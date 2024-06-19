Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D64815ADB3
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834301; cv=none; b=EdVvLX0Lptb3eZn8qHt1N2KZzqDK3RWcCrqB/UY8jZqoo1GcTTE8RFLvfwH0n1A3SmAxmoHOvNABuNQzAMK9Yby1e7Eltee4gNcSY+o11ctImK4E/X9AH4hczB8n7GbgNW9OYRfEtGITh3QqkPJucp8Q4h1rRWmta1oiaHMAFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834301; c=relaxed/simple;
	bh=8m8mkOtGwfkXkie9PVkWv1usJtGprvn9IF7V8Ys1yN8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L1DdNYw3cAmgbz3X3Y7Rz/v2LUSRyh7qF0c9+TivB5SazZhnT8lUhtyovNefVHM0w04iDAzDaFCnS8rQ8rocEShvVYqHIGo4Q7AIR08CuisttkzUqIsXZ5JN8PeF/X9pzgaqoxBSwN9Z+EKZrhxVkhHhGlV0P6UjDA5Icm0QHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9LC873S; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9LC873S"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42249a4f9e4so2030175e9.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834297; x=1719439097; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2ScA0TQGGNmdtbi7fNH3rCzzw9Qek8q07cfzUAHvNU=;
        b=d9LC873S2vvTUg1bMNS3yheOyF50H8APT0vndo5Ji/zRU5rVdFOYqv4PXzCiQ1TbiZ
         Wx/C+VO5IuVeqJB7Enq6Mlko/AjmOx0dfpq9mveMfEiwTDBkzQybL8CWUIUD6/AXF22Z
         u59PgRNjwgVBhcaJFgB8+dyWHU8A82OJdWzmbLJEcqAH+y5Ycn9kOIRkjpDLTeGTER5B
         kq+MmfKQLdJL63R5IZF6eTGmTQGoleQqErAqxMemDNHrNhZYwS54JCxwMEMPpGGpnxRR
         /s6zwKNtH/oU0DWDAmmYw7fBy8nC9zqHGTS70sU3ZA9D9FlYweHyXzk2Rw89Pl2eAwrN
         1mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834297; x=1719439097;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2ScA0TQGGNmdtbi7fNH3rCzzw9Qek8q07cfzUAHvNU=;
        b=GwIPFF+k76pou4zOc9urNXEPFdmwUqBWmt4R9P1Xmmnb426jvYM76Z4kFN7kiA7wpv
         QRpiB/2E1ifMctskkj9rsWP01Ka4A/r98RI92l6fLKizpGFOb1WcWH+RnUPxx9CU0tQH
         HGYc7jS18BvgV0jsGzouoxFTxxrhklaUjRzEm8t2CQAZFOvAntGwnvZzbbBaAPFTGQLm
         dZTbhV2tLAQV3G4YiWLWAzNrHOS0UOUyD47oSqMhfwfmLTWphqgf/GuLQNSNo3MejUMl
         R+yNyvk2eb0ej58LYtGqu8ER/hEZo584Q9MmwW/N5kHP0zCcoH2+Jb83tv3ma8IjLSaA
         G0Dg==
X-Gm-Message-State: AOJu0Yy0wDN+aSayhPLoiUoZ+C8tsOZMDD6wxakG+0+qFma5U8IKqnEn
	VPAWyG17QaKHfhFNsbMVf7/bIhTb77u+m2PoSTmLT7nORRXYS2U+/DOh4Q==
X-Google-Smtp-Source: AGHT+IFxoUFPQ2cInae52ds2utn5+61sZD2cyzlMkry1yLDUIqiANvwhE1iuQ2hui2L2aZ88A78lqw==
X-Received: by 2002:a05:600c:4189:b0:421:81c1:65fa with SMTP id 5b1f17b1804b1-42475178bdfmr25688525e9.13.1718834296902;
        Wed, 19 Jun 2024 14:58:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d2122e7sm3769645e9.40.2024.06.19.14.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:16 -0700 (PDT)
Message-Id: <9dc8e16a7fca886ec378d74a8e2ac61921a7f6ea.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:57:55 +0000
Subject: [PATCH v2 07/17] mktree: use read_index_info to read stdin lines
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Replace the custom input parsing of 'mktree' with 'read_index_info()', which
handles not only the 'ls-tree' output format it already handles but also the
other formats compatible with 'update-index'. This lends some consistency
across the commands (avoiding the need for two similar implementations for
input parsing) and adds flexibility to mktree.

It should be noted that, while the error messages are largely preserved in
the refactor, one does change: "fatal: invalid quoting" is now "error: bad
quoting of path name".

Update 'Documentation/git-mktree.txt' to reflect the more permissive input
format, as well as make a note about rejecting stage values higher than 0.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-mktree.txt |  26 ++++--
 builtin/mktree.c             | 156 +++++++++++++++--------------------
 t/t1010-mktree.sh            |  66 +++++++++++++++
 3 files changed, 151 insertions(+), 97 deletions(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 383f09dd333..c187403c6bd 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -3,7 +3,7 @@ git-mktree(1)
 
 NAME
 ----
-git-mktree - Build a tree-object from ls-tree formatted text
+git-mktree - Build a tree-object from formatted tree entries
 
 
 SYNOPSIS
@@ -13,15 +13,14 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads standard input in non-recursive `ls-tree` output format, and creates
-a tree object.  The order of the tree entries is normalized by mktree so
-pre-sorting the input is not required.  The object name of the tree object
-built is written to the standard output.
+Reads entry information from stdin and creates a tree object from those
+entries. The object name of the tree object built is written to the standard
+output.
 
 OPTIONS
 -------
 -z::
-	Read the NUL-terminated `ls-tree -z` output instead.
+	Input lines are separated with NUL rather than LF.
 
 --missing::
 	Allow missing objects.  The default behaviour (without this option)
@@ -35,6 +34,21 @@ OPTIONS
 	optional.  Note - if the `-z` option is used, lines are terminated
 	with NUL.
 
+INPUT FORMAT
+------------
+Tree entries may be specified in any of the formats compatible with the
+`--index-info` option to linkgit:git-update-index[1]:
+
+include::index-info-formats.txt[]
+
+Note that if the `stage` of a tree entry is given, the value must be 0.
+Higher stages represent conflicted files in an index; this information
+cannot be represented in a tree object. The command will fail without
+writing the tree if a higher order stage is specified for any entry.
+
+The order of the tree entries is normalized by `mktree` so pre-sorting the
+input by path is not required.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/mktree.c b/builtin/mktree.c
index a96ea10bf95..03a9899bc11 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -6,6 +6,7 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
+#include "index-info.h"
 #include "quote.h"
 #include "strbuf.h"
 #include "tree.h"
@@ -95,123 +96,96 @@ static const char *mktree_usage[] = {
 	NULL
 };
 
-static void mktree_line(char *buf, int nul_term_line, int allow_missing,
-			struct tree_entry_array *arr)
+struct mktree_line_data {
+	struct tree_entry_array *arr;
+	int allow_missing;
+};
+
+static int mktree_line(unsigned int mode, struct object_id *oid,
+		       enum object_type obj_type, int stage,
+		       const char *path, void *cbdata)
 {
-	char *ptr, *ntr;
-	const char *p;
-	unsigned mode;
-	enum object_type mode_type; /* object type derived from mode */
-	enum object_type obj_type; /* object type derived from sha */
+	struct mktree_line_data *data = cbdata;
+	enum object_type mode_type = object_type(mode);
 	struct object_info oi = OBJECT_INFO_INIT;
-	char *path, *to_free = NULL;
-	struct object_id oid;
+	enum object_type parsed_obj_type;
 
-	ptr = buf;
-	/*
-	 * Read non-recursive ls-tree output format:
-	 *     mode SP type SP sha1 TAB name
-	 */
-	mode = strtoul(ptr, &ntr, 8);
-	if (ptr == ntr || !ntr || *ntr != ' ')
-		die("input format error: %s", buf);
-	ptr = ntr + 1; /* type */
-	ntr = strchr(ptr, ' ');
-	if (!ntr || parse_oid_hex(ntr + 1, &oid, &p) ||
-	    *p != '\t')
-		die("input format error: %s", buf);
-
-	/* It is perfectly normal if we do not have a commit from a submodule */
-	if (S_ISGITLINK(mode))
-		allow_missing = 1;
-
-
-	*ntr++ = 0; /* now at the beginning of SHA1 */
-
-	path = (char *)p + 1;  /* at the beginning of name */
-	if (!nul_term_line && path[0] == '"') {
-		struct strbuf p_uq = STRBUF_INIT;
-		if (unquote_c_style(&p_uq, path, NULL))
-			die("invalid quoting");
-		path = to_free = strbuf_detach(&p_uq, NULL);
-	}
+	if (stage)
+		die(_("path '%s' is unmerged"), path);
 
-	/*
-	 * Object type is redundantly derivable three ways.
-	 * These should all agree.
-	 */
-	mode_type = object_type(mode);
-	if (mode_type != type_from_string(ptr)) {
-		die("entry '%s' object type (%s) doesn't match mode type (%s)",
-			path, ptr, type_name(mode_type));
-	}
+	if (obj_type != OBJ_ANY && mode_type != obj_type)
+		die("object type (%s) doesn't match mode type (%s)",
+		    type_name(obj_type), type_name(mode_type));
+
+	oi.typep = &parsed_obj_type;
 
-	/* Check the type of object identified by oid without fetching objects */
-	oi.typep = &obj_type;
-	if (oid_object_info_extended(the_repository, &oid, &oi,
+	if (oid_object_info_extended(the_repository, oid, &oi,
 				     OBJECT_INFO_LOOKUP_REPLACE |
 				     OBJECT_INFO_QUICK |
 				     OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
-		obj_type = -1;
-
-	if (obj_type < 0) {
-		if (allow_missing) {
-			; /* no problem - missing objects are presumed to be of the right type */
-		} else {
-			die("entry '%s' object %s is unavailable", path, oid_to_hex(&oid));
-		}
-	} else {
-		if (obj_type != mode_type) {
-			/*
-			 * The object exists but is of the wrong type.
-			 * This is a problem regardless of allow_missing
-			 * because the new tree entry will never be correct.
-			 */
-			die("entry '%s' object %s is a %s but specified type was (%s)",
-				path, oid_to_hex(&oid), type_name(obj_type), type_name(mode_type));
-		}
+		parsed_obj_type = -1;
+
+	if (parsed_obj_type < 0) {
+		/*
+		 * There are two conditions where the object being missing
+		 * is acceptable:
+		 *
+		 * - We're explicitly allowing it with --missing.
+		 * - The object is a submodule, which we wouldn't expect to
+		 *   be in this repo anyway.
+		 *
+		 * If neither condition is met, die().
+		 */
+		if (!data->allow_missing && !S_ISGITLINK(mode))
+			die("entry '%s' object %s is unavailable", path, oid_to_hex(oid));
+
+	} else if (parsed_obj_type != mode_type) {
+		/*
+		 * The object exists but is of the wrong type.
+		 * This is a problem regardless of allow_missing
+		 * because the new tree entry will never be correct.
+		 */
+		die("entry '%s' object %s is a %s but specified type was (%s)",
+		    path, oid_to_hex(oid), type_name(parsed_obj_type), type_name(mode_type));
 	}
 
-	append_to_tree(mode, &oid, path, arr);
-	free(to_free);
+	append_to_tree(mode, oid, path, data->arr);
+	return 0;
 }
 
 int cmd_mktree(int ac, const char **av, const char *prefix)
 {
-	struct strbuf sb = STRBUF_INIT;
 	struct object_id oid;
 	int nul_term_line = 0;
-	int allow_missing = 0;
 	int is_batch_mode = 0;
-	int got_eof = 0;
 	struct tree_entry_array arr = { 0 };
-	strbuf_getline_fn getline_fn;
+	struct mktree_line_data mktree_line_data = { .arr = &arr };
+	struct strbuf line = STRBUF_INIT;
+	int ret;
 
 	const struct option option[] = {
 		OPT_BOOL('z', NULL, &nul_term_line, N_("input is NUL terminated")),
-		OPT_BOOL(0, "missing", &allow_missing, N_("allow missing objects")),
+		OPT_BOOL(0, "missing", &mktree_line_data.allow_missing, N_("allow missing objects")),
 		OPT_BOOL(0, "batch", &is_batch_mode, N_("allow creation of more than one tree")),
 		OPT_END()
 	};
 
 	ac = parse_options(ac, av, prefix, option, mktree_usage, 0);
-	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
-
-	while (!got_eof) {
-		while (1) {
-			if (getline_fn(&sb, stdin) == EOF) {
-				got_eof = 1;
-				break;
-			}
-			if (sb.buf[0] == '\0') {
+
+	do {
+		ret = read_index_info(nul_term_line, mktree_line, &mktree_line_data, &line);
+		if (ret < 0)
+			break;
+
+		if (ret == INDEX_INFO_UNRECOGNIZED_LINE) {
+			if (line.len)
+				die("input format error: %s", line.buf);
+			else if (!is_batch_mode)
 				/* empty lines denote tree boundaries in batch mode */
-				if (is_batch_mode)
-					break;
 				die("input format error: (blank line only valid in batch mode)");
-			}
-			mktree_line(sb.buf, nul_term_line, allow_missing, &arr);
 		}
-		if (is_batch_mode && got_eof && arr.nr < 1) {
+
+		if (is_batch_mode && !ret && arr.nr < 1) {
 			/*
 			 * Execution gets here if the last tree entry is terminated with a
 			 * new-line.  The final new-line has been made optional to be
@@ -224,9 +198,9 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 			fflush(stdout);
 		}
 		tree_entry_array_clear(&arr, 1); /* reset tree entry buffer for re-use in batch mode */
-	}
+	} while (ret > 0);
 
+	strbuf_release(&line);
 	tree_entry_array_release(&arr, 1);
-	strbuf_release(&sb);
-	return 0;
+	return !!ret;
 }
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 22875ba598c..649842fa27c 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -54,11 +54,36 @@ test_expect_success 'ls-tree output in wrong order given to mktree (2)' '
 	test_cmp tree.withsub actual
 '
 
+test_expect_success '--batch creates multiple trees' '
+	cat top >multi-tree &&
+	echo "" >>multi-tree &&
+	cat top.withsub >>multi-tree &&
+
+	cat tree >expect &&
+	cat tree.withsub >>expect &&
+	git mktree --batch <multi-tree >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'allow missing object with --missing' '
 	git mktree --missing <top.missing >actual &&
 	test_cmp tree.missing actual
 '
 
+test_expect_success 'mktree with invalid submodule OIDs' '
+	# non-existent OID - ok
+	printf "160000 commit $(test_oid numeric)\tA\n" >in &&
+	git mktree <in >tree.actual &&
+	git ls-tree $(cat tree.actual) >actual &&
+	test_cmp in actual &&
+
+	# existing OID, wrong type - error
+	tree_oid="$(cat tree)" &&
+	printf "160000 commit $tree_oid\tA" |
+	test_must_fail git mktree 2>err &&
+	test_grep "object $tree_oid is a tree but specified type was (commit)" err
+'
+
 test_expect_success 'mktree refuses to read ls-tree -r output (1)' '
 	test_must_fail git mktree <all
 '
@@ -67,4 +92,45 @@ test_expect_success 'mktree refuses to read ls-tree -r output (2)' '
 	test_must_fail git mktree <all.withsub
 '
 
+test_expect_success 'mktree fails on malformed input' '
+	# empty line without --batch
+	echo "" |
+	test_must_fail git mktree 2>err &&
+	test_grep "blank line only valid in batch mode" err &&
+
+	# bad whitespace
+	printf "100644 blob $EMPTY_BLOB A" |
+	test_must_fail git mktree 2>err &&
+	test_grep "input format error" err &&
+
+	# invalid type
+	printf "100644 bad $EMPTY_BLOB\tA" |
+	test_must_fail git mktree 2>err &&
+	test_grep "invalid object type" err &&
+
+	# invalid OID length
+	printf "100755 blob abc123\tA" |
+	test_must_fail git mktree 2>err &&
+	test_grep "input format error" err &&
+
+	# bad quoting
+	printf "100644 blob $EMPTY_BLOB\t\"A" |
+	test_must_fail git mktree 2>err &&
+	test_grep "bad quoting of path name" err
+'
+
+test_expect_success 'mktree fails on mode mismatch' '
+	tree_oid="$(cat tree)" &&
+
+	# mode-type mismatch
+	printf "100644 tree $tree_oid\tA" |
+	test_must_fail git mktree 2>err &&
+	test_grep "object type (tree) doesn${SQ}t match mode type (blob)" err &&
+
+	# mode-object mismatch (no --missing)
+	printf "100644 $tree_oid\tA" |
+	test_must_fail git mktree 2>err &&
+	test_grep "object $tree_oid is a tree but specified type was (blob)" err
+'
+
 test_done
-- 
gitgitgadget

