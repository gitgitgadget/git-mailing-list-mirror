Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3742820248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfCQMu2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:50:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40717 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:50:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id u9so9495557pgo.7
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nsKAG+TCAm6ro/tTSeyM4GCLFweO/cxZV5E4SYlEoXY=;
        b=hKd43blgvgxSeYsYz7DyF1fDaNCmVeuHCys6QPGMdm6kqUyUPel5wb2GGnjgV2FfXZ
         Ya6DbYw+bB9bML4M0C3K/0dazvHv2wMT7zGoPyo1w83NnBC2fYKl/77J56bxi2EGPqe+
         rQjBSOPF8EiuE5p2/3Qq9mo1lTYBMI2BXo938uess6J8JtrG3pH4h7CLoaCOF2He/5pR
         54+C2juRFwQdmGBJ2V285PW6iOArBRFmNug50LXQJu4Iavs+yw4yP8uPgW0qZZ0t1mHD
         IKyIU2nQI5DPCDrAvamvbtwmWlCSf90tObJ06G+eZ22gTbk9rBwck2WIBSBf03f7ejJm
         3JPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nsKAG+TCAm6ro/tTSeyM4GCLFweO/cxZV5E4SYlEoXY=;
        b=kzLBfCdwYvJc/Cjn7fIeDkQ4VZCE1z9M80QPrJ0QtrFz98dO9ss3+AiE5nPn3VlI2q
         a/u1rMT9AlMIDYK0pUPGmtto9HktU8p4LT6TXz4tOf5igJ8NatqFR+ko5jv6FcosjSSe
         K15wV6j+wQ7IKrVO1D6MF1Su1kZXmJHlova7YlrENg+jmqpNZlEKH9qhCcQYppw6+gLZ
         7/et5/D7QToP8Ng1vI0Epd1m6Blr3pHvosfdQHCRPr2V3sPcqTuFq58RThtYHkxgNTRF
         0+LMgk++Y/s3MROrAQLY3FviV5hTBRlLC98ECHOVXuz5a41YY97awrBTjT7s98f7GdWj
         5UJQ==
X-Gm-Message-State: APjAAAUCCnBP1+HemUWEDP5fwcchFuTv+q72a6SSo3pkrc7vtti0yg5b
        oxATzobDBzjFkNsP1JJnLIc=
X-Google-Smtp-Source: APXvYqzYqck8b+Nur15ta0Gt2fbNjU9/6YH3UmtRhS6wTKNYkU7c8SDVjsPJAMN139iu04hseQqFZw==
X-Received: by 2002:a62:4817:: with SMTP id v23mr13782457pfa.81.1552827027970;
        Sun, 17 Mar 2019 05:50:27 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id l63sm10315108pfc.89.2019.03.17.05.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:50:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:50:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 08/26] checkout: factor out some code in parse_branchname_arg()
Date:   Sun, 17 Mar 2019 19:49:08 +0700
Message-Id: <20190317124926.17137-9-pclouds@gmail.com>
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

This is in preparation for the new command restore, which also
needs to parse opts->source_tree but does not need all the
disambiguation logic.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 51 ++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f7801db2fb..1ce0446bc6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1081,6 +1081,34 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 	return git_xmerge_config(var, value, NULL);
 }
 
+static void setup_new_branch_info_and_source_tree(
+	struct branch_info *new_branch_info,
+	struct checkout_opts *opts,
+	struct object_id *rev,
+	const char *arg)
+{
+	struct tree **source_tree = &opts->source_tree;
+	struct object_id branch_rev;
+
+	new_branch_info->name = arg;
+	setup_branch_path(new_branch_info);
+
+	if (!check_refname_format(new_branch_info->path, 0) &&
+	    !read_ref(new_branch_info->path, &branch_rev))
+		oidcpy(rev, &branch_rev);
+	else
+		new_branch_info->path = NULL; /* not an existing branch */
+
+	new_branch_info->commit = lookup_commit_reference_gently(the_repository, rev, 1);
+	if (!new_branch_info->commit) {
+		/* not a commit */
+		*source_tree = parse_tree_indirect(rev);
+	} else {
+		parse_commit_or_die(new_branch_info->commit);
+		*source_tree = get_commit_tree(new_branch_info->commit);
+	}
+}
+
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new_branch_info,
@@ -1088,10 +1116,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 				struct object_id *rev,
 				int *dwim_remotes_matched)
 {
-	struct tree **source_tree = &opts->source_tree;
 	const char **new_branch = &opts->new_branch;
 	int argcount = 0;
-	struct object_id branch_rev;
 	const char *arg;
 	int dash_dash_pos;
 	int has_dash_dash = 0;
@@ -1213,26 +1239,11 @@ static int parse_branchname_arg(int argc, const char **argv,
 	argv++;
 	argc--;
 
-	new_branch_info->name = arg;
-	setup_branch_path(new_branch_info);
-
-	if (!check_refname_format(new_branch_info->path, 0) &&
-	    !read_ref(new_branch_info->path, &branch_rev))
-		oidcpy(rev, &branch_rev);
-	else
-		new_branch_info->path = NULL; /* not an existing branch */
+	setup_new_branch_info_and_source_tree(new_branch_info, opts, rev, arg);
 
-	new_branch_info->commit = lookup_commit_reference_gently(the_repository, rev, 1);
-	if (!new_branch_info->commit) {
-		/* not a commit */
-		*source_tree = parse_tree_indirect(rev);
-	} else {
-		parse_commit_or_die(new_branch_info->commit);
-		*source_tree = get_commit_tree(new_branch_info->commit);
-	}
-
-	if (!*source_tree)                   /* case (1): want a tree */
+	if (!opts->source_tree)                   /* case (1): want a tree */
 		die(_("reference is not a tree: %s"), arg);
+
 	if (!has_dash_dash) {	/* case (3).(d) -> (1) */
 		/*
 		 * Do not complain the most common case
-- 
2.21.0.548.gd3c7d92dc2

