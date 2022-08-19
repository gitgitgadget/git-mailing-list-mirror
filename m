Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8597DC25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 04:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344695AbiHSEqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 00:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbiHSEp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 00:45:59 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B475CC6CFA
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 21:45:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z16so3836737wrh.12
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 21:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=sczXWogkGlQREbLghl+N5Gpb/4as3Qa9m/wKedjGbjI=;
        b=jdjGWsi9W63U/UFZd9BhngvoF90CBnGjnR+YEW0TVOms6shIkfRJArlhKBai5XioUV
         MR3+gNdX7Tt9hKEtaL/bpLHIsVPSsl47isLzeCxWAy74bZ8Tj0cuU4I4jzNfQfmWZMSB
         ogzAxIbl/LzvOgbbsbuKKmvL3Qvgr1HXefhOUC9PAUIr+1eN5nw+v5tSFTJ8EyYfHl66
         XBLpzzLvPU1yzkJP9gidf0nygeFqgQ21BS2lStoHVKVbiGrOofIogRzCrYkBbdG8o6Qo
         xp3ol9hL6jyERKFmYqEyqCt/cRze+wKZs5PKBd+X9LMBgoofmGCTB78J+4PRRN/9lT3V
         u00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=sczXWogkGlQREbLghl+N5Gpb/4as3Qa9m/wKedjGbjI=;
        b=SkOSD1vl7dOd6F6VKhrPvIO6w48149M5Os34khU9tAsruh9sRE9yp50j5wYKpsvi02
         ch1cHR3wUob5Q30+E2VkD/TZQGiWxvOa1kAm+3XO/ZCSOslEwdVKThhJPm7N85vSA+kL
         XvUIoXPXRR11bRJVVogMfqIn4JcPrW1n6WH9wtSK3cQEuZJ1PtgqRXzFheqz1V6XvItj
         OI/AejPo6MXdd7qMK1KeHkIsV77MGmb3iAjKqQuxeVRQaisi+dji91fqKnBBZq25Cp/2
         OE+/fEtyZ9sjkiNWISQgIFVmh4JxpRiLBSsyHaCZ2MwomCEChw0p2q8CzMWSMR+4v5S3
         SzEw==
X-Gm-Message-State: ACgBeo1IKoglrwQpk/tpv8OHQb5aDyzZsgVkfweGsUUsHHZmPtPzAO3S
        eDDjHtV59NVbHwBvBZqFRyDSVgkYC8o=
X-Google-Smtp-Source: AA6agR6hunn40XBnqUxeshYL3sFJSvgBWbgdbhyP79DlnGiGA1Ywkg1Pnblzcf21tkQBbHgyy+jsBA==
X-Received: by 2002:a5d:5a0c:0:b0:220:6cd2:33fb with SMTP id bq12-20020a5d5a0c000000b002206cd233fbmr2905817wrb.560.1660884356966;
        Thu, 18 Aug 2022 21:45:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c461300b003a550be861bsm3972914wmo.27.2022.08.18.21.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 21:45:56 -0700 (PDT)
Message-Id: <pull.1302.git.git.1660884355643.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 04:45:55 +0000
Subject: [PATCH] merge-ort: remove code obsoleted by other changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 66b209b86a ("merge-ort: implement CE_SKIP_WORKTREE handling with
conflicted entries", 2021-03-20) added some code for merge-ort to handle
conflicted and skip_worktree entries in general.  Included in this was
an ugly hack for dealing with present-despite-skipped entries and a
testcase (t6428.2) specific to that hack, since at that time users could
accidentally get files into that state when using a sparse checkout.

However, with the merging of 82386b4496 ("Merge branch
'en/present-despite-skipped'", 2022-03-09), that class of problems was
addressed globally and in a much cleaner way.  As such, the
present-despite-skipped hack in merge-ort is no longer needed and can
simply be removed.

No additional testcase is needed here; t6428.2 was written to test the
necessary functionality and is being kept.  The fact that this test
continues to pass despite the code being removed shows that the extra
code is no longer necessary.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    merge-ort: remove code obsoleted by other changes

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1302%2Fnewren%2Fnuke-present-despite-skipped-hack-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1302/newren/nuke-present-despite-skipped-hack-v1
Pull-Request: https://github.com/git/git/pull/1302

 merge-ort.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8b7de0fbd8e..a6a3ab839a0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -491,7 +491,6 @@ enum conflict_and_info_types {
 	CONFLICT_FILE_DIRECTORY,
 	CONFLICT_DISTINCT_MODES,
 	CONFLICT_MODIFY_DELETE,
-	CONFLICT_PRESENT_DESPITE_SKIPPED,
 
 	/* Regular rename */
 	CONFLICT_RENAME_RENAME,   /* same file renamed differently */
@@ -536,8 +535,6 @@ static const char *type_short_descriptions[] = {
 	[CONFLICT_FILE_DIRECTORY] = "CONFLICT (file/directory)",
 	[CONFLICT_DISTINCT_MODES] = "CONFLICT (distinct modes)",
 	[CONFLICT_MODIFY_DELETE] = "CONFLICT (modify/delete)",
-	[CONFLICT_PRESENT_DESPITE_SKIPPED] =
-		"CONFLICT (upgrade your version of git)",
 
 	/*** Regular rename ***/
 	[CONFLICT_RENAME_RENAME] = "CONFLICT (rename/rename)",
@@ -748,8 +745,7 @@ static void path_msg(struct merge_options *opt,
 	/* Sanity checks */
 	assert(omittable_hint ==
 	       !starts_with(type_short_descriptions[type], "CONFLICT") ||
-	       type == CONFLICT_DIR_RENAME_SUGGESTED ||
-	       type == CONFLICT_PRESENT_DESPITE_SKIPPED);
+	       type == CONFLICT_DIR_RENAME_SUGGESTED);
 	if (opt->record_conflict_msgs_as_headers && omittable_hint)
 		return; /* Do not record mere hints in headers */
 	if (opt->priv->call_depth && opt->verbosity < 5)
@@ -4377,22 +4373,8 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 			 * the CE_SKIP_WORKTREE bit and manually write those
 			 * files to the working disk here.
 			 */
-			if (ce_skip_worktree(ce)) {
-				struct stat st;
-
-				if (!lstat(path, &st)) {
-					char *new_name = unique_path(opt,
-								     path,
-								     "cruft");
-
-					path_msg(opt, CONFLICT_PRESENT_DESPITE_SKIPPED, 1,
-						 path, NULL, NULL, NULL,
-						 _("Note: %s not up to date and in way of checking out conflicted version; old copy renamed to %s"),
-						 path, new_name);
-					errs |= rename(path, new_name);
-				}
+			if (ce_skip_worktree(ce))
 				errs |= checkout_entry(ce, &state, NULL, NULL);
-			}
 
 			/*
 			 * Mark this cache entry for removal and instead add

base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
-- 
gitgitgadget
