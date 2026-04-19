Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199AA199D8
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776588532; cv=none; b=B3ynxVs2EQzBWNx/bU5Qe4NphaMKnd6VPnJq8X6aeihdnRPz2Vm3zihwhdiyBKnaOCt1KiccQGkgdkcrRUL2KiciHNBIWXnXcYdD4Ra73hnuI9buB/+xwjjHEujRGdnoZYANN8Gpz901Z9L9yzYWsDEDPE9s02/wTQdoKMdvqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776588532; c=relaxed/simple;
	bh=2gAbsJZQe8tTacmOAoxdELDayDXAsBtYC+ThDcyb/xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trL4x6vypSf1qQmLq8jk5pH4xrO6OFvTvtRtXpPPuNuIzH1JXRKpzsykeQ63OEPZnDKSI7av3KO56Fv7D3pN34nyqYqVMshYa/XKk4KqE8JZHGkgze7o6cfoHTXrLTrXAI+rFn6taPcTLdxm00gpqk9Etton5BR95YBENZ10x1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/0Pfc8f; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/0Pfc8f"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3614826eca4so1424125a91.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2026 01:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776588530; x=1777193330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXksBDVFwWINAUQw6MCwli3i4IzAGOENUMMLtIYqXNU=;
        b=K/0Pfc8fwn6YKOpnpeYqCWzLD0Mh7xNRZu83V7LPGRyH2qOIWaS74eZCocVcxwQNZv
         OA+8c5NzvFWArXuZPuqX3/dR7TFypp1vApQFT55nkgfZVtFpcp47qSQnTMdMs1GjlKZQ
         7kdigXj3t1KmKBHvexMi+h/dgd1PZ8623ULHVjdEI3txUU9F5a3tJRlAzND9x+cKhBKI
         H4t62Y2Z19lsw/fM7e/5MdZD7yh8/E9EVdB6E/JTI+SzxfiY5/IGDeGs3TVfb+4Abv8V
         Uy3LOuTiYtHuu0bGG/J/NZ32kYRUu9ZTDGv+0OIDUk4ovxYCMRTJJ2DXa6rVuffLVHBJ
         mkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776588530; x=1777193330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kXksBDVFwWINAUQw6MCwli3i4IzAGOENUMMLtIYqXNU=;
        b=o9zH/o7oe5sWs1WuQmR18+cVM1aBIAQbO25ni6fgzUQqLR4+yBKA8b1W18H9LYiHmO
         OA4iBG4RCmcP5ZNnasVe2GHHW4Wypdu8sFbVL+ZF2bJ8yHQVMsKGI10pk/3h1myzdcIR
         aVRkUzbR2b0PtNq8/zoAzlhBoQEtjlUcw8/Nv43AAf0fKRQJ6P8Fu2cIL4fMx9SZnIYJ
         m1VA5ZZsWEjQtEqU652aNDjAVXFOEkp3fHk7GKior+4HTv8I1dYKIVdHsF9gwazjHlbc
         tGSH0JpKSvh60VdzjMDmm67X9nFQyOwmbVpXgbVQ2Dc3nbDu0w/FmXkGVtxSm1n6vcrC
         3H+w==
X-Gm-Message-State: AOJu0YwyreP7N3s6Dd6pMbSsnh9EkE9ZbVQ6RDjyIzO0IM/QMT5onwgt
	y265h257SUmGcx2SLfZNGQj9XKuMI4I/wcwR0BRlbfX54fuu2ONtpGPuFmcTTQ==
X-Gm-Gg: AeBDiesaJXffBFteztDNfq5qEDv6wtNYphxhz0w9SxQUb+TFY9ciXDUGOixubj1uZwg
	ybO5npIggZtR1ek75R26/W5eoGlr/UF10mP8cmLWDevSDum3bXyjpYyrDC1kjXTptsQ8B6YK0EO
	NSEl95vdj/lvzjJdJD8eVN6Q4p+kTOrMyWlNR3OCjxKBM7Q+NFUwWgcJkqab0P+jmlmWzeFzKtq
	Ckuj7apW1FuFcRZm6eGjDtYIaJslQrxNzUA2ZvmswJK1zaMi4I5+CSJhYEZQezDIMgYa68L+0M1
	hrp859PVxO+sWa29M+MlE77iUUyNrQO5BXE6iQkm2xc3abnLcR3VNFGSLH1w/aBUyBdreMJ3W2q
	Zp1QB2kvRfhTsUvM0dLHVPr1hOmf+w9sxYUDw9kh7/jTSDBYk8Y0j9VZo0EG7vpTIKamUV6Q82L
	WeIY/rIRUvyTeWEWVhcIcJlYutTfyQ0EYuwtp8GDWfWZMrji9CO7N9cmrpDwhLTJpACmvUeDFpo
	7jYg3k=
X-Received: by 2002:a17:90b:1807:b0:35f:bb33:d728 with SMTP id 98e67ed59e1d1-361403f2bd5mr10626945a91.11.1776588529878;
        Sun, 19 Apr 2026 01:48:49 -0700 (PDT)
Received: from localhost ([2409:40e3:40f3:1d3c:b014:b093:7cf2:7c44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc575bsm6945162a91.4.2026.04.19.01.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 01:48:49 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	toon@iotcl.com,
	ps@pks.im,
	karthik.188@gmail.com,
	justin@parity.io,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v1 1/1] rev-list: add --missing=print-only mode
Date: Sun, 19 Apr 2026 14:18:40 +0530
Message-ID: <20260419084840.33986-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419084840.33986-1-siddharthasthana31@gmail.com>
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When working with partial clones, it's common to want just the list of
missing objects. The current --missing=print mode does this but mixes
present and missing objects together, with missing ones prefixed by '?'.
Getting only the missing OIDs requires an extra pipe:

  git rev-list --objects --all --missing=print | perl -ne 'print if s/^[?]//'

Add --missing=print-only which outputs only the missing object OIDs, one
per line, without any prefix. This makes the above one-liner unnecessary
and the output directly usable by downstream tools.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/rev-list-options.adoc |  5 +++
 builtin/rev-list.c                  | 49 ++++++++++++++++++++++-------
 t/t6022-rev-list-missing.sh         | 26 +++++++++++++++
 3 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 2d195a1474..5438be5975 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1056,6 +1056,11 @@ Unexpected missing objects will raise an error.
 The form `--missing=print` is like `allow-any`, but will also print a
 list of the missing objects.  Object IDs are prefixed with a ``?'' character.
 +
+The form `--missing=print-only` is like `print`, but will print ONLY the
+missing objects (not the present ones), and without the ``?'' prefix.  This
+is useful for scripting, as a simpler alternative to
+`--missing=print | sed -n 's/^?//p'`.
++
 The form `--missing=print-info` is like `print`, but will also print additional
 information about the missing object inferred from its containing object. The
 information is all printed on the same line with the missing object ID in the
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 8f63003709..ba7e3e3919 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -104,14 +104,22 @@ static void missing_objects_map_entry_free(void *e)
 
 static struct oidmap missing_objects;
 enum missing_action {
-	MA_ERROR = 0,    /* fail if any missing objects are encountered */
-	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
-	MA_PRINT,        /* print ALL missing objects in special section */
-	MA_PRINT_INFO,   /* same as MA_PRINT but also prints missing object info */
+	MA_ERROR = 0, /* fail if any missing objects are encountered */
+	MA_ALLOW_ANY, /* silently allow ALL missing objects */
+	MA_PRINT, /* print ALL missing objects in special section */
+	MA_PRINT_INFO, /* same as MA_PRINT but also prints missing object info */
+	MA_PRINT_ONLY, /* print ONLY missing objects, without the "?" prefix */
 	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
 };
 static enum missing_action arg_missing_action;
 
+static inline int missing_action_prints(void)
+{
+	return arg_missing_action == MA_PRINT ||
+	       arg_missing_action == MA_PRINT_INFO ||
+	       arg_missing_action == MA_PRINT_ONLY;
+}
+
 /* display only the oid of each object encountered */
 static int arg_show_object_names = 1;
 
@@ -156,11 +164,16 @@ static void print_missing_object(struct missing_objects_map_entry *entry,
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	if (line_term)
+	if (arg_missing_action == MA_PRINT_ONLY) {
+		printf("%s", oid_to_hex(&entry->entry.oid));
+		putchar(line_term);
+		return;
+	} else if (line_term) {
 		printf("?%s", oid_to_hex(&entry->entry.oid));
-	else
+	} else {
 		printf("%s%cmissing=yes", oid_to_hex(&entry->entry.oid),
 		       info_term);
+	}
 
 	if (!print_missing_info) {
 		putchar(line_term);
@@ -209,6 +222,7 @@ static inline void finish_object__ma(struct object *obj, const char *name)
 
 	case MA_PRINT:
 	case MA_PRINT_INFO:
+	case MA_PRINT_ONLY:
 		add_missing_object_entry(&obj->oid, name, obj->type);
 		return;
 
@@ -246,6 +260,11 @@ static void show_commit(struct commit *commit, void *data)
 		return;
 	}
 
+	if (arg_missing_action == MA_PRINT_ONLY) {
+		finish_commit(commit);
+		return;
+	}
+
 	if (show_disk_usage)
 		total_disk_usage += get_object_disk_usage(&commit->object);
 
@@ -384,6 +403,8 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
 	if (finish_object(obj, name, cb_data))
 		return;
 	display_progress(progress, ++progress_counter);
+	if (arg_missing_action == MA_PRINT_ONLY)
+		return;
 	if (show_disk_usage)
 		total_disk_usage += get_object_disk_usage(obj);
 	if (info->flags & REV_LIST_QUIET)
@@ -525,6 +546,12 @@ static inline int parse_missing_action_value(const char *value)
 		return 1;
 	}
 
+	if (!strcmp(value, "print-only")) {
+		arg_missing_action = MA_PRINT_ONLY;
+		fetch_if_missing = 0;
+		return 1;
+	}
+
 	if (!strcmp(value, "allow-promisor")) {
 		arg_missing_action = MA_ALLOW_PROMISOR;
 		fetch_if_missing = 0;
@@ -967,8 +994,7 @@ int cmd_rev_list(int argc,
 
 	if (arg_print_omitted)
 		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
-	if (arg_missing_action == MA_PRINT ||
-	    arg_missing_action == MA_PRINT_INFO) {
+	if (missing_action_prints()) {
 		struct oidset_iter iter;
 		struct object_id *oid;
 
@@ -994,8 +1020,7 @@ int cmd_rev_list(int argc,
 			printf("~%s\n", oid_to_hex(oid));
 		oidset_clear(&omitted_objects);
 	}
-	if (arg_missing_action == MA_PRINT ||
-	    arg_missing_action == MA_PRINT_INFO) {
+	if (missing_action_prints()) {
 		struct missing_objects_map_entry *entry;
 		struct oidmap_iter iter;
 
@@ -1011,7 +1036,7 @@ int cmd_rev_list(int argc,
 
 	stop_progress(&progress);
 
-	if (revs.count) {
+	if (revs.count && arg_missing_action != MA_PRINT_ONLY) {
 		if (revs.left_right && revs.cherry_mark)
 			printf("%d\t%d\t%d\n", revs.count_left, revs.count_right, revs.count_same);
 		else if (revs.left_right)
@@ -1022,7 +1047,7 @@ int cmd_rev_list(int argc,
 			printf("%d\n", revs.count_left + revs.count_right);
 	}
 
-	if (show_disk_usage)
+	if (show_disk_usage && arg_missing_action != MA_PRINT_ONLY)
 		print_disk_usage(total_disk_usage);
 
 cleanup:
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 08e92dd002..105560ad21 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -198,6 +198,32 @@ do
 	'
 done
 
+for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
+do
+	test_expect_success "rev-list --missing=print-only with missing $obj" '
+		oid="$(git rev-parse $obj)" &&
+		path=".git/objects/$(test_oid_to_path $oid)" &&
+
+		# Capture present OIDs before hiding anything.
+		git rev-list --objects --no-object-names HEAD ^$obj >present.raw &&
+
+		mv "$path" "$path.hidden" &&
+		test_when_finished "mv $path.hidden $path" &&
+
+		git rev-list --missing=print-only --objects --no-object-names \
+			HEAD >actual &&
+
+		# Only the missing OID should appear, without the "?" prefix.
+		grep "^$oid$" actual &&
+
+		# Present objects must NOT appear in the output.
+		while read present_oid
+		do
+			! grep "^$present_oid$" actual || return 1
+		done <present.raw
+	'
+done
+
 test_expect_success "-z nul-delimited --missing" '
 	test_when_finished rm -rf repo &&
 
-- 
2.53.0

