Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6CCC1F51C
	for <e@80x24.org>; Sat, 19 May 2018 02:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeESCHM (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 22:07:12 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59106 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752210AbeESCHF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 May 2018 22:07:05 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4J263gY024696;
        Fri, 18 May 2018 19:07:03 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2j23ryhmu1-1;
        Fri, 18 May 2018 19:07:03 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 066EC229B0EA;
        Fri, 18 May 2018 19:07:03 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id F1A472CDEF0;
        Fri, 18 May 2018 19:07:02 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/5] merge-recursive: fix numerous argument alignment issues
Date:   Fri, 18 May 2018 19:06:57 -0700
Message-Id: <20180519020700.2241-3-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.847.g20b8963732
In-Reply-To: <20180519020700.2241-1-newren@gmail.com>
References: <20180519020700.2241-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1805190021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Various refactorings throughout the code have left lots of alignment
issues that were driving me crazy; fix them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c430fd72bc..01306c87eb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -308,8 +308,8 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 }
 
 static int add_cacheinfo(struct merge_options *o,
-		unsigned int mode, const struct object_id *oid,
-		const char *path, int stage, int refresh, int options)
+			 unsigned int mode, const struct object_id *oid,
+			 const char *path, int stage, int refresh, int options)
 {
 	struct cache_entry *ce;
 	int ret;
@@ -409,8 +409,8 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 }
 
 static int save_files_dirs(const struct object_id *oid,
-		struct strbuf *base, const char *path,
-		unsigned int mode, int stage, void *context)
+			   struct strbuf *base, const char *path,
+			   unsigned int mode, int stage, void *context)
 {
 	struct path_hashmap_entry *entry;
 	int baselen = base->len;
@@ -1257,13 +1257,13 @@ static int conflict_rename_dir(struct merge_options *o,
 }
 
 static int handle_change_delete(struct merge_options *o,
-				 const char *path, const char *old_path,
-				 const struct object_id *o_oid, int o_mode,
-				 const struct object_id *changed_oid,
-				 int changed_mode,
-				 const char *change_branch,
-				 const char *delete_branch,
-				 const char *change, const char *change_past)
+				const char *path, const char *old_path,
+				const struct object_id *o_oid, int o_mode,
+				const struct object_id *changed_oid,
+				int changed_mode,
+				const char *change_branch,
+				const char *delete_branch,
+				const char *change, const char *change_past)
 {
 	char *alt_path = NULL;
 	const char *update_path = path;
@@ -1324,9 +1324,9 @@ static int handle_change_delete(struct merge_options *o,
 }
 
 static int conflict_rename_delete(struct merge_options *o,
-				   struct diff_filepair *pair,
-				   const char *rename_branch,
-				   const char *delete_branch)
+				  struct diff_filepair *pair,
+				  const char *rename_branch,
+				  const char *delete_branch)
 {
 	const struct diff_filespec *orig = pair->one;
 	const struct diff_filespec *dest = pair->two;
@@ -1429,7 +1429,7 @@ static int handle_file(struct merge_options *o,
 }
 
 static int conflict_rename_rename_1to2(struct merge_options *o,
-					struct rename_conflict_info *ci)
+				       struct rename_conflict_info *ci)
 {
 	/* One file was renamed in both branches, but to different names. */
 	struct diff_filespec *one = ci->pair1->one;
@@ -1491,7 +1491,7 @@ static int conflict_rename_rename_1to2(struct merge_options *o,
 }
 
 static int conflict_rename_rename_2to1(struct merge_options *o,
-					struct rename_conflict_info *ci)
+				       struct rename_conflict_info *ci)
 {
 	/* Two files, a & b, were renamed to the same thing, c. */
 	struct diff_filespec *a = ci->pair1->one;
@@ -2710,7 +2710,8 @@ static struct object_id *stage_oid(const struct object_id *oid, unsigned mode)
 }
 
 static int read_oid_strbuf(struct merge_options *o,
-	const struct object_id *oid, struct strbuf *dst)
+			   const struct object_id *oid,
+			   struct strbuf *dst)
 {
 	void *buf;
 	enum object_type type;
@@ -2763,10 +2764,10 @@ static int blob_unchanged(struct merge_options *opt,
 }
 
 static int handle_modify_delete(struct merge_options *o,
-				 const char *path,
-				 struct object_id *o_oid, int o_mode,
-				 struct object_id *a_oid, int a_mode,
-				 struct object_id *b_oid, int b_mode)
+				const char *path,
+				struct object_id *o_oid, int o_mode,
+				struct object_id *a_oid, int a_mode,
+				struct object_id *b_oid, int b_mode)
 {
 	const char *modify_branch, *delete_branch;
 	struct object_id *changed_oid;
@@ -3303,14 +3304,14 @@ int merge_recursive_generic(struct merge_options *o,
 			struct commit *base;
 			if (!(base = get_ref(base_list[i], oid_to_hex(base_list[i]))))
 				return err(o, _("Could not parse object '%s'"),
-					oid_to_hex(base_list[i]));
+					   oid_to_hex(base_list[i]));
 			commit_list_insert(base, &ca);
 		}
 	}
 
 	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
-			result);
+				result);
 	if (clean < 0) {
 		rollback_lock_file(&lock);
 		return clean;
-- 
2.17.0.847.g20b8963732

