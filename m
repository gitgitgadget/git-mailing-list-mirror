Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDAA3DFF7
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb1V0II9"
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184DFFA
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:54 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66d17bdabe1so777076d6.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697744393; x=1698349193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zGvx/vTx2PJBWIw2qIv/v+/wtygGLw25nG8QRsnkB8=;
        b=Xb1V0II9ajr0cPbwWmTY1/cxiZ700fxSUi0rjMabWJCn1BxuOQNHwK9o2G+/lcziPU
         2Ra+cvbK5F8zb+lQfTXVlySDuj8SyEEJWYaehhiNATB6pQQH2TWeKQyZlqoRZZsUrkpd
         J/yb8TpFzAwfnrTUHQycWR9woWkbjxgWxb5NUxx247aMOVVdZnIC+o7IfdBt57fh85N2
         hzPBF3xL/cFqHMotgdwYYd/9Z53AeFiE6DHrIkl+tIczGOBSNf0PbMxualFy3+Cd8n2C
         aIsNBWeJBnDev0UahUb335/8m5d75nLf6++Z1m7IC2qXjJAaPBFdPGjLGBDTGKAxMSng
         VtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697744393; x=1698349193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zGvx/vTx2PJBWIw2qIv/v+/wtygGLw25nG8QRsnkB8=;
        b=CrzBeLjvNr6eDnrrzJiJGXXHj8ATsN22+RxxLGnVxziCHQ2+SfjexQ6YH3RS8ngKHJ
         F8KoqZEr6P6Spi3QDzZqkwG5fzKanG8/mYFLcmkOBljCQhkgsi1sqhP1R1fhUaIVn1eK
         Cj+uf9/UeMTHLHcrnJ8ONAyX6u3uOsxe8QH87gC3Lurm7vJFkESnyc31HRTB4FekOIhz
         yyrpUt9rQoVhqDHmnNJpbrgj84bOTTtw7CJkQu6qMQlQLrDKWVoyKRDRGehzaAg1bWSM
         kDBhq6nrnH/4bg1Z6YVtdw/d0D4lChWvb1Fw3yw8DMbB5LbyiCxct8tvb3+KDJz8wZvi
         mnAA==
X-Gm-Message-State: AOJu0YyMkIzLRBsE1AID44PHfwnQ4xLzKniZW1FSDmf9XTbBizsqp+fH
	Eo58d4puKw4jW3sYSwcbEpIrSdyBi1w=
X-Google-Smtp-Source: AGHT+IEJUE4H1zF0cq+KwJjKUcy5YS0jPFUrTL4jGICO2n0HNRfIRc+kcfSILXunQel+Y5pTv6Lj0A==
X-Received: by 2002:a0c:b396:0:b0:656:3352:831e with SMTP id t22-20020a0cb396000000b006563352831emr3168782qve.31.1697744393082;
        Thu, 19 Oct 2023 12:39:53 -0700 (PDT)
Received: from u.ad.analog.com (cpc99472-lich12-2-0-cust1752.3-2.cable.virginm.net. [80.2.214.217])
        by smtp.gmail.com with ESMTPSA id ph5-20020a0562144a4500b0066d0ab215b5sm99940qvb.13.2023.10.19.12.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:39:52 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH 7/7] log: show pseudorefs in decorations
Date: Thu, 19 Oct 2023 20:39:11 +0100
Message-ID: <20231019193911.1669705-8-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231003205442.22963-1-andy.koppe@gmail.com>
References: <20231003205442.22963-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Show various pseudorefs in log decorations. This includes pseudorefs for
ongoing operations such as MERGE_HEAD and REBASE_HEAD, as well as
ORIG_HEAD for the HEAD position before any "drastic" operations.

Do not include FETCH_HEAD in the default decoration filter though,
because it would appear a lot in user's logs, often right alongside
HEAD, while providing little value as usually a remote-tracking branch
already points at what's been fetched.

To implement this, introduce decoration type DECORATION_REF_PSEUDO with
corresponding color.decorate.pseudoref setting that defaults to bold
blue. (This makes it similar to but not the same as HEAD, which defaults
to bold cyan.)

Add entries for each pseudoref to the ref_namespace array in refs.c.
Process them in new function add_pseudoref_decorations(). They also get
picked up by set_default_decoration_filter().

Document the showing of pseudorefs on the git-log page and the
color.decorate.pseudoref setting on the git-config page.

Amend t4207-log-decoration-colors.sh to test color.decorate.pseudoref,
and tweak various other tests to reflect the appearance of ORIG_HEAD in
decorations.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/color.txt                |  2 +
 Documentation/git-log.txt                     |  7 ++--
 commit.h                                      |  1 +
 log-tree.c                                    | 29 +++++++++++++
 refs.c                                        | 41 +++++++++++++++++++
 refs.h                                        |  7 ++++
 t/t4013/diff.log_--decorate=full_--all        |  2 +-
 ..._--decorate=full_--clear-decorations_--all |  4 +-
 t/t4013/diff.log_--decorate_--all             |  2 +-
 ...f.log_--decorate_--clear-decorations_--all |  4 +-
 t/t4202-log.sh                                | 23 ++++++-----
 t/t4207-log-decoration-colors.sh              | 13 ++++--
 12 files changed, 113 insertions(+), 22 deletions(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index 086efebbe5d..139fb90498a 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -95,6 +95,8 @@ color.decorate.<slot>::
 `ref`;;
 	any other refs (not shown unless enabled with one of the decoration
 	filter options such as `--decorate-refs=<pattern>`)
+`pseudoref`;;
+	pseudorefs such as ORIG_HEAD or MERGE_HEAD
 `symbol`;;
 	punctuation surrounding the other elements
 --
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 2a66cf88807..f217d16c439 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -52,9 +52,10 @@ OPTIONS
 	the decorations, but an explicit `--decorate-refs` pattern will
 	override a match in `log.excludeDecoration`.
 +
-If none of these options or config settings are given, then references are
-used as decoration if they match `HEAD`, `refs/heads/`, `refs/remotes/`,
-`refs/stash/`, or `refs/tags/`.
+If none of these options or config settings are given, then refs matching
+`refs/heads/`, `refs/remotes/`, `refs/stash/`, or `refs/tags/`, as well as
+the `HEAD` ref and the pseudorefs `ORIG_HEAD`, `MERGE_HEAD`, `REBASE_HEAD`,
+`CHERRY_PICK_HEAD`, `REVERT_HEAD` and `BISECT_HEAD` are shown.
 
 --clear-decorations::
 	When specified, this option clears all previous `--decorate-refs`
diff --git a/commit.h b/commit.h
index f6b2125fc42..44dd3ce19b4 100644
--- a/commit.h
+++ b/commit.h
@@ -56,6 +56,7 @@ enum decoration_type {
 	DECORATION_REF_STASH,
 	DECORATION_REF,
 	DECORATION_REF_HEAD,
+	DECORATION_REF_PSEUDO,
 	DECORATION_GRAFTED,
 	DECORATION_SYMBOL,
 };
diff --git a/log-tree.c b/log-tree.c
index fd99eb88d95..eae288599d0 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -41,6 +41,7 @@ static char decoration_colors[][COLOR_MAXLEN] = {
 	[DECORATION_REF_STASH]	= GIT_COLOR_BOLD_MAGENTA,
 	[DECORATION_REF]	= GIT_COLOR_BOLD_MAGENTA,
 	[DECORATION_REF_HEAD]	= GIT_COLOR_BOLD_CYAN,
+	[DECORATION_REF_PSEUDO]	= GIT_COLOR_BOLD_BLUE,
 	[DECORATION_GRAFTED]	= GIT_COLOR_BOLD_BLUE,
 	[DECORATION_SYMBOL]	= GIT_COLOR_NIL,
 };
@@ -52,6 +53,7 @@ static const char *color_decorate_slots[] = {
 	[DECORATION_REF_STASH]	= "stash",
 	[DECORATION_REF]	= "ref",
 	[DECORATION_REF_HEAD]	= "HEAD",
+	[DECORATION_REF_PSEUDO]	= "pseudoref",
 	[DECORATION_GRAFTED]	= "grafted",
 	[DECORATION_SYMBOL]	= "symbol",
 };
@@ -146,6 +148,32 @@ static int ref_filter_match(const char *refname,
 	return 1;
 }
 
+static void add_pseudoref_decorations(const struct decoration_filter *filter)
+{
+	struct ref_store *store = get_main_ref_store(the_repository);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++) {
+		struct object_id oid;
+		struct object *obj;
+		enum object_type objtype;
+		const struct ref_namespace_info *info = &ref_namespace[i];
+
+		if (info->decoration != DECORATION_REF_PSEUDO ||
+		    !refs_resolve_ref_unsafe(store, info->ref,
+					     RESOLVE_REF_READING, &oid, NULL) ||
+		    (filter && !ref_filter_match(info->ref, filter)))
+			continue;
+
+		objtype = oid_object_info(the_repository, &oid, NULL);
+		if (objtype < 0)
+			continue;
+
+		obj = lookup_object_by_type(the_repository, &oid, objtype);
+		add_name_decoration(DECORATION_REF_PSEUDO, info->ref, obj);
+	}
+}
+
 static int add_ref_decoration(const char *refname, const struct object_id *oid,
 			      int flags UNUSED,
 			      void *cb_data)
@@ -236,6 +264,7 @@ void load_ref_decorations(struct decoration_filter *filter, int flags)
 		decoration_loaded = 1;
 		decoration_flags = flags;
 		for_each_ref(add_ref_decoration, filter);
+		add_pseudoref_decorations(filter);
 		head_ref(add_ref_decoration, filter);
 		for_each_commit_graft(add_graft_decoration, filter);
 	}
diff --git a/refs.c b/refs.c
index 492b9f7d4e5..d960997aed1 100644
--- a/refs.c
+++ b/refs.c
@@ -149,6 +149,47 @@ struct ref_namespace_info ref_namespace[] = {
 		.ref = "refs/",
 		.decoration = DECORATION_REF,
 	},
+	[NAMESPACE_ORIG_HEAD] = {
+		.ref = "ORIG_HEAD",
+		.exact = 1,
+		.decoration = DECORATION_REF_PSEUDO,
+		.include = 1,
+	},
+	[NAMESPACE_MERGE_HEAD] = {
+		.ref = "MERGE_HEAD",
+		.exact = 1,
+		.decoration = DECORATION_REF_PSEUDO,
+		.include = 1,
+	},
+	[NAMESPACE_REBASE_HEAD] = {
+		.ref = "REBASE_HEAD",
+		.exact = 1,
+		.decoration = DECORATION_REF_PSEUDO,
+		.include = 1,
+	},
+	[NAMESPACE_CHERRY_PICK_HEAD] = {
+		.ref = "CHERRY_PICK_HEAD",
+		.exact = 1,
+		.decoration = DECORATION_REF_PSEUDO,
+		.include = 1,
+	},
+	[NAMESPACE_REVERT_HEAD] = {
+		.ref = "REVERT_HEAD",
+		.exact = 1,
+		.decoration = DECORATION_REF_PSEUDO,
+		.include = 1,
+	},
+	[NAMESPACE_BISECT_HEAD] = {
+		.ref = "BISECT_HEAD",
+		.exact = 1,
+		.decoration = DECORATION_REF_PSEUDO,
+		.include = 1,
+	},
+	[NAMESPACE_FETCH_HEAD] = {
+		.ref = "FETCH_HEAD",
+		.exact = 1,
+		.decoration = DECORATION_REF_PSEUDO,
+	},
 };
 
 void update_ref_namespace(enum ref_namespace namespace, char *ref)
diff --git a/refs.h b/refs.h
index b77691d787a..5ac1f308d07 100644
--- a/refs.h
+++ b/refs.h
@@ -1011,6 +1011,13 @@ enum ref_namespace {
 	NAMESPACE_PREFETCH,
 	NAMESPACE_REWRITTEN,
 	NAMESPACE_REFS,
+	NAMESPACE_ORIG_HEAD,
+	NAMESPACE_MERGE_HEAD,
+	NAMESPACE_REBASE_HEAD,
+	NAMESPACE_CHERRY_PICK_HEAD,
+	NAMESPACE_REVERT_HEAD,
+	NAMESPACE_BISECT_HEAD,
+	NAMESPACE_FETCH_HEAD,
 
 	/* Must be last */
 	NAMESPACE__COUNT
diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
index 6b0b334a5d6..9ebdd9b14fa 100644
--- a/t/t4013/diff.log_--decorate=full_--all
+++ b/t/t4013/diff.log_--decorate=full_--all
@@ -39,7 +39,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
 
     Side
 
-commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 (ORIG_HEAD)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
 
diff --git a/t/t4013/diff.log_--decorate=full_--clear-decorations_--all b/t/t4013/diff.log_--decorate=full_--clear-decorations_--all
index 1c030a6554e..7d16978e7f6 100644
--- a/t/t4013/diff.log_--decorate=full_--clear-decorations_--all
+++ b/t/t4013/diff.log_--decorate=full_--clear-decorations_--all
@@ -33,13 +33,13 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side'
 
-commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (refs/heads/side)
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (FETCH_HEAD, refs/heads/side)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
 
     Side
 
-commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 (ORIG_HEAD)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
 
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index c7df1f58141..46dde03cffa 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -39,7 +39,7 @@ Date:   Mon Jun 26 00:03:00 2006 +0000
 
     Side
 
-commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 (ORIG_HEAD)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
 
diff --git a/t/t4013/diff.log_--decorate_--clear-decorations_--all b/t/t4013/diff.log_--decorate_--clear-decorations_--all
index 88be82cce31..4f9be50ce02 100644
--- a/t/t4013/diff.log_--decorate_--clear-decorations_--all
+++ b/t/t4013/diff.log_--decorate_--clear-decorations_--all
@@ -33,13 +33,13 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side'
 
-commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (side)
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (FETCH_HEAD, side)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
 
     Side
 
-commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 (ORIG_HEAD)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index af4a123cd22..ea048cb4a29 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -927,7 +927,7 @@ test_expect_success 'multiple decorate-refs' '
 test_expect_success 'decorate-refs-exclude with glob' '
 	cat >expect.decorate <<-\EOF &&
 	Merge-tag-reach (HEAD -> main)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tags-octopus-a-and-octopus-b (ORIG_HEAD)
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b)
 	octopus-a (tag: octopus-a)
@@ -944,7 +944,7 @@ test_expect_success 'decorate-refs-exclude with glob' '
 test_expect_success 'decorate-refs-exclude without globs' '
 	cat >expect.decorate <<-\EOF &&
 	Merge-tag-reach (HEAD -> main)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tags-octopus-a-and-octopus-b (ORIG_HEAD)
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b, octopus-b)
 	octopus-a (tag: octopus-a, octopus-a)
@@ -961,7 +961,7 @@ test_expect_success 'decorate-refs-exclude without globs' '
 test_expect_success 'multiple decorate-refs-exclude' '
 	cat >expect.decorate <<-\EOF &&
 	Merge-tag-reach (HEAD -> main)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tags-octopus-a-and-octopus-b (ORIG_HEAD)
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b)
 	octopus-a (tag: octopus-a)
@@ -1022,10 +1022,12 @@ test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
 	EOF
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs-exclude="*octopus*" \
+		--decorate-refs-exclude="ORIG_HEAD" \
 		--simplify-by-decoration >actual &&
 	test_cmp expect.decorate actual &&
-	git -c log.excludeDecoration="*octopus*" log \
-		-n6 --decorate=short --pretty="tformat:%f%d" \
+	git -c log.excludeDecoration="*octopus*" \
+	    -c log.excludeDecoration="ORIG_HEAD" \
+	    log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--simplify-by-decoration >actual &&
 	test_cmp expect.decorate actual
 '
@@ -1067,9 +1069,10 @@ test_expect_success 'decorate-refs and simplify-by-decoration without output' '
 	test_cmp expect actual
 '
 
-test_expect_success 'decorate-refs-exclude HEAD' '
+test_expect_success 'decorate-refs-exclude HEAD ORIG_HEAD' '
 	git log --decorate=full --oneline \
-		--decorate-refs-exclude="HEAD" >actual &&
+		--decorate-refs-exclude="HEAD" \
+		--decorate-refs-exclude="ORIG_HEAD" >actual &&
 	! grep HEAD actual
 '
 
@@ -1082,7 +1085,7 @@ test_expect_success 'decorate-refs focus from default' '
 test_expect_success '--clear-decorations overrides defaults' '
 	cat >expect.default <<-\EOF &&
 	Merge-tag-reach (HEAD -> refs/heads/main)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tags-octopus-a-and-octopus-b (ORIG_HEAD)
 	seventh (tag: refs/tags/seventh)
 	octopus-b (tag: refs/tags/octopus-b, refs/heads/octopus-b)
 	octopus-a (tag: refs/tags/octopus-a, refs/heads/octopus-a)
@@ -1107,7 +1110,7 @@ test_expect_success '--clear-decorations overrides defaults' '
 
 	cat >expect.all <<-\EOF &&
 	Merge-tag-reach (HEAD -> refs/heads/main)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tags-octopus-a-and-octopus-b (ORIG_HEAD)
 	seventh (tag: refs/tags/seventh)
 	octopus-b (tag: refs/tags/octopus-b, refs/heads/octopus-b)
 	octopus-a (tag: refs/tags/octopus-a, refs/heads/octopus-a)
@@ -1139,7 +1142,7 @@ test_expect_success '--clear-decorations clears previous exclusions' '
 	cat >expect.all <<-\EOF &&
 	Merge-tag-reach (HEAD -> refs/heads/main)
 	reach (tag: refs/tags/reach, refs/heads/reach)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tags-octopus-a-and-octopus-b (ORIG_HEAD)
 	octopus-b (tag: refs/tags/octopus-b, refs/heads/octopus-b)
 	octopus-a (tag: refs/tags/octopus-a, refs/heads/octopus-a)
 	seventh (tag: refs/tags/seventh)
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 4b51e34f8b2..0b32e0bb8e9 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -18,6 +18,7 @@ test_expect_success setup '
 	git config color.decorate.tag "reverse bold yellow" &&
 	git config color.decorate.stash magenta &&
 	git config color.decorate.ref blue &&
+	git config color.decorate.pseudoref "bold cyan" &&
 	git config color.decorate.grafted black &&
 	git config color.decorate.symbol white &&
 	git config color.decorate.HEAD cyan &&
@@ -30,6 +31,7 @@ test_expect_success setup '
 	c_tag="<BOLD;REVERSE;YELLOW>" &&
 	c_stash="<MAGENTA>" &&
 	c_ref="<BLUE>" &&
+	c_pseudoref="<BOLD;CYAN>" &&
 	c_HEAD="<CYAN>" &&
 	c_grafted="<BLACK>" &&
 	c_symbol="<WHITE>" &&
@@ -46,7 +48,10 @@ test_expect_success setup '
 	test_commit B &&
 	git tag v1.0 &&
 	echo >>A.t &&
-	git stash save Changes to A.t
+	git stash save Changes to A.t &&
+	git reset other/main &&
+	git reset ORIG_HEAD &&
+	git revert --no-commit @~
 '
 
 cmp_filtered_decorations () {
@@ -63,17 +68,19 @@ ${c_symbol} -> ${c_reset}${c_branch}main${c_reset}${c_symbol}, ${c_reset}\
 ${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_symbol}, ${c_reset}\
 ${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_symbol})${c_reset} B
 ${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_pseudoref}ORIG_HEAD${c_reset}${c_symbol}, ${c_reset}\
 ${c_tag}tag: ${c_reset}${c_tag}A1${c_reset}${c_symbol}, ${c_reset}\
 ${c_remoteBranch}other/main${c_reset}${c_symbol})${c_reset} A1
 	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
 ${c_stash}refs/stash${c_reset}${c_symbol})${c_reset} On main: Changes to A.t
 	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_pseudoref}REVERT_HEAD${c_reset}${c_symbol}, ${c_reset}\
 ${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbol}, ${c_reset}\
 ${c_ref}refs/foo${c_reset}${c_symbol})${c_reset} A
 	EOF
 
-	git log --first-parent --no-abbrev --decorate --clear-decorations \
-		--oneline --color=always --all >actual &&
+	git log --first-parent --no-abbrev --decorate --color=always \
+		--decorate-refs-exclude=FETCH_HEAD --oneline --all >actual &&
 	cmp_filtered_decorations
 '
 
-- 
2.42.GIT

