Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CDEC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 15:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiHOPLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiHOPLa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 11:11:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BA51CB1A
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:11:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso4046918wmb.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=O3IhWz1TTOveOMKTPthuFBz/G5/QPbB/RzNIjdz2Jsk=;
        b=V/KwWJkCsGBAjEG/Gc72AgAO3+h6u8jw+6TenP41+xaN0LjhBp+/FOC+QarEK8Ioi3
         GGojKnQYb9mOBdxX73KTRD7T1EnWCzft36k4V5dqymSmwZkTKa6SIjwFzEVtvDWN6dQu
         8fbodYTkDbhA/hoDwt+rOh2z1lXVHfAQ6VfZfWia44XoofOnq6NIW1SVDO6pFvr/oucS
         9kf+cUph5yeqToGabEdCGR5+WxfzkYkV64qkS74ar1xCSQ36uQjhv1QWwFWjHh3jDkgr
         yXHKBkcDnC2MlAnnhtCCkwYVUdyOILHWBgCUph0CC+9kfgIruqEkyY4nfBs0VU0ZvKVt
         kMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=O3IhWz1TTOveOMKTPthuFBz/G5/QPbB/RzNIjdz2Jsk=;
        b=q1s2FO3oClGWOd/tkDRoLOBX1xbTYB6knN0HFxUVepiKsp0kSox21/oOBChm28ai8a
         bXCLFRNBmRQ1GqsECCefJrK5kt3bubArZQSOS2L7MwCw5qj4VRGwH4CsJRfow9dmJ+p+
         7M/YT/izSWPvKVb2QkEAsWZi+BLuvhWVLu2zOBfe2ct8hHf1pzmeddaSrvd90o19Iv14
         crcGkPq+H8D+gxCGTpHGkKekUvdDUfoOZ6rcxlopn6vbeGNoCmaM/HWtykEnZn6dh0vf
         JX+qk3PYO2q8loK3uG7Y24IlvIQvz2KLwYyP1Rsu+dePqyZX52m18lBfWKJf1DG+oxvw
         hoQw==
X-Gm-Message-State: ACgBeo0wlhl62XKfqd7DFlKmJUDD+KWaN9/HshVddM28xcvsV6Ky8rvB
        e5d/ICRsjmy4RWf83w1rmiEbVgak9+E=
X-Google-Smtp-Source: AA6agR6y66u0LyxGiX+z3T5qxr+7V5x27dJ7Z4EvtacW+5stPUzyCkwZSMPbh4vYVdGlTp65FnawIg==
X-Received: by 2002:a05:600c:a03:b0:39e:4f0c:938c with SMTP id z3-20020a05600c0a0300b0039e4f0c938cmr10431722wmp.145.1660576288210;
        Mon, 15 Aug 2022 08:11:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6-20020a05600c4e0600b003a5f4fccd4asm4310067wmq.35.2022.08.15.08.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:11:27 -0700 (PDT)
Message-Id: <019158db9d2dbb371705ba79a96a907e4a17cdb1.1660576283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 15:11:21 +0000
Subject: [PATCH 3/5] rebase: factor out merge_base calculation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Separate out calculating the merge base between onto and head from the
check for whether we can fast-forward or not. This means we can skip
the fast-forward checks when the rebase is forced and avoid
calculating the merge-base twice when --keep-base is given.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
Note the unnecessary braces around "if (keep_base)" are added here
reduce the churn on the next commit.
---
 builtin/rebase.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6cf9c95f4e1..86ea731ca3a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -871,13 +871,9 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	struct commit_list *merge_bases = NULL;
 	int res = 0;
 
-	merge_bases = get_merge_bases(onto, head);
-	if (!merge_bases || merge_bases->next) {
-		oidcpy(merge_base, null_oid());
+	if (is_null_oid(merge_base))
 		goto done;
-	}
 
-	oidcpy(merge_base, &merge_bases->item->object.oid);
 	if (!oideq(merge_base, &onto->object.oid))
 		goto done;
 
@@ -902,6 +898,20 @@ done:
 	return res && is_linear_history(onto, head);
 }
 
+static void fill_merge_base(struct rebase_options *options,
+			    struct object_id *merge_base)
+{
+	struct commit_list *merge_bases = NULL;
+
+	merge_bases = get_merge_bases(options->onto, options->orig_head);
+	if (!merge_bases || merge_bases->next)
+		oidcpy(merge_base, null_oid());
+	else
+		oidcpy(merge_base, &merge_bases->item->object.oid);
+
+	free_commit_list(merge_bases);
+}
+
 static int parse_opt_am(const struct option *opt, const char *arg, int unset)
 {
 	struct rebase_options *opts = opt->value;
@@ -1668,7 +1678,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("Does not point to a valid commit '%s'"),
 				options.onto_name);
 	}
-
+	if (keep_base) {
+		oidcpy(&merge_base, &options.onto->object.oid);
+	} else {
+		fill_merge_base(&options, &merge_base);
+	}
 	if (options.fork_point > 0)
 		options.restrict_revision =
 			get_fork_point(options.upstream_name, options.orig_head);
@@ -1697,13 +1711,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * Check if we are already based on onto with linear history,
 	 * in which case we could fast-forward without replacing the commits
 	 * with new commits recreated by replaying their changes.
-	 *
-	 * Note that can_fast_forward() initializes merge_base, so we have to
-	 * call it before checking allow_preemptive_ff.
 	 */
-	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
-		    options.orig_head, &merge_base) &&
-	    allow_preemptive_ff) {
+	if (allow_preemptive_ff &&
+	    can_fast_forward(options.onto, options.upstream, options.restrict_revision,
+			     options.orig_head, &merge_base)) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
-- 
gitgitgadget

