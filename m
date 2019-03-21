Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0C8420248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfCUNSI (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:18:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43004 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfCUNSH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:18:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so4166315pgh.9
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GD5Rh0oDGmhgGee9T9CW5LlNWL6toV6OnTxwiq/Yo1Y=;
        b=SnflLGDb1TqGFLcx/l+6J6Wpbl5lLF1LONutRijP8W8UasYhl3D9RV5WonKXWrHsIW
         STOkQrp8iaZuEfGwxQMsYT4Jv4zmm44NKWljDTtXx7LLyj4sDcOvVo8cwF4kQ2IXL5c3
         G09yMK2fwLwj9T6ULbgTInSUrfzK6ViOw3k+lVDN5GVjzD1FphyyTO3LFE0w4m2Rt4e1
         GtSBYLvc51n3VdbMMQrCkx+cHhK0ajm9nPb39ps53W/zHIio9lpFH6FXwj/29jeA+FeE
         GdVoFcsboXQjJ8kbrjcwMRORXoDz+hvdVLmw3FRKncMGyAVaihZEsI7oTwQ71Ca1Pb+D
         2B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GD5Rh0oDGmhgGee9T9CW5LlNWL6toV6OnTxwiq/Yo1Y=;
        b=TfsDvfopxQBEd9W2j9VyfX3ynCXaZ7RwrKZZDOH1uPrPXhrlB2t6Eec3OywBUkKbaq
         JACAXiyNAKEQc1b3uDSWA6N2lvo+qZUg+51ezXL0ldwYjj9v/iNDHnsdUDUUuTQbrPDx
         YfUtVw6MzhK4wF2JoXUuGIj65C2qRVHevxKJfcMW2myMfqGwYn63K+bpqtEFRO7AMSYw
         llVDpUg9/5JWqkcuRbF9H8FAlLb3/h3l/gkaiXHs6WGUJaWbACFbS+cTsE+fkVGW9l1I
         Ex+ZYgvcj4jx78Emb/elZhC9xUh9p4VhY0r879pRLNUDH4ezCb9HYRdDG5JOys0BcTYy
         W7mg==
X-Gm-Message-State: APjAAAUH4dxoTGpYpz/lc50LXVtkrjaIHr4aXi/cVL5PHme3gEiPXICW
        PLtUw0AvSIEm3t1g/3nxTRM=
X-Google-Smtp-Source: APXvYqwbzOoS3ptwggerr65EGeWoEBvVO9dbRmua+BBMObBXEP+VK6Qj98lJsRCi5fRVtqNu0SpboQ==
X-Received: by 2002:a65:6546:: with SMTP id a6mr3305321pgw.296.1553174286954;
        Thu, 21 Mar 2019 06:18:06 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id o3sm5584420pgv.50.2019.03.21.06.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:18:06 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:17:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 08/26] checkout: factor out some code in parse_branchname_arg()
Date:   Thu, 21 Mar 2019 20:16:37 +0700
Message-Id: <20190321131655.15249-9-pclouds@gmail.com>
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

This is in preparation for the new command restore, which also
needs to parse opts->source_tree but does not need all the
disambiguation logic.
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

