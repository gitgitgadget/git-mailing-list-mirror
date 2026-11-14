Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662674;
	b=rA+HS7il6FZetSrj8gA05o1/ydjBoDtXLxDEQGs+u6ktcrCf/4zPVDlObiKQdlciIdcw
	 iXqlZEic7z2Pqu9S8Gon/cs5WZHZZHDz7RZE1xv/Lo/vqNTlQ4+LLtvRXXhTzKMgvnusS
	 +vjycKIrsarAYDN32fN7+ly3bwd+asE7NqDpqPiP71kh1yIHhQk7BEz0nPe+zILXgsPPf
	 fIKpRrhwqLpLYvbK8xNbhCudcYJvgA3RLq+P8DiU8RkHtJ1P692ixL5/SLixSw01LU4Lh
	 xSws7+3zqp+m1ZbBM5khuMjkrq0XYb8SFVyeUNFCNwiIFW02DVPhayJpe6vAj8FIEPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=H97GS7SY4KKMHKogUYLM72fe5AjsImPMQbCSrOSb3dE=;
	b=BNkhw7ebOGbF1g7aQHQNCl0EmYYd8CH31bE+iW3QyF1uOl2+2WjJxL9q7LaJQ7Xz6DoR
	 M9/B4XSKLyD8dE2BJNAUt+xKBJ5Lkk6KnemT+DpMZgfdLF/+loYN/xOnQ0qj1yJu/Z8uA
	 OTSt71N6dWD9hHbVgO1aaDBf3nPUJ6J3o32J04CkjXH9tw1BM88SIqhTDaTh2sl6feuJy
	 oYamSGTC+hyKA83me5xTnG9lFF+R9E/Aen0umseAU96KZLDjTuuQNsqW8DbdmMLByeb0C
	 Z/wCnCGn9s4T6d/xaNR5awfkRbHRR1j7Qc6MJrc7Yw2P7N+LmMeHcKUrBn52IWFTugA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q75+b8Cx;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED1606A327
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 13:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64ED1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q75+b8Cx
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8479f46ecd8so666203a34.0
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 05:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794662673; x=1795267473; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H97GS7SY4KKMHKogUYLM72fe5AjsImPMQbCSrOSb3dE=;
        b=Q75+b8CxLsNZkvh4VitmJSWhy4UwfzJWaSxqhY5pE+Kmvv6sh2/GbdSt48EloQxaCo
         LO1Ig1cPxavWUUHanWzkOM12/3Bt+3bdjol7qMxjKTIXAPwXhNPPLGNzTGcroUW76DD5
         BKuxM0iwf5DHML0rVNlRTkmkbYUE6bNxRdp6c2c1n4Qm2E495otTyqIi+R6fmcnd5Kjk
         knGdT1r9oYi8MmzTJNZxF0u8rSwLuiVAQDhMk5sUKpkZFqQPYZtjN37awrZFfnWiXHFV
         RVlikbOD+Hp36mwTgB9/sM+rfcL+1ElFAD4KVGu4DkReqzNVX3HeoH/2YN3nGngztJPy
         y7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794662673; x=1795267473;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H97GS7SY4KKMHKogUYLM72fe5AjsImPMQbCSrOSb3dE=;
        b=OlhyKXuytQSr1yFxyQzG8YImaFA22edPTMaJi767n2UKFTHeh2sO0AGR8KAk2t4GhJ
         Bhuhq8WN76uRkTq/d4a3bFNVgHoqdePVeUfcgsiGGbMW95dPCY1nBNUwpC5GPU54jdiW
         YOAx1YzPh+DB3N0pv9hPCyP3c0bOPR9T99XtqGXXKaaDpKHcXsLmdzgSBmd5vTOIgExQ
         63BdwCaViERpHzWnzol+IyIGr+t43paJTeg07lXg6ETFIOEWwvcLnyetnBqk7gTFSMwW
         gwLV4OmhO9Vy1TMhUMxHyO/cJKzxIiZhT40Mw241LJZIZNPDdTjHst+ZvxRHR/i5adN1
         CvAw==
X-Gm-Message-State: APuU4Z+9+yNRfIblutpnAIkZ4rMqJBjRrKuOl0AJRKT/9EW/AedBpgIW
	xD+qZ24aXejxgOEILJNZ7GOP7iYwJtZzo+CiYcetuvJuV4xFGIPO5NMwQNbFOw==
X-Gm-Gg: AYBFou09zw2wHOweUj5qxshKBkULS190stFPUrX3fAGxHNy/EJZN6sVKW3EJRxw3Ys2
	EzDCqAs+WmOnUPw0dPS8eX8jIfjF7E9701SxVRJd7GEo+XC7GHhbN0s0nSWVI0KDCMFwJ5/v7Co
	O7mg75+9WUUK3brwjQPpxkibrQaD+QbPdKIgYcfvXIzKsSSc31U8SHLAqm93E3mw2SLk+dX5t7s
	FEVD8AP0/ZJfcymoS2whPvw+IECnW9XgmkAnVL55PDM/IOApau8l6tzzpeLdrKVhvvEm6Afflor
	cnAdXFkI6faxCa8m5snh9fIp2jaEKN+NFumsgt2he+qOlptD/BCtXVDDWuW0jTnjd+yhCwt+s7k
	Z0iayXWMJyIFe8sYwTN7sI691fiKkRWup1Ww3qqHiBGfIgtLb2na1V3SWCWDzrjCOjmZMHTOo0I
	bJW5Uexa4HV1lgecRNyC1IjRWTUTy52gPmq9cJGWDXz5dYGkIOMUFVTp8qzDhrJ3Nu2KV+iB5hg
	Jb2YxnwRzg7L/+qznvQSrIVbbGr8FfXEtS1PzH1jFjjlyWtqE17H7V/ob03ff2+M7kggfjTt0iW
	L/IlikbXo6a0kaPFYnKxNgenyTkR/1cypHsIJysSN0TcISa5tt4a6Q==
X-Received: by 2002:a05:6808:152b:b0:53b:1d13:dffd with SMTP id 5614622812f47-56e6059f865mr4512325b6e.7.1794662673142;
        Sat, 14 Nov 2026 05:24:33 -0800 (PST)
Received: from [127.0.0.1] ([20.64.107.197])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7024673csm4866790b6e.8.2026.11.14.05.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 05:24:31 -0800 (PST)
Message-Id: <pull.2425.v7.git.git.1794662670.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 14 Nov 2026 13:24:26 +0000
Subject: [PATCH v7 0/4] branch: let --delete-merged find squash merged branches
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jasper Mayone <me@jaspermayone.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Branches merged on GitHub with "Squash and merge" or "Rebase and merge" are
never deleted by git branch --delete-merged, because their tips are not
reachable from the upstream. This treats such a branch as merged when some
upstream commit contains all of its changes, and names that commit in the
output:

Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).


Changes in v7:

 * Added a test that --delete-integrated keeps a branch whose changes did
   not land.
 * Read the index once before the walk in find_landed_commits(), instead of
   for every file merge at every candidate commit.
 * The commit message now says the merge uses this repository's attributes
   from the working tree and the index.

Changes in v6:

 * Read the index before the file merge, so .gitattributes that are only in
   the index are honored too.
 * Renamed the diff_options variables from opt to diffopt.

Changes in v5:

 * git branch -h lists --delete-integrated in the usage lines
 * Giving both --delete-merged and --delete-integrated dies with a short
   "cannot be used together" message instead of the full usage text

Changes in v4:

 * --delete-merged works as it does on master again: it only deletes
   branches whose tip is reachable from their upstream
 * New --delete-integrated <pattern> also deletes branches that were rebase
   or squash merged, including those squashed after upstream changed the
   same files. It replaces --squashed
 * New prep commit lets delete_branches() take a map of where each branch
   landed, so "landed as" is printed there
 * Added Junio's test that --delete-merged keeps a branch when an unrelated
   upstream commit adds an identical file
 * --dry-run works with either option, and the two options can't be combined

Changes in v3:

 * Split into multiple commits, one for rebase merges and one for squash
   merges.
 * By default a branch counts as merged when an upstream commit has its
   exact version of every file it changed. This never reads file contents,
   so it stays cheap in a partial clone. It finds rebase merges, and squash
   merges where upstream left those files alone.
 * Replace --no-squashed with an opt-in --squashed, which also finds
   branches merged after upstream changed the same files by merging those
   files.
 * Add a test for a rebase merge, and check that a squash onto changed files
   is kept without --squashed and deleted with it.

Changes in v2:

 * Diff each upstream commit once and share the result between all branches,
   faster than v1.
 * Fix a branch merged with a merge commit being reported as "landed as" the
   merge when another branch was searched first, and add a test for it. Show
   the topic commit itself in "landed as" for work that arrived through a
   merge.
 * Use git merge --squash as the example in the commit message and mention
   GitHub's squash and rebase buttons.
 * Add --no-squashed to skip the squash search.

Harald Nordgren (4):
  branch: move the deleteMerged opt-out check into a helper
  branch: let delete_branches() name where a branch landed
  branch: add --delete-integrated to delete rebase and squash merged
    branches
  branch: let --delete-integrated find branches merged onto changed
    files

 Documentation/config/branch.adoc |   8 +-
 Documentation/git-branch.adoc    |  22 +-
 builtin/branch.c                 | 361 +++++++++++++++++++++++++++++--
 t/t3200-branch.sh                | 271 +++++++++++++++++++++++
 4 files changed, 632 insertions(+), 30 deletions(-)


base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2425%2FHaraldNordgren%2Fbranch-delete-squashed-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2425/HaraldNordgren/branch-delete-squashed-v7
Pull-Request: https://github.com/git/git/pull/2425

Range-diff vs v6:

 1:  e728b4ed0d = 1:  25d2441ce7 branch: move the deleteMerged opt-out check into a helper
 2:  9858c8c81e = 2:  18c3edb6e3 branch: let delete_branches() name where a branch landed
 3:  92bd9afda4 = 3:  7bc634c794 branch: add --delete-integrated to delete rebase and squash merged branches
 4:  006a57d7d1 ! 4:  4b5485584e branch: let --delete-integrated find branches merged onto changed files
     @@ Commit message
          unchanged. This has to read the files, so in a partial clone it may
          download blobs.
      
     +    The merge uses the attributes of this repository, from the working tree
     +    and the index, the same as a merge run here would. A merge driver that
     +    only the upstream repository has is not seen. In a bare repository only
     +    info/attributes and the global file apply.
     +
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/git-branch.adoc ##
     @@ builtin/branch.c: static void collect_branch_changes(struct landing_search *sear
      +	mmfile_t result = { 0 };
      +	int ret;
      +
     -+	repo_read_index(the_repository);
      +	read_mmblob(&base, the_repository->objects, &change->base_oid);
      +	read_mmblob(&upstream, the_repository->objects, &change->upstream_oid);
      +	read_mmblob(&branch, the_repository->objects, &change->branch_oid);
     @@ builtin/branch.c: static void collect_branch_changes(struct landing_search *sear
       	return 1;
       }
       
     +@@ builtin/branch.c: static void find_landed_commits(struct landing_search *searches,
     + 	diffopt.no_free = 1;
     + 	diff_setup_done(&diffopt);
     + 	init_changed_paths(&cache);
     ++	repo_read_index(the_repository);
     + 
     + 	for (size_t i = 0; i < searches_nr; i++) {
     + 		struct commit *landed;
      
       ## t/t3200-branch.sh ##
      @@ t/t3200-branch.sh: test_expect_success '--delete-integrated deletes a squash merged branch that was
     @@ t/t3200-branch.sh: test_expect_success '--delete-integrated deletes a squash mer
      +		EOF
      +	)
      +'
     ++
     ++test_expect_success '--delete-integrated keeps branches whose changes did not land' '
     ++	(
     ++		cd upstream &&
     ++		git checkout next &&
     ++		test_write_lines 1 2 3 4 5 6 7 8 9 10 >doc &&
     ++		git add doc &&
     ++		git commit -m "add doc" &&
     ++		git checkout main
     ++	) &&
     ++	setup_repo_for_delete_merged &&
     ++	(
     ++		cd repo &&
     ++		git checkout -b unmerged --track origin/next &&
     ++		test_write_lines 1 2 3 4 5 6 7 eight 9 10 >doc &&
     ++		git commit -a -m "edit line 8" &&
     ++		git push origin unmerged &&
     ++		git checkout -b half-landed --track origin/next &&
     ++		test_write_lines one 2 3 4 5 6 7 8 9 ten >doc &&
     ++		git commit -a -m "edit lines 1 and 10" &&
     ++		git push origin half-landed &&
     ++		git checkout -b conflicting --track origin/next &&
     ++		test_write_lines 1 2 three 4 5 6 7 8 9 10 >doc &&
     ++		git commit -a -m "edit line 3" &&
     ++		git push origin conflicting &&
     ++		git checkout --detach
     ++	) &&
     ++	(
     ++		cd upstream &&
     ++		git checkout next &&
     ++		test_write_lines 1 2 3 4 five 6 7 8 9 10 >doc &&
     ++		git commit -a -m "edit line 5" &&
     ++		test_write_lines one 2 3 4 five 6 7 8 9 10 >doc &&
     ++		git commit -a -m "take line 1 from half-landed" &&
     ++		test_write_lines one 2 THREE 4 five 6 7 8 9 10 >doc &&
     ++		git commit -a -m "edit line 3 differently" &&
     ++		git checkout main
     ++	) &&
     ++	(
     ++		cd repo &&
     ++		git fetch origin &&
     ++
     ++		git branch --delete-integrated origin/next >actual 2>&1 &&
     ++		test_must_be_empty actual &&
     ++
     ++		check_branches <<-\EOF
     ++		conflicting
     ++		half-landed
     ++		main
     ++		unmerged
     ++		EOF
     ++	)
     ++'
      +
       test_expect_success '--delete-integrated reports a merge plainly next to an unmerged branch' '
       	setup_repo_for_delete_merged &&

-- 
gitgitgadget
