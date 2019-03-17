Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A800B20248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfCQMvG (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:51:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39268 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMvG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:51:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id i20so9409045pfo.6
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MG9SfhC3vkjfeRW3EsqTTq2eJ58px8vX0/dcLX4+88M=;
        b=K1wFLTM5NLBHdyKVw4zPNA6r6cX+ti5P9MQEdnZKtCpaaMtnYXGUA+6M3XZunnwxEG
         pBRZxjz0+dpNuJrUfUKS8U1OVwlt/S5RYFS7kWoXw0Y73OA3W1iLnZC+d7/jELI2hdX8
         g3uIBh1cETdAGFBDn9qyW9XSWxWH9OxFn7qYeu6DHqEY5+1U7LaofWLp5VRfDu9svx3O
         ufIXTpSmxlNbqeJ2K1BVP4ydavO8GFE7UgXyfu+z8SdWQY+o+oaRAtqp7rtXPvoiCg4O
         rhI4gc1UFh6KQtYKKVy1LHpzcYBUM/3R2uVsPISA5Lf+oFZCjL4IPjdNow1fP4rN0ink
         u9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MG9SfhC3vkjfeRW3EsqTTq2eJ58px8vX0/dcLX4+88M=;
        b=NJ2J7mpQn2nUuNvn7rxIW/c6w3Nj0lErI24VVGVQ78NkSs1VOrdNvLe5GSaKQwYPxj
         shEMmMVjoqb0gU7YXkmwF7aSYA+xxHyuVVuXnxbhieRkEuQyRoREopKa1XP2faFy509B
         lAUdhEtfA7kjBt0tWs9fvRTHKg4QBxsLsyt53K9kRBQTNJILUX1e/ghCK0h0HGY7j9hp
         tE40++tFfGxJcjMV4P0xsKqSavgiVeZOlNsH+4iOlPdvjt9hkMb2souXPgygduiixm7r
         RomBAMNzNE9O+6CkyYwJYSjizPwf4O4fnTgQqqx6mLeh6v1wIZdhiTgjVeG3jK/gpjC5
         cwpw==
X-Gm-Message-State: APjAAAXk2rNaslsTeiZAdvWljzn//HFYmzPDvXbM0bJVJjuFSMg+l7x3
        My9VciEiNmPXE+L/HSbwB20=
X-Google-Smtp-Source: APXvYqyVzmRzgLX0afWK34ih/J42Cjd1ZD9sCBVxuhTS48+D5+nb1vpjwpIesk5OMJv2/Kh6aK67xA==
X-Received: by 2002:a17:902:9008:: with SMTP id a8mr14551834plp.38.1552827065593;
        Sun, 17 Mar 2019 05:51:05 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id p86sm15148148pfa.104.2019.03.17.05.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:51:04 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:50:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 14/26] switch: add --discard-changes
Date:   Sun, 17 Mar 2019 19:49:14 +0700
Message-Id: <20190317124926.17137-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--discard-changes is a better name than --force for this option since
it's what really happens. --force is turned to an alias for
--discard-changes. But it's meant to an alias for potentially more force
options in the future.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 400a0d5620..bd94b04303 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -53,6 +53,7 @@ struct checkout_opts {
 	int count_checkout_paths;
 	int overlay_mode;
 	int no_dwim_new_local_branch;
+	int discard_changes;
 
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
@@ -680,7 +681,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		return error(_("index file corrupt"));
 
 	resolve_undo_clear();
-	if (opts->force) {
+	if (opts->discard_changes) {
 		ret = reset_tree(get_commit_tree(new_branch_info->commit),
 				 opts, 1, writeout_error);
 		if (ret)
@@ -802,7 +803,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	if (!opts->force && !opts->quiet)
+	if (!opts->discard_changes && !opts->quiet)
 		show_local_changes(&new_branch_info->commit->object, &opts->diff_options);
 
 	return 0;
@@ -1309,6 +1310,9 @@ static int checkout_branch(struct checkout_opts *opts,
 	if (opts->force && opts->merge)
 		die(_("'%s' cannot be used with '%s'"), "-f", "-m");
 
+	if (opts->discard_changes && opts->merge)
+		die(_("'%s' cannot be used with '%s'"), "--discard-changes", "--merge");
+
 	if (opts->force_detach && opts->new_branch)
 		die(_("'%s' cannot be used with '%s'"),
 		    "--detach", "-b/-B/--orphan");
@@ -1445,6 +1449,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		opts->merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
 	}
+	if (opts->force)
+		opts->discard_changes = 1;
 
 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));
@@ -1600,6 +1606,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 			   N_("create and switch to a new branch")),
 		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and switch to a branch")),
+		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
+			 N_("throw away local modifications")),
 		OPT_END()
 	};
 	int ret;
-- 
2.21.0.548.gd3c7d92dc2

