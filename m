Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D8720954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbdLDX7r (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:47 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46564 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbdLDX7V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:21 -0500
Received: by mail-pf0-f193.google.com with SMTP id c204so9799690pfc.13
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BYaNMysXXeGUOgvxY8SH4+vGzqxwEJOcB3BnZHypjMU=;
        b=o0azztOe5Bw9LKzfff+FBjNHskDYV+eS1XtucmRdxeh31X62kFYA6IwmrkCgxUPMVk
         9dku6HDTN5cU1Gp/zs4JIEG+gu+Q1j9ecOdzliXlR6oJ98VXXCE6WLs2qy5Yh5dHEsI0
         rcB4ahKYjuTfDvUL4mRZJJmWNLF9WYPvGjHKyl6vkK3Mb+2fmHbx6Jz3dK1SRXQaNPbi
         aTNGWjUYyjP0jDmqu3pBvujEycR7UveAeZvTe2PrlonMVXTAKNSI1uPxSGsZcYj1BL2W
         LIOjenaVUI5i4iOuqA6fb7x+XxJ2++sjvC01QfBzWvPqaSBTNsiZyx5211tcecuX+F0Z
         rtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BYaNMysXXeGUOgvxY8SH4+vGzqxwEJOcB3BnZHypjMU=;
        b=JlfdQMr0ERRLNOQk09umnLRy0rfwF1UimLV6qLTAVzptxOiCj1UlAMVmhtMG+gZpwl
         O/W2s85LEKsSvfVoyFpr2hv4MfdLjHccYHzl/XstcHeTiCfDgT7jY59vr6jWa114+Asr
         6lJvn8Bh6+GYGU680cOy8GV9f9xABFoeuNibsduXa3+xN5K/tH8Y7flSwxAqlzW4rRUS
         KL07RnjZgisUGCnq8vi+CQIpsjgSJqnXf4b9HZI8nuiad/hqpoFRjz6quF/ygqZrmkCi
         ZkyYe7WE3LeRrzuMnCvqGZSGl4H9Ce619Bk8s8LzPpJSKyrd+8avrK3rb+gvr7p+iZpo
         6Wyg==
X-Gm-Message-State: AJaThX5KYe7rR0lid43NzKDx3UfZqhV23vZ7pcEVhypfGlw4d3ETELw8
        LQhyUcjaKE5czr/VmQsz5HLOnIrLcVk=
X-Google-Smtp-Source: AGs4zMbpDQ3At9afh0I+ivqJMr9WXRLUofhgisDFn2V8KYDkjCTnS6xH4CwPzLexp3RS2eD14JzMhA==
X-Received: by 10.99.152.68 with SMTP id l4mr15798097pgo.208.1512431959855;
        Mon, 04 Dec 2017 15:59:19 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:18 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 10/15] protocol: introduce enum protocol_version value protocol_v2
Date:   Mon,  4 Dec 2017 15:58:18 -0800
Message-Id: <20171204235823.63299-11-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171204235823.63299-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce protocol_v2, a new value for 'enum protocol_version'.
Subsequent patches will fill in the implementation of protocol_v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch-pack.c   | 3 +++
 builtin/receive-pack.c | 3 +++
 builtin/send-pack.c    | 3 +++
 connect.c              | 3 +++
 protocol.c             | 2 ++
 protocol.h             | 1 +
 remote-curl.c          | 3 +++
 transport.c            | 9 +++++++++
 upload-pack.c          | 3 +++
 9 files changed, 30 insertions(+)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4873e9572..061c278b4 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -199,6 +199,9 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	packet_reader_init(&reader, fd[0], NULL, 0);
 
 	switch (discover_version(&reader)) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 839c1462d..4e141d521 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1965,6 +1965,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		unpack_limit = receive_unpack_limit;
 
 	switch (determine_protocol_version_server()) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 		/*
 		 * v1 is just the original protocol with a version string,
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 9c2ca80c8..9441f1eed 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -261,6 +261,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	packet_reader_init(&reader, fd[0], NULL, 0);
 
 	switch (discover_version(&reader)) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		get_remote_heads(&reader, &remote_refs, REF_NORMAL,
diff --git a/connect.c b/connect.c
index 5f7cf05c7..433f08649 100644
--- a/connect.c
+++ b/connect.c
@@ -84,6 +84,9 @@ enum protocol_version discover_version(struct packet_reader *reader)
 
 	/* Maybe process capabilities here, at least for v2 */
 	switch (version) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 		/* Read the peeked version line */
 		packet_reader_read(reader);
diff --git a/protocol.c b/protocol.c
index 43012b7eb..5e636785d 100644
--- a/protocol.c
+++ b/protocol.c
@@ -8,6 +8,8 @@ static enum protocol_version parse_protocol_version(const char *value)
 		return protocol_v0;
 	else if (!strcmp(value, "1"))
 		return protocol_v1;
+	else if (!strcmp(value, "2"))
+		return protocol_v2;
 	else
 		return protocol_unknown_version;
 }
diff --git a/protocol.h b/protocol.h
index 1b2bc94a8..2ad35e433 100644
--- a/protocol.h
+++ b/protocol.h
@@ -5,6 +5,7 @@ enum protocol_version {
 	protocol_unknown_version = -1,
 	protocol_v0 = 0,
 	protocol_v1 = 1,
+	protocol_v2 = 2,
 };
 
 /*
diff --git a/remote-curl.c b/remote-curl.c
index 74c6c3049..abb6e2ac1 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -183,6 +183,9 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 	packet_reader_init(&reader, -1, heads->buf, heads->len);
 
 	switch (discover_version(&reader)) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		get_remote_heads(&reader, &list, for_push ? REF_NORMAL : 0,
diff --git a/transport.c b/transport.c
index 4160c4167..8a3735cf5 100644
--- a/transport.c
+++ b/transport.c
@@ -201,6 +201,9 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 
 	data->version = discover_version(&reader);
 	switch (data->version) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		get_remote_heads(&reader, &refs,
@@ -248,6 +251,9 @@ static int fetch_refs_via_pack(struct transport *transport,
 		refs_tmp = get_refs_via_connect(transport, 0);
 
 	switch (data->version) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		refs = fetch_pack(&args, data->fd, data->conn,
@@ -584,6 +590,9 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 		args.push_cert = SEND_PACK_PUSH_CERT_NEVER;
 
 	switch (data->version) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		ret = send_pack(&args, data->fd, data->conn, remote_refs,
diff --git a/upload-pack.c b/upload-pack.c
index d2711e4ee..d706175e4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1105,6 +1105,9 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	git_config(upload_pack_config, NULL);
 
 	switch (determine_protocol_version_server()) {
+	case protocol_v2:
+		die("support for protocol v2 not implemented yet");
+		break;
 	case protocol_v1:
 		/*
 		 * v1 is just the original protocol with a version string,
-- 
2.15.1.424.g9478a66081-goog

