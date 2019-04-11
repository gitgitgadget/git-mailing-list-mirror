Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7BB920248
	for <e@80x24.org>; Thu, 11 Apr 2019 15:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfDKPSr (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 11:18:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38246 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKPSo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 11:18:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id d13so5564279edr.5
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 08:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XVHSiL5mMCg4EgIdII3I/N3VRROLaXAH6aK3irFuKkc=;
        b=elecvkmzSo1+Hf2LOQxi2Yu69nnO828DH5hlWEH6gRqw+d4vYmO8M2R04ZGfKgYXYK
         EcN8HtB7WHy318R5qujgoVROKPlyszqiqq6YfDWov1IB5W/y5igSRZX3xvprthesiR1B
         X7IjVbqIu0k2CmxYolgLDfrdxZPowVOJiZ1/cWU6vNyAk6M8mf8LFcpIAGTSNNPYcnv4
         HvaRAL6vOolLlTpF6Y3GnQmPoXtLbE/cTm/L9/Db0rKgQQSAbLJw+Y4asrjOs+xSGdmC
         u/COakDho4YDFKYzJoLuaib1zBM5QAc4GYNoqPf2TuqNSr8v8W477k/VIh4YZhGe5oHS
         UrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XVHSiL5mMCg4EgIdII3I/N3VRROLaXAH6aK3irFuKkc=;
        b=IT7E+CEQzjuX6r44P98sQP6tGPZViubWJMuqV2M+/Fk36slb2xxv3UaSJq0rwKGdFl
         3MSYgaF/HIj0jCW91fNU+E0PYn0KS88pQbOm1I4rcHSoo9Sq6VT48cPHqnF1tbYvCKNr
         Qsz9fTNCD6eVgqDos3N0SMN52W+Q5yl48ESoy+EHyRCNRAA4gn+3rq4WZMEJAPEjJiL6
         TNBM4Bx3Kr4Sn9CZTcjEQT5+keyRvzXKWJtOnizW+UUz40wusdshn1YFcpYFwHWWBqyh
         QDFhw1t32HknrntaW17yj+dvJzITuGtZHnrOnyanaj8rVvg02+j/DUfqOq1UZN8zKgYO
         MtAw==
X-Gm-Message-State: APjAAAWqTwaPreJdBIirXoL6+de6MW7ezfVR+drGWxk8zp/Nk1Oq9o4R
        NI+dpQU4f8uPq9Nkb3Id+qxXZ65v
X-Google-Smtp-Source: APXvYqxnaa9WWhngk80VpARjWo5IK48RTNT18vgI8zLnLdcKOhbacVFnh2d9wV3jxVvtEI5BwX+GHQ==
X-Received: by 2002:a50:9b50:: with SMTP id a16mr32442278edj.160.1554995922197;
        Thu, 11 Apr 2019 08:18:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm505193edk.56.2019.04.11.08.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:18:41 -0700 (PDT)
Date:   Thu, 11 Apr 2019 08:18:41 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Apr 2019 15:18:31 GMT
Message-Id: <d15be7b63a539f113355590aadba44bd48238472.1554995916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v3.git.gitgitgadget@gmail.com>
References: <pull.169.v2.git.gitgitgadget@gmail.com>
        <pull.169.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 05/10] config: add read_very_early_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Created an even lighter version of read_early_config() that
only looks at system and global config settings.  It omits
repo-local, worktree-local, and command-line settings.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 config.c | 25 ++++++++++++++++++++++---
 config.h |  4 ++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 8e5f45fa20..5b10f18088 100644
--- a/config.c
+++ b/config.c
@@ -1688,14 +1688,16 @@ static int do_git_config_sequence(const struct config_options *opts,
 		ret += git_config_from_file(fn, user_config, data);
 
 	current_parsing_scope = CONFIG_SCOPE_REPO;
-	if (repo_config && !access_or_die(repo_config, R_OK, 0))
+	if (!opts->ignore_repo &&
+	    repo_config && !access_or_die(repo_config, R_OK, 0))
 		ret += git_config_from_file(fn, repo_config, data);
 
 	/*
 	 * Note: this should have a new scope, CONFIG_SCOPE_WORKTREE.
 	 * But let's not complicate things before it's actually needed.
 	 */
-	if (repository_format_worktree_config) {
+	if (!opts->ignore_worktree &&
+	    repository_format_worktree_config) {
 		char *path = git_pathdup("config.worktree");
 		if (!access_or_die(path, R_OK, 0))
 			ret += git_config_from_file(fn, path, data);
@@ -1703,7 +1705,8 @@ static int do_git_config_sequence(const struct config_options *opts,
 	}
 
 	current_parsing_scope = CONFIG_SCOPE_CMDLINE;
-	if (git_config_from_parameters(fn, data) < 0)
+	if (!opts->ignore_cmdline &&
+	    git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
 
 	current_parsing_scope = CONFIG_SCOPE_UNKNOWN;
@@ -1794,6 +1797,22 @@ void read_early_config(config_fn_t cb, void *data)
 	strbuf_release(&gitdir);
 }
 
+/*
+ * Read config but only enumerate system and global settings.
+ * Omit any repo-local, worktree-local, or command-line settings.
+ */
+void read_very_early_config(config_fn_t cb, void *data)
+{
+	struct config_options opts = {0};
+
+	opts.respect_includes = 1;
+	opts.ignore_repo = 1;
+	opts.ignore_worktree = 1;
+	opts.ignore_cmdline = 1;
+
+	config_with_options(cb, data, NULL, &opts);
+}
+
 static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
 {
 	struct config_set_element k;
diff --git a/config.h b/config.h
index ee5d3fa7b4..6a58d61d22 100644
--- a/config.h
+++ b/config.h
@@ -55,6 +55,9 @@ typedef int (*config_parser_event_fn_t)(enum config_event_t type,
 
 struct config_options {
 	unsigned int respect_includes : 1;
+	unsigned int ignore_repo : 1;
+	unsigned int ignore_worktree : 1;
+	unsigned int ignore_cmdline : 1;
 	const char *commondir;
 	const char *git_dir;
 	config_parser_event_fn_t event_fn;
@@ -83,6 +86,7 @@ extern int git_config_from_blob_oid(config_fn_t fn, const char *name,
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern void read_early_config(config_fn_t cb, void *data);
+extern void read_very_early_config(config_fn_t cb, void *data);
 extern void git_config(config_fn_t fn, void *);
 extern int config_with_options(config_fn_t fn, void *,
 			       struct git_config_source *config_source,
-- 
gitgitgadget

