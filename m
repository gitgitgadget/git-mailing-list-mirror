Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8328B1E3DF4
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124122; cv=none; b=rWVeLwNQrmz2x0brU5ttaRG2bzl42DeD+9X7DY4W9zNskUdNt0dr3ysjF7Z7Pq2STH0jYj26Hta6PxumS7rtRTIxfk27mWGFFjozGb68jtvNMGVVb3+WE6qHpW+byLnlD2sc/mA4iGMTvgoCDgWgj5wZjhBzKr7c5jiGucwn940=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124122; c=relaxed/simple;
	bh=so2C3CY2xqRfeBWgAFyOJC24UpYvuqOQv59c2geObEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5H9WoD8E5Z9W5c/lwRd/MvMXmG75m9aNmNarIZ5iRzya9ybL/jJONWuAGyiw6mo9CKwMY+SnBBUIgcmke1/2Vh2AY0rm9zzyeHn5rzND4job/MXbt3be8VJoVbss9Am1/ZXScXeLc4uj1OgkGt8onYGDtu6eoXQx70lXVuEboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=nTvhilmR; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nTvhilmR"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so5108544276.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 13:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741124119; x=1741728919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/2ql4Z7ZqH9tJiYtk589hM2EU/Q3gxsUSmk2cbX+3w=;
        b=nTvhilmR3MfuUDb8kiXzew/yTcFmpz4PUAPKxj6b9wNQZZSKKchk6aZtZSYtyXQbtG
         IBi1ghVd/CnEx/Qud/gZqNvtO7AJw+fDs6aUIS6NWHzTTwykaucPzo/m01ta7nAE748f
         VnT36i70WaMpQGB4agRhY73RQ7ddz+3YkhpivwZpiVp21fN4xGyqd4nCjhuX3tTCAW4H
         NjjiDWB3owWjj46BsUkAI58rPRnWCiP2otZqyz+tDVFHgmKoK7ReK9d4Wd5k4fqszPID
         iEVErR1OR7hxo9Pbrh6TYsfot+v546xH7Wl1LLiTDXIV9AWtCk7/awrfXk/N6K5t4QaC
         1EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741124119; x=1741728919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/2ql4Z7ZqH9tJiYtk589hM2EU/Q3gxsUSmk2cbX+3w=;
        b=p7kenv05t1aBU6ccF6E0sCW+1d8ng97plOZ3ORA15FvuO792DcH8UEmNwm22MGN/ZR
         fM6jT+aitZCl0/2h7fzIcwgGYW8ncw8VjmV8aNXlsNgyIxtJsCM6FtljcN7qfA2sx4AY
         iHkYhQfzG0X/3/N+xBk33+6zJuEuRpzjXfMoA89mIMF2qOUVELl2rMr+xUL1vGtieBeB
         /nvJMnjYg790c4Y/Rxs4BVV8DbHv0bYClTuAlr16vF+kyfx+cvOUjKphBwj4lJBswzgu
         fWe4Xelb4PLh7euFzq4UBYTMx0mHTnbXjQtkewLuj6Xno7IGsrOY89SdLFfv4JWG4KUm
         RAvg==
X-Gm-Message-State: AOJu0YzZt7wOUUfOu1KgOPolB77bmSC0nD12CUnWQ9BVVZkuu+mFw6o7
	n4bN0DQ/YuPeVYdjMn7xGBW92h9rsVicK4T5k2gtBSDqNP/o4P15wz6iCau/yMaH3rU1aomZxnG
	u
X-Gm-Gg: ASbGncuWjdjGSEWjKpjeCBioH+GgfqCruo49LiN4XavEXnwQxf6m/A4iFWtQB1QticT
	dPP223C3PHynCLhXfgAAaUSoWtcrwYjpKPZ1ROgcuqSN21bIG7HT7PZz6TNbw4YLOIrxVsmeYc2
	xnwdTNp+dsURviBWj3wHzl85pAFS7j6g5OV5S/rRi7Zk/EUq0qh0MorZOgZEbZl8rC3ZDkIQ7Qo
	7QjODyDz4EprV4HCfIyH70DZx+hbp2+vg4/PHXrDAWmwNuFgiRsLTsymWlCvF4MmlrGXJtSuILv
	amScMRGmTKt+XScvlpLU4ucc3UptGqIPIbrh0e1UQTBrz2c4rl/h8y3FQaeuGPe3setinRdMxqM
	xmtMc5rdImtE3Z73b
X-Google-Smtp-Source: AGHT+IE2we1c8O+eKg3LfDMcDvqMwXwE2GS5vwzLo4U6ovpxlA3IOS6zqUMejCTT9jdJNxXAzmRWRA==
X-Received: by 2002:a05:6902:1aca:b0:e5b:12b4:d67 with SMTP id 3f1490d57ef6-e611e1ad403mr1086127276.11.1741124119231;
        Tue, 04 Mar 2025 13:35:19 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e60a3ab0251sm3893640276.49.2025.03.04.13.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 13:35:18 -0800 (PST)
Date: Tue, 4 Mar 2025 16:35:17 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/2] pack-objects: freshen objects with multi-cruft packs
Message-ID: <cover.1741124116.git.me@ttaylorr.com>
References: <cover.1740680964.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1740680964.git.me@ttaylorr.com>

This is a minor reroll of my series to fix a bug in freshening objects
with multiple cruft packs.

Since last time the only updates to the series are textual changes to
the commit message, so everything functionally should be working as it
was before.

As usual, there is a range-diff showing as much below, and the original
cover letter is as follows:

---

This short series contains a fix for a bug I noticed while rolling out
multi-cruft packs (via 'git repack --max-cruft-size') within GitHub's
infrastructure.

The series is structured as follows:

 - The first patch simplifies how 'repack' aggregates cruft packs
   together when their size is below the '--max-cruft-size' or
   '--max-pack-size' threshold. This simplification changes behavior
   slightly, but not in a meaningful way. It occurred to me while
   writing the second patch.

 - The second patch describes and fixes the main bug. The gist here is
   that objects which are (a) unreachable, (b) exist in a cruft pack
   being retained, and (c) were freshened to have a more recent mtime
   than any existing cruft copy are unable to be freshened.

The fix pursued in the second patch changes the rules around when we
want to retain an object via builtin/pack-objects.c::want_found_object()
when at least one cruft pack will survive the repack.

Previously the rule was to discard any object which appears in any
surviving pack, regardless of mtime. The rule now is to only discard an
object if it appears in either (a) a non-cruft pack which will survive
the repack, or (b) a cruft pack whose mtime for that object is older
than the one we are trying to pack.

I think that this is the right behavior, but admittedly putting this
series together hurt my brain trying to think through all of the cases.
I'm fairly confident in the testing here as I remember it being fairly
exhaustive of all interesting cases. But I'd appreciate a sanity check
from others that they too are convinced this is the right approach.

Thanks in advance for your review!

Taylor Blau (2):
  builtin/repack.c: simplify cruft pack aggregation
  builtin/pack-objects.c: freshen objects from existing cruft packs

 builtin/pack-objects.c  | 118 ++++++++++++++++++++++++++++++++++------
 builtin/repack.c        |  38 +------------
 packfile.c              |   3 +-
 packfile.h              |   2 +
 t/t7704-repack-cruft.sh | 105 +++++++++++++++++++++--------------
 5 files changed, 170 insertions(+), 96 deletions(-)

Range-diff against v1:
1:  8564f982597 ! 1:  63ea9d4d00e builtin/repack.c: simplify cruft pack aggregation
    @@ Commit message
         would get combined together until the sum of their sizes was no larger
         than the given max pack size.
     
    -    There is a much simpler way to achieve this, however, which is to simply
    -    combine *all* cruft packs which are smaller than the threshold,
    +    There is a much simpler way to combine cruft packs, however, which is to
    +    simply combine *all* cruft packs which are smaller than the threshold,
         regardless of what their sum is. With '--max-pack-size', 'pack-objects'
         will split out the resulting pack into individual pack(s) if necessary
         to ensure that the written pack(s) are each no larger than the provided
2:  c0c926adde2 ! 2:  7ba9054701b builtin/pack-objects.c: freshen objects from existing cruft packs
    @@ Commit message
         only be modified in a pruning GC, or if the threshold itself is
         adjusted.
     
    -    However, this process breaks down when we attempt to freshen an object
    -    packed in an earlier cruft pack that is larger than the threshold and
    -    thus will survive the repack.
    +    Prior to this patch, however, this process breaks down when we attempt
    +    to freshen an object packed in an earlier cruft pack, and that cruft
    +    pack is larger than the threshold and thus will survive the repack.
     
         When this is the case, it is impossible to freshen objects in cruft
    -    pack(s) which are larger than the threshold. This is because we avoid
    -    writing them in the new cruft pack entirely, for a couple of reasons.
    +    pack(s) when those cruft packs are larger than the threshold. This is
    +    because we would avoid writing them in the new cruft pack entirely, for
    +    a couple of reasons.
     
          1. When enumerating packed objects via 'add_objects_in_unpacked_packs()'
             we pass the SKIP_IN_CORE_KEPT_PACKS, which is used to avoid looping
    @@ Commit message
          - exists in a non-cruft pack that we are retaining, regardless of that
            pack's mtime, or
     
    -     - exists in a cruft pack with an mtime more recent than the copy we are
    -       debating whether or not to pack, in which case freshening would be
    -       redundant.
    +     - exists in a cruft pack with an mtime at least as recent as the copy
    +       we are debating whether or not to pack, in which case freshening
    +       would be redundant.
     
         To do this, keep track of whether or not we have any cruft packs in our
         in-core kept list with a new 'ignore_packed_keep_in_core_has_cruft'
         flag. When we end up in this new special case, we replace a call to
    -    'has_object_kept_pack()' to 'want_cruft_object_mtime()', and only
    -    reject objects when we have a copy in an existing cruft pack with a more
    -    recent mtime (in which case "freshening" would be redundant).
    +    'has_object_kept_pack()' to 'want_cruft_object_mtime()', and only reject
    +    objects when we have a copy in an existing cruft pack with at least as
    +    recent an mtime as our candidate (in which case "freshening" would be
    +    redundant).
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ t/t7704-repack-cruft.sh: test_expect_success '--max-cruft-size with freshened ob
     +
     +		git repack --cruft -d &&
     +
    -+		# Make a packed copy of object $foo with a more recent
    -+		# mtime.
    ++		# Make an identical copy of foo stored in a pack with a more
    ++		# recent mtime.
     +		foo="$(generate_random_blob foo $((2*1024*1024)))" &&
     +		foo_pack="$(echo "$foo" | git pack-objects $packdir/pack)" &&
     +		test-tool chmtime --get -100 \
     +			"$packdir/pack-$foo_pack.pack" >foo.new &&
     +		git prune-packed &&
     +
    -+		# Make a loose copy of object $bar with a more recent
    -+		# mtime.
    ++		# Make a loose copy of bar, also with a more recent mtime.
     +		bar="$(generate_random_blob bar $((2*1024*1024)))" &&
     +		test-tool chmtime --get -100 \
     +			"$objdir/$(test_oid_to_path "$bar")" >bar.new &&

base-commit: 08bdfd453584e489d5a551aecbdcb77584e1b958
-- 
2.49.0.rc0.57.gdb91954e186.dirty
