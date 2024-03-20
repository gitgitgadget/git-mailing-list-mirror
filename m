Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33D2CA6
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972302; cv=none; b=L8r4jydNOfnuXvpSLXADJzSr7CuddQBDrOYcLe6IGR9+164P+LjK53tjIM34W4fRMaM53LGs6ZdiYGT6eCu5EtbwU6X+rD/jbXiUo6ixefAiWDLZkCJKL+voUnA/URUbC3pM3+TgEvTNO7QyeE6bx413fLvAx1PcJM1Ro6+Lts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972302; c=relaxed/simple;
	bh=IM42pNFdQLHjXjTna8hJcDgyAhvKlZiPOvSJQbp2zMU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g629Y1JflUoEJgAD3WMLv5V+ebD1MRc74O1LGTer4cIqltAOvGPgdUOwtRNsr09p1YGakjWWo9VIB0wCdOQoGpM7IjIMtg6XacaVTVqH1sC+cMnOtzx3Y5HWFHD1ZubHRW7ZHSycwl0xAhIgfYZfJ38dwkTsGnin1Q18Z6dCSHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TnsmIche; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TnsmIche"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ddf26eba3cso194181a34.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972299; x=1711577099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkZ9gTs1puclBmKb6wJYjxLA5xg8CvPL1HJw0GmOfII=;
        b=TnsmIcheMwKNk4FsbBtn9m+oz8jSon6aM/qrAYJIFHP9O1t6LgfejAzaj2CaNUyaDn
         RSoSFRCdI7xGDEGRiccJWVudLSoPA551uCMIyZQROeWuF+dkbOEVDRV5U3CM6SeEN60b
         m3lYS1QEocIqC6/U5l1mz7S8iBSMQjD6e6ZL+r4BMxszjV51pOh6SZ8Vezz84fO6tSr+
         05iGahLXWghQy61wYgd33ZJqZewGdsAgQO42eKFMce5Yr6rKFf4+0Z1LclCm2uUuE2a+
         opYQq6Mzpoy1/kBYdW0O/r94P8Cboqc5b2ZUixQ5qhfzQXsT4ahRLZWxdWg7dOwqm+24
         tpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972299; x=1711577099;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkZ9gTs1puclBmKb6wJYjxLA5xg8CvPL1HJw0GmOfII=;
        b=LNPx4wbtqtGkNG3nobuP8zTYqHbykX7taPBXJBLws5qSzLvd2TkMjP9SvhVFk8rxpw
         S1h5m8BldBeWqzXgoSaTcbhbo0M8vmI5FGkuHRL1hCsPZwTPaU3AEDg25apglCVwjmld
         hkovnllldJN5mx6Y5Kha08beEhMxdFilnwoathAN2hKqGQVSVNexmdyhUhis5V0A9XOF
         sFu8XQ1oJxQMsAhnpjdCuhbE87LWjpaGrlYzob4KTlmlKdiJp2BeJQZBfIqWz8AT3h9I
         BdMDEOZie4qMs27BPmxGFC/ipdWX7FKweJtfWVJdoI33Qsgbd4qFWHN6Ht2waPa2TH83
         olcw==
X-Gm-Message-State: AOJu0YzL86gl8L+KcSz4Ft+k8sP1zUGPcvKP4Vo8x1k0R4Y5sNlcVYTk
	umzvY+y7DshGM7ax/LAwA0/rWY4dVJDj74O7a7mO2jw8/H+RKCrrGVJdICPgsb7Car4i8sBJWPf
	uP6w=
X-Google-Smtp-Source: AGHT+IFJx8tM4xGbK5/1LPIrvVWIluJ1E0t1fDTxFVSg7Oknn0iyTnpY5IpwEOsLOvVHr8UfbWmR/g==
X-Received: by 2002:a05:6830:10ce:b0:6e6:87f6:cd25 with SMTP id z14-20020a05683010ce00b006e687f6cd25mr13332867oto.36.1710972298792;
        Wed, 20 Mar 2024 15:04:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c21-20020ae9e215000000b00789dc8d92a3sm6467126qkc.79.2024.03.20.15.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:04:58 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:04:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/24] pack-bitmap: pseudo-merge reachability bitmaps
Message-ID: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

This series implements a new idea in the pack-bitmap machinery called
"pseudo-merge reachability bitmaps".

BACKGROUND
==========

Pseudo-merge bitmaps conceptually represent storing bitmaps for
octopus-merges covering the reference tips in a repository not selected
for bitmaps, decreasing the size (number of parents) of consecutive
merges according to an inverse power-law.

(Note that a complete description of the on-disk format can be found in
Documentation/technical/bitmap-format.txt, and the configuration
details in the "bitmapPseudoMerge" section of 'git-config(1)').

Commits are assigned into pseudo-merge group(s) according to a number of
parameters unique to each defined group, like so:

    [bitmapPseudoMerge "name"]
        pattern = "refs/*"
        decay = 100
        sampleRate = 100
        threshold = 1.week.ago
        maxMerges = 64
        stableThreshold = 1.month.ago
        stableSize = 1024

Users can create zero or more pseudo-merge groups. Pseudo-merge groups
look at reference tips matching the given pattern, and use the commits
at the tips of those (matching) references as candidates for forming the
pseudo-merge groups.

The full details are spelled out in git-config(1), but the gist is as
follows:

  - "decay" controls the decay rate between consecutive groups
    (effectively setting 'k' in the decay function 'f(n)=C*n^-k')

  - "sampleRate" controls how often (between 0 and 100, inclusive) to
    select a candidate for inclusion within a pseudo-merge group

  - "threshold" sets the minimum age for an un-bitmapped reference tip
    to join a pseudo-merge gruop

  - "maxMerges" controls how many unstable pseudo-merge groups we'll
    create

In addition, there are a pair of parameters controlling "stable"
pseudo-merge groups, meant to cover commits that are so old as to be
highly unlikely to change. "stableThreshold" controls the minimum age,
and "stableSize" controls the fixed size of each of these groups. Stable
pseudo-merges do not follow the inverse power-law decay function as
above.

Pseudo-merges can be grouped evevn further if the given pattern has one
or more capture groups, similar to delta islands. In a fork-network
repository (where each fork is a remote, and all objects live in
aggregate in a repository called "network.git"), you can group
branches/tags separately by fork ID like so:

    [bitmapPseudoMerge "branches"]
        pattern = "refs/remotes/([0-9])+/heads/"
        [...]

    [bitmapPseudoMerge "tags"]
        pattern = "refs/remotes/([0-9])+/tags/"
        [...]

Pseudo-merges are an additive optimization. A pseudo-merge may only be
used when all of its parents are part of either the "haves" or "wants"
side of a reachability query.

This is why groups with "older" commits tend to be larger (since they
are less likely to change, thus more likely to be usable over time). The
same is true for "newer" pseudo-merge groups being smaller.

USAGE
=====

Here's a best-case scenario for using pseudo-merge bitmaps. This is a
local copy of a relatively large (private) repository that has a large
number of references (~44k) with poor bitmap coverage, spike-y branches,
and deep-ish trees.

First, we generate a new bitmap with 64 pseudo-merge commits covering
the un-bitmapped parts of this repository, like so.

    $ GIT_TRACE2_PERF=1 GIT_TRACE2_PERF_BRIEF=1 \
      git.compile \
        -c bitmapPseudoMerge.all.pattern='refs/' \
        -c bitmapPseudoMerge.all.threshold=now \
        -c bitmapPseudoMerge.all.stableThreshold=never \
        -c bitmapPseudoMerge.all.maxMerges=64 \
        -c pack.writeBitmapLookupTable=true \
        repack -adb
    [...]
    d1 | main | data         | r1  | 476.227928 |  0.058245 | progress     | ....total_objects:1
    d1 | main | region_leave | r1  | 476.227938 |  0.058255 | progress     | ..label:Selecting pseudo-merge commits
    d1 | main | region_enter | r1  | 476.227946 |           | progress     | ..label:Building bitmaps
    d1 | main | region_enter | r1  | 476.227949 |           | pack-bitmap- | ....label:building_bitmaps_total
    d1 | main | data         | r1  | 476.228348 |  0.000399 | bitmap       | ......opened bitmap file:.git/objects/pack/pack-47e6bced8a8f64d82802a77f2f1cf5eeac24f295.pack
    d1 | main | data         | r1  | 485.947246 |  9.719297 | pack-bitmap- | ......num_selected_commits:733
    d1 | main | data         | r1  | 485.947269 |  9.719320 | pack-bitmap- | ......num_maximal_commits:115
    d1 | main | region_leave | r1  | 1033.008932 | 556.780983 | pack-bitmap- | ....label:building_bitmaps_total
    d1 | main | data         | r1  | 1033.008953 | 556.781007 | pack-bitmap- | ....building_bitmaps_reused:700
    d1 | main | data         | r1  | 1033.008957 | 556.781011 | pack-bitmap- | ....building_bitmaps_pseudo_merge_reused:0
    d1 | main | data         | r1  | 1033.008968 | 556.781022 | progress     | ....total_objects:733
    d1 | main | region_leave | r1  | 1033.008971 | 556.781025 | progress     | ..label:Building bitmaps

(Note: this repository had an up-to-date .bitmap prior to generating
pseudo-merges, so we spend about ~9 minutes (on an unoptimized build)
generating psuedo-merges. This feels expensive, but maybe my intuition
is wrong. I've spent quite a bit of time trying to drive this down, but
I still think there is some medium-hanging fruit left here to get this
to be even cheaper.)

PERFORMANCE
===========

From there, we can compare the time it takes to generate a count of
reachable objects with and without using pseudo-merge bitmaps:

    $ hyperfine -L v ,.compile 'git{v} rev-list --all --objects --count --use-bitmap-index'
    Benchmark 1: git rev-list --all --objects --count --use-bitmap-index
      Time (mean ± σ):     16.129 s ±  0.079 s    [User: 15.681 s, System: 0.446 s]
      Range (min … max):   16.029 s … 16.243 s    10 runs

    Benchmark 2: git.compile rev-list --all --objects --count --use-bitmap-index
      Time (mean ± σ):     874.9 ms ±  20.4 ms    [User: 611.4 ms, System: 263.3 ms]
      Range (min … max):   847.1 ms … 904.3 ms    10 runs

    Summary
      git.compile rev-list --all --objects --count --use-bitmap-index ran
       18.43 ± 0.44 times faster than git rev-list --all --objects --count --use-bitmap-index

Similarly for clone performance (this impact here is less dramatic than
above, primarily because we end up accumulating most objects via
pack-reuse, but enumeration is faster by roughly the same quantity as
above):

    $ hyperfine --runs=3 -L v ,.compile 'git{v} pack-objects \
      --all --use-bitmap-index --delta-base-offset \
      --stdout --all-progress </dev/null >/dev/null'
    Benchmark 1: git pack-objects \
      --all --use-bitmap-index --delta-base-offset \
      --stdout --all-progress </dev/null >/dev/null
      Time (mean ± σ):     93.811 s ±  2.202 s    [User: 80.905 s, System: 7.674 s]
      Range (min … max):   92.136 s … 96.305 s    3 runs

    Benchmark 2: git.compile pack-objects \
      --all --use-bitmap-index --delta-base-offset \
      --stdout --all-progress </dev/null >/dev/null
      Time (mean ± σ):     79.608 s ±  0.764 s    [User: 68.304 s, System: 7.215 s]
      Range (min … max):   78.912 s … 80.425 s    3 runs

    Summary
      git.compile pack-objects --all --use-bitmap-index --delta-base-offset --stdout --all-progress </dev/null >/dev/null ran
        1.18 ± 0.03 times faster than git pack-objects --all --use-bitmap-index --delta-base-offset --stdout --all-progress </dev/null >/dev/null

In a smaller repository, like git.git, the perfomrance number are much
less dramatic (here we're generating the numbers from the new p5333
performance test), but show that we do not pay a performance penalty for
using pseudo-merges:

    Test                                                                this tree
    -----------------------------------------------------------------------------------
    5333.2: git rev-list --count --all --objects (no bitmaps)           3.46(3.37+0.09)
    5333.3: git rev-list --count --all --objects (no pseudo-merges)     0.13(0.11+0.01)
    5333.4: git rev-list --count --all --objects (with pseudo-merges)   0.12(0.11+0.01)

CONCLUSION
==========

This series turned out to be quite the adventure to work on ;-). Many
thanks to Peff, who developed this idea together with me during the end
of October, 2021.

Review on this large topic is greatly appreciated. Likewise, if folks
have good ideas on either (a) how to speed-up generating these bitmaps,
or (b) a sense of whether or not the current performance is acceptable,
I am all ears.

Thanks in advance for anyone interested in reviewing this topic, and I
look forward to your feedback!

Taylor Blau (24):
  Documentation/technical: describe pseudo-merge bitmaps format
  config: repo_config_get_expiry()
  ewah: implement `ewah_bitmap_is_subset()`
  pack-bitmap: drop unused `max_bitmaps` parameter
  pack-bitmap: move some initialization to `bitmap_writer_init()`
  pseudo-merge.ch: initial commit
  pack-bitmap-write: support storing pseudo-merge commits
  pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
  pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
  pseudo-merge: implement support for selecting pseudo-merge commits
  pack-bitmap-write.c: select pseudo-merge commits
  pack-bitmap-write.c: write pseudo-merge table
  pack-bitmap: extract `read_bitmap()` function
  pseudo-merge: scaffolding for reads
  pack-bitmap.c: read pseudo-merge extension
  pseudo-merge: implement support for reading pseudo-merge commits
  ewah: implement `ewah_bitmap_popcount()`
  pack-bitmap: implement test helpers for pseudo-merge
  t/test-lib-functions.sh: support `--date` in `test_commit_bulk()`
  pack-bitmap.c: use pseudo-merges during traversal
  pack-bitmap: extra trace2 information
  ewah: `bitmap_equals_ewah()`
  pseudo-merge: implement support for finding existing merges
  t/perf: implement performace tests for pseudo-merge bitmaps

 Documentation/config.txt                     |   2 +
 Documentation/config/bitmap-pseudo-merge.txt |  75 ++
 Documentation/technical/bitmap-format.txt    | 205 +++++
 Makefile                                     |   1 +
 builtin/pack-objects.c                       |   3 +-
 config.c                                     |  18 +
 config.h                                     |   2 +
 ewah/bitmap.c                                |  76 ++
 ewah/ewok.h                                  |   3 +
 midx.c                                       |   3 +-
 pack-bitmap-write.c                          | 275 ++++++-
 pack-bitmap.c                                | 359 ++++++++-
 pack-bitmap.h                                |  16 +-
 pseudo-merge.c                               | 739 +++++++++++++++++++
 pseudo-merge.h                               | 218 ++++++
 t/helper/test-bitmap.c                       |  34 +-
 t/perf/p5333-pseudo-merge-bitmaps.sh         |  32 +
 t/t5333-pseudo-merge-bitmaps.sh              | 389 ++++++++++
 t/test-lib-functions.sh                      |  12 +-
 19 files changed, 2401 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/config/bitmap-pseudo-merge.txt
 create mode 100644 pseudo-merge.c
 create mode 100644 pseudo-merge.h
 create mode 100755 t/perf/p5333-pseudo-merge-bitmaps.sh
 create mode 100755 t/t5333-pseudo-merge-bitmaps.sh


base-commit: 3bd955d26919e149552f34aacf8a4e6368c26cec
-- 
2.44.0.303.g1dc5e5b124c
