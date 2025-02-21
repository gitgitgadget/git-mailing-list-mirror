Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC3252919
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164721; cv=none; b=l+0ZN5U/SwUhz94Veal4DnDSy/53SBHyDB0vAp/YZOleENrDUhyRQlKEACEsKduEWA2jon9fzypFtHxGGXCEEboTBVSTldkrzNCDfkih1fNT0wr8yy2WnuWD22xhHb5CkD336cUlbR48zQL4GUNxd27S1wNd7FeoCYNoseuAwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164721; c=relaxed/simple;
	bh=8NtfoC1Ejc9gdK5WUTnjnxNLSGtsas42taJhWIgkjV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzavM1YZs35lUCNabRhIV39J6Kqpc7d71hxL0Z5SzTUZQLUImVX4Ddhr9m+aWVW5VsnYBseDptFJwBlrdVMbvCzmFg0ZXuQvOvyfddO9C5VFsaejDMA4z/laRtMP6nc3ILQlqScCgCXiaDqGsVzQP41UTX6kdy20tQPOHk2KeRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7XYYfy7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7XYYfy7"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471f4909650so22576631cf.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 11:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740164718; x=1740769518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nmhr4HqbL83sELewUK6bIIk1mDPnwvBASAhn/HNqTyc=;
        b=P7XYYfy7wq41RWfYyjeMMYw9M3Ofr3Yx95gl3RXo77hccUvOD+6B7cnxQCbzzq7sWz
         seEnzrZlr424mq1eBcjERQp6ls9Win/6Px6CxY7VeMBZi5pGtCH4EMBoyqSfFnclhVzq
         m13btwMVbvX822G1YGCzFV7iNe0D/fGktdffXDXX+abEAnB6Z5c0X8K4tJu2cmL38L9Q
         tPXuZuNoEYKlWjJKcDpZOq87WjaP6Z3LBvZeIQFlDund8qGC5KCSCitNzvFxPa1T54mw
         Bz0enKS5HE5Ojy0zYeec7Qe7fKdbue+qOFoZ/G1O9wiJd4MbOxdMwFjlise20d6bldIp
         pvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164718; x=1740769518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nmhr4HqbL83sELewUK6bIIk1mDPnwvBASAhn/HNqTyc=;
        b=vZUyJ2j9oAaRJXf4C4GC1KM7y2noshK7XACEpd/6oY7tPZkf5t284DsQM+fQNTPQIL
         fFPq7tQgIJYvyeAMrdOmoEuiTtefB6wlXq5WaFIg/3bmvDs6AAJuPpKD9mTmcjeQOFvS
         Hq4o1FhfgJH5m9YBfGFNIwlR6smyNh3ne4o65maShCiJEG/oYj5+ouJRK0Qwsdjlo3tS
         x37wi2atrOpI7hasaGAMWr/PGrxuGdKXMZndQXDOmHIsM78fGz2rIuPcUIPlg3tZQ6yZ
         R0IRCo9DUkhq1EcGEW75Pj2BKMYUzvEeogyFaXiLaOb7RVB0P3Ll66clWOyEFIA7ubiz
         h5Mg==
X-Gm-Message-State: AOJu0Yyi5AFt7R1bu9AwddCswN2/T0EFHuEVv2MwEb8eHUHzk180q3+Z
	e4LlWE8m74DpbkeqRTTCmqd9zvo6gaoDrYuRhCJ0Y8yeNiUa6tDh9LOl50Tx73o=
X-Gm-Gg: ASbGnct963zhsgPKBM54l46ENdoIWzoPVSI2zPDgoBf6vzxxPb00trSnY3iiTNpiI4a
	2L6E+PST6+vwsd0bs1yTJXfS3VyyboUC+MWwMaMgpWRV2r7CFJ6nfE6ZTDMo7oSwrTwDD/cB1o6
	bvuDNWdUF6cLY5Q4/WbpDPm/X7fYcl1hFy/L6h7Rd/AF3/WODDadHEm4DigMWnQl5QlP4LJYqXZ
	ahpbk0pxeWRbzDv5D8uMXVQmLgxXt9hypfO30dT5s6/XY2Uh15gAKkbpEaE5cxkNl/SUPJs6btD
	zSUiTEyEM/YPxjmV+LwoTNrKjpw6AiNR1+P3QSsRkJNr79bgDT66
X-Google-Smtp-Source: AGHT+IF9sK+MlWmrMxBMOkpCF8aO/77RZ6sY6zKbVmwochblPC4OPoTHgfaJWPlT/o+2h6afSuguQQ==
X-Received: by 2002:ac8:5852:0:b0:471:f7a3:f73 with SMTP id d75a77b69052e-472228d56f0mr62964891cf.21.1740164718281;
        Fri, 21 Feb 2025 11:05:18 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720b1fe010sm32945661cf.60.2025.02.21.11.05.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 11:05:17 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v11 4/8] fetch-pack: refactor packet writing
Date: Fri, 21 Feb 2025 14:04:45 -0500
Message-ID: <20250221190451.12536-5-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221190451.12536-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250221190451.12536-1-eric.peijian@gmail.com>
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
 connect.h    |  8 ++++++++
 fetch-pack.c | 35 ++---------------------------------
 3 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/connect.c b/connect.c
index 91f3990014..6647b4a4b6 100644
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
+		for (size_t i = 0; i < server_options->nr; i++)
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
index 1645126c17..d904c73a85 100644
--- a/connect.h
+++ b/connect.h
@@ -30,4 +30,12 @@ void check_stateless_delimiter(int stateless_rpc,
 			       struct packet_reader *reader,
 			       const char *error);
 
+/*
+ * Writes a command along with the requested
+ * server capabilities/features into a request buffer.
+ */
+struct string_list;
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options);
+
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 71fb2ca054..19b4a092ea 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1319,37 +1319,6 @@ static int add_haves(struct fetch_negotiator *negotiator,
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
-		for (size_t i = 0; i < server_options->nr; i++)
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
@@ -1360,7 +1329,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2188,7 +2157,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, "fetch", server_options);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-- 
2.48.1

