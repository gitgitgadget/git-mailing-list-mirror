Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B486C1714AC
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 05:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736487533; cv=none; b=jO4IXLQ/vgHv4dS5u2p3D4a+RmcoutPJsvPms6bglvKVW68VjM73t3xw3WkyYITV0LXE9OoqoRvcIqVognespiC+0+iiQNDPmdqPxfpNAByxhpRrlcHFTHBEmYQxxMAqXT5Zx4n4ya3OzTPrBiU7J3NITKTRgclP3OfKSYtz3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736487533; c=relaxed/simple;
	bh=u8DIrp4Q1KhLHCN+PIc/IHmtP3zXmw7a/pmwxUz2m+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0oSz518yFh8TJMh0dnT/O6k+90GEv273/IbIfXMn3mz5AD6PuhNQAdayxMkrxyUbUtTKhofQcQ5CV3Nko+aHxtunRdwqCSM2/nTrBGAGJ6AtQ55hSIuAgeFZ7mrBRo54q+QSgRMaPHUqXf/TRLFTC7G/DMh+Y4YgDG4y0rn0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3Vq1J7r; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3Vq1J7r"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3eb7e725aa0so575303b6e.0
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 21:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736487530; x=1737092330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txiM0H8xU82VLfacXyo0+17TE/3+q+uZmELFh9NjuXo=;
        b=l3Vq1J7rGDj9dqVX1ukTnQTRLkd+n3gWgqG1Qcn7d+LffoaD6lKdoFCfqDszHE0g7n
         ORimOxwU6z4ROA1+OPaK7FdzsgUjTIncj8+xarWvbBjSdOVQrTJbXgg1ex4KtV8V/nJF
         ORwLSJcNRqABWpyVka0JLoQGQWzCyWWYTvVRiArPLGkSyqM/EptjsyqnEjFhKAp/vDgb
         vLmdxBAeDQr/csFexIj683cnqaBMt5o7aRGyiBY+9m8x5POxWJCGQ5b5wSf1h8ykzFWG
         TbUoLt6BgZAFBZ2VobASYHKYtXZtzO2TLhpw9xoBfjlf/0FM3HRvtS+JKtGUDB5dZzrP
         qFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736487530; x=1737092330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txiM0H8xU82VLfacXyo0+17TE/3+q+uZmELFh9NjuXo=;
        b=QsnWmf1WN4EZ2/QfwO1YUV+XM41PA94drK3/gIA7osRwk52W6YoPrPQ6RXoHsWGasE
         uNj+4B9NNKDVpZ9XVXo0kS666G2s4zpulkM/03FtuXnhZt90/aOnCDT0tTERDixAfMgD
         fW3kYSaQnUb+MsE3K7O0h6TOcO/onKQaWCqrNY5JYorPNxhj43nt7pSrRb2tnNaHtF0I
         A1B/DH86fEWYnyGZwve+YTZPFm5C14Kgph/SBtz6fy1LK6Cq8lC+kPzYFBMBK2uAjo5o
         e7PN4imbn7En3cAaRFopBRQarHVN1nL83Eqxt/UaboXDrmN7tptDpRXNyljfFAmP7AZC
         wrMw==
X-Gm-Message-State: AOJu0YwoU7a9eykVZpyelFvb+r3IjsDUXrF6bm+Js1/dhWisNDnLKReU
	0UPe52GEBn+2t5oYYBTGoVv/WfImXhVEPqwx8MRiGukD4DHL9FqEJlNdlQ==
X-Gm-Gg: ASbGncvxaEnK+v7oxynOYJNPZK0XQ1DSKcgaQE2t5vUNwBrdMMsvTgktmKVEbqr/jsB
	kBLDM0INFEsKYAf03yHsftCq0J1owTvLw1FQbEGIM3Um52FrRy/R6ALsswzEkPyMx/Z7CMIinVI
	KIqOJpds1RlUGAiPIKDGAP5kvzmQ8S1A1LrHzYvQ2mPnkG30+GzlGolgbU+56a/94eHzCRqG47G
	ljX4yNOpFmLF8noz585HrmU8od5aSlw00oWIOovB1I3+jTbUyU1PKHBCZ00Ymmu
X-Google-Smtp-Source: AGHT+IE/30FIiFD2HHtaApWvW/3U+dp5Wj9uIvezdwvSCeCTXYjvhXaT6v1/x7qBHjK9KkbnoQmtCw==
X-Received: by 2002:a05:6808:38c7:b0:3ea:5880:fe1d with SMTP id 5614622812f47-3ef2edc988emr6023344b6e.35.1736487530268;
        Thu, 09 Jan 2025 21:38:50 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231861c02csm714044a34.46.2025.01.09.21.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 21:38:49 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/2] rev-list: add --missing-info to print missing object path
Date: Thu,  9 Jan 2025 23:34:17 -0600
Message-ID: <20250110053417.2602109-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108034012.211043-1-jltobler@gmail.com>
References: <20250108034012.211043-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Missing objects identified through git-rev-list(1) can be printed by
setting the `--missing=print` option. Additional information about the
missing object, such as its path and type, may be present in its
containing object.

Add the `--missing-info` option that, when also set with
`--missing=print`, prints additional insight about the missing object
inferred from its containing object. Each line of output for a missing
object is in the form: `?<oid> [<token>=<value>]...`. This format is
kept generic so it can support multiple different attributes and be
extended in the future as needed. Each additional attribute is separated
by a SP. Any value containing a SP or special character is enclosed in
double-quotes in the C style as needed.

For now, only a missing object path attribute is implemented. It follows
the form `path=<path>` and specifies the full path to the object from
the top-level tree. In a subsequent commit, a missing object type
attribute will also be added.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/rev-list-options.txt | 12 ++++
 builtin/rev-list.c                 | 98 +++++++++++++++++++++++++-----
 t/t6022-rev-list-missing.sh        | 52 ++++++++++++++++
 3 files changed, 147 insertions(+), 15 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 459e5a02f5..8e363f5ae7 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1028,6 +1028,18 @@ If some tips passed to the traversal are missing, they will be
 considered as missing too, and the traversal will ignore them. In case
 we cannot get their Object ID though, an error will be raised.
 
+--missing-info::
+	Only useful with `--missing=print`; prints any additional information
+	about the missing object inferred from its containing object. The
+	information is all printed on the same line with the missing object ID
+	in the form: `?<oid> [<token>=<value>]...`. Additional attributes are
+	each separated by a SP. Any value containing a SP or special character
+	is enclosed in double-quotes in the C style as needed. Each
+	`<token>=<value>` may be one of the following:
++
+The `path=<path>` shows the path of the missing object inferred from a
+containing object.
+
 --exclude-promisor-objects::
 	(For internal use only.)  Prefilter object traversal at
 	promisor boundary.  This is used with partial clone.  This is
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3196da7b2d..861ffdaf21 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -22,7 +22,10 @@
 #include "progress.h"
 #include "reflog-walk.h"
 #include "oidset.h"
+#include "oidmap.h"
 #include "packfile.h"
+#include "quote.h"
+#include "strbuf.h"
 
 static const char rev_list_usage[] =
 "git rev-list [<options>] <commit>... [--] [<path>...]\n"
@@ -73,7 +76,11 @@ static unsigned progress_counter;
 static struct oidset omitted_objects;
 static int arg_print_omitted; /* print objects omitted by filter */
 
-static struct oidset missing_objects;
+struct missing_objects_map_entry {
+	struct oidmap_entry entry;
+	const char *path;
+};
+static struct oidmap missing_objects;
 enum missing_action {
 	MA_ERROR = 0,    /* fail if any missing objects are encountered */
 	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
@@ -101,7 +108,47 @@ static off_t get_object_disk_usage(struct object *obj)
 	return size;
 }
 
-static inline void finish_object__ma(struct object *obj)
+static void add_missing_object_entry(struct object_id *oid, const char *path)
+{
+	struct missing_objects_map_entry *entry;
+
+	if (oidmap_get(&missing_objects, oid))
+		return;
+
+	CALLOC_ARRAY(entry, 1);
+	entry->entry.oid = *oid;
+	if (path)
+		entry->path = xstrdup(path);
+	oidmap_put(&missing_objects, entry);
+}
+
+static void print_missing_object(struct missing_objects_map_entry *entry,
+				 int print_missing_info)
+{
+	struct strbuf sb;
+
+	if (!print_missing_info) {
+		printf("?%s\n", oid_to_hex(&entry->entry.oid));
+		return;
+	}
+
+	strbuf_init(&sb, 0);
+	if (entry->path && *entry->path) {
+		strbuf_addstr(&sb, " path=");
+
+		if (quote_c_style(entry->path, NULL, NULL, 0))
+			quote_c_style(entry->path, &sb, NULL, 0);
+		else if (strchr(entry->path, ' '))
+			strbuf_addf(&sb, "\"%s\"", entry->path);
+		else
+			strbuf_addstr(&sb, entry->path);
+	}
+
+	printf("?%s%s\n", oid_to_hex(&entry->entry.oid), sb.buf);
+	strbuf_release(&sb);
+}
+
+static inline void finish_object__ma(struct object *obj, const char *name)
 {
 	/*
 	 * Whether or not we try to dynamically fetch missing objects
@@ -119,7 +166,7 @@ static inline void finish_object__ma(struct object *obj)
 		return;
 
 	case MA_PRINT:
-		oidset_insert(&missing_objects, &obj->oid);
+		add_missing_object_entry(&obj->oid, name);
 		return;
 
 	case MA_ALLOW_PROMISOR:
@@ -152,7 +199,7 @@ static void show_commit(struct commit *commit, void *data)
 
 	if (revs->do_not_die_on_missing_objects &&
 	    oidset_contains(&revs->missing_commits, &commit->object.oid)) {
-		finish_object__ma(&commit->object);
+		finish_object__ma(&commit->object, NULL);
 		return;
 	}
 
@@ -268,12 +315,11 @@ static void show_commit(struct commit *commit, void *data)
 	finish_commit(commit);
 }
 
-static int finish_object(struct object *obj, const char *name UNUSED,
-			 void *cb_data)
+static int finish_object(struct object *obj, const char *name, void *cb_data)
 {
 	struct rev_list_info *info = cb_data;
 	if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
-		finish_object__ma(obj);
+		finish_object__ma(obj, name);
 		return 1;
 	}
 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
@@ -538,6 +584,7 @@ int cmd_rev_list(int argc,
 	int bisect_show_vars = 0;
 	int bisect_find_all = 0;
 	int use_bitmap_index = 0;
+	int print_missing_info = 0;
 	int filter_provided_objects = 0;
 	const char *show_progress = NULL;
 	int ret = 0;
@@ -656,6 +703,15 @@ int cmd_rev_list(int argc,
 		if (skip_prefix(arg, "--missing=", &arg))
 			continue; /* already handled above */
 
+		if (!strcmp(arg, "--missing-info")) {
+			if (arg_missing_action != MA_PRINT)
+				die(_("the option '%s' requires '%s'"),
+				    "--missing-info", "--missing=print");
+
+			print_missing_info = 1;
+			continue;
+		}
+
 		if (!strcmp(arg, ("--no-object-names"))) {
 			arg_show_object_names = 0;
 			continue;
@@ -782,9 +838,16 @@ int cmd_rev_list(int argc,
 	if (arg_print_omitted)
 		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
 	if (arg_missing_action == MA_PRINT) {
-		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
+		struct oidset_iter iter;
+		struct object_id *oid;
+
+		oidmap_init(&missing_objects, DEFAULT_OIDSET_SIZE);
+		oidset_iter_init(&revs.missing_commits, &iter);
+
 		/* Add missing tips */
-		oidset_insert_from_set(&missing_objects, &revs.missing_commits);
+		while ((oid = oidset_iter_next(&iter)))
+			add_missing_object_entry(oid, NULL);
+
 		oidset_clear(&revs.missing_commits);
 	}
 
@@ -801,12 +864,17 @@ int cmd_rev_list(int argc,
 		oidset_clear(&omitted_objects);
 	}
 	if (arg_missing_action == MA_PRINT) {
-		struct oidset_iter iter;
-		struct object_id *oid;
-		oidset_iter_init(&missing_objects, &iter);
-		while ((oid = oidset_iter_next(&iter)))
-			printf("?%s\n", oid_to_hex(oid));
-		oidset_clear(&missing_objects);
+		struct missing_objects_map_entry *entry;
+		struct oidmap_iter iter;
+
+		oidmap_iter_init(&missing_objects, &iter);
+
+		while ((entry = oidmap_iter_next(&iter))) {
+			print_missing_object(entry, print_missing_info);
+			free((void *)entry->path);
+		}
+
+		oidmap_free(&missing_objects, true);
 	}
 
 	stop_progress(&progress);
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 7553a9cca2..2eb051028e 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -145,4 +145,56 @@ do
 	done
 done
 
+for obj in "HEAD~1" "HEAD^{tree}" "HEAD:foo" "HEAD:foo/bar" "HEAD:baz baz" "HEAD:bat\""
+do
+	test_expect_success "--missing-info with missing '$obj'" '
+		test_when_finished rm -rf missing-info &&
+
+		git init missing-info &&
+		(
+			cd missing-info &&
+			git commit --allow-empty -m first &&
+
+			mkdir foo &&
+			echo bar >foo/bar &&
+			echo baz >"baz baz" &&
+			echo bat >bat\" &&
+			git add -A &&
+			git commit -m second &&
+
+			oid="$(git rev-parse "$obj")" &&
+			path=".git/objects/$(test_oid_to_path $oid)" &&
+
+			case $obj in
+			HEAD:foo)
+				path_info=" path=foo"
+				;;
+			HEAD:foo/bar)
+				path_info=" path=foo/bar"
+				;;
+			"HEAD:baz baz")
+				path_info=" path=\"baz baz\""
+				;;
+			"HEAD:bat\"")
+				path_info=" path=\"bat\\\"\""
+				;;
+			esac &&
+
+			# Before the object is made missing, we use rev-list to
+			# get the expected oids.
+			git rev-list --objects --no-object-names \
+				HEAD ^"$obj" >expect.raw &&
+			echo "?$oid$path_info" >>expect.raw &&
+
+			mv "$path" "$path.hidden" &&
+			git rev-list --objects --no-object-names \
+				--missing=print --missing-info HEAD >actual.raw &&
+
+			sort actual.raw >actual &&
+			sort expect.raw >expect &&
+			test_cmp expect actual
+		)
+	'
+done
+
 test_done
-- 
2.47.1

