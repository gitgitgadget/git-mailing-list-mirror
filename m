Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB34C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 09:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiCVJTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 05:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiCVJTh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 05:19:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A997A6337
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 02:18:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so980630wme.5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 02:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b2pol7l//2hIG3aXgl/a+Yv2cXMaQ8rdcVJAnZ3WIAY=;
        b=GojP6Rw3VIsuh5w/ONcE+8PEaoHM+o5+F5jm0MyWXlIF6/WRhiHTENxaPYOqPQP0gP
         yqjXbZ08q2XfUQhYbeqKY/JhsNlWn1HBB1H9fhgL1TOBynE7XdwdcHcgs8OtVByrtOvL
         0W8/DTVyKNnw9fekwDIp6lQnsb3EEPfNBCeZFFaMdP+umqCA/gnTxqX43WNrVKpQsuTm
         Kb9RQcgLaomveau1wsxPmPH1OS9O7DD+h+KILGzlWwUtr4JV3g060EAOOd5zmX3xhVU0
         Een8Zs5Z2BLpVDqygOtVNyVctCfcs/ljVAsBaWNG4HexfD8hi8E6Y0XDCyTFJDM9Puge
         kosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b2pol7l//2hIG3aXgl/a+Yv2cXMaQ8rdcVJAnZ3WIAY=;
        b=OzNgg9wRke9P+MvWErW5UOD0x1V33gSYgzsxvZru0bkfPstQzK1cWBNkNtM+CTKMrZ
         Uf9HvZHHXcLBNCmopAbNLNAQ2pM1wLb4TRG9/4l0UpJgFEvJzkVBDn/hut2jKLaJJxvx
         rU1CmdiGkdRa7+OMdMbPR2Q56ZjzcqNNFPt94gsOD0zS+TivwVE7LgyXLNIGhWGfjrOM
         ONxo9/5KhRgFHMkHv8fE/laVfz45y9LqND9KcdtKNfugLz3P9hhsoXS6jTQ8GhtYBzlK
         HOdxtwSfVJX/zKxwpf7oS8xxuopM0j2LX6B9x/XJ5TfswOG0i/Z2O2a/2Y+rm1gHqnDa
         85WA==
X-Gm-Message-State: AOAM532r63WDGATPACaTJ5M9IJ+LseYpIhY477F/w8LImmt0k4TCPQQe
        YCjHWAlxPWcFQTD/R3XW+Xfmj97OkWo=
X-Google-Smtp-Source: ABdhPJzB/3j1AYwKlkMTm4zHFCDOImalxAqrndO4AzIRDlv4mQzysHQRR7xk2KS7eiF4oyyBknb4Ww==
X-Received: by 2002:a05:600c:3d0e:b0:38c:9b5e:52c0 with SMTP id bh14-20020a05600c3d0e00b0038c9b5e52c0mr2734044wmb.3.1647940687944;
        Tue, 22 Mar 2022 02:18:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d6d52000000b00203da94cf01sm15396927wri.14.2022.03.22.02.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 02:18:07 -0700 (PDT)
Message-Id: <pull.1183.v2.git.1647940686394.gitgitgadget@gmail.com>
In-Reply-To: <pull.1183.git.1647858238144.gitgitgadget@gmail.com>
References: <pull.1183.git.1647858238144.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 09:18:06 +0000
Subject: [PATCH v2] RFC: tracking branches: add advice to ambiguous refspec
 error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

The error "not tracking: ambiguous information for ref" is raised
when we are evaluating what tracking information to set on a branch,
and find that the ref to be added as tracking branch is mapped
under multiple remotes' fetch refspecs.

This can easily happen when a user copy-pastes a remote definition
in their git config, and forgets to change the tracking path.

Add advice in this situation, explicitly highlighting which remotes
are involved and suggesting how to correct the situation.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    RFC: tracking branches: add advice to ambiguous refspec error
    
    Second go at adding some advice around ambiguous remote refspecs,
    incorporating Ævar's suggestions.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1183%2FTaoK%2Fadvise-ambiguous-tracking-refspec-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1183/TaoK/advise-ambiguous-tracking-refspec-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1183

Range-diff vs v1:

 1:  9ec19e1c48e ! 1:  6c1cd885dda tracking branches: add advice to ambiguous refspec error
     @@ Metadata
      Author: Tao Klerks <tao@klerks.biz>
      
       ## Commit message ##
     -    tracking branches: add advice to ambiguous refspec error
     +    RFC: tracking branches: add advice to ambiguous refspec error
      
          The error "not tracking: ambiguous information for ref" is raised
          when we are evaluating what tracking information to set on a branch,
     @@ Commit message
      
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
     + ## Documentation/config/advice.txt ##
     +@@ Documentation/config/advice.txt: advice.*::
     + 		Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
     + 		is asked to update index entries outside the current sparse
     + 		checkout.
     ++	ambiguousFetchRefspec::
     ++		Advice shown when branch tracking relationship setup fails due
     ++		to multiple remotes' refspecs mapping to the same remote
     ++		tracking namespace in the repo.
     + --
     +
       ## advice.c ##
      @@ advice.c: static struct {
       	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec", 1 },
     @@ advice.h: struct string_list;
       	ADVICE_DETACHED_HEAD,
      
       ## branch.c ##
     -@@
     - struct tracking {
     - 	struct refspec_item spec;
     - 	struct string_list *srcs;
     -+	struct string_list *remotes;
     - 	const char *remote;
     +@@ branch.c: struct tracking {
       	int matches;
       };
     + 
     ++struct find_tracked_branch_cb {
     ++	struct tracking *tracking;
     ++	struct strbuf remotes_advice;
     ++};
     ++
     + static int find_tracked_branch(struct remote *remote, void *priv)
     + {
     +-	struct tracking *tracking = priv;
     ++	struct find_tracked_branch_cb *ftb = priv;
     ++	struct tracking *tracking = ftb->tracking;
     + 
     + 	if (!remote_find_tracking(remote, &tracking->spec)) {
     + 		if (++tracking->matches == 1) {
      @@ branch.c: static int find_tracked_branch(struct remote *remote, void *priv)
       			free(tracking->spec.src);
       			string_list_clear(tracking->srcs, 0);
       		}
     -+		string_list_append(tracking->remotes, remote->name);
     ++		strbuf_addf(&ftb->remotes_advice, "  %s\n", remote->name);
       		tracking->spec.src = NULL;
       	}
       
     @@ branch.c: static int inherit_tracking(struct tracking *tracking, const char *ori
      +
      +static const char ambiguous_refspec_advice_pre[] =
      +N_("\n"
     -+"There are multiple remotes with fetch refspecs mapping to\n"
     -+"the tracking ref %s:\n";)
     ++"There are multiple remotes whose fetch refspecs map to the remote\n"
     ++"tracking ref";)
      +static const char ambiguous_refspec_advice_post[] =
      +N_("This is typically a configuration error.\n"
      +"\n"
     @@ branch.c: static int inherit_tracking(struct tracking *tracking, const char *ori
        * This is called when new_ref is branched off of orig_ref, and tries
        * to infer the settings for branch.<new_ref>.{remote,merge} from the
      @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
     - {
       	struct tracking tracking;
       	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
     -+	struct string_list tracking_remotes = STRING_LIST_INIT_DUP;
       	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
     -+	struct string_list_item *item;
     ++	struct find_tracked_branch_cb ftb_cb = {
     ++		.tracking = &tracking,
     ++		.remotes_advice = STRBUF_INIT,
     ++	};
       
       	memset(&tracking, 0, sizeof(tracking));
       	tracking.spec.dst = (char *)orig_ref;
       	tracking.srcs = &tracking_srcs;
     -+	tracking.remotes = &tracking_remotes;
       	if (track != BRANCH_TRACK_INHERIT)
     - 		for_each_remote(find_tracked_branch, &tracking);
     +-		for_each_remote(find_tracked_branch, &tracking);
     ++		for_each_remote(find_tracked_branch, &ftb_cb);
       	else if (inherit_tracking(&tracking, orig_ref))
     + 		return;
     + 
      @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
       			return;
       		}
       
      -	if (tracking.matches > 1)
     +-		die(_("not tracking: ambiguous information for ref %s"),
     +-		    orig_ref);
      +	if (tracking.matches > 1) {
     -+		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC)) {
     -+			advise(_(ambiguous_refspec_advice_pre), orig_ref);
     -+			for_each_string_list_item(item, &tracking_remotes) {
     -+				advise("  %s", item->string);
     -+			}
     -+			advise(_(ambiguous_refspec_advice_post));
     -+		}
     - 		die(_("not tracking: ambiguous information for ref %s"),
     - 		    orig_ref);
     ++		int status = die_message(_("not tracking: ambiguous information for ref %s"),
     ++					    orig_ref);
     ++		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC))
     ++			advise("%s %s:\n%s\n%s",
     ++			       _(ambiguous_refspec_advice_pre),
     ++			       orig_ref,
     ++			       ftb_cb.remotes_advice.buf,
     ++			       _(ambiguous_refspec_advice_post)
     ++			       );
     ++		exit(status);
      +	}
       
       	if (tracking.srcs->nr < 1)


 Documentation/config/advice.txt |  4 ++++
 advice.c                        |  1 +
 advice.h                        |  1 +
 branch.c                        | 42 +++++++++++++++++++++++++++++----
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 063eec2511d..abfac4f664b 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -126,4 +126,8 @@ advice.*::
 		Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
 		is asked to update index entries outside the current sparse
 		checkout.
+	ambiguousFetchRefspec::
+		Advice shown when branch tracking relationship setup fails due
+		to multiple remotes' refspecs mapping to the same remote
+		tracking namespace in the repo.
 --
diff --git a/advice.c b/advice.c
index 1dfc91d1767..686612590ec 100644
--- a/advice.c
+++ b/advice.c
@@ -39,6 +39,7 @@ static struct {
 	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec", 1 },
 	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile", 1 },
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
+	[ADVICE_AMBIGUOUS_FETCH_REFSPEC]		= { "ambiguousFetchRefspec", 1 },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
diff --git a/advice.h b/advice.h
index 601265fd107..3d68c1a6cb4 100644
--- a/advice.h
+++ b/advice.h
@@ -17,6 +17,7 @@ struct string_list;
 	ADVICE_ADD_EMPTY_PATHSPEC,
 	ADVICE_ADD_IGNORED_FILE,
 	ADVICE_AM_WORK_DIR,
+	ADVICE_AMBIGUOUS_FETCH_REFSPEC,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DETACHED_HEAD,
diff --git a/branch.c b/branch.c
index 5d20a2e8484..4a3a77aa338 100644
--- a/branch.c
+++ b/branch.c
@@ -16,9 +16,15 @@ struct tracking {
 	int matches;
 };
 
+struct find_tracked_branch_cb {
+	struct tracking *tracking;
+	struct strbuf remotes_advice;
+};
+
 static int find_tracked_branch(struct remote *remote, void *priv)
 {
-	struct tracking *tracking = priv;
+	struct find_tracked_branch_cb *ftb = priv;
+	struct tracking *tracking = ftb->tracking;
 
 	if (!remote_find_tracking(remote, &tracking->spec)) {
 		if (++tracking->matches == 1) {
@@ -28,6 +34,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 			free(tracking->spec.src);
 			string_list_clear(tracking->srcs, 0);
 		}
+		strbuf_addf(&ftb->remotes_advice, "  %s\n", remote->name);
 		tracking->spec.src = NULL;
 	}
 
@@ -217,6 +224,18 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 	return 0;
 }
 
+
+static const char ambiguous_refspec_advice_pre[] =
+N_("\n"
+"There are multiple remotes whose fetch refspecs map to the remote\n"
+"tracking ref";)
+static const char ambiguous_refspec_advice_post[] =
+N_("This is typically a configuration error.\n"
+"\n"
+"To support setting up tracking branches, ensure that\n"
+"different remotes' fetch refspecs map into different\n"
+"tracking namespaces.\n");
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
@@ -228,12 +247,16 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 	struct tracking tracking;
 	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
+	struct find_tracked_branch_cb ftb_cb = {
+		.tracking = &tracking,
+		.remotes_advice = STRBUF_INIT,
+	};
 
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	tracking.srcs = &tracking_srcs;
 	if (track != BRANCH_TRACK_INHERIT)
-		for_each_remote(find_tracked_branch, &tracking);
+		for_each_remote(find_tracked_branch, &ftb_cb);
 	else if (inherit_tracking(&tracking, orig_ref))
 		return;
 
@@ -248,9 +271,18 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 			return;
 		}
 
-	if (tracking.matches > 1)
-		die(_("not tracking: ambiguous information for ref %s"),
-		    orig_ref);
+	if (tracking.matches > 1) {
+		int status = die_message(_("not tracking: ambiguous information for ref %s"),
+					    orig_ref);
+		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC))
+			advise("%s %s:\n%s\n%s",
+			       _(ambiguous_refspec_advice_pre),
+			       orig_ref,
+			       ftb_cb.remotes_advice.buf,
+			       _(ambiguous_refspec_advice_post)
+			       );
+		exit(status);
+	}
 
 	if (tracking.srcs->nr < 1)
 		string_list_append(tracking.srcs, orig_ref);

base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
-- 
gitgitgadget
