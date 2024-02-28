Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F863307B
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113465; cv=none; b=O2ab1TIuM3VB+22/3hCdXuMlzr7lIO8jnvfw4zPY6+pxKkOqHWEIHphbpaFdwqN19bFWiy2XgG6VYurGL/El8Zpd9b17ZR/K9/iCIy26l3GbxqLcYuR6TyB1HhT5ptbiKLsGw4ysHDDxwQ6yyUAb/JuH7NVHHllHy6dW1sy7S2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113465; c=relaxed/simple;
	bh=1LjlgFXR0fs7NU34x2nk2XVfu45VLwbHnC5VIePiOlE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J3kt6gyH2h8uFfrAqBogdFVi2qsTHnnDLZ+WzJz2Ldlbw0ImAk8UM/m0wBJyglp2iL2bBJfNSiFBieebS5D9GusRzaqMe2dTXCjVhUIY3vHe++r8NcfUjybWqZbAzgF8NnKRHnq+9GLsSEGtlPCQhzGrd0eWbwqMsxLELvYfc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8CkRbu6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8CkRbu6"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412af574501so9803935e9.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 01:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709113461; x=1709718261; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSzdf7LTNVOaQHYbqWaK4lwEwIUGgR+bq1Juu2QCd1Q=;
        b=V8CkRbu681NzRbx/5j6hS/gV85zhqQoOkiUqStwvMk7QFE0D2XyCGYRkSvEWlneW+A
         vsKZ0kqM7kx9FwBWOm8NNLAJx25cD3AhojyziI5BgYdWxWSLkldrmuL2T7Bm4UQrI3U1
         OaLPf1LujOZ/oxs0OD9Bq2U7pVPjWa944s4lmLcy7QkW/YexTnvEM383HwOO7lpSx1Mt
         o17RFrEfNiUJAdhg5hlkK1v0//qjt4JyqaU1FE/zI0M+zurHxiiquutlfNL1MI1WNLuD
         dst8x5j4A9T+0AsB2hq+NmI5Qef0JnLwhV2pGtH0i9p3bMkSuHPMzzYwCIuBzKemBmuH
         Svqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113461; x=1709718261;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSzdf7LTNVOaQHYbqWaK4lwEwIUGgR+bq1Juu2QCd1Q=;
        b=a2903kE8XhF3fEc8/cU1PbC6oTryHbpTxFK03JBqKHgnlkBqCGWxf4gneyfL3C4smA
         7Lk6I913NdlnbX+3HcQJtHYBgJyUG/Xj6DAhMQNNPVyKKGwdzPZzlCxW8it0D2Aex9GA
         5CF+ZULZ7PlakvF8FioXMHThdBSeVxWmjySbpEJL9kYcRnXd5RQp3r/9Q5mn+2PSmP7X
         4l8WIGBjvUcOiIuKXAmurRLbLQuTkeum+phrtzHI8bgIvS0Ue3WObSTqeNsOJfLPf/1j
         L6XRSqU5PIIFF6dYxph3EYDPhQa2Un+j0ND383dn+B3X1pJzh8ygY0o08whhc0CmNeea
         XyNg==
X-Gm-Message-State: AOJu0YwxKV7drBpbmli3GTILzn/Lxyx+jlL4ERi2BefPcgZDTBii1+0N
	OwG2YPX20q+lMpgjETjO3xNfLQ+LZ2GqBUTfhLN4aFgC9e/+9Xpo17r2eZx8
X-Google-Smtp-Source: AGHT+IGQddi6+TD6TLHtYFdY+LWJgbIirOY60vOGrzbPWBRee+FrKVOJx8h+E092iWJdZGOk90RwYw==
X-Received: by 2002:a05:600c:524c:b0:412:a7c9:8970 with SMTP id fc12-20020a05600c524c00b00412a7c98970mr5275605wmb.31.1709113460654;
        Wed, 28 Feb 2024 01:44:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8-20020adfe4c8000000b0033dcc0d1399sm10766154wrm.25.2024.02.28.01.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:44:20 -0800 (PST)
Message-ID: <pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 28 Feb 2024 09:44:06 +0000
Subject: [PATCH v4 00/11] The merge-base logic vs missing commit objects
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Dirk Gouders <dirk@gouders.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

This patch series is in the same spirit as what I proposed in
https://lore.kernel.org/git/pull.1651.git.1707212981.gitgitgadget@gmail.com/,
where I tackled missing tree objects. This here patch series tackles missing
commit objects instead: Git's merge-base logic handles these missing commit
objects as if there had not been any commit object at all, i.e. if two
commits' merge base commit is missing, they will be treated as if they had
no common commit history at all, which is a bug. Those commit objects should
not be missing, of course, i.e. this is only a problem in corrupt
repositories.

This patch series is a bit more tricky than the "missing tree objects" one,
though: The function signature of quite a few functions need to be changed
to allow callers to discern between "missing commit object" vs "no
merge-base found".

And of course it gets even more tricky because in shallow and partial clones
we expect commit objects to be missing, and that must not be treated like an
error but the existing logic is actually desirable in those scenarios.

I am deeply sorry both about the length of this patch series as well as
having to lean so heavily on reviews on the Git mailing list.

Changes since v3:

 * Reworded some hard-to-understand paragraphs in the commit message of
   "Prepare paint_down_to_common() for handling shallow commits" (4/11).
 * Changed an inconsistent paint_down_to_common() < 0 to simply test whether
   the return value is non-zero.
 * Changed all commit messages to have proper <area>: prefixes.

Changes since v2:

 * Moved a hunk from 3/11 to 2/11 that lets the repo_in_merge_bases_many()
   function return an error if non-existing commits have been passed to it,
   unless the ignore_missing_commits parameter is non-zero.
 * The end result is tree-same.

Changes since v1:

 * Addressed a lot of memory leaks.
 * Reordered patch 2 and 3 to render the commit message's comment about
   unchanged behavior true.
 * Fixed the incorrectly converted condition in the merge_submodule()
   function.
 * The last patch ("paint_down_to_common(): special-case shallow/partial
   clones") was dropped because it is not actually necessary, and the
   explanation for that was added to the commit message of "Prepare
   paint_down_to_common() for handling shallow commits".
 * An inconsistently-named variable i was renamed to be consistent with the
   other variables called ret.

Johannes Schindelin (11):
  commit-reach(paint_down_to_common): plug two memory leaks
  commit-reach(repo_in_merge_bases_many): optionally expect missing
    commits
  commit-reach(repo_in_merge_bases_many): report missing commits
  commit-reach(paint_down_to_common): prepare for handling shallow
    commits
  commit-reach(paint_down_to_common): start reporting errors
  commit-reach(merge_bases_many): pass on "missing commits" errors
  commit-reach(get_merge_bases_many_0): pass on "missing commits" errors
  commit-reach(repo_get_merge_bases): pass on "missing commits" errors
  commit-reach(get_octopus_merge_bases): pass on "missing commits"
    errors
  commit-reach(repo_get_merge_bases_many): pass on "missing commits"
    errors
  commit-reach(repo_get_merge_bases_many_dirty): pass on errors

 bisect.c                         |   7 +-
 builtin/branch.c                 |  12 +-
 builtin/fast-import.c            |   6 +-
 builtin/fetch.c                  |   2 +
 builtin/log.c                    |  30 +++--
 builtin/merge-base.c             |  23 +++-
 builtin/merge-tree.c             |   5 +-
 builtin/merge.c                  |  26 ++--
 builtin/pull.c                   |   9 +-
 builtin/rebase.c                 |   8 +-
 builtin/receive-pack.c           |   6 +-
 builtin/rev-parse.c              |   5 +-
 commit-reach.c                   | 209 ++++++++++++++++++++-----------
 commit-reach.h                   |  26 ++--
 commit.c                         |   7 +-
 diff-lib.c                       |   5 +-
 http-push.c                      |   5 +-
 log-tree.c                       |   5 +-
 merge-ort.c                      |  87 +++++++++++--
 merge-recursive.c                |  58 +++++++--
 notes-merge.c                    |   3 +-
 object-name.c                    |   7 +-
 remote.c                         |   2 +-
 revision.c                       |  12 +-
 sequencer.c                      |   8 +-
 shallow.c                        |  21 ++--
 submodule.c                      |   7 +-
 t/helper/test-reach.c            |  11 +-
 t/t4301-merge-tree-write-tree.sh |  12 ++
 29 files changed, 441 insertions(+), 183 deletions(-)


base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1657%2Fdscho%2Fmerge-base-and-missing-objects-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1657/dscho/merge-base-and-missing-objects-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1657

Range-diff vs v3:

  1:  6e4e409cd43 !  1:  647fa2ed5c5 paint_down_to_common: plug two memory leaks
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    paint_down_to_common: plug two memory leaks
     +    commit-reach(paint_down_to_common): plug two memory leaks
      
          When a commit is missing, we return early (currently pretending that no
          merge basis could be found in that case). At that stage, it is possible
  2:  f68d77c6123 !  2:  48e69bf7229 Prepare `repo_in_merge_bases_many()` to optionally expect missing commits
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    Prepare `repo_in_merge_bases_many()` to optionally expect missing commits
     +    commit-reach(repo_in_merge_bases_many): optionally expect missing commits
      
          Currently this function treats unrelated commit histories the same way
          as commit histories with missing commit objects.
  3:  0aaa224b5db !  3:  1938b317a49 Start reporting missing commits in `repo_in_merge_bases_many()`
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    Start reporting missing commits in `repo_in_merge_bases_many()`
     +    commit-reach(repo_in_merge_bases_many): report missing commits
      
          Some functions in Git's source code follow the convention that returning
          a negative value indicates a fatal error, e.g. repository corruption.
  4:  84e7fbc07e0 !  4:  837aa5a89c6 Prepare `paint_down_to_common()` for handling shallow commits
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    Prepare `paint_down_to_common()` for handling shallow commits
     +    commit-reach(paint_down_to_common): prepare for handling shallow commits
      
          When `git fetch --update-shallow` needs to test for commit ancestry, it
          can naturally run into a missing object (e.g. if it is a parent of a
     -    shallow commit). To accommodate, the merge base logic will need to be
     -    able to handle this situation gracefully.
     +    shallow commit). For the purpose of `--update-shallow`, this needs to be
     +    treated as if the child commit did not even have that parent, i.e. the
     +    commit history needs to be clamped.
      
     -    Currently, that logic pretends that a missing parent commit is
     -    equivalent to a missing parent commit, and for the purpose of
     -    `--update-shallow` that is exactly what we need it to do.
     +    For all other scenarios, clamping the commit history is actually a bug,
     +    as it would hide repository corruption (for an analysis regarding
     +    shallow and partial clones, see the analysis further down).
      
     -    Therefore, let's introduce a flag to indicate when that is precisely the
     -    logic we want.
     +    Add a flag to optionally ask the function to ignore missing commits, as
     +    `--update-shallow` needs it to, while detecting missing objects as a
     +    repository corruption error by default.
      
     -    We need a flag, and cannot rely on `is_repository_shallow()` to indicate
     -    that situation, because that function would return 0: There may not
     -    actually be a `shallow` file, as demonstrated e.g. by t5537.10 ("add new
     -    shallow root with receive.updateshallow on") and t5538.4 ("add new
     -    shallow root with receive.updateshallow on").
     +    This flag is needed, and cannot replaced by `is_repository_shallow()` to
     +    indicate that situation, because that function would return 0 in the
     +    `--update-shallow` scenario: There is not actually a `shallow` file in
     +    that scenario, as demonstrated e.g. by t5537.10 ("add new shallow root
     +    with receive.updateshallow on") and t5538.4 ("add new shallow root with
     +    receive.updateshallow on").
      
          Note: shallow commits' parents are set to `NULL` internally already,
          therefore there is no need to special-case shallow repositories here, as
  5:  85332b58c37 !  5:  b978b5d233a commit-reach: start reporting errors in `paint_down_to_common()`
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    commit-reach: start reporting errors in `paint_down_to_common()`
     +    commit-reach(paint_down_to_common): start reporting errors
      
          If a commit cannot be parsed, it is currently ignored when looking for
          merge bases. That's undesirable as the operation can pretend success in
     @@ commit-reach.c: static struct commit_list *merge_bases_many(struct repository *r
       	}
       
      -	list = paint_down_to_common(r, one, n, twos, 0, 0);
     -+	if (paint_down_to_common(r, one, n, twos, 0, 0, &list) < 0) {
     ++	if (paint_down_to_common(r, one, n, twos, 0, 0, &list)) {
      +		free_commit_list(list);
      +		return NULL;
      +	}
  6:  2ae6a54dd59 !  6:  0f1ce130ce6 merge_bases_many(): pass on errors from `paint_down_to_common()`
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    merge_bases_many(): pass on errors from `paint_down_to_common()`
     +    commit-reach(merge_bases_many): pass on "missing commits" errors
      
          The `paint_down_to_common()` function was just taught to indicate
          parsing errors, and now the `merge_bases_many()` function is aware of
     @@ commit-reach.c: static int paint_down_to_common(struct repository *r,
      +				     oid_to_hex(&twos[i]->object.oid));
       	}
       
     - 	if (paint_down_to_common(r, one, n, twos, 0, 0, &list) < 0) {
     + 	if (paint_down_to_common(r, one, n, twos, 0, 0, &list)) {
       		free_commit_list(list);
      -		return NULL;
      +		return -1;
  7:  4321795102d !  7:  133b69b6a62 get_merge_bases_many_0(): pass on errors from `merge_bases_many()`
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    get_merge_bases_many_0(): pass on errors from `merge_bases_many()`
     +    commit-reach(get_merge_bases_many_0): pass on "missing commits" errors
      
          The `merge_bases_many()` function was just taught to indicate
          parsing errors, and now the `get_merge_bases_many_0()` function is aware
  8:  35545c4b777 !  8:  bd52f258cd9 repo_get_merge_bases(): pass on errors from `merge_bases_many()`
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    repo_get_merge_bases(): pass on errors from `merge_bases_many()`
     +    commit-reach(repo_get_merge_bases): pass on "missing commits" errors
      
          The `merge_bases_many()` function was just taught to indicate parsing
          errors, and now the `repo_get_merge_bases()` function (which is also
  9:  a963058d2ba !  9:  b7ef90a57f0 get_octopus_merge_bases(): pass on errors from `merge_bases_many()`
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    get_octopus_merge_bases(): pass on errors from `merge_bases_many()`
     +    commit-reach(get_octopus_merge_bases): pass on "missing commits" errors
      
          The `merge_bases_many()` function was just taught to indicate parsing
          errors, and now the `repo_get_merge_bases()` function (which is also
 10:  c3bed9c8500 ! 10:  32587b3caa7 repo_get_merge_bases_many(): pass on errors from `merge_bases_many()`
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    repo_get_merge_bases_many(): pass on errors from `merge_bases_many()`
     +    commit-reach(repo_get_merge_bases_many): pass on "missing commits" errors
      
          The `merge_bases_many()` function was just taught to indicate parsing
          errors, and now the `repo_get_merge_bases_many()` function is aware of
 11:  bdbf47ae505 ! 11:  05de9f24444 repo_get_merge_bases_many_dirty(): pass on errors from `merge_bases_many()`
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    repo_get_merge_bases_many_dirty(): pass on errors from `merge_bases_many()`
     +    commit-reach(repo_get_merge_bases_many_dirty): pass on errors
     +
     +    (Actually, this commit is only about passing on "missing commits"
     +    errors, but adding that to the commit's title would have made it too
     +    long.)
      
          The `merge_bases_many()` function was just taught to indicate parsing
          errors, and now the `repo_get_merge_bases_many_dirty()` function is

-- 
gitgitgadget
