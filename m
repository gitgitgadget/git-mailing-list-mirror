Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5905320444
	for <e@80x24.org>; Wed, 11 Oct 2017 20:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbdJKUk0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 16:40:26 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34317 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdJKUk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 16:40:26 -0400
Received: by mail-qt0-f194.google.com with SMTP id y45so3985573qty.1
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=utXy1lU+ivB24FQeo3oyWv4KajyJQk/QpfGvaADMGN0=;
        b=uz1DZ0qFB8cPPx5xIyxC/vVmLwemyO51ViYiNB12plKpDlC03f4HBOAdJJRMEpRFJt
         S8/KojFO2pWzOT5S/HmUe1ybe5QAWmWGTdRdjahDOngrs4TkS1I+l5aPyma7mR7OkK4J
         MTNmrop7iVqDPxfwq2uD8Xxiv1f6QJYgpZso4m6eeaIf9UxLLMxwKyeJ0O2zmCdUtR9j
         QUj/H9Mnhsfhw0HSqBLx3azpe2HDMziXdLLgA6Jc0wDXVqMaoaZPrFPpzZSmNas5CMfq
         ZVOGg4tBxDA+BN7nxDvH3SB6Zstpq+FD7SW/43PLd48IyzI6qrRU65LhfGmlGfs0wa4o
         qH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=utXy1lU+ivB24FQeo3oyWv4KajyJQk/QpfGvaADMGN0=;
        b=D5z4ZL7sfcRLkM2tgpgM0sEGhdIVi9W66SBbYo7foY53p00HTNO8BuFrYsSG6pifUZ
         eH8zTD3HB0ZKbVjqHPFVlYahsklFH5CbkcpW1yzs3+ZbQhyvpu4JC4b4vyzOO1cC+YQk
         IngvVW9WIlbguf4i+sjMpSwmihIwWUM7Zk6vLBhqXBVyBztM9xA9MqHfpX2nDRnzlLkp
         tz+o3ZiYYzU0KlSgOMhCevsLtwft50XM+5/HKCGPI86purGfMqZj9kyt4naKDRQ0FVFO
         7iKnsNMyzI4NkXFG8H1NrFI1UQtIJkpC8UKniHLvPKWQlwWCz+XcfXaS1NJvABR2adki
         11ug==
X-Gm-Message-State: AMCzsaUa3aZ2ki4spB8aUX/X1W1UibZZvFfjLBzr2o1TS47BlJoMhcgB
        JkmnYHpKaiKH6LOTM4M76BBLsrUU
X-Google-Smtp-Source: ABhQp+RPJEaHdslX1m7dN29CRMZ2b3C2xAjoRFmSq/0mAVWlpdyBEkMcDsk5F0yShWDPt6iPGuwzRA==
X-Received: by 10.55.140.68 with SMTP id o65mr380297qkd.293.1507754425286;
        Wed, 11 Oct 2017 13:40:25 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f2:2a86:eb6c:5bd5:d213:6456:b036])
        by smtp.gmail.com with ESMTPSA id v55sm8612344qtc.66.2017.10.11.13.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 13:40:24 -0700 (PDT)
From:   "Thais D. Braz" <thais.dinizbraz@gmail.com>
To:     marius.paliga@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [PATCH][Outreachy] New git config variable to specify string that will be automatically  passed as --push-option
Date:   Wed, 11 Oct 2017 17:40:19 -0300
Message-Id: <20171011204019.11093-1-thais.dinizbraz@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0.39.g2f0e14e.dirty
In-Reply-To: <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
References: <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/git-push.txt | 3 +++
 builtin/push.c             | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3e76e99f3..e1036feaf 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -161,6 +161,9 @@ already exists on the remote side.
 	Transmit the given string to the server, which passes them to
 	the pre-receive as well as the post-receive hook. The given string
 	must not contain a NUL or LF character.
+	Can be configured using "git config push.optionDefault <option-string>".
+	After configured git push will always be executed silently
+	with --push-options <options configured>.
 
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
diff --git a/builtin/push.c b/builtin/push.c
index 2ac810422..ae3efafce 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -467,11 +467,18 @@ static int git_push_config(const char *k, const char *v, void *cb)
 {
 	int *flags = cb;
 	int status;
+	struct string_list push_options = STRING_LIST_INIT_DUP;
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
 		return status;
 
+	const struct string_list *optionsDefault = git_config_get_value_multi("push.optionDefault");
+	for (int i = 0; i < optionsDefault->nr; i++) {
+		string_list_insert(&push_options, optionsDefault->items[i].string);
+	}
+
+
 	if (!strcmp(k, "push.followtags")) {
 		if (git_config_bool(k, v))
 			*flags |= TRANSPORT_PUSH_FOLLOW_TAGS;
@@ -515,7 +522,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int push_cert = -1;
 	int rc;
 	const char *repo = NULL;	/* default repository */
-	struct string_list push_options = STRING_LIST_INIT_DUP;
+	static struct string_list push_options = STRING_LIST_INIT_DUP;
 	const struct string_list_item *item;
 
 	struct option options[] = {
-- 
2.15.0.rc0.39.g2f0e14e.dirty

