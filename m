Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C0220248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfCUNTR (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:19:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45089 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfCUNTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:19:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id v21so4252403pfm.12
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AvQKPjaKoZP4FAffLGL5l6E1IFN4a38P1XQ723mbR/U=;
        b=rbaWs8RR3V9O0cH5N9tpHT3z0mtNPbO0HB+F+xKUimXc48IQtbzBJF27CEPhTzXCYF
         vLNwRqszht3kK99k57hheWv+IonZOYkOeRT8QF50VwIViLV9nT6OgvXHcAjpwteHl7tv
         UW0cUNgN6e+gPBfORYplytMqvvOvQnkG29wP/IWEip7q0gGkHG4Y1IvyPiN1mX2FwM+V
         7Z8f47nJXY6Yz5GHxH3iej0+xdf/rH5SM43aU8gsyeQfrEKZ/NhQwcFHy2D4hYND7oFf
         Nt/QOlNyR4fyJB0uzMJc2ROvfCUWjxrT4/Sh78JEJsYY3J/bI8XbhMo+tXXgs0NWLTqw
         qhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AvQKPjaKoZP4FAffLGL5l6E1IFN4a38P1XQ723mbR/U=;
        b=K96Q8nTxx4EGXO+WCT5VRNE5TIimEDfDyp4bI9H+4TZ+vpza2vYCkH7dwMCV6yrWiM
         +F6fYEhcJ6mlnJC3YWUl1XxUfAbj9JK2jFxoL60uZIJ/zJjweQRu6/BPFniQKEKVaF+i
         0BdssnWn6bBl+AtoOXXUlxYNXWeih23TwRrA1mlSHySoXE0o4153o9kJLf/3Y9PEiFb2
         4C7fBVD4s/N1um34cNIRzFb1W84elxq2yPb1w8Db6oFWdFSRsnWxyEiRB5x4lqHZL0Kv
         9xW/pGILSFzc+AKgbC301pVzUiS7ylxhpSdI6YMOn5EvnNd9mGBFZke0myAFlF27UkXA
         sW1Q==
X-Gm-Message-State: APjAAAV5fJ7F9KZtkDtTvQ/U7hNbzZAElnBU3KVHLkOFFdxzN8DCqkG/
        Mdhu5abJTLvW4uD4qBAGylo=
X-Google-Smtp-Source: APXvYqzDw9jwj6nTCap8baTdqRo/kBvjjBe062NNncryPeULz2YF7koRCoViXGJ4UBzHA7lsGuioEA==
X-Received: by 2002:a65:62c5:: with SMTP id m5mr3260273pgv.77.1553174355849;
        Thu, 21 Mar 2019 06:19:15 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id r10sm5777252pfn.188.2019.03.21.06.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:19:15 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:19:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 18/26] switch: only allow explicit detached HEAD
Date:   Thu, 21 Mar 2019 20:16:47 +0700
Message-Id: <20190321131655.15249-19-pclouds@gmail.com>
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

"git checkout <commit>" will checkout the commit in question and
detach HEAD from the current branch. It is naturally a right thing to
do once you get git references. But detached HEAD is a scary concept
to new users because we show a lot of warnings and stuff, and it could
be hard to get out of (until you know better).

To keep switch a bit more friendly to new users, we only allow
entering detached HEAD mode when --detach is given. "git
switch" must take a branch (unless you create a new branch,
then of course switch can take any commit-ish)
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

