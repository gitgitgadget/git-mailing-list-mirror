Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFF1F1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 08:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeJ0QtU (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 12:49:20 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37787 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbeJ0QtU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 12:49:20 -0400
Received: by mail-it1-f194.google.com with SMTP id e74-v6so4373914ita.2
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 01:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bHgtQdGKfW+d6pXbSvhonFilMxHbs1cnem+PrHFxTIc=;
        b=IYpBFlqPJltikIC9yu2xiIL/p4uJIl0Jaloog1dbD308DaQRm9A2mDnaX589SZY4ZB
         KnJCtYJ03Mu9YkA4LaZG06lf77bqV5gWFfyF5Ycuki51L+c3yez9JZw23iBEuTWRCh6O
         U4qsYVeGdGgvQ8EpzDSQFax05x9q350XacVb8+rVth2dtaRWwZ15MY0tyTj/s37kQtbP
         RsDZ1Ro+ohoGbP2JgtJNa0ODUziaFhkyX925wAEyySBrUwh9pXyuEbL6xbZomqI5vOKZ
         Ww37osBZAH20gAc9/8HVapXuSoBaY5cgENFdl+uUsFTKzditWXFYTWuXKP62jpShL8g8
         8VzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bHgtQdGKfW+d6pXbSvhonFilMxHbs1cnem+PrHFxTIc=;
        b=c0JQUMRm05ib65LVpabwE5AeD+ZOH8Tbi2ww06AzOeexugS+YXxyG8H4zBm+z5Ajey
         Z8L7sMS8CPq9k+BHmg6YhanwTIAfN7fJ4woW6PZTxfMjZT+xzc0YXWs6k2Dwm6GgV5cc
         2MFO73GvCMkERhC0De1HJp5OTG2kw/c2WYEWWHo6vWrKH2i5lmhgDjA7LfZGxllkFrI8
         sdqUo+AUPrpLS6t5km8EheLwRY99Tpsq1Ujs+GLSxkkYt2zLVIPdiM36Mbe5u+tbt6YA
         9egb156e/bN9hJnnQSKpkn5Bt1rbpdA1NYGz1DsOlHfDvwdlfNXycP/vx4LOThnfDZx/
         pYGA==
X-Gm-Message-State: AGRZ1gLVBfTM7dLsbmYFzydUoffr1CA7anx/sEyr93b9UE6TOzpfz0AE
        /U+Syq3S3cAislLlxe7D63deJL01
X-Google-Smtp-Source: AJdET5eo1vz25eeLAJt+VjzzrK+DowmwefzTQrpZlh2CuROG/FV1i8fTJy3/uxMA1DbhLJMBA3FDZA==
X-Received: by 2002:a24:7312:: with SMTP id y18-v6mr5883901itb.9.1540627751365;
        Sat, 27 Oct 2018 01:09:11 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id k133-v6sm3678185itb.16.2018.10.27.01.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 01:09:10 -0700 (PDT)
Date:   Sat, 27 Oct 2018 04:09:07 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com,
        f.francet@hotmail.com
Subject: [RFC PATCH] remote: add --fetch option to git remote set-url
Message-ID: <1d1b0fe85ddd89cf8172e730e8886d5b4a9ea7eb.1540627720.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the --fetch option to `git remote set-url` such that when
executed we move the remote.*.url to remote.*.pushurl and set
remote.*.url to the given url argument.

For example, if we have the following config:

	[remote "origin"]
		url = git@github.com:git/git.git

`git remote set-url --fetch origin https://github.com/git/git.git`
would change the config to the following:

	[remote "origin"]
		url = https://github.com/git/git.git
		pushurl = git@github.com:git/git.git

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Filip Francetic <f.francet@hotmail.com>
---
 builtin/remote.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index f7edf7f2c..fcf1220c6 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -23,9 +23,9 @@ static const char * const builtin_remote_usage[] = {
 	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
 	N_("git remote set-branches [--add] <name> <branch>..."),
 	N_("git remote get-url [--push] [--all] <name>"),
-	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
-	N_("git remote set-url --add <name> <newurl>"),
-	N_("git remote set-url --delete <name> <url>"),
+	N_("git remote set-url [--push|--fetch] <name> <newurl> [<oldurl>]"),
+	N_("git remote set-url --add [--push|--fetch] <name> <newurl>"),
+	N_("git remote set-url --delete [--push|--fetch] <name> <url>"),
 	NULL
 };
 
@@ -76,9 +76,9 @@ static const char * const builtin_remote_geturl_usage[] = {
 };
 
 static const char * const builtin_remote_seturl_usage[] = {
-	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
-	N_("git remote set-url --add <name> <newurl>"),
-	N_("git remote set-url --delete <name> <url>"),
+	N_("git remote set-url [--push|--fetch] <name> <newurl> [<oldurl>]"),
+	N_("git remote set-url --add [--push|--fetch] <name> <newurl>"),
+	N_("git remote set-url --delete [--push|--fetch] <name> <url>"),
 	NULL
 };
 
@@ -1519,7 +1519,7 @@ static int get_url(int argc, const char **argv)
 
 static int set_url(int argc, const char **argv)
 {
-	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
+	int i, push_mode = 0, fetch_mode = 0, add_mode = 0, delete_mode = 0, move_fetch_to_push = 0;
 	int matches = 0, negative_matches = 0;
 	const char *remotename = NULL;
 	const char *newurl = NULL;
@@ -1532,6 +1532,8 @@ static int set_url(int argc, const char **argv)
 	struct option options[] = {
 		OPT_BOOL('\0', "push", &push_mode,
 			 N_("manipulate push URLs")),
+		OPT_BOOL('\0', "fetch", &fetch_mode,
+			 N_("manipulate fetch URLs")),
 		OPT_BOOL('\0', "add", &add_mode,
 			 N_("add URL")),
 		OPT_BOOL('\0', "delete", &delete_mode,
@@ -1543,6 +1545,8 @@ static int set_url(int argc, const char **argv)
 
 	if (add_mode && delete_mode)
 		die(_("--add --delete doesn't make sense"));
+	if (push_mode && fetch_mode)
+		die(_("--push --fetch doesn't make sense"));
 
 	if (argc < 3 || argc > 4 || ((add_mode || delete_mode) && argc != 3))
 		usage_with_options(builtin_remote_seturl_usage, options);
@@ -1559,18 +1563,40 @@ static int set_url(int argc, const char **argv)
 	if (!remote_is_configured(remote, 1))
 		die(_("No such remote '%s'"), remotename);
 
+	/*
+	 * If add_mode, we will be appending to remote.*.url so we shouldn't move the urls over.
+	 * If pushurls exist, we don't need to move the urls over to pushurl.
+	 */
+	move_fetch_to_push = fetch_mode && !add_mode && !remote->pushurl_nr;
+
 	if (push_mode) {
 		strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
 		urlset = remote->pushurl;
 		urlset_nr = remote->pushurl_nr;
 	} else {
+		if (move_fetch_to_push) {
+			strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
+			for (i = 0; i < remote->url_nr; i++) {
+				git_config_set_multivar(name_buf.buf, remote->url[i],
+						"^$", 0);
+			}
+			strbuf_reset(&name_buf);
+		}
+
 		strbuf_addf(&name_buf, "remote.%s.url", remotename);
 		urlset = remote->url;
 		urlset_nr = remote->url_nr;
 	}
 
+	/* Empty fetch URLs if they are being replaced */
+	if (move_fetch_to_push) {
+		for (i = 0; i < remote->url_nr; i++) {
+			git_config_set_multivar(name_buf.buf, NULL, remote->url[i], 1);
+		}
+	}
+
 	/* Special cases that add new entry. */
-	if ((!oldurl && !delete_mode) || add_mode) {
+	if ((!oldurl && !delete_mode) || move_fetch_to_push || add_mode) {
 		if (add_mode)
 			git_config_set_multivar(name_buf.buf, newurl,
 						       "^$", 0);
-- 
2.19.1.542.gc4df23f79.dirty

