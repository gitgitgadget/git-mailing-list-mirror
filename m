Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEEB377EB9
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411418; cv=none; b=qstdh2ixowA/MDJ3F5Jq4tOIM4I7wQdJT59p9ZYGm9CGxZ51RYxWwymoxb5IEiTxeQWbvWallx8moBChkEIFOwOz/jjoLcNoxMuGHJL2WFLpv8GlRIZdGzdatAVOyOd736MgA4QBR0pqqAqG2GMHJHcyblk6+/cNfghyV6Sx4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411418; c=relaxed/simple;
	bh=X2jTolZXQNukd7z1WzW+fsNZJr8SmIEMz8kg0lQ/WvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xty1AfhI1eKZ5Ut9/ulftwYKhfnTxSm7WxFirxVd5WhfbJUKPz85u7R7Tgz/Wk4ZjC1R0HCCaGXDixG8mRXx1BAk56MhQ5zhrRuErHJ6YlTBPe4VUlgMMrFaoka/2Y45g3jFVHWzzORbenNm4yd7dYw5EMGV7PfuTVp4OBitmJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJYE7l6Z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJYE7l6Z"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954df200ddso6974765e9.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 14:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411415; x=1785016215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xi1sKxLcXp+bsWMKgCDIe62HTmF9/n/YXXV/3KmnZWI=;
        b=BJYE7l6ZNkSycptQB6TMoM9HRUlzfs3WYbHahT8xKekDVAYptOwDhrijUZ7hf91ZfO
         0pnMJDbnsWJKQ9VK5sXaeTJ8k8RBzOa0kkBd32fuXfil6u5BUJQ2H8S1kiFYpxY54Mk+
         tLTOnYYpg9QTKBicvjydyV2qAyYQvoJVbvnQfNBsNiR0bS+mhZY5RGZqg5Gj05u4wrwq
         YIAKyLYL3yBytfhswtlCtz14LHuvu3mN4o4MT/eXxUkswqdcdBnlAWFfqPIPPYA2PpZw
         zXfev9+3YuuhrAwlMwoQQaiqfKRJg1asiaNUmXN4X75epEv2SMJIIGapPaX46jrQzS02
         F/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411415; x=1785016215;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xi1sKxLcXp+bsWMKgCDIe62HTmF9/n/YXXV/3KmnZWI=;
        b=ft5ThgD+WJvbxZMKs+i2k/YFnqGkfpN5U0klebkAXtEIDmlVYirFWw+8bAbmuccSgv
         dRj8CFPIggKQBET2w5L88bdruFACimgS1j+hSPXQ3D7VrCAm818yVoDX3zfWBq6ICPWM
         pRP0hfMsjWlmfHW03/RZh96tEkfvPgyNQKD8Yod3wqFYR7k9+1sxxHZlRKmI8T0oaeiX
         k/CzDSSFpGiHJFXozwCzx2b/7hky5C9DmxYNsxPiNONYXpXJclvCJTSNYRE9nyG1PAmh
         zoCGl95SbvvxKYW5PhmnryP7IFi7GhMGInmPLv7QlW7mdbU+tHPYy1Ht15Xy8nOft/hw
         d67Q==
X-Gm-Message-State: AOJu0YxU9EC6bCWLuMyIZ7MxAhIDXjmSSOmRxt+v9nA6QjXQar1ul/tL
	le/euUwfGdczFzf67VQxgDZAdLdDgxZlsVVWiZgmtdoaj6g7ZZfxfNPZsg3j7GJ5
X-Gm-Gg: AfdE7cm4bP2zEuEws4D7jl9hD6DMbL+AuoHKG9to/plnGUHye6R3fKN4GxU4JJoNFVy
	KNfKa/gQY2q0d1AgkV8MP0MNUPVYlvFu7NyAc5EL1pZdqPnASuqM2xeVSLTMKDCSCGrLMLB7NKq
	BPE/i9Sdhw8qIj5zhtM/oaKYzljTWoQ1ksAzeCJgXKlm/qgfneRv8rq619BCLb2L6oqX0hp+Wf8
	wrahT85ZXzHEevm2AVwhVchsdy+W4Koq+h80MsnsOwXyKBmC1mK6ICGcwtbpISu6qQ872BBKdl4
	xa61CUT6v7ARQzc0GKbzsZsDhMkIASqynI85KT8lEeM8RpNJS5aO043/Ct2B4atKaNJi0YHr5YQ
	WmioYTSSBAmmZH9BhV0HjebKl+4CkXUOBZX9vDSjpIYqEMFoJ48NyvonZm47B18+kDMA1VpUYuH
	USbRrm6lBePwUfd1M+sAKkagZslIZhoUgmqUuRBZK75rtA8IrQdt/xxvlvP99or7h2ULoZ8E7v3
	rEEf0A1Ry/xH4Qx2eBd9OFyF/2/stiZFf6jOMjR1GLnrLTf7C/E5fcPqMo2OPU6mSkZSDpHT7/E
	XsQ2LLZBfvqSjeDM63BrlXPPOMPL02Vm
X-Received: by 2002:a05:600c:1989:b0:495:699:84ca with SMTP id 5b1f17b1804b1-4954a798f17mr81804165e9.28.1784411415254;
        Sat, 18 Jul 2026 14:50:15 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm146225145e9.13.2026.07.18.14.50.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 14:50:14 -0700 (PDT)
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
	szeder.dev@gmail.com
Subject: [PATCH GSoC v20 06/13] fetch-pack: move write_fetch_command_and_capabilities() to connect.c
Date: Sat, 18 Jul 2026 23:49:55 +0200
Message-ID: <20260718-ps-eric-work-rebase-v20-6-0c13962ac532@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In a subsequent commit write_fetch_command_and_capabilities() will be
refactored to a more general-purpose function, making it more accessible
to additional commands in the future.

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
index f1e64160fc..f7789e8456 100644
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
