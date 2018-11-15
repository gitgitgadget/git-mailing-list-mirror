Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7481F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 21:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeKPIDR (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 03:03:17 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37965 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeKPIDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 03:03:16 -0500
Received: by mail-pf1-f169.google.com with SMTP id q1so2333962pfi.5
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 13:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJX6dpjBw4YYu7xL58VeuM217CsAfJCKukZfSxtJV5U=;
        b=YSgaqxyqeqbskp+DpC4aHVav9/ekXy1wBuCy5bFX7lQTY0s3iAzGlnUSRnrJoon6X1
         iPDMJ9RZeFjGdHQG7ooKn7H3o+sy7zxcYbN24t1tzmYSjQuvntqCmKTbLoSDIgfYEZ+i
         cO00HiCubFXTVA0RNmeuzCQxumhyXJwIn1CKvHTLfKnNVP+08Ogvxj7rq+FpU1xT9s6i
         Cf2jSE0n8Apo9UIWYhFCwPQAYbJMV8wKyjxMCyWp5xI9bniC3CJW9/Ajr/JLzBRb9r5+
         aNFVSxulABzEgb2KBFNzh/+V6iVHfhqjIEZwNLK1hb2cTuFQvwo/M0QiYTikNOq/EOKf
         HzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJX6dpjBw4YYu7xL58VeuM217CsAfJCKukZfSxtJV5U=;
        b=rjbEV0E274mr9Yj647kikAliSZwNEPCESaTBBDCURZpfl+VGtQ0YioyI9owCaMvoob
         6eH7zwKWDtB86DurE58aYjJf1vLEMTWpV2NITYGe66INoZWIOh4ZQZ0Ok0gZmRfXRyqc
         3F50pik+0Gwp2hUI3CaylRTecDm4aym3Jcz5QFMS7WHxPqhfmVXLjNPhxbfudpIneQ44
         H600YIt69MIxnfWYfhWh9wkrSH+CHA94mlkRwZmhMdPWlNFEqb72Zpc96cGqYHBZrOYZ
         hhol992donHPMZlXsERsoj6RAeMhi4hYPg6vEsXCzr2R98317CEek32CgKC+z59eeaG1
         y7aA==
X-Gm-Message-State: AGRZ1gIowkk/sKL/k6KX384gHSGPcPdh6/5Z1+wMiX13BYhxX53l7Way
        VmiovjyxLRq+5qYIKm0ND41BeA==
X-Google-Smtp-Source: AJdET5dwEVrW6A1NVcFfY0p5sv9swdd4Pm+kS5leCX5z7WEMhuvgrvJI9l9ofESIvCFdzqFRNb8YgQ==
X-Received: by 2002:a63:6cc7:: with SMTP id h190-v6mr7272153pgc.216.1542318821142;
        Thu, 15 Nov 2018 13:53:41 -0800 (PST)
Received: from localhost ([2601:647:5180:35d7::13ed])
        by smtp.gmail.com with ESMTPSA id l72-v6sm33576828pfi.149.2018.11.15.13.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 13:53:40 -0800 (PST)
From:   Michael Forney <mforney@mforney.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Confusing behavior with ignored submodules and `git commit -a`
Date:   Thu, 15 Nov 2018 13:53:39 -0800
Message-Id: <20181115215339.28289-1-mforney@mforney.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <CAGw6cBvLGZKcf1em0d47hcCuKau2QVbX4wfb0yN+m4umbNLaRg@mail.gmail.com>
References: <CAGw6cBvLGZKcf1em0d47hcCuKau2QVbX4wfb0yN+m4umbNLaRg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-11-15, Michael Forney <mforney@mforney.org> wrote:
> Here is a work-in-progress diff that seems to have the correct
> behavior in all cases I tried.

I was hoping that gmail wouldn't mess with the whitespace, but apparently
it has, sorry about that. Let me try again.

---
 builtin/add.c |  1 -
 diff-lib.c    | 15 +++++++++------
 diff.c        | 22 ++--------------------
 3 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f65c17229..9902f7742 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -117,7 +117,6 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &data;
-	rev.diffopt.flags.override_submodule_config = 1;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	clear_pathspec(&rev.prune_data);
diff --git a/diff-lib.c b/diff-lib.c
index 83fce5151..fbb048cca 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -68,12 +68,13 @@ static int check_removed(const struct cache_entry *ce, struct stat *st)
 static int match_stat_with_submodule(struct diff_options *diffopt,
 				     const struct cache_entry *ce,
 				     struct stat *st, unsigned ce_option,
-				     unsigned *dirty_submodule)
+				     unsigned *dirty_submodule,
+				     int exact)
 {
 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct diff_flags orig_flags = diffopt->flags;
-		if (!diffopt->flags.override_submodule_config)
+		if (!diffopt->flags.override_submodule_config && !exact)
 			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
 		if (diffopt->flags.ignore_submodules)
 			changed = 0;
@@ -88,7 +89,7 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 
 int run_diff_files(struct rev_info *revs, unsigned int option)
 {
-	int entries, i;
+	int entries, i, matched;
 	int diff_unmerged_stage = revs->max_count;
 	unsigned ce_option = ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
@@ -110,7 +111,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
 
-		if (!ce_path_match(istate, ce, &revs->prune_data, NULL))
+		matched = ce_path_match(istate, ce, &revs->prune_data, NULL);
+		if (!matched)
 			continue;
 
 		if (ce_stage(ce)) {
@@ -226,7 +228,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			}
 
 			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
-							    ce_option, &dirty_submodule);
+							    ce_option, &dirty_submodule,
+							    matched == MATCHED_EXACTLY);
 			newmode = ce_mode_from_stat(ce, st.st_mode);
 		}
 
@@ -292,7 +295,7 @@ static int get_stat_data(const struct cache_entry *ce,
 			return -1;
 		}
 		changed = match_stat_with_submodule(diffopt, ce, &st,
-						    0, dirty_submodule);
+						    0, dirty_submodule, 0);
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
 			oid = &null_oid;
diff --git a/diff.c b/diff.c
index e38d1ecaf..73dc75286 100644
--- a/diff.c
+++ b/diff.c
@@ -6209,24 +6209,6 @@ int diff_can_quit_early(struct diff_options *opt)
 		opt->flags.has_changes);
 }
 
-/*
- * Shall changes to this submodule be ignored?
- *
- * Submodule changes can be configured to be ignored separately for each path,
- * but that configuration can be overridden from the command line.
- */
-static int is_submodule_ignored(const char *path, struct diff_options *options)
-{
-	int ignored = 0;
-	struct diff_flags orig_flags = options->flags;
-	if (!options->flags.override_submodule_config)
-		set_diffopt_flags_from_submodule_config(options, path);
-	if (options->flags.ignore_submodules)
-		ignored = 1;
-	options->flags = orig_flags;
-	return ignored;
-}
-
 void diff_addremove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const struct object_id *oid,
@@ -6235,7 +6217,7 @@ void diff_addremove(struct diff_options *options,
 {
 	struct diff_filespec *one, *two;
 
-	if (S_ISGITLINK(mode) && is_submodule_ignored(concatpath, options))
+	if (S_ISGITLINK(mode) && options->flags.ignore_submodules)
 		return;
 
 	/* This may look odd, but it is a preparation for
@@ -6285,7 +6267,7 @@ void diff_change(struct diff_options *options,
 	struct diff_filepair *p;
 
 	if (S_ISGITLINK(old_mode) && S_ISGITLINK(new_mode) &&
-	    is_submodule_ignored(concatpath, options))
+	    options->flags.ignore_submodules)
 		return;
 
 	if (options->flags.reverse_diff) {
-- 
2.19.1

