Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE7F20248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfCUNSu (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:18:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38685 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbfCUNSt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:18:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id v1so4173611pgi.5
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBKw5x2paBWVl/XVrrpyuMps7S8ULwR1ilLojh1sVk8=;
        b=Efnng9HWy45UcmkroJDDrT5uC//5qnnImD6Kk2g0o8G+vRxE3b4952BewrdUPmlCo/
         iXedk6P5paxyUMuWAQOHztu21zaJAw1/20QXMXNTN9MBP/Gv6T2hpdzTnunQysnw9lzy
         tWpMCWBH1uyCvFEIiaIIO7JY840/x5p2pfNZjF1IFi3lhEDd+UiGoU4oINcn15d+sbW7
         2WrAcFuvawX0rZ1/l2b7LVsEFRLuP13UmyzOIQJTa2RLO4qSueuGPA0ajw7ew9wAzbEE
         4fV/aZu3ZMOmKcJ23+C3wJcp+uUAJDUCn2AuXxNOUBXG+YDGbXdDZ8D0mk7hEOjed3zD
         OTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBKw5x2paBWVl/XVrrpyuMps7S8ULwR1ilLojh1sVk8=;
        b=fD6vFJyJLoUQa/rUKmmRgwW58JTJNdMzBdqNPC1zILZTIcWVHv97VlX3YaRhrHDSxq
         bOxyrHF7m24NZMu05HAjukP/Cap92QyM7VepwetPrLwVAqfjb0QhuYbCor16l+JBS7Nv
         OlRWTEaPAbrosKzxlFAblHIuZKBqaaXwhE5BIp4xqmOc4zgnti7FffB4S5Ny79gRa7tx
         ts8geboDc1HOGgn9/avUrgCUC00VS0Hl2lCUeCxli166oqYwtmf7W/v4M50ZGJ7G3egB
         SqAJfwRxvL85iTYhvH7zBXGSupYnmcYXIjVoTYSPTl7d+xNBYhnntV6AgveI6RCZxtyh
         fBnw==
X-Gm-Message-State: APjAAAWEQALZEHnM4S1kwNh+cCM3NDZW4+9bv6yZESHugjYJS6C0+u+p
        TiX0ljwNo/6O0k5FAOObZ9A=
X-Google-Smtp-Source: APXvYqy7BF1wTn0NXzIdWw/3PwlmQmLjpdMhPGZsPMiSRbOvEjSfuVYL36x+mZKL6GNZQ3nbNw1rEw==
X-Received: by 2002:a17:902:aa5:: with SMTP id 34mr3407459plp.302.1553174328295;
        Thu, 21 Mar 2019 06:18:48 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id e1sm6290747pfn.73.2019.03.21.06.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:18:47 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:18:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 14/26] switch: add --discard-changes
Date:   Thu, 21 Mar 2019 20:16:43 +0700
Message-Id: <20190321131655.15249-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--discard-changes is a better name than --force for this option since
it's what really happens. --force is turned to an alias for
--discard-changes. But it's meant to be an alias for potentially more
force options in the future.
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

