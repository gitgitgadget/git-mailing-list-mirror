Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A3184F
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720406639; cv=none; b=lJe1NPf/oh7K2l78tDLER0B6A8YqCPBkwQ/riUxa40FTv+NdtJEujuHqoMxRbVx3FnMXHt8Uh3oA5/KlyKeNtB4EO/CXYb2qZKoHwKIq1KU4xcRz5QEHY11ATSiqS7vcZIb452HeFfL1PzbTPQTGxsShDrVV8VRIQWE/6NgyZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720406639; c=relaxed/simple;
	bh=+w+3dfcmWjVANvS55TgpFIMw/PWFIpIElAcWweRT0K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1UNco6N+S1nK38hTlgkmTNEVpKd0CRZBD2oJfJhQD54gcS6nk/aQDUUAhziYaHh0cfHMaKLv+mXuZNOvXQdUf3iXYvt9GCiTMaQk5D5DsN1A4c75nHlrMgIziaHrz/N3eirLaUMvzxL/xD66pblDVKfyT020rwxJioG7x7cwto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79eff64a06aso66614985a.3
        for <git@vger.kernel.org>; Sun, 07 Jul 2024 19:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720406636; x=1721011436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZsJ4yy3nponVcXQHr9Y+d1yzTsTm98uX/CEdUa/t9o=;
        b=j1FG12Ib+X/n28h7gtx9V75MJV5mMY+oyywEiwZmi04HxWG3gz36gas5CeYWni6H5m
         IJ5/4RnpnL5Ru/P7k/TAY+pPDmc+ci2IUse0p9a954dnaEes9vP3yLSILMIm/LjbkQxm
         vTCBDupWNVUFfhuaCbcpORgkV5IZcOy6BvgdTW/rtmKAj4vPVJ/Yvy+o3w44ke/IfIlW
         Zesw5dy3kZ9N5rCFtn4JLqvBsuAQs2D4/dmUJb4UNSQmM5OhDYvBnni7NibvTEwpxtBH
         fLUEVhtIvAzYSwu7uBNgUKThId9rNzwgdSgwM6dO7AhOsSufqkdssymYQ41dz9U1z1rX
         lzKg==
X-Forwarded-Encrypted: i=1; AJvYcCV6tIokXXVjH1RBC3FgSOapQcVNAzbJcmxWbfO0xtVGM6s35a8bWuM3oroTpTqW5srHf+OaeRpfjL8p2c0JldS8sVkH
X-Gm-Message-State: AOJu0YwtlMBua5Es73FSYWJagpWYcJdevpL5/ZBXdp35WINFHYTfcKlW
	py1Kk15YkW+q35iQgzu1mJuie8LKRcGZ+fIO2u//SUcCvo14mOTpZl14BkFYhwYqG3cX/aCqgP2
	OBo82frjSP5QMAtUfu1N3D8hBe68=
X-Google-Smtp-Source: AGHT+IFpE6vOXonAX/h2T2TYGwPe2ocQ/EpsQsWQmPAf7AgOZA9yRFHszHnj3w6NxBWuDg4hbsQytRpePjEE8esOEk4=
X-Received: by 2002:a05:6214:1bc7:b0:6b2:d007:886e with SMTP id
 6a1803df08f44-6b5ed262269mr118143556d6.54.1720406636042; Sun, 07 Jul 2024
 19:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706060143.GD698153@coredump.intra.peff.net> <20240706060754.GC700151@coredump.intra.peff.net>
In-Reply-To: <20240706060754.GC700151@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 7 Jul 2024 22:43:45 -0400
Message-ID: <CAPig+cRzoyxQpNf15nGeHDdDQK64KRJXLdgKN2rkXaN+2SjTZQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] t/chainlint: add tests for test body in heredoc
To: Jeff King <peff@peff.net>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 2:07=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> The chainlint.pl script recently learned about our new:
>
>   test_expect_success 'some test' - <<\EOT
>         TEST_BODY
>   EOT
>
> syntax, where TEST_BODY should be checked in the usual way. Let's make
> sure this works by adding a few tests. [...]
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> These could also be squashed into Eric's patch which introduces the new
> functionality.

As the author of these tests, you should get credit, so I'd proposed
not squashing this into my patch.

> diff --git a/t/chainlint/here-doc-body.test b/t/chainlint/here-doc-body.t=
est
> @@ -0,0 +1,9 @@
> +test_expect_success 'here-doc-body' - <<\EOT
> +       echo "missing chain before"
> +       cat >file <<-\EOF &&
> +       inside inner here-doc
> +       these are not shell commands
> +       EOF
> +       echo "missing chain after"
> +       echo "but this line is OK because it's the end"
> +EOT

This one made me think of an additional pathological case, though I'm
not sure it's worth having a test:

    test_expect_success 'pathological-here-doc-body' - <<\EOF
        echo "missing chain before"
        cat >file <<-\EOF &&
        inside inner here-doc
        these are not shell commands
        EOF
        echo "missing chain after"
        echo "but this line is OK because it's the end"
   EOF

It's exactly the same as your test except that the same tag ("EOF") is
used for both outer and inner heredocs. It works because the outer
heredoc is introduced with `<<` whereas the inner with `<<-`. The
opposite case, in which outer is introduced with `<<-` and inner with
`<<`, obviously would be bogus.
