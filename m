Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334886255
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977960; cv=none; b=cQjmTPylmgWWMaBdzUcARa5zQbNVyJN8DTqryQExMoYbMCEDECeEiUU1rfQv2y7yQICSUZoTaSiJsiSts6g61jM3RL1luBIoRuMr4/V/LvbVIwbr+0FJ2PuGFLGLHFYVJQKwXAHLYUg/D0sicDV7Fd1ayvIvrTNyf0xO+ZflWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977960; c=relaxed/simple;
	bh=oNu/hPOdGS7b+rHZwIzTRLKnDEvzAB3TCLMGbOKKRv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1SLZB0iOGvHw+tCCcyrDM2aYDiLynTScsQzt6vx4Sk5yZq8l9HpI97FDp+rQtOIB80GOdDEZjEYm6CRzdwVEIj4aD2FgFWTtUN8FyMPOc+kkxQF0J9GKMPQro6YTIbUGblyh3w6B9BB4ZD2cZQV0SG9+lw7KCLJfm3NJRMyOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npEnjFBW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npEnjFBW"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78850ab4075so18743685a.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710977957; x=1711582757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJVwRAzmp+d9Tnz6YseAaK2s9JICFyBMdLB4S0pQyqI=;
        b=npEnjFBW7hQ6aE5KoFKWsyVSVyJxzjJQQKCwHygXpAmDd/CjHWGf5upLI8Tu9mLpZh
         lIk857JGHKNvFofa7+wQFPQe83xYdWhWLx4ji93ObBJE1PrZzbctc4sc8xlrE7/omQ4A
         ZGNMKekhJCNBjF+WhJykr/0k0XbDnUo8cGVbr5SmF7S34iWZ7qb7xu0L2WhIZACtrPTz
         b8XYY+pltjC0N2k7yiEdjm2ppm/fGUDYM8tYRzv11CSsF4eLR20TLnoouTIZN8+COUDQ
         C1TGHbPlj50vMCpUn5sHGuiXre5rAyPGx5jZMLBoIRHnHW1tGRb/L5Mti/ZnohHC/TAx
         cFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710977957; x=1711582757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJVwRAzmp+d9Tnz6YseAaK2s9JICFyBMdLB4S0pQyqI=;
        b=sza5YbVWv44wbCvMZ3zLMsCsVosHE2ldljvl7g4kmDDq9xX2nlny9RF3qYWXZY8U9S
         fxOf5TT7asG9HdbyFLnJA1+n56Ba5tiksS7fgGUmfF6SyYULEix2Sp99Igf7LbweKlXc
         DwJlJQpqDVSna3Hrn4UmIzb0Ayao54lhh3EhPM1N+eixsIOPCPWySVIlrNeKXb6DGLH5
         awTe7/z8EvuCRTbX1gEE98CiSWGhdVtjhIjjVddWdegvHuoF8LPl4slLkW1UcLf8KtAl
         lO24Iv5TfkQXICZ4othYMvH8GHl2Y0YiH8hL4BhWGwhuIsrc9POZJbtemkyiEL0GW1pq
         EsRQ==
X-Gm-Message-State: AOJu0YyZRAHUpjkPEgiOpjLfJrq2pKVFIvgqUqlpLAFdXUO6EYcwT6tY
	Nhv2d0uSENffb/TuH4XX1tw/04Vp3wAN/vPQC9LQE97wAXnNQH8TgDvfj0LXBO8=
X-Google-Smtp-Source: AGHT+IEZ8jXCQlzzYQt02ItCBH5a/yxKmkmSdQCxDaXanP09eWvDfNbqoNPpoZG5knw/2PBLkiMrFQ==
X-Received: by 2002:a05:620a:21c4:b0:78a:280c:219 with SMTP id h4-20020a05620a21c400b0078a280c0219mr2495701qka.38.1710977957022;
        Wed, 20 Mar 2024 16:39:17 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b0078a0edbaa94sm2400867qkj.91.2024.03.20.16.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 16:39:16 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 4/7] sequencer: handle unborn branch with `--allow-empty`
Date: Wed, 20 Mar 2024 18:36:59 -0500
Message-ID: <20240320233724.214369-5-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using git-cherry-pick(1) with `--allow-empty` while on an unborn
branch, an error is thrown. This is inconsistent with the same
cherry-pick when `--allow-empty` is not specified.

Detect unborn branches in `is_index_unchanged`. When on an unborn
branch, use the `empty_tree` as the tree to compare against.

Add a new test to cover this scenario. While modelled off of the
existing 'cherry-pick on unborn branch' test, some improvements can be
made:

- Use `git switch --orphan unborn` instead of `git checkout --orphan
  unborn` to avoid the need for a separate `rm -rf *` call
- Avoid using `--quiet` in the `git diff` call to make debugging easier
  in the event of a failure. Use simply `--exit-code` instead.

Make these improvements to the existing test as well as the new test.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---

Changes from v3:

- More robustly validate that we are on an unborn branch, rather than
  assuming that an error while reading the HEAD implies an unborn branch
- Replace `--quiet` with `--exit-code` in the tests rather than just
  removing `--quiet`, to ensure that the test still fails appropriately
  if any differences are found.

 sequencer.c                   | 39 ++++++++++++++++++++++-------------
 t/t3501-revert-cherry-pick.sh | 14 ++++++++++---
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f49a871ac0..f31d71ebad 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -770,29 +770,40 @@ static struct object_id *get_cache_tree_oid(struct index_state *istate)
 static int is_index_unchanged(struct repository *r)
 {
 	struct object_id head_oid, *cache_tree_oid;
+	const struct object_id *head_tree_oid;
 	struct commit *head_commit;
 	struct index_state *istate = r->index;
+	const char *head_name;
 
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
-		return error(_("could not resolve HEAD commit"));
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
+		/*
+		 * Check to see if this is an unborn branch
+		 */
+		head_name = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE, &head_oid, NULL);
+		if (!head_name || !starts_with(head_name, "refs/heads/") || !is_null_oid(&head_oid))
+			return error(_("could not resolve HEAD commit"));
+		head_tree_oid = the_hash_algo->empty_tree;
+	} else {
+		head_commit = lookup_commit(r, &head_oid);
 
-	head_commit = lookup_commit(r, &head_oid);
+		/*
+		 * If head_commit is NULL, check_commit, called from
+		 * lookup_commit, would have indicated that head_commit is not
+		 * a commit object already.  repo_parse_commit() will return failure
+		 * without further complaints in such a case.  Otherwise, if
+		 * the commit is invalid, repo_parse_commit() will complain.  So
+		 * there is nothing for us to say here.  Just return failure.
+		 */
+		if (repo_parse_commit(r, head_commit))
+			return -1;
 
-	/*
-	 * If head_commit is NULL, check_commit, called from
-	 * lookup_commit, would have indicated that head_commit is not
-	 * a commit object already.  repo_parse_commit() will return failure
-	 * without further complaints in such a case.  Otherwise, if
-	 * the commit is invalid, repo_parse_commit() will complain.  So
-	 * there is nothing for us to say here.  Just return failure.
-	 */
-	if (repo_parse_commit(r, head_commit))
-		return -1;
+		head_tree_oid = get_commit_tree_oid(head_commit);
+	}
 
 	if (!(cache_tree_oid = get_cache_tree_oid(istate)))
 		return -1;
 
-	return oideq(cache_tree_oid, get_commit_tree_oid(head_commit));
+	return oideq(cache_tree_oid, head_tree_oid);
 }
 
 static int write_author_script(const char *message)
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index aeab689a98..af73227512 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -104,11 +104,19 @@ test_expect_success 'revert forbidden on dirty working tree' '
 '
 
 test_expect_success 'cherry-pick on unborn branch' '
-	git checkout --orphan unborn &&
+	git switch --orphan unborn &&
 	git rm --cached -r . &&
-	rm -rf * &&
 	git cherry-pick initial &&
-	git diff --quiet initial &&
+	git diff --exit-code initial &&
+	test_cmp_rev ! initial HEAD
+'
+
+test_expect_success 'cherry-pick on unborn branch with --allow-empty' '
+	git checkout --detach &&
+	git branch -D unborn &&
+	git switch --orphan unborn &&
+	git cherry-pick initial --allow-empty &&
+	git diff --exit-code initial &&
 	test_cmp_rev ! initial HEAD
 '
 
-- 
2.43.2

