Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55A813DDAE
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356030; cv=none; b=AsFc3KeNOIVsOOTXkmityK4g4tfzIiDVVNhg5vfv875AoIfq/C2wPsbU053NxeMTib1eJRb3W57UQPwxLiZDFD1kkHsjac6LB0Ck+y3lRCPfe9Ruz/rx434su1iienZftdWk7vgxZy1e5SMjFK55Fz9j+7PjpbJz9qeXhlO5Vaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356030; c=relaxed/simple;
	bh=FcjVfkKgPm5joEpA4S9K0yI2pEIMJOlnbKPeArIGc/M=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Xe5fKnRUauKyS0BFaYChdsSv7F6TN6pEXGGR+25zBVwKhj3jdhRiZppsFEfjCLwT4dP0uvofYy2xeXZJ6r9M0tylNYCF2Ct/hj58RZD4P+Zlvrun/a9UwZekTKVfj/+gPNzW10aQogG7tpkukZZQx0eXzUuIOmRNM50tvgtvZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxdzMZQO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxdzMZQO"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d3ecad390so1039892f8f.1
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 23:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730356026; x=1730960826; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6Px/2mw1C9B/dIahKTcpODpdkmoB/d97dOozD8Lw7fA=;
        b=XxdzMZQOjR6HsGdPuE/LnNfa5wWI6pXq+mr2/0W+q56LDYXUG6OOdol6fpoFzhVgpA
         vn3ZGxD+Jv/wbLkvHgTcsurCw5eRcI3i3Co4hjPMa9NlbhjWbBS1mFjjFS73xddJsJ3+
         QSbOCMLnY7iSnEdZuiWenywftoqhZn6r6QvOPVspUkm5VQu8rFxV3vGQ8v1q5CwfT74d
         +fx/yeX7vtdFuuirll/blyVMicdZhanY7EorOJFA/wkEwEm24OmYgZLAgeZv7hiucz9E
         WLScOV2mbbiB+03HJms/IyteQ7H+YrreM4Ays/zYW2s5RWm7eVkNuFgyeJp7gUquv3Kf
         /v0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730356026; x=1730960826;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Px/2mw1C9B/dIahKTcpODpdkmoB/d97dOozD8Lw7fA=;
        b=ja/6a+GAR6cxHWSZ3oaNWufV3BSydEqUkvW8fm7BkBNeuEtSATdmcG5YgXkYNxiLlB
         7YjT9nzeZIutZSoEC8OVLogEsrazEiEfaHEKYI6t1VJAXLYxHtOABTppnq38VeRmw+1g
         idqcCyWhMV3zhBuHzatz3Wo3P76SrgtEef2lt7humLgZVa6sWZhqYldZBAvIhQbq4oZs
         e8vN+6EJIBFTaaEJ9IqoZRe+RG22k/9+MVl1O1QBoi44d/mXMKtqe5DEQTvqGH3Fi+Ce
         VJPOc8/X+twTcVvFDBl4yFcIwQKulYBWuHKcgBgOpYHcwF176FLXBsblSmfXox4ooaVM
         Tr1Q==
X-Gm-Message-State: AOJu0Yz4kqDBVwBGKaTapSZ7w6ivdDaHT0cPl9WwTPgj0p+T5Wi4xT5S
	8+ukUuqeB4sZ1JEMS3wcA0rA2M+IinGZi7DqrZJJE3JPVoIP0pBgeV10JA==
X-Google-Smtp-Source: AGHT+IEuetFrE3zc7FDSaJJOj9UJo4vgsgNthCUgp3P+gB6sy5Xk5Is6IDq496o2aeuzH9H6N2nqMg==
X-Received: by 2002:a05:6000:184b:b0:37e:d6b9:a398 with SMTP id ffacd0b85a97d-381c12bef57mr754564f8f.9.1730356025504;
        Wed, 30 Oct 2024 23:27:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf225sm12512985e9.11.2024.10.30.23.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:27:04 -0700 (PDT)
Message-Id: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 31 Oct 2024 06:26:57 +0000
Subject: [PATCH 0/6] PATH WALK I: The path-walk API
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    Derrick Stolee <stolee@gmail.com>


Introduction and relation to prior series
=========================================

This is a new series that rerolls the initial "path-walk API" patches of my
RFC [1] "Path-walk API and applications". This new API (in path-walk.c and
path-walk.h) presents a new way to walk objects such that trees and blobs
are walked in batches according to their path.

This also replaces the previous version of ds/path-walk that was being
reviewed in [2]. The consensus was that the series was too long/dense and
could use some reduction in size. This series takes the first few patches,
but also makes some updates (which will be described later).

[1]
https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com/
[RFC] Path-walk API and applications

[2]
https://lore.kernel.org/git/pull.1813.v2.git.1729431810.gitgitgadget@gmail.com/
[PATCH v2 00/17] pack-objects: add --path-walk option for better deltas

This series only introduces the path-walk API, but does so to the full
complexity required to later add the integration with git pack-objects to
improve packing compression in both time and space for repositories with
many name hash collisions. The compression also at least improves for other
repositories, but may not always have an improvement in time.

Some of the changes that are present in this series that differ from the
previous version are motivated directly by discoveries made by testing the
feature in Git for Windows and microsoft/git forks that shipped these
features for fast delivery of these improvements to users who needed them.
That testing across many environments informed some things that needed to be
changed, and in this series those changes are checked by tests in the
t6601-path-walk.sh test script and the test-tool path-walk test helper.
Thus, the code being introduced in this series is covered by tests even
though it is not integrated into the git executable.


Discussion of follow-up applications
====================================

By splitting this series out into its own, I was able to reorganize the
patches such that each application can be build independently off of this
series. These are available as pending PRs in gitgitgadget/git:

 * Better delta compression with 'git pack-objects' [3]: This application
   allows an option in 'git pack-objects' to change how objects are walked
   in order to group objects with the same path for early delta compression
   before using the name hash sort to look for cross-path deltas. This helps
   significantly in repositories with many name-hash collisions. This
   reduces the size of 'git push' pacifies via a config option and reduces
   the total repo size in 'git repack'.

 * The 'git backfill' command [4]: This command downloads missing blobs in a
   bloodless partial clone. In order to save space and network bandwidth, it
   assumes that objects at a common path are likely to delta well with each
   other, so it downloads missing blobs in batches via the path-walk API.
   This presents a way to use blobless clones as a pseudo-resumable clone,
   since the initial clone of commits and trees is a smaller initial
   download and the batch size allows downloading blobs incrementally. When
   pairing this command with the sparse-checkout feature, the path-walk API
   is adjusted to focus on the paths within the sparse-checkout. This allows
   the user to only download the files they are likely to need when
   inspecting history within their scope without downloading the entire
   repository history.

 * The 'git survey' command [5]. This application begins the work to mimic
   the behavior of git-sizer, but to use internal data structures for better
   performance and careful understanding of how objects are stored. Using
   the path-walk API, paths with many versions can be considered in a batch
   and sorted into a list to report the paths that contribute most to the
   size of the repository. A version of this command was used to help
   confirm the issues with the name hash collisions. It was also used to
   diagnose why some repacks using the --path-walk option were taking more
   space than without for some repositories. (More on this later.)

Question for reviewers: I am prepped to send these three applications to the
mailing list, but I'll refrain for now to avoid causing too much noise for
folks. Would you like to see them on-list while this series is under review?
Or would you prefer to explore the PRs ([3] [4] and [5])?

[3] https://github.com/gitgitgadget/git/pull/1819
PATH WALK II: Add --path-walk option to 'git pack-objects'

[4] https://github.com/gitgitgadget/git/pull/1820
PATH WALK III: Add 'git backfill' command

[5] https://github.com/gitgitgadget/git/pull/1821
PATH WALK IV: Add 'git survey' command


Structure of the Patch Series
=============================

This patch series attempts to create the simplest version of the API in
patch 1, then build functionality incrementally. During the process, each
change will introduce an update to:

 * The path-walk API itself in path-walk.c and path-walk.h.
 * The documentation of the API in
   Documentation/technical/api-path-walk.txt.
 * The test script t/t6601-path-walk.sh.

The core of the API relies on using a 'struct rev_info' to define an initial
set of objects and some form of a commit walk to define what range of
objects to visit. Initially, only a subset of 'struct rev_info' options work
as expected. For example:

 * Patch 1 assumes that only commit objects are starting positions, but the
   focus is on exploring trees and blobs.
 * Patch 3 allows users to specify object types, which includes outputting
   the visited commits in a batch.
 * Annotated tags and indexed objects are considered in Patch 4. These are
   grouped because they both exist within the 'pending' object list.
 * UNINTERESTING objects are not considered until Patch 5.


Changes since previous version
==============================

There are a few hard-won learnings from previous versions of this series due
to testing this in the wild with many different repositories.

 * Initially, the 'git pack-objects --path-walk' feature was not tested with
   the '--shallow' option because it was expected that this option was for
   servers creating a pack containing shallow commits. However, this option
   is also used when pushing from a shallow clone, and this was a critical
   feature that we needed to reduce the size of commits pushed from
   automated environments that were bootstrapped by shallow clones. The crux
   of the change is in Patch 5 and how UNINTERESTING objects are handled. We
   no longer need to push the UNINTERESTING flag around the objects
   ourselves and can use existing logic in list-objects.c to do so. This
   allows using the --objects-edge-aggressive option when necessary to
   reduce the object count when pushing from a shallow clone. (The
   pack-objects series expands on tests to cover this integration point.)

 * When looking into cases where 'git repack -adf' outperformed 'git repack
   -adf --path-walk', I discovered that the issue did not reproduce in a
   bare repository. This is due to 'git repack' iterating over all indexed
   objects before walking commits. I had inadvertently put all indexed
   objects in their own category, leading to no good deltas with previous
   versions of those files; I had also not used the 'path' option from the
   pending list, so these objects had invalid name hash values. You will see
   in patch 4 that the pending list is handled quite differently and the
   '--indexed-objects' option is tested directly within t6601.

 * I added a new 'test_cmp_sorted' helper because I wanted to simplify some
   repeated sections of t6601.

 * Patch 1 has significantly more context than it did before.

 * Annotated tags are given a name of "/tags" to differentiate them slightly
   from root trees and commits.

I will include a full range diff relative to the previous versions of these
patches in [2] in a reply to this cover letter.

Thanks, -Stolee

Derrick Stolee (6):
  path-walk: introduce an object walk by path
  test-lib-functions: add test_cmp_sorted
  t6601: add helper for testing path-walk API
  path-walk: allow consumer to specify object types
  path-walk: visit tags and cached objects
  path-walk: mark trees and blobs as UNINTERESTING

 Documentation/technical/api-path-walk.txt |  63 +++
 Makefile                                  |   2 +
 path-walk.c                               | 529 ++++++++++++++++++++++
 path-walk.h                               |  65 +++
 t/helper/test-path-walk.c                 | 114 +++++
 t/helper/test-tool.c                      |   1 +
 t/helper/test-tool.h                      |   1 +
 t/t6601-path-walk.sh                      | 366 +++++++++++++++
 t/test-lib-functions.sh                   |  10 +
 9 files changed, 1151 insertions(+)
 create mode 100644 Documentation/technical/api-path-walk.txt
 create mode 100644 path-walk.c
 create mode 100644 path-walk.h
 create mode 100644 t/helper/test-path-walk.c
 create mode 100755 t/t6601-path-walk.sh


base-commit: e9356ba3ea2a6754281ff7697b3e5a1697b21e24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1818%2Fderrickstolee%2Fapi-upstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1818/derrickstolee/api-upstream-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1818
-- 
gitgitgadget
