Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B0211291
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077101; cv=none; b=oaMFlhR3y1hPSt9XCMSBxM9229lltDvOMhJpWW+P70+Xq2gZZHxgteCHBS7GOFhkZ5mQCGh1xfpCaErXro+VNarlqub9n7jp4EGQ1w6j5RXqxqmczzM7iKYn2cJ+7OI4Gc3YA7Jgit837zzcGnw+NqkBPgvpFnKRjOW5qhmJmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077101; c=relaxed/simple;
	bh=nE2HWl2ErMiWjvVAU743BbKSuZY3HWN3zYadljVjzz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRzmoS8fDfNrTj37/9Icaak722GdHg5DMKT8oPSGSIdp9vXzBkV0AxCQM7ab3Cy7WxSqDuXtIkc9WaiU5MSlKB0L8wyouSlkrjmMRQ4uJkopX1chKlM4MxPcm0eB7bn0QkIV3DTvOkTZkrecD9Y93E222ut46z1n2rVJDJS6HBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0D/ioeE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0D/ioeE"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abbdc4a0b5aso253122666b.0
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 10:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740077098; x=1740681898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/i4LhNM4Uy/CgGzEi3rL/dK7BqNjuHn2NT11gBwmtXM=;
        b=B0D/ioeEXzIR8JNx4lxOADhjix3peGtAnIEUmVbLnUs4CHtcstcudLp09DmqbzIjHk
         0IdWD3Gs2a8LELXcWy9Cw3Cro0jTP3xSOYNxj3QUe3p+oS3lmZz29oq0W7Pzve3Y6f3T
         1lOf8sivoXNMMRoFCjfRokFGovc1RSMirihV+wWQBrlaBn9/nuvyj+JKhrY7ByPetj93
         OZ4tkW/7GoTSuvgofDVdpS8ABXhxDpLMxBWiGOmXmBl6Os2Ggspk4/kcO1/3GlV3XuAV
         qwE1HztasrS+OXXXNYZ6awHGmdYFH2Xx+K3Afkvzl9PEPiJjlcgAec2feVM9yV3ChGVO
         SLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077098; x=1740681898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/i4LhNM4Uy/CgGzEi3rL/dK7BqNjuHn2NT11gBwmtXM=;
        b=XiQ+LbQ6MduT2pwnZ6GElnAmXuA7eFaHEC+puMGiH9z7RPYDrrOCWtjlgtcQxB2oGi
         Gt5P5NNyH4AN1sqMbV8H3PD867VhBNOD3Rm0EqcZ2FdmArugPIHtbVkR1TcU554RbfQO
         jtd9okYoXteh0U/6YdIzOQufvwHHFMDdlEhBPKr/12pQaYDzdC71mwtBwXErNFO8gZ8w
         1cyWgA1yC3O+ofT8mkp3Y+R8+c7zuUzGJA1zodoVc3aAxWMKK3fuZ6ZugA+RU7habhno
         LTVPkOmKKrHYy51fmc7tHlvIHIzDR/Bab7ec1n+WPcU10KJrQSWxcKCkpmX/zh5TVfh0
         I3BQ==
X-Gm-Message-State: AOJu0Yw45NqrjB3zoX3bJbJ2M3Qsqxif9p1X1/dCyYgpN7S0pkjzL6z3
	NYDkBVF6zbj0m4/XBsMyMlS6HsURwxOqUQRFL+tuEst5tRsjjBuqNCgqMktz3sXv1yGJ3SihqYt
	kvy15S7RmyQSUnBlwN+aGtnaoLl4=
X-Gm-Gg: ASbGncvGwCh/4g5XyFsh/RqY89mVInXVMm6KxX/pmFTpLENC6I4A4mjAlW4PbIDgT9L
	tUL08FV0QcJZDhIER1t6jMioNIPBuhpdZLrw6Wma1/0PLtHqaUsUyOl1lJcz/ehj3eXfidWkhoQ
	lh8lGbTLG4zFcYxWPIgaL/ChbJvWVG
X-Google-Smtp-Source: AGHT+IFe5rs7nE+z6Z1M4tHX9fCwGg7jeiPKKP4pFvIYaIs8pecoH4qeQEDhE7pEI+oTOq7bNuBojItCx/udH7M7PuA=
X-Received: by 2002:a17:907:6c13:b0:ab9:d282:d42e with SMTP id
 a640c23a62f3a-abbedeea657mr421381566b.21.1740077097990; Thu, 20 Feb 2025
 10:44:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <arrp2ye3kid76pwghguu5z4jkpv7xsskzdsjunbfkgmwejgby5@qh4phxwzenyp>
In-Reply-To: <arrp2ye3kid76pwghguu5z4jkpv7xsskzdsjunbfkgmwejgby5@qh4phxwzenyp>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 20 Feb 2025 13:44:47 -0500
X-Gm-Features: AWEUYZkBrymd1qnR1v6zfY6Hevf5s5UQKJcoW8UyYDhSWxxoSAgLAIqUaRLBybs
Message-ID: <CALnO6CACJTKasKT9rX9w4_r9q0DPOPZhGnHt8f65oo6Q=8NxEg@mail.gmail.com>
Subject: Re: first bisection step takes quite a while
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 9:38=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> today I did a bisection in the kernel repository:
>
>         linux$ git version
>         git version 2.47.1
>
>         linux$ time git bisect start 09fbf3d502050282bf47ab3babe1d4ed54dd=
1fd8 96d8eab5d0a1a9741a4cae1b3c125d75d1aabedf
>         Bisecting: 572238 revisions left to test after this (roughly 19 s=
teps)
>         [eafdca4d7010a0e019aaaace3dd71b432a69b54c] Merge tag 'staging-4.1=
8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
>
>         real    18m41.374s
>         user    27m18.306s
>         sys     1m0.565s
>
> I was surprised that it took that long to find and checkout the first
> revision to check. (That is on a 4 x Intel(R) Core(TM) i5-6440HQ CPU @
> 2.60GHz, 16 GiB RAM with a Samsung SSD. On a different machine (56 x
> Intel(R) Xeon(R) CPU E5-2660 v4 @ 2.00GHz, 256 GiB RAM and (I think a
> spinning hard disk)) it took nearly an hour.

Related thread:
https://lore.kernel.org/git/19461b87a5c.5a2ea74016716.8214238482389812984@z=
ohomail.com/



--=20
D. Ben Knoble
