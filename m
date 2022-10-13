Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F82C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 08:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiJMInQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJMInF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 04:43:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9224415DB0C
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:42:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bv10so1722140wrb.4
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXRpK3Gmha71w1nQdeXTUYi8vteYdTPfLiPwPdRDtkY=;
        b=RxtjCYJa1n+RSsvF8YjNigJg6Bgce2tUip94+jbXAzNHq4fBChrV501zsqN3+oep5M
         2lV8FJp+tzfwpuOKdbbxiHrcHkzbyj3UAo8+fr8zSwEgVuAxmiI7YlFh1ZD1h70/xcN/
         N3wLxNa3f20UGZwJis9F4A0F0gz9zyVHxstk8dd45CADEHIA7Dkv2CqyuLGGJfYRW7fT
         NM3yVo5Tr9FVSwXNBhEsj/VDggxcLN78oSrQyDF2nlOdzAdjWb6S4mC41jmvYo5sAn/S
         0y3LNNtSpeRhfxgXMlBZ5ESYREgLhLXMAG28817NLwrDrvwwnqb/Ho0MScmDqL07fuEY
         c83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXRpK3Gmha71w1nQdeXTUYi8vteYdTPfLiPwPdRDtkY=;
        b=1OIiiEjfwPZZ8vttC1QIdZuihi3azPDdw+R8wMnPkd2hFa4ScjeOZb6BwnRh4n1fCX
         4/FtF7sYExq437ohC+h5nvCR2I7FDGScIZMzF4G55mvJYGjIXm6YHsqNa+tu4X09VjdO
         OhfbhVJ2GX5J8QEucJjd//4S+1ZfSfC1/7Ny+9x+FVo7sBx9WHSCUTOW/0xoijGY1PpO
         IIH0HIA6Z6jV4+lJsA4xQyz6zPY9nscTlHn9HK3+7rLs9OMhOHH/1aE7YTL0zXQ3VQvI
         b98jSeH8r/A6LCFu3UTobeKHOXEr6UK9flBXUkTvAgc31pH+kzQFQykoYOX3QQWF2lNp
         alTA==
X-Gm-Message-State: ACrzQf1lGEFSIAQ91SdZ3KTlzFVc1coSbHOVIC9dSWXW0Z/a7XK6cVeM
        aTUcJdSSFfQOsfSerk7gH0QiFK9A0R4=
X-Google-Smtp-Source: AMsMyM5h1KZLeJcklU6e2VKc4TmXGqb/F55ZZzz0wpatkmA5QRiz8eVgNmIcTvZKDhCueBpCVELV/A==
X-Received: by 2002:adf:ea08:0:b0:22e:46e9:2a8a with SMTP id q8-20020adfea08000000b0022e46e92a8amr21182876wrm.636.1665650575087;
        Thu, 13 Oct 2022 01:42:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b003c6cc57566fsm2616169wmq.14.2022.10.13.01.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 01:42:54 -0700 (PDT)
Message-Id: <00f70c9034452bd87c82fb3aea9658aec32f2ec1.1665650564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 08:42:41 +0000
Subject: [PATCH v3 5/8] rebase: rename merge_base to branch_base
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

merge_base is not a very descriptive name, the variable always holds
the merge-base of 'branch' and 'onto' which is commit at the base of
the branch being rebased so rename it to branch_base.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7e6ce374c59..cbafcc41e75 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -866,22 +866,22 @@ static int is_linear_history(struct commit *from, struct commit *to)
 
 static int can_fast_forward(struct commit *onto, struct commit *upstream,
 			    struct commit *restrict_revision,
-			    struct commit *head, struct object_id *merge_base)
+			    struct commit *head, struct object_id *branch_base)
 {
 	struct commit_list *merge_bases = NULL;
 	int res = 0;
 
 	merge_bases = get_merge_bases(onto, head);
 	if (!merge_bases || merge_bases->next) {
-		oidcpy(merge_base, null_oid());
+		oidcpy(branch_base, null_oid());
 		goto done;
 	}
 
-	oidcpy(merge_base, &merge_bases->item->object.oid);
-	if (!oideq(merge_base, &onto->object.oid))
+	oidcpy(branch_base, &merge_bases->item->object.oid);
+	if (!oideq(branch_base, &onto->object.oid))
 		goto done;
 
-	if (restrict_revision && !oideq(&restrict_revision->object.oid, merge_base))
+	if (restrict_revision && !oideq(&restrict_revision->object.oid, branch_base))
 		goto done;
 
 	if (!upstream)
@@ -1035,7 +1035,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	struct object_id merge_base;
+	struct object_id branch_base;
 	int ignore_whitespace = 0;
 	enum action action = ACTION_NONE;
 	const char *gpg_sign = NULL;
@@ -1653,7 +1653,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else if (!options.onto_name)
 		options.onto_name = options.upstream_name;
 	if (strstr(options.onto_name, "...")) {
-		if (get_oid_mb(options.onto_name, &merge_base) < 0) {
+		if (get_oid_mb(options.onto_name, &branch_base) < 0) {
 			if (keep_base)
 				die(_("'%s': need exactly one merge base with branch"),
 				    options.upstream_name);
@@ -1661,7 +1661,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				die(_("'%s': need exactly one merge base"),
 				    options.onto_name);
 		}
-		options.onto = lookup_commit_or_die(&merge_base,
+		options.onto = lookup_commit_or_die(&branch_base,
 						    options.onto_name);
 	} else {
 		options.onto =
@@ -1699,11 +1699,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * in which case we could fast-forward without replacing the commits
 	 * with new commits recreated by replaying their changes.
 	 *
-	 * Note that can_fast_forward() initializes merge_base, so we have to
+	 * Note that can_fast_forward() initializes branch_base, so we have to
 	 * call it before checking allow_preemptive_ff.
 	 */
 	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
-		    options.orig_head, &merge_base) &&
+		    options.orig_head, &branch_base) &&
 	    allow_preemptive_ff) {
 		int flag;
 
@@ -1745,12 +1745,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		struct diff_options opts;
 
 		if (options.flags & REBASE_VERBOSE) {
-			if (is_null_oid(&merge_base))
+			if (is_null_oid(&branch_base))
 				printf(_("Changes to %s:\n"),
 				       oid_to_hex(&options.onto->object.oid));
 			else
 				printf(_("Changes from %s to %s:\n"),
-				       oid_to_hex(&merge_base),
+				       oid_to_hex(&branch_base),
 				       oid_to_hex(&options.onto->object.oid));
 		}
 
@@ -1762,8 +1762,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename = DIFF_DETECT_RENAME;
 		diff_setup_done(&opts);
-		diff_tree_oid(is_null_oid(&merge_base) ?
-			      the_hash_algo->empty_tree : &merge_base,
+		diff_tree_oid(is_null_oid(&branch_base) ?
+			      the_hash_algo->empty_tree : &branch_base,
 			      &options.onto->object.oid, "", &opts);
 		diffcore_std(&opts);
 		diff_flush(&opts);
@@ -1794,7 +1794,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * we just fast-forwarded.
 	 */
 	strbuf_reset(&msg);
-	if (oideq(&merge_base, &options.orig_head->object.oid)) {
+	if (oideq(&branch_base, &options.orig_head->object.oid)) {
 		printf(_("Fast-forwarded %s to %s.\n"),
 			branch_name, options.onto_name);
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
-- 
gitgitgadget

