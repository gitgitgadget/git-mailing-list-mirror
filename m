Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2810B1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 16:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeG3Rfh (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:35:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40053 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeG3Rfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:35:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id y200-v6so8506698lfd.7
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvbWll83k1zLorqOGEdBWvgtR6iHxykm1Fe2LD8B/kI=;
        b=VREa4HE9q4XCyF1X5LgNdpDB5ViazRC/6DY9kOcsvqD9fgFhpag60wQaQeLMae8FnU
         +TuCRwyAwchNbLLI72HCO+cTblB0EDFdp4noSLn0Qmht+EOf3UgfgkpAlUu4S8S+Zpm6
         8CVRX4ePdxJIHE9GOpVUX1nW3zc5T4Y02UJm3K8scHsPIDe7FtmAOY7tOZrPrd6QnMBY
         E3+RSZTsxfRNBZXms93eJDb6gKlCZ81QQW8J7fuDK4aJW+WN2Ggntve1UNVIxiUv3cvA
         vP0USHDqEGB2KuHE5P0wefsS9BQrUwzwLCBft1RnXdfKHG6IsHBjtTOd3K0dT1YHvAdo
         YQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvbWll83k1zLorqOGEdBWvgtR6iHxykm1Fe2LD8B/kI=;
        b=DyJEXV+aliNjNLyyGRztVUuJuR3Iv5M00smoXD7aItCL3MpBaaMySX6McM6whot+nL
         8KM4l5Gcb7Uwi+Vh7f+vuflbjR7MqJ93yTXrNyXUCTRahHNoqabZEZ+ed1ea6Nz7liZA
         A4RjaXv8kSdA27MTqSUP+L91xh7VjnGJXe5q8MXE4xPjFFU3eWvlENuQmCoqDaXP3jMt
         h2zzUynkox+8rBVMhcyN9LD+cCE/rXEpoi7iiUgBMhIW6hd2DntPoDVCqtBCk/jeYHn7
         Jbyq2L1zm69/cVLOnudo85FFcFP5vzBbiQAIIwlz+V+5I7Qs20CBs0K/39MkbDLDlcft
         cYnA==
X-Gm-Message-State: AOUpUlH4vNLTl6hV2CVm+sxF01cJ4SVxpCHXlFiKV6I1YwcELwSLn6jP
        AEmix2AnAd//rzGaPC6wPUv8RaoU
X-Google-Smtp-Source: AAOMgpcJH9yFdSdMOLNAS3Ul5UWuHR+8DY9LADHoigBplXc1LRNqxSEp6Ku17KmA7uAxser9JsLhHg==
X-Received: by 2002:a19:f70d:: with SMTP id z13-v6mr10619719lfe.33.1532966397066;
        Mon, 30 Jul 2018 08:59:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a18-v6sm2141682ljk.47.2018.07.30.08.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 08:59:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC] Color merge conflicts
Date:   Mon, 30 Jul 2018 17:59:50 +0200
Message-Id: <20180730155950.17329-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.656.gda699b98b3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the things I notice when watching a normal git user face a
merge conflicts is the output is very verbose (especially when there
are multiple conflicts) and it's hard to spot the important parts to
start resolving conflicts unless you know what to look for.

This is the start to hopefully help that a bit. One thing I'm not sure
is what to color because that affects the config keys we use for
this. If we have to color different things, it's best to go
"color.merge.<slot>" but if this is the only place to color, that slot
thing looks over-engineered.

Perhaps another piece to color is the conflicted path? Maybe. But on
the other hand, I don't think we want a chameleon output, just enough
visual cues to go from one conflict to the next...

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 merge-recursive.c | 133 +++++++++++++++++++++++++++-------------------
 2 files changed, 79 insertions(+), 55 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 113c1d6962..b800101538 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -26,6 +26,7 @@
 #include "dir.h"
 #include "submodule.h"
 #include "revision.h"
+#include "color.h"
 
 struct path_hashmap_entry {
 	struct hashmap_entry e;
@@ -286,6 +287,28 @@ static void output(struct merge_options *o, int v, const char *fmt, ...)
 		flush_output(o);
 }
 
+__attribute__((format (printf, 3, 4)))
+static void conflict_output(struct merge_options *o, int v, const char *fmt, ...)
+{
+	va_list ap;
+
+	if (!show(o, v))
+		return;
+
+	strbuf_addchars(&o->obuf, ' ', o->call_depth * 2);
+
+	strbuf_addf(&o->obuf, "%s%s%s ",
+		    GIT_COLOR_RED, _("CONFLICT"), GIT_COLOR_RESET);
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&o->obuf, fmt, ap);
+	va_end(ap);
+
+	strbuf_addch(&o->obuf, '\n');
+	if (!o->buffer_output)
+		flush_output(o);
+}
+
 static void output_commit_title(struct merge_options *o, struct commit *commit)
 {
 	struct merge_remote_desc *desc;
@@ -1497,27 +1520,27 @@ static int handle_change_delete(struct merge_options *o,
 		 */
 		if (!alt_path) {
 			if (!old_path) {
-				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
-				       "and %s in %s. Version %s of %s left in tree."),
-				       change, path, delete_branch, change_past,
-				       change_branch, change_branch, path);
+				conflict_output(o, 1, _("(%s/delete): %s deleted in %s "
+							"and %s in %s. Version %s of %s left in tree."),
+						change, path, delete_branch, change_past,
+						change_branch, change_branch, path);
 			} else {
-				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
-				       "and %s to %s in %s. Version %s of %s left in tree."),
-				       change, old_path, delete_branch, change_past, path,
-				       change_branch, change_branch, path);
+				conflict_output(o, 1, _("(%s/delete): %s deleted in %s "
+							"and %s to %s in %s. Version %s of %s left in tree."),
+						change, old_path, delete_branch, change_past, path,
+						change_branch, change_branch, path);
 			}
 		} else {
 			if (!old_path) {
-				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
-				       "and %s in %s. Version %s of %s left in tree at %s."),
-				       change, path, delete_branch, change_past,
-				       change_branch, change_branch, path, alt_path);
+				conflict_output(o, 1, _("(%s/delete): %s deleted in %s "
+							"and %s in %s. Version %s of %s left in tree at %s."),
+						change, path, delete_branch, change_past,
+						change_branch, change_branch, path, alt_path);
 			} else {
-				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
-				       "and %s to %s in %s. Version %s of %s left in tree at %s."),
-				       change, old_path, delete_branch, change_past, path,
-				       change_branch, change_branch, path, alt_path);
+				conflict_output(o, 1, _("(%s/delete): %s deleted in %s "
+							"and %s to %s in %s. Version %s of %s left in tree at %s."),
+						change, old_path, delete_branch, change_past, path,
+						change_branch, change_branch, path, alt_path);
 			}
 		}
 		/*
@@ -1647,12 +1670,12 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 	struct diff_filespec *a = ci->pair1->two;
 	struct diff_filespec *b = ci->pair2->two;
 
-	output(o, 1, _("CONFLICT (rename/rename): "
-	       "Rename \"%s\"->\"%s\" in branch \"%s\" "
-	       "rename \"%s\"->\"%s\" in \"%s\"%s"),
-	       one->path, a->path, ci->branch1,
-	       one->path, b->path, ci->branch2,
-	       o->call_depth ? _(" (left unresolved)") : "");
+	conflict_output(o, 1, _("(rename/rename): "
+				"Rename \"%s\"->\"%s\" in branch \"%s\" "
+				"rename \"%s\"->\"%s\" in \"%s\"%s"),
+			one->path, a->path, ci->branch1,
+			one->path, b->path, ci->branch2,
+			o->call_depth ? _(" (left unresolved)") : "");
 	if (o->call_depth) {
 		struct merge_file_info mfi;
 		struct diff_filespec other;
@@ -1716,11 +1739,11 @@ static int handle_rename_rename_2to1(struct merge_options *o,
 	struct merge_file_info mfi_c2;
 	int ret;
 
-	output(o, 1, _("CONFLICT (rename/rename): "
-	       "Rename %s->%s in %s. "
-	       "Rename %s->%s in %s"),
-	       a->path, c1->path, ci->branch1,
-	       b->path, c2->path, ci->branch2);
+	conflict_output(o, 1, _("(rename/rename): "
+				"Rename %s->%s in %s. "
+				"Rename %s->%s in %s"),
+			a->path, c1->path, ci->branch1,
+			b->path, c2->path, ci->branch2);
 
 	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
 	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
@@ -1973,12 +1996,12 @@ static char *handle_path_level_conflicts(struct merge_options *o,
 		/* This should only happen when entry->non_unique_new_dir set */
 		if (!entry->non_unique_new_dir)
 			BUG("entry->non_unqiue_dir not set and !new_path");
-		output(o, 1, _("CONFLICT (directory rename split): "
-			       "Unclear where to place %s because directory "
-			       "%s was renamed to multiple other directories, "
-			       "with no destination getting a majority of the "
-			       "files."),
-		       path, entry->dir);
+		conflict_output(o, 1, _("(directory rename split): "
+					"Unclear where to place %s because directory "
+					"%s was renamed to multiple other directories, "
+					"with no destination getting a majority of the "
+					"files."),
+				path, entry->dir);
 		clean = 0;
 		return NULL;
 	}
@@ -2005,20 +2028,20 @@ static char *handle_path_level_conflicts(struct merge_options *o,
 		collision_ent->reported_already = 1;
 		strbuf_add_separated_string_list(&collision_paths, ", ",
 						 &collision_ent->source_files);
-		output(o, 1, _("CONFLICT (implicit dir rename): Existing "
-			       "file/dir at %s in the way of implicit "
-			       "directory rename(s) putting the following "
-			       "path(s) there: %s."),
-		       new_path, collision_paths.buf);
+		conflict_output(o, 1, _("(implicit dir rename): Existing "
+					"file/dir at %s in the way of implicit "
+					"directory rename(s) putting the following "
+					"path(s) there: %s."),
+				new_path, collision_paths.buf);
 		clean = 0;
 	} else if (collision_ent->source_files.nr > 1) {
 		collision_ent->reported_already = 1;
 		strbuf_add_separated_string_list(&collision_paths, ", ",
 						 &collision_ent->source_files);
-		output(o, 1, _("CONFLICT (implicit dir rename): Cannot map "
-			       "more than one path to %s; implicit directory "
-			       "renames tried to put these paths there: %s"),
-		       new_path, collision_paths.buf);
+		conflict_output(o, 1, _("(implicit dir rename): Cannot map "
+					"more than one path to %s; implicit directory "
+					"renames tried to put these paths there: %s"),
+				new_path, collision_paths.buf);
 		clean = 0;
 	}
 
@@ -2107,11 +2130,11 @@ static void handle_directory_level_conflicts(struct merge_options *o,
 			 * know that head_ent->new_dir and merge_ent->new_dir
 			 * are different strings.
 			 */
-			output(o, 1, _("CONFLICT (rename/rename): "
-				       "Rename directory %s->%s in %s. "
-				       "Rename directory %s->%s in %s"),
-			       head_ent->dir, head_ent->new_dir.buf, o->branch1,
-			       head_ent->dir, merge_ent->new_dir.buf, o->branch2);
+			conflict_output(o, 1, _("(rename/rename): "
+						"Rename directory %s->%s in %s. "
+						"Rename directory %s->%s in %s"),
+					head_ent->dir, head_ent->new_dir.buf, o->branch1,
+					head_ent->dir, merge_ent->new_dir.buf, o->branch2);
 			string_list_append(&remove_from_head,
 					   head_ent->dir)->util = head_ent;
 			strbuf_release(&head_ent->new_dir);
@@ -2758,10 +2781,10 @@ static int process_renames(struct merge_options *o,
 			} else if (!oid_eq(&dst_other.oid, &null_oid)) {
 				clean_merge = 0;
 				try_merge = 1;
-				output(o, 1, _("CONFLICT (rename/add): Rename %s->%s in %s. "
-				       "%s added in %s"),
-				       ren1_src, ren1_dst, branch1,
-				       ren1_dst, branch2);
+				conflict_output(o, 1, _("(rename/add): Rename %s->%s in %s. "
+							"%s added in %s"),
+						ren1_src, ren1_dst, branch1,
+						ren1_dst, branch2);
 				if (o->call_depth) {
 					struct merge_file_info mfi;
 					if (merge_file_one(o, ren1_dst, &null_oid, 0,
@@ -3079,7 +3102,7 @@ static int merge_content(struct merge_options *o,
 	if (!mfi.clean) {
 		if (S_ISGITLINK(mfi.mode))
 			reason = _("submodule");
-		output(o, 1, _("CONFLICT (%s): Merge conflict in %s"),
+		conflict_output(o, 1, _("(%s): Merge conflict in %s"),
 				reason, path);
 		if (rename_conflict_info && !df_conflict_remains)
 			if (update_stages(o, path, &one, &a, &b))
@@ -3240,9 +3263,9 @@ static int process_entry(struct merge_options *o,
 			       0)) {
 			char *new_path = unique_path(o, path, add_branch);
 			clean_merge = 0;
-			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
-			       "Adding %s as %s"),
-			       conf, path, other_branch, path, new_path);
+			conflict_output(o, 1, _("(%s): There is a directory with name %s in %s. "
+						"Adding %s as %s"),
+					conf, path, other_branch, path, new_path);
 			if (update_file(o, 0, oid, mode, new_path))
 				clean_merge = -1;
 			else if (o->call_depth)
-- 
2.18.0.656.gda699b98b3

