Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A78FD20248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfCQMvb (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:51:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42350 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMvb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:51:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so6648467pfn.9
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxdvYRW5lOwtcsY3Xg5bPzI69zHrdn7pCFUTOwqGlEM=;
        b=cwa2YGW9HWdOpApCFFaRGr1G/oiTvnyR/+98S7QRA/CzM0M0y5ysU4/O9RVY28GfYy
         gxYSp0RsScTeqNGuwqtCcn6z9qIgPHjYMyKiKZAIi3T5M7UDI2aYeYBi0e94WC2cYjWs
         XzQ7kMlMVBPh/g4/rj2+SKJZfXL6UumgWcISQmqU0kmm/k4TeHRnhiJOVpbTIxkExtug
         jFJDFzMQUe4JQBK/86yaxYNwWAMc1i077VhHG6ZAOYA+9p8iBsuKNz/adjvmnRFLCR8R
         yLlVbbkyamiHf7G0iARggd8sDshBP4ZGbx/bZChjcOD9KbsWeL2iAn6aRA9HE2F7g6Cy
         S6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxdvYRW5lOwtcsY3Xg5bPzI69zHrdn7pCFUTOwqGlEM=;
        b=o/boh2u+ZMZqHIcppWogswFxpABtAUHfXrPbIjlJ5cyYeA4PpQzQM7FxzoJCXk7s8C
         GAyLQDF0WFcSM+bqXvXCUurUcXovkhtms8Ckzrp7n788kRwy8drBtvx6wDjK/R+Lh5Xo
         J/gW3eYiHr1lPC1jtKNzU2HJUv2cUFdqFw/TQycjcq2eDhDtoZQvulGWzggtRmKQt5Mx
         lYYA2vexGoGT2b3L6+z7umbBUcHOEMsFTuxuEh+Dbt0LlWM7NE+la926ixnd1e3kNzQg
         O+2aVdIAsNx0h/8cMphxb+Ml1XdYGRyQf37VDU1mswfA1jPku6oz5kRsYvVxLgZBeict
         gVyA==
X-Gm-Message-State: APjAAAUn5IAdMR4ezexOoGPJ13BejPGWjhEkEoYUsHgW2Q7A3bcMzP5Q
        DhQ9exn+K3Ftfs3pTFvWjkM=
X-Google-Smtp-Source: APXvYqzoQ1pHp0aZksagAiqsQPpoXpvw/F8UPxqniCIO8Sg1eff3EMsqD7jdoFOYkV1+bw6jrQ2nhQ==
X-Received: by 2002:a63:e101:: with SMTP id z1mr12881075pgh.190.1552827090535;
        Sun, 17 Mar 2019 05:51:30 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id d24sm360344pfn.0.2019.03.17.05.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:51:29 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:51:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 18/26] switch: only allow explicit detached HEAD
Date:   Sun, 17 Mar 2019 19:49:18 +0700
Message-Id: <20190317124926.17137-19-pclouds@gmail.com>
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

"git checkout <commit>" will checkout the commit in question and
detach HEAD from the current branch. It is naturally a right thing to
do once you get git references. But detached HEAD is a scary concept
to new users because we show a lot of warnings and stuff, and it could
be hard to get out of (until you know better).

To keep switch a bit more friendly to new users, we only allow
entering detached HEAD mode when --detach is given. "git
switch" must take a branch (unless you create a new branch,
then of course switch can take any commit-ish)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 73b7373414..d72e28aabb 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -45,6 +45,7 @@ struct checkout_opts {
 	int merge;
 	int force;
 	int force_detach;
+	int implicit_detach;
 	int writeout_stage;
 	int overwrite_ignore;
 	int ignore_skipworktree;
@@ -1298,6 +1299,29 @@ static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 	return status;
 }
 
+static void die_expecting_a_branch(const struct branch_info *branch_info)
+{
+	struct object_id oid;
+	char *to_free;
+
+	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, &to_free) == 1) {
+		const char *ref = to_free;
+
+		if (skip_prefix(ref, "refs/tags/", &ref))
+			die(_("a branch is expected, got tag '%s'"), ref);
+		if (skip_prefix(ref, "refs/remotes/", &ref))
+			die(_("a branch is expected, got remote branch '%s'"), ref);
+		die(_("a branch is expected, got '%s'"), ref);
+	}
+	if (branch_info->commit)
+		die(_("a branch is expected, got commit '%s'"), branch_info->name);
+	/*
+	 * This case should never happen because we already die() on
+	 * non-commit, but just in case.
+	 */
+	die(_("a branch is expected, got '%s'"), branch_info->name);
+}
+
 static int checkout_branch(struct checkout_opts *opts,
 			   struct branch_info *new_branch_info)
 {
@@ -1345,6 +1369,14 @@ static int checkout_branch(struct checkout_opts *opts,
 	    !opts->force_detach)
 		die(_("missing branch or commit argument"));
 
+	if (!opts->implicit_detach &&
+	    !opts->force_detach &&
+	    !opts->new_branch &&
+	    !opts->new_branch_force &&
+	    new_branch_info->name &&
+	    !new_branch_info->path)
+		die_expecting_a_branch(new_branch_info);
+
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
 		int flag;
@@ -1602,6 +1634,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.no_dwim_new_local_branch = 0;
 	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.accept_pathspec = 1;
+	opts.implicit_detach = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1633,6 +1666,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.no_dwim_new_local_branch = 0;
 	opts.accept_pathspec = 0;
 	opts.switch_branch_doing_nothing_is_ok = 0;
+	opts.implicit_detach = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.548.gd3c7d92dc2

