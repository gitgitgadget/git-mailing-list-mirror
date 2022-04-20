Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A73C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 09:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377397AbiDTKAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 06:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377358AbiDTJ7t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 05:59:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA5238BF0
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:57:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p189so829219wmp.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2SYDa+rcqivkvUif5+HUoX5QbBb/oga7GCGFMYTLewY=;
        b=CaHfMayYq2dPBfGKGiEazLKnx/D+e9M4YIq0gRhSd2Mp8xE3fnSIXK979ofn05Yvaf
         snczfeOUSMmtL2v2kDHlmABS8MoZuWCyoQt/nuLW8j9I2s8PSS3IEClb0hSGSoLivzo2
         IXJZQkbtiC3lA5L7Yrwcxaw11lTCm9uUmApZvoiIjcwMhVrltJkFpONGxe+MdQT6ycwL
         yYjN8/7ydYieWisX9aDxVa8/phLDpgmNl/WUl9U4Zz7nju9cIEbucqWVfDVwnqiYqY8/
         1QaK5KDHNrxHhVb6CDPrzFeOKUNNIaosvwhNAgNYw33J7OPext4zSQ4HSyDf4OZ1qicL
         LQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2SYDa+rcqivkvUif5+HUoX5QbBb/oga7GCGFMYTLewY=;
        b=UBV2uGO84DUlLmCuctcJKFOH0UFCpNR61BDCy4g6vUz5xDwh9wqANi3+D8NsFg230D
         WH3Sji3LsK/prcs4RqUhKOCGJ/mTgwXOPgKW/VF/VNVbQ/GDSAxrJNY0dqRf+jpZnn9I
         6ukXR+e6GhBCTwuMDKwKXK7bHjrAV73O1vjN8wsW9fbSwxQNg1BEr6wpbK64hIsrerQ2
         59hKLsfiN1EGjXwSW656dI/FhWoGW0Uqjb5pam/ZRlGWoaNy3iYdeJNs8cOtK7ITjB9h
         dI1wk94pLOu+SKWLdq9/+JK5jACCAHog73OqPtgDqIEBTK4Z5G+dQWg7dS8SVm8HWLzy
         SVyQ==
X-Gm-Message-State: AOAM531W83pSoSCwhKnNlYEPaqWZvlilovdwBYLvss187HSQRsLqtiMf
        N8EpA+Knk7mucMnnJxXhck8eAto1tW4=
X-Google-Smtp-Source: ABdhPJzdmbPGB8ZyyzOe94icl1FwUMCYnTIHFRimSHUeDwUe6hFEiDfHOtQMaoM42hK/liDu+gqwzw==
X-Received: by 2002:a7b:cc17:0:b0:38d:af7:3848 with SMTP id f23-20020a7bcc17000000b0038d0af73848mr2790571wmh.41.1650448621780;
        Wed, 20 Apr 2022 02:57:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9-20020adfa2c9000000b002061561d4a7sm14968085wra.96.2022.04.20.02.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:57:00 -0700 (PDT)
Message-Id: <95161f21e0004cff1bb0915aa39200b286e592e5.1650448612.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
        <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 09:56:49 +0000
Subject: [PATCH v2 6/8] rebase --apply: make reflog messages match rebase
 --merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The apply backend creates slightly different reflog messages to the
merge backend when starting and finishing a rebase and when picking
commits. The choice of backend is really an implementation detail so
it is confusing to have the same command create different messages
depending on which backend is selected. Change the apply backend so
the reflog messages from the two backends match as closely as
possible. Note that there is still a difference when committing a
conflict resolution - the merge backend will use "(continue)" rather
than "(pick)" in that case as it does not know which command created
the conflict that it is committing.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          | 9 +++++----
 t/t3406-rebase-message.sh | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e50361fc2a9..678339c7bf7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -580,10 +580,10 @@ static int move_to_original_branch(struct rebase_options *opts)
 	if (!opts->onto)
 		BUG("move_to_original_branch without onto");
 
-	strbuf_addf(&branch_reflog, "%s finished: %s onto %s",
+	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
-	strbuf_addf(&head_reflog, "%s finished: returning to %s",
+	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), opts->head_name);
 	ropts.branch = opts->head_name;
 	ropts.flags = RESET_HEAD_REFS_ONLY;
@@ -613,7 +613,8 @@ static int run_am(struct rebase_options *opts)
 
 	am.git_cmd = 1;
 	strvec_push(&am.args, "am");
-
+	strvec_pushf(&am.env_array, GIT_REFLOG_ACTION_ENVIRONMENT "=%s (pick)",
+		     getenv(GIT_REFLOG_ACTION_ENVIRONMENT));
 	if (opts->action && !strcmp("continue", opts->action)) {
 		strvec_push(&am.args, "--resolved");
 		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1763,7 +1764,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		printf(_("First, rewinding head to replay your work on top of "
 			 "it...\n"));
 
-	strbuf_addf(&msg, "%s: checkout %s",
+	strbuf_addf(&msg, "%s (start): checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	ropts.oid = &options.onto->object.oid;
 	ropts.orig_head = &options.orig_head,
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index bb2a4949abc..5c6cd9af3bc 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -88,7 +88,7 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
 write_reflog_expect () {
 	if test $mode = --apply
 	then
-		sed 's/(finish)/finished/; s/ ([^)]*)//'
+		sed 's/(continue)/(pick)/'
 	else
 		cat
 	fi >expect
-- 
gitgitgadget

