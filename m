Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA0938AC7B
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106970; cv=none; b=SekWPLwivlToGRNT0aZMSntwj0OT3oywGoixtYZemCA7W/O3AKI2VGr/Qlj281qdf0evQr2tY0fy5NKuQS1fCoLdY51Tvtvz9lemsvWaYVsT94bo7TlsTCN8j53K5UBEAogfcPR5v/s3Y8IUezM0/5Bu/pLCL4fP4ReuV/zHrDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106970; c=relaxed/simple;
	bh=fFhAAAkyAcnw9UnJFEIm+uOVecJ16fKwz4ypn35Ch5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzE7q1zgD9/22nQAUoCTugxQG6HZOY4dBySIQwXJLx8n1OiCEgCIlSWiv7P4kdZy70VLsCOyEap7dv0fOO6c/iPebUr0hSAwowtmYHehrsjP/IGdff5K3MCXbGGAZ5SgMNG8kSZKJqSWGYpaWz1QPItcWWacB8hEpirDg86HlE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXIwcliu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXIwcliu"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f1bfc9b8fso1163442b3a.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 12:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776106969; x=1776711769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m8iP53GuKR3/6FnrwRBTTwTzpqolp51t6+AIh3m4EqA=;
        b=CXIwcliuU0/W5BoLXQAttgjadggyOcwGPZNPoUJlaUjiFkZ2wk1IPO0aVD77Kz/Dt3
         xYEgBJGPtfu8S+j9D3jtwUKDq5QYGkFAI/ck60mPVKnTpNZpMW8Pj3GTDIHnIK8yojdL
         BhjmaQyHI4f/jDrIK1w9PNIyK2ZdVG1UxzZBzQikS9WDP9Jhr6Q7OPrRqnQQFNNS3Fx4
         jH5xZySn/wv6h5GoF1bkBD2kba0wQRVWFYfKJuMhOeWKrtDUOI7NS+OHVgseH05ybnAN
         BPFdVhIi+gWzGYLBlICUBNhp/y5/S2Kf4nTOLuEZ7zUE0KTV1TQ1XO2RAUj50x/Xcnru
         45GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776106969; x=1776711769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8iP53GuKR3/6FnrwRBTTwTzpqolp51t6+AIh3m4EqA=;
        b=N/NT8FPCqFP1gD7QYifN6tVq1cMy+LPsweH7LrTJnRUThZEaEH9kPfZBWuQ/lVeac9
         NRQbtcCcbEiSUpfBoB+kBsoNs3B5iIFIZdpy+11A+rG6tgx6wh33HHVxpriWfLsVl50W
         LvK9ZS0/9zw79EOfYEs1GpgM4TLPiV1TEAklRJF/w94JQgmnyJgdWhIXQ4+cGOEODDiC
         Xq6oq7lj4nsq9tPs4K07Nq2rqIf1XmTGV0+Q7ZPKLnrjgFuqG33anCMKoxRP1bD7V+Xt
         nLJQdUHF9Vx8GYgCk/tCnmlktyms5+WnR/Wd/yGhSaB/P6izp4LYozRCjvf8yKAc8Pt4
         BtPg==
X-Forwarded-Encrypted: i=1; AFNElJ93rhaYUqnZubMSiwlSEgBNjOMtgbVMIDWg14bZJXNOZFM4HRJQxVuZqut8hBHt3AYaayE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaIN51YTjDP1q+ga9k+9HzZVNNnbSpq6zHsl13WYu5PfgvBdwC
	1lEPjblXBE8REJhEOUTU9Cga8oCo1t2hJPyZ8+6nwYieRKGVV/yd106A
X-Gm-Gg: AeBDieuWWZMhKYX+wqBRKskw5MPFV3fUz63BZ2n7lohDB7TpAslC7p4cBU6FzDmgHhC
	c8fD6nb/L62wjRbdl6ink97cEMOfSFTulK2INVpHF9vtM5CyKW2UHTC0ygWiBCqdrMSPMjAQFMg
	RRao07h3UUgHfhAWxGU1T6elaKq16HnfI+w8Gy5KFqhYyIfyGVwEOWUUMQJd6WkO1cbylGikifF
	+4KMVCY/gh1SnclaTMQvDvh0B33+MjWGrO4GcipxVL/0oLoR1UBXgw7q4s6oQ56Q7okteUNl+y9
	J8LaiPRvQ+itCBau/pAtz90wvhWc7Eou52ZaKbadiAsZa45iALOTDiYksvkyH1VRtZJ08nJRimJ
	Pc6Bl5jmHm2cDxbcxafJ7nc0/5K4cj0pcDa13LmhgqLmD3rroUdl5RVYocnFJQK8eQ3nqTat1z1
	AehtLlgkw5ROgCA29IBwSpnqF3RDE8u2pN7w==
X-Received: by 2002:a05:6a00:a241:b0:82c:2480:4e95 with SMTP id d2e1a72fcca58-82f0c302aa3mr14265410b3a.33.1776106968668;
        Mon, 13 Apr 2026 12:02:48 -0700 (PDT)
Received: from localhost ([42.114.219.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30e5f1sm12836301b3a.11.2026.04.13.12.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:02:48 -0700 (PDT)
Date: Tue, 14 Apr 2026 02:02:43 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org
Subject: Re: [GSoC PATCH v2] backfill: add --[no-]progress option
Message-ID: <wsbnw3am5fq6hpjwmmbguo2c3mnv4qkr3hh7apawch7smns6zx@rxegeuugbnhg>
References: <20260412193659.26288-1-viking4@gmail.com>
 <d2cf741c-a381-42a6-9d26-e38481696adb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2cf741c-a381-42a6-9d26-e38481696adb@gmail.com>

On Sun, Apr 12, 2026 at 03:46:17PM -0400, Derrick Stolee wrote:
> On 4/12/26 3:36 PM, Trieu Huynh wrote:
> > From: Trieu Huynh <vikingtc4@gmail.com>
> > 
> > 'git backfill' does not show an overall progress bar across
> > batches, giving no cross-batch feedback during potentially
> > long-running operations on large repositories.  By contrast,
> > 'git fetch', 'git gc', and 'git index-pack' all support
> > --[no-]progress.
> > 
> > Add a --[no-]progress option that tracks the total number of
> > missing blobs downloaded across all batches, defaulting to
> > showing progress when stderr is a terminal (matching the
> > behaviour of 'git fetch').
> > 
> > Add tests to verify that:
> >   - progress is shown by default on a TTY
> >   - --progress forces output regardless of TTY
> >   - --no-progress suppresses output
> 
> I think the tests do show an improvement, but we're missing
> the interaction with the underlying fetch's progress
> indicators. I don't see any mention of how your backfill
> progress indicators will work with or against the fetch's
> progress from the remote and index-pack steps.
Actually, I was missing adding it in the changelog, see below:
As-is:
remote: Enumerating objects: 7391, done.
remote: Counting objects: 100% (293/293), done.
remote: Compressing objects: 100% (162/162), done.
remote: Total 7391 (delta 249), reused 131 (delta 131), pack-reused 7098 (from 1)
Receiving objects: 100% (7391/7391), 4.09 MiB | 10.20 MiB/s, done.
Resolving deltas: 100% (5617/5617), done.

To-be:
remote: Enumerating objects: 7391, done.
remote: Counting objects: 100% (293/293), done.
remote: Compressing objects: 100% (162/162), done.
remote: Total 7391 (delta 249), reused 131 (delta 131), pack-reused 7098 (from 1)
Receiving objects: 100% (7391/7391), 4.09 MiB | 6.46 MiB/s, done.
Resolving deltas: 100% (5618/5618), done.
Downloading missing blobs: 157594, done.
> 
> Further, if a user supplies 'git backfill --no-progress'
> then they are probably saying "I don't want any progress
> indicators" and that would signal also that the fetch should
> be quiet. This is perhaps the key detail that makes your
> current version unable to move forward. It creates an
> implication that it doesn't follow-through on.
Thank you for the point.
You are right that the current patch does not address the interaction
between the backfill progress bar and the underlying fetch's own output
(remote counting/compressing objects, index-pack, etc.). Leaving both
active at the same time would produce interleaved and confusing output,
which is worse than no progress at all.
> 
> One way to go about this is to hide the 'git fetch' output
> entirely by passing '--quiet' unconditionally from the
> backfill command. But this may also be too much for users
> who want to watch the download statistics from the remote.
> 
> Perhaps a way to have a robust set that allows all things
> to interact is to do the following:
> 
> 1. Add a --[no-]verbose option that is off by default. The
>    implementation sends the --quiet flag to 'git fetch' if
>    --verbose isn't provided from the user. This reduces the
>    noise for the default user.
> 
> 2. Add a --[no-]progress option as you've provided here.
Make sense to me, will change to implement that way in v3.
> 
> The complexity at the end is about what happens when the
> user provides both --verbose and --progress, which is the
> situation that this patch is currently in. How do the
> progress indicators mingle with the verbose fetch output?
IIUC, the fetch output for each batch completes before the progress
bar updates, so they do not actually interleave. The
"Downloading missing blobs" counter updates in place via carriage return
during the run, display until it's done partially, and only prints the
final "done." line at the end, for example:

  remote: Enumerating objects: 50106, done.
  remote: Counting objects: 100% (780/780), done.
  ...
  Receiving objects: 100% (50106/50106), done.
  remote: Enumerating objects: 50096, done.
  ...
  Receiving objects: 100% (50096/50096), done.
  Downloading missing blobs: 157594, done.

So --verbose and --progress together produce readable output without
any special handling needed.
Does that direction sound reasonable to you?
> 
> Thanks,
> -Stolee
> 
