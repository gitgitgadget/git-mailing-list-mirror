From: Jonathan del Strother <maillist@steelskies.com>
Subject: [PATCH] Revert "Convert output messages in merge-recursive to past tense."
Date: Sat, 23 Aug 2008 13:14:57 +0100
Message-ID: <1219493697-85555-1-git-send-email-maillist@steelskies.com>
References: <1219425524-77545-1-git-send-email-maillist@steelskies.com>
Cc: spearce@spearce.org,
	Jonathan del Strother <maillist@steelskies.com>,
	Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 14:16:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWs2L-0004Xi-9E
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 14:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbYHWMPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 08:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbYHWMPF
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 08:15:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:2856 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbYHWMPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 08:15:04 -0400
Received: by wr-out-0506.google.com with SMTP id 69so713093wri.5
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=tuwrlGTfHouk55VUDLwUIZUQcbOhcujM+83xHsBaYqk=;
        b=jYeYWinSzwP0qCGPi0ykip16yzv8sJwvd86pzEPgWdNfuYVyd+/4u6Lr8QlFsKct+X
         Snxi+Puy8nbhvLJR0mCwY1PTANOqbd/5DcnZ23HteKVDXlNVemrAcNJQV2+irD7Kt8oQ
         QfV31DaSzhjsEpfSbsMb2ED4tqk98MIeFJ3NI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=tabTw0m+DHqox6EFWb5EOSIEGqOiNF6RjtdqwqxRYn12HNwXEN1fyekMDFdyKVMvop
         /e119zyFE0Pbcg0SXSE1MEffMAyl/tCxSbdtbMf3bC8pNiZhmQi5leW9sHQwFEX+t70I
         lxSQpirYGslOD6FZi9d85sYF02l+EshrNsbh4=
Received: by 10.90.29.13 with SMTP id c13mr2811623agc.32.1219493701838;
        Sat, 23 Aug 2008 05:15:01 -0700 (PDT)
Received: from localhost ( [89.105.122.147])
        by mx.google.com with ESMTPS id 43sm3948358wri.27.2008.08.23.05.14.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 05:15:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.6.gc667.dirty
In-Reply-To: <1219425524-77545-1-git-send-email-maillist@steelskies.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93461>

Now that the progress meter is gone, merge messages make more sense when presented in present tense

This reverts commit 89f40be294363ce4d14ed6931a65561a4e8e9140.

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---
Sorry about that - that's what I get for trying to do things last thing on a friday.
Adding signed-off, removing the conflict report.

...and trying once more with a non-broken header

 builtin-merge-recursive.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 43e55bf..dfb363e 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -729,13 +729,13 @@ static void conflict_rename_rename(struct rename *ren1,
 	const char *dst_name2 = ren2_dst;
 	if (string_list_has_string(&current_directory_set, ren1_dst)) {
 		dst_name1 = del[delp++] = unique_path(ren1_dst, branch1);
-		output(1, "%s is a directory in %s added as %s instead",
+		output(1, "%s is a directory in %s adding as %s instead",
 		       ren1_dst, branch2, dst_name1);
 		remove_file(0, ren1_dst, 0);
 	}
 	if (string_list_has_string(&current_directory_set, ren2_dst)) {
 		dst_name2 = del[delp++] = unique_path(ren2_dst, branch2);
-		output(1, "%s is a directory in %s added as %s instead",
+		output(1, "%s is a directory in %s adding as %s instead",
 		       ren2_dst, branch1, dst_name2);
 		remove_file(0, ren2_dst, 0);
 	}
@@ -760,7 +760,7 @@ static void conflict_rename_dir(struct rename *ren1,
 				const char *branch1)
 {
 	char *new_path = unique_path(ren1->pair->two->path, branch1);
-	output(1, "Renamed %s to %s instead", ren1->pair->one->path, new_path);
+	output(1, "Renaming %s to %s instead", ren1->pair->one->path, new_path);
 	remove_file(0, ren1->pair->two->path, 0);
 	update_file(0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path);
 	free(new_path);
@@ -773,7 +773,7 @@ static void conflict_rename_rename_2(struct rename *ren1,
 {
 	char *new_path1 = unique_path(ren1->pair->two->path, branch1);
 	char *new_path2 = unique_path(ren2->pair->two->path, branch2);
-	output(1, "Renamed %s to %s and %s to %s instead",
+	output(1, "Renaming %s to %s and %s to %s instead",
 	       ren1->pair->one->path, new_path1,
 	       ren2->pair->one->path, new_path2);
 	remove_file(0, ren1->pair->two->path, 0);
@@ -887,10 +887,10 @@ static int process_renames(struct string_list *a_renames,
 						 branch1,
 						 branch2);
 				if (mfi.merge || !mfi.clean)
-					output(1, "Renamed %s->%s", src, ren1_dst);
+					output(1, "Renaming %s->%s", src, ren1_dst);
 
 				if (mfi.merge)
-					output(2, "Auto-merged %s", ren1_dst);
+					output(2, "Auto-merging %s", ren1_dst);
 
 				if (!mfi.clean) {
 					output(1, "CONFLICT (content): merge conflict in %s",
@@ -924,14 +924,14 @@ static int process_renames(struct string_list *a_renames,
 
 			if (string_list_has_string(&current_directory_set, ren1_dst)) {
 				clean_merge = 0;
-				output(1, "CONFLICT (rename/directory): Renamed %s->%s in %s "
+				output(1, "CONFLICT (rename/directory): Rename %s->%s in %s "
 				       " directory %s added in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren1_dst, branch2);
 				conflict_rename_dir(ren1, branch1);
 			} else if (sha_eq(src_other.sha1, null_sha1)) {
 				clean_merge = 0;
-				output(1, "CONFLICT (rename/delete): Renamed %s->%s in %s "
+				output(1, "CONFLICT (rename/delete): Rename %s->%s in %s "
 				       "and deleted in %s",
 				       ren1_src, ren1_dst, branch1,
 				       branch2);
@@ -940,19 +940,19 @@ static int process_renames(struct string_list *a_renames,
 				const char *new_path;
 				clean_merge = 0;
 				try_merge = 1;
-				output(1, "CONFLICT (rename/add): Renamed %s->%s in %s. "
+				output(1, "CONFLICT (rename/add): Rename %s->%s in %s. "
 				       "%s added in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren1_dst, branch2);
 				new_path = unique_path(ren1_dst, branch2);
-				output(1, "Added as %s instead", new_path);
+				output(1, "Adding as %s instead", new_path);
 				update_file(0, dst_other.sha1, dst_other.mode, new_path);
 			} else if ((item = string_list_lookup(ren1_dst, renames2Dst))) {
 				ren2 = item->util;
 				clean_merge = 0;
 				ren2->processed = 1;
-				output(1, "CONFLICT (rename/rename): Renamed %s->%s in %s. "
-				       "Renamed %s->%s in %s",
+				output(1, "CONFLICT (rename/rename): Rename %s->%s in %s. "
+				       "Rename %s->%s in %s",
 				       ren1_src, ren1_dst, branch1,
 				       ren2->pair->one->path, ren2->pair->two->path, branch2);
 				conflict_rename_rename_2(ren1, branch1, ren2, branch2);
@@ -986,9 +986,9 @@ static int process_renames(struct string_list *a_renames,
 					output(3, "Skipped %s (merged same as existing)", ren1_dst);
 				else {
 					if (mfi.merge || !mfi.clean)
-						output(1, "Renamed %s => %s", ren1_src, ren1_dst);
+						output(1, "Renaming %s => %s", ren1_src, ren1_dst);
 					if (mfi.merge)
-						output(2, "Auto-merged %s", ren1_dst);
+						output(2, "Auto-merging %s", ren1_dst);
 					if (!mfi.clean) {
 						output(1, "CONFLICT (rename/modify): Merge conflict in %s",
 						       ren1_dst);
@@ -1039,7 +1039,7 @@ static int process_entry(const char *path, struct stage_data *entry,
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
 			if (a_sha)
-				output(2, "Removed %s", path);
+				output(2, "Removing %s", path);
 			/* do not touch working file if it did not exist */
 			remove_file(1, path, !a_sha);
 		} else {
@@ -1086,12 +1086,12 @@ static int process_entry(const char *path, struct stage_data *entry,
 			const char *new_path = unique_path(path, add_branch);
 			clean_merge = 0;
 			output(1, "CONFLICT (%s): There is a directory with name %s in %s. "
-			       "Added %s as %s",
+			       "Adding %s as %s",
 			       conf, path, other_branch, path, new_path);
 			remove_file(0, path, 0);
 			update_file(0, sha, mode, new_path);
 		} else {
-			output(2, "Added %s", path);
+			output(2, "Adding %s", path);
 			update_file(1, sha, mode, path);
 		}
 	} else if (a_sha && b_sha) {
@@ -1105,7 +1105,7 @@ static int process_entry(const char *path, struct stage_data *entry,
 			reason = "add/add";
 			o_sha = (unsigned char *)null_sha1;
 		}
-		output(2, "Auto-merged %s", path);
+		output(2, "Auto-merging %s", path);
 		o.path = a.path = b.path = (char *)path;
 		hashcpy(o.sha1, o_sha);
 		o.mode = o_mode;
-- 
1.6.0.6.gc667.dirty
