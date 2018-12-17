Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93531F405
	for <e@80x24.org>; Mon, 17 Dec 2018 22:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbeLQWlJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 17:41:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45717 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeLQWlI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 17:41:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so13771872wrr.12
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 14:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmPR5RI9HWW3UWfWbpBrlr6Z1MuUnA7PG0jrOVzdn1s=;
        b=HGzo8GvAoAUhTdgJEQLCohVzSQfghrCWec5yVBf8Q14WHEfZc+mQPkfP72AMzCw78d
         Xv6A1oy1m5v7nYRI0fCrdHxBaXp0eJu0ERJHtx2mW1VQ1JOVu1JnhWWLEe8pv+G9mc5d
         Am4lx1NQfCjq5ijo0XwiPnkupU9UXdx8BdBe6AYCURs6fsdW1pnVg0pHKcZwgjjtkm6n
         7vzsbOZwaQpsnkMw/DZXfHVxnXhOTs1jdz4/6PQUIKurcn13CqexZl3YfLGe8dFrtK3+
         RpKn1mEqhYLsPbA160HYeLWopXXWZnCqmIgArQfWWQOrrAH68ZDduNYTjhArRRPpvlUl
         MaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmPR5RI9HWW3UWfWbpBrlr6Z1MuUnA7PG0jrOVzdn1s=;
        b=pk7AKuPwlwokZwmL9KPFJ1Z70dv/5CxgxByYybGg1ZOcY9bKyy3+I6QPRurTHDoTAa
         1vYkwqPGnnnYaVgYzFyn3g7eicTtWXM24zMGDMIExz1HiuNhbeiQDZWv3SMv+VNFdlaq
         KcAtImToDseHuCk4MIthJMiB2qWGpuljBhy+VBo0aHqL+y3Pk5kGwX0I9uOf+U3AdHbQ
         oYBT1GL10dBiXMCy6uCkAwmsPwZRt+7jW28g5xq8J6pL5fcXGzp0YhvFTNm4LNPeX+M/
         RDfn24sMgH+8Gzi36WDuTjiEbMy6BtRXJpz7gXz1SGAURDoPoyQuEqhajretD3a+UNTd
         R24Q==
X-Gm-Message-State: AA+aEWYWuGOtxhtn58MnBny2JaYsdoKy9O/UvtaDRFjPbTyWh/F5Rv31
        TWzrx6p3HQ7/azShO5p1Ku/1wdnV/ow=
X-Google-Smtp-Source: AFSGD/XjGnzxtkKD90fUrCUIyzvUt5k/hrZVBx40ysEyi1FIBYMTePvFYvXJtoCWxgp2zcPZ0iKw6Q==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr6787130wro.29.1545086466038;
        Mon, 17 Dec 2018 14:41:06 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm2208199wre.64.2018.12.17.14.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 14:41:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/4] serve: pass "config context" through to individual commands
Date:   Mon, 17 Dec 2018 23:40:51 +0100
Message-Id: <20181217224054.4376-2-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181213155817.27666-1-avarab@gmail.com>
References: <20181213155817.27666-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In protocol v2, instead of just running "upload-pack", we have a generic
"serve" loop which runs command requests from the client. What used to
be "upload-pack" is now generally split into two operations: "ls-refs"
and "fetch". The latter knows it must respect uploadpack.* config, but
the former is not actually specific to a fetch operation (we do not yet
do v2 receive-pack, but eventually we may, and ls-refs would support
both operations).

However, ls-refs does need to know which operation we're performing, in
order to read the correct config (e.g., uploadpack.hiderefs versus
receive.hiderefs; we don't read _either_ right now, but this is the
first step to fixing that).

In the generic "git-serve" program, we don't have that information. But
in the protocol as it is actually used by clients, the client still asks
to run "git-upload-pack", and then issues an "ls-refs" from there. So we
_do_ know at that point that "uploadpack" is the right config context.
This patch teaches the protocol v2 "serve" code to pass that context
through to the individual commands (a future patch will teach ls-refs to
actually use it).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/upload-pack.c | 1 +
 ls-refs.c             | 4 +++-
 ls-refs.h             | 3 ++-
 serve.c               | 9 +++++----
 serve.h               | 7 +++++++
 upload-pack.c         | 4 ++--
 upload-pack.h         | 4 ++--
 7 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 42dc4da5a1f..67192cfa9e9 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -52,6 +52,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	case protocol_v2:
 		serve_opts.advertise_capabilities = opts.advertise_refs;
 		serve_opts.stateless_rpc = opts.stateless_rpc;
+		serve_opts.config_context = "uploadpack";
 		serve(&serve_opts);
 		break;
 	case protocol_v1:
diff --git a/ls-refs.c b/ls-refs.c
index a06f12eca8d..e8e31475f06 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -69,7 +69,9 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-int ls_refs(struct repository *r, struct argv_array *keys,
+int ls_refs(struct repository *r,
+	    const char *config_section,
+	    struct argv_array *keys,
 	    struct packet_reader *request)
 {
 	struct ls_refs_data data;
diff --git a/ls-refs.h b/ls-refs.h
index b62877e8dad..da26fc9824d 100644
--- a/ls-refs.h
+++ b/ls-refs.h
@@ -4,7 +4,8 @@
 struct repository;
 struct argv_array;
 struct packet_reader;
-extern int ls_refs(struct repository *r, struct argv_array *keys,
+extern int ls_refs(struct repository *r, const char *config_context,
+		   struct argv_array *keys,
 		   struct packet_reader *request);
 
 #endif /* LS_REFS_H */
diff --git a/serve.c b/serve.c
index bda085f09c8..70f89cf0d98 100644
--- a/serve.c
+++ b/serve.c
@@ -48,6 +48,7 @@ struct protocol_capability {
 	 * This field should be NULL for capabilities which are not commands.
 	 */
 	int (*command)(struct repository *r,
+		       const char *config_context,
 		       struct argv_array *keys,
 		       struct packet_reader *request);
 };
@@ -158,7 +159,7 @@ enum request_state {
 	PROCESS_REQUEST_DONE,
 };
 
-static int process_request(void)
+static int process_request(struct serve_options *opts)
 {
 	enum request_state state = PROCESS_REQUEST_KEYS;
 	struct packet_reader reader;
@@ -222,7 +223,7 @@ static int process_request(void)
 	if (!command)
 		die("no command requested");
 
-	command->command(the_repository, &keys, &reader);
+	command->command(the_repository, opts->config_context, &keys, &reader);
 
 	argv_array_clear(&keys);
 	return 0;
@@ -249,10 +250,10 @@ void serve(struct serve_options *options)
 	 * a single request/response exchange
 	 */
 	if (options->stateless_rpc) {
-		process_request();
+		process_request(options);
 	} else {
 		for (;;)
-			if (process_request())
+			if (process_request(options))
 				break;
 	}
 }
diff --git a/serve.h b/serve.h
index fe65ba9f469..d527224cbb1 100644
--- a/serve.h
+++ b/serve.h
@@ -8,6 +8,13 @@ extern int has_capability(const struct argv_array *keys, const char *capability,
 struct serve_options {
 	unsigned advertise_capabilities;
 	unsigned stateless_rpc;
+
+	/*
+	 * Some operations may need to know the context when looking up config;
+	 * e.g., set this to "uploadpack" to respect "uploadpack.hiderefs" (as
+	 * opposed to "receive.hiderefs").
+	 */
+	const char *config_context;
 };
 #define SERVE_OPTIONS_INIT { 0 }
 extern void serve(struct serve_options *options);
diff --git a/upload-pack.c b/upload-pack.c
index 5e81f1ff24f..914bbb40bcd 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1413,8 +1413,8 @@ enum fetch_state {
 	FETCH_DONE,
 };
 
-int upload_pack_v2(struct repository *r, struct argv_array *keys,
-		   struct packet_reader *request)
+int upload_pack_v2(struct repository *r, const char *config_context,
+		   struct argv_array *keys, struct packet_reader *request)
 {
 	enum fetch_state state = FETCH_PROCESS_ARGS;
 	struct upload_pack_data data;
diff --git a/upload-pack.h b/upload-pack.h
index cab2178796a..2a9f51197c4 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -13,8 +13,8 @@ void upload_pack(struct upload_pack_options *options);
 struct repository;
 struct argv_array;
 struct packet_reader;
-extern int upload_pack_v2(struct repository *r, struct argv_array *keys,
-			  struct packet_reader *request);
+extern int upload_pack_v2(struct repository *r, const char *config_context,
+			  struct argv_array *keys, struct packet_reader *request);
 
 struct strbuf;
 extern int upload_pack_advertise(struct repository *r,
-- 
2.20.0.405.gbc1bbc6f85

