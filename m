Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DDD1CC17A
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224930; cv=none; b=bXTft1DbI10qTkN//8L+QN18niP8x4P8C0EhArkXnjtUD0eDGV2aI9CNMpwQR6wFVLuySmCMUIYXAC1S0qi+E1GsbmDNeWk+sdNDycZlJUD5zmnAUaBvHaRQMQw7KMt2umbZyUXmX/o4RBw+jOKicvjKVvVKlNjX5OefPwJ2p0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224930; c=relaxed/simple;
	bh=niQpJ0CWRMVEqyiz1I2vyCbcA147omaAaC2FzDZFCiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEgY8EnSDAmtjxO5/bxtVZO2nLnP1YYNlhILQBQFcyMa+ZmE0geqG0DjWx2RP6GemqnKbcIqVqq17n4CITrl6ddqalaK+F4g7nz8vFYUiFgb/QtNQELOHBa0SxJ6oryvYBqUbBoYFeDePxrYxsVXCKAgO0EHQTiJ7wyz5zlWUvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wek+eU8G; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wek+eU8G"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e5a5a59094so49869337b3.3
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730224927; x=1730829727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NbXUNFMm73ttnHlynNv4SwLGxjssGSLPUcPmCVeeHPs=;
        b=wek+eU8GPC7ak11QS8cYruvU7icThfVCyISi31EXNgsf2/04i3palQes7iYCvVookD
         Nfzxv6YFO5C1kEj6xmUOlCJJZbTeVEdzvt0IN0apQYoVF3odmnuxOPOJZwJVGbgOiEN9
         IUb23xaXD+E2gQ5It1gvVTG3+vU/Fk7LBjcdpfqyfh2olj9MkzonlZqvETw/XUPZndfI
         dvVzoCKdquVHxYotems7LA9DpoO9ShsUHw+Mfqp4Yy+Q3rYmDFhv57mKjjCXRMS2gGAT
         9Gnc7P5Iq3vd0vwjiXSOhraHfpiAM5gMiWzcy/ke8tzA97jVyDf0rSnrOQIT6EQ0fM/Z
         9oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730224927; x=1730829727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbXUNFMm73ttnHlynNv4SwLGxjssGSLPUcPmCVeeHPs=;
        b=vc3EfGQSFSxh69UV4656YzvSZCoLkUbKKVLtZqncEximDNQEGxeAHdTxdbCrXBuIGP
         aHPeE9qVGlsdC7GA6sGEbuP7zBA4v6BnUqAAuUxH17xbZ5SZjfvVfkJutAH6lkhJJtYA
         D7FvRBLvX2pEdOyiNuZ1HX3hZsrF4aZC1cfSgSqJaJdJlUG7HOxEEMXBSaJA7Fr5MTsh
         8dch8tiRSD+52tAj2u8ShEeKhEvmKrucURfCVD7OVVJdtRKjVIuqwuPL/jggwXQVz9/W
         zy/LghYPYrb1J6WAhN/OPJ3LThwGEYBlAsevXWp1fhZrwMKO+oqPPAheM3+/1oMjVZbW
         4SfA==
X-Forwarded-Encrypted: i=1; AJvYcCXFHDPW+J+N16AOxYuA01NszeXYh5+5cwofd06rBCDTRGHIZOK/+XuM8WooTjpRSkEKYVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNmSQrx8u2SkCpg8LedbramHjz/lJCqk61aKeXWsFa3R1x+Ox
	jfQNSp5vsRyFpKlq3DBJFOyCwjB7harN6VhAkJZUVINVaiGY8DPzps1HEtDOK4U=
X-Google-Smtp-Source: AGHT+IEprEAdAO2FLQ/V0JwquEP4Afbw+XmPS8HImF3b/2FlWGs3kbmjBu9+OSCDuZlnPDekVmEySg==
X-Received: by 2002:a05:690c:fcb:b0:6de:2ae:8138 with SMTP id 00721157ae682-6e9d891bcdamr110758367b3.5.1730224927079;
        Tue, 29 Oct 2024 11:02:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c18381sm20602817b3.58.2024.10.29.11.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 11:02:06 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:02:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH v2 00/17] pack-objects: add --path-walk option for better
 deltas
Message-ID: <ZyEjHOcf9A4eMSFG@nand.local>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
 <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
 <ZxbLFLDgCm6wLmB9@nand.local>
 <Zx8lHzDyqyBpzrAE@pks.im>
 <Zx/AGrGTN2mQZqGs@nand.local>
 <00d80855-0530-4384-8d2f-5370ace9c0d5@gmail.com>
 <Zx/I+9icWGsRz11x@nand.local>
 <85d3c75c-d7c2-498f-8afe-34c49337ba37@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85d3c75c-d7c2-498f-8afe-34c49337ba37@gmail.com>

On Mon, Oct 28, 2024 at 03:46:11PM -0400, Derrick Stolee wrote:
> On 10/28/24 1:25 PM, Taylor Blau wrote:
> > On Mon, Oct 28, 2024 at 01:13:15PM -0400, Derrick Stolee wrote:
>
> > > You are correct that this is not compatible with those features as-is.
> > > _Maybe_ there is potential to integrate them in the future, but that
> > > would require better understanding of whether the new compression
> > > mechanism valuable in enough cases (final storage size or maybe even
> > > in repacking time).
> >
> > I think the bitmap thing is not too big of a hurdle. The .bitmap file is
> > the only spot we store name-hash values on-disk in the "hashcache"
> > extension.
> >
> > Unfortunately, there is no easy way to reuse the format of the existing
> > hashcache extension as-is to indicate to the reader whether they are
> > recording traditional name-hash values, or the new --path-walk hash
> > values.
>
> The --path-walk option does not mess with the name-hash. You're thinking
> of the --full-name-hash feature [1] that was pulled out due to a lack of
> interest (and better results with --path-walk).
>
> [1] https://lore.kernel.org/git/pull.1785.git.1725890210.gitgitgadget@gmail.com/

Ah, gotcha. Thanks for clarifying.

What is the incompatibility between the two, then? Is it just that
bitmaps give us the objects in pack- or pseudo-pack order, and we don't
have a way to permute that back into the order that --path-walk would
give us?

If so, a couple of thoughts:

  - You could consider storing the path information for each blob and
    tree object in the bitmap using a trie-like structure. This would
    give you enough information to reconstruct the path-walk order (I
    think) at read-time, but at significant cost in terms of the on-disk
    size of the .bitmap.

  - Alternatively, if you construct the bitmap from a pack or packs that
    were generated in path-walk order, then you could store a
    permutation between pack order and path-walk order in the bitmap
    itself.

  - Alternatively still: if the actual pack *order* were dictated solely
    by path-walk, then neither of these would be necessary.

That all said, I'm still not sure that there is a compatibility blocker
here. Is the goal is to ensure that packs generated with
--use-bitmap-index are still compact in the same way that they would be
with your new --path-walk option?

If so, I think matching the object order in a pack to the path walk
order would achieve that goal, since the chunks that you end up reusing
verbatim as a result of pack-reuse driven by the bitmap would already be
delta-ified according to the --path-walk rules, so the resulting pack
would appear similarly.

OTOH, the order in which we pack objects is extremely important to
performance as you no doubt are aware of. So changing that order to more
closely match the --path-walk option should be done with great care.

Anyway. All of that is to say that I want to better understand what does
and doesn't work together between bitmaps and path-walk. Given my
current understanding, it seems there are a couple of approaches to
unifying these two things together, so it would be nice to be able to
do so if possible.

Thanks,
Taylor
