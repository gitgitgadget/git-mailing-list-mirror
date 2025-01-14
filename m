Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66E2309A6
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820934; cv=none; b=I1LlZpVf4NlH4cY291cg/9vsgm/hmpfWyCjtvPb687nbCW00sr7cV4JTobXUTXODVsdJBCJwL0W/fuRGduj3hERLB5qmbwXXW2uQMZ2GMFJi2mbYDQmiTgwdeI1RHzOuHJYW3VLRHFex+OgAWPuKrPo0OqPnKwrEfrt60WTe8xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820934; c=relaxed/simple;
	bh=TKeW403SYch7/jwTdE0FvvYa/b/yhmiSoma1i7aYmpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIDbK0OZD5N1sg++jlv3w66KgsynitNjAzZ4yeV5ZWzvGk77dmHhBdAJyV9wAgrBvQYUW77H2wqbryGXxb8NgkUuKcLKCp1gMhi8Ai4hAsM1pPA28fW48isx9REc4JjxggwZI5h6hgQ4expjnrO4NcG7JWJeB+GGUApC9+IOw7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UinajRWf; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UinajRWf"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4679eacf25cso34379251cf.3
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 18:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736820931; x=1737425731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ5QIlB3zqVmw9f06PPifm9yITGcgL0SCiC8QIzL+Hw=;
        b=UinajRWf2NaHZXx2xUxgxg6e06gom3ZyIwyyyVQzC5IYWbBbNkYOgNTRuaI1MpH5H/
         kNMiGWZSs376YpLj+KD6rzoHZTw5FFYMjFsUIGCcPvw7+DcG14SWQr2Va/N6xWA02AV7
         iByrlsr/a333vVrSWAx1QqI8M94A5WttbwfoVktadNxsEKGEhppRbNxV6pyJER0k0JBv
         RRmSg01g6AG6sCmke6zozoY8XCI3Xuya3sPb/EfET8uzj4Mqq0K461ilrkUJrWuMngmb
         pYcqmnn+0ee7xKgSi553poqHDJu+tIeT2QM0QMyN6Tl8gvNdtCIsjJ8nj8e19qF28ttU
         fvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736820931; x=1737425731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQ5QIlB3zqVmw9f06PPifm9yITGcgL0SCiC8QIzL+Hw=;
        b=ETjazrAP1XGT1rJETKkXU8E4fGz+n1VQa13MM/Eu0ZMI0N5mDtYQ7c/0li6eMEZMmE
         OQM+S/XwiXd6wuxEHm1ssL7y6xGLIwOMCZCpm+kmpVKSRFYlzNGioThzUzZu1bxa6QLI
         ahoLW3CmQnxD56dFuI5gaLJXIkQo+UwpCrb0ujp0KXioi9903R3y9X//FYUoKugienwp
         ZbUm/g0nxd0e7PbFd2eI2wJmNCpvBbIq4mjW7Siqln3t8DjsJ7a5VbPT1UAJ1PFLuHMh
         HN1RKPSRKWT8AGZATISWL+PsiREF2WOaw3orJHna1CtQY2AmWuFHd6iCzhS1SbrB3bew
         9e0g==
X-Gm-Message-State: AOJu0Yx/Exk9NEoxk4at0VlDPWYHXpj1KYfE9cnX+lmLzFUunSVj/oa6
	kPSmYWtsZVQDNw5KdUo+o4zUm/VQm4fKsSLhGca70Vkisa5aqEbDzAvv/u8V/fA=
X-Gm-Gg: ASbGncsQ29QZ7fFLTkRNXXbl4p3eXFzwq+S+d4mnluFlmVqUslRCCUC09l2VMLbehMj
	LNjnpxQmKfssMEs4a1zhh3Lonh/baOpU4cI6TEMuu95GWzHJ1ejwZURj2KW6uaWLVNR0ODJk15U
	3Hwy5yGqdyzZgJUK8bM2OWr7d8hxvy8KWxlnl3w8o2G1e4i4/y0HFiBkC4I7sPiEuKG1/XPdxDY
	78bq5dByiiz9OozgkcVxAfgzBwrZEEgevb48JOXAjzBsFD2wlVIrzy2qlv4MxpPKGMGdek93gt4
	2AhQ9fc=
X-Google-Smtp-Source: AGHT+IGts187wPbLsFnx+4rIaQSaBcNOmtM64b3iM78u8D8qFepiGYXTBNZfJdFg2/ioM9n7XzxTkw==
X-Received: by 2002:a05:622a:144e:b0:467:81ef:1953 with SMTP id d75a77b69052e-46c71079ec7mr297522241cf.7.1736820929976;
        Mon, 13 Jan 2025 18:15:29 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c8734072bsm47572221cf.33.2025.01.13.18.15.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:15:29 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v10 4/8] fetch-pack: refactor packet writing
Date: Mon, 13 Jan 2025 21:14:56 -0500
Message-ID: <20250114021502.41499-5-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114021502.41499-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250114021502.41499-1-eric.peijian@gmail.com>
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
index 10fad43e98..d89591f043 100644
--- a/connect.c
+++ b/connect.c
@@ -689,6 +689,40 @@ int server_supports(const char *feature)
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
index f5a63f12cd..78e7d38c47 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1317,37 +1317,6 @@ static int add_haves(struct fetch_negotiator *negotiator,
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
@@ -1358,7 +1327,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2186,7 +2155,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, "fetch", server_options);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-- 
2.47.1

