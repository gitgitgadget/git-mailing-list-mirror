Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D868DC433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 13:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiCRNzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiCRNz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 09:55:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B87019235B
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 06:54:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q8so490497wrc.0
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WxB3SXx7HN1GEVwPjpmMqwSm8iGOaSqzbUJA7cUKGsA=;
        b=T+uIGyRqo5Nfz20ov+EbrN0+/JvZchnVlPTnjxj/rKMMue7RsixW85gz5jdkZTonzp
         jX8TUN0dkxzo2xRrqC+37RVf6ob8ebt3selhHkSR5fxF5OPrClLEEcNl3CWwNmaRlEwH
         dPQuujMNGrIKX8mqoRyqIu84RseM0EjCJMvWXlWj+24WXvI85zWRNG503SyFNgzgaHD4
         O2K0YufOWaMvfhM2ZUISnINuvtA/3m7j3DcV29gM3mRtedQXpspNZj3jEtY9XIqj/Tml
         kJBEe2lQpl2qDlFFceYLfuHi7A2if5a4kO9KVO0H5ACRMh8acfUFKFwqP4BzE10m8RuL
         kSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WxB3SXx7HN1GEVwPjpmMqwSm8iGOaSqzbUJA7cUKGsA=;
        b=gK0DQ7PKcac0jN4XsnMq6o6mZ7proGcVYT4NJK3XIKp/IEtOLLhqdCBx8rHQuH/R3O
         HdAHmytP4czz30tR+D6bo6fbF89ceOWFG/ytC7pS7AAdcTf5DxFJKudZ2MS2cHWGaRGs
         yX6654U69rwqGZ50c1hwggXLtrCJE2Bxw4hPsYu3Ue2MjM1vzIyo2GFx0Lr/9g4gZ3qE
         GPR8rJTy8B8TEGnzyZ8e7cUrLUxbTkOrv4EGgzGcdDJZ9YCgfrXubbUL9rUjpXNHd58o
         VDnfh/1fVZNWnS0btQCYUJ9PiE0PZNInDn6ho0KOQinCSrQuT4WinMOB5gp5IPOiYlkh
         kyrQ==
X-Gm-Message-State: AOAM531LO4NwILVY4DgzYDhw12kcErxlFpV/xccjI31/s4cqJxeHQEsO
        aU7IAylZw4mM23QFGT4luxHqZOFkFo8=
X-Google-Smtp-Source: ABdhPJzBTy40Nng2VyZfBb5kZ+HYGNwvXIzoEFWQr29HCgVLIGNR5nRYsGdfrnKZI54Hj6pAzW03JA==
X-Received: by 2002:a05:6000:156e:b0:203:d6e6:bcd0 with SMTP id 14-20020a056000156e00b00203d6e6bcd0mr8059868wrz.135.1647611646061;
        Fri, 18 Mar 2022 06:54:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm2272040wrq.44.2022.03.18.06.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 06:54:05 -0700 (PDT)
Message-Id: <1dd5bb210124480132a78e5ac64384713d734299.1647611643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v5.git.git.1647611643.gitgitgadget@gmail.com>
References: <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
        <pull.1226.v5.git.git.1647611643.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Mar 2022 13:54:03 +0000
Subject: [PATCH v5 2/2] rebase: set REF_HEAD_DETACH in checkout_up_to_date()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Michael McClimon <michael@mcclimon.org>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

"git rebase A B" where B is not a commit should behave as if the
HEAD got detached at B and then the detached HEAD got rebased on top
of A.  A bug however overwrites the current branch to point at B,
when B is a descendant of A (i.e. the rebase ends up being a
fast-forward).  See [1] for the original bug report.

The callstack from checkout_up_to_date() is the following:

cmd_rebase()
-> checkout_up_to_date()
   -> reset_head()
      -> update_refs()
         -> update_ref()

When B is not a valid branch but an oid, rebase sets the head_name
of rebase_options to NULL. This value gets passed down this call
chain through the branch member of reset_head_opts also getting set
to NULL all the way to update_refs().

Then update_refs() checks ropts.branch to decide whether or not to switch
branches. If ropts.branch is NULL, it calls update_ref() to update HEAD.
At this point however, from rebase's point of view, we want a detached
HEAD. But, since checkout_up_to_date() does not set the RESET_HEAD_DETACH
flag, the update_ref() call will deference HEAD and update the branch its
pointing to. We want the HEAD detached at B instead.

Fix this bug by adding the RESET_HEAD_DETACH flag in
checkout_up_to_date if B is not a valid branch, so that once
reset_head() calls update_refs(), it calls update_ref() with
REF_NO_DEREF which updates HEAD directly intead of deferencing it
and updating the branch that HEAD points to.

Also add a test to ensure the correct behavior.

[1] https://lore.kernel.org/git/YiokTm3GxIZQQUow@newk/

Reported-by: Michael McClimon <michael@mcclimon.org>
Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rebase.c  | 2 ++
 t/t3400-rebase.sh | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b29ad2b65e7..27fde7bf281 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -829,6 +829,8 @@ static int checkout_up_to_date(struct rebase_options *options)
 	ropts.oid = &options->orig_head;
 	ropts.branch = options->head_name;
 	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	if (!ropts.branch)
+		ropts.flags |=  RESET_HEAD_DETACH;
 	ropts.head_msg = buf.buf;
 	if (reset_head(the_repository, &ropts) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 0643d015255..d5a8ee39fc4 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -394,6 +394,15 @@ test_expect_success 'switch to branch not checked out' '
 	git rebase main other
 '
 
+test_expect_success 'switch to non-branch detaches HEAD' '
+	git checkout main &&
+	old_main=$(git rev-parse HEAD) &&
+	git rebase First Second^0 &&
+	test_cmp_rev HEAD Second &&
+	test_cmp_rev main $old_main &&
+	test_must_fail git symbolic-ref HEAD
+'
+
 test_expect_success 'refuse to switch to branch checked out elsewhere' '
 	git checkout main &&
 	git worktree add wt &&
-- 
gitgitgadget
