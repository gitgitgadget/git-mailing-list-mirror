Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357586;
	b=wUmsPmKE7jWo54AXmWfTceJtSmBHhMA2ebwkJNdldHp0zr1WrKqZKMPxy6Nf2x6TC1ef
	 TRe7cGueCKh9OpRPkGqvpyjwlTzxBqlqnQFaFIBMnvBenFDFclgw5RTOmQ3NlW6IpgMhd
	 /QSIOTiub59tBVDsF+ydHyonPzgpq5OGqufkYh3CNXlcIAsObCTBQhyuClkKLd3SOVp0o
	 sYra+3jLOAJ2+bRXBQWUZD8ZntfORWUCqrGyn+4mLRThJj9bn5Ufs+t5WqEu61t3e7L3R
	 VcMG7Gqag0YUmV7dPve2cXiEfKpbUBr/mBECa1NGW4Kh/WqyK5LrsO8MZW89rEHMu4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=XyBH980KXRNeJ2MbT5MwM32P/ZqK8gn3MvoLXOAfC9Q=;
	b=N7o/BXgTR+FtuXy/I7FARTC94mlU1/NC4LM6l51kgdJj9qkJ2EXBH483nGcxotX4shC3
	 /KihlPITmK/dR+QQB6w9RQ0p3xeyRlf7uQJCdGxbcsbRbJtrTRetSOZvbPgv5pawn68//
	 0tg2+/JS/hmGLiIVNtl5I0WMKx0BtlJ1EzuwgaPfXLTzb5LW5jlDZh8Uv9keXoZqXMxBf
	 zRIZcyROdettlO1t0zVCb3k5ey4jRmb51cyrlDvbhF0EACvgngX0eIOeBfIgyse7RuoFN
	 MjTPszM+fw+fAuyGsIdQNzkA9lNk7oLpRcbfnbAR1TW4b29T827Ys1K6Q8/3Z0eM7Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KN6aBYag;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8350460706B3
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8350460706B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KN6aBYag
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-451a49abd8aso566630fac.3
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357585; x=1793962385; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XyBH980KXRNeJ2MbT5MwM32P/ZqK8gn3MvoLXOAfC9Q=;
        b=KN6aBYag8wem/WgcR2eia9KYVYp8bBQ6c9L0KUdDUSh1p08VlY7cafmd1r2tiT4Khz
         zyRlTLa2Nq57F0DtH9oxNHxvbHiZW1poHx5bqllVsoJ5Y/9gDjsbO37yBUnfSZh0b3Si
         jgnvrKYbefqYiEyN6UmEPoAK9I7H4Bg9KokOsvnzItYLXJovnZM5qAANyC/8Uw1eTxso
         EKds2hdv974mWPmuOqbbxUHAynHsqbuj6zijNdKO5wbL9ykny07ywV0CNG57/qNtznwv
         cNv8oUuZFUr3xn/yPVDnA3vNswj2/lA02695XczLSNuwAoKnUZnFw3RWOjbhVxr7vUVb
         fDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357585; x=1793962385;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XyBH980KXRNeJ2MbT5MwM32P/ZqK8gn3MvoLXOAfC9Q=;
        b=Oia9Y2UwRCcFeeQvRcbWxUMm2rOAp73AFFjjv2r8mwLbj3UMgDXtdgFBqsGBYkMJ6m
         /peBzCRVQHnDwpCeEl/JaYyaqEkQxGN1itTcjt9Ollz3F4apLf7iMQ+fHS8vjzNCwR4G
         C1Zzq/3zyn/idD45gX0TBKXpODNBN7n59WkZNnlNYZKluFuQrhPE8/e1k9Xb0s471KN2
         /5ChWtW+iO9kp1pGY3taFl3FIvzpH4tLE9HpUE5F+Il8NiUGcP0PEv5tcO00f7Hm5xXH
         fLb+a/LWNlfMY0UANOdKhH093gfewyz/ZDPWx/hJA1+sdfRKDgictnUslZ/DSJ0DwvKs
         JMvA==
X-Gm-Message-State: AFq9FYIG+AxMU+QDHQKif2OnVdRakiroPu0pl1xa0tvIaI3iBpZzM5Xd
	OYQp0ApoCHmeO2YQ8E2EZy9WkQX/RujejRruC35W4ScNksPvM/U0yEMPI6Sul7xX1/w=
X-Gm-Gg: AYBFou2Q0Lb+YHFdmMaB1xnYe9j6k87c19I8aa9YlWHPMJOCOxCbbP5Bt1mxfODzBNa
	PPALhNLuNJuwgbqezCFJUo36T2iVQ9r0v2Dw94JlQuBK2+E5HEiGiMEbxcaAyxWvhHAIWUXV2sP
	D0uL7qjsgJvTM4MSDEV+HagkEv9wofnEY9Ku25ePaKhNYobKb6BLbX/9HsosJUCVT4MKt1DRLDV
	UjiqNtT5dbTf9tANgHY61MubeARTgomWPPGQMV6bhQ4v2sVQQf2xndN1wQ8bWRM4TF6f3TiI5y4
	g2kXiZdEBmqkt6LZdYxRqRjM6t9+6zByfwGNaOXhTpwdcaDlnz9K/K6hNHo3PDMMa5im1BBmrNy
	16wWfGj0bMKMfSar0QvuDg8ccBFIhI3PI4VVPxwA7Rwsw9z6TKTNePkmm8Ae/SDn+w51zYJhWmJ
	NAnC+KxZUCXfG0MKl1xUHajXK2OcR746difTA9GW4qO+sk7prnWYlKl+u3KX6jKERb8h4soStlz
	d5tKHzHaFqwXI5AVyqcJM69RTl5kS9t66n+TiQPDR2126dz/ByRSYagJlIn44x9QWbUAmGVPZiN
	Jc5SqngEfwr9kO1YdoBzUWOIgynrtCQj5lhgZ1nQY479zdJG1by/Ni0=
X-Received: by 2002:a05:6871:4b0b:b0:47d:f10:686f with SMTP id 586e51a60fabf-4a9076b74efmr1165067fac.23.1793357585453;
        Fri, 30 Oct 2026 03:53:05 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.62.244])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a90ae4dd00sm1500623fac.5.2026.10.30.03.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:53:04 -0700 (PDT)
Message-Id: <pull.2425.v5.git.git.1793357582.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 10:52:58 +0000
Subject: [PATCH v5 0/4] branch: let --delete-merged find squash merged branches
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
 builtin/branch.c                 | 360 +++++++++++++++++++++++++++++--
 t/t3200-branch.sh                | 218 +++++++++++++++++++
 4 files changed, 578 insertions(+), 30 deletions(-)


base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2425%2FHaraldNordgren%2Fbranch-delete-squashed-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2425/HaraldNordgren/branch-delete-squashed-v5
Pull-Request: https://github.com/git/git/pull/2425

Range-diff vs v4:

 1:  1d01085b75 = 1:  090aec5725 branch: move the deleteMerged opt-out check into a helper
 2:  592562d7e7 = 2:  24180bf4a2 branch: let delete_branches() name where a branch landed
 3:  deb1e649cf ! 3:  bf30f57ceb branch: add --delete-integrated to delete rebase and squash merged branches
     @@ builtin/branch.c
       
       static const char * const builtin_branch_usage[] = {
       	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
     +@@ builtin/branch.c: static const char * const builtin_branch_usage[] = {
     + 	N_("git branch [<options>] [-r | -a] [--format]"),
     + 	N_("git branch [<options>] (--delete-merged <pattern>)... "
     + 	   "[<branch-pattern>...]"),
     ++	N_("git branch [<options>] (--delete-integrated <pattern>)... "
     ++	   "[<branch-pattern>...]"),
     + 	NULL
     + };
     + 
      @@ builtin/branch.c: enum delete_branch_flags {
       	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
       	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
     @@ builtin/branch.c: int cmd_branch(int argc,
       
       	if (filter.with_commit || filter.no_commit ||
      @@ builtin/branch.c: int cmd_branch(int argc,
     + 	    filter.points_at.nr || filter.forked.nr)
     + 		list = 1;
       
     ++	die_for_incompatible_opt2(!!delete_merged.nr, "--delete-merged",
     ++				  !!delete_integrated.nr, "--delete-integrated");
     ++
       	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
       			    !!show_current + !!list + !!edit_description +
      -			    !!unset_upstream + !!delete_merged.nr;
     @@ t/t3200-branch.sh: test_expect_success '--dry-run without --delete-merged is rej
       
      +test_expect_success '--delete-integrated cannot be combined with --delete-merged' '
      +	test_must_fail git -C forked branch --delete-merged origin/next \
     -+		--delete-integrated origin/next
     ++		--delete-integrated origin/next 2>err &&
     ++	test_grep "cannot be used together" err
      +'
      +
       test_done
 4:  19a9630c13 = 4:  9443055242 branch: let --delete-integrated find branches merged onto changed files

-- 
gitgitgadget
