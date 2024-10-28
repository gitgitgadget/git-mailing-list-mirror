Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CC61E04B8
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147722; cv=none; b=fLwHqO1y2LLzIgB3R1e+VRtdmKToiLnoNaUfT6AxGVDLSjDhGg/zFPPnYIj9f+VsKaGRos+QHJ3cno7Mlg4Ljj7Pj3b3bSIJSr5/VgvStcpNc5WiuICAxRDXJYa5J/m/QhWJCARvf7Nkfffor2vT3KuQJfn4OGkoHiI/8DA69T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147722; c=relaxed/simple;
	bh=D8wqdm4BLbtyhYoTPlFPcB9KHfCUgoe2JolJ7Bn7cvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeCZIngaY3YRzIIhbNod3ybjGSDiwbuyu2xb4RnNKaa2Ybh9rX1FEMz9QJECqSu9TN7OCJBli+4c8WRlHV16UnQBzqk8UaYQ4Rhn2QkbH5bShz3CXdDEDH43skYoIRvwOfz/owViDv2WCOS2Dg+jOhUbWEffINX8SWCti357hlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3fogR77; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3fogR77"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460d1145cd8so39057391cf.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730147717; x=1730752517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jenA9nffZLeofPCg+6OUxAoi32evtcfhSrI7JvAoz/s=;
        b=a3fogR77rpfSkfywIUX3lJbpM/lmS3bj0Ue4by+P4XDOGsXdPtIVlDqYtTu2Qo24OX
         dtb6GiR23GvMcgx2/W8XZmINDHxExkSyJak2muD7hZ2Jjjr8AOfx1Qi/cpWnKAIpoiNe
         ZQyhWmfOnDFOlzwgpsNuk4R6fEpMxaJXAw/GmO35tliHvvN8FAtV1I87DKnR3t1tSEpt
         rgp6DPW1SjCLCoF2bnw2sN/NpQ26y+/0X8iCrHaLbodQLjBjj3a+rMZLrG1mLepfrQ5Z
         BEIRC/iMBC8IGBl7TDROi+1UtoHLu0ZYu3Ltp8/NarjO7ZjUCTXIM/eYTjvyT34Gult4
         Ibiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730147717; x=1730752517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jenA9nffZLeofPCg+6OUxAoi32evtcfhSrI7JvAoz/s=;
        b=Tzmy/+YbFrQixTQ0ZQdzFw3bST2j/OCNqpE4vUGnMZMjt9Lz6MFKbYfUcWF//4Ot8U
         R+fdJh1lbWKXW7zmmGe9dF1T+XECCTS7IiImkF7M7U2jY8f3W6LgmnzYMrr6FGiMRsHe
         HsUSZx+++xFg9WWyQSaHmnAhIIH6MXNlXgJhwu3dNKeLZecpi0ZJoaxPBxd3nb3/hQQ9
         fGjX+ti94qgfRKy8XKYtAYX+LfY6nB+Fr0PDbzjdKc9CfPlBM5a8jkCs80PRTMH+MyXu
         9MdQ8Ll6CVMBcNzIwPyQGcSGkiVAbJN3X+FOHepi32pwOSLaVjU1pNyFstPpZYCLbeQ4
         C8xQ==
X-Gm-Message-State: AOJu0YyuNWFWZtCBFDe6+sc21bZ509eSL43WdUn1M9BNOcyiz5oB3lfn
	LzEn6FJ0Jc8kcGhJyWhyqvgmruih8PmonpT1oUQlcOEwgUhSlnXVIg9kXFrM
X-Google-Smtp-Source: AGHT+IExNeTfTfjBJR+eV1BwlIvfniWOXlJnMidkFfNIOd3pdak/0cF/eBWI49GzyWIO3nwRECq7fA==
X-Received: by 2002:ac8:7d13:0:b0:461:17e6:2651 with SMTP id d75a77b69052e-4613bfc96c0mr132474321cf.8.1730147717437;
        Mon, 28 Oct 2024 13:35:17 -0700 (PDT)
Received: from localhost.localdomain ([184.147.230.152])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613228c099sm38215791cf.46.2024.10.28.13.35.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Oct 2024 13:35:16 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v5 1/6] fetch-pack: refactor packet writing
Date: Mon, 28 Oct 2024 16:34:52 -0400
Message-ID: <20241028203457.19715-2-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028203457.19715-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241028203457.19715-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

Refactor write_fetch_command_and_capabilities() to be a more general
purpose function write_command_and_capabilities(), so that it can be
used by both fetch and future commands.

Here "command" means the "operations" supported by Git’s wire protocol
https://git-scm.com/docs/protocol-v2. An example would be a
git's subcommand, such as git-fetch(1); or an operation supported by
the server side such as "object-info" implemented in "a2ba162cda
(object-info: support for retrieving object info, 2021-04-20)".

The new write_command_and_capabilities() function is also moved to
connect.c, so that it becomes accessible to other commands.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 connect.c    | 34 ++++++++++++++++++++++++++++++++++
 connect.h    |  4 ++++
 fetch-pack.c | 36 ++----------------------------------
 3 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/connect.c b/connect.c
index 58f53d8dcb..bb4e4eec44 100644
--- a/connect.c
+++ b/connect.c
@@ -688,6 +688,40 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+									const struct string_list *server_options)
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
index 1645126c17..2ed009066e 100644
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
+									const struct string_list *server_options);
+
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index f752da93a8..533fb76f95 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1314,38 +1314,6 @@ static int add_haves(struct fetch_negotiator *negotiator,
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
-		int i;
-		ensure_server_supports_v2("server-option");
-		for (i = 0; i < server_options->nr; i++)
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
@@ -1356,7 +1324,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2174,7 +2142,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, "fetch", server_options);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-- 
2.47.0

