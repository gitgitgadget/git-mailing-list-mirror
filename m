Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793891253;
	b=uLRekUNlP/x7h8AUJ3lPc5ClaAzXlFvvTPO64TSCoz4xTsq34ALKoe4LPjVusvP9gEmM
	 d2KsJwKHQPTt2g/LxyLijpZjN/y87k+s8dw4Nv0nMjFFRRK/KCTnvGHlX86e8ZWWbNjXm
	 VPerr+iwexYQYkprm0onJ9ZH6QGDaxNSUczYDJqPEfrJvqVs+lL4iTM1FwFt3gArGezI9
	 lGSyDxJJhv0muhrvgeTTnQ5H5Fw1eAW57onyX2fioexLtKt3Ub7jtEt1zEabp9xJvC3GJ
	 wlcWOMdIKVfEC+x+Oii0G5LvgnJNG+8/BCV07S1YL0HGFe4SbsQmSPJx2vQRFiNDBag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=MfEilovptnYwF1sqKFQtI7i1mMVWGm/FZ+K3LZHiAsk=;
	b=rA67fEj5xeo+MVqeALdpk6zJPjeO3qKwRHLeI6bF8p5/dvPVyHSHsfst4dhYYkTyV2j/
	 qeYzd0MLnVPFmJhpKdyJiMWXQLgtO58W31kmy2NaUa6En0l1uO3HLVz+Mq4/NUxc6DtvY
	 VGGxsum2MgtH+F//15LxoJEemVvVim9BvmmOreXkrJ+MMRunweR3mpK9qHLnYWujKJUDj
	 sKd10x/vg2SNmzfgdk0cglzHiMigpogrXf60TdzEy5Iaf98zKytMOlqWjRoKTpBO+oyc1
	 LWU6yTv/tL5BwpJgKi0kAkta/L1bAXcHb8Hcx7luUaBM2tVaq1NucGQIqSTFBuEvRMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=Qjw5DywK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08309606A333
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08309606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=Qjw5DywK
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67be1e468a8so1122708d50.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 07:07:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793891251; cv=none;
        d=google.com; s=arc-20260327;
        b=FlyatOZGYnC0r5YH09rwZcSwHkvvqJAZdPaHzC4CgpoqUgUqdwIrgvbdDgayuOF7go
         DK9QtQQY2LEfoZC0gnEqZvuFkRZ0yTjrc4WZVA80TTWpUzPK08Q3C76fQz0s5o/MCqDz
         oEeGBYhHJLeJyCslajwkJ9sXTFxy4rzGrc78x/lcIGYsLuqjW65BoT3QkInre9UmKPpE
         T6USJJgdq2/6xfXCuLdfAf9h+OrmP9jgjGYAJ+MDfvLQwdpqSaRGaM8zRRMfwWlWRucV
         4VtMaU+7W8WXBqWzTR6TyfbCyg9Mv8ginuoBDKpww6RmCnyBADb13icAU2xJX1m9N5OM
         r5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MfEilovptnYwF1sqKFQtI7i1mMVWGm/FZ+K3LZHiAsk=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=pZyEKCqWuFRtg80ViP822C+m+Ex0v0Z6rr+C38HJLZ1PXD0wvLmk8/eyy5O7oeDMTo
         FB469bnH/Gb3jJdghnZh57RbpnJsu1zPpzH7sCI6H7bhisjegiGTeX7izXPwh8hBsThs
         1TAbruPsua4MW2WJvKqfQtP8IA5qPlzF0FRFy1JuotTrIXqedwRVnL6ijSji9urSECX5
         FnNMCpa7RGO3Ssqqwf5WBSkGLFcDcGOlMt3V2ZKhdYAU3oFx/rYGkTJJCzfwd/vT4CvG
         8HDPXSL+MyTeZAepFPY6XlCmEM/jKqsxg3rorI/J0Hj/hZPKmZ4ApqhJIlmAdUMXXv3s
         gR0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793891251; x=1794496051; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MfEilovptnYwF1sqKFQtI7i1mMVWGm/FZ+K3LZHiAsk=;
        b=Qjw5DywK7x9Rj/NE94AwiEfpKsPTdm7n/Rf6ye/vT7TdVxq3/qf27gngaK7oYkxF/P
         Gs7oBRWt+sz5DIKo/gL/kMdMJ0UkOv7EoN2ZR2ohO17N9LyXuu+h75imjmzoLyn4nr4k
         fvs5UNkUMFGMYmDf3KNB2PKl3jVUQjiAbkt0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891251; x=1794496051;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MfEilovptnYwF1sqKFQtI7i1mMVWGm/FZ+K3LZHiAsk=;
        b=oREkRUJwliV624RGOZc1twYqUUi+oWDLipOr1Wyn5uS4bg/EUIpnp1BKTMLa69uajb
         dVztMqnMK1IgLsuLohfEYOwJzZ0gM2ZNeYAqKFUhhAo2kctgT092e/23AQ9GFSI8ofnJ
         t7E8PlH/lRCebTREsVsP+jhFDgq+ve3Eh5WavMPB5ENpJC0VukMI6zkVqJcpbNGW7HsO
         oTqR33vedFf6e5QZAJgZEZr3uYMsFG038672FyrRhMiFcPv8m8cGdpA0iv4XfMi/Iuda
         GIhkTrKJtSKzriooRwGVv0kqF+xDk93PbRN5IZdM8rHOUE2GAOzy6vXvtw5gPZt4P0FG
         YBUw==
X-Gm-Message-State: APuU4Z/irtdj1hwYqb0vLlg5/KJkCMmJX71Q1+mVGPLn0hqLcxE4wTfA
	6XyIflPQ/g7GY1S6jy062eaPgyiy+HOl+ViY5vC0XRBdqEIT3vYBJQynGwK8X4ZA4WaPaaKYqEF
	nItGFCkLmEAxS1uubfFS1A+G/dwRRebdwvavPcZjSyeZrsE8cvzkrnD81uQ==
X-Gm-Gg: AYBFou2evq/z/JUQmpNPszI8zpNH6a7DhMid0B9PkJ1KA3URRZddA6IGW90ijC2mqrE
	LQbXraW7J8zGvxGOEYp4217jUHncoTfgD6acqCZMGhgq+9HX/+5v1FZ/Q6aCJAD+QeuzE1ZYJ9x
	HoJzlPI73sPAAeVj89CvK5f8/EMmyd40x1sx9Su2rL3xwGqufutzNr1XGuDpgcmaVX5SyUbS5go
	g0e+DMDs3O/E4vC6Kwo8SSsHzpPzDu1WxVa6+p1XD1WWShCaOTDLykCWDtAd2t3HoYXJrgJ7QZe
	/21gLJbSGbkABAEs4+6amrNIB0r+Zx2m9nYaQwVzYdhF87mOzcD7ErIvRroJ0I0kBjSZbyVB3QW
	Fft1S9l7jdzePcq7wK5M2q4nso1stLbEUc8YeX6AA6xbTGQQ2CLhi/CmW/Ug=
X-Received: by 2002:a05:690e:1201:b0:67c:cd5:f5ae with SMTP id
 956f58d0204a3-67c0cd61623mr574955d50.95.1793891250899; Thu, 05 Nov 2026
 07:07:30 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
 <20261104-pks-commit-graph-write-refactorings-v1-6-d013d9401a59@pks.im>
 <CAL71e4N4BvO=eMfO0wnJ9=gGbfTRz5ayWFZULoN1dGSF7uCZAA@mail.gmail.com> <auyCsmn6Hx_uc6zq@pks.im>
In-Reply-To: <auyCsmn6Hx_uc6zq@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 5 Nov 2026 16:07:18 +0100
X-Gm-Features: AclHuK9MUl3jSDHUQwkNKv29n3mqcJ4p9PzJa349xeDh4K-eWDbRCduxnNkq4G4
Message-ID: <CAL71e4PxNKffAmmB2XbV8mksUe_nJ9uS2JQhpbm2X1jtG=z9SQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] commit-graph: move remaining write parameters into options
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Nov 2026 at 14:21, Patrick Steinhardt <ps@pks.im> wrote:
>
> I was wondering whether we want to maybe introduce a tagged union where
> it becomes implicitly clear that some of the options only apply to a
> specific mode. Something like this:
>
[...]
>
> I wasn't really sure whether that complexity is really worth it, so for
> now I decided to not pursue it. I think I still tend to stick with that
> decision for now, but it's maybe something to keep in mind for the
> future?

Yes, I agree that it's already clean enough.  If this code ever
moves to Rust, an enum with the relevant data would be nice though.

Thanks,
Kristofer
