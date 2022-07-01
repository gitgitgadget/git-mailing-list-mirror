Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FBEC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 05:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiGAFXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 01:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiGAFX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 01:23:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010621CB3A
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:23:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v9so1518531wrp.7
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ysrfIK+K9nK21STm/jpYzuK4G4DzmoD98BUjPHyngU0=;
        b=aW4Yv2zailszzxP4C9++O9xG3jZxYS4zIWazUXiHWJQlvu+lTzk2ZCEjlpI9PZUlSZ
         V2oSpN7vmruR7WtXhR3BnR/2Czl7qsO9GQSZbJUS7k5MouFQijxKijyrsQfuC/9Slbws
         PX4vcPRicqvaG+J0De5x3V4LjwtGsizjE0sSjQUGBzJXCFguX5Wkef9j4nPt9xMVCqjV
         YUelKAVaCdOAbzlGddF5/qVONdi5cgGHrbt6b/RVJK93uYTCjWW1vedNFHNS35q2Sfz2
         9In2utqPtfkhzEMF49mMgjDbRdXZY+J2VSV904EbvfFkDCIbNQulUzof5HZ7T2Mj9ZPD
         wRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ysrfIK+K9nK21STm/jpYzuK4G4DzmoD98BUjPHyngU0=;
        b=bB4U067s66Zw7Zt3924/ofPMj9WXMH6CueE/Mwan5QWak9FcjmSr1o/U92OsvbfzbD
         CYwqI918zA3Y1X455pmxC9LYDURG/NhOai0aPnUYTXZXFXMhGpXJEGhPgkHEP1NXQ3MM
         ReGycIsZZHIGh2tFIb1WYFopPpvWsdyegFsSF0APSx581lrrdZP/fEInsVc3RWJyFHC9
         MoHBI5g14cR7VofrjyZr50zjsmqM9Gd8zKYDmF/AOLYlUUO/z73qoEGqXVLRquSfoVX1
         vbulUDs5UfZY9PgziOm/a2KgGxaoHqkEK3Fsto/x5nVQA+ZqXtWJL50WHLE8sYFotYQk
         bJVg==
X-Gm-Message-State: AJIora+aN+O+72Ker6/iV2JNX+yoVX3M4UijNLIKd2HDRNcgZ1mTQZ/l
        aSQTwusGQnCjEJSiUVHfuhTfEQAVx+4=
X-Google-Smtp-Source: AGRyM1tMnnm5v5ojpep+ikdSL57E/K6At9yCcQoSQf1P/vY/EsAAwB3z2ttiPq+lTC4Q43BtBQBV1Q==
X-Received: by 2002:a5d:410a:0:b0:21b:9549:e151 with SMTP id l10-20020a5d410a000000b0021b9549e151mr11411107wrp.702.1656653004270;
        Thu, 30 Jun 2022 22:23:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003a04b0bcb43sm8820992wmi.40.2022.06.30.22.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 22:23:23 -0700 (PDT)
Message-Id: <297fef60b19b28a24c449eb42948e0e9138cfdaa.1656653000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
References: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
        <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jul 2022 05:23:17 +0000
Subject: [PATCH v3 2/5] merge-ort: small cleanups of
 check_for_directory_rename
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@palantir.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@palantir.com>

No functional changes, just some preparatory cleanups.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@palantir.com>
---
 merge-ort.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8545354dafd..ff037cca8d2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2267,18 +2267,17 @@ static char *check_for_directory_rename(struct merge_options *opt,
 					struct strmap *collisions,
 					int *clean_merge)
 {
-	char *new_path = NULL;
+	char *new_path;
 	struct strmap_entry *rename_info;
-	struct strmap_entry *otherinfo = NULL;
+	struct strmap_entry *otherinfo;
 	const char *new_dir;
 
+	/* Cases where we don't have a directory rename for this path */
 	if (strmap_empty(dir_renames))
-		return new_path;
+		return NULL;
 	rename_info = check_dir_renamed(path, dir_renames);
 	if (!rename_info)
-		return new_path;
-	/* old_dir = rename_info->key; */
-	new_dir = rename_info->value;
+		return NULL;
 
 	/*
 	 * This next part is a little weird.  We do not want to do an
@@ -2304,6 +2303,7 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	 * As it turns out, this also prevents N-way transient rename
 	 * confusion; See testcases 9c and 9d of t6043.
 	 */
+	new_dir = rename_info->value; /* old_dir = rename_info->key; */
 	otherinfo = strmap_get_entry(dir_rename_exclusions, new_dir);
 	if (otherinfo) {
 		path_msg(opt, rename_info->key, 1,
-- 
gitgitgadget

