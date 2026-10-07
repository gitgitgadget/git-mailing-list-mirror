Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980B3FCB10
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791376027; cv=pass; b=gXjcCzavMN0b02rOG69rMcNlbGk/WR2HPfMOPDnHDyhD7+S7xfGKWiFeejqfJ9NxrtufeBa8KhoEMVINfEy9lYIv4PzA8mCgYuD8IVGlOgVeGujIFr4vFYB4Kb5N0nla6d7VB+ha6NF0l6z2EYqDNq3/JRB7kPTgk8yiANTYAhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791376027; c=relaxed/simple;
	bh=7OEx3y6CL1VaQk9+mGhwRGkLX3HZ7BnNDOm/HBooG+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=q3lRPGC5JYV2jHRwdtD+NuNGgS3H7GkQIImUwYVwh6n0H5j0iAMMt4VQVtyf5Oas1H1Vbrqt1HYyEQRjFtlBrVy/tFFe6nyBQB1iJ8a4gh9Pjo2xT0SXw8HM+pkQ73F3yvFgDmrG1FTVW3W/R5nw6Oy9tw5rm4DaAU25UabMWWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj8gaWo6; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj8gaWo6"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6dddc514bcdso2326325eaf.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 05:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791376014; cv=none;
        d=google.com; s=arc-20260327;
        b=L75KGL90fWQrd5RKJkL3HqfQW2oHcaiQqFoN5MuIBUx1Xm88nmKMP0KeqCrnkhWrUl
         5OPWkA2vKSgAgF8RZh2jUMc7SnE/pUem9Fa4bbedThLmSVluU8WbDnuLd/KCEbFxWLor
         l8K2HJyOHKrz6E4721AeKwb3W5YqdAnNs13r1BqznW+tXjLG6HbQi/90yicDIhh0lESM
         oICQum/k4zaG/DJwHzfoToY2m6Q5sOQHKdFw5k6aIqBIfaMtTst/grHRHtgjEiEIC2z5
         IF9jzl5jXJ3gKnMuhsAYpn5iq0jrObtEVv41pVwcSNFo+uHRMNgi4rQlkmaM38j9xV0T
         bMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h/1ISnALKBu1Y1A3sGti1jX+r8LZz/aMU/VR3ofuKLM=;
        fh=zce8ZcIDVda7jDiquDSuc1Wmn8Tps2DnEodrMEmcsco=;
        b=cWfKSH+T+It6g7BZkje3rkJxfjCb6Oi6Es1xomM9Yz6OoLnF/ygpb6nbQuNP7JlJW1
         NHLftXbbkO3EpV+eTLylW5Jf/b7OZPbumCDu6rmGLNvqwXHCFv4rXHzIuAjLb/ijol5K
         Rm51geDxnctlYxwnGHfb3NCa3f6E01onQWAyKb702xZOsdazKslG8EmjcjC1lzC6xSc8
         FxDCjR/bJsB7pqxHd47erIwyq1BVyT9R1thHQteTCIFcO9gvy5hOOGwQfks3vZsPTpsJ
         FIDRicOEoLMJ4L0iyBxzpIJP0yuVl2dioLlhUUCYRM6WZ4lQplBK/rJ71lccYqGfBEqL
         +UDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791376014; x=1791980814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h/1ISnALKBu1Y1A3sGti1jX+r8LZz/aMU/VR3ofuKLM=;
        b=Wj8gaWo6dhFlrG5IJhuogRL7T+df4h83GUzBhs0VwGVUcnSebVkk7gdGMgpddhYbG7
         X03227tzmUs9sBcZ1U1r1Dn07YCYrPuxbZFzSTWfqheRb4bAvWHaBt/dFEe3/LulNDVT
         3S525OZ4VKC48KwM619HF/KQ0hSR/W2hCHxp+9JRGsRfz+Sm1X5RlqGmWvBHv8bMtpY5
         YhrPHtxq0wJorBeoowW2mBV+NitBlI/SSPOojX45l72pendBBLOxm1/XPuhVOA59OlLN
         8tCBjQPfL0BiHq3DmCSZossCdo6hyTFJ4XGl7LqexIpI7puhKCSdlpX5SgMOFgTVJdqu
         g8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791376014; x=1791980814;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h/1ISnALKBu1Y1A3sGti1jX+r8LZz/aMU/VR3ofuKLM=;
        b=KvdxolD3g8SLxEc2qC/EL1E3BJrkcBg3zqI8PLEMW+F1H73cS90tc96GV39VZtlUh7
         E+PnZtmbFNFR0QqeFCINmPumgWZKOtg9NH3yU9+RtIlrG/ixIFYZLCFDOzQkfXVgNrPk
         6V20XQcg5Zc6GpssLZEZ8s0YohCDXyP2hnrq4GozLAytxqv2+13SKFV+FkeYscqjeyV0
         YHtD7IYoL1jrR+ZvHEGyDcxGnYyHndWF1hpzvmE3lgoEH8YC87sUJioXKihTuVqRNTjH
         DfJ4ayDwwdSx9j6GS1ADo7HIjdnzNXWl2d1wYfxdkEUjhJnQFtvTg9E5ULR5SiDjcf0o
         sn5A==
X-Forwarded-Encrypted: i=1; AKwUvBxFteqM1+DP39xhw+R1wRtSw9iK/2np+6T3GQ5pZrqXzjjGUkxkRtloSiW4J14+m33vgis=@vger.kernel.org
X-Gm-Message-State: AFuF++mSqG/1gk3R+X9pGAW4mYXQyydwReXXPXVRLgmqfC58pEQZZb5m
	GiWIqoFfU1pkKBW59qFGJzEFvzNxdbWfKYGYmtm3R/nciUR8alKGO2BPWobGf8LbI+qocsyGSCo
	VSJZTCNjtriAUC2Q46ZcnSxTIFVIcVok=
X-Gm-Gg: AYBFou3Z5+CUPOhVqfgm2ioDwPQ8XP3dEZTDEnsUjTt05aMqUIVEtkh/oDyZNFXgcnx
	jofhGB45TZ0LDBlj5p3s74ntA9M7LKp6yFL7a0kSBQ7ek09fxYR9LnbIk5TeiV7FPEzuGAQLZSL
	7XjL/ggeGPABGPQneSK82rbSrpMt9XG/xvMM5mmJyLvKc6ldNZNwSlx8g9o+XY7HtHxAqUTXwfM
	HdWtRPoTRYAQ+rsegZdtg+R7qUB1eesoA5Yuz7uwM2s6hyhBR1wBsF0bE997Vh+dPKjlRQlCOTq
	h4Rp7aYSY1++EgNUgp0vRo5RClgYau0Do++7DPs81w8bQlBu5FWt0ruetRLz4fguyM4wGQsOPYq
	bgM9m+/msGO5TurKOpgA5ztV0nzJmrT0m61hEsf5HsquxViRpFjGqwAyoS1ymvojQul1SEj9LO6
	uEaBbnhDsCyOCYGnnOgKJhXtO7uPeSeLHk84/RMHqj
X-Received: by 2002:a4a:e845:0:b0:6df:224:2b48 with SMTP id
 006d021491bc7-6e7a2e4217fmr2200128eaf.10.1791376013699; Wed, 07 Oct 2026
 05:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002081846.25144-1-scott@gitbutler.net> <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
 <CAP8UFD096CdR9MXd+VHk7Zf9rCJEnGTEiBhCc0mJdMmE3U_gOg@mail.gmail.com> <asV1oB_avuEbgRVe@fruit.crustytoothpaste.net>
In-Reply-To: <asV1oB_avuEbgRVe@fruit.crustytoothpaste.net>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 7 Oct 2026 14:26:39 +0200
X-Gm-Features: AclHuK9NlhQTv-3e7RSB2J8dvMQuEVIQ1G-IjEsehy2McZCS8ZwJsrUD8HJ00zE
Message-ID: <CAP8UFD3dnx3u6LL78pPSzreaTsSmoiJvofoR_R0Pyk7H6-8NXw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits and tags
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Christian Couder <christian.couder@gmail.com>, Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 12:26=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-10-06 at 09:00:45, Christian Couder wrote:

> > Is the current state of the work publicly available somewhere? Or
> > could you make it publicly available somewhere? (Fine if it's only as
> > patches in a tarball.)
>
> Yeah, it's at https://github.com/bk2204/git.git as `sha256-interop`.

Thanks.

[...]

> > If some of us could help you, how could we best help?
>
> I would love someone to start picking up patches from the early part of
> the series, rebasing them onto `master`, fixing up any conflicts, and
> polishing them, and then sending them in.  The `sha256-interop-part-2`
> series would be great for that.
>
> Just let me know if you want to do this and then we won't conflict.

I am willing to help, but it's not likely I will have a lot of time to
work on it before the end of next month. Anyway let me see if I can
upstream some parts of the `sha256-interop-part-2` series this week or
next week...

Thanks,
Christian.
