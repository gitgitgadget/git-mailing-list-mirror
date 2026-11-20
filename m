Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184669;
	b=tHjYtS4U9bDN49FV/BVGDetEwZykazM4+OuobuzXmiVYOdvE98MuUrCOswDOwWvC1JZK
	 Iu0iVNTbKM9MgxVDxsCPI35RAgTv+QuHaqulvFaoLA+ZordoYkCQ9BrpktwX5aWUbMahH
	 quOk3hhtMhpzzFaZ7ft6TJkqy7wmCVMkUhlWA0n0IYHIVmwFRdTgGN/qw+MMMeqm+LQDG
	 x9TAMcccZpL0/MNUbV2srYJMoTypcEQHsxX5lplzaaVx3NZyzLnUzYiEZ0QjlRUCE8QxU
	 9ZFdR/Gn2WUb4aIEIlupXCByXOJlAmp3OarStwy/U/fx0rNhGGOU/Q+fng7JgU5Nt7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=rlv4/ZMGT8Lk6x0dHKf4Een7NgE7NiOv+LO/PCqdLtA=;
	b=g9pQ0GQdWLXTxfPMR0i7hNKwUn9P7XC5xh0dEPPyl7S7rTKoWi6jBm6VInT5/o6agvkU
	 P5YndclSAbpTLIkwW7nseszM+LZiyaLbfn9ZAFA4rIvTuIBiK5TKyZU539gKra/7OcB7Q
	 3NVEKd9KgMBLTKifxoFKKTYKKJuj46CMkZZxOJmubX57jaBEZwLMy0GFKqTDcPhW7VZlp
	 myTwBvBPvzZUkLdq1haRNxH9jEPeZy/hO21qfvfeyOj8V0/PevJoAsp4lTlOuiv8ZBE24
	 a/QxMX2jdMH7JNuTkWqbNRN8wF+txqWkBxTrN+NxLsEmCW25h8YE9U9mrsZrvWygs0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bn5lIEUT;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4D606A32C
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEF4D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bn5lIEUT
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15dd124bbe7so2045456c88.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 06:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795184668; x=1795789468; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rlv4/ZMGT8Lk6x0dHKf4Een7NgE7NiOv+LO/PCqdLtA=;
        b=bn5lIEUTzZrIMSJnFYqfnS8q9nt8WDU7aiDrMA1QNZKWC0BYTVUGYF3Lpf6rXzO5yF
         8/pG5rNlQ7zQZxIVcSq0IdeKFzZcVUOLNhJ8nauVQkzD5SO6x/YgfCm1LNRYvnCU4nKE
         7gh8oKexcITtywbdDLdW2SEQdTmOmZmzSMuYf2VBPFoM4+jMZFKFhE4AILkJuJX1Dbvq
         kgsL7UB8IFelZjKmoCKxy8elhJEHXpNHzs8ujZNVOiTWp30U3icielrqB62ZgXXXagMG
         JvHaVDxCiJBo7qVZ/7anf8hShrupycyPPWC43p2QGgoQNN45NXHglrT/FJ5Y3lK4NvqM
         RU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795184668; x=1795789468;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlv4/ZMGT8Lk6x0dHKf4Een7NgE7NiOv+LO/PCqdLtA=;
        b=WwCpyzJ1qgixlcvc1caOACTwUi6wnzk+agfAPt481C+k87kA6epgBT/8tM8C+WYQuk
         qz5uN/o6phD71TAlFGoeFq+2FzEkdrCNtuuwVR9daAgJ/iAqwmnrivpMoqxaFODK4FlX
         AoWwoK/lY5yCSMtnvZN7Xe5h5FeevknGyyaMMtKqYcz5zJZme4s+VEicMo3gAuvJO3hG
         AUqFuKZOgBeD3Xw31INyPdmAZBsHBNqZKLc7lf0xVIwnsuoqnphsyOjh4p14UeOX6ZEb
         8Lu6gXAPGNni6SjV0//5wNFhfp+AoacTFbcDWHrebLZHb9Uk8AmZ2Gg4QD/GnCocF+fD
         K7fA==
X-Gm-Message-State: APuU4Z/rhxv7snTEDxfFi+FqHt3WXA9/4F/Y6yGkMfWxm0kumT1s3lDS
	jVLc3iul4cuJxYjMDrfagpOZGTp4l6VQ1tqk42bnXZaKZroqGHPhrqpk1SYxNFEB
X-Gm-Gg: AYBFou3/BslD6tsG9qB52+nz6LOHS+IG2/rKIssKTRdNqLIO8vqZ9bAOYcrJgVgkD6p
	QcOLK7Eq9SY9wtFveVNPV8BhH6nCFsPj09hQx5KCq7ZR3HF6N4F3WO81yASBmQ7V9vUqNvXQ9IG
	2Dfyc8zVuTB+n2QmMDglp92DnhpgZDCFEneBJ6rQesGYHt127G7Apu8MuC3YV01Vmy8vRcz4JOF
	nTENm2Hhs5bn39u/boLunxl8XBow/tJ/0uDoO4wruoC8qEeVk7EfrR3BMBEkEfQCobFeEx/cMHi
	/x0fOPDdKAd5C4OKTRuJw3KR+0YCHl5p6A0ThFoiUNv/uD5cRg6BjzUPzhgxZshWUMxAMljUr4z
	Ebr7hqur/LzMNYU4wb69wIVnN+nQc99LDgdKpDbepI9k1io0x0KP4WBwEnZ3DQNCiRyg1NGlfIk
	ZZY3mi6r58Zsa46hl37gPnoiluCXs5DTHFzEwqX8JB8eI7BFqAprKSc25uTfBFhT0VGaVWhqGBm
	CpJnV24xEDIh/XOSxBU/QYXzBLL+HQ8epJbs0T+a+b0NWjKj5mzY9UJRJP7BNu5ubs5n10S5FYx
	Ca95+Wfbamrc2ncI3XWS9n1Gh20FbA==
X-Received: by 2002:a05:7022:5f19:b0:1ae:e0f5:2cdd with SMTP id a92af1059eb24-1b556903921mr3161337c88.28.1795184667552;
        Fri, 20 Nov 2026 06:24:27 -0800 (PST)
Received: from [127.0.0.1] ([20.171.3.187])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm10135780eec.26.2026.11.20.06.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:24:25 -0800 (PST)
Message-Id: <pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 14:24:20 +0000
Subject: [PATCH v9 0/4] branch: let --delete-merged find squash merged branches
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
    Tuomas Ahola <taahol@utu.fi>,
    Harald Nordgren <haraldnordgren@gmail.com>

Branches merged on GitHub with "Squash and merge" or "Rebase and merge" are
never deleted by git branch --delete-merged, because their tips are not
reachable from the upstream. This adds git branch --delete-integrated
<pattern>, which works like --delete-merged and also deletes such a branch
when some upstream commit contains all of its changes. It names that commit
in the output:

Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).


Changes in v9:

 * Fix --delete-integrated dying with "unable to read blob object" when a
   path was a submodule at the fork point and both the branch and upstream
   replaced it with different regular files. Such a branch is now kept.
 * Add a test for that case.

Changes in v8:

 * Reword commit messages.

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
 Documentation/git-branch.adoc    |  23 +-
 builtin/branch.c                 | 363 +++++++++++++++++++++++++++++--
 t/t3200-branch.sh                | 315 +++++++++++++++++++++++++++
 4 files changed, 679 insertions(+), 30 deletions(-)


base-commit: f7de81456940dd6f3274e461149bba12965de609
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2425%2FHaraldNordgren%2Fbranch-delete-squashed-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2425/HaraldNordgren/branch-delete-squashed-v9
Pull-Request: https://github.com/git/git/pull/2425

Range-diff vs v8:

 1:  25d2441ce7 = 1:  37ef7636e0 branch: move the deleteMerged opt-out check into a helper
 2:  18c3edb6e3 = 2:  c4513f9ec1 branch: let delete_branches() name where a branch landed
 3:  7bc634c794 = 3:  1f922a0034 branch: add --delete-integrated to delete rebase and squash merged branches
 4:  22658105ed ! 4:  ef65700303 branch: let --delete-integrated find branches merged onto changed files
     @@ builtin/branch.c: static int branch_pushes_to_upstream(struct branch *branch,
       struct branch_change {
       	char *path;
      -	struct object_id branch_oid;
     +-	unsigned short branch_mode;
      +	struct object_id base_oid, branch_oid, upstream_oid;
     - 	unsigned short branch_mode;
     ++	unsigned short base_mode, branch_mode;
      +	enum change_state state;
       };
       
     @@ builtin/branch.c: static void collect_branch_changes(struct landing_search *sear
      +		       &p->one->oid : null_oid(the_hash_algo));
       		oidcpy(&change->branch_oid, DIFF_FILE_VALID(p->two) ?
       		       &p->two->oid : null_oid(the_hash_algo));
     ++		change->base_mode = p->one->mode;
       		change->branch_mode = p->two->mode;
     -@@ builtin/branch.c: static void collect_branch_changes(struct landing_search *search,
     + 	}
       	diff_flush(&diffopt);
       }
       
     @@ builtin/branch.c: static void collect_branch_changes(struct landing_search *sear
      +	if (is_null_oid(&change->base_oid) ||
      +	    is_null_oid(&change->branch_oid) ||
      +	    oideq(&change->upstream_oid, &change->base_oid) ||
     -+	    mode != change->branch_mode || !S_ISREG(mode))
     ++	    mode != change->branch_mode || !S_ISREG(mode) ||
     ++	    !S_ISREG(change->base_mode))
      +		return CHANGE_MISSING;
      +	return CHANGE_NEEDS_MERGE;
       }
     @@ t/t3200-branch.sh: test_expect_success '--delete-integrated deletes a squash mer
      +		EOF
      +	)
      +'
     ++
     ++test_expect_success '--delete-integrated keeps a branch that replaced a submodule with a file' '
     ++	(
     ++		cd upstream &&
     ++		git checkout next &&
     ++		git init lib &&
     ++		test_commit -C lib in-lib &&
     ++		git add lib &&
     ++		git commit -m "add lib as a submodule" &&
     ++		git checkout main
     ++	) &&
     ++	setup_repo_for_delete_merged &&
     ++	(
     ++		cd repo &&
     ++		git checkout -b replaces-lib --track origin/next &&
     ++		rmdir lib &&
     ++		echo "from the branch" >lib &&
     ++		git add lib &&
     ++		git commit -m "replace lib with a file" &&
     ++		git push origin replaces-lib &&
     ++		git checkout --detach
     ++	) &&
     ++	(
     ++		cd upstream &&
     ++		git checkout next &&
     ++		rm -rf lib &&
     ++		echo "from upstream" >lib &&
     ++		git add lib &&
     ++		git commit -m "replace lib with another file" &&
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
     ++		main
     ++		replaces-lib
     ++		EOF
     ++	)
     ++'
      +
       test_expect_success '--delete-integrated reports a merge plainly next to an unmerged branch' '
       	setup_repo_for_delete_merged &&

-- 
gitgitgadget
