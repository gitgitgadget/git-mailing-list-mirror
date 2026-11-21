Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795243357;
	b=KtfGOvN4TZ3VVZhIBP0TRVJcXV5G8hfb26KEps/waA49u+OB3HhmAqcqKIL5kjc2lS4y
	 y31B6L1j14AfIzOBntGvfxLPhosdqHFsFL8NtBkL4zPOclp7ORcQwpuVBEIqIilEOJDJ9
	 aK+E8QEZEn8eW4ouavlHIW3DxSkq8IVq2hhN8vdxX7VXUpJqmnR2y8Y9DkGyQxnf2Y66e
	 K8ows+t8uB8pqxQvB0+zmQHf3ZGgE6BHWT7hTqY8vEHm2iZjSo4iVWJn8E1wy8HWVWwEi
	 s3AaPE2W4XNKCaKRiHIhI3p8DvghjZwtXIh6EwOoZrxbAMnuW+aLU7rMx6TO1hHGeJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795243357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=62q4QrPixlzE9TUY64BuW0J1EmgeOr6+dZnyPNNsqE8=;
	b=EKdGj6/1SboANSpMLW53rT7EfgmDncKDN1zrBwd5RHPHSt+XkvCCqn4yu2+o1skNROkJ
	 tXenBsi2hXrAsUJFXIj4Ni0SFBQlxbe4E8U2PpynUC5cd7+hTByH74oDHWQN0vNGLPM9M
	 cODD16fVr9q+QfX8ER/3U6IwZt0pwaWQoxWu3HYonxofxAR9T+n/dDHWmjHVmO5zrRibi
	 jG9jfsty0hNT9H3Ink5YNkEQrYlxFIrWAmZfKe0W4Hppo3/iw0V5jJUrD7gTCg1fZbDzk
	 J8rA0MY52RzrUZoXYdUJ3owqxqzImHtj4F0fcAEw8SMhW+0ZEEn/FRS7dpxZcjjysOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sYeNFlhF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E5606A339
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 06:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B59E5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sYeNFlhF
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6d290b10a35so676836eaf.2
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 22:42:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795243355; cv=none;
        d=google.com; s=arc-20260327;
        b=LoomkaWFZoN2yBRyHLPpcvOtuIJaUCUj6Dog3JLixSYAZdB+X6is419yb3L17tOY+4
         3v68IrzAGBrA8unUlTZj0l2XN8Y9x5e0AgPvEydsH76+YyqOklej2Raw92H1isIYEdUM
         8GKW2YI0/OrlaMwkUY315NAm/mA1uyp99/gcYMDf/nnUXUJIUTLvZGLp/JgPSkrixPnU
         Gf8m2msYMN8WkYekhkDy2aFLGOcy8LXfP3khhFhPTcl5v+NimkXXOl41hW7YyFrhqgYw
         Uk/kSOHBvkCAu5/G4M0uGznFGpyyz2cTV7LoFIzoSiKIOySXddF7XDopLu6d2uBXm3GG
         7ZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=62q4QrPixlzE9TUY64BuW0J1EmgeOr6+dZnyPNNsqE8=;
        fh=azt8TgWTl01NptQZMw9NPhZWceF2SXJbJqFTBR6uZLs=;
        b=Ppkj307wuUyQjbp+q+5DwCqSajfaUlP5q96oFJe6psTzG/naNvuR/tyILQK5dpPml1
         VGSP163EYYg419o41E6S7s4cEekO/Y8s+cZC4K5OnmhmTCmwLba/U4wwDsLWxvEkL+Al
         ZbiLO7GjeJjOJEp52QE4skFuAH86b2M0zQJ0D7qnsOIqv6ON45ZaU8dOiOrKYVJHFiDa
         gAzAfe4OI/ZwzlFCt000+rka0NjD/UgyxmRLZFzrurz8mxeeRK5/YV4UhxMv2+4iidU2
         VkPZKdOsTKfPyxM0uO1Mil4nxH+HMw1qk5QVVSBp29IlSVyiiThuEiSvFuXG1Lww/NNf
         FaVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795243355; x=1795848155; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=62q4QrPixlzE9TUY64BuW0J1EmgeOr6+dZnyPNNsqE8=;
        b=sYeNFlhFWs8JhoR7+K+2BLC41khsT6tKYRHrneiipEpC9CShsdvHkNYGt/FuQZ0Mjv
         UGY7ZIzsyle7noLTSzP1OiGKOkRXIGhC2l+xM/VsF1fywzK1Qmme1YQMZlH+7kcQ9Len
         KK/4NWsFj+UxGvrPUNzW6LjfWtHK2Sqtc2qTHm4e8hzvNla51IIJ2AsRWEnqPNl0NhJx
         ub8kAq4b3aB24tRZw4xvoOgwefw30fQ640N5kG23ZLtXna5iireMzIQJjb5TVA4Ex5EY
         rnbpxwOgPIEHoP6jsVaS1RHi48uXaao6IgUX7gRvjdZAdRqpk54mACEktxGORxui12Bd
         Rp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795243355; x=1795848155;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=62q4QrPixlzE9TUY64BuW0J1EmgeOr6+dZnyPNNsqE8=;
        b=aN6tIWmYF2dYXMoDnNNam+0kfO4ZQp+4DBXnDvFUMmXxlKSafq90krn8eh0Gu5vB87
         ormjEAZaYVzRVWtwPKsODSGnLOfmcCHFHdqkBapCGXfrPJFeiJGUoJLP1YY53XejVQ8d
         XZ8wqLEUP3rMtn7X4pi2xYvPMB/ed9rpnh25muz2T8fvI2ErdG8+cSjEgmvHl8qxURGp
         KdCTqkR/CoDVaRwbPL/M28NeXMFDyL0AwezWjRrZGziU5h71hJbXY5h64dChfBGa8lvU
         O3jnDXQH4GEk73wzamL4bPGrJEglrkcskR3E0jK9G3Se9y8j7WMTjjq2IMb91kQGG67S
         xOHg==
X-Gm-Message-State: APuU4Z/0rTOiU+qsjk/JbsHUCtnGxQFtGJa8mUFBPlg4EWmD/Ky0R+rw
	6W+ifdpjYvjppZjT9YnTOffEfkexjQSVwpV6lyt4KVKnXVwMtg5a2/Gz6mc8myNtajUX5DXCgrc
	2Exs22BDYqYO9oNG+PZdKOw19fwS75cP8jaL1
X-Gm-Gg: AZFdTZeSz+GbIAm5YvDyICwkMfvFlK1vvzR+dMGjVra90wpkqZeygN/p7cosvGE2tfR
	Xxl6+0Pdd+HG3KYSmkK9uU0NyMXHo2IuGne2BpVZDKAYhVA6Plw7HsUAoamX0KNgJsvahk6Kxk3
	wtnFTJUh/7cwD7YFPrwhRMYoxP0KdrZlsWcQrRDm3vSg9Y5FDJWpQEORLBswSshuj6GH1BAO4ED
	CZ7o/8JmI2YX7HErkshP7kDEZLaYPSzU1fUq4mlvz1oGa8p5vzBD5uGv+9Ii5s3am6dBzGIZPoK
	JB9Q5BdfmvjKg0InAr34WKICv1V0+eH5Jaq6cSZnWzEvvDVR5y/OCoVcEAB+eI8FYoo2BLpI89I
	uMQsf6I2RQyxedny/uaNEpPly1kCE18jg8dE=
X-Received: by 2002:a05:6820:8599:20b0:71a:d6ae:500a with SMTP id
 006d021491bc7-71b394b822amr3243850eaf.46.1795243355591; Fri, 20 Nov 2026
 22:42:35 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114201632.103400-1-dirk@gouders.net> <20261115070357.113875-1-dirk@gouders.net>
In-Reply-To: <20261115070357.113875-1-dirk@gouders.net>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Sat, 21 Nov 2026 06:42:21 +0000
X-Gm-Features: Aa3M54ry7eQjYFsLEIblGhpDBP_mbSkDQmEmbGRZvZyldN-hKjE7pIIutqK6KTc
Message-ID: <CAHWeT-ZvrBXJTJWuLNsw3S_Do-NCF_MxVf80mWbbuoKtxdF_7Q@mail.gmail.com>
Subject: Re: [PATCH v3] doc/gitcli: minor fixes
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

On 15 Nov 2026, Dirk Gouders wrote:
> Fix three details in the gitcli documentation:
>
> Use plural/singular where appropriate and imperative form when rules
> are listed.

The introduction promises a list of three, but only as single point
follows. The message should mention the change to the '--' rule.

> - * Splitting short options to separate words (prefer `git foo -a -b`
> -   to `git foo -ab`, the latter may not even work).
> + * Split short options to separate words: prefer `git foo -a -b`
> +   to `git foo -ab` (the latter may not even work).

Nit: "into separate words" reads more naturally, although "to" was
already there before.
