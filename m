Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E134120248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfC2Kls (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:41:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37419 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfC2Kls (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:41:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id q6so859402pll.4
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L7ALrjDUF5z4nISFHzAMVwo7nzZQvql1SdBAJTKDzBw=;
        b=V+n8awomGD7rSH7Xu5eJncqQlSehHRrs7JAW48VEjrp9HoWFbbrgTDJ8nUE7jKjloa
         ZZWX0SN3N0DK9j7c0I0bOq/QcBR4z20UUkoa661GdnDAjJpZh9bUuKzmCEXmGlQUg4eg
         MREUZvVFwvxHqCs5y4AbGeRtSQZW9DJFeF4flEB4I9RUfUdRojOsGEFFozvqSkIE7o+T
         c9Z//C/MuSzOJPDSH7/HN530qT/zWsceGhButh3/G3m8hXykqvmlYusMsySFpfxhs270
         CwKMhWbhiKQlsmAgHuUJhy0UR8PgNE/VKzyvoXrLoVByZz/jwnuxwskNBW1+i/7qLb5A
         3yZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L7ALrjDUF5z4nISFHzAMVwo7nzZQvql1SdBAJTKDzBw=;
        b=o9xd0V8XMo5LxbgpIiyv61smfy0+kxmBnvXgkjP9VNt1gvJHRtrSwJIy6RBFYRHACv
         XeVcztNqkRC2CLPJ05L4PvNblZl0V+NWV5eEO4Ni6Hm/zR68sgBCU5qUqFU1fCYYh0Q1
         s5ECScAQnGYpvJAUYZsNzdgy3XSufQzesYrbv8hFpeCzmnpcfkRH4JrVYLm11TX5d6fP
         r9cDobjaY/VTIHS0vHOzLnqXSnLkjsQp4mRXAXbxsNldOLHLk0fRZCXJmlnSMv5LqlVS
         HGf5QEh/iTKIcZtsIq+q1vE0qYoczd8CjS4Qp2EyVz8buMk1SD0JnumRnM4hp/swL0uA
         ksWA==
X-Gm-Message-State: APjAAAXia+16SW/SPM/iGai6g3sfaAv+Ve83QBoGm4Rv5Dsf1S2uuEcK
        I+4hhQ9ThQg7YlgTJ5J4RCs=
X-Google-Smtp-Source: APXvYqyeRCUw2kNt5z/d+IuD4PL6ezrdxCYkSTp0wmiNbfMmJwvnnvkiCOYrE0EIIlY1218+Bm5rIA==
X-Received: by 2002:a17:902:b181:: with SMTP id s1mr47745691plr.321.1553856108030;
        Fri, 29 Mar 2019 03:41:48 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id m7sm5892661pgg.62.2019.03.29.03.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:41:47 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:41:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 19/27] switch: only allow explicit detached HEAD
Date:   Fri, 29 Mar 2019 17:39:11 +0700
Message-Id: <20190329103919.15642-20-pclouds@gmail.com>
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
index e9dfe38d69..4416b82bfd 100644
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
2.21.0.479.g47ac719cd3

