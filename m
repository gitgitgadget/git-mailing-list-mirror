Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46E6E20248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfC2Klm (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:41:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34704 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfC2Klm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:41:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so866097plt.1
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E22TX1Y2gQlqeaQMt7pDZxE9OG0JA1fmQRW/ARIvOTw=;
        b=EsqA+8a+yY4SoXF2MscMR8z6bo/1QdRCqQAvbYZrR0tqwE6ZNWbXDkWtCdGZHtbCXE
         +rKv7lBOXMSNkqf5/qA9XiSP7bVzScmgaaiaRSRvvtsxNK1OlJhvFW10cxa7zMbulN/J
         sxFY6eVs/TrJJbAyN2Q6votaKAUGollyvMpIz+pu8+jxUlZvCRHKuSaq3umVOMsFwFp1
         RZXtnspiAYAy4jHLI5bdvtDhXmgKj8pVhXGIRXIJCE++l7WRLMkhgh4U35z0TM5u0Agb
         WGO7/8dvk0mEgWlDdKYGPuLT/Qo7uHELdSKu+2XV5SREr7XJyrfXx6GaDTLyy/V4mY9a
         SjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E22TX1Y2gQlqeaQMt7pDZxE9OG0JA1fmQRW/ARIvOTw=;
        b=CX7ohYKk9/KT8Tc7+DGyeTSyCeA1/Hw61uq+YGQNwvS1N6IP/7ITlWABIZam0M+SBv
         H0oEq/xfa6r3V+JQmjKK/nxeLRMkrc9vgkqPff3zHm/sw6eUG0TuhFlpfn6prSvWfgHq
         YXh2g75SvhHDKbNtqhu5AS+CJpZ/0BXyydaZSNiTgwQ+OeKzOZf9+cE8Ctdc9Zw1aqh5
         atVVmf7rxex0gnKcqgcaDlKoIan1YcG6oscfDScnY7MwZb0TePGPb7WvZSJS3ofkt5xS
         8S+3I0g8NAAllMVPu+hXWXzhwmyWSbzh2I+t96Gytyg6vRaOotjUYTsUrTf5VU7us1c3
         B9Zw==
X-Gm-Message-State: APjAAAX1ucisLXBLLkT6pqZnn3yDuYTLX1Ltt0R2oP2AnbEXRovmn7CO
        UX/XuGbQxjhA5ugO9LJVDwg=
X-Google-Smtp-Source: APXvYqwa257p/3GH3IBqn4Je6hTJFxMaNpyBmdnX1N7LVf6yaTC5+TyH1B5jCsFzN1ysEtdlq24FaA==
X-Received: by 2002:a17:902:ab92:: with SMTP id f18mr25087143plr.341.1553856101548;
        Fri, 29 Mar 2019 03:41:41 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id k75sm5831675pfj.46.2019.03.29.03.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:41:40 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:41:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 18/27] switch: reject "do nothing" case
Date:   Fri, 29 Mar 2019 17:39:10 +0700
Message-Id: <20190329103919.15642-19-pclouds@gmail.com>
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

"git checkout" can be executed without any arguments. What it does is
not exactly great: it switches from HEAD to HEAD and shows worktree
modification as a side effect.

Make switch reject this case. Just use "git status" if you want
that side effect. For switch, you have to either

- really switch a branch
- (explicitly) detach from the current branch
- create a new branch

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0584dc484d..e9dfe38d69 100644
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
2.21.0.479.g47ac719cd3

