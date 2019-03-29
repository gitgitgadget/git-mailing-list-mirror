Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D613C20248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfC2KlW (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:41:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43842 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbfC2KlW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:41:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so1022639pgu.10
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dqh8VXl9rLaFoHeJpz38pmyNr4HE8h7MMcjVDuekE/k=;
        b=smTUwcEOH5RsAepzbqYKSfFG/6h5GyrfHtYIU+B+wPNeolrGTZu+AU9KMlpLfG+z2O
         NWceJt57GftLEnyC/vd6PAf+S51ZBBNdtNzjzipt/XGk1QSpMxb9Lhe4NchhTwCYxtsf
         mHWXif6Qzux22an9sYL4jDBhuaeuVbXwi4s9lKd6OjVdYbJ1WE6Po6zl27MS3VEKU2aY
         dDl2tcuBwnw8GcVNl//IPHkg6SZzakZkV53XXYTMVH7c65ygEWl08Op98zRQSjCrE+iD
         5YWWjbVStlAUGDnZCsY+Q6i6H1ingYvKPbO3XR9IBye1beWPXcIIih5ghChjLGD4MrJz
         ZfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dqh8VXl9rLaFoHeJpz38pmyNr4HE8h7MMcjVDuekE/k=;
        b=MAYGXG7dkxI5bJL/4k59D9Pw74aJ+Ys7AzRSkxqUUEWAjxLsmvtK9gS8lFHpZ114a3
         3L3BrVaoRkNdBMSR1i97/BJbmN1ahpvsy3Cj3Q0f6Ibu808CSguThd/hUFZOS4ZU5Egh
         P9t6jA2dRyr5WWzmAkz2kUJhxEmX5KKWG2LWb1qIQ3Zc2hupHUCCYC9ODDYoGZ7PP3fN
         21i+T6yYboGG33OqVEFub3xroqarQ7TLyUZ9Fo99En+fWIC8LY4zFekkiS2CcxZQAjRW
         0b/5BmgMufimdwvJ8E3tBr4qIpe4HC3wejzpKSgZxISj0gmKaq5IOOvAXMb/VibdcSY3
         8dPg==
X-Gm-Message-State: APjAAAWWUs5CQLYFfV/PAcBDAGDZ0N3H7iGmJggkqSL3Bf+6F2t6bINX
        Koxlf3GZIPEy9eUVZQDmOuM=
X-Google-Smtp-Source: APXvYqxj9gx+b+fkPlYZ2KKgFLnbD/epVsmVX4Y6+J6Cglf9Y/4NJQZ5IAYJO70jy+/1QXGme+MyZQ==
X-Received: by 2002:aa7:8243:: with SMTP id e3mr47069292pfn.40.1553856081953;
        Fri, 29 Mar 2019 03:41:21 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id t190sm3633128pfb.33.2019.03.29.03.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:41:20 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:41:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 15/27] switch: add --discard-changes
Date:   Fri, 29 Mar 2019 17:39:07 +0700
Message-Id: <20190329103919.15642-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--discard-changes is a better name than --force for this option since
it's what really happens. --force is turned to an alias for
--discard-changes. But it's meant to be an alias for potentially more
force options in the future.

Side note. It's not obvious from the patch but --discard-changes also
affects submodules if --recurse-submodules is used. The knob to force
updating submodules is hidden behind unpack-trees.c

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 319ba372e3..6d0b2ef565 100644
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
2.21.0.479.g47ac719cd3

