Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632073093C1
	for <git@vger.kernel.org>; Sun, 16 Nov 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763299987; cv=none; b=DlKmt6MGo+WpDPnvhzjqJaclFOuTIksEIrsJU1bCPIDyEqruy5R1wEpuvhlBX/zfpbh9V/LgdnIzJyRz5dITJMqRCAomcHBKGHPGZC+mrmPx0uqVxHWbuP0tWRfgO68cbadPDt0pR+vugVxlzBl5wGDg7Dk66AQQu8wro9SjTDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763299987; c=relaxed/simple;
	bh=yRr/mhhln2cVQnZ2W/EWbEJ/9xLxtAEhARdpEqB6acU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVtL+wdsiKluTTtXaR5t7lp9I+pdEiBhG1t3kQz1eMf6CD8VnpiStiDA/tjI92LYaZmQGmcWCj02uITH0AE17/giFwKrjTiZ1l35GERZvtd2p0j16x/6f946VR52vYX1ag3n20BU8+fFgQtjx3kZ6uz5cjNpCUZLs0T9qAmM0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw6KAqvz; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw6KAqvz"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-640f88b8613so2935909d50.2
        for <git@vger.kernel.org>; Sun, 16 Nov 2025 05:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763299983; x=1763904783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWcOS+h9WWJqZlmxhDIDLeHF0fcxPji6LkXJ9QM8BWE=;
        b=Bw6KAqvzDAvZUvXt5qOR6ui5ddG8wk0KbokvSffHq0cgTvlxOE1j5XYA1uvCmLJxxd
         3q2P0cp89j39hNlNtFBijDum+qjNQTblDu8xY4ivcrx0ifx2M9zinpSPJnat7j5+zp4b
         qWOToRw5tBcjqcgPdOhG99oMDvTmtH0nkYa2Wrw0hm/OLggvestpTLxaNgYfH1YVf+0J
         jvJG8jKP/obEn2gZGM0K91+kralzjaDYYfyYUkTQBn99c6Uwuw0j1x2BEAhUV5FJKgWa
         q8Pqv+m9NTigNH5mxrNJvDG13Rkwp87KO3Vgu2daEJsbvoaNyBNN/NNA6T//2v9twT6G
         w2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763299983; x=1763904783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pWcOS+h9WWJqZlmxhDIDLeHF0fcxPji6LkXJ9QM8BWE=;
        b=Uya/asSLrEGioncGvBPh1JWsaLggR6Z0IHTAPs6aBs3zO3RWxesU/o2cV5mvYkPBqE
         dfEYu9fP5drSa/Ki2nOFpOVOXfcvWZCbv6q1YMReGp5e8VDCMHdZMETB0KwdWxJUYhn/
         tr5UXc70COlz8crxSH3z95VgxltK1cCYNHytRzrGRLW83y18dn7CgBGTjXMuFn+PSMK+
         yYxwkV2kV0aDL7lSzg3Kzf4I2R+AfYjhfUWUAU67bLZHBCia71Hih3WOV7gmW2v1K6/b
         dgPMzyVMHeYd9W8q07VlaYCP+umEyvO/dzf95OYF4oqh0WNW5lm4EHsJyrI7S5t/sDaW
         9YkA==
X-Gm-Message-State: AOJu0YywNv7DHIEgmF3O8lfcyFJ7kbOT86dkd/ckLObgmVyfuEdn7i0j
	Wpa9OMMW/l5wi2Cauy52mJk7BMNb8LlciWjDFpDtf30bv4+4f7M6ybotZmZH8X6U+X9r0ki7cPp
	OZA0o+WWFjbHVHGz8euxE7w9oUfWdPVY=
X-Gm-Gg: ASbGncsCnnmb0MAQYlsq/gULXERb+klAnGU0qQuzQzkW+TZfNHgeQBsPdibVmyzxqVm
	SZppFAxN4Av850ZQjHAEhQuQJgYeHAb7N6I77OkffEw1sS2HEqODmmFE9/LurmwNWTuo3oAsj1V
	h1heyF840pkllZ96FvPhBOR7Z4IDLjhBFyf6jZ9Bsc/bJvoK8mSZFxfbl4Av3Jr6N3HTs0qqVuT
	HP8urfB6C5w5qBhSMRPyotkowkruY9F/vP5Zho7gIfuFKuWsM5h2JN9RPlsxTAuv+3s5N4Y
X-Google-Smtp-Source: AGHT+IHiVED/QcLqjxAUrOUcVPZ3fbGkMw1ajwP05KJVDOszs0QD65AmoP8akle3EdpbiGhimuybo1gKkoJN0UH1iKY=
X-Received: by 2002:a05:690e:1516:b0:63f:a2ff:b1d2 with SMTP id
 956f58d0204a3-641e769d11amr7442691d50.42.1763299983306; Sun, 16 Nov 2025
 05:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763098804.git.worldhello.net@gmail.com>
 <a50bcde6446fbd87b4fb04b28c579a915457813a.1763098804.git.worldhello.net@gmail.com>
 <xmqqa50oiduy.fsf@gitster.g> <CANYiYbEFN9BHtNh1PQ9C3gDJasq1PaKnkcH-Nq=FddUCAcMGqg@mail.gmail.com>
 <xmqqtsyvfe2f.fsf@gitster.g>
In-Reply-To: <xmqqtsyvfe2f.fsf@gitster.g>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Sun, 16 Nov 2025 21:32:52 +0800
X-Gm-Features: AWmQ_blbUHDCxxuJKMbY1AYqFZb4g8msP0tTh0KsnvoHrEi_joUnEGew0Tr8HfY
Message-ID: <CANYiYbFcap=c8xDy-=ZyaY3U4-jU9OEe18LPgTEAHi2wx2M0VQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/repo: fix table alignment for UTF-8 characters
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 12:36=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> >> >  builtin/repo.c | 22 ++++++++++++++++++----
> >> >  1 file changed, 18 insertions(+), 4 deletions(-)
> >>
> >> ... it is a good idea to protect the change with a new test or two
> >> to make sure the expected alignment in the output.
> >
> > Will add test cases for strbuf_utf8_align(), a function newly
> > introduced in builtin/repo.c.
>
> Unit tests are nice to make sure that building blocks like this
> helper function works as expected.  To ensure that the application
> uses the building blocks correctly, you'd also need end-to-end test,
> getting output out of the tool ("repo struct"?) and checking it.

t1901 already includes test cases to safeguard the output of the
"git repo structure" command.  I could add a new test case to
validate the output when localized in Chinese (as shown below),
but such a test would be inherently unstable, because it risks
breaking at the end of every release cycle whenever translations
change.
Therefore, I feel it's better to fix the issue by using strbuf_utf8_align()
and adding dedicated unit tests for it, rather than relying on
fragile end-to-end localization tests.

-------- 8< --------

diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 36a71a144e..fdab0a3d29 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -34,6 +34,37 @@ test_expect_success 'empty repository' '
        )
 '

+test_expect_success 'output repo structure in non-ASCII glyphs' '
+       test_when_finished "rm -rf repo" &&
+       git init repo &&
+       (
+               cd repo &&
+               cat >expect <<-\EOF &&
+               | =E4=BB=93=E5=BA=93=E7=BB=93=E6=9E=84       | =E5=80=BC |
+               | -------------- | -- |
+               | * =E5=BC=95=E7=94=A8         |    |
+               |   * =E8=AE=A1=E6=95=B0       |  0 |
+               |     * =E5=88=86=E6=94=AF     |  0 |
+               |     * =E6=A0=87=E7=AD=BE     |  0 |
+               |     * =E8=BF=9C=E7=A8=8B     |  0 |
+               |     * =E5=85=B6=E5=AE=83     |  0 |
+               |                |    |
+               | * =E5=8F=AF=E8=BE=BE=E7=9A=84=E5=AF=B9=E8=B1=A1   |    |
+               |   * =E8=AE=A1=E6=95=B0       |  0 |
+               |     * =E6=8F=90=E4=BA=A4     |  0 |
+               |     * =E6=A0=91       |  0 |
+               |     * =E6=95=B0=E6=8D=AE=E5=AF=B9=E8=B1=A1 |  0 |
+               |     * =E6=A0=87=E7=AD=BE     |  0 |
+               EOF
+
+               env LC_ALL=3Dzh_CN.utf-8 \
+                       git repo structure >out 2>err &&
+
+               test_cmp expect out &&
+               test_line_count =3D 0 err
+       )
+'
+
 test_expect_success 'repository with references and objects' '
        test_when_finished "rm -rf repo" &&
        git init repo &&
