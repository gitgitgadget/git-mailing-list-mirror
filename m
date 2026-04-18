Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB3175A5
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776472353; cv=none; b=tmGsWg0UMEMrxJ2hFWFy4aDh6phVDjloPcT2zGFmMFB4pTccf3vHJul6PxHo9Wwf78nEHcLNLf9JPIPygB3wXKGKsw9twvpHp+OVSpHk6JRLlPKXQb17sqnsOl/LWjJ5Cw5kYbLZB29IRqvkYu9wCJs/2GSJ+8J4nGzqZ6KWD2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776472353; c=relaxed/simple;
	bh=ekIVorwU6nDxg1DiUhXVmFDkNl2sV0AQPnblCGIf958=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sQoOdZRrG5cqOOdlUeQOvJ40VbMjDQfYYdEUZhysT0PmAmPstYX/pdVN6ws4yL98GHqzDoIvyX7xXMeSkxAqSXORVEu9xkPE5/D8fSVO33zyk1OQ/9VLrhdqvRs/fyuMNbpFO7Y+UhXFKpgpJDwHTI5gxcyuoqGDtTAQnrqwzvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiFvrPWq; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiFvrPWq"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50d8da3e656so14084491cf.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 17:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776472350; x=1777077150; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9LMfTbCByFgowY3JDDHHKzd1XgOcAyyN8G9GabVxj8=;
        b=jiFvrPWqqlhOlAOiPo2gsa2nnYHfuJ/VjSDwt2kx1fJJr8MZwG8CULiPGXJ3yOkVLb
         c9rHwbXsSBHyjJZqsvYpN2h4w8aXftRaoZcqfYE6eKqreQhfCmHFI7geuP9kBZeOGmwy
         BDPx54o9g+akvhe6aBtVczXqN9qO4zZDLiL5VlMuKtgLpxMIUC3WwAbFDxKRKZ3Ekyat
         YBxoqL0kQdE2Tt0EgZ1kEwZb7EW9QLRC6UY30kkf0OzTsPDH0ra7pBiEadoCc4f/7rpe
         W6gf3DUgH1qqW9k9b2XO/oR9B4qoTgN9J97nok0yo9qQnV5bpOYPfOHTi6PbydYcuLlq
         z+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776472350; x=1777077150;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y9LMfTbCByFgowY3JDDHHKzd1XgOcAyyN8G9GabVxj8=;
        b=rqRIv6RaRISQmDpWOOQT7jOjPWqJ/peiBq90CRosZN0SaDZXBXpvIXhIy0WHDXn+j2
         pcPNTEugkTvCnNAfw6l/EEkSslKVJe8hWsSX31NV+np4aqExOBY6eW02aOBz0h3Aizph
         O3azmR6LYflYr6mRbMH6BzIjRqgTM95YYGTxrsK/mZ0I57Fi/ePUcGhe1oYD/d0zUGg+
         aZM/KCqDez/cDP/U7h4RsQGzxrzQKmaZJjCYvcAtSg5zeZHYncy98DdsvOgajg1AGWDY
         e8sBLNlChD2/OdDdslk+GGgeSpJvAU7J7+LYj5RkwH3o4UDnKOxlnsI9CPJhUvg2HSEP
         hfow==
X-Gm-Message-State: AOJu0YyVMnt8bvFYyebWxYT0oBnaII3PCYmpOA7n/pw/rQgWAugRmNNs
	5e0U59Q2oPTisR2lpy+72FG6loc5zUevNfsFa8s0KF2cNhBMnmyj8hZsdZn0Ag==
X-Gm-Gg: AeBDieveux9fXdGB7leJoGSpRw1evOjsRuFq3xeddruDqSg8ZzeP1Qj5hHscKzriXLQ
	LEBwX5ApRt1aCziGX9LIJA2cOzzykzyTpD8h/hQ3Cp7cjrVEGNmhoUlHfKp9tSrwOXOzzfXHaLz
	eemUG2zdW2mEWccC+8tdTzkTs7nGaKHUGHHG/CiMJ5S6K4WWAinAUzlMNUk6hPp2IW9xUjsZjIY
	ktWgk3rgo41OBVCorLHf2yqCGOyxI5jirYiOkG7TkV6MUI+wfkdWTk8lE2lDAd1HKHASEk2JHaC
	+YxAQ5iNVtfzfJOa11y8r9VN2w62pHtXsdOHqiM4VeoCI4PVoT0azH5NHDonUZuNdmT5WpI1oHz
	xOfblIZ1tIJRqMvXwKCl14bnBztmUo08cKzWiRBgd9MuPl5QJUZYFGkhRvuqb6Di8oIRmx+kEF2
	QGFZyScLjVn7WzGjBHkyf6vMB7xipfvDX7vWIs2bY=
X-Received: by 2002:ac8:7c56:0:b0:50d:9b07:9c2b with SMTP id d75a77b69052e-50e36c8da62mr77402811cf.56.1776472349900;
        Fri, 17 Apr 2026 17:32:29 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.177.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3944e4e0sm23217721cf.20.2026.04.17.17.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 17:32:28 -0700 (PDT)
Message-Id: <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
In-Reply-To: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 Apr 2026 00:32:24 +0000
Subject: [PATCH v2 0/3] Batch prefetching
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

Changes since v1:

 * Remove stray file that should have never been added. So embarrassing that
   I didn't catch that before submitting.

Partial clones provide a trade-off for users: avoid downloading blobs
upfront, at the expense of needing to download them later as they run other
commands. This tradeoff can sometimes incur a more severe cost than
expected, particularly if needed blobs are discovered as they are accessed,
resulting in downloading blobs one at a time. Some commands like checkout,
diff, and merge do batch prefetches of necessary blobs, since that can
dramatically reduce the pain of on-demand loading. Extend this ability to
two more commands: cherry and grep.

This series was spurred by a report where git cherry jobs were each doing
hundreds of single-blob fetches, at a cost of 3s each. Batching those
downloads should dramatically speed up their jobs. (And I decided to fix up
git grep similarly while at it.)

I'll also note that git backfill with revisions and/or pathspecs could also
improve things for these users, but since backfill is a manual command users
would have to run and requires users to try to figure out which data is
needed (a challenge in the case of cherry), it still makes sense to provide
smarter behavior for folks who don't choose to manually run backfill.

Also, correct a documentation typo I noticed in patch-ids.h (related to code
I was using for the git cherry fixes) as a preparatory fixup.

Elijah Newren (3):
  patch-ids.h: add missing trailing parenthesis in documentation comment
  builtin/log: prefetch necessary blobs for `git cherry`
  grep: prefetch necessary blobs

 builtin/grep.c    | 142 ++++++++++++++++++++++++++++++++++++++++++++++
 builtin/log.c     | 125 ++++++++++++++++++++++++++++++++++++++++
 patch-ids.h       |   2 +-
 t/t3500-cherry.sh |  18 ++++++
 t/t7810-grep.sh   |  35 ++++++++++++
 5 files changed, 321 insertions(+), 1 deletion(-)


base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2089%2Fnewren%2Fbatch-prefetching-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2089/newren/batch-prefetching-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2089

Range-diff vs v1:

 1:  7f5ac5942e = 1:  663816a344 patch-ids.h: add missing trailing parenthesis in documentation comment
 2:  610be2a49a ! 2:  a705852723 builtin/log: prefetch necessary blobs for `git cherry`
     @@ builtin/log.c: int cmd_cherry(int argc,
       		char sign = '+';
       
      
     - ## investigations/cherry-prefetch-design-spec.md (new) ##
     -@@
     -+# Design Spec: Batch Blob Prefetch for `git cherry` in Partial Clones
     -+
     -+## Problem
     -+
     -+In a partial clone with `--filter=blob:none`, `git cherry` compares
     -+commits using patch IDs.  Patch IDs are computed in two phases:
     -+
     -+1. Header-only: hashes file paths and mode changes only (no blob reads)
     -+2. Full: hashes actual diff content (requires reading blobs)
     -+
     -+Phase 2 only runs when two commits have matching header-only IDs
     -+(i.e. they modify the same set of files with the same modes).  This
     -+is common — any two commits touching the same file(s) will collide.
     -+
     -+When phase 2 needs a blob that isn't local, it triggers an on-demand
     -+promisor fetch.  Each fetch is a separate network round-trip.  With
     -+many collisions, this means many sequential fetches.
     -+
     -+## Solution Overview
     -+
     -+Add a preparatory pass before the existing comparison loop in
     -+`cmd_cherry()` that:
     -+
     -+1. Identifies which commit pairs will collide on header-only IDs
     -+2. Collects all blob OIDs those commits will need
     -+3. Batch-prefetches them in one fetch
     -+
     -+After this pass, the existing comparison loop runs as before, but
     -+all needed blobs are already local, so no on-demand fetches occur.
     -+
     -+## Detailed Design
     -+
     -+### 1. No struct changes to patch_id
     -+
     -+The existing `struct patch_id` and `patch_id_neq()` are not
     -+modified.  `is_null_oid()` remains the sentinel for "full ID not
     -+yet computed".  No `has_full_patch_id` boolean, no extra fields.
     -+
     -+Key insight: `init_patch_id_entry()` stores only `oidhash()` (the
     -+first 4 bytes of the header-only ID) in the hashmap bucket key.
     -+The real `patch_id_neq()` comparison function is invoked only when
     -+`hashmap_get()` or `hashmap_get_next()` finds entries with a
     -+matching oidhash — and that comparison triggers blob reads.
     -+
     -+The prefetch needs to detect exactly those oidhash collisions
     -+*without* triggering blob reads.  We achieve this by temporarily
     -+swapping the hashmap's comparison function.
     -+
     -+### 2. The prefetch function (in builtin/log.c)
     -+
     -+This function takes the repository, the head-side commit list (as
     -+built by the existing revision walk in `cmd_cherry()`), and the
     -+patch_ids structure (which contains the upstream entries).
     -+
     -+#### 2.1 Early exit
     -+
     -+If the repository has no promisor remote, return immediately.
     -+Use `repo_has_promisor_remote()` from promisor-remote.h.
     -+
     -+#### 2.2 Swap in a trivial comparison function
     -+
     -+Save `ids->patches.cmpfn` (the real `patch_id_neq`) and replace
     -+it with a trivial function that always returns 0 ("equal").
     -+
     -+```
     -+static int patch_id_match(const void *unused_cmpfn_data,
     -+                          const struct hashmap_entry *a,
     -+                          const struct hashmap_entry *b,
     -+                          const void *unused_keydata)
     -+{
     -+    return 0;
     -+}
     -+```
     -+
     -+With this cmpfn in place, `hashmap_get()` and `hashmap_get_next()`
     -+will match every entry in the same oidhash bucket — exactly the
     -+same set that would trigger `patch_id_neq()` during normal lookup.
     -+No blob reads occur because we never call the real comparison
     -+function.
     -+
     -+#### 2.3 For each head-side commit, probe for collisions
     -+
     -+For each commit in the head-side list:
     -+
     -+- Use `patch_id_iter_first(commit, ids)` to probe the upstream
     -+  hashmap.  This handles `init_patch_id_entry()` + hashmap lookup
     -+  internally.  With our swapped cmpfn, it returns any upstream
     -+  entry whose oidhash matches — i.e. any entry that *would*
     -+  trigger `patch_id_neq()` during the real comparison loop.
     -+  (Merge commits are already handled — `patch_id_iter_first()`
     -+  returns NULL for them via `patch_id_defined()`.)
     -+- If there's a match: collect blob OIDs from the head-side commit
     -+  (see section 3).
     -+- Then walk `patch_id_iter_next()` to find ALL upstream entries
     -+  in the same bucket.  For each, collect blob OIDs from that
     -+  upstream commit too.  (Multiple upstream commits can share the
     -+  same oidhash bucket.)
     -+- Collect blob OIDs from the first upstream match too (from
     -+  `patch_id_iter_first()`).
     -+
     -+We need blobs from BOTH sides because `patch_id_neq()` computes
     -+full patch IDs for both the upstream and head-side commit when
     -+comparing.
     -+
     -+#### 2.4 Restore the original comparison function
     -+
     -+Set `ids->patches.cmpfn` back to the saved value (patch_id_neq).
     -+This MUST happen before returning — the subsequent
     -+`has_commit_patch_id()` loop needs the real comparison function.
     -+
     -+#### 2.5 Batch prefetch
     -+
     -+If the oidset is non-empty, populate an oid_array from it using
     -+`oidset_iter_first()`/`oidset_iter_next()`, then call
     -+`promisor_remote_get_direct(repo, oid_array.oid, oid_array.nr)`.
     -+
     -+This is a single network round-trip regardless of how many blobs.
     -+
     -+#### 2.6 Cleanup
     -+
     -+Free the oid_array and the oidset.
     -+
     -+### 3. Collecting blob OIDs from a commit (helper function)
     -+
     -+Given a commit, enumerate the blobs its diff touches.  Takes an
     -+oidset to insert into (provides automatic dedup — consecutive
     -+commits often share blob OIDs, e.g. B:foo == C^:foo when C's
     -+parent is B).
     -+
     -+- Compute the diff: `diff_tree_oid()` for commits with a parent,
     -+  `diff_root_tree_oid()` for root commits.  Then `diffcore_std()`.
     -+- These populate the global `diff_queued_diff` queue.
     -+- For each filepair in the queue:
     -+  - Check the userdiff driver for the file path.  If the driver
     -+    explicitly declares the file as binary (`drv->binary != -1`),
     -+    skip it.  Reason: patch-ID uses `oid_to_hex()` for binary
     -+    files (see diff.c around line 6652) and never reads the blob.
     -+    Use `userdiff_find_by_path()` (NOT `diff_filespec_load_driver`
     -+    which is static in diff.c).
     -+  - For both sides of the filepair (p->one and p->two): if the
     -+    side is valid (`DIFF_FILE_VALID`) and has a non-null OID,
     -+    check the dedup oidset — `oidset_insert()` handles dedup
     -+    automatically (returns 1 if newly inserted, 0 if duplicate).
     -+- Clear the diff queue with `diff_queue_clear()` (from diffcore.h,
     -+  not diff.h).
     -+
     -+Note on `drv->binary`: The value -1 means "not set" (auto-detect
     -+at read time by reading the blob); 0 means explicitly text (will
     -+be diffed, blob reads needed); positive means explicitly binary
     -+(patch-ID uses `oid_to_hex()`, no blob read needed).
     -+
     -+The correct skip condition is `drv && drv->binary > 0` — skip
     -+only known-binary files.  Do NOT use `drv->binary != -1`, which
     -+would also skip explicitly-text files that DO need blob reads.
     -+(The copilot reference implementation uses `!= -1`, which is
     -+technically wrong but harmless in practice since explicit text
     -+attributes are rare.)
     -+
     -+### 4. Call site in cmd_cherry()
     -+
     -+Insert the call between the revision walk loop (which builds the
     -+head-side commit list) and the comparison loop (which calls
     -+`has_commit_patch_id()`).
     -+
     -+### 5. Required includes in builtin/log.c
     -+
     -+- promisor-remote.h  (for repo_has_promisor_remote,
     -+                       promisor_remote_get_direct)
     -+- userdiff.h         (for userdiff_find_by_path)
     -+- oidset.h           (for oidset used in blob OID dedup)
     -+- diffcore.h         (for diff_queue_clear)
     -+
     -+## Edge Cases
     -+
     -+- No promisor remote: early return, zero overhead
     -+- No collisions: probes the hashmap for each head-side commit but
     -+  finds no bucket matches, no blobs collected, no fetch issued
     -+- Merge commits in head-side list: skipped (no patch ID defined)
     -+- Root commits (no parent): use diff_root_tree_oid instead of
     -+  diff_tree_oid
     -+- Binary files (explicit driver): skipped, patch-ID doesn't read
     -+  them
     -+- The cmpfn swap approach matches at oidhash granularity (4 bytes),
     -+  which is exactly what the hashmap itself uses to trigger
     -+  patch_id_neq().  This means we prefetch for every case the real
     -+  code would trigger, plus rare false-positive oidhash collisions
     -+  (harmless: we fetch a few extra blobs that won't end up being
     -+  compared).  No under-fetching is possible.
     -+
     -+## Testing
     -+
     -+See t/t3500-cherry.sh on the copilot-faster-partial-clones branch
     -+for two tests:
     -+
     -+Test 5: "cherry batch-prefetches blobs in partial clone"
     -+  - Creates server with 3 upstream + 3 head-side commits modifying
     -+    the same file (guarantees collisions)
     -+  - Clones with --filter=blob:none
     -+  - Runs `git cherry` with GIT_TRACE2_PERF
     -+  - Asserts exactly 1 fetch (batch) instead of 6 (individual)
     -+
     -+Test 6: "cherry prefetch omits blobs for cherry-picked commits"
     -+  - Creates a cherry-pick scenario (divergent branches, shared
     -+    commit cherry-picked to head side)
     -+  - Verifies `git cherry` correctly identifies the cherry-picked
     -+    commit as "-" and head-only commits as "+"
     -+  - Important: the head side must diverge before the cherry-pick
     -+    so the cherry-pick creates a distinct commit object (otherwise
     -+    the commit hash is identical and it's in the symmetric
     -+    difference, not needing patch-ID comparison at all)
     -
       ## t/t3500-cherry.sh ##
      @@ t/t3500-cherry.sh: test_expect_success 'cherry ignores whitespace' '
       	test_cmp expect actual
 3:  6dbfc7608b = 3:  8fbfe69bc4 grep: prefetch necessary blobs

-- 
gitgitgadget
