Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EDCEC5
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653821; cv=none; b=AKnkEGY4k5Eily6vEhOdS9vt2wEeGBTIKYQAvrCo2Dbe0lpqxkHPbF3KnvB8dlfxWDHOCHlsCbRg9CvnQ4sjz6XpwbtBKl9w31WMkB8h+dI6tzQLgkdWq2NdToE0HI0CitURVdSYBbNU/FKVjwEp/Nd8GAkTs9CQo9GnYvVnjKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653821; c=relaxed/simple;
	bh=lOA5QDD5oyAZEpWaZUKSiKE87DZwP2rTwt6sKLm4SDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRjPPqNqTmGky72fI7pT0rsR3vjuxP27Ov4a6ZlCGw6ZvZhf2Xk1bfiei0PJ2bxgxD5Tc+ikH2hXTLWd6iM9nly4JsJG81+PbSCTq1OCAFqyTQCFEq6l3TyXCLCRlR2uJLnCMbSEhq6p/o6U9DPvCs6psuJvd3RSM1pHsQLdTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=06BxA3zx; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="06BxA3zx"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso1751733276.2
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 09:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737653818; x=1738258618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZKucF4VGYX7JdhEz5o6Uam1uAhne3Ifq0NiCArh5fk=;
        b=06BxA3zxmd8/B5SW7dCo4YRtCHT4nVwATi/yGVkNm2Fe+kGKTF8XTWyW//4o+nwHpv
         nEnc/U1AP7pJuJD5eyURl0rGadTJ0BY/cNEduP/vLhZLal49w0ukrbdm6Wjgqcw8gDZN
         9okAUJ1vzo6mo/ue8iqd6o793toqyrDRaHL2M/FRpBxgoAyAYR0/BFDb/xljP8afeTjL
         LhAqAAovCCDNfXP3siFv9gzmwvrWxnG34iF/uYZAnQAFPS4IWu4KdK+Mug5dI3WaGGdR
         o2JFu4SkmQMbi2aSkP4X5hItKfe5fP6XdZlHGMEIT//5xS8FO7skwXPC320vwX5JgJAl
         EIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737653818; x=1738258618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZKucF4VGYX7JdhEz5o6Uam1uAhne3Ifq0NiCArh5fk=;
        b=ZPpZg/urf1dFYwSJWS0X7wIouwrwFdfswk5gsYK9lbJUgmxacJZTwma20yr1O/zLMm
         H3jVDH8e8AFZs+vmu/uDja8QDwRh+h8SGXxvhJEis4XHUyT3WRZcbIZXx19OILHNnxyH
         XfOwk4OV+hHNaZlg53Z9WUqipUW1eWCKNw3bAZ9uTpqXOinmEStMvZVREzGQBTe34sYQ
         xR+1ybuVM57oxsp9V6dOSS+pMDS8Ybn46JFStqTTKxpnRMw/IyXVDy3Q/x8ZrrPGnP7p
         ew+4lRWQj9lWOy+K8Y1TdJNenwcZXeUyZaYC0aimmIowH7L/MCGjThqGhVJGpp07Lbob
         347Q==
X-Gm-Message-State: AOJu0YzfOaejeVEUWg/xyZEXuhY9LZZEQJqsKNEknLOwt0S/0/uN0SPf
	wOZOPeoAPAWoYAdraHDeYHu45ouWY8wj44bEREl6jX0aBfvxEdbRqJIaCHLi0s44s/fRWagJF7B
	NIxY=
X-Gm-Gg: ASbGncv4u4dSqJiPZk1VP7XOWCLyyTe8Ie2MHo+3qUPugQFlymVjyJBAeqJZKhGYQ/w
	moQns5zEdDEy2FOToLbNdtPXSaJFcR8pivM27z5wvQNbtLThkGwNa6JLF+myE/42xflIAHvXNGq
	4rQ1aCzSVWlk+aUK+mSQyiwTUdgNv/x4lXnuUatv5Xx6EUM21v6sOc1fTlp17k7zC2WzZvvgRRh
	Dv0lTAOiRjSTrKeXkzbcAbseT6fA6ChCJENA0I27JNCFW/8TpmyHlbfU7+jchtS/IwUur9eUjqK
	IgXk5fJB4vlsD348eZGqJkLJg2FStOekUid044jAboEwvd9f46LO
X-Google-Smtp-Source: AGHT+IFP9cS3wnPjCnt/D8tOtLpznxeD8Dvwt+ZUJDtC803Dyx/+EWWzlL2A5KpBQEgk2p4mnOWYSg==
X-Received: by 2002:a05:690c:6e07:b0:6ef:6a71:aa55 with SMTP id 00721157ae682-6f6eb51a3b4mr218033537b3.0.1737653818365;
        Thu, 23 Jan 2025 09:36:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f7578a23d4sm487557b3.54.2025.01.23.09.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:36:58 -0800 (PST)
Date: Thu, 23 Jan 2025 12:36:56 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
Message-ID: <Z5J+ONavA9XUTPn1@nand.local>
References: <xmqqbjvyv510.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjvyv510.fsf@gitster.g>

On Wed, Jan 22, 2025 at 02:48:43PM -0800, Junio C Hamano wrote:
> * tb/unsafe-hash-cleanup (2025-01-17) 8 commits
>  - hash.h: drop unsafe_ function variants
>  - csum-file: introduce hashfile_checkpoint_init()
>  - t/helper/test-hash.c: use unsafe_hash_algo()
>  - csum-file.c: use unsafe_hash_algo()
>  - hash.h: introduce `unsafe_hash_algo()`
>  - csum-file.c: extract algop from hashfile_checksum_valid()
>  - csum-file: store the hash algorithm as a struct field
>  - t/helper/test-tool: implement sha1-unsafe helper
>
>  The API around choosing to use unsafe variant of SHA-1
>  implementation has been updated in an attempt to make it harder to
>  abuse.
>
>  Expecting a hopefully small and final reroll.
>  cf. <20250118124343.GA3828177@coredump.intra.peff.net>
>  source: <cover.1737151386.git.me@ttaylorr.com>

Thanks for the nudge. I sent out a very small reroll of this series as
<cover.1737653640.git.me@ttaylorr.com>.

> * tb/incremental-midx-part-2 (2024-11-20) 15 commits
>  - midx: implement writing incremental MIDX bitmaps
>  - pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
>  - pack-bitmap.c: keep track of each layer's type bitmaps
>  - ewah: implement `struct ewah_or_iterator`
>  - pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
>  - pack-bitmap.c: compute disk-usage with incremental MIDXs
>  - pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
>  - pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
>  - pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
>  - pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
>  - pack-bitmap.c: open and store incremental bitmap layers
>  - pack-revindex: prepare for incremental MIDX bitmaps
>  - Documentation: describe incremental MIDX bitmaps
>  - Merge branch 'tb/pseudo-merge-bitmap-fixes' into tb/incremental-midx-part-2
>  - Merge branch 'tb/incremental-midx-part-1' into tb/incremental-midx-part-2
>
>  Incrementally updating multi-pack index files.
>
>  Needs review.
>  source: <cover.1732054032.git.me@ttaylorr.com>

Yeah, I would really like to see this one progress. I'll gently nudge
Peff (CC'd) as a potential reviewer here.

> * ds/name-hash-tweaks (2024-12-20) 8 commits
>  - pack-objects: add third name hash version
>  - pack-objects: prevent name hash version change
>  - test-tool: add helper for name-hash values
>  - p5313: add size comparison test
>  - pack-objects: add GIT_TEST_NAME_HASH_VERSION
>  - repack: add --name-hash-version option
>  - pack-objects: add --name-hash-version option
>  - pack-objects: create new name-hash function version
>
>  "git pack-objects" and its wrapper "git repack" learned an option
>  to use an alternative path-hash function to improve delta-base
>  selection to produce a packfile with deeper history than window
>  size.
>
>  Will merge to 'next'.
>  (microhalt) <Z5E5KdbwHE7fmiJx@nand.local>
>  source: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>

Hmm. I think that the first seven patches are fine as-is (I had some
minor comments on them, but as I noted they are mostly cosmetic and
don't require a reroll IMHO). But I think it would be worth having a
more thorough discussion about the last patch, or at least to hear from
Stolee before proceeding.

Thanks,
Taylor
