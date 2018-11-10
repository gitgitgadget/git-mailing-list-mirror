Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AFAF1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeKJPWD (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:22:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36887 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeKJPWD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:22:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id e5-v6so3372547lja.4
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bHf2csGjo7gExghk9TlC1/P14ZGAOJ1ucr5+Dwr8SZM=;
        b=qrfEYTRyao70wDh0FSLqJ7mnU+N7dCjm3I8K9rMlX5VzG6lHJ5dAPQPtjSd4d1q+tn
         WjxB/YGp6jevQfys+xuqVZ8HVyYQKlCUHHrrxOzIXc2wv3l5/nbSrNu5ezTbQ8wZlsmY
         dBNmE6o6Y0MGxBlNm4hUkE1ED68ik0HCwlxu9YxAoC3dVNdBEZ7lVZrJf6+SH7+CQkHq
         e1H1C/DM7kBYXNs2Id99R5ubj0HIMGTfT0N8vob4kv4hv8zahi/daSe3SemreTUs48xW
         sJT2ouFsbXsQCqgowMLWoCwzMin5hbh2Ct5USmWKND4xUZstJ+9Ri/971Cwf3hcXYjp1
         NA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHf2csGjo7gExghk9TlC1/P14ZGAOJ1ucr5+Dwr8SZM=;
        b=Vc0QXR2UbZpfkg95qOjZQ23g7Hop4LCNwT4piqrc/lvRK1TmqHO8rpeWpX0N+PILyM
         nkETu1WcSJ4XT3mGfnhbvDmLJOgPGm29nDBOrrQrYqnmnfJso1hr/8Zhut94XJHVFkO4
         QQmSJYhNutcqCZ+JCS/GGmmbtnp8L1cVBQGzN0taINiMP1COc8e8GjAprRQtsLXZWqcZ
         Uq+dev1qt0i22sHZNzszXEEqLN1giZkNzreCbNg+O9H0Y7GpBtwWxXMGtgn8PZ9/pxqN
         +eex8U/NvM+7S9DHhdLLO6EgjKZLULBwfBFpJ7/Wb3UAUvs3qZ8qUey5uB0a0XoR7Lm+
         Dj+w==
X-Gm-Message-State: AGRZ1gK/39IoBaKgOFyL9x8F2hzYcTjYdmiN6gJ6N0TE0BqyYVhuvTaf
        B/ov0wAZXDaDY2WH1MZCars=
X-Google-Smtp-Source: AJdET5eClIDh+X2MHEp4YXmbe89tVB1f1HCLyhIUKAGRi6VsQVDbjg3XhPMiWw0jQgE6IKfOqAVkEw==
X-Received: by 2002:a2e:9783:: with SMTP id y3-v6mr7260096lji.167.1541827000586;
        Fri, 09 Nov 2018 21:16:40 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:39 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 16/16] fsck: mark strings for translation
Date:   Sat, 10 Nov 2018 06:16:15 +0100
Message-Id: <20181110051615.8641-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110051615.8641-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
 <20181110051615.8641-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two die() are updated to start with lowercase to be consistent with
the rest.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fsck.c             | 106 ++++++++++++++++++++-----------------
 t/t1410-reflog.sh          |   6 +--
 t/t1450-fsck.sh            |  50 ++++++++---------
 t/t6050-replace.sh         |   4 +-
 t/t7415-submodule-names.sh |   6 +--
 5 files changed, 90 insertions(+), 82 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1feb6142f4..dcf72859a6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -85,7 +85,7 @@ static const char *printable_type(struct object *obj)
 
 	ret = type_name(obj->type);
 	if (!ret)
-		ret = "unknown";
+		ret = _("unknown");
 
 	return ret;
 }
@@ -116,7 +116,8 @@ static int fsck_config(const char *var, const char *value, void *cb)
 static int objerror(struct object *obj, const char *err)
 {
 	errors_found |= ERROR_OBJECT;
-	fprintf_ln(stderr, "error in %s %s: %s",
+	/* TRANSLATORS: e.g. error in tree 01bfda: <more explanation> */
+	fprintf_ln(stderr, _("error in %s %s: %s"),
 		   printable_type(obj), describe_object(obj), err);
 	return -1;
 }
@@ -126,11 +127,13 @@ static int fsck_error_func(struct fsck_options *o,
 {
 	switch (type) {
 	case FSCK_WARN:
-		fprintf_ln(stderr, "warning in %s %s: %s",
+		/* TRANSLATORS: e.g. warning in tree 01bfda: <more explanation> */
+		fprintf_ln(stderr, _("warning in %s %s: %s"),
 			   printable_type(obj), describe_object(obj), message);
 		return 0;
 	case FSCK_ERROR:
-		fprintf_ln(stderr, "error in %s %s: %s",
+		/* TRANSLATORS: e.g. error in tree 01bfda: <more explanation> */
+		fprintf_ln(stderr, _("error in %s %s: %s"),
 			   printable_type(obj), describe_object(obj), message);
 		return 1;
 	default:
@@ -151,17 +154,18 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 	 */
 	if (!obj) {
 		/* ... these references to parent->fld are safe here */
-		printf("broken link from %7s %s\n",
-			   printable_type(parent), describe_object(parent));
-		printf("broken link from %7s %s\n",
-			   (type == OBJ_ANY ? "unknown" : type_name(type)), "unknown");
+		printf_ln(_("broken link from %7s %s"),
+			  printable_type(parent), describe_object(parent));
+		printf_ln(_("broken link from %7s %s"),
+			  (type == OBJ_ANY ? _("unknown") : type_name(type)),
+			  _("unknown"));
 		errors_found |= ERROR_REACHABLE;
 		return 1;
 	}
 
 	if (type != OBJ_ANY && obj->type != type)
 		/* ... and the reference to parent is safe here */
-		objerror(parent, "wrong object type in link");
+		objerror(parent, _("wrong object type in link"));
 
 	if (obj->flags & REACHABLE)
 		return 0;
@@ -177,8 +181,8 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 
 	if (!(obj->flags & HAS_OBJ)) {
 		if (parent && !has_object_file(&obj->oid)) {
-			printf_ln("broken link from %7s %s\n"
-				  "              to %7s %s",
+			printf_ln(_("broken link from %7s %s\n"
+				    "              to %7s %s"),
 				  printable_type(parent),
 				  describe_object(parent),
 				  printable_type(obj),
@@ -246,8 +250,8 @@ static void check_reachable_object(struct object *obj)
 			return;
 		if (has_object_pack(&obj->oid))
 			return; /* it is in pack - forget about it */
-		printf("missing %s %s\n", printable_type(obj),
-			describe_object(obj));
+		printf_ln(_("missing %s %s"), printable_type(obj),
+			  describe_object(obj));
 		errors_found |= ERROR_REACHABLE;
 		return;
 	}
@@ -272,8 +276,8 @@ static void check_unreachable_object(struct object *obj)
 	 * since this is something that is prunable.
 	 */
 	if (show_unreachable) {
-		printf("unreachable %s %s\n", printable_type(obj),
-			describe_object(obj));
+		printf_ln(_("unreachable %s %s"), printable_type(obj),
+			  describe_object(obj));
 		return;
 	}
 
@@ -291,8 +295,8 @@ static void check_unreachable_object(struct object *obj)
 	 */
 	if (!(obj->flags & USED)) {
 		if (show_dangling)
-			printf("dangling %s %s\n", printable_type(obj),
-			       describe_object(obj));
+			printf_ln(_("dangling %s %s"), printable_type(obj),
+				  describe_object(obj));
 		if (write_lost_and_found) {
 			char *filename = git_pathdup("lost-found/%s/%s",
 				obj->type == OBJ_COMMIT ? "commit" : "other",
@@ -300,18 +304,18 @@ static void check_unreachable_object(struct object *obj)
 			FILE *f;
 
 			if (safe_create_leading_directories_const(filename)) {
-				error("Could not create lost-found");
+				error(_("could not create lost-found"));
 				free(filename);
 				return;
 			}
 			f = xfopen(filename, "w");
 			if (obj->type == OBJ_BLOB) {
 				if (stream_blob_to_fd(fileno(f), &obj->oid, NULL, 1))
-					die_errno("Could not write '%s'", filename);
+					die_errno(_("could not write '%s'"), filename);
 			} else
 				fprintf(f, "%s\n", describe_object(obj));
 			if (fclose(f))
-				die_errno("Could not finish '%s'",
+				die_errno(_("could not finish '%s'"),
 					  filename);
 			free(filename);
 		}
@@ -328,7 +332,7 @@ static void check_unreachable_object(struct object *obj)
 static void check_object(struct object *obj)
 {
 	if (verbose)
-		fprintf(stderr, "Checking %s\n", describe_object(obj));
+		fprintf_ln(stderr, _("Checking %s"), describe_object(obj));
 
 	if (obj->flags & REACHABLE)
 		check_reachable_object(obj);
@@ -346,7 +350,7 @@ static void check_connectivity(void)
 	/* Look up all the requirements, warn about missing objects.. */
 	max = get_max_object_index();
 	if (verbose)
-		fprintf(stderr, "Checking connectivity (%d objects)\n", max);
+		fprintf_ln(stderr, _("Checking connectivity (%d objects)"), max);
 
 	for (i = 0; i < max; i++) {
 		struct object *obj = get_indexed_object(i);
@@ -365,11 +369,11 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 	obj->flags |= SEEN;
 
 	if (verbose)
-		fprintf(stderr, "Checking %s %s\n",
-			printable_type(obj), describe_object(obj));
+		fprintf_ln(stderr, _("Checking %s %s"),
+			   printable_type(obj), describe_object(obj));
 
 	if (fsck_walk(obj, NULL, &fsck_obj_options))
-		objerror(obj, "broken links");
+		objerror(obj, _("broken links"));
 	err = fsck_object(obj, buffer, size, &fsck_obj_options);
 	if (err)
 		goto out;
@@ -378,14 +382,15 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 		struct commit *commit = (struct commit *) obj;
 
 		if (!commit->parents && show_root)
-			printf("root %s\n", describe_object(&commit->object));
+			printf_ln(_("root %s"),
+				  describe_object(&commit->object));
 	}
 
 	if (obj->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) obj;
 
 		if (show_tags && tag->tagged) {
-			printf_ln("tagged %s %s (%s) in %s",
+			printf_ln(_("tagged %s %s (%s) in %s"),
 				  printable_type(tag->tagged),
 				  describe_object(tag->tagged),
 				  tag->tag,
@@ -413,7 +418,8 @@ static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
 				  eaten);
 	if (!obj) {
 		errors_found |= ERROR_OBJECT;
-		return error("%s: object corrupt or missing", oid_to_hex(oid));
+		return error(_("%s: object corrupt or missing"),
+			     oid_to_hex(oid));
 	}
 	obj->flags &= ~(REACHABLE | SEEN);
 	obj->flags |= HAS_OBJ;
@@ -437,7 +443,8 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 			obj->flags |= USED;
 			mark_object_reachable(obj);
 		} else if (!is_promisor_object(oid)) {
-			error("%s: invalid reflog entry %s", refname, oid_to_hex(oid));
+			error(_("%s: invalid reflog entry %s"),
+			      refname, oid_to_hex(oid));
 			errors_found |= ERROR_REACHABLE;
 		}
 	}
@@ -450,8 +457,8 @@ static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid
 	const char *refname = cb_data;
 
 	if (verbose)
-		fprintf(stderr, "Checking reflog %s->%s\n",
-			oid_to_hex(ooid), oid_to_hex(noid));
+		fprintf_ln(stderr, _("Checking reflog %s->%s"),
+			   oid_to_hex(ooid), oid_to_hex(noid));
 
 	fsck_handle_reflog_oid(refname, ooid, 0);
 	fsck_handle_reflog_oid(refname, noid, timestamp);
@@ -480,13 +487,14 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 			 default_refs++;
 			 return 0;
 		}
-		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
+		error(_("%s: invalid sha1 pointer %s"),
+		      refname, oid_to_hex(oid));
 		errors_found |= ERROR_REACHABLE;
 		/* We'll continue with the rest despite the error.. */
 		return 0;
 	}
 	if (obj->type != OBJ_COMMIT && is_branch(refname)) {
-		error("%s: not a commit", refname);
+		error(_("%s: not a commit"), refname);
 		errors_found |= ERROR_REFS;
 	}
 	default_refs++;
@@ -520,7 +528,7 @@ static void get_default_heads(void)
 	 * "show_unreachable" flag.
 	 */
 	if (!default_refs) {
-		fprintf(stderr, "notice: No default references\n");
+		fprintf_ln(stderr, _("notice: No default references"));
 		show_unreachable = 0;
 	}
 }
@@ -535,7 +543,7 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 
 	if (read_loose_object(path, oid, &type, &size, &contents) < 0) {
 		errors_found |= ERROR_OBJECT;
-		error("%s: object corrupt or missing: %s",
+		error(_("%s: object corrupt or missing: %s"),
 		      oid_to_hex(oid), path);
 		return 0; /* keep checking other objects */
 	}
@@ -548,7 +556,7 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 
 	if (!obj) {
 		errors_found |= ERROR_OBJECT;
-		error("%s: object could not be parsed: %s",
+		error(_("%s: object could not be parsed: %s"),
 		      oid_to_hex(oid), path);
 		if (!eaten)
 			free(contents);
@@ -568,7 +576,7 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 static int fsck_cruft(const char *basename, const char *path, void *data)
 {
 	if (!starts_with(basename, "tmp_obj_"))
-		fprintf(stderr, "bad sha1 file: %s\n", path);
+		fprintf_ln(stderr, _("bad sha1 file: %s"), path);
 	return 0;
 }
 
@@ -583,7 +591,7 @@ static void fsck_object_dir(const char *path)
 	struct progress *progress = NULL;
 
 	if (verbose)
-		fprintf(stderr, "Checking object directory\n");
+		fprintf_ln(stderr, _("Checking object directory"));
 
 	if (show_progress)
 		progress = start_progress(_("Checking object directories"), 256);
@@ -599,28 +607,28 @@ static int fsck_head_link(void)
 	int null_is_error = 0;
 
 	if (verbose)
-		fprintf(stderr, "Checking HEAD link\n");
+		fprintf_ln(stderr, _("Checking HEAD link"));
 
 	head_points_at = resolve_ref_unsafe("HEAD", 0, &head_oid, NULL);
 	if (!head_points_at) {
 		errors_found |= ERROR_REFS;
-		return error("Invalid HEAD");
+		return error(_("invalid HEAD"));
 	}
 	if (!strcmp(head_points_at, "HEAD"))
 		/* detached HEAD */
 		null_is_error = 1;
 	else if (!starts_with(head_points_at, "refs/heads/")) {
 		errors_found |= ERROR_REFS;
-		return error("HEAD points to something strange (%s)",
+		return error(_("HEAD points to something strange (%s)"),
 			     head_points_at);
 	}
 	if (is_null_oid(&head_oid)) {
 		if (null_is_error) {
 			errors_found |= ERROR_REFS;
-			return error("HEAD: detached HEAD points at nothing");
+			return error(_("HEAD: detached HEAD points at nothing"));
 		}
-		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
-			head_points_at + 11);
+		fprintf_ln(stderr, _("notice: HEAD points to an unborn branch (%s)"),
+			   head_points_at + 11);
 	}
 	return 0;
 }
@@ -631,12 +639,12 @@ static int fsck_cache_tree(struct cache_tree *it)
 	int err = 0;
 
 	if (verbose)
-		fprintf(stderr, "Checking cache tree\n");
+		fprintf_ln(stderr, _("Checking cache tree"));
 
 	if (0 <= it->entry_count) {
 		struct object *obj = parse_object(the_repository, &it->oid);
 		if (!obj) {
-			error("%s: invalid sha1 pointer in cache-tree",
+			error(_("%s: invalid sha1 pointer in cache-tree"),
 			      oid_to_hex(&it->oid));
 			errors_found |= ERROR_REFS;
 			return 1;
@@ -647,7 +655,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 				obj, xstrdup(":"));
 		mark_object_reachable(obj);
 		if (obj->type != OBJ_TREE)
-			err |= objerror(obj, "non-tree in cache-tree");
+			err |= objerror(obj, _("non-tree in cache-tree"));
 	}
 	for (i = 0; i < it->subtree_nr; i++)
 		err |= fsck_cache_tree(it->down[i]->cache_tree);
@@ -789,7 +797,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			if (!obj || !(obj->flags & HAS_OBJ)) {
 				if (is_promisor_object(&oid))
 					continue;
-				error("%s: object missing", oid_to_hex(&oid));
+				error(_("%s: object missing"), oid_to_hex(&oid));
 				errors_found |= ERROR_OBJECT;
 				continue;
 			}
@@ -801,7 +809,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			mark_object_reachable(obj);
 			continue;
 		}
-		error("invalid parameter: expected sha1, got '%s'", arg);
+		error(_("invalid parameter: expected sha1, got '%s'"), arg);
 		errors_found |= ERROR_OBJECT;
 	}
 
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 388b0611d8..353bdfd415 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -20,12 +20,12 @@ check_have () {
 }
 
 check_fsck () {
-	output=$(git fsck --full)
+	git fsck --full >fsck.output
 	case "$1" in
 	'')
-		test -z "$output" ;;
+		test_must_be_empty fsck.output ;;
 	*)
-		echo "$output" | grep "$1" ;;
+		test_i18ngrep "$1" fsck.output ;;
 	esac
 }
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 90c765df3a..15ca98b2a9 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -70,7 +70,7 @@ test_expect_success 'object with bad sha1' '
 
 	test_must_fail git fsck 2>out &&
 	cat out &&
-	grep "$sha.*corrupt" out
+	test_i18ngrep "$sha.*corrupt" out
 '
 
 test_expect_success 'branch pointing to non-commit' '
@@ -78,7 +78,7 @@ test_expect_success 'branch pointing to non-commit' '
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
 	test_must_fail git fsck 2>out &&
 	cat out &&
-	grep "not a commit" out
+	test_i18ngrep "not a commit" out
 '
 
 test_expect_success 'HEAD link pointing at a funny object' '
@@ -88,7 +88,7 @@ test_expect_success 'HEAD link pointing at a funny object' '
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=.git git fsck 2>out &&
 	cat out &&
-	grep "detached HEAD points" out
+	test_i18ngrep "detached HEAD points" out
 '
 
 test_expect_success 'HEAD link pointing at a funny place' '
@@ -98,7 +98,7 @@ test_expect_success 'HEAD link pointing at a funny place' '
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=.git git fsck 2>out &&
 	cat out &&
-	grep "HEAD points to something strange" out
+	test_i18ngrep "HEAD points to something strange" out
 '
 
 test_expect_success 'email without @ is okay' '
@@ -122,7 +122,7 @@ test_expect_success 'email with embedded > is not okay' '
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
 	cat out &&
-	grep "error in commit $new" out
+	test_i18ngrep "error in commit $new" out
 '
 
 test_expect_success 'missing < email delimiter is reported nicely' '
@@ -134,7 +134,7 @@ test_expect_success 'missing < email delimiter is reported nicely' '
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
 	cat out &&
-	grep "error in commit $new.* - bad name" out
+	test_i18ngrep "error in commit $new.* - bad name" out
 '
 
 test_expect_success 'missing email is reported nicely' '
@@ -146,7 +146,7 @@ test_expect_success 'missing email is reported nicely' '
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
 	cat out &&
-	grep "error in commit $new.* - missing email" out
+	test_i18ngrep "error in commit $new.* - missing email" out
 '
 
 test_expect_success '> in name is reported' '
@@ -158,7 +158,7 @@ test_expect_success '> in name is reported' '
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
 	cat out &&
-	grep "error in commit $new" out
+	test_i18ngrep "error in commit $new" out
 '
 
 # date is 2^64 + 1
@@ -172,7 +172,7 @@ test_expect_success 'integer overflow in timestamps is reported' '
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
 	cat out &&
-	grep "error in commit $new.*integer overflow" out
+	test_i18ngrep "error in commit $new.*integer overflow" out
 '
 
 test_expect_success 'commit with NUL in header' '
@@ -184,7 +184,7 @@ test_expect_success 'commit with NUL in header' '
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
 	cat out &&
-	grep "error in commit $new.*unterminated header: NUL at offset" out
+	test_i18ngrep "error in commit $new.*unterminated header: NUL at offset" out
 '
 
 test_expect_success 'tree object with duplicate entries' '
@@ -205,7 +205,7 @@ test_expect_success 'tree object with duplicate entries' '
 		git hash-object -w -t tree --stdin
 	) &&
 	test_must_fail git fsck 2>out &&
-	grep "error in tree .*contains duplicate file entries" out
+	test_i18ngrep "error in tree .*contains duplicate file entries" out
 '
 
 test_expect_success 'unparseable tree object' '
@@ -259,7 +259,7 @@ test_expect_success 'tag pointing to nonexistent' '
 	test_when_finished "git update-ref -d refs/tags/invalid" &&
 	test_must_fail git fsck --tags >out &&
 	cat out &&
-	grep "broken link" out
+	test_i18ngrep "broken link" out
 '
 
 test_expect_success 'tag pointing to something else than its type' '
@@ -301,7 +301,7 @@ test_expect_success 'tag with incorrect tag name & missing tagger' '
 	warning in tag $tag: badTagName: invalid '\''tag'\'' name: wrong name format
 	warning in tag $tag: missingTaggerEntry: invalid format - expected '\''tagger'\'' line
 	EOF
-	test_cmp expect out
+	test_i18ncmp expect out
 '
 
 test_expect_success 'tag with bad tagger' '
@@ -320,7 +320,7 @@ test_expect_success 'tag with bad tagger' '
 	echo $tag >.git/refs/tags/wrong &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags 2>out &&
-	grep "error in tag .*: invalid author/committer" out
+	test_i18ngrep "error in tag .*: invalid author/committer" out
 '
 
 test_expect_success 'tag with NUL in header' '
@@ -340,7 +340,7 @@ test_expect_success 'tag with NUL in header' '
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags 2>out &&
 	cat out &&
-	grep "error in tag $tag.*unterminated header: NUL at offset" out
+	test_i18ngrep "error in tag $tag.*unterminated header: NUL at offset" out
 '
 
 test_expect_success 'cleaned up' '
@@ -396,7 +396,7 @@ test_expect_success 'fsck notices blob entry pointing to null sha1' '
 	       git hash-object -w --stdin -t tree) &&
 	  git fsck 2>out &&
 	  cat out &&
-	  grep "warning.*null sha1" out
+	  test_i18ngrep "warning.*null sha1" out
 	)
 '
 
@@ -407,7 +407,7 @@ test_expect_success 'fsck notices submodule entry pointing to null sha1' '
 	       git hash-object -w --stdin -t tree) &&
 	  git fsck 2>out &&
 	  cat out &&
-	  grep "warning.*null sha1" out
+	  test_i18ngrep "warning.*null sha1" out
 	)
 '
 
@@ -428,7 +428,7 @@ while read name path pretty; do
 			bad_tree=$(git mktree <bad) &&
 			git fsck 2>out &&
 			cat out &&
-			grep "warning.*tree $bad_tree" out
+			test_i18ngrep "warning.*tree $bad_tree" out
 		)'
 	done <<-\EOF
 	100644 blob
@@ -474,9 +474,9 @@ test_expect_success 'NUL in commit' '
 		git branch bad $(cat name) &&
 
 		test_must_fail git -c fsck.nulInCommit=error fsck 2>warn.1 &&
-		grep nulInCommit warn.1 &&
+		test_i18ngrep nulInCommit warn.1 &&
 		git fsck 2>warn.2 &&
-		grep nulInCommit warn.2
+		test_i18ngrep nulInCommit warn.2
 	)
 '
 
@@ -594,7 +594,7 @@ test_expect_success 'fsck --name-objects' '
 		remove_object $(git rev-parse julius:caesar.t) &&
 		test_must_fail git fsck --name-objects >out &&
 		tree=$(git rev-parse --verify julius:) &&
-		egrep "$tree \((refs/heads/master|HEAD)@\{[0-9]*\}:" out
+		test_i18ngrep -E "$tree \((refs/heads/master|HEAD)@\{[0-9]*\}:" out
 	)
 '
 
@@ -605,7 +605,7 @@ test_expect_success 'alternate objects are correctly blamed' '
 	mkdir alt.git/objects/12 &&
 	>alt.git/objects/12/34567890123456789012345678901234567890 &&
 	test_must_fail git fsck >out 2>&1 &&
-	grep alt.git out
+	test_i18ngrep alt.git out
 '
 
 test_expect_success 'fsck errors in packed objects' '
@@ -624,8 +624,8 @@ test_expect_success 'fsck errors in packed objects' '
 	remove_object $one &&
 	remove_object $two &&
 	test_must_fail git fsck 2>out &&
-	grep "error in commit $one.* - bad name" out &&
-	grep "error in commit $two.* - bad name" out &&
+	test_i18ngrep "error in commit $one.* - bad name" out &&
+	test_i18ngrep "error in commit $two.* - bad name" out &&
 	! grep corrupt out
 '
 
@@ -706,7 +706,7 @@ test_expect_success 'fsck notices dangling objects' '
 		git fsck >actual &&
 		# the output order is non-deterministic, as it comes from a hash
 		sort <actual >actual.sorted &&
-		test_cmp expect actual.sorted
+		test_i18ncmp expect actual.sorted
 	)
 '
 
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 86374a9c52..7700a8e793 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -133,8 +133,8 @@ test_expect_success 'tag replaced commit' '
 
 test_expect_success '"git fsck" works' '
      git fsck master >fsck_master.out &&
-     grep "dangling commit $R" fsck_master.out &&
-     grep "dangling tag $(cat .git/refs/tags/mytag)" fsck_master.out &&
+     test_i18ngrep "dangling commit $R" fsck_master.out &&
+     test_i18ngrep "dangling tag $(cat .git/refs/tags/mytag)" fsck_master.out &&
      test -z "$(git fsck)"
 '
 
diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index 293e2e1963..49a37efe9c 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -154,7 +154,7 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
 		# symlink detector; this grep string comes from the config
 		# variable name and will not be translated.
 		test_must_fail git fsck 2>output &&
-		grep gitmodulesSymlink output
+		test_i18ngrep gitmodulesSymlink output
 	)
 '
 
@@ -172,7 +172,7 @@ test_expect_success 'fsck detects non-blob .gitmodules' '
 		git ls-tree HEAD | sed s/subdir/.gitmodules/ | git mktree &&
 
 		test_must_fail git fsck 2>output &&
-		grep gitmodulesBlob output
+		test_i18ngrep gitmodulesBlob output
 	)
 '
 
@@ -186,7 +186,7 @@ test_expect_success 'fsck detects corrupt .gitmodules' '
 		git commit -m "broken gitmodules" &&
 
 		git fsck 2>output &&
-		grep gitmodulesParse output &&
+		test_i18ngrep gitmodulesParse output &&
 		test_i18ngrep ! "bad config" output
 	)
 '
-- 
2.19.1.1231.g84aef82467

