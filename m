Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9342931C2
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109158; cv=none; b=YExhJJ3F6mXPF/QIXtfB+0id0vFMzAUqFOZy8HF914xg94TmehEBDTfwOeWWPJWx8qMPRHltx+21SJbwUIPPqS7C5QHcDW2AwHkUVarigVv3+DIuJsf9zW1dCiQ72ovx9Lf8ZQDZK6wt1fT5F637VCm8kmXEF4uUANB5zTtnqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109158; c=relaxed/simple;
	bh=vp+uYO5Xw+05gA1ijE59mdgdHWbKDHqtG/kH/mDpA0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rG7AEGW07F415B7spY8DGfeFnOLORFmiKgOxXRf7IpqS1YX1XdeToAEOpkHAAosNDJkowany2L25S6Gaa8Il/Ei9YWghrsTclDT+NN2XmiT6w9er9MGs14f36X5OMKa7eLbpl+6YI6KUY4hRiRNHHZu8g0yaNWSS2ZW2h0G/JRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHz/uR9r; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHz/uR9r"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso44989255e9.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784109154; x=1784713954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vnxUQtuBg/crHTGOidTsObMZ67UAC2hoXWC8zCOJbIo=;
        b=cHz/uR9rdbWuYl4WD/526yVEY4zLjFdqK2TxqaZXZ3X2apxOveKoaJvtHh2rt8oGFY
         J0NsrDAvqsODjN3DpaeRfh03nU0laPWEtdlNQLC2yhJIDCf8K3sth1ZfcqhoS/BSVur+
         I66rjFL1WqZvaYtu2vv6ovL0ZtO8M8qTjqurTuy3QlN9VSVc1Z88biGZx5jxF3ZThq8/
         c6Dm/RMZ/mCrS473XGxA3sAQBrhLAzQ9tw2rydAQ1u2QedE61PtNohhgKy6I+PMw5HQO
         eXYjUkeLpWFplSQDDcJpZHK8G+QcolDRbQYENR/EZZjs0A8/7lUKyM+dkQVK+VVh8tHs
         JNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109154; x=1784713954;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vnxUQtuBg/crHTGOidTsObMZ67UAC2hoXWC8zCOJbIo=;
        b=YADM0Oh6D57CqPbdU9r7qSikYOUcbnqdcKQ+E/ox7J8BjRoUqzmE9OQgbDgQNQlZzz
         26oloy++RiEuLGnUxUFCCvqWUC6dl0GeqedjIc5VYwmrXB/unkGIej9s80A9xRiMt2II
         4YXGCJquHiWBExiCX381xKzKw/qdH3O5zrEQIxaCoaQc/k/VLjkZjFotaOXQ8RbuY6zm
         XrbJw6PhQL7bWfvGkqLY/869LKJ2xrMEULET9aYlSPQphMNGJfFzC9OQ/OFB6iG7zSVP
         euiYKMTHKIC7OyUs9cyLqylPBTqCLGdkqRs1jeyToNTEyBqe/QfbVw1RHjXXlfna7d7J
         aMWA==
X-Gm-Message-State: AOJu0Yyr2KIM2ti0yjMu4OagWXeVN3LdqA02GBBNRd9YgPd5G19EZbQ1
	Z1qzMf/OPmytMHvt+6uhWUuuoimBTrxwaXGPhf7ab5cvV5itoFKHYsWpaGEf8tDe
X-Gm-Gg: AfdE7clL7+RUNhMJJXjVb4088MpU17NYi1I3QJa1Gy8wBXMdtpOrVsnw/IHvJ4j7xHp
	ZVPJCf/5MwhJPwQx3WaasM5wQ4VVU0L1GrLFM53E/z9qbsFWTrhitiWmhREHKJGTcaAbFXo14t+
	mzrFAjIsixmN1is2a9K0ltP9k9eLEwcDmVs92MaNpY+ZyRjUjrH0p50Pxtq34mYwwOTQIuErdtG
	QXhejN5zTWmCpuCl4duHAVmE0KVf1JLJyrVs4iJW+HUhM6HeyxCuVPHKBDtN67jIgmItqkLKY4I
	4EoZqyKoBCiJVHvXcaFiquJcvaU5Wv8m+8gWDs8yan2IJUZ6n6V4tx2iueu429NhalDm9gy7PrL
	Z7GkCkz8F5B+AkUw6ntgP1t5TuCsOCdJXchNOngbYxLiOsxeJCSyfNQjMrNEKocIglIfIbUl8yl
	tmz/xSxgTYypKduqq2ELz7hZoufx1wf3zZV2bhPySNxwN79cTj7EYI0520nlhJP0dKNrI8CqJuB
	XC10sjlhF8C9Ovzd0XyJGeOrg0OKZclCyH+xXuOjGrPGX1+hCk0ki3lG/iQxM/L7T+8oqTrIVJt
	GMx6AYen8xzPSxSwW6LfePc1+R17xfVbqiyqhBN8xQkwi9v8yfyTusDLSyUk0Al+aSIbnVAhzAB
	6f02xW5GKew==
X-Received: by 2002:a05:600c:474f:b0:493:f6f6:bcb1 with SMTP id 5b1f17b1804b1-49538a0bd94mr57702085e9.25.1784109154122;
        Wed, 15 Jul 2026 02:52:34 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm15630419f8f.35.2026.07.15.02.52.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 02:52:33 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Jonathan Tan <jonathantanmy@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH GSoC v18 06/13] fetch-pack: move write_fetch_command_and_capabilities() to connect.c
Date: Wed, 15 Jul 2026 11:52:14 +0200
Message-ID: <20260715-ps-eric-work-rebase-v18-6-34d7adb051bb@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

write_fetch_command_and_capabilities() is refactored in a subsequent
commit where it becomes a more general-purpose function, making it
more accessible to additional commands in the future.

Move write_fetch_command_and_capabilities() to 'connect.c', where
there are similar purpose functions.

Because string_list is only used as a pointer, use a forward
declaration [1].

[1]: https://lore.kernel.org/git/Z0RIqUAoEob8lGfM@pks.im/

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 connect.c    | 34 ++++++++++++++++++++++++++++++++++
 connect.h    |  4 ++++
 fetch-pack.c | 34 ----------------------------------
 3 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/connect.c b/connect.c
index 47e39d2a73..c09947cc56 100644
--- a/connect.c
+++ b/connect.c
@@ -700,6 +700,40 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
+void write_fetch_command_and_capabilities(struct strbuf *req_buf,
+					  const struct string_list *server_options)
+{
+	const char *hash_name;
+	int advertise_sid = 0;
+
+	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
+
+	ensure_server_supports_v2("fetch");
+	packet_buf_write(req_buf, "command=fetch");
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
+		const unsigned int hash_algo = hash_algo_by_name(hash_name);
+		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
+			die(_("mismatched algorithms: client %s; server %s"),
+			    the_hash_algo->name, hash_name);
+		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
+	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1_LEGACY) {
+		die(_("the server does not support algorithm '%s'"),
+		    the_hash_algo->name);
+	}
+	packet_buf_delim(req_buf);
+}
+
 static const char *url_scheme_name(enum url_scheme scheme)
 {
 	switch (scheme) {
diff --git a/connect.h b/connect.h
index aa482a37fb..c4f6ea4b0a 100644
--- a/connect.h
+++ b/connect.h
@@ -34,4 +34,8 @@ void check_stateless_delimiter(int stateless_rpc,
 			       struct packet_reader *reader,
 			       const char *error);
 
+struct string_list;
+void write_fetch_command_and_capabilities(struct strbuf *req_buf,
+					  const struct string_list *server_options);
+
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 8e04db8640..5e7c4f1d46 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1375,40 +1375,6 @@ static int add_haves(struct fetch_negotiator *negotiator,
 	return haves_added;
 }
 
-static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-						 const struct string_list *server_options)
-{
-	const char *hash_name;
-	int advertise_sid = 0;
-
-	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
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
-		const unsigned int hash_algo = hash_algo_by_name(hash_name);
-		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
-			die(_("mismatched algorithms: client %s; server %s"),
-			    the_hash_algo->name, hash_name);
-		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
-	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1_LEGACY) {
-		die(_("the server does not support algorithm '%s'"),
-		    the_hash_algo->name);
-	}
-	packet_buf_delim(req_buf);
-}
-
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,

-- 
2.54.0
