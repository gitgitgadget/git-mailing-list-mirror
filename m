Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2995C4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiJUJWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJUJWH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:22:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1C425590A
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:21:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e18so1772441wmq.3
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUqPYjlgyRZ2KRHIh7Lay3mIu1RDwi4TVB0J1FOnfnQ=;
        b=g5DYe+EqxuWQ48kRWMTkkcfAdautx1aReUmUfiTNSH7FhARpI2f7LS+qdRXfs1DAoB
         J4tNHcJJvg3SapLMvuzkPpqW7h6xgor8AuBsP94R81c/dCWuoP4Do54vKS21wH1OL3aS
         qxevPPVtvtNYFQhcmETVptjUxUnkC/+BUtPvgcbWOsLwGhRqdYgnHdCy92s/PvaAAzJs
         WSX6XGAycQ/ti6+BIvVzhHpGGxM/2SbqbIWIShzRjSoIBqv1kMr1TsIFLeiT2cWhOyMo
         Q01WjlCnl3R5oMtQq/dv53pCxmhUI36Hj6u0rFUGc25ppeg0BzSyrBDIkBxJ98E8yxVa
         tWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUqPYjlgyRZ2KRHIh7Lay3mIu1RDwi4TVB0J1FOnfnQ=;
        b=icQsvp7AvFdvyUF6JM90DvUeW4BV+F8/ssXYA/kFFR3lli0xSIq/O8Zpgwa4T4S0pO
         ifgHAGP5OhEMkQcC8mIqb5a6r5YNnZlgei6ugyt0bHLcP/jMsMyb/BCPSfFs7R7bXP8H
         /xikBzx3oM2EFviowWqhdX47RCH7Kr+WKRXWoEdi/A4p2j/tuTsXQXmOkU58frCpBntz
         xN2JZoYUarLAden/KLFTfSp17pOSWlG6nkXuz4Q1WGsSA9sDFH/Yu1mnWY54/9MSaYD2
         mlQzEbkgXEideTa/JbdVeD+Vmo7JqzCQPIydod+BbV897T6vXUhsuh4GmpBinPRsebJo
         +XBw==
X-Gm-Message-State: ACrzQf32B7e19g/3MzlV6BadixYPB4Q6ZgeJ6Oyc2+PJJyE59yq+jtq4
        uWvhhrmHP1Kt3aY7bx4IE3LqLgkWAQE=
X-Google-Smtp-Source: AMsMyM4e4Bsj45gQIKo25p0YvcSYFXk93jW61rIE9FypfJd7DNvUwosNiW8tNWOgtG9DEndD2oGisQ==
X-Received: by 2002:a05:600c:3512:b0:3c8:2c4e:8680 with SMTP id h18-20020a05600c351200b003c82c4e8680mr970855wmq.165.1666344117431;
        Fri, 21 Oct 2022 02:21:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d488b000000b0022eafed36ebsm18470474wrq.73.2022.10.21.02.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:21:56 -0700 (PDT)
Message-Id: <3f6b2e39f4091e891f3ab83da7944a0c497ec300.1666344108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 09:21:46 +0000
Subject: [PATCH v4 6/8] rebase --apply: make reflog messages match rebase
 --merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The apply backend creates slightly different reflog messages to the
merge backend when starting or finishing a rebase and when picking
commits. These differences make it harder than it needs to be to parse
the reflog (I have a script that reads the finishing messages from
rebase and it is a pain to have to accommodate two different message
formats). While it is possible to determine the backend used for a
rebase from the reflog messages, the differences are not designed for
that purpose. c2417d3af7 (rebase: drop '-i' from the reflog for
interactive-based rebases, 2020-02-15) removed the clear distinction
between the reflog messages of the two backends without complaint.

As the merge backend is the default it is likely to be the format most
common in existing reflogs. For that reason the apply backend is changed
to format its reflog messages to match the merge backend as closely as
possible. Note that there is still a difference as when committing a
conflict resolution the apply backend will use "(pick)" rather than
"(continue)" because it is not currently possible to change the message
for a single commit.

In addition to c2417d3af7 we also changed the reflog messages in
68aa495b59 (rebase: implement --merge via the interactive machinery,
2018-12-11) and 2ac0d6273f (rebase: change the default backend from "am"
to "merge", 2020-02-15). This commit makes the same change to "git
rebase --apply" that 2ac0d6273f made to "git rebase" without any backend
specific options. As the messages are changed to use an existing format
any scripts that can parse the reflog messages of the default rebase
backend should be unaffected by this change.

There are existing tests for the messages from both backends which are
adjusted to ensure that they do not get out of sync in the future.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          | 9 +++++----
 t/t3406-rebase-message.sh | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index ea246c6bb3a..5253ba66861 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -582,10 +582,10 @@ static int move_to_original_branch(struct rebase_options *opts)
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
@@ -615,7 +615,8 @@ static int run_am(struct rebase_options *opts)
 
 	am.git_cmd = 1;
 	strvec_push(&am.args, "am");
-
+	strvec_pushf(&am.env, GIT_REFLOG_ACTION_ENVIRONMENT "=%s (pick)",
+		     getenv(GIT_REFLOG_ACTION_ENVIRONMENT));
 	if (opts->action && !strcmp("continue", opts->action)) {
 		strvec_push(&am.args, "--resolved");
 		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1792,7 +1793,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		printf(_("First, rewinding head to replay your work on top of "
 			 "it...\n"));
 
-	strbuf_addf(&msg, "%s: checkout %s",
+	strbuf_addf(&msg, "%s (start): checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	ropts.oid = &options.onto->object.oid;
 	ropts.orig_head = &options.orig_head->object.oid,
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

