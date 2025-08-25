Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDFC1E7C08
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126204; cv=none; b=J17xR4NgKNTcLkMYSK/bqYUkGEYGOCUZEmP+fYjbBUW5wi/femZpmR8vd4hJOcVWURU3iKo/1lzqXKeTs+n3Eyi4ixS03ssSAVen0XJaKb8E02oIYkU3i1mYwIjasnKmIbXgE3pC9Gq9OhmvbSyvGL2VKtt8sTeisMjjLDMsYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126204; c=relaxed/simple;
	bh=Z4ftYsw5NDhBrKmj9B/p6qTJwu7e4xeO2kRTft0zAv0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=akFwvq83UIJzyPFPZNAH9SaNClJw6RQOWuF/kMfDBI8MzK21iUuYaSOBF5YBNy+NCX5/iaON0RukpajGECceu7NfpfNCdn+eY8i5tYlFb6EEIFPqEQ2W0Hkh/jfb2MPOU9NWYx/KtkPwhZvLJeIKsHvjuLwJRs9Jsm4SDYd7lXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMuWfu8c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMuWfu8c"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b629c8035so3567195e9.3
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756126200; x=1756731000; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8dymknT0UChMitRISuCw5vSkB1Stj2szNi2pxPLjsU=;
        b=YMuWfu8cSFB8Pri4z8IMheJDmbvPXQXvoNQTgLR1XmvNlaOtkZEiyGiWDC3G0AYZXy
         DIsaIdBFcrwQ1S9cIP3gUAWGhtctIGqu9nsvjGr0dA7d2HalkZPwTQZY24s3raDYx/dM
         BAoDwz2naTk4zMkLx7fM1E0/i6Yz2R9p6akiE8nVThYyRxmhcMzjx2iLHuujHCZ9wAIB
         H/IeFXEKmHa1g/Gpw3SI5a+cXeKyTnZOjS4NcJLmBhYAOG7FKiDVE0570j/0tb8Zm+DL
         sbZWZP3+acIvkWpO4EtrLCDv/UWqQvHNGGtG3OT7KMGCK+pR56KlVpZ9jkk1teVgCRxd
         JjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756126200; x=1756731000;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8dymknT0UChMitRISuCw5vSkB1Stj2szNi2pxPLjsU=;
        b=K0pjLquGzVP4TXjtargpC2MrTP/5aDmKIsyOBcX1hoQ76K938zZAw66k0k3eUnRic9
         8ttqUOtLgALyTOKBM2NR9BzEhxVQUDp5gXB5j+eaP3dAwx3v2o5ITLyrYlds97ZxXIVS
         lDHSUChi3eQdidmNpQX/RYiu1wFfxWmwgx0kQJLHixqgdpZm09mzDNaHbI4EGCJGU1Rw
         Iz9qlzA5lpX6hCFtlYT+b9sgtrAVbAaaRpjrEOclZtDcj2jAG5vYhIdl5lNjqs9m1cWj
         a7S10AIScgm0Xc77nJYdrMhHCiyn+68FgwwL1xWliqS8vKHqqbZfs+JTiqnQgcC/M0Jp
         /uLA==
X-Gm-Message-State: AOJu0Yxwzs9oJ9snQwVtKkZiOM8tDMjx5UZB9W0xeswf3d5kPm/Aujjy
	WPkiGLpfuA1mHCKtuyl2Rxu2ibyRdrQRNIJoNZK7H2Uivx7HTM2JeZZON7SSPrsG
X-Gm-Gg: ASbGnctKZ5qHx8BYQdwyuNZvC6XHomsQiM27x5iRdbMDGBAbDyiLl6KfYqwq+hUPMpF
	yQZYZ9pAZOlC2TZm2Po5hw9T0TO+32lFRlIa3Dm7RobwM3zhwpR7L/9LLaSIDzpH90uuqi5Tebc
	I1hvcd8T0svdyitoZla6l/Q76SMiZgUFgeZVgf0zml3bLJ/U1UFOELXniAXr0wvzeX6MlPxQweK
	ctMXl8o+7dbx+NCOPC/2Wk5X1YSTwiI/776Q+QyVt/Wi6RFUvl4lkXQr3sa1dr7h+zEJTwLZaKU
	XtVUmlDFq7jBhQMtlXZMVzh4z4uxT7PfAJd6+2QHKpn34rHCZgZhEXwnZepVtfBKIfA35z2PlCs
	PwMJuhqmYOKB4FV/K7GLQd4imP8Dq67wiUw==
X-Google-Smtp-Source: AGHT+IHxI7jGmD1WchuRFLvCqCkjfrjfMdn2uXMQgGYw8wc5lo6TcJZiygwmrfpxoLDAgIM1jWqf9g==
X-Received: by 2002:a05:600c:1388:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-45b517d40f2mr118086655e9.24.1756126199527;
        Mon, 25 Aug 2025 05:49:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba486sm11488537f8f.7.2025.08.25.05.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 05:49:58 -0700 (PDT)
Message-Id: <pull.1956.v2.git.1756126197.gitgitgadget@gmail.com>
In-Reply-To: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Aug 2025 12:49:55 +0000
Subject: [PATCH v2 0/2] [2.51.0 Bug] Missing singleton objects in 'git repack -adf --path-walk'
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>

Now that the --path-walk feature for git repack is out in the wild and
getting more visibility than it did in the Git for Windows fork, the
following issue was brought to my attention:

Some folks would report missing objects after git repack -adf --path-walk!

It turns out that this snuck through the cracks because it was pretty
difficult to create a reproducing test case (patch 1) but it boils down to:

 1. A path has exactly one version across all of the history being repacked.
 2. That path is in the index.
 3. The object at that path is not a loose object.
 4. pack.useSparse=true in the config (this is the default)

It is also something where users don't necessarily notice the missing
objects until they fetch and a missing object is used as a delta base. Doing
normal checkouts doesn't cause changes to these files, so they are never
opened by Git. Users hitting this issue can usually recover using git fetch
--refetch to repopulate the missing objects from a remote (unless they never
had a remote at all).

Patch 1 introduces the fix for this issue, which is related to forgetting to
initialize a struct indicator when walking the pending objects.

When reflecting on the ways that I missed this when building the feature, I
think the core issue was an overreliance on using bare repos in testing. I
also think that the way that the UNINTERESTING object exploration was
implemented was particularly fragile to missing updates to the
initialization of the struct, so patch 2 adds a new initializer to reduce
duplicate code and to help avoid this mistake in the future.


Updates in v2
=============

Thank you for the quick and careful review of these patches.

 * The test and bug fix are now in the same patch.
 * Several commit message typos/grammar edits.

Thanks, -Stolee

P.S. CC'ing all original reviewers of the series.

Derrick Stolee (2):
  path-walk: fix setup of pending objects
  path-walk: create initializer for path lists

 path-walk.c       | 55 +++++++++++++++++++----------------------
 t/t7700-repack.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 30 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1956%2Fderrickstolee%2Fpath-walk-missing-objects-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1956/derrickstolee/path-walk-missing-objects-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1956

Range-diff vs v1:

 1:  5b19173c03d ! 1:  2feedf5a1ee t7700: add failing --path-walk test
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    t7700: add failing --path-walk test
     +    path-walk: fix setup of pending objects
      
          Users reported an issue where objects were missing from their local
     -    enlistments after a full repack using 'git repack -adf --path-walk'.
     -    This was alarming, but took a while to create a reproducer.
     +    repositories after a full repack using 'git repack -adf --path-walk'.
     +    This was alarming and took a while to create a reproducer. Here, we fix
     +    the bug and include a test case that would fail without this fix.
      
          The root cause is that certain objects existed in the index and had no
          second versions. These objects are usually blobs, though trees can be
     @@ Commit message
          issue for reproducibility:
      
           1. File a/b/c has only one committed version.
     -     2. Files a/i and x/y only exists as staged changes.
     +     2. Files a/i and x/y only exist as staged changes.
           3. Tree x/ only exists in the cache-tree.
      
          After performing a non-path-walk repack to force all loose objects into
     @@ Commit message
          Note that since the staged root tree is missing, the fsck output cannot
          even report that the staged x/ tree is missing as well.
      
     -    This bug will be fixed in the next change.
     +    The core problem here is that the "maybe_interesting" member of 'struct
     +    type_and_oid_list' is not initialized to '1'. This member was added in
     +    6333e7ae0b (path-walk: mark trees and blobs as UNINTERESTING,
     +    2024-12-20) in a way to help when creating packfiles for a small commit
     +    range using the sparse path algorithm (enabled by pack.useSparse=true).
     +
     +    The idea here is that the list is marked as "maybe_interesting" if an
     +    object is added that does not have the UNINTERESTING flag on it. Later,
     +    this is checked again in case all objects in the list were marked
     +    UNINTERESTING after that point in time. In this case, the algorithm
     +    skips the list as there is no reason to visit it.
     +
     +    This leads to the problem where the "maybe_interesting" member was not
     +    appropriately initialized when the list is created from pending objects.
     +    Initializing this in the correct places fixes the bug.
     +
     +    To reduce risk of similar bugs around initializing this structure, a
     +    follow-up change will make initializing lists use a shared method.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     + ## path-walk.c ##
     +@@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
     + 					list->type = OBJ_TREE;
     + 					strmap_put(&ctx->paths_to_lists, path, list);
     + 				}
     ++				list->maybe_interesting = 1;
     + 				oid_array_append(&list->oids, &obj->oid);
     + 				free(path);
     + 			} else {
     +@@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
     + 					list->type = OBJ_BLOB;
     + 					strmap_put(&ctx->paths_to_lists, path, list);
     + 				}
     ++				list->maybe_interesting = 1;
     + 				oid_array_append(&list->oids, &obj->oid);
     + 			} else {
     + 				/* assume a root tree, such as a lightweight tag. */
     +
       ## t/t7700-repack.sh ##
      @@ t/t7700-repack.sh: test_expect_success '-n overrides repack.updateServerInfo=true' '
       	test_server_info_missing
       '
       
     -+test_expect_failure 'pending objects are repacked appropriately' '
     ++test_expect_success 'pending objects are repacked appropriately' '
     ++	test_when_finished rm -rf pending &&
      +	git init pending &&
      +
      +	(
      +		cd pending &&
      +
     ++		# Commit file, a/b/c and never change them.
      +		mkdir -p a/b &&
      +		echo singleton >file &&
      +		echo stuff >a/b/c &&
     @@ t/t7700-repack.sh: test_expect_success '-n overrides repack.updateServerInfo=tru
      +		git add file a &&
      +		git commit -m "single blobs" &&
      +
     ++		# Files a/d and a/e will not be singletons.
      +		echo d >a/d &&
      +		echo e >a/e &&
      +		git add a &&
     @@ t/t7700-repack.sh: test_expect_success '-n overrides repack.updateServerInfo=tru
      +		# test that the cache-tree is walked, too.
      +		git sparse-checkout set --sparse-index a x &&
      +
     -+		# Just _stage_ the changes.
     ++		# Create staged changes:
     ++		# * a/e now has multiple versions.
     ++		# * a/i now has only one version.
      +		echo f >a/d &&
      +		echo h >a/e &&
      +		echo i >a/i &&
     ++		git add a &&
     ++
     ++		# Stage and unstage a change to make use of
     ++		# resolve-undo cache and how that impacts fsck.
      +		mkdir x &&
      +		echo y >x/y &&
     -+		git add a x &&
     ++		git add x &&
     ++		xy=$(git rev-parse :x/y) &&
     ++		git rm --cached x/y &&
     ++
     ++		# The blob for x/y must persist through repacks,
     ++		# but fsck currently ignores the REUC extension
     ++		# for finding links to the blob.
     ++		cat >expect <<-EOF &&
     ++		dangling blob $xy
     ++		EOF
      +
      +		# Bring the loose objects into a packfile to avoid
      +		# leftovers in next test. Without this, the loose
      +		# objects persist and the test succeeds for other
      +		# reasons.
      +		git repack -adf &&
     -+		git fsck &&
     ++		git fsck >out &&
     ++		test_cmp expect out &&
      +
      +		# Test path walk version with pack.useSparse.
      +		git -c pack.useSparse=true repack -adf --path-walk &&
     -+		git fsck
     ++		git fsck >out &&
     ++		test_cmp expect out
      +	)
      +'
      +
 2:  0dc4a6323e6 < -:  ----------- path-walk: fix setup of pending objects
 3:  dd458e04354 = 2:  fc2c171f52d path-walk: create initializer for path lists

-- 
gitgitgadget
