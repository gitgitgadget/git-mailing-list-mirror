Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F4A1885A4
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083103; cv=none; b=mLClUzDUoFwWyjugeza9DpTM09MB05WI7k7d6qoweE6ni+qTLoWPuF9JT98XvjJ9aTXa/jspgG/5ZvZOLEWoZs68G66e2tlo19QXV84+x8TMVyBMRjTw3NVNvxozypXKMDgQBH8VbR5NxwJgvjDP53vlqiCql8CuPbHLqsB59KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083103; c=relaxed/simple;
	bh=jshCky/zlmpsFNJ1TXtVnx/54IQwxCxfxWKlIX92FhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3/yzWaVUjTgh3xokpcc/gUWExLxOwTSQ6+8ylUL3QrJCm3ACfp+Pn5jl59brOhFfk5NAgqRncqBt+8NwjZMSrn3pTr47D5LvpHwelXkv41Qa7ylDBKj3Twh9+V2JXneuL9znxLdMQ7KJB+xg41/v0g4Jcm40AgHZuBcAmM5NFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtj17B0I; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtj17B0I"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460c316fc37so14307751cf.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 08:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731083100; x=1731687900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7MVXs0gxtCtxujZsstp9c+aL+ldmxTsu5jXCqlAKKI=;
        b=dtj17B0IwiiBGSO//oRPNzV8D7cjYaU37AWDwv1RVKTK62iU+TOt6gr/rHWccZkQSc
         bimqZAB+Z4v1oqM4HWiRI77ptrIfnsPzOORVRlvziSSG8LUH5jDBFTqNfUri5YYKDrQK
         y4P7nG+byz8UZnmsN75Vzls8lsXu1chG2peX5INqA58MLEhPTyaHdCLMK5V06k2u/cIQ
         U2zL41OdHbkJd3oxbqpbtuTlpBSVV24chZ04pMgk7iVlxDApdKYU4yZ+5Ihe+uqV9sdh
         9lVUnXxlqQaAjKGDsLVS95yD6Aa+oC4ZQvfzE2/tJgdsWbZ0Flcfsd67L7MbtXj+Pojt
         O2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731083100; x=1731687900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7MVXs0gxtCtxujZsstp9c+aL+ldmxTsu5jXCqlAKKI=;
        b=c8R3QzioLU2TpamEZ9dd2eUQriSao7GeBI4omNaBKq1FtpMgG6PzO1eabXr3sUCIEo
         owoWYlgF6IL8a6CofCveni+yfar8wBe60EvyqT07ce+iplvecCDAJNjM1usdIifKdRxP
         VVMK4hQ8QGgS9HCCn/c/4RgxZ1714AuoUrGnJdMgAv+t32Jxqd1eImSaYlPuuHRz0dfc
         AtbpypxcOSCPQjsbYlzE/8AQ1cR9hFoKF5gkr6ITNZ55Dq17Sv2mUs9lUuIW+w3AmfVJ
         Ky3r7iDSCS3dZnPODk0QYVze+zI6X4SbsAZlUBOnT5ZY14dh58RIilim1EnzV9PWp46D
         cpzg==
X-Gm-Message-State: AOJu0YxJPkOdJ/BI61J86JWLJLgWBUrphD5kUHw3B2zvNac2RPadm8d9
	7xRjeStxgbh1c+mOFoU+M881kiWnKUgauio6tc7ED5/xuE/97RhGiFjilVk+
X-Google-Smtp-Source: AGHT+IGQ2xhnOY51WU+4PMAjRrYBRz5/Irya2jWZRPof8yg+/pWaEgvu0dUjSXadrMREQ/Qx4DXlHQ==
X-Received: by 2002:ac8:7fca:0:b0:45d:7ebd:76e0 with SMTP id d75a77b69052e-463093fe069mr34320121cf.44.1731083100293;
        Fri, 08 Nov 2024 08:25:00 -0800 (PST)
Received: from localhost.localdomain ([174.95.142.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3ef11esm21928711cf.15.2024.11.08.08.24.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 08 Nov 2024 08:24:59 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v6 2/6] fetch-pack: refactor packet writing
Date: Fri,  8 Nov 2024 11:24:37 -0500
Message-ID: <20241108162441.50736-3-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108162441.50736-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241108162441.50736-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

Refactor write_fetch_command_and_capabilities() to a more
general-purpose function, write_command_and_capabilities(), enabling it
to serve both fetch and additional commands.

In this context, "command" refers to the "operations" supported by
Git's wire protocol https://git-scm.com/docs/protocol-v2, such as a Git
subcommand (e.g., git-fetch(1)) or a server-side operation like
"object-info" as implemented in commit a2ba162c
(object-info: support for retrieving object info, 2021-04-20).

Furthermore, write_command_and_capabilities() is moved to connect.c,
making it accessible to additional commands in the future.

To move write_command_and_capabilities() to connect.c, we need to
adjust how `advertise_sid` is managed. Previously,
in fetch_pack.c, `advertise_sid` was a static variable, modified using
git_config_get_bool().

In connect.c, we now initialize `advertise_sid` at the beginning by
directly using git_config_get_bool(). This change is safe because:

In the original fetch-pack.c code, there are only two places that
write `advertise_sid` :
1. In function do_fetch_pack:
        if (!server_supports("session-id"))
                advertise_sid = 0;
2. In function fetch_pack_config():
        git_config_get_bool("transfer.advertisesid", &advertise_sid);

About 1, since do_fetch_pack() is only relevant for protocol v1, this
assignment can be ignored in our refactor, as
write_command_and_capabilities() is only used in protocol v2.

About 2, git_config_get_bool() is from config.h and it is an out-of-box
dependency of connect.c, so we can reuse it directly.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 connect.c    | 34 ++++++++++++++++++++++++++++++++++
 connect.h    |  4 ++++
 fetch-pack.c | 35 ++---------------------------------
 3 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/connect.c b/connect.c
index 58f53d8dcb..5dd544335c 100644
--- a/connect.c
+++ b/connect.c
@@ -688,6 +688,40 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options)
+{
+	const char *hash_name;
+	int advertise_sid;
+
+	git_config_get_bool("transfer.advertisesid", &advertise_sid);
+
+	ensure_server_supports_v2(command);
+	packet_buf_write(req_buf, "command=%s", command);
+	if (server_supports_v2("agent"))
+		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
+	if (advertise_sid && server_supports_v2("session-id"))
+		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
+	if (server_options && server_options->nr) {
+		ensure_server_supports_v2("server-option");
+		for (int i = 0; i < server_options->nr; i++)
+			packet_buf_write(req_buf, "server-option=%s",
+					 server_options->items[i].string);
+	}
+
+	if (server_feature_v2("object-format", &hash_name)) {
+		const int hash_algo = hash_algo_by_name(hash_name);
+		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
+			die(_("mismatched algorithms: client %s; server %s"),
+				the_hash_algo->name, hash_name);
+		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
+	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
+		die(_("the server does not support algorithm '%s'"),
+			the_hash_algo->name);
+	}
+	packet_buf_delim(req_buf);
+}
+
 enum protocol {
 	PROTO_LOCAL = 1,
 	PROTO_FILE,
diff --git a/connect.h b/connect.h
index 1645126c17..04043cd66d 100644
--- a/connect.h
+++ b/connect.h
@@ -1,6 +1,7 @@
 #ifndef CONNECT_H
 #define CONNECT_H
 
+#include "string-list.h"
 #include "protocol.h"
 
 #define CONNECT_VERBOSE       (1u << 0)
@@ -30,4 +31,7 @@ void check_stateless_delimiter(int stateless_rpc,
 			       struct packet_reader *reader,
 			       const char *error);
 
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options);
+
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 3699cf9945..533fb76f95 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1314,37 +1314,6 @@ static int add_haves(struct fetch_negotiator *negotiator,
 	return haves_added;
 }
 
-static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-						 const struct string_list *server_options)
-{
-	const char *hash_name;
-
-	ensure_server_supports_v2("fetch");
-	packet_buf_write(req_buf, "command=fetch");
-	if (server_supports_v2("agent"))
-		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
-	if (advertise_sid && server_supports_v2("session-id"))
-		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
-	if (server_options && server_options->nr) {
-		ensure_server_supports_v2("server-option");
-		for (int i = 0; i < server_options->nr; i++)
-			packet_buf_write(req_buf, "server-option=%s",
-					 server_options->items[i].string);
-	}
-
-	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
-		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
-			die(_("mismatched algorithms: client %s; server %s"),
-			    the_hash_algo->name, hash_name);
-		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
-	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
-		die(_("the server does not support algorithm '%s'"),
-		    the_hash_algo->name);
-	}
-	packet_buf_delim(req_buf);
-}
-
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
@@ -1355,7 +1324,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2173,7 +2142,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, "fetch", server_options);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-- 
2.47.0

