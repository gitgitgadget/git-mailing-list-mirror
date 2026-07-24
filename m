Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643473603C3
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915372; cv=pass; b=J2O0JUOBQgNe7IwfZjtUq8g7gZIrAZQc2WwWpyo8VVVsdNMCR3J/DzSsAO3d870T5SvaKUtyMHTytIF9hg1ZNuwWvKNBqUJHQrFY0vy3znyx88cHZSWZNht43aeBkUMGeCo5F3I5mrlfkxsInRdYNfWIOTWPEYooacUpU437ayw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915372; c=relaxed/simple;
	bh=ppTsr0hNv4Mf4f0584gkCM/YrgUKZEb8LFQhlb9swGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhPkWN4k3DY8y2JHlYl3d3fKVoI/2Foh+dWk7MbobhKEfyl1NgSS5JFsJ5AN/IJymcqh9OmaxBJA5RKGP6hxhKVJRPSnTsFTzPe2w8+4xIOVd1avylz7MR/3S10/QJDNouMZsahXOh76uWcZ2CxPifEVtNvugmBGlj4d1JLK4t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNGt8wSb; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNGt8wSb"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c7ed5410bso4244471fa.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784915369; cv=none;
        d=google.com; s=arc-20260327;
        b=rzP4dQHIpO6ruSV+d2hYwL2ni/5WpUsOfoJAKPXIqWVIYAzQhxxZS+6lMFJuez6Wlr
         HWHEDpWXGAW7dS3m8IabePsMEDLyE5cipp36T7QAx7luyta/m4FN6S1dnuND4bPA293j
         SZD84cfc2tePj82C7CiPisfErvuTIRFgTl6FfR3R8lzenlnTnx9WJhtltf3al9A0ZmR2
         gnR2eHxVOW4uJnMLaSPJU55piEk2wEUsdtYEfJdMOxl6KKuMUfB2pSg5rSpWoVF82bZ3
         OvJBe6EXJV3p6mE7XeehXtXztIJmAibawRms20Xfj+0lotBt+BViGwGvhD4h3oO+UJP4
         QWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ppTsr0hNv4Mf4f0584gkCM/YrgUKZEb8LFQhlb9swGs=;
        fh=2fKBGui0CPLp/DkOGwBJS2c6k6TbQqR+qLNrnXY2Uzw=;
        b=VuELaCDUIM0IG8P538FHbl48gnGyN6ewIBu44naE8WrPXFc3G60hwcW7yoXsbDaK2o
         a3JVhEwoWfgEvPPK/eUZfSpg10AyC5aLj7HEBQs0PBKmQ7sEMdR8UKI8fbYfHGhpij/r
         cLSJmRmguRNV41GPkrJdhA3mKgHWJfCOEvvPSPbMHUSVV2LaFhTqVipY+3XmHriWCMoq
         izwF+cVHhJNNYxS1MulDwF6t+gcDwv8aAqavLFjjG33ztMilgzE1kW3PiPEIkt63meJ3
         OOYZvAo0yeQhwdQgSaFQUCEXZntiigR0q4cDakwrANRf4didZ/fXTqSUEG8G8gyHwVUe
         QjBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784915369; x=1785520169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ppTsr0hNv4Mf4f0584gkCM/YrgUKZEb8LFQhlb9swGs=;
        b=WNGt8wSb+sdMlWYAQx/p0nCnwWkxZjfG4s9OrGYSpSvOi6Pet5fEeq9EmiIE5TpFZw
         vwIg/Yj+jUBBEa7r+ToSOG1T/dVeQkglMOtSMGmEMGAekDszGngFAW9HoBEOG2/4bzHu
         yub1g9h1xtE1Rk47NlY5ERWDjt5VcnR+oNiGvQIqSbWDhL275/6xDagXlxLKD9HpBgFH
         WkNOLCfOt5KcRwQzVBuVdjsyyUgBewc93YDjL+VJ9ZsZeakf7vlTln249J3QvTfzSYxc
         L89/ORzrIGbKy52Vqd8JXpzxrLsOn0v+TzblBNu6r1XmEudDvswpz1J8W5HmrNRZuIFS
         rTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784915369; x=1785520169;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ppTsr0hNv4Mf4f0584gkCM/YrgUKZEb8LFQhlb9swGs=;
        b=s3tzkkwhy9n/2EgZb1GaxnrQ7HOI4A0MG6CRn9RN+6gfRhxPltV8FeIQKW5BZH5zHw
         yqbx2M14Gb0sK8WpZgYXWjTPfV6+KDRccJTCQZmkN57mMdGMYjMrespIPHlTjqBCmw6G
         vI1Q6C06irYn2u9hfthwyKwsp2pfarAgAPMg+gnRBV+IFZVBphF97xC70j/FhmRhDm3L
         /Tjctgy50ZJQ2i+h6HlRgHMUCsHQlCS3BCG4oczIQQYFDc9DJNPOdWpoG7sxbYspDsjU
         YC0mwXDXzrhaBFaZ4kgfXn2GITX6iwdmXflxwKqNuEPPjEMWS0C2TjiVQ5qBkuAC0srM
         FOfw==
X-Gm-Message-State: AOJu0YwIDQBC6yRzqt7gZbNE5/WcbKFVUpL9zixaSY2+D9kxwiXHYAtq
	AF+istyByrOlomR9bXGhAMGil/YqeB81VIOnfrvsN1NZ0/tfN7kbo76K1SJvDIORpHgr0Uasn4Q
	0Qeb8luRT4WL+2ub/w9IekoETdJJXwBQ=
X-Gm-Gg: AR+sD123zVt6Bs1he1QUqSe+WNnkfJLgjKQ2PSEJZIQWzfY1f07nwJGja9U32Y8b/qU
	Nap/BJDnITtk5nj7g4wLftq6ud5EF0/HSeFvFol6OXNSfSxX1wyV9Ax8WxnR6EetR2El1rTGX6H
	OCFCGzMDLJOoGYJUIv0nLKeHWTKsEogZpo/YeFzQoV+eYFk1b6UbcpyDrVB8gRgn8JNbab6XNpB
	/aCWevWa/lhwd9Ql8oQsTVaOM4ja9+fpNcTKQlIp2ENj+op5U8h8uJATs9DNau2V/bHxChVM6V9
	wcc9eVv9Svwg1OQ1gSrj4ym8VN92VwGZhVek5rc1roM2IE0MJioKLBf/n/pK13GCUwM210reCnd
	QqlN+GCIPlWe05hc=
X-Received: by 2002:a05:6512:3584:b0:5ae:a9ec:3545 with SMTP id
 2adb3069b0e04-5b2b2f730cdmr1262910e87.54.1784915369238; Fri, 24 Jul 2026
 10:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
 <20260717133015.32040-6-jayatheerthkulkarni2005@gmail.com> <845D6852-98F5-4168-82CD-90B3B476BCF5@gmail.com>
In-Reply-To: <845D6852-98F5-4168-82CD-90B3B476BCF5@gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 24 Jul 2026 23:19:16 +0530
X-Gm-Features: AUfX_mxNM_8fd0LBjl6dxcPAyxyOkL06uDLQ63ac1unTd1HWepXUlD-Q_WvaRxs
Message-ID: <CA+rGoLcgHYk1BgWyNmJT6SGmo6xb_Q4O=LT46FXaC=+tQ_U-qg@mail.gmail.com>
Subject: Re: [GSoC Patch v2 5/7] repo: add path.index with absolute and
 relative suffix formatting
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Lucas and Junio,

On Mon, Jul 20, 2026 at 6:05=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
>
> > Introduce `path.index.absolute` and `path.index.relative` keys to
> > `git repo info`. This allows tooling utilities to discover the active
> > index context cleanly while scaling transparently with localized
> > `GIT_INDEX_FILE` environment overrides.
>
> Note that bare repositories doesn't need to have an index file. Maybe
> it would be better if you return an empty value in those cases.

I wanted to follow up on this series.

I am a bit unsure about how to proceed with this specific case,
especially after Junio's feedback on the grafts patch.

For path.grafts, Junio mentioned that we should return the expected
path even if the file doesn't exist yet,
so scripts know where to write it. I am wondering if a similar logic
should apply to path.index in bare repositories.

While bare repos don't have a working tree (and therefore usually no index)=
,
scripts do sometimes set GIT_INDEX_FILE to build temporary indexes for
tree manipulation.

Should we strictly return an empty string for bare repos (similar to
how we handle path.toplevel),
or should we return the default <gitdir>/index path in case a script
wants to know where it would be?

If this confusion is clear I can send a new version!

Thank you,
Regards

- K Jayatheerth
