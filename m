Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513567;
	b=Yo2jai+5Fm8xCttDA9gqTXNHXuzlbR7m2B8s2TeLveGyBKEWigNMFBB3PzeQVlfHrVF6
	 1k+jMFDddrv/r4QFMjROPY3vzoLWLaqLWX/TUDMCwkKpVrezIkX8MWR/mZxSL/ycDvsiD
	 c8RJafk24ElIdqvwtrqvN/QQtx5Yez/N5cnH3jtRRumrcvlc15E4nzovDJP/GeoTPJBG0
	 OtxiyTyG7Cjbk8/MN4hKBjB7cixWJoYhk1+PBTgwEl1h2uYGahYn0WLdWOAzHLiyC0qWC
	 QRQUt+u4cBeKhXEBDR6CcUWe3gN5dL/MfIvP1z/tIh55B0bHU5LaDlIGbSpErwfc8zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r72XN+wpPUEHtmJwR3s8Z6+ub6rQG/0RM1Uif87elys=;
	b=F16MlEXjh3XsBOKPt0hcWMaNLoJ7jCFezSsiz02Bolhrfr/kv70HZApYuGpnvEgO5/Dg
	 y0XEjf12tionFdAYiKTiFC7Xbo8Y3IME7FaQIpEKe4HLRQhQxIZeRZV+MZ5ldd04bRHxt
	 PqfYEYxXvvPA7hPqwtpDArPY539FmX2vkwnVtNnKhp/b5rqwi+OT1Sgrq5tzb4z13Xpz/
	 kjgXRUNr2JViXTisiR3gRZf5n0o/WFPiUSgzsZAakUK9g8HUyVcnM9B1DdCP5hM0lSPWQ
	 gz6iAJ5MxPVWm5LrcdQTPxFVZqGwHiF0yrtkANvQg7/W/wqx3pYG6CZ8l5tHc+u3kQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="JxmbF/aC";
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35270606A33A
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35270606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JxmbF/aC
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b2382bf051so109394b3a.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 11:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513566; x=1795118366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r72XN+wpPUEHtmJwR3s8Z6+ub6rQG/0RM1Uif87elys=;
        b=JxmbF/aC++gc/uMMPq0oHuxhIPhPWfRlaU6rvufWjUdEPSivLzzEeuMF9OgR0cBVgw
         32oyet4iB+2/Z3vfPNifk96uIx57y3Ojhbgc/rTyxn72Agz64GuPirOhvJTmTfaxAWCY
         gcTWl6+w+JNtoRyrdom17JpKj04gy3WEYlTchd83BMQWoTPGeHJ08tViJ2GkuUazD6Fc
         7vvl0qXQNQh3hRRwg5dFzg/5m8A/FQbNtEPmta74ottTzJy7X2MsoGRzVAHJPpJOtJ+D
         GRnqClKHPCqCKCi9W/irjRO31UHXw81flpGuP4h+VtpaVaZZCWW0baIOf7aXQDIYuTlW
         VwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513566; x=1795118366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r72XN+wpPUEHtmJwR3s8Z6+ub6rQG/0RM1Uif87elys=;
        b=oMqv8e3uCTToKYG0ao4ioWUHesfN0FUVZOlxlH2gAPj49d/2ZH/rawIRKEzdSj3i9U
         TzZUpYBjPtLN4qmkoxUWjkROFCPhmQ3MxQ2Y+485EvnGaH97H4mwI+TrEik4stQgVisP
         xxp4ILg0fal3sztjCubTxP84ON3Oir/pd59n5NUkSeDEx15HPfsc5HR+To5TzghpPVWe
         o20qeQV1UWubxz1ZAteg7b3AYF9YadO4txUAZUv0PSXqxfXxLlDA23EMp0vATtd5Ez+d
         HDGuXQM9OwXnTGHIwM4j/wR4M26HYGOaY9feO1KDeq44JGQ9s89TXCVcPIJEPpIlQzTJ
         qeYg==
X-Gm-Message-State: APuU4Z+gUV4Wx6ESZLZi35Ldg1VUHIlvIg+UQt2gqp4a10WFdjImVnF9
	i0saIHSAGjJMD3C6SdzpIpnda4jS+WUIeRQpDm6ikxXpiFXDOqnXjwtDEsZYg92q
X-Gm-Gg: AYBFou0Uh9zXvde++JV50qBR+swZ26RLp2OJZuZeQe6IHwZBtIbbViRGCwhAZY35BCI
	QZq/bB0xtkcYafogR5Pwo8rl+MhSb5D1rCLRAjJo3anoZKDuq595+81R7EraWwiVgqNRlKRPvsQ
	JZtZijcEQXX10YSlIFrEKH1TWCzw2CLGSKAnVbPFVCxXJ9p1zI7umGHp6QKgkkNYKhnrySj5j1g
	gIdFAUIo6Ttz8Qf0v//mgJUg3uYGM24oBQddH68NCXgblN8Af4WJqDwuifPGShd5l38GlQzn4qJ
	nr3j5WxXDA9rl+JkzVwoX1vH742tiSNK/tnI+xCqeKc/F876pbyDwQom7qdwRVMQ50IRvvO5wNp
	xUxqg9/KEaIxppZsxO81NSgJ9yh5f3rse8hPk2/+FRqe4gF4/gCzPw8CO1mc6YUbId0atu6ZAgk
	pWX5Osq8EqMNTvTi3Id97hM69783KGs+XFUkw8b6hM61Y/LepdSWupmkG7JlpZdTxqxCKQEwrQ3
	rb/bBighS2qgUEM+gDlH1/a+nPQrraQh9KwsQWO6GYCdxjxG1mq2cpH5Uyf/Ziv/PD177keYaAT
	9lGJ7abJKEiFwN5TTmH/bINPYC960PrYI/y2vKvpD39gvEZuxz2wAls3D8k5AhgTYFPdVGcW3XC
	cbaM5iABB5CZ7xU9YQrU6Jwvv4GyiRs83FQcRH2VJuKkuFfa2NBF3N3c9fvPkqhE6MFS4Ji+U3M
	+wlDLMR9iDetUSgjWNoAxYv7xL0adKa0SbJe4r+U4FMA/yf9GJmyNmQAYQzA==
X-Received: by 2002:a05:693c:8244:b0:369:f291:49da with SMTP id 5a478bee46e88-379675061a4mr175068eec.40.1794513566255;
        Thu, 12 Nov 2026 11:59:26 -0800 (PST)
Received: from christian--20230123--2G7D3.nvidia.com ([216.228.127.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316fdsm640395eec.5.2026.11.12.11.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:59:25 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matt Cote <mcote@nvidia.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 1/3] connect: let write_command_and_capabilities() send a promisor-remote reply
Date: Thu, 12 Nov 2026 20:59:00 +0100
Message-ID: <20261112195858.53788-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.471.g1891de46f7.dirty
In-Reply-To: <20261112195858.53788-5-christian.couder@gmail.com>
References: <20261112195858.53788-5-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In protocol v2, the `promisor-remote=...` reply is only written by
send_capabilities(), which is used to send the `ls-refs` and
`bundle-uri` protocol commands.

The request for the `fetch` protocol command is built by
write_command_and_capabilities() called by send_fetch_request() in
"fetch-pack.c" which cannot send that reply.

In a following commit, we will need send_fetch_request() to send that
reply.

Let's prepare for that by adding a new `promisor_remote_reply` argument
to write_command_and_capabilities(). When it is not NULL, a
`promisor-remote=...` capability with that value is written into the
request.

For now, all the callers pass NULL, so there is no change in behavior.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 connect.c           | 6 +++++-
 connect.h           | 6 ++++--
 fetch-object-info.c | 3 ++-
 fetch-pack.c        | 6 ++++--
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index 87d2e8bccd..32243948b4 100644
--- a/connect.c
+++ b/connect.c
@@ -724,7 +724,8 @@ int server_supports(const char *feature)
 }
 
 void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
-				    const struct string_list *server_options)
+				    const struct string_list *server_options,
+				    const char *promisor_remote_reply)
 {
 	const char *hash_name;
 	int advertise_sid = 0;
@@ -754,6 +755,9 @@ void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
 		die(_("the server does not support algorithm '%s'"),
 		    the_hash_algo->name);
 	}
+	if (promisor_remote_reply)
+		packet_buf_write(req_buf, "promisor-remote=%s",
+				 promisor_remote_reply);
 	packet_buf_delim(req_buf);
 }
 
diff --git a/connect.h b/connect.h
index 957e5fe2b9..8914d131c7 100644
--- a/connect.h
+++ b/connect.h
@@ -37,9 +37,11 @@ void check_stateless_delimiter(int stateless_rpc,
 struct string_list;
 /*
  * Write a protocol v2 command request, along with the capability
- * advertisements, into req_buf.
+ * advertisements, into req_buf. When `promisor_remote_reply` is not
+ * NULL, a `promisor-remote` capability is sent with that value.
  */
 void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
-				    const struct string_list *server_options);
+				    const struct string_list *server_options,
+				    const char *promisor_remote_reply);
 
 #endif
diff --git a/fetch-object-info.c b/fetch-object-info.c
index 0a58308f9b..7fe6e4e864 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -18,7 +18,8 @@ static void send_object_info_request(const int fd_out,
 {
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_command_and_capabilities(&req_buf, "object-info", server_options);
+	write_command_and_capabilities(&req_buf, "object-info",
+				       server_options, NULL);
 
 	if (ask_size)
 		packet_buf_write(&req_buf, "size");
diff --git a/fetch-pack.c b/fetch-pack.c
index 55d311c0c3..50c97f561e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1386,7 +1386,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch",
+				       args->server_options, NULL);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2269,7 +2270,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_command_and_capabilities(&req_buf, "fetch", server_options);
+		write_command_and_capabilities(&req_buf, "fetch",
+					       server_options, NULL);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-- 
2.56.0

