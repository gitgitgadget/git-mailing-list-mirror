Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE97317CE
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707782962; cv=none; b=Abxj++usWKW8HmNUoQvoEshEF8xtLNa/9yTLiiq19n2JDNkEU532fTELWpiz0YGSAwwq/iG1lDZM/YffJhYmT4T2EhlWVp2x1gtJixi4NMvIaQVMKSvgupaP+gKd/lGsr7Za8vCcpO97RrWazfjOlVIzaGEjRKg9CizYroFRUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707782962; c=relaxed/simple;
	bh=n145+/KXEKqyVEuZGoDC1F+DtaANgltKGfgaaxveIIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2ZrJ4NJK2Kt6WGtXYSFpSU5VGRQ5XxbdD+zHJx6O6jfpwAgZKVPHaFW3pwL25fz1ndJlU4kidWsvNUhWDkfzIIiNKbKAPB8MlC2BJsfDduUSmnW809TYTCA7wzoKvG53xu07t0GcgTrD5IxhUi7ZPBYyaQVyK5a7HTZ0dkhrSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbILMccn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbILMccn"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-295c67ab2ccso2167537a91.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 16:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707782960; x=1708387760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFr+hUsjXwqyRzCGFaDyZy9FVAGXqkBR0SaBXs9dLVs=;
        b=PbILMccnp18e1JgwZ5vrDEVABZGNWcwvRAVrkIwE58Ly6QrVOoWj/L8PZ9UJ3LHCwm
         a20iM/lmKRzo7uGP2WAPNyAl0hLX17U9QMrQ9jNQqw3f/9zBvhryNaUEf3Ok0i0EuBit
         6dZvbdeJ8CYHG8xwMP9AaldJ1gdGRevMOiRj7DUtBomvtnaUktcVFiEoAXOY9eLDP37U
         lNTQx+l2XVYJlMf/nLZ+AA2JakbJmuEbeh4E+owdbyk6bDdnxsE/hRWbZ6rdu4ZqyLN0
         GNgHW22l2tr8PouiyfNGgNsaAQx6usoTQXaHY/vIEqWA5POtACMT0ePrQx0onsn0oDBN
         QguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707782960; x=1708387760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFr+hUsjXwqyRzCGFaDyZy9FVAGXqkBR0SaBXs9dLVs=;
        b=qzdoitsVONe+BiR3+jpCuQBO3wEW8P2PV0Ug1VBYA8Q++NxuhIxe/xO2bMv9ruy7SX
         e5YdeW7N9pHLbWxfgc+yEU9/awyRoxCPl5/eS6xuYO1ZrcXLEXlPXsNdC5c5f6l2Xpoz
         8L1zejO4Hxv8jyO2XPNeQdcGQFREH5i3te6uw2BlUIIrWEN6tNWtnh+RB8yfeLiIPKGj
         hJPA7ad7xhIaBmL5j6KD9NKm3QDQR6yKOVEcPMExUoMrEJCDIdvGCpbPkA6+LVepHQkm
         gF7g/7OqlMV+2wINGc68+va6WUBr5yrGyJAS569wrKmOB1CGL4d5i7Xj5w/qh7VA2AF8
         s+9w==
X-Gm-Message-State: AOJu0YxQiC8/sQTQVG7iVMAxDj1bGELncXYYCXicxmjxrosLcvuB2m/W
	7aLTffDsVKViRSkwrStRYnyS5qrpdmMQWumchmXhQxHt4nrTpGrrpDwbyltiMc4=
X-Google-Smtp-Source: AGHT+IGIg6d/QGdX7w6brnBfYoODt6T3MnT8tmUlI3kBovqL9jmUDsAh4MJ2TZrUPz0mjvjLfB72Hw==
X-Received: by 2002:a17:90a:c58b:b0:297:285e:9a93 with SMTP id l11-20020a17090ac58b00b00297285e9a93mr2958051pjt.46.1707782959693;
        Mon, 12 Feb 2024 16:09:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXHiuUG6qBJzVyw/oPYSSpUmXwCY5rTjO9ZDiMyE4IZj7sdyo5Jcx7eZhoTnzuEzgbeA7zJdWDWmHYu2NbbHwu63XuVWeD/MK0/pOrTsCZza0b5h+vWsjmvww+F1bqkAnstuOC6o6oEEm4+jRY54Jw0koOJMgoA+hKoNFZd82essodUmvRFYqU3
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090acb1500b00296b57ac914sm1097980pjt.38.2024.02.12.16.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 16:09:19 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v6 1/2] add-patch: classify '@' as a synonym for 'HEAD'
Date: Tue, 13 Feb 2024 05:35:29 +0530
Message-ID: <20240213000601.520731-4-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211202035.7196-2-shyamthakkar001@gmail.com>
References: <20240211202035.7196-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, (restore, checkout, reset) commands correctly take '@' as a
synonym for 'HEAD'. However, in patch mode different prompts/messages
are given on command line due to patch mode machinery not considering
'@' to be a synonym for 'HEAD' due to literal string comparison with
the word 'HEAD', and therefore assigning patch_mode_($command)_nothead
and triggering reverse mode (-R in diff-index). The NEEDSWORK comment
suggested comparing commit objects to get around this. However, doing
so would also take a non-checked out branch pointing to the same commit
as HEAD, as HEAD. This would cause confusion to the user.

Therefore, after parsing '@', replace it with 'HEAD' as reasonably
early as possible. This also solves another problem of disparity
between 'git checkout HEAD' and 'git checkout @' (latter detaches at
the HEAD commit and the former does not).

Trade-offs:
- Some of the errors would show the revision argument as 'HEAD' when
  given '@'. This should be fine, as most users who probably use '@'
  would be aware that it is a shortcut for 'HEAD' and most probably
  used to use 'HEAD'. There is also relevant documentation in
  'gitrevisions' manpage about '@' being the shortcut for 'HEAD'. Also,
  the simplicity of the solution far outweighs this cost.

- Consider '@' as a shortcut for 'HEAD' even if 'refs/heads/@' exists
  at a different commit. Naming a branch '@' is an obvious foot-gun and
  many existing commands already take '@' for 'HEAD' even if
  'refs/heads/@' exists at a different commit or does not exist at all
  (e.g. 'git log @', 'git push origin @' etc.). Therefore this is an
  existing assumption and should not be a problem.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 add-patch.c                |  8 -------
 builtin/checkout.c         |  4 +++-
 builtin/reset.c            |  4 +++-
 t/t2016-checkout-patch.sh  | 46 +++++++++++++++++++++-----------------
 t/t2020-checkout-detach.sh | 12 ++++++++++
 t/t2071-restore-patch.sh   | 18 +++++++++------
 t/t7105-reset-patch.sh     | 16 ++++++++-----
 7 files changed, 65 insertions(+), 43 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 79eda168eb..68f525b35c 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1729,14 +1729,6 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	if (mode == ADD_P_STASH)
 		s.mode = &patch_mode_stash;
 	else if (mode == ADD_P_RESET) {
-		/*
-		 * NEEDSWORK: Instead of comparing to the literal "HEAD",
-		 * compare the commit objects instead so that other ways of
-		 * saying the same thing (such as "@") are also handled
-		 * appropriately.
-		 *
-		 * This applies to the cases below too.
-		 */
 		if (!revision || !strcmp(revision, "HEAD"))
 			s.mode = &patch_mode_reset_head;
 		else
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a6e30931b5..067c251933 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1224,7 +1224,9 @@ static void setup_new_branch_info_and_source_tree(
 	struct tree **source_tree = &opts->source_tree;
 	struct object_id branch_rev;
 
-	new_branch_info->name = xstrdup(arg);
+	/* treat '@' as a shortcut for 'HEAD' */
+	new_branch_info->name = !strcmp(arg, "@") ? xstrdup("HEAD") :
+						    xstrdup(arg);
 	setup_branch_path(new_branch_info);
 
 	if (!check_refname_format(new_branch_info->path, 0) &&
diff --git a/builtin/reset.c b/builtin/reset.c
index 8390bfe4c4..f0bf29a478 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -281,7 +281,9 @@ static void parse_args(struct pathspec *pathspec,
 			verify_filename(prefix, argv[0], 1);
 		}
 	}
-	*rev_ret = rev;
+
+	/* treat '@' as a shortcut for 'HEAD' */
+	*rev_ret = !strcmp("@", rev) ? "HEAD" : rev;
 
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 747eb5563e..c4f9bf09aa 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -38,26 +38,32 @@ test_expect_success 'git checkout -p with staged changes' '
 	verify_state dir/foo index index
 '
 
-test_expect_success 'git checkout -p HEAD with NO staged changes: abort' '
-	set_and_save_state dir/foo work head &&
-	test_write_lines n y n | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_saved_state dir/foo
-'
-
-test_expect_success 'git checkout -p HEAD with NO staged changes: apply' '
-	test_write_lines n y y | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head head
-'
-
-test_expect_success 'git checkout -p HEAD with change already staged' '
-	set_state dir/foo index index &&
-	# the third n is to get out in case it mistakenly does not apply
-	test_write_lines n y n | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head head
-'
+for opt in "HEAD" "@"
+do
+	test_expect_success "git checkout -p $opt with NO staged changes: abort" '
+		set_and_save_state dir/foo work head &&
+		test_write_lines n y n | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_saved_state dir/foo &&
+		test_grep "Discard" output
+	'
+
+	test_expect_success "git checkout -p $opt with NO staged changes: apply" '
+		test_write_lines n y y | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head head &&
+		test_grep "Discard" output
+	'
+
+	test_expect_success "git checkout -p $opt with change already staged" '
+		set_state dir/foo index index &&
+		# the third n is to get out in case it mistakenly does not apply
+		test_write_lines n y n | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head head &&
+		test_grep "Discard" output
+	'
+done
 
 test_expect_success 'git checkout -p HEAD^...' '
 	# the third n is to get out in case it mistakenly does not apply
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 8202ef8c74..bce284c297 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -45,6 +45,18 @@ test_expect_success 'checkout branch does not detach' '
 	check_not_detached
 '
 
+for opt in "HEAD" "@"
+do
+	test_expect_success "checkout $opt no-op/don't detach" '
+		reset &&
+		cat .git/HEAD >expect &&
+		git checkout $opt &&
+		cat .git/HEAD >actual &&
+		check_not_detached &&
+		test_cmp expect actual
+	'
+done
+
 test_expect_success 'checkout tag detaches' '
 	reset &&
 	git checkout tag &&
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
index b5c5c0ff7e..3dc9184b4a 100755
--- a/t/t2071-restore-patch.sh
+++ b/t/t2071-restore-patch.sh
@@ -44,13 +44,17 @@ test_expect_success PERL 'git restore -p with staged changes' '
 	verify_state dir/foo index index
 '
 
-test_expect_success PERL 'git restore -p --source=HEAD' '
-	set_state dir/foo work index &&
-	# the third n is to get out in case it mistakenly does not apply
-	test_write_lines n y n | git restore -p --source=HEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head index
-'
+for opt in "HEAD" "@"
+do
+	test_expect_success PERL "git restore -p --source=$opt" '
+		set_state dir/foo work index &&
+		# the third n is to get out in case it mistakenly does not apply
+		test_write_lines n y n | git restore -p --source=$opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head index &&
+		test_grep "Discard" output
+	'
+done
 
 test_expect_success PERL 'git restore -p --source=HEAD^' '
 	set_state dir/foo work index &&
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 05079c7246..453872c8ba 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -26,12 +26,16 @@ test_expect_success PERL 'saying "n" does nothing' '
 	verify_saved_state bar
 '
 
-test_expect_success PERL 'git reset -p' '
-	test_write_lines n y | git reset -p >output &&
-	verify_state dir/foo work head &&
-	verify_saved_state bar &&
-	test_grep "Unstage" output
-'
+for opt in "HEAD" "@" ""
+do
+	test_expect_success PERL "git reset -p $opt" '
+		set_and_save_state dir/foo work work &&
+		test_write_lines n y | git reset -p $opt >output &&
+		verify_state dir/foo work head &&
+		verify_saved_state bar &&
+		test_grep "Unstage" output
+	'
+done
 
 test_expect_success PERL 'git reset -p HEAD^' '
 	test_write_lines n y | git reset -p HEAD^ >output &&
-- 
2.43.0

