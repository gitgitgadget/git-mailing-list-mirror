Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D850320248
	for <e@80x24.org>; Fri,  8 Mar 2019 10:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfCHKRP (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 05:17:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39236 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCHKRP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 05:17:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id h8so13796238pgp.6
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 02:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSojSj5FN3rjbrmSgUHyDiyqPL29JujC+ECnHHbP5bE=;
        b=LN6qegPemEqrJzigtrmxrQ1ZCG93MF2ex3RVvGikvylo0/aQM8Jd7GY0YqrtoCoafV
         z/aQWsAyLhxMU8q/BNrD0LdgGsFxK0XLiGwH/zWds/GcstUfRACTUJ//oVQh4J3AsMkZ
         5y0u5Bt026TMA4wTbW8eK0Pi2Hz4OrcF/SXjJ/uD3YaQqvoBXBQQKYPGL11+22NZQkqx
         /ZtzSqDDyBG31aCmHnACJByL3qQr9XvGPr1Iku08LJTZqqMJO/Vy2mQJkMEA6KlfRm+W
         luVs4SH+BpvRh8K7m8CBoJxcR5e5f1Gyaf8RKx9gwknBwtWb57EI2R7VlKGJlceyV1QK
         QnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSojSj5FN3rjbrmSgUHyDiyqPL29JujC+ECnHHbP5bE=;
        b=j/Z5wWWKYN7fUR3cFZmWILCs018tCGj2oMaOyeAjDNvNxuhEu599pxHOagEqp6lVYE
         e7a+Frp3hynAysjbnQXhObq1/Y3Il3ALvO2GK2oNfH/4ph0RY3tSNsl7HIsh7V5HXeNY
         9JjqNXg3NpZaQd5BCpFo8elB4dolI4IFmppPeP5Axoh+BnRa1Sf2+wb1FWnWvxG4NsNJ
         h1RTESkhGxOZrwvj66Nliy0jNg1MI0nqYNeFcTiR5yzfSJToF75heLREcHosIvXW2LNr
         gyHr8L4glWihxJolVybdpcJ80Apm/zTTqW1GNLYuf7d7fR8htog95CtldmV6EIBpMAz+
         37Aw==
X-Gm-Message-State: APjAAAXx4CovxzzG6MAcMJ028Y90zujipEcqcqTboPVQKf/vZ35TLqng
        4EeafVa++8rOxxBoxOyotMIgvtDH
X-Google-Smtp-Source: APXvYqz0ix5rd+zoQJT3hW8vcpmA7EHIumm6jqK5GBp43KzdA8v0V2bjenOTrHCCxrletpn9eqEMpA==
X-Received: by 2002:a17:902:ba8d:: with SMTP id k13mr18084721pls.15.1552040234251;
        Fri, 08 Mar 2019 02:17:14 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id h184sm20977593pfc.78.2019.03.08.02.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 02:17:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 17:17:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 02/11] restore: take tree-ish from --source option instead
Date:   Fri,  8 Mar 2019 17:16:46 +0700
Message-Id: <20190308101655.9767-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308101655.9767-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another departure from 'git checkout' syntax, which uses -- to
separate ref and pathspec. The observation is restore (or "git
checkout ,, <pathspec>") is most often used to restore some files from
the index. If this is correct, we can simplify it by taking a way the
ref, so that we can write

    git restore some-file

without worrying about some-file being a ref and whether we need to do

    git restore -- some-file

for safety. If the source of the restore comes from a tree, it will be
in the form of an option with value, e.g.

    git restore --source=this-tree some-file

This is of course longer to type than using "--". But hopefully it
will not be used as often, and it is clearly easier to understand.

dwim_new_local_branch is no longer set (or unset) in cmd_restore_files()
because it's irrelevant because we don't really care about dwim-ing.
With accept_ref being unset, dwim can't happen.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 11dd2ae44c..838343d6aa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -38,7 +38,7 @@ static const char * const switch_branch_usage[] = {
 };
 
 static const char * const restore_files_usage[] = {
-	N_("git restore [<options>] [<branch>] -- <file>..."),
+	N_("git restore [<options>] [--source=<branch>] <file>..."),
 	NULL,
 };
 
@@ -57,6 +57,7 @@ struct checkout_opts {
 	int count_checkout_paths;
 	int overlay_mode;
 	int dwim_new_local_branch;
+	int accept_ref;
 	int accept_pathspec;
 	int switch_branch_doing_nothing_is_ok;
 	int only_merge_on_switching_branches;
@@ -72,6 +73,7 @@ struct checkout_opts {
 	int branch_exists;
 	const char *prefix;
 	struct pathspec pathspec;
+	const char *from_treeish;
 	struct tree *source_tree;
 };
 
@@ -1324,6 +1326,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 {
 	struct branch_info new_branch_info;
 	int dwim_remotes_matched = 0;
+	int parseopt_flags = 0;
 
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts->overwrite_ignore = 1;
@@ -1335,8 +1338,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
-	argc = parse_options(argc, argv, prefix, options, usagestr,
-			     PARSE_OPT_KEEP_DASHDASH);
+	if (!opts->accept_pathspec && !opts->accept_ref)
+		BUG("make up your mind, you need to take _something_");
+	if (opts->accept_pathspec && opts->accept_ref)
+		parseopt_flags = PARSE_OPT_KEEP_DASHDASH;
+
+	argc = parse_options(argc, argv, prefix, options,
+			     usagestr, parseopt_flags);
 
 	if (opts->show_progress < 0) {
 		if (opts->quiet)
@@ -1393,7 +1401,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	 * including "last branch" syntax and DWIM-ery for names of
 	 * remote branches, erroring out for invalid or ambiguous cases.
 	 */
-	if (argc) {
+	if (argc && opts->accept_ref) {
 		struct object_id rev;
 		int dwim_ok =
 			!opts->patch_mode &&
@@ -1405,6 +1413,18 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 					     &dwim_remotes_matched);
 		argv += n;
 		argc -= n;
+	} else if (!opts->accept_ref && opts->from_treeish) {
+		struct object_id rev;
+
+		if (get_oid_mb(opts->from_treeish, &rev))
+			die(_("could not resolve %s"), opts->from_treeish);
+
+		setup_new_branch_info_and_source_tree(&new_branch_info,
+						      opts, &rev,
+						      opts->from_treeish);
+
+		if (!opts->source_tree)
+			die(_("reference is not a tree: %s"), opts->from_treeish);
 	}
 
 	if (argc) {
@@ -1488,6 +1508,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.dwim_new_local_branch = 1;
 	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.only_merge_on_switching_branches = 0;
+	opts.accept_ref = 1;
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
 
@@ -1519,6 +1540,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 0;
+	opts.accept_ref = 1;
 	opts.accept_pathspec = 0;
 	opts.switch_branch_doing_nothing_is_ok = 0;
 	opts.only_merge_on_switching_branches = 1;
@@ -1537,15 +1559,19 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 int cmd_restore(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
-	struct option *options = NULL;
+	struct option *options;
+	struct option restore_options[] = {
+		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
+			   N_("where the checkout from")),
+		OPT_END()
+	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.dwim_new_local_branch = 1;
-	opts.switch_branch_doing_nothing_is_ok = 0;
+	opts.accept_ref = 0;
 	opts.accept_pathspec = 1;
 
-	options = parse_options_dup(options);
+	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
 
-- 
2.21.0.rc1.337.gdf7f8d0522

