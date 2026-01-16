Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49563594F
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 05:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768540590; cv=pass; b=JwAUqjqhzawAgC+aDy8fTc29bdwZBILu1nQv8s40wjAu++sPSQk6lUh13jkhYuTjMUlSqJkgGpGKtjkSp6E/a3Y9bNw3VP+dTeXg+JxZztElkzElWKQE8ahaCsGeYi2oWEjvbfSi5uBFkMAgzEFWxEEtJnujozdsV5tPmNbczIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768540590; c=relaxed/simple;
	bh=zDFnh9GtefduLEGKu6MiXuDllQUXLdG9JgW8HpOUUS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dxNplh3i3KVqxB9WlalLc2bTJ+TibbAlMi2oJ9sirYdRVIyMWuye0qucSUoNn8452asoJopCnsGKWD46yCPWbvmHZmDbw+3Zmkhae/lwc+coPOXjfzLoV4bkUGvZ6bxFmkf7c5fS3NJ8aGOmW/Rahi99e5Oy0mPBoj0zm/TJqWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks/GNuTD; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks/GNuTD"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-563497c549cso1156411e0c.3
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 21:16:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768540587; cv=none;
        d=google.com; s=arc-20240605;
        b=iLxx71hYrAuagYhhoj6AXetOGs84PJG8g/f3jl454oszSfuIUw2IAPHofPm7JQWZZK
         uS7k3CFQ8tAQ9stlnQMJWviHmeOFzl0hoxEY7IbOS/8olOLarZBpPUTusFuGNiTZ+xUc
         HnFMKkyI73S60jV+t14Kd7llmmc4SJMWXjWxm9FXJaupCxogv7qdZifWsmqWonE03TBH
         GruRqCPWChu0FvM9Cx6QdZ4YYmdfU4EAoFb0fH26jp+B2TXIrZpU+iRUDPN2rFrFLLwr
         icg7EhU+dX/E9DEj8nP/CKHaK0ioA9+ZorPqQhwOrF0YOtlIbG5LxXbF9fp/nRQmmou2
         WmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=Ow/E/g3GbpI964MT/Z1Knl5QxvetpdLnlqRVWk8Kq5k=;
        fh=J3lB6HVM2OBDdowdDQhGTg906XVzZniHhGA+zKF1QaU=;
        b=dfNiyP/E+x+yN3Zal24HlMv3nS4m5qqtAIVfwhDZz2vZDo7zL6OGqPb0VZNdvHEcRR
         GBYWW0pG8BCij4gLGBkZKlAaAg857ZjKjDRoB8vVN/YjESIKlcOc2tYcoNGIBvqbxACI
         c7CxSxS3F3cVL4W0Sb6oN34XCinDs8oDUaRnKJ0TMM2SL/HlM1trOT37cwPl/XBpr8gj
         iyOgR9sg3hDxA4wRsrZQ7nT/4NjP9XCGcxpt6RAtgMZ1RPqRGrK/bwgVXz/FdoOL2Wl9
         8p21vzP4a94Eg8wsVeGSl8HXz8p5DvFUIbWh9/fkAbGwpzmhLYQHY3bGXftamwRgVAGt
         Lk/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768540587; x=1769145387; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ow/E/g3GbpI964MT/Z1Knl5QxvetpdLnlqRVWk8Kq5k=;
        b=Ks/GNuTDL+vmkqxvToiKIrp+RRPIEU9wOAQHyXAMIPwJkEw68WGW1PLQLHL0Oul+cQ
         RuD61c/7smycjqScrKFqN2R63zS8MILkNaZoS+YCI7mIPshvQVNmmrKA9oDMIPAa+8JU
         Fip8qC1yuGqr0HVYk0a93m4pqzSmLuDBXiy7qPTmn7XZvMOttkTK4ZJql5oN3VZdcqoN
         TNsrpKWsM1Cq/ggOSVbYBx96ZbFzlP1pjCLn27WxXkrZLonCLUbsEMAYjH1uSItyC0Nx
         7J1jQ6qnlHi4ncrDCEYItxLmT0fJu5DxCrYhhz0jzvhi7kBWY2jrA14c/ph2gtNTv21O
         vS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768540587; x=1769145387;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ow/E/g3GbpI964MT/Z1Knl5QxvetpdLnlqRVWk8Kq5k=;
        b=T/oA4SsN83FW6agl9lwi1spJAynJMEsCw2X9PWkVQB15b25d3xYh2ZYrp6Mti/6QKQ
         vWuin2QSbfc9TGqvoKWWPO9EeQxiQdZh8ymxzrzLaDi9BU76l5SSKYGDZyZKxx8tVl8k
         hVeVJ2cLWK8TcvefA3qJ1R1Bkz6/J3wxxpzixROLKCrFmD8WkNsuQSPtw9w0rboSIyyb
         5G8uWFimu5zjdghAgPlOKDXm6Pht2DIqPSRYohlIF9R5A14FLsFg8ADR5AVMAZsDpJ+a
         uTzdjXLzT9Gc44g9wqJXnDGP9Lq99wgdw8BK9jWotttMCA9dpKxtl+RTAWT8B5sk3BXh
         vPuA==
X-Forwarded-Encrypted: i=1; AJvYcCVNjPRbIOCBeRoDpdwXozoVSaOpDi6sVzVND+e0mHSp9Bh/HP+ZEgGinD0C+kjVgPv/hyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrYcamfOTLBw3CJ/hP8/jcoW8zP4zMxf2Hj/itbgZDfeLtHX1Z
	hoo1bmgdpHKHBcoCH7U2fbD+LDUH9KUBUwub+asWUYkGYd+kSERIhJtS21JC46hyLDQgpU9+yg/
	mw4Tc+U/pBynVOFqCyNl3ZM2UAsJnouCoP+uQ
X-Gm-Gg: AY/fxX62BIEhdiKNchlnd1OtfaDoyIVQzJJUQ/TVPzhup2q4RsiwVSPbzEYGjhK1OFa
	0fTdvMWT4h5gYxBvRovCEbWDNz/68ZbRuMMwenGrSO7OoABUaKu4yoQD0ihbb3aueKkIai2G32E
	xA5nmw/llULNuWvzavG6Zz3VoslI2Fu97jR0syIAm0Rz3iOeR96sucKpkbTsqwA399qpBeaoynn
	tyrGm/nzOYLeT0EMTnS/vEojZ5BxhQaZ4rhvtsKVAwP6YwJYeAD7T8UC2478s1NDK1mMIyXGQ==
X-Received: by 2002:a05:6122:468e:b0:563:7a35:1d9f with SMTP id
 71dfb90a1353d-563b5c89e28mr757506e0c.15.1768540587488; Thu, 15 Jan 2026
 21:16:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+itcS3-RQ=ESqcWj0Pkw=N4e4gwaz2fp2xH2M1MPXQXaMDmCw@mail.gmail.com>
 <aWEAHQLzwTxCpD5Q@fruit.crustytoothpaste.net>
In-Reply-To: <aWEAHQLzwTxCpD5Q@fruit.crustytoothpaste.net>
From: Simon Cheng <cyqsimon@gmail.com>
Date: Fri, 16 Jan 2026 13:16:16 +0800
X-Gm-Features: AZwV_QgWQ6_h4PNFsKmzQlJMB0TZE4oqvDcqYstSHNYLUKCVeV0oDD2PGwDiMGA
Message-ID: <CA+itcS3S3SXWGSwFp=k=f0u+q5eEqSqKMzFwLzKHLzLOtYpH9g@mail.gmail.com>
Subject: Re: Feat. req.: add a flag to `git clean` to also remove ignored
 nested repositories
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Simon Cheng <cyqsimon@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ah yes that's exactly what I need, thanks a lot. Pebkac moment for me sorry.

I must say though, the discoverability of this "double -f" behaviour
can be improved. Maybe the "nested repository skipped" message can
include a hint? Something like this I imagine:

Skipping repository ignored-path/repo (pass a second `-f` to remove)

Wdyt?

On Fri, 9 Jan 2026 at 21:18, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-01-09 at 03:50:30, Simon Cheng wrote:
> > Currently, running `git clean -dxf` on a repository that includes
> > another repository under an ignored path would skip said repository:
> >
> > $ git clean -dxf
> > Removing foo
> > Skipping repository ignored-path/repo
> > Removing bar
> >
> > This is to request the addition of a new flag to allow altering this
> > behaviour, i.e. to make `git clean` remove those repositories too.
> >
> > For me, this feature is relevant for building `*-git` packages from
> > the AUR, for example https://aur.archlinux.org/packages/paru-git. By
> > default `makepkg` would clone the source repo into `./src/NAME`, which
> > creates the aforementioned condition. Without such an option on `git
> > clean`, cleanup after build is rather complicated.
>
> Does this work if you use `git clean -dxff` (that is, with a second `-f`
> flag)?  I do often clean up ignored repositories that way (and it's
> documented to do that in the manual page), but I'm not sure if you're
> maybe doing something a little different from my workflow.
>
> If that _doesn't_ work for you, would you mind creating a quick shell
> script to demonstrate the problem that you're seeing so that we could
> provide better advice?
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
