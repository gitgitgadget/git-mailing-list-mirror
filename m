Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F52C433FE
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 00:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbiBVASj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:18:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbiBVASc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 19:18:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F8A2558A
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:06 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d3so14115703wrf.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M3yfAW+FMygRnAbUO3SWrYQH55uT4SNwhA5DqD8nFTc=;
        b=n4YOTMiULxqGKriUJ57mKToZ+T2MHBPAAEZDNjcFosD8shmqn/QwEZ75SMtckHfXZ/
         915PuyzaS3tNmDH4zd+BJWljcpDI/jP9m/Gi6SjnKTkovJyWsEMElhh9178N7sVIMRrV
         tpxaMBy/yaKypIQ/7IsD/X3G/jdu/VQBbXpS5mNk+VglD8lLwYUoZUUlcnU4QAp4Hr2w
         iaf0i1mB43CRSctLoy4Uk2UE+x8RFsdjIgyO8zhOfZMSaFejd+RILcekaYQORodRgviP
         IUhliCCbbxgrDsMel6JenI1zm5DGYL+g4oVBGViR+0vde1hiuKNlo2q3gdCH7BYoh0LH
         Ij7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M3yfAW+FMygRnAbUO3SWrYQH55uT4SNwhA5DqD8nFTc=;
        b=K79h8IX2AXHD8XfryPtgA1N6jHg++9TrCIuM7nsiGnA3PTQVA/yEEWQdYqG+yass0a
         ikZRa+EkW1Y7lOkwalmkqgd8VcYi3giF2zx9CaZFhllN1wr92S64EnrJE1yvcGGncHWr
         ZaoKvJGFTV8NghpcMTVgjuceIp+uPLuMtc7nPbyZ9tqOjSITD4VH/lz72JDddwoO5x9I
         DErKj/aB+aU+eAOtsVJk7oXfRcA4uwaAv4P3+AMM6yXyfHLKYAleFUDGHEPD37Ir05gd
         XyaIH2nqlhq42VVHQsh+TipQ7ZWR5ZU3CvVdUngejq2yS5/HORBW54nvbudoosRj+lzM
         odFQ==
X-Gm-Message-State: AOAM530xc8wFzImW3Vmks5MC4z/IXDCVP4n9jc2inW1Gg3JJphYQoqR3
        yz6sEevNRrxwmk3A8Sa4k13/ahh1jTQ=
X-Google-Smtp-Source: ABdhPJzMM1ZvEqXuyMnV6CH9hvqb75x0qL1zbjofv937EYnIBfcmKfQEmCj3AfFsh1uJhtSFPOFXRw==
X-Received: by 2002:a5d:4c41:0:b0:1e5:1a70:fb86 with SMTP id n1-20020a5d4c41000000b001e51a70fb86mr17187564wrt.452.1645489084522;
        Mon, 21 Feb 2022 16:18:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm915684wmp.13.2022.02.21.16.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 16:18:04 -0800 (PST)
Message-Id: <ccc5b1ef9fb4dbeedfbc1ad8f0da36299bf48b56.1645489080.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 00:17:52 +0000
Subject: [PATCH v2 03/11] worktree: extract copy_sparse_checkout()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This logic was introduced by 5325591 (worktree: copy sparse-checkout
patterns and config on add, 2022-02-07), but some feedback came in that
the add_worktree() method was already too complex. It is better to
extract this logic into a helper method to reduce this complexity.

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/worktree.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2771a6dc793..c806aa2b261 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -236,6 +236,22 @@ static void check_candidate_path(const char *path,
 		die(_("'%s' is a missing but already registered worktree;\nuse '%s -f' to override, or 'prune' or 'remove' to clear"), path, cmd);
 }
 
+static void copy_sparse_checkout(const char *worktree_git_dir)
+{
+	char *from_file = git_pathdup("info/sparse-checkout");
+	char *to_file = xstrfmt("%s/info/sparse-checkout", worktree_git_dir);
+
+	if (file_exists(from_file)) {
+		if (safe_create_leading_directories(to_file) ||
+			copy_file(to_file, from_file, 0666))
+			error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
+				from_file, to_file);
+	}
+
+	free(from_file);
+	free(to_file);
+}
+
 static void copy_filtered_worktree_config(const char *worktree_git_dir)
 {
 	char *from_file = git_pathdup("config.worktree");
@@ -379,21 +395,8 @@ static int add_worktree(const char *path, const char *refname,
 	 * If the current worktree has sparse-checkout enabled, then copy
 	 * the sparse-checkout patterns from the current worktree.
 	 */
-	if (core_apply_sparse_checkout) {
-		char *from_file = git_pathdup("info/sparse-checkout");
-		char *to_file = xstrfmt("%s/info/sparse-checkout",
-					sb_repo.buf);
-
-		if (file_exists(from_file)) {
-			if (safe_create_leading_directories(to_file) ||
-			    copy_file(to_file, from_file, 0666))
-				error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
-				      from_file, to_file);
-		}
-
-		free(from_file);
-		free(to_file);
-	}
+	if (core_apply_sparse_checkout)
+		copy_sparse_checkout(sb_repo.buf);
 
 	/*
 	 * If we are using worktree config, then copy all current config
-- 
gitgitgadget

