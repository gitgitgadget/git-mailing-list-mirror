Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D6E31F404
	for <e@80x24.org>; Thu,  6 Sep 2018 00:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeIFF0P (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 01:26:15 -0400
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:47121 "EHLO
        fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeIFF0P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 01:26:15 -0400
Received: from fed1rmimpo210.cox.net ([68.230.241.161])
          by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180906005330.UTJL4167.fed1rmfepo201.cox.net@fed1rmimpo210.cox.net>
          for <git@vger.kernel.org>; Wed, 5 Sep 2018 20:53:30 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo210.cox.net with cox
        id Y0tV1y00m59yGBo010tW7z; Wed, 05 Sep 2018 20:53:30 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090210.5B907A8A.004E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=Vv1TO6+n c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=WDhBSedXqNQA:10 a=kviXuzpPAAAA:8
 a=-rZcr-M_gChtg2RW1k0A:9 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 8BAF629A0145;
        Wed,  5 Sep 2018 17:53:29 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Git List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/4] wt-status: rename commitable to committable
Date:   Wed,  5 Sep 2018 17:53:27 -0700
Message-Id: <20180906005329.11277-3-ischis2@cox.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180906005329.11277-1-ischis2@cox.net>
References: <20180906005329.11277-1-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix variable spelling error.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 builtin/commit.c | 18 +++++++++---------
 wt-status.c      | 10 +++++-----
 wt-status.h      |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0d9828e29..51ecebbec 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -507,7 +507,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	wt_status_collect(s);
 	wt_status_print(s);
 
-	return s->commitable;
+	return s->committable;
 }
 
 static int is_a_merge(const struct commit *current_head)
@@ -653,7 +653,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 {
 	struct stat statbuf;
 	struct strbuf committer_ident = STRBUF_INIT;
-	int commitable;
+	int committable;
 	struct strbuf sb = STRBUF_INIT;
 	const char *hook_arg1 = NULL;
 	const char *hook_arg2 = NULL;
@@ -870,7 +870,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
-		commitable = run_status(s->fp, index_file, prefix, 1, s);
+		committable = run_status(s->fp, index_file, prefix, 1, s);
 		s->use_color = saved_color_setting;
 	} else {
 		struct object_id oid;
@@ -888,7 +888,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			for (i = 0; i < active_nr; i++)
 				if (ce_intent_to_add(active_cache[i]))
 					ita_nr++;
-			commitable = active_nr - ita_nr > 0;
+			committable = active_nr - ita_nr > 0;
 		} else {
 			/*
 			 * Unless the user did explicitly request a submodule
@@ -904,7 +904,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			if (ignore_submodule_arg &&
 			    !strcmp(ignore_submodule_arg, "all"))
 				flags.ignore_submodules = 1;
-			commitable = index_differs_from(parent, &flags, 1);
+			committable = index_differs_from(parent, &flags, 1);
 		}
 	}
 	strbuf_release(&committer_ident);
@@ -916,7 +916,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 * explicit --allow-empty. In the cherry-pick case, it may be
 	 * empty due to conflict resolution, which the user should okay.
 	 */
-	if (!commitable && whence != FROM_MERGE && !allow_empty &&
+	if (!committable && whence != FROM_MERGE && !allow_empty &&
 	    !(amend && is_a_merge(current_head))) {
 		s->display_comment_prefix = old_display_comment_prefix;
 		run_status(stdout, index_file, prefix, 0, s);
@@ -1186,14 +1186,14 @@ static int parse_and_validate_options(int argc, const char *argv[],
 static int dry_run_commit(int argc, const char **argv, const char *prefix,
 			  const struct commit *current_head, struct wt_status *s)
 {
-	int commitable;
+	int committable;
 	const char *index_file;
 
 	index_file = prepare_index(argc, argv, prefix, current_head, 1);
-	commitable = run_status(stdout, index_file, prefix, 0, s);
+	committable = run_status(stdout, index_file, prefix, 0, s);
 	rollback_index_files();
 
-	return commitable ? 0 : 1;
+	return committable ? 0 : 1;
 }
 
 define_list_config_array_extra(color_status_slots, {"added"});
diff --git a/wt-status.c b/wt-status.c
index 180faf6ba..4962b5bc8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -786,7 +786,7 @@ static void wt_longstatus_print_updated(struct wt_status *s)
 			continue;
 		if (!shown_header) {
 			wt_longstatus_print_cached_header(s);
-			s->commitable = 1;
+			s->committable = 1;
 			shown_header = 1;
 		}
 		wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);
@@ -1021,7 +1021,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 		rev.diffopt.use_color = 0;
 		wt_status_add_cut_line(s->fp);
 	}
-	if (s->verbose > 1 && s->commitable) {
+	if (s->verbose > 1 && s->committable) {
 		/* print_updated() printed a header, so do we */
 		if (s->fp != stdout)
 			wt_longstatus_print_trailer(s);
@@ -1089,7 +1089,7 @@ static void show_merge_in_progress(struct wt_status *s,
 					 _("  (use \"git merge --abort\" to abort the merge)"));
 		}
 	} else {
-		s-> commitable = 1;
+		s-> committable = 1;
 		status_printf_ln(s, color,
 			_("All conflicts fixed but you are still merging."));
 		if (s->hints)
@@ -1665,14 +1665,14 @@ static void wt_longstatus_print(struct wt_status *s)
 					   "new files yourself (see 'git help status')."),
 					 s->untracked_in_ms / 1000.0);
 		}
-	} else if (s->commitable)
+	} else if (s->committable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),
 			s->hints
 			? _(" (use -u option to show untracked files)") : "");
 
 	if (s->verbose)
 		wt_longstatus_print_verbose(s);
-	if (!s->commitable) {
+	if (!s->committable) {
 		if (s->amend)
 			status_printf_ln(s, GIT_COLOR_NORMAL, _("No changes"));
 		else if (s->nowarn)
diff --git a/wt-status.h b/wt-status.h
index 1673d146f..937b2c352 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -96,7 +96,7 @@ struct wt_status {
 	unsigned char sha1_commit[GIT_MAX_RAWSZ]; /* when not Initial */
 
 	/* These are computed during processing of the individual sections */
-	int commitable;
+	int committable;
 	int workdir_dirty;
 	const char *index_file;
 	FILE *fp;
-- 
2.18.0

