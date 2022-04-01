Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD5FC433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 06:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245280AbiDAGHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 02:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiDAGHH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 02:07:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FF24EA1C
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 23:05:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i132-20020a1c3b8a000000b0038ce25c870dso2870451wma.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 23:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NO7Y2dx8/KhpvGUEjBGH4xdGvS1hCVYSkql+2iB+O5s=;
        b=NsQQNGnPiL6VboIhIodjK1muyKdTh6rWiJnVa5pLu4PpivanuTXTpwbq2awXlaWvso
         bl+3CQAeDqIlem2TTLkW2q1L6vKUO/IBcczrOwKPngQpEl5Qk2p5ZYQyUCGiu5qxm1pc
         D0hRLNi5DsNvHYNv2TBSfDFvG6MwRfSFcS17HulF8UQtqHxjR/xoqkdrCca0Em6ybLA+
         4++6WirlZVSWMlrPJ3EII+ki0CFZ/1g6oSWhWU02NOHkjoLfvUsd8k9adE80fpSLJsuk
         9ej3PF6e/wBekoCSIofNLlAYWQY5R0AsawMka56fAj2SSGdUm1hAuIzMYDjWFKE2YKMD
         J13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NO7Y2dx8/KhpvGUEjBGH4xdGvS1hCVYSkql+2iB+O5s=;
        b=0edtvbAdXWfBu4GeJL6tLj/KE1xorOzXEMeQzzV35x0i+6JfOCw1hDMoynYrwTwtB9
         LciI+SdqpLXRPIt0gXiLAuXKLvKLc9jiNyZzL+Di8xshm3j7lk1VmqgYUhKFqptpTQ+T
         DZGTCkoqnWWus5RIjRqlyOa9mBEBqtcjU2FJSEiimxU/yE9QKvNhAv/PFJoqBPL9BEDY
         xIoNxDG0zfWpBubk5s+MtJQ0WXoQEcz1ZbTnSXlu919MqNSI4d9MXsRP5IYLtXz9A+xS
         i9lTiWOem5JHwEJrleOYQ2axDfWeEdt1E+R7gXN5ZYYmtbI5OUt3RTxR25+zaTReYL2g
         cZww==
X-Gm-Message-State: AOAM531yTuK38HKE1USdjVSP8rB9uAE4Fg4VNjax9Ti4QkYB5bx7lEZA
        3M4/q0kwGRLWBkhPbVUIBdmSC2HAgvk=
X-Google-Smtp-Source: ABdhPJx6xBbWcsFUdwyRDqpoFlKfK1bxxjPcB2/Eq6r9Jx6Exdwt8GHEKp0KxGC2dk26pZiAfM3V2g==
X-Received: by 2002:a05:600c:2206:b0:38c:9529:3e9 with SMTP id z6-20020a05600c220600b0038c952903e9mr7277842wml.46.1648793115333;
        Thu, 31 Mar 2022 23:05:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b0038ce140fec1sm971870wms.16.2022.03.31.23.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 23:05:14 -0700 (PDT)
Message-Id: <pull.1183.v7.git.1648793113943.gitgitgadget@gmail.com>
In-Reply-To: <pull.1183.v6.git.1648742485887.gitgitgadget@gmail.com>
References: <pull.1183.v6.git.1648742485887.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Apr 2022 06:05:13 +0000
Subject: [PATCH v7] tracking branches: add advice to ambiguous refspec error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Tao Klerks <tao@klerks.biz>,
        Glen Choo <chooglen@google.com>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>
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
are involved and suggesting how to correct the situation. Also
update a test to explicitly expect that advice.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    tracking branches: add advice to ambiguous refspec error
    
    In v7 address a wrong-value-printed bug that Junio and Glen noticed, and
    add testing for the emitted advice.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1183%2FTaoK%2Fadvise-ambiguous-tracking-refspec-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1183/TaoK/advise-ambiguous-tracking-refspec-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1183

Range-diff vs v6:

 1:  2408ab0ccb3 ! 1:  4fc5d2b6d13 tracking branches: add advice to ambiguous refspec error
     @@ Commit message
          in their git config, and forgets to change the tracking path.
      
          Add advice in this situation, explicitly highlighting which remotes
     -    are involved and suggesting how to correct the situation.
     +    are involved and suggesting how to correct the situation. Also
     +    update a test to explicitly expect that advice.
      
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
     @@ branch.c: struct tracking {
      +			break;
      +		case 2:
      +			/* there are at least two remotes; backfill the first one */
     -+			string_list_append(&ftb->ambiguous_remotes, tracking->spec.src);
     ++			string_list_append(&ftb->ambiguous_remotes, tracking->remote);
      +			/* fall through */
      +		default:
      +			string_list_append(&ftb->ambiguous_remotes, remote->name);
     @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
       }
       
       int read_branch_desc(struct strbuf *buf, const char *branch_name)
     +
     + ## t/t3200-branch.sh ##
     +@@ t/t3200-branch.sh: test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates
     + 	git rev-parse --verify gamma@{0}
     + '
     + 
     +-test_expect_success 'avoid ambiguous track' '
     ++test_expect_success 'avoid ambiguous track and advise' '
     + 	git config branch.autosetupmerge true &&
     + 	git config remote.ambi1.url lalala &&
     + 	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/main &&
     + 	git config remote.ambi2.url lilili &&
     + 	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/main &&
     +-	test_must_fail git branch all1 main &&
     ++	cat <<-EOF >expected &&
     ++	fatal: not tracking: ambiguous information for ref '\''refs/heads/main'\''
     ++	hint: There are multiple remotes whose fetch refspecs map to the remote
     ++	hint: tracking ref '\''refs/heads/main'\'':
     ++	hint:   ambi1
     ++	hint:   ambi2
     ++	hint: ''
     ++	hint: This is typically a configuration error.
     ++	hint: ''
     ++	hint: To support setting up tracking branches, ensure that
     ++	hint: different remotes'\'' fetch refspecs map into different
     ++	hint: tracking namespaces.
     ++	EOF
     ++	test_must_fail git branch all1 main 2>actual &&
     ++	test_cmp expected actual &&
     + 	test -z "$(git config branch.all1.merge)"
     + '
     + 


 Documentation/config/advice.txt |  4 +++
 advice.c                        |  1 +
 advice.h                        |  1 +
 branch.c                        | 63 +++++++++++++++++++++++++++++----
 t/t3200-branch.sh               | 18 ++++++++--
 5 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c40eb09cb7e..343d271c707 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -4,6 +4,10 @@ advice.*::
 	can tell Git that you do not need help by setting these to 'false':
 +
 --
+	ambiguousFetchRefspec::
+		Advice shown when fetch refspec for multiple remotes map to
+		the same remote-tracking branch namespace and causes branch
+		tracking set-up to fail.
 	fetchShowForcedUpdates::
 		Advice shown when linkgit:git-fetch[1] takes a long time
 		to calculate forced updates after ref updates, or to warn
diff --git a/advice.c b/advice.c
index 2e1fd483040..18ac8739519 100644
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
index a3957123a16..2d4c94f38eb 100644
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
index 6b31df539a5..182f1c5a556 100644
--- a/branch.c
+++ b/branch.c
@@ -18,17 +18,31 @@ struct tracking {
 	int matches;
 };
 
+struct find_tracked_branch_cb {
+	struct tracking *tracking;
+	struct string_list ambiguous_remotes;
+};
+
 static int find_tracked_branch(struct remote *remote, void *priv)
 {
-	struct tracking *tracking = priv;
+	struct find_tracked_branch_cb *ftb = priv;
+	struct tracking *tracking = ftb->tracking;
 
 	if (!remote_find_tracking(remote, &tracking->spec)) {
-		if (++tracking->matches == 1) {
+		switch (++tracking->matches) {
+		case 1:
 			string_list_append(tracking->srcs, tracking->spec.src);
 			tracking->remote = remote->name;
-		} else {
+			break;
+		case 2:
+			/* there are at least two remotes; backfill the first one */
+			string_list_append(&ftb->ambiguous_remotes, tracking->remote);
+			/* fall through */
+		default:
+			string_list_append(&ftb->ambiguous_remotes, remote->name);
 			free(tracking->spec.src);
 			string_list_clear(tracking->srcs, 0);
+		break;
 		}
 		tracking->spec.src = NULL;
 	}
@@ -232,12 +246,16 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 	struct tracking tracking;
 	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
+	struct find_tracked_branch_cb ftb_cb = {
+		.tracking = &tracking,
+		.ambiguous_remotes = STRING_LIST_INIT_DUP,
+	};
 
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	tracking.srcs = &tracking_srcs;
 	if (track != BRANCH_TRACK_INHERIT)
-		for_each_remote(find_tracked_branch, &tracking);
+		for_each_remote(find_tracked_branch, &ftb_cb);
 	else if (inherit_tracking(&tracking, orig_ref))
 		goto cleanup;
 
@@ -252,9 +270,39 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 			goto cleanup;
 		}
 
-	if (tracking.matches > 1)
-		die(_("not tracking: ambiguous information for ref %s"),
-		    orig_ref);
+	if (tracking.matches > 1) {
+		int status = die_message(_("not tracking: ambiguous information for ref '%s'"),
+					    orig_ref);
+		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC)) {
+			struct strbuf remotes_advice = STRBUF_INIT;
+			struct string_list_item *item;
+
+			for_each_string_list_item(item, &ftb_cb.ambiguous_remotes)
+				/*
+				 * TRANSLATORS: This is a line listing a remote with duplicate
+				 * refspecs in the advice message below. For RTL languages you'll
+				 * probably want to swap the "%s" and leading "  " space around.
+				 */
+				strbuf_addf(&remotes_advice, _("  %s\n"), item->string);
+
+			/*
+			 * TRANSLATORS: The second argument is a \n-delimited list of
+			 * duplicate refspecs, composed above.
+			 */
+			advise(_("There are multiple remotes whose fetch refspecs map to the remote\n"
+				 "tracking ref '%s':\n"
+				 "%s"
+				 "\n"
+				 "This is typically a configuration error.\n"
+				 "\n"
+				 "To support setting up tracking branches, ensure that\n"
+				 "different remotes' fetch refspecs map into different\n"
+				 "tracking namespaces."), orig_ref,
+			       remotes_advice.buf);
+			strbuf_release(&remotes_advice);
+		}
+		exit(status);
+	}
 
 	if (tracking.srcs->nr < 1)
 		string_list_append(tracking.srcs, orig_ref);
@@ -264,6 +312,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 
 cleanup:
 	string_list_clear(&tracking_srcs, 0);
+	string_list_clear(&ftb_cb.ambiguous_remotes, 0);
 }
 
 int read_branch_desc(struct strbuf *buf, const char *branch_name)
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7a0ff75ba86..e12db593615 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1039,13 +1039,27 @@ test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates
 	git rev-parse --verify gamma@{0}
 '
 
-test_expect_success 'avoid ambiguous track' '
+test_expect_success 'avoid ambiguous track and advise' '
 	git config branch.autosetupmerge true &&
 	git config remote.ambi1.url lalala &&
 	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/main &&
 	git config remote.ambi2.url lilili &&
 	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/main &&
-	test_must_fail git branch all1 main &&
+	cat <<-EOF >expected &&
+	fatal: not tracking: ambiguous information for ref '\''refs/heads/main'\''
+	hint: There are multiple remotes whose fetch refspecs map to the remote
+	hint: tracking ref '\''refs/heads/main'\'':
+	hint:   ambi1
+	hint:   ambi2
+	hint: ''
+	hint: This is typically a configuration error.
+	hint: ''
+	hint: To support setting up tracking branches, ensure that
+	hint: different remotes'\'' fetch refspecs map into different
+	hint: tracking namespaces.
+	EOF
+	test_must_fail git branch all1 main 2>actual &&
+	test_cmp expected actual &&
 	test -z "$(git config branch.all1.merge)"
 '
 

base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b
-- 
gitgitgadget
