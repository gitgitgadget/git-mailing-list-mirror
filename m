Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7278C70
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130300; cv=none; b=RINVnutNlgaTMP2kcjIptGOY2A6HYbLeJ9E9VORq2M5uOXL+T8Mzcr9tnmH4W0Zwei61TEPMCdqukg6Rr1pX6oNQ9jcWOpVtbwTfBS+r6xB1I8uyu8uSoYOf5jJtO1DmG/TvOAAwEKrQIesuhLbpyeRt88sd7rOHTW5Z6+ukLlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130300; c=relaxed/simple;
	bh=fo+KRucjZW9OQPdxvhlJmXOueEPQO90gusIsSSwSt1o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eSVj22hM0jOrTbHq/Jsge2e0oR6+Happq+5Mz0iiTKleWIyi9zbXCUOpZQCsaSWXopRNhIUhQgWXaZKjGHqgFH6hy3o9lVRhaTP9Izdxv3bBmNOGDacn7LmFwfFlqWh9AsSyqLtXaz5ilm4VRnkddy673k34Ipq0w7Ai37/T74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqD/3Z51; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqD/3Z51"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso2714907e87.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130297; x=1718735097; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEB9O27yrASduCiokIYNf0odHRRtLKAjE4kaiaGLMg4=;
        b=dqD/3Z51EkbNffMJ/picpSPfy0XITfCd9HrtsQTtxB6wAtRZ13PkL65SFxEPvkt+QO
         ajLjGCuQrVR1BKRHyTtaCdRJIZ5G21VWSRxZLfDrtPhAMnMadFkVGhJPIIWlQzjQQFt4
         kxcrzM3neA0R8fpvF8VK9lIUiwtCPQyfhCK0/z3jGX+IciPV069Qnboa6JK7r9VpY9rg
         l7afBeQlFKebMbDEwYc2PPhhpzdZwJYZ7lRWZU+Q42mv5Z57DKSX/ssu4vsJ/JyOXkBk
         tnfbdlvVy8f2mJiyHkcVm1dWllrYXMKkgRfaWCvp5QEV0GYVoi09s2oFNNngwPt2QrDj
         FRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130297; x=1718735097;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEB9O27yrASduCiokIYNf0odHRRtLKAjE4kaiaGLMg4=;
        b=cio8fgLvPkJatxQNiiePsufYwz/O0JqvhfA0XyAN8gh4t88FVeuobXItJ+9eMlvKiK
         roktzZmEe0Z+Ebc59V+j2JisO0dRMPmdhsTpjtSsHWsnuM9OvUzAfwhiNnypdVzaifGw
         au3csd99SU6gsU+7jcTYTVQwDT9PN8NIfQncIDbgRw6SBCO7BMAOUAItOGl1kjUzeh8o
         D+5TU+BnkWECfVgD0FdZoiyz/h5KilLFGPy1UXVgihCFBpweUdJAX8O3LsNTVT/aLmX9
         f/Jn3HkWh8Y3CckrV18BClCBWglSsu/IJmujqPU9YKaS+W5IFfslsMRH3woC7rLtPbEx
         yOsQ==
X-Gm-Message-State: AOJu0Yzsj/cSza+U67/PgZ9ZNSqVKiimOKHdwemcuxvwI9TBxV0jHVOP
	zHWB5/fQ84mhFrAlS5zN0Qoa5QyMUQ2GuHTdS7ziUAc+Uxks5tg6qc4Z0A==
X-Google-Smtp-Source: AGHT+IHqh6L06EpA6BgcxM6nXwgjh6tqiPrM9TLDehfNZEsSfCEHRbQoqdM6GzZjgt28aXdh8jPG6Q==
X-Received: by 2002:a19:5e10:0:b0:52c:99c9:bef6 with SMTP id 2adb3069b0e04-52c99c9c02dmr35555e87.7.1718130296713;
        Tue, 11 Jun 2024 11:24:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4225443988dsm32739775e9.47.2024.06.11.11.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:24:55 -0700 (PDT)
Message-Id: <b497dc90687a7c77a4d21c3a12fe5fa3bfdabc16.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:40 +0000
Subject: [PATCH 08/16] mktree: add a --literally option
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Add the '--literally' option to 'git mktree' to allow constructing a tree
with invalid contents. For now, the only change this represents compared to
the normal 'git mktree' behavior is no longer sorting the inputs; in later
commits, deduplicaton and path validation will be added to the command and
'--literally' will skip those as well.

Certain tests use 'git mktree' to intentionally generate corrupt trees.
Update these tests to use '--literally' so that they continue functioning
properly when additional input cleanup & validation is added to the base
command. Note that, because 'mktree --literally' does not sort entries, some
of the tests are updated to provide their inputs in tree order; otherwise,
the test would fail with an "incorrect order" error instead of the error the
test expects.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-mktree.txt       |  9 ++++++-
 builtin/mktree.c                   | 36 +++++++++++++++++++++++----
 t/t1010-mktree.sh                  | 40 ++++++++++++++++++++++++++++++
 t/t1014-read-tree-confusing.sh     |  6 ++---
 t/t1450-fsck.sh                    |  4 +--
 t/t1601-index-bogus.sh             |  2 +-
 t/t1700-split-index.sh             |  6 ++---
 t/t7008-filter-branch-null-sha1.sh |  6 ++---
 t/t7417-submodule-path-url.sh      |  2 +-
 t/t7450-bad-git-dotfiles.sh        |  8 +++---
 10 files changed, 96 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 507682ed23e..fb07e40cef0 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -9,7 +9,7 @@ git-mktree - Build a tree-object from formatted tree entries
 SYNOPSIS
 --------
 [verse]
-'git mktree' [-z] [--missing] [--batch]
+'git mktree' [-z] [--missing] [--literally] [--batch]
 
 DESCRIPTION
 -----------
@@ -27,6 +27,13 @@ OPTIONS
 	object.  This option has no effect on the treatment of gitlink entries
 	(aka "submodules") which are always allowed to be missing.
 
+--literally::
+	Create the tree from the tree entries provided to stdin in the order
+	they are provided without performing additional sorting, deduplication,
+	or path validation on them. This option is primarily useful for creating
+	invalid tree objects to use in tests of how Git deals with various forms
+	of tree corruption.
+
 --batch::
 	Allow building of more than one tree object before exiting.  Each
 	tree is separated by a single blank line. The final newline is
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 5530257252d..48019448c1f 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -45,11 +45,11 @@ static void release_tree_entry_array(struct tree_entry_array *arr)
 }
 
 static void append_to_tree(unsigned mode, struct object_id *oid, const char *path,
-			   struct tree_entry_array *arr)
+			   struct tree_entry_array *arr, int literally)
 {
 	struct tree_entry *ent;
 	size_t len = strlen(path);
-	if (strchr(path, '/'))
+	if (!literally && strchr(path, '/'))
 		die("path %s contains slash", path);
 
 	FLEX_ALLOC_MEM(ent, name, path, len);
@@ -89,14 +89,35 @@ static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
 	strbuf_release(&buf);
 }
 
+static void write_tree_literally(struct tree_entry_array *arr,
+				 struct object_id *oid)
+{
+	struct strbuf buf;
+	size_t size = 0;
+
+	for (size_t i = 0; i < arr->nr; i++)
+		size += 32 + arr->entries[i]->len;
+
+	strbuf_init(&buf, size);
+	for (size_t i = 0; i < arr->nr; i++) {
+		struct tree_entry *ent = arr->entries[i];
+		strbuf_addf(&buf, "%o %s%c", ent->mode, ent->name, '\0');
+		strbuf_add(&buf, ent->oid.hash, the_hash_algo->rawsz);
+	}
+
+	write_object_file(buf.buf, buf.len, OBJ_TREE, oid);
+	strbuf_release(&buf);
+}
+
 static const char *mktree_usage[] = {
-	"git mktree [-z] [--missing] [--batch]",
+	"git mktree [-z] [--missing] [--literally] [--batch]",
 	NULL
 };
 
 struct mktree_line_data {
 	struct tree_entry_array *arr;
 	int allow_missing;
+	int literally;
 };
 
 static int mktree_line(unsigned int mode, struct object_id *oid,
@@ -136,7 +157,7 @@ static int mktree_line(unsigned int mode, struct object_id *oid,
 		    path, oid_to_hex(oid), type_name(parsed_obj_type), type_name(mode_type));
 	}
 
-	append_to_tree(mode, oid, path, data->arr);
+	append_to_tree(mode, oid, path, data->arr, data->literally);
 	return 0;
 }
 
@@ -152,6 +173,8 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 	const struct option option[] = {
 		OPT_BOOL('z', NULL, &nul_term_line, N_("input is NUL terminated")),
 		OPT_BOOL(0, "missing", &mktree_line_data.allow_missing, N_("allow missing objects")),
+		OPT_BOOL(0, "literally", &mktree_line_data.literally,
+			 N_("do not sort, deduplicate, or validate paths of tree entries")),
 		OPT_BOOL(0, "batch", &is_batch_mode, N_("allow creation of more than one tree")),
 		OPT_END()
 	};
@@ -175,7 +198,10 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 			 */
 			; /* skip creating an empty tree */
 		} else {
-			write_tree(&arr, &oid);
+			if (mktree_line_data.literally)
+				write_tree_literally(&arr, &oid);
+			else
+				write_tree(&arr, &oid);
 			puts(oid_to_hex(&oid));
 			fflush(stdout);
 		}
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 9b2ab0c97ad..e0687cb529f 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -133,4 +133,44 @@ test_expect_success 'mktree fails on mode mismatch' '
 	grep "object $tree_oid is a tree but specified type was (blob)" err
 '
 
+test_expect_success '--literally can create invalid trees' '
+	tree_oid="$(cat tree)" &&
+	blob_oid="$(git rev-parse ${tree_oid}:one)" &&
+
+	# duplicate entries
+	{
+		printf "040000 tree $tree_oid\tmy-tree\n" &&
+		printf "100644 blob $blob_oid\ttest-file\n" &&
+		printf "100755 blob $blob_oid\ttest-file\n"
+	} | git mktree --literally >tree.bad &&
+	git cat-file tree $(cat tree.bad) >top.bad &&
+	test_must_fail git hash-object --stdin -t tree <top.bad 2>err &&
+	grep "contains duplicate file entries" err &&
+
+	# disallowed path
+	{
+		printf "100644 blob $blob_oid\t.git\n"
+	} | git mktree --literally >tree.bad &&
+	git cat-file tree $(cat tree.bad) >top.bad &&
+	test_must_fail git hash-object --stdin -t tree <top.bad 2>err &&
+	grep "contains ${SQ}.git${SQ}" err &&
+
+	# nested entry
+	{
+		printf "100644 blob $blob_oid\tdeeper/my-file\n"
+	} | git mktree --literally >tree.bad &&
+	git cat-file tree $(cat tree.bad) >top.bad &&
+	test_must_fail git hash-object --stdin -t tree <top.bad 2>err &&
+	grep "contains full pathnames" err &&
+
+	# bad entry ordering
+	{
+		printf "100644 blob $blob_oid\tB\n" &&
+		printf "040000 tree $tree_oid\tA\n"
+	} | git mktree --literally >tree.bad &&
+	git cat-file tree $(cat tree.bad) >top.bad &&
+	test_must_fail git hash-object --stdin -t tree <top.bad 2>err &&
+	grep "not properly sorted" err
+'
+
 test_done
diff --git a/t/t1014-read-tree-confusing.sh b/t/t1014-read-tree-confusing.sh
index 8ea8d36818b..762eb789704 100755
--- a/t/t1014-read-tree-confusing.sh
+++ b/t/t1014-read-tree-confusing.sh
@@ -30,13 +30,13 @@ while read path pretty; do
 	esac
 	test_expect_success "reject $pretty at end of path" '
 		printf "100644 blob %s\t%s" "$blob" "$path" >tree &&
-		bogus=$(git mktree <tree) &&
+		bogus=$(git mktree --literally <tree) &&
 		test_must_fail git read-tree $bogus
 	'
 
 	test_expect_success "reject $pretty as subtree" '
 		printf "040000 tree %s\t%s" "$tree" "$path" >tree &&
-		bogus=$(git mktree <tree) &&
+		bogus=$(git mktree --literally <tree) &&
 		test_must_fail git read-tree $bogus
 	'
 done <<-EOF
@@ -58,7 +58,7 @@ test_expect_success 'utf-8 paths allowed with core.protectHFS off' '
 	test_when_finished "git read-tree HEAD" &&
 	test_config core.protectHFS false &&
 	printf "100644 blob %s\t%s" "$blob" ".gi${u200c}t" >tree &&
-	ok=$(git mktree <tree) &&
+	ok=$(git mktree --literally <tree) &&
 	git read-tree $ok
 '
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8a456b1142d..532d2770e88 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -316,7 +316,7 @@ check_duplicate_names () {
 			*)  printf "100644 blob %s\t%s\n" $blob "$name" ;;
 			esac
 		done >badtree &&
-		badtree=$(git mktree <badtree) &&
+		badtree=$(git mktree --literally <badtree) &&
 		test_must_fail git fsck 2>out &&
 		test_grep "$badtree" out &&
 		test_grep "error in tree .*contains duplicate file entries" out
@@ -614,7 +614,7 @@ while read name path pretty; do
 			tree=$(git rev-parse HEAD^{tree}) &&
 			value=$(eval "echo \$$type") &&
 			printf "$mode $type %s\t%s" "$value" "$path" >bad &&
-			bad_tree=$(git mktree <bad) &&
+			bad_tree=$(git mktree --literally <bad) &&
 			git fsck 2>out &&
 			test_grep "warning.*tree $bad_tree" out
 		)'
diff --git a/t/t1601-index-bogus.sh b/t/t1601-index-bogus.sh
index 4171f1e1410..54e8ae038b7 100755
--- a/t/t1601-index-bogus.sh
+++ b/t/t1601-index-bogus.sh
@@ -4,7 +4,7 @@ test_description='test handling of bogus index entries'
 . ./test-lib.sh
 
 test_expect_success 'create tree with null sha1' '
-	tree=$(printf "160000 commit $ZERO_OID\\tbroken\\n" | git mktree)
+	tree=$(printf "160000 commit $ZERO_OID\\tbroken\\n" | git mktree --literally)
 '
 
 test_expect_success 'read-tree refuses to read null sha1' '
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index ac4a5b2734c..97b58aa3cca 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -478,12 +478,12 @@ test_expect_success 'writing split index with null sha1 does not write cache tre
 	git config splitIndex.maxPercentChange 0 &&
 	git commit -m "commit" &&
 	{
-		git ls-tree HEAD &&
-		printf "160000 commit $ZERO_OID\\tbroken\\n"
+		printf "160000 commit $ZERO_OID\\tbroken\\n" &&
+		git ls-tree HEAD
 	} >broken-tree &&
 	echo "add broken entry" >msg &&
 
-	tree=$(git mktree <broken-tree) &&
+	tree=$(git mktree --literally <broken-tree) &&
 	test_tick &&
 	commit=$(git commit-tree $tree -p HEAD <msg) &&
 	git update-ref HEAD "$commit" &&
diff --git a/t/t7008-filter-branch-null-sha1.sh b/t/t7008-filter-branch-null-sha1.sh
index 93fbc92b8db..a1b4c295c01 100755
--- a/t/t7008-filter-branch-null-sha1.sh
+++ b/t/t7008-filter-branch-null-sha1.sh
@@ -12,12 +12,12 @@ test_expect_success 'setup: base commits' '
 
 test_expect_success 'setup: a commit with a bogus null sha1 in the tree' '
 	{
-		git ls-tree HEAD &&
-		printf "160000 commit $ZERO_OID\\tbroken\\n"
+		printf "160000 commit $ZERO_OID\\tbroken\\n" &&
+		git ls-tree HEAD
 	} >broken-tree &&
 	echo "add broken entry" >msg &&
 
-	tree=$(git mktree <broken-tree) &&
+	tree=$(git mktree --literally <broken-tree) &&
 	test_tick &&
 	commit=$(git commit-tree $tree -p HEAD <msg) &&
 	git update-ref HEAD "$commit"
diff --git a/t/t7417-submodule-path-url.sh b/t/t7417-submodule-path-url.sh
index dbbb3853dc0..5d3c98e99a7 100755
--- a/t/t7417-submodule-path-url.sh
+++ b/t/t7417-submodule-path-url.sh
@@ -42,7 +42,7 @@ test_expect_success MINGW 'submodule paths disallows trailing spaces' '
 	tree=$(git -C super write-tree) &&
 	git -C super ls-tree $tree >tree &&
 	sed "s/sub/sub /" <tree >tree.new &&
-	tree=$(git -C super mktree <tree.new) &&
+	tree=$(git -C super mktree --literally <tree.new) &&
 	commit=$(echo with space | git -C super commit-tree $tree) &&
 	git -C super update-ref refs/heads/main $commit &&
 
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 4a9c22c9e2b..de2d45d2244 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -203,11 +203,11 @@ check_dotx_symlink () {
 			content=$(git hash-object -w ../.gitmodules) &&
 			target=$(printf "$tricky" | git hash-object -w --stdin) &&
 			{
-				printf "100644 blob $content\t$tricky\n" &&
-				printf "120000 blob $target\t$path\n"
+				printf "120000 blob $target\t$path\n" &&
+				printf "100644 blob $content\t$tricky\n"
 			} >bad-tree
 		) &&
-		tree=$(git -C $dir mktree <$dir/bad-tree)
+		tree=$(git -C $dir mktree --literally <$dir/bad-tree)
 	'
 
 	test_expect_success "fsck detects symlinked $name ($type)" '
@@ -261,7 +261,7 @@ test_expect_success 'fsck detects non-blob .gitmodules' '
 		cp ../.gitmodules subdir/file &&
 		git add subdir/file &&
 		git commit -m ok &&
-		git ls-tree HEAD | sed s/subdir/.gitmodules/ | git mktree &&
+		git ls-tree HEAD | sed s/subdir/.gitmodules/ | git mktree --literally &&
 
 		test_must_fail git fsck 2>output &&
 		test_grep gitmodulesBlob output
-- 
gitgitgadget

