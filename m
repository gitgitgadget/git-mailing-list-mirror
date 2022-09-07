Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AE1C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiIGOiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiIGOiC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:38:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93BC796BA
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:37:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bp20so20235379wrb.9
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Q6ItcPI6xHP71TlY+fYKLbGe9zwtY+Rr4iUmMfLEpzg=;
        b=XP/IBG9CLkxbTV+VIvBxKkxQ7iejv7IID4FAy0j2EbtpHq5cOACYcp0NC3b2i1IAkY
         EGALY3/T2d4lixVItGeg6YII8ZHMeF2UFd1Fv6HcB5s4L9IVlD+TKVXu4kqkf6bj1uLU
         Aia7zrpssHrm8MBQ9ouz8g0rL2bCm7GoJSm2NvM+jjYtraCf8XQOfEJ0UROeDXfXdLI/
         Pwel77h/r3UPVu8mATtKeAPqqtzY5DLgLEdK0bgycqdu9sJIGf9g4g6Q2NO+C7gqrTyu
         UVEK6DHkVhFhA/FFR7X7VKKiXC3xYBt0lVQ5/YI5jh6mb2Rm7tb3SoE/YynRN4co68l2
         YNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Q6ItcPI6xHP71TlY+fYKLbGe9zwtY+Rr4iUmMfLEpzg=;
        b=49Iy/31siDtlgwbWBlKC0Z9/jRY+5lrV7wJjRmECRDfBRm3sLbI5i4kF0JBTw3eziT
         d1HC7A1jqw3wO7fL7fPKUkBt8v/bBOSP9KuC9EyVyI6r2iU8SGHFrcL/Y4K/W21+KBt5
         RqtdCxx8ySBTxj+U8UoPVHQkHUK8tfO4QMMbQDvNrsVMXTvfpJoBUVhuci9ocqcdxQ2a
         qGruWnAqR0qghFVUDpgh50BlqwQ3UsENxzRfuxv4Ki3rDqqgPaVKwzSaWWgerVSeLx/b
         4eJivofJlRm6cGewBsqw9eweGY7hCJd8xoO2TFyUho41DuU66/K8xSlwCfr1jbZtoh4o
         algQ==
X-Gm-Message-State: ACgBeo2R0vk4Yep+dMdfZ0px3ORvTYMcsKjk1m+9EOsL2vkYpKJRWoNL
        BA492dscgZckhzKNghhxoM//s0q7Nrg=
X-Google-Smtp-Source: AA6agR4IElyOoTgTulJUGqT5Yp7YNCJGBAsTUwwWsiHhBJOeNhOzBfICtNCWh+oEH0h0JkIH+mVV1w==
X-Received: by 2002:a5d:65ce:0:b0:228:d8b6:d1 with SMTP id e14-20020a5d65ce000000b00228d8b600d1mr2314484wrw.486.1662561478022;
        Wed, 07 Sep 2022 07:37:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10-20020a1ced0a000000b003a8436e2a94sm18903022wmh.16.2022.09.07.07.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:37:57 -0700 (PDT)
Message-Id: <cca933a5f1d0d2ecbce807a91e379f974e70f6bf.1662561470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Sep 2022 14:37:47 +0000
Subject: [PATCH v2 4/7] rebase: rename merge_base to branch_base
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
index a3cf1ef5923..dd5e0e1feb6 100644
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
@@ -1651,7 +1651,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else if (!options.onto_name)
 		options.onto_name = options.upstream_name;
 	if (strstr(options.onto_name, "...")) {
-		if (get_oid_mb(options.onto_name, &merge_base) < 0) {
+		if (get_oid_mb(options.onto_name, &branch_base) < 0) {
 			if (keep_base)
 				die(_("'%s': need exactly one merge base with branch"),
 				    options.upstream_name);
@@ -1659,7 +1659,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				die(_("'%s': need exactly one merge base"),
 				    options.onto_name);
 		}
-		options.onto = lookup_commit_or_die(&merge_base,
+		options.onto = lookup_commit_or_die(&branch_base,
 						    options.onto_name);
 	} else {
 		options.onto =
@@ -1697,11 +1697,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
 
@@ -1743,12 +1743,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
 
@@ -1760,8 +1760,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1792,7 +1792,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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

