Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682921CF5F8
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489012; cv=none; b=pWqqxrmAt7bqj7pVpIexvECqfnXhepnGHyBarYy8ZWz165z9fFw3zJQ2PdRVutwPG/Yg90SoeUokiROt04KWrYrattuQ5hDfX7dN++HBaFzMgnKmOO1acS39VXcClXDTih4zmORdRZEqY58Zg4ul0i7sPq//xrSgNt0k3HZZ3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489012; c=relaxed/simple;
	bh=vEXoc3haJB+a0kj4Qz/63H9ZV2Q7sZqZmsZrQaLoWjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIZz9a1SebXO+TpVUfT9cdSqXU4NNxryd6BuLWHBFc0QTjUjef/dnW/uLaAJ4a4frwejsNuOUCMuiIFRE7GOJ23wJIyyO22vyde7+5YLsVqQDTADVZeQ7/oAjb5okAY+rovqrAa95YWxOux/7yaKPyCbgSMdkYI3X2TnLO1vGgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CDK+D8by; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CDK+D8by"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e390d9ad1dso19970887b3.3
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 12:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730489009; x=1731093809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4VmSSkP1Nk7rB4X4DfjYEhyQUTQULnByqe9CBVRCcXQ=;
        b=CDK+D8byWPc6yVswwiHCT2A9jP7z9IYgtBgytTVFYidnV480v+Wx6I5mf08dmNPPCr
         qyLHQxEbZwnyDD4PNaJUSzZDfkwNPk7mczkJo43oNubdCNUAiSHkpyqUwvwaaw2jnzd0
         46cvAZNzJ3GHIkxubNUnYb73autqJGnhabnxgwPW1d9xXx2BfjzNVvyS9SqmSayapx5q
         bLsR1yhgifK8sXjtbydDvSpJhIPmgX/52c60aZej0anqyX8BEehNNMmmrWORloxJtlTO
         n6oQIlQN0Z3ggKaWOnQByHP718hZYkdK4l4WtPMydVLNg0mlDMDkV2j00ECpxF3DIEzM
         Yo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489009; x=1731093809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VmSSkP1Nk7rB4X4DfjYEhyQUTQULnByqe9CBVRCcXQ=;
        b=KuZ+dwZ1zWApTy5CvgSWMd1G1iqtQqe4l0OO7x/jExVHNR6iqytnmAw0WeDXqVd722
         oI4pMn7erEC9y84N+MgTrH0WsbRGmmo4EvI4pk/pXIYNfGJAfVxzqz6oe0+vL2SPQ99l
         IvECpRHa49tviOjifzhMD89ujZfm8npb4h47ZAXTECACfxTAbqbtckHW1gFy6vUHYmaz
         BZoXbcC7Xfr1AhJHNzTdu6ecsmP2eAVCzceZVC91qapHTERephIFd0KK7u3bkj5Zi2qM
         U4dR8+Ca4OAJIviscyKzoCaJlVEEPmRhBNDBV6+bPLo85ymzBcHBIBS5YRhUSHOCgHvw
         n1ew==
X-Gm-Message-State: AOJu0YyzVTjbe64aVLnXjy5iLDYsuyMtE3FKZIgOJfOcosjc5phqSYx0
	dFR7A9tL85NHhS4NWSV42c9E8p2Xu35ARJPXaLSusXJ7E9wRwQTr/eg4ePPxLT0=
X-Google-Smtp-Source: AGHT+IEXqxvusToE5qj+PC/9YKVl6LJ6yyVFxaAyECjod3hUDuNdVXTRxR88ImgYTJKKnmPzxTAJYg==
X-Received: by 2002:a0d:c603:0:b0:6ea:7950:e75 with SMTP id 00721157ae682-6ea79500fbamr13613807b3.24.1730489009267;
        Fri, 01 Nov 2024 12:23:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea557be7c9sm7964857b3.0.2024.11.01.12.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 12:23:28 -0700 (PDT)
Date: Fri, 1 Nov 2024 15:23:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
	jonathantanmy@google.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/6] PATH WALK I: The path-walk API
Message-ID: <ZyUqr/wb5K4Og9j9@nand.local>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1818.git.1730356023.gitgitgadget@gmail.com>

Hi Stolee,

On Thu, Oct 31, 2024 at 06:26:57AM +0000, Derrick Stolee via GitGitGadget wrote:
>
> Introduction and relation to prior series
> =========================================
>
> This is a new series that rerolls the initial "path-walk API" patches of my
> RFC [1] "Path-walk API and applications". This new API (in path-walk.c and
> path-walk.h) presents a new way to walk objects such that trees and blobs
> are walked in batches according to their path.
>
> This also replaces the previous version of ds/path-walk that was being
> reviewed in [2]. The consensus was that the series was too long/dense and
> could use some reduction in size. This series takes the first few patches,
> but also makes some updates (which will be described later).
>
> [1]
> https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com/
> [RFC] Path-walk API and applications
>
> [2]
> https://lore.kernel.org/git/pull.1813.v2.git.1729431810.gitgitgadget@gmail.com/
> [PATCH v2 00/17] pack-objects: add --path-walk option for better deltas

I apologize for not having a better place to start discussing a topic
which pertains to more than just this immediate patch series, but I
figure here is as good a place as any to do so.

From our earlier discussion, it seems to stand that the path-walk API
is fundamentally incompatible with reachability bitmaps and
delta-islands, making the series a non-starter in environments that
rely significantly one or both of those features. My understanding as a
result is that the path-walk API and feature are more targeted towards
improving client-side repacks and push performance, where neither of the
aforementioned two features are used quite as commonly.

I was discussing this a bit off-list with Peff (who I hope will join the
thread and share his own thoughts), but I wonder if it was a mistake to
discard your '--full-name-hash' idea (or something similar, which I'll
discuss in a bit below) from earlier.

(Repeating a few things that I am sure are obvious to you out loud so
that I can get a grasp on them for my own understanding):

It seems that the problems you've identified which result in poor repack
performance occur when you have files at the same path, but they get
poorly sorted in the delta selection window due to other paths having
the same final 16 characters, so Git doesn't see that much better delta
opportunities exist.

Your series takes into account the full name when hashing, which seems
to produce a clear win in many cases. I'm sure that there are some cases
where it presents a modest regression in pack sizes, but I think that's
fine and probably par for the course when making any changes like this,
as there is probably no easy silver bullet here that uniformly improves
all cases.

I suspect that you could go even further and intern the full path at
which each object occurs, and sort lexically by that. Just stringing
together all of the paths in linux.git only takes 3.099 MiB on my clone.
(Of course, that's unbounded in the number of objects and length of
their pathnames, but you could at least bound the latter by taking only
the last, say, 128 characters, which would be more than good enough for
the kernel, whose longest path is only 102 characters).

Some of the repositories that you've tested on I don't have easy access
to, so I wonder if either doing (a) that, or (b) using some fancier
context-sensitive hash (like SimHash or MinHash) would be beneficial.

I realize that this is taking us back to an idea you've already
presented to the list, but I think (to me, at least) the benefit and
simplicity of that approach has only become clear to me in hindsight
when seeing some alternatives. I would like to apologize for the time
you spent reworking this series back and forth to have the response be
"maybe we should have just done the first thing you suggested". Like I
said, I think to me it was really only clear in hindsight.

In any event, the major benefit to doing --full-name-hash would be that
*all* environments could benefit from the size reduction, not just those
that don't rely on certain other features.

Perhaps just --full-name-hash isn't quite as good by itself as the
--path-walk implementation that this series starts us off implementing.
So in that sense, maybe we want both, which I understand was the
original approach. I see a couple of options here:

  - We take both, because doing --path-walk on top represents a
    significant enough improvement that we are collectively OK with
    taking on more code to improve a more narrow (but common) use-case.

  - Or we decide that either the benefit isn't significant enough to
    warrant an additional and relatively complex implementation, or in
    other words that --full-name-hash by itself is good enough.

Again, I apologize for not having a clearer picture of this all to start
with, and I want to tell you specifically and sincerely that I
appreciate your patience as I wrap my head around all of this. I think
the benefit of --full-name-hash is much clearer and appealing to me now
having had both more time and seeing the series approached in a couple
of different ways. Let me know what you think.

Thanks,
Taylor
