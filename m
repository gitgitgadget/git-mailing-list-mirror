Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16AC4973B1
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590634; cv=pass; b=CJ5bCstVzygGBRZZrSVxZZe0959g21dugovPgIczwJU5mrTZ189BJcj/Os9zcUdMCq6htNHX6qJtb1OfYmSpVhbuwJN9kNA0a5X7/OBZ2YMn1wIPZ+7IkRt4BKoNDheW04hmzzuSLJ0OvL9we4Hi5lr0xU/xRVQWBXW9AyE6hI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590634; c=relaxed/simple;
	bh=bkeuj3fWIVvKLxgKlajhfurW3kj+LiA04twYxN5euv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AikaV+Rj0BDAdQjonvd9mzmw8O263Pb5s2ZuuOg1g5p2imuYwhCQppIXfSxCrrZi7OnPsYN+9/+s4YS2zI0MuwJZQ1Q4Rki21qMxtzPn9VcOPcjvJhrzMGupp2aTGddyfykpf0Gfmhb9203Z11DM5FG6ek1lgxir+b5JECafSA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC7mCxTH; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC7mCxTH"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a49bc59559so21202191fa.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 03:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790590629; cv=none;
        d=google.com; s=arc-20260327;
        b=a+4U0u+NIb95LPm7tgQ6kD2G1iFtc5MmsZTHrCkD6A7kJvzX3k+9H4gZtVzI8YwC+F
         SIbaPNmGvuutn/ffGQszByegOFmTFc5TwGxRNKGdp+gQhZuUfhruhx/iJmQ4ixgmcX+M
         TlmokcHQgJS4rGOIiVDYujHo97p7ONj5ZIz4z7hu+Lkrkss1A7AqJR2V+1CmFMVeV70v
         Iiecj7xWZoKLFm78R1mpPYpyAT2dLyVJhy4EVoP40BzwPI9NFKXZEdIyA1HnYLrLv2mv
         p4MZkAiqCXGdm/DnGSv8Ba0LQd069cShUin5OooCK2oIqwiWsQHdKwWPoWIQ9FSkfSvG
         ttNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vDvfFORzli9SvLaZI3tu6CuYK8dmt3iMi+5/9gXzVKA=;
        fh=xhTNA0mJPQkXgCl5nb8pmfEc9l2jOBtNjAD+skEbj5M=;
        b=g7L4sVXA6+0jhkJ73qtPxzwMv2ige34nJ70M/7XPYMq0dvXVaFm7EUsUJ+JixnB2TQ
         VnyfPlcWuAvpcuYZD3u9Ml3CKLYjnPaOXrLloXhnM+RcwcYQ2CLqvGw1TwDkWYYByaFX
         6nyBAnxDOj+0dp0msSa062A7t0D0V3NT44Sib3Ki3jw93N/RiB04xPbjQUnmvatHrBO2
         xWFygFESaWi/OtlyH3106yECVx/2KShgKMNypvQayhHhF2TDKFT54kIPC2ULd7oQfldf
         ljy0oYA/qDXHqp+0nkP81Qo7DSjN9vKrfOxdASXS3RBfxoipjeVmPRbmTdmVnTSRixo4
         WVcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790590629; x=1791195429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vDvfFORzli9SvLaZI3tu6CuYK8dmt3iMi+5/9gXzVKA=;
        b=EC7mCxTHME4Pcc26HFqvv/DWbKHsI6ps2TyX/2dZwg3FSAy1jEUhK1t8Itw463+0jy
         s14/peYFC+vXwZIxIPW8VSs6I+gfOPSpKr3+5MvzSyXb8HTtveGsT/00zREYKiwu2KI1
         c4oqQxQt5qHix+8uwGauKKSWX2sW7npYnvvDOCBB0khpSRvA4DB4aLF/ZjsHcMb5+GC9
         UjSili7t68+KQ2SJ7441zqUU/x3W4BQUHT5FEWSvZIzi8JI1GjnjRJzrjsPndgxGtf4s
         1wwgsJWA1PuKufuFeKP7NyzkDbeWcymWS+hckFPAmtJ66710GswAGTsGVgrcIo3PjqYm
         Jj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790590629; x=1791195429;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vDvfFORzli9SvLaZI3tu6CuYK8dmt3iMi+5/9gXzVKA=;
        b=YdA444kJGn8aF2LS/Ctry1Nlc+dNskcGt0cRMyYBesY+mDtwkxMqWwmwcnT76ozA63
         mlMvK6iEX9Jl5qIyXzaXYgDUzm26s6WSLYKdic6mOlBF71sj7aADaz3+vOZ5J8qj7yQx
         R7SJRrL7wWRv/K1vkhoVKSX5rNrf8ZRb2QgVEKdWtzzDlfSL9/d4e2sLGTzTf4DhOIrG
         C6ZafDZp+5EPbb/8jeeJHWk21BM5khBiKsZZir1SsIKmmORDzZXfwNo8HZK7h2Wrsz4t
         mXKm8a8WsOBpy9wpBxX3c1bE4l4TGKUMKs1I+O+bqlDrBsbQhDp2zSBDIPHzFNvkMlxR
         /z8g==
X-Gm-Message-State: AFq9FYLzYQhejMvqCSWQdgg4RwRn/39PyaPf4aIkXNLolqCw/awp9aGs
	bwhjGj6Y/vkYC8c63ocBYfvCpRY0l5bTnPylk2xnc/7ijMxEFcWCNp7trSVQtZVnasRoN49VzdQ
	+ArjMMO2vnZOEqt9um97DoXA7D2RhINM=
X-Gm-Gg: AYBFou1Yqc5FXcjJzKdtX3f6YijamPjh/+++WWgVLbfo+ATG4G86mZSsaNea7OeHz4E
	gpUEwS8LljuEHoLh07ad9gHtZw/80EO9pXaUZ/1yG5v4PWqVV/mvQgbiY+76TxI8X7Bu2JJzFTV
	d3UMGyRLSDMMhdIfUbE/cHkMUFv2OqgRgkAdWeztJXX/I/3b8UHt4M/jyuo/bPjo/YnKcZUNt3T
	pa57HtC4y2rj3SOwfTqofd7vDDS+sgeHtuuSJ16lkBclCTJh63sSfTrYgNQDDTEQR5yzmnmc5uO
	qOe5WReqd0mI0Ve0q77h9nfwVQZzyfZ4mCSsjGGFGvJ/do/SxbrhSUBzESR78HhpsPw4OLfzn+r
	iQEosGRFdudHLeAUA2BllBltZCITL6+75sy3Gur9UUJ/gBCtzF4/JGzyQ3b2iFYjWR/Y=
X-Received: by 2002:a2e:a593:0:b0:3a6:3741:987c with SMTP id
 38308e7fff4ca-3a64c7e9c2cmr24226661fa.27.1790590629001; Mon, 28 Sep 2026
 03:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com>
 <20260925-ci-large-test-resources-v2-2-f632cf319756@gmail.com> <aroK7KcRabARSqd8@pks.im>
In-Reply-To: <aroK7KcRabARSqd8@pks.im>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 28 Sep 2026 06:16:33 -0400
X-Gm-Features: AclHuK88zFl8KF5Y4HTSdDp7YPTov6b_e8H0cPcrRso7uF8qGgo-LCqYKF1xkVA
Message-ID: <CAJ-ks9mWU2cFWLfioSSM_6Ct1ydtxn3i4Dh-L537M5EDiMW3vQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ci: align job counts across CI providers
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:36=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Sep 25, 2026 at 12:35:39PM -0400, Tamir Duberstein wrote:
> > GitHub Actions sets JOBS to ten regardless of runner size, while
> > GitLab CI uses the detected CPU count. Use the CPU count for Make and
> > prove on both providers, selecting JOBS after the operating system
> > is identified.
>
> Again, it should be noted here what the effect of this is. In other
> words, does GitHub slow down as a result? You already showed numbers
> during the discussion on v1 of this series, and these numbers should
> probably be included in this message, too.

Agreed, but in this case there was no reliable performance change
across 10 runs; I could include that.

>
> > Use nproc on Linux and NUMBER_OF_PROCESSORS on Windows. On macOS, use
> > sysctl to avoid requiring nproc before the dependency installer has run=
;
> > GitHub macOS images need not provide GNU coreutils.
>
> Huh... "need not" feels somewhat weird as phrasing. I guess it's rather
> "does not", and consequently we have to adapt? I think instead of
> describing what you do, I'd directly pinpoint what matters:
>
>   Note that we continue to use the same logic to detect the number of
>   processors on both Linux and Windows. But on macOS, we cannot continue
>   to use nproc(1) because the image used by GitHub does not provide that
>   tool. Use sysctl instead, which is available on both GitLab and
>   GitHub

Agreed.
.
>
> Thanks!
>
> Patrick
