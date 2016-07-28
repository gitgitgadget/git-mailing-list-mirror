Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4E81F955
	for <e@80x24.org>; Thu, 28 Jul 2016 16:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758928AbcG1QD0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:03:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35397 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759056AbcG1QDO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 12:03:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so11836725wmg.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 09:03:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aqFp/ki4BR7kVWV5oF6mmuyl//LcR2O7wk/g7FZ2h/k=;
        b=mezKNswfm4rAjJucJz0AYqMHNxSB0J6EFjdQbl5NORyopyZmBtw8pJBVikQ/PxyuUL
         zKuem/reguN8ryysFS5SbOdqo9mugYLhiUp2kXVv1ZF2qEY4tVYxudbvStyHgD7GN7ea
         Y7l2xo5H9nOjSeUD/yZ2+Wd/kfCz8jvhm2PG32xSZqZY/6oRiBuX7lAyQGmtbr2Dmkwg
         9ao3kzKretVE2x6ny3mPjwf3bmrWZqTr7peSmPGLbPfPXrkMQlFhSOQJi7WbwSm1pfHC
         KfftQ1gcpGGyKV6u7d0/v7rogskWZOghjeG+TZsXhkoIFd8fMsy5a/rx4hrHqIv4Uhl+
         muSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aqFp/ki4BR7kVWV5oF6mmuyl//LcR2O7wk/g7FZ2h/k=;
        b=ErlQdOAk6oaJ0oK7GvjR2GoS2urk3W49KSqSFHBTL6G5Osr+sv0Qrngqd+XbRDRWiv
         pha/rapLcZKvZTQ5j3EpUcv8tDBsItarijYXA18cX35lwMRAz5C5dV7dEStSdMZFjOE0
         NOtu1Iw2awiqo0v9JDpSjE7OaQ049ZZuutsLaqu1KidYd9l6T6A8WFZx2gj3RjfQlRAt
         DaJIbWflYLS3GtfJ+RoEaJrQRJBJvWeqLwXzYMKYFpA2nptkYn6E17AzCJ8v0nol5Ixg
         jKlaTGRba3tvtPKf8drReMFag0iNc7R4g50jArKjdMJOTfG9tjaoErnaxFNjXFCbEOle
         44kQ==
X-Gm-Message-State: AEkooutO4nsD7uSnIjXVX9AnPa4sVrTHN7wR+ZwSOiFrEbTcXnrMSu4QbWYk2kvSkbv06w==
X-Received: by 10.194.221.134 with SMTP id qe6mr34552714wjc.165.1469721792800;
        Thu, 28 Jul 2016 09:03:12 -0700 (PDT)
Received: from localhost.localdomain (p54A20961.dip0.t-ipconnect.de. [84.162.9.97])
        by smtp.gmail.com with ESMTPSA id ka6sm12118232wjb.38.2016.07.28.09.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 09:03:11 -0700 (PDT)
From:	Robin Ruede <r.ruede@gmail.com>
To:	git@vger.kernel.org
Cc:	Robin Ruede <r.ruede@gmail.com>
Subject: [PATCH/RFC 7/7] remote-curl: add sparse prefix
Date:	Thu, 28 Jul 2016 18:02:26 +0200
Message-Id: <20160728160226.24018-8-r.ruede@gmail.com>
X-Mailer: git-send-email 2.9.2.472.g105ab30
In-Reply-To: <20160728160226.24018-1-r.ruede@gmail.com>
References: <20160728160226.24018-1-r.ruede@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Robin Ruede <r.ruede@gmail.com>
---
 remote-curl.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index e181e62..b9f7cf1 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -20,6 +20,7 @@ static struct strbuf url = STRBUF_INIT;
 struct options {
 	int verbosity;
 	unsigned long depth;
+	const char *sparse_prefix;
 	unsigned progress : 1,
 		check_self_contained_and_connected : 1,
 		cloning : 1,
@@ -60,6 +61,10 @@ static int set_option(const char *name, const char *value)
 		options.depth = v;
 		return 0;
 	}
+	else if (!strcmp(name, "sparse-prefix")) {
+		options.sparse_prefix = xstrdup(value);
+		return 0;
+	}
 	else if (!strcmp(name, "followtags")) {
 		if (!strcmp(value, "true"))
 			options.followtags = 1;
@@ -754,8 +759,9 @@ static int fetch_git(struct discovery *heads,
 	struct rpc_state rpc;
 	struct strbuf preamble = STRBUF_INIT;
 	char *depth_arg = NULL;
+	char *sparse_arg = NULL;
 	int argc = 0, i, err;
-	const char *argv[17];
+	const char *argv[19];
 
 	argv[argc++] = "fetch-pack";
 	argv[argc++] = "--stateless-rpc";
@@ -783,6 +789,12 @@ static int fetch_git(struct discovery *heads,
 		depth_arg = strbuf_detach(&buf, NULL);
 		argv[argc++] = depth_arg;
 	}
+	if (options.sparse_prefix) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "--sparse-prefix=%s", options.sparse_prefix);
+		sparse_arg = strbuf_detach(&buf, NULL);
+		argv[argc++] = sparse_arg;
+	}
 	argv[argc++] = url.buf;
 	argv[argc++] = NULL;
 
@@ -807,6 +819,7 @@ static int fetch_git(struct discovery *heads,
 	strbuf_release(&rpc.result);
 	strbuf_release(&preamble);
 	free(depth_arg);
+	free(sparse_arg);
 	return err;
 }
 
-- 
2.9.1.283.g3ca5b4c.dirty

