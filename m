Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793906125;
	b=CgG4eS3Pk0iaJbNpX6x/D39PtfA7m+qSvjTi/8u1pdopRIZ9q+NGVhN5oeoSNBGzl1WT
	 pMrkdqTwOdy897MiwtD1Kw/XcBKroozN4aOQIlP1DuaPjgQt2fVa78zJA0Qo8eNu79ba5
	 IYuOMnasYudEAT3abkY3n9M+e0NEQrS0SvFWS/HGoNv9JzD2DY4V+wtP8ynyUHVwMRSnT
	 JVpxhslaN+gaxnKLi1GLnSXb0D1eCeZtxck4EZE6qPRv7M3/vq4T+TewmFKofANY8iPYN
	 ehNZyLUnDfKHFDaVo8LA6faSuIjE3BtwSJ/Ojs047UMXSP0YRuFtKTh9m8CBB8+eFdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=UdEoOvWoO4DuIDuWH/FV9IhK7vlDtHn3ih6iZlQqR98=;
	b=NSH5jd2F5GRnbPxWjpilUJ10rrgrZVowKIKYItNtkXjEqIK9joxbbcCv/JB+ATKy97K1
	 XOY52PjYpOin0PqlAU2yLOMAAYC4P8FMihC9xFyZ+5uA6Yre0X15hpf4dSsADsYhpLDTu
	 uBZ1AzZiGnnbWBFDeuhCwyiFMAb+a4mpiyRUlJMvocrcfSDu1pIJTuUPN4wFli2/VQfYG
	 mG95fW2PI7dTNGBgijgXEiXgkayBOvKDPdF5+F7BFygGwGF9QaY9aXi5U6pC4u65vPPMm
	 CkYg5UDJvfaaeAhZjlGdHxhu4rPql+mZ9Ik8x5lr5V/O6MHGVJklowXFn+NB0wqy+Ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l5beoqTR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CD2606A328
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 19:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63CD2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l5beoqTR
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6d290b10a35so1054740eaf.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 11:15:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793906124; cv=none;
        d=google.com; s=arc-20260327;
        b=kdxcQ0ehFfJ2XM5iM5wLwRWvLbcCGkDI/FpMUUm54GXwi6RYeacwAymfvsXYK8l+Jn
         77LTqIe39x7/s3jLQsY0RTxZO3lI8fvHWFKijUFzEF2bwL7etcS7DF4ZqR1fnfY2ImQi
         RztMumj4T1d6SNCsUt1/Bf+VH/kVB65f1LmbpNj7UD4F/C/RqpmJso21I5XXL9/tTkPI
         HRmBYuiTiV2CdoB1FKwN6k+c4/2aLtYTGt8oJkeqgomfIa5y4jYh+xlW8tuYYRMXAy6J
         PdoUgq1e5WSBXZCQR8E24G3vkBf9qRS5dKEG/2umpISByd0DH/35W5W1kDaxYzQjkauL
         CgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UdEoOvWoO4DuIDuWH/FV9IhK7vlDtHn3ih6iZlQqR98=;
        fh=GRlzCOJ9DXBM0i6A/iVtq5dr8FzCZ9cO/i89g4/OYzQ=;
        b=Z58D8Z4KaYfQbKMFOY3UgiNKhomaHSPUlvAB1/txGWYYUOGcdQ1KUwTB+lGQ3XsD4X
         0pOyUs4bhjNI0j14JEkx8n4J+3/zmLWZfD+ItHdKLA2bo7/tgdtrFicreCrxh8g6qJo0
         /mHIe6Vdw7iENPem+iod4SyvTtMXCPTn0WynDFZMtBUGV9dGzk9QIPcLTWi4fN1ZFmSm
         BQcamMi+N0SoxtydHWTuSxnTrj1QPaauu3xC1hHjmXIyKDur5z2/98eTUnJE1/uJPi5x
         k2DH5JA8AJR8cdGwZsxBuI4bWZ/2pFMsmm5DMVDUvcd3bE7rgxSNRyETzgytbOU9O0AN
         r2sQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793906124; x=1794510924; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UdEoOvWoO4DuIDuWH/FV9IhK7vlDtHn3ih6iZlQqR98=;
        b=l5beoqTR7j6S75yLezTWpxNVLTVpCot1Mx/tmyy6IBu+AW8zVjCT6ZXt2UdFw+ag6G
         cJYI/C1JD6v/Vk2CRV94xD2FcWlU9RbE4sN2rkZl9lC2OnQ8oXozUHUFxMQCMhAMCnu7
         CehlrDRuu8GvmeobGIOTHrHJ6iFPIGJABho2Twe3uP9ngX1Aq8Xzirj12F4IAx9fc/DH
         m5DWRd28b8ST5na8JMBRb0oSjMlIGI7xHH5K25hXvy6Fbg/gqf1KjOCHlTvuF5wuTo7G
         98O32cMR1qOvS7lPV28skd5NjVRYrLh03zJ+EpcVglNdIR27Zdu00NOlCvwdFijVl1uE
         U1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906124; x=1794510924;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UdEoOvWoO4DuIDuWH/FV9IhK7vlDtHn3ih6iZlQqR98=;
        b=BiL0Jm+Uq/Abm6yi0dvUHbY/65oAhvjP2hzNs9ReZFft31f/ZWt8ro1AsmqiRRNomy
         RsWquC96ij9Mp6fblyhv6f6k7AMmb6UhyjItqrgy8sVxoDNLu1LokRjFZlZe3qx10K32
         lziCYonLKIsQ86M5+gOhsWwzK+cKwkx7SWP18ctCSeoA3RtZB1RrI5tYAAuC2qx9+ddp
         a5lhLAGVQjMDqm3pW52Zjsv5FYucMA3pzJaFQ1sqtbAwOxS++wyG6a6ZKX6tQoviKEG+
         NWasqnXL/idKdiFX6WX582ku/SJ08viAavXAoMg46CReaTZ4DREPlNjTXqN6wCkrmgTC
         DMfw==
X-Gm-Message-State: APuU4Z/UerceRt9UP08V6wx6e4+2o1xgV/78Ni5hM3hsixzsRslWd4eM
	g/gFgXrCvdou8l+GdbxMFnbEW3ckdnDf/IkLXwGp36uoipflWV/swP/ifN6QY6HdzSQUEQDwem9
	zp2fD7yhSIpeZJRJkxnUdbgXrAGBY+Jo=
X-Gm-Gg: AYBFou3wJIRlttFNyCDbxC4zKqxC7gZJO4bkfJ1XrxTyY/34DaKXskwou0Cl6rq3AZI
	qVowpQCQ5XwXBNdArgdaFP9ZnmzvE1rM+h5PieF1MvJsUzkGnHD20hrjUbH1LIEeHwHSz/VrPRG
	s6coCfwkByqBUvK3yDk4SPUUUnPiRywkPondCl32WlLZU4rbAKqJKQxVzQhl3R8kvrhJ5WwwWBc
	Er1btFkVD0Af0ULkFeEcYP6pxYAYgJE2aBUbpTz85spmRAazKSsCYPJUJO01XM+ob6uKOZyFlWN
	EsnyANgZK9nWoDvXSwD/W7v1fJ/kR7QjwCz8N91fn3++fpLXqq/z9lqjFP1v5UkVqLI1iwpDFsj
	rSb0ci0/1g78mQmYBU7faNe1vQHXn1BuqdotYUDN6kmVxS4ClqX8KF3z4V8Zsfk9+ZevuONXxv/
	Y/ZileNfolwrGiRTnpQuaaDqJQkpr6cmOENYpMDk7vQsDiGJ8qBSUa4o5pMjVSi4FoFz8jRzDEm
	jNw
X-Received: by 2002:a05:6820:4481:b0:6f8:a519:d930 with SMTP id
 006d021491bc7-716e78b499fmr389583eaf.34.1793906124278; Thu, 05 Nov 2026
 11:15:24 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029231621.48958-1-tangajoris@gmail.com> <20261105003914.708836-1-tangajoris@gmail.com>
 <xmqq8q37xpi8.fsf@gitster.g>
In-Reply-To: <xmqq8q37xpi8.fsf@gitster.g>
From: Tanga Joris <tangajoris@gmail.com>
Date: Thu, 5 Nov 2026 22:14:47 +0300
X-Gm-Features: AclHuK94n81pn_0iKqa5x00CuNIaL8aSvLOBDE4PNZRCyxj8ce7PhkuxyyMsnC4
Message-ID: <CAKrRMNpJhpqqAdELav+cw8=ScxVk6bLDJSa6Rq+Q4pyRg6uZdw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v4 1/3] parse-options: answer
 --git-completion-helper before command runs
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, l.s.r@web.de, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com, 
	usmanakinyemi202@gmail.com, herroyalpriestess@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

Thank you for looking into my revised patch.

On Thu, 5 Nov 2026 at 18:32, Junio C Hamano <gitster@pobox.com> wrote:
> "wait for input" and "leave files behind" are peculiarity that
> exists only in fast-import, that is shared with nobody else, no?
> The fact that it does not call parse_options() until it gets an
> input, and that you want it to react to "-h", is what makes this
> function useful in that context.

I agree that my comment focuses too much on the
peculiarity associated with fast-import.

> I think what you want to describe is
>
>  - A program that uses parse_options() early in the program has no
>    reason to use this function.
>
>  - If there is a reason why you may have to react to help request
>    from the command line before the control hits parse_options(),
>    you may want to call this function to react to such a request.

Yes, that is what the text should have described. I will rewrite the comment
to mention that the function is not needed by programs which call
parse_options() early. I'll also add that its purpose is to answer
help requests (-h and --help-all) or the completion helper before
parse_options() runs.

The new comment would read:

  /*
   * Programs that call parse_options() early do not need this function.
   * If your program has to answer help requests (-h and --help-all) or
   * the completion helper before parse_options() runs, call this
   * function to answer them.
   */

Thanks,
Tanga
