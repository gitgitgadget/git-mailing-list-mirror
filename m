Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3314F125
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 05:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754889728; cv=none; b=cW10d3w8uKr/nrFMQuNWIePwPhwz9VVDbtiXRxTct3ngxR67QisY8DZWGbgK2rhk94aTfY5sawMrqQNXrjwomVVlASwZBhBrTaGwkt6+uYQjUEmhV/nkvnYTGE5xZ1VapXNw5Qi+PRLGnyIxLk2SrSCTFaMRyU+h6XzDdr0Sd0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754889728; c=relaxed/simple;
	bh=UgkC1tMnIrv6jDPhYXJxPUuKaiwHfeXfYRRqzLUIG6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsMDnADCxMBXnO993rJUIikKYzYIBx/HpVjiAfvsjvNpEry3/0J9NGO7yqZJvVcKYf1hlESw7kEH60Oqqyb+A2Rq8xCAnttwqJzWDnqdf9WBdg+iABTUcy3wUbg/Er0FWywSyhn0HQzO0SdJ8Ar7IYSV3cJl3DoAo5DYAeWj94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b0632ae199so9492491cf.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 22:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754889726; x=1755494526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75h36plVeQjFquaHGBQRoQws0aMazTscToQJn1zX1w0=;
        b=vQuds4H4UxeW9i83FjY67BMwjsF6BM68h6a14WTYNE9/tuyumQqwzhBa17n10aUuIt
         9ng81OBZPKmzWKz58HZyl5guBdf6l+XZA4+HOgZVKyewU/NzDAzKxf+Gua/6z0KaT826
         sD5S5y75h3KmjC8qn/5mq9vqrp0jn6sqbGqlhGUFGD2jiRqn15iVSRuPNTD2RyS8C1do
         XA0cKErPK2XoOQtF73hjrmu3gRLEtz0di12t9IeGvcX9vL2Q9PMtmQVHpcLMHmammYi9
         yBIFFI9ZCakqdzo3ujyhFz1bF0f+os2Gs630wbLAJsRNaoA6q3/v0o7oKoUj+GA24Ea1
         00Fg==
X-Gm-Message-State: AOJu0YzAPYCEdUe8j/CbDNcGOzqt4EXoKbbUES1juUvxXwDX7Gxl2DCk
	pD3HKI0Scx2CuKtpGPoxdKnw++PiqbV1zZstZsF60//7KgYKVqz7+5EnuvsgEZ9QuCnU+ljE3Da
	769SCYhA6ezm5SIamZWhO2mUglyvickPAyA==
X-Gm-Gg: ASbGncuGIuwkWlxerpDuLLlqYBkOcKCt8pG6S8Xba0BvI1IjmFc1EaQf+yjuJTXZog3
	yFVUR5FBO4YcGYnsBNVDetg8X01/6W1NOh2u5XjPxViIdkNEY9whvBKBuaVC3V+N9d68N01TCq1
	mqw0mXZAFNViCFrBDktQP2i+ImW7GvavYwQT+36+dKJidEFaG3MP72vYveqVcDgQp1c3sf1F2qS
	Bl69om+a+mhaDhnV19A9kiZyrRkE3zpPwQNdKMd
X-Google-Smtp-Source: AGHT+IF7/a4A6wbH89+dQk78DHGGigq26xkN9f4YDRsaiyysH0lubR+nKUKktdqFydYZVmoRdYPaMrF6ChO0haWoiME=
X-Received: by 2002:a05:6214:2264:b0:707:1654:ced4 with SMTP id
 6a1803df08f44-709aba8b60fmr54668976d6.0.1754889725563; Sun, 10 Aug 2025
 22:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com> <20250807150239.6987-4-lucasseikioshiro@gmail.com>
In-Reply-To: <20250807150239.6987-4-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 11 Aug 2025 01:21:54 -0400
X-Gm-Features: Ac12FXw0xdoOIXz2gGJu2idG-i-9bhUQmN3lqaUEm-fLGctso6L0UgDimoZtoCw
Message-ID: <CAPig+cSBg6oQC4Y81ieH25-A9cHRTfbqC5i+22RSBcbyVo_qtA@mail.gmail.com>
Subject: Re: [GSoC PATCH v9 3/5] repo: add the field layout.bare
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, ps@pks.im, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 11:04=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> This commit is part of the series that introduces the new subcommand
> git-repo-info.
>
> The flag --is-bare-repository from git-rev-parse is used for retrieving
> whether the current repository is bare. This way, it is used for
> querying repository metadata, fitting in the purpose of git-repo-info.
>
> Then, add a new field layout.bare to the git-repo-info subcommand
> containing that information.
>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> @@ -54,4 +60,14 @@ test_expect_success 'only one value is returned if the=
 same key is requested twi
> +test_expect_success 'output is returned correctly when two keys are requ=
ested' '
> +       cat >expected <<-\EOF &&
> +       layout.bare=3Dfalse
> +       references.format=3Dfiles
> +       EOF
> +       git init --ref-format=3Dfiles two-keys &&
> +       git -C two-keys repo info layout.bare references.format >actual &=
&
> +       test_cmp expected actual
> +'

Since the documentation asserts that the emitted key/value lines will
be sorted lexicographically, can we also have a test that verifies
that behavior? There are a couple ways you could do that: (1) either
add another test just like this one but reverse the order of the
arguments to the `git repo info` invocation, or (2) modify this test
by reversing the arguments and (*importantly*) add a comment to the
test body explaining that the order of the arguments to the command
invocation are intentionally different from the output to prove that
the output order is unrelated to the argument order.
