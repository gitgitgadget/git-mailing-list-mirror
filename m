Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E07E1DD533
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136322; cv=none; b=Z/NaFyWjhGhsvhTxovjdNatDxiwqh6+QHB2EZf4pQI0vR3gA2OxUpWWGw8rJFOIoNSx73PbcREjfBkj7Davl1E7WgH7BlO+U6/6sUMhi2OWYMf7Ptv21Rtihmaitv+YCVahPFO9PutHmQ/CjugkR0bTiTihfyuTo4sZj3ozWXHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136322; c=relaxed/simple;
	bh=0bqhxvRp84g8pbFou5YoLhDEqZcIvJBKgmYp3Ewzs88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQoS/rhzXyaVMorhGccdiTixcVpvjtjZ1IDK6jhivo0i6mFt8H8Uny6lshAK+GERl/DPVxQ+x9KN2I8EjVYHOGB3M4/u2LXxsNfzLuKAOXdVVdgdqiuiVtL0g+51jgEF2P/wt8KcCtdKT/8zpzUxeXgp4WPWEWTHqZ1f75NMAgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=E9jrRK2Q; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="E9jrRK2Q"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e2915f00c12so4380206276.0
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 10:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730136318; x=1730741118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0bqhxvRp84g8pbFou5YoLhDEqZcIvJBKgmYp3Ewzs88=;
        b=E9jrRK2Q+fGLMesSSonuAGccedkzr4ftOn51jWlt/nhyRSx2UJoDPOh7nmPL4U2KxQ
         55UoBqJZmrtVxmh9WDam4rsqSqtIsp6dVbzQYosO4KfshEyA8io4i+yVW6Z2jibJ3S02
         g65Hu+qHDPYhR/yaq3pADaHjkhp5y4Uo7bOu0XAHJa5kIOP30/aw0Orftdvy/Kb7xN4x
         nbTD/loItztp9OFWIYLXwBl2bSzoo79ICCJUsqwziNiguagOe+6bksiWL7muM2ilqKVz
         kinP7CCJPiJA9GGkXC4HfLPypMb4OSigjq3/V12wACyJiUko75WhR901o4BR+m8VT/e4
         VdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730136318; x=1730741118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bqhxvRp84g8pbFou5YoLhDEqZcIvJBKgmYp3Ewzs88=;
        b=Q98KUpFf+ilKLLcTA6OPvxy+ca0YtT9rhYML0oHaBSFnfZ7cY6wlr3AgQ1zj7cciw0
         jotyRLW0AmgcabAws3Nyl+JIkUBWlIzRmilC5vFU8Ae8npmTQqA9XYqfaMfNIKXrN5ZK
         aYa33EVCauiAkNj9dd+NOKRTPm+1onoEFqQcfJPgvBnHOx3OTQNZpbuRqDohhW48EQ+B
         tB6DEgdkx5iG4qTDYzGT6A7lJRcVjV9dnGU4zKAR9KL0kYVr2cfPTwwO0NS4fLhDOQgj
         et3Tak4ju+PPq+Ju6yjCyNEp462vKIoapaOTlnvkcLZQz/ttmuq8nk57HOMnCLbqglTD
         rupQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDmpkhe+LZhqGEINJrMa6syV1MN1YXcriBZjJnk+6SRrJ2/BxSf1wxHMuFm0XJHnIGr7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNMFXfaz21LuF1wZQkLIaZ1oiY2QBazCdqqxbnBkmcwVGRvxV
	609y5FVa0Rm/K9a12CQ5AdpWambevtazAcId9ktwMoSB9JAf95zwEPO+fNN0HUNUoWiYXWOZN71
	Ycs0=
X-Google-Smtp-Source: AGHT+IE8ceKqLlu/d4RORA0u2tcx1OHUS9dqP0ALjwLcwHrK0ZyDTCPeyo4zXtdkeQBJkSipAm/PIA==
X-Received: by 2002:a05:6902:1605:b0:e28:6d3c:f869 with SMTP id 3f1490d57ef6-e3087a4074dmr9281585276.11.1730136318189;
        Mon, 28 Oct 2024 10:25:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e307a03cad4sm1503124276.61.2024.10.28.10.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:25:17 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:25:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH v2 00/17] pack-objects: add --path-walk option for better
 deltas
Message-ID: <Zx/I+9icWGsRz11x@nand.local>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
 <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
 <ZxbLFLDgCm6wLmB9@nand.local>
 <Zx8lHzDyqyBpzrAE@pks.im>
 <Zx/AGrGTN2mQZqGs@nand.local>
 <00d80855-0530-4384-8d2f-5370ace9c0d5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00d80855-0530-4384-8d2f-5370ace9c0d5@gmail.com>

On Mon, Oct 28, 2024 at 01:13:15PM -0400, Derrick Stolee wrote:
> On 10/28/24 12:47 PM, Taylor Blau wrote:
> > On Mon, Oct 28, 2024 at 06:46:07AM +0100, Patrick Steinhardt wrote:
> > > I've flagged this internally now at GitLab so that we can provide some
> > > more data with some of the repos that are on the bigger side to check
> > > whether we can confirm the findings and to prioritize its review.
> >
> > I suspect that you'll end up measuring no change assuming that you
> > (AFAIK) use bitmaps and (I imagine) delta islands in your production
> > configuration? This series is not compatible with either of those
> > features to my knowledge.
> You are correct that this is not compatible with those features as-is.
> _Maybe_ there is potential to integrate them in the future, but that
> would require better understanding of whether the new compression
> mechanism valuable in enough cases (final storage size or maybe even
> in repacking time).

I think the bitmap thing is not too big of a hurdle. The .bitmap file is
the only spot we store name-hash values on-disk in the "hashcache"
extension.

Unfortunately, there is no easy way to reuse the format of the existing
hashcache extension as-is to indicate to the reader whether they are
recording traditional name-hash values, or the new --path-walk hash
values.

I suspect that you could either add a new extension for --path-walk hash
values, or add a new variant of the hashcache extension that has a flag
to indicate what kind of hash value it's recording.

Of the two, I think the latter is preferred, since it would allow us to
grow new hash functions on paths in the future without needing to add an
additional extension (only a new bit in the existing one).

> At the very least, it would be helpful if some other large repos were
> tested to see how commonly this could help client-side users. Are
> there other aspects to a repo's structure that could be important to
> how effective this approach is?

What measurements are you looking for here? I thought that you had
already done an extensive job of measuring the client-side impact of
pushing smaller packs and faster local repacks, no?

Thanks,
Taylor
