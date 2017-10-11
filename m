Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A053A20444
	for <e@80x24.org>; Wed, 11 Oct 2017 20:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbdJKUZd (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 16:25:33 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:55042 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbdJKUZc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 16:25:32 -0400
Received: by mail-qt0-f194.google.com with SMTP id z19so9025430qtg.11
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=utXy1lU+ivB24FQeo3oyWv4KajyJQk/QpfGvaADMGN0=;
        b=S0UPbKy3JgIXqhVRlp3kLwjsWPYHmsJt87sFusUnsIZfCrp6eEGwB6JEObOBb1ASB/
         YEZPcC4pJ87t+/zxq93Q/s4mLR2OLuxqWaR9afXCwSVjE097E1wyQR4YuIEVHx2WSeTU
         cKcEFXo35WQGRfVEdufd/G+8c8C1iFQzNJs8ZY+ZfVau19yGxgRX8QRH1qBF+b2qZKdQ
         rAjDi/BOvBEPeH4Y9jRol+SJsXnHGYrpYgbsi5qnWt9lBVBBC3LKyb+7rQRT2DMhBsR9
         MoMwzvIhH5eiJ7QyU0ywb7taPjs8JmrsfzWlyzANUi4kSQpzYsv+uy/A4sL3mK5k45BD
         ONZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=utXy1lU+ivB24FQeo3oyWv4KajyJQk/QpfGvaADMGN0=;
        b=NrJ+m5c4yefsNIVQ3dMlZbL3ZYcWOojWqXdnkSikMqn3acuHVuDLEEjPmYmgsxFEyT
         bmosbdSDbC+MWALXjyKPPwCDEV/6RlNPnz2PgUaJXMPOL04dyuT/lf6dOTI+t48HVtQm
         3A6Lxf/s2JEtumtlOSrVPk/BqOSXpXwYXt+QzTyL1m6xnzxQdQamO5oZWdnz5iXBKbiQ
         qg21xmzKx/c0/rRQetAjSiMwVZts7J2uhPp8PHE7w8qMHy1V8t/BbRmnXF0LNDyqJfjm
         ohnKsesf0WW/+vYJxrRs49HtNDqYq58T9IntFCZtNlgmv6Bbgbt2SNSMGg9pIKhIqNKd
         hMiw==
X-Gm-Message-State: AMCzsaWpyWaJlnSALKrH1QVaybKrCKPz4B7sxBEKnmDFY3Wh+evAdzqt
        P1lLdKTwl8eWgcfrUd2i04PzmGQekNw=
X-Google-Smtp-Source: AOwi7QBtq6f0+ZnM/s6CIAs6xLVGlxIat7REMNKgwWE4gwkd0PPAytsEAMUA9HXgO7avb4IXKufyKQ==
X-Received: by 10.237.53.92 with SMTP id b28mr407478qte.280.1507753532200;
        Wed, 11 Oct 2017 13:25:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f2:2a86:eb6c:5bd5:d213:6456:b036])
        by smtp.gmail.com with ESMTPSA id m28sm4780245qtb.55.2017.10.11.13.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 13:25:31 -0700 (PDT)
From:   "Thais D. Braz" <thais.dinizbraz@gmail.com>
To:     marius.paliga@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        "Thais D. Braz" <thais.dinizbraz@gmail.com>
Subject: [PATCH][Outreachy] New git config variable to specify string that will be automatically  passed as --push-option
Date:   Wed, 11 Oct 2017 17:25:05 -0300
Message-Id: <20171011202505.10113-2-thais.dinizbraz@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0.39.g2f0e14e.dirty
In-Reply-To: <20171011202505.10113-1-thais.dinizbraz@gmail.com>
References: <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
 <20171011202505.10113-1-thais.dinizbraz@gmail.com>
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

