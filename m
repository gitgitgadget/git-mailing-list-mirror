Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_MIXED_ES shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C41920A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 15:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeLMP6b (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 10:58:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35791 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbeLMP6a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 10:58:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so2554485wrb.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 07:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1edgIllYJ2wnLizBgABFmxOPPXGmsOwnqOIRskQPNjQ=;
        b=NTVBHH0W2r9Z3CMsLqZWet79M6IA1wEqffs/Vv+UhiDt+vms09IxE8JxtlV/A+w6Pq
         tU5V/ZW+UUI3w2i0Jib6fkTlitwGMrPvfe5XYWQ1LgbqzdcpZKAWAohqCukQj+f4miu0
         WQfIwOpwzpTPSyggrOgmBdUHrdCCG4NffgZy1E8m1ZqEakW/lrIG0iE67soIh7qG7u25
         6Ekg1OZ0EnCGhdJpVnxq/2mHdoZitb7nZ9oBusf/ZMSt6XC+FK+jGo+/gaFr+UMrOP0T
         ySu4G7rhH+DE5jNZbC4gIuZl4qpxQUVwQtUi03NNwqG3W6M7BbJT3w//0FUUczf1DutW
         upXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1edgIllYJ2wnLizBgABFmxOPPXGmsOwnqOIRskQPNjQ=;
        b=Dc44fwn6W0KM7AIAwxbw7+4pc8XKJPsEptspRQDRc6IrJnax89IF96yk7yj2MaGLjx
         kRKNEL3RNWsO6dIYAulbZWFSUgqoYyVbk63P4YygGzDxRNxVTkn8j6RwFr/dy3rV/yh+
         kWtp+KiMZuLqnoOqqLPUaiaVyKBw/JMfCAGLKWi+oboFDDXFMnlFnH61O62sjEIMlzLG
         cBixxZoBT8NW6McpQOZegJv/kzonajckKOyqHjiHnlOpYznDWRenW4xkvyZ/1emlo+ji
         7wb3iFAOwupd9DFhEWby6wWCQw54XZ/ttZp1ksAcfzNB4zay4rlcbZiXdgSs2oy4f3zi
         +MKQ==
X-Gm-Message-State: AA+aEWanihJmFC7UnB/Y8RfIWmaV5uCweOxVBOD/oU/bPk8QfL+exdWI
        eQ+B0UlHecR41EyBssOcxptGcHl5
X-Google-Smtp-Source: AFSGD/Ufc4ulI9YuGOQocxR4vGz88etaTt6jNvuvy9PO9J7Qpl/jB4mso/GxKzDbpZkwWK/iUUsrEQ==
X-Received: by 2002:adf:a393:: with SMTP id l19mr22081728wrb.110.1544716708594;
        Thu, 13 Dec 2018 07:58:28 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r69sm4047821wmd.4.2018.12.13.07.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 07:58:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/8] serve: pass "config context" through to individual commands
Date:   Thu, 13 Dec 2018 16:58:10 +0100
Message-Id: <20181213155817.27666-2-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
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
index 42dc4da5a1..67192cfa9e 100644
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
index a06f12eca8..e8e31475f0 100644
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
index b62877e8da..da26fc9824 100644
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
index bda085f09c..70f89cf0d9 100644
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
index fe65ba9f46..d527224cbb 100644
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
index 5e81f1ff24..914bbb40bc 100644
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
index cab2178796..2a9f51197c 100644
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

