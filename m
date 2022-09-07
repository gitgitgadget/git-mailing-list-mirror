Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F7EC6FA86
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiIGOiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIGOiC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:38:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C836C72B61
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:38:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso11996724wmc.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=2yzHLcjtuvUxrHTA/UZk5taVZwKLdxBxKR7daGtKpEY=;
        b=qE6z14NORsLGmfSohxfZ+tBHzWG0n4noKudk8UunLQGnRuDC9g8yb5mCynFyN+DOsW
         LlgXVx58gmT+nM4P3hAwt+YzRyXyicB9pJpFuWD9RAHB0abNMe05pNcFJzfkpiLI8G3y
         kj/tk5FmI5dZGMUGRWtnEWcuUlSqytUODkgqB+dlA7fW9EiwMI4BV92/p60twvksfrUk
         mheUanjyiT5ygyjoQLKzMj1VCQzWwmUblYglk9Ii9F51yYk+P66K1kKCG6gGCrdnBvbw
         L6fQ019z022nBim20hjxkPK54GdoFAMcrSHsW8lNDFkFex6xPrO2/iMEt4d6gW89tvv1
         k0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2yzHLcjtuvUxrHTA/UZk5taVZwKLdxBxKR7daGtKpEY=;
        b=Xsqr1l9JZWY5WlFQifw4DlkFrLDwkxU7WjB76xBCm0gksMcOvg8tqDrbMsLs1gxCPH
         WnS54sAAWE7fARfbH4eRwvFQFkC9uEYdgv8mIz5SxHWu6eXqK7ZItCvQZ9+tWmLHV66K
         8q+SyKMG9BaDQw+Z2pIAhl1oWTQ1dcexIPwC12/utSoZ7WZcbF+XxM6IGkdgd2YcAveB
         nQ+B+rCzYXN4Fo41swySovy7qkpPl9yKxI13RQpiKci39TfjmxCov26dKfJalGDR0f4W
         FKIBwbmReKMqthEWSZQJ/6ZSztjzfD0uyxIV3I4PDyjWNWLTLOchDtmifGK/L2PGTPZn
         DRtg==
X-Gm-Message-State: ACgBeo1sY5WuYZ0+7bYwZn1skHZE5srUDTyM0VEFhZdSi/bFGoyO9IG+
        DICeVYzzz/rcbGp53+C5E5SD72Ez214=
X-Google-Smtp-Source: AA6agR4dy1EdqwqJMB6Jv2oeYQ5AhONsqYsknJ4MykajKxIIb+SmIArxYfejJEmY5Rpq0PRAoQgReQ==
X-Received: by 2002:a05:600c:348f:b0:3a5:e28c:a1d5 with SMTP id a15-20020a05600c348f00b003a5e28ca1d5mr2189127wmq.33.1662561479150;
        Wed, 07 Sep 2022 07:37:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8-20020adfe6c8000000b00228de58ae2bsm5055422wrm.12.2022.09.07.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:37:58 -0700 (PDT)
Message-Id: <fc45b996d34af43f8e333f7c43a8b06489a1fda2.1662561470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Sep 2022 14:37:48 +0000
Subject: [PATCH v2 5/7] rebase: factor out branch_base calculation
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

Separate out calculating the merge base between 'onto' and 'HEAD' from
the check for whether we can fast-forward or not. This means we can skip
the fast-forward checks when the rebase is forced and avoid calculating
the merge-base between 'HEAD' and 'onto' when --keep-base is given.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index dd5e0e1feb6..b5c78ce1fb0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -871,13 +871,9 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	struct commit_list *merge_bases = NULL;
 	int res = 0;
 
-	merge_bases = get_merge_bases(onto, head);
-	if (!merge_bases || merge_bases->next) {
-		oidcpy(branch_base, null_oid());
+	if (is_null_oid(branch_base))
 		goto done;
-	}
 
-	oidcpy(branch_base, &merge_bases->item->object.oid);
 	if (!oideq(branch_base, &onto->object.oid))
 		goto done;
 
@@ -887,7 +883,6 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	if (!upstream)
 		goto done;
 
-	free_commit_list(merge_bases);
 	merge_bases = get_merge_bases(upstream, head);
 	if (!merge_bases || merge_bases->next)
 		goto done;
@@ -902,6 +897,20 @@ done:
 	return res && is_linear_history(onto, head);
 }
 
+static void fill_branch_base(struct rebase_options *options,
+			    struct object_id *branch_base)
+{
+	struct commit_list *merge_bases = NULL;
+
+	merge_bases = get_merge_bases(options->onto, options->orig_head);
+	if (!merge_bases || merge_bases->next)
+		oidcpy(branch_base, null_oid());
+	else
+		oidcpy(branch_base, &merge_bases->item->object.oid);
+
+	free_commit_list(merge_bases);
+}
+
 static int parse_opt_am(const struct option *opt, const char *arg, int unset)
 {
 	struct rebase_options *opts = opt->value;
@@ -1667,8 +1676,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (!options.onto)
 			die(_("Does not point to a valid commit '%s'"),
 				options.onto_name);
+		fill_branch_base(&options, &branch_base);
 	}
-
 	if (options.fork_point > 0)
 		options.restrict_revision =
 			get_fork_point(options.upstream_name, options.orig_head);
@@ -1696,13 +1705,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * Check if we are already based on onto with linear history,
 	 * in which case we could fast-forward without replacing the commits
 	 * with new commits recreated by replaying their changes.
-	 *
-	 * Note that can_fast_forward() initializes branch_base, so we have to
-	 * call it before checking allow_preemptive_ff.
 	 */
-	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
-		    options.orig_head, &branch_base) &&
-	    allow_preemptive_ff) {
+	if (allow_preemptive_ff &&
+	    can_fast_forward(options.onto, options.upstream, options.restrict_revision,
+			     options.orig_head, &branch_base)) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
-- 
gitgitgadget

