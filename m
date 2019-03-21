Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31ABF20248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfCUNTL (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:19:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39534 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbfCUNTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:19:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so4278625pfo.6
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dR8CRkK8fjUgrnAu9t6mJcEqdMzwV5vhayKwaymfNKA=;
        b=rsQov4l/LJR1AGEpBvxhsJKE34bkB586PaPeJQDMZdtlPScop1siPxfPN+gCOi5R44
         jHNVSZdHABjFqvF5NPhBMl8NcDoE2tjRUoYBt9ttkRM3IybHAlFQFTo06hIuJu3qmQrD
         COanWLsRir7/a4/Dy1ywtKYEapD1PHMZP77svrpucEXCuSQJ+2zoIEGKpyGV8FS3JXdF
         u5o5upSeiIq+5OyFVc6h9CrccK6uMR+k/rGMBN8t1y8HeBV0YwGoyTH9Kz6yH5oSKzih
         JNPoxa5qeOHecu824R5K/LZgMX1lUBznuV7/TUWbIW0WLYBM/Z9UF4UO+tKsGxvuOP4j
         6Txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dR8CRkK8fjUgrnAu9t6mJcEqdMzwV5vhayKwaymfNKA=;
        b=laW4yohPtyWuqCjBCmlCDV/yyhEtFrVemKUveqQIlVa9QBzTWuasymzI99irY/5F3F
         OCANyUxWyuk85S3f/TYVAlN65JtSTlwIjt70uj2+DYakTpDXZY2vc6NvQjKinhXLyI58
         Nidk9Fgublsqn5HZpNziXfDJZmnr5WGp5jqzu6JFLE7rb9/VYynH764C6a13krqNBjF4
         G7sMUBK9PSYfUAXndnZMzlyDSJJHE/YsoAG1ULCOnZMZ9/Bc/BQF3cu1HZ4mDSQGuH34
         dBAe6L6eX77FTDFpPDeCjnXjZT9ubPXcIuoAsrACS4hkyrwC8pC0lxOaKd9i1B/Z9NNu
         CiNw==
X-Gm-Message-State: APjAAAWc/JO9dCpxFQuyjH36aRmpFC8QXo1AibyGOtLaS4A7kEZ9TRoF
        lDVbK+syLvVo3N+xC3cewYQ=
X-Google-Smtp-Source: APXvYqyAaN0ll9GB3q5pym18MKxLmRZF0t6BkkE1kvhwqE4BLWfKATX13mtTiWSJfWiDPHkGVojwyQ==
X-Received: by 2002:a62:47d0:: with SMTP id p77mr3218665pfi.95.1553174349253;
        Thu, 21 Mar 2019 06:19:09 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id g13sm7126848pfm.159.2019.03.21.06.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:19:08 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:19:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 17/26] switch: reject "do nothing" case
Date:   Thu, 21 Mar 2019 20:16:46 +0700
Message-Id: <20190321131655.15249-18-pclouds@gmail.com>
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

"git checkout" can be executed without any arguments. What it does is
not exactly great: it switches from HEAD to HEAD and shows worktree
modification as a side effect.

Make switch reject this case. Just use "git status" if you want
that side effect. For switch, you have to either

- really switch a branch
- (explicitly) detach from the current branch
- create a new branch
---
 builtin/checkout.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2c4cab6406..73b7373414 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -55,6 +55,7 @@ struct checkout_opts {
 	int no_dwim_new_local_branch;
 	int discard_changes;
 	int accept_pathspec;
+	int switch_branch_doing_nothing_is_ok;
 
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
@@ -1338,6 +1339,12 @@ static int checkout_branch(struct checkout_opts *opts,
 		die(_("Cannot switch branch to a non-commit '%s'"),
 		    new_branch_info->name);
 
+	if (!opts->switch_branch_doing_nothing_is_ok &&
+	    !new_branch_info->name &&
+	    !opts->new_branch &&
+	    !opts->force_detach)
+		die(_("missing branch or commit argument"));
+
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
 		int flag;
@@ -1593,6 +1600,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
+	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.accept_pathspec = 1;
 
 	options = parse_options_dup(checkout_options);
@@ -1624,6 +1632,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
 	opts.accept_pathspec = 0;
+	opts.switch_branch_doing_nothing_is_ok = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.548.gd3c7d92dc2

