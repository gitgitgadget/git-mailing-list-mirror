Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193319;
	b=346uP+q2pRZ/+BYcLoSPAdUCoiB2Oi7gD3mm7yO1lcWpRkV7ve+EW3OtIEOqS+H1y1jT
	 t9+YNgwQXefzlznJJbkrmO5knTBITMWFpRxAmh6ExhXsI1j/ciLtBf366uvSXe1EjTc5g
	 QH6GuJKhWr+R+mxphncCo9tMDUTBViM75GBVfFhgvcdP/p6eRdgQ8Qk0UvDnFnu3aSfto
	 TBh4ibIdHFpmA6fG2719El+ix5vWGvCb/WX9Ai1wOzXIdT+50gMVLyb6fGfSVQYHH4M9t
	 2yazdtJChuScnq7/buOE8Z1VlHEne0kckni2CcTGX8LbXwge6RMSkXRCM0jd7p9BSBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MAl3F0k9iy6k2KNkXTe8oCF/FD/4FQZFRAvUuFl7Rb4=;
	b=VnXxRaDRjFUe4t+qnexe8SaiRMXIGBEtdnhup/idCfC5srkW9iTcotCqQB46ihdFMmOS
	 199drQhVQhzGe4ioDtA619qpmuM+Cw8cAvHoPpnko+rLt4YxpXYuQY91dRwZ5vwQRzx9S
	 lYoJ+2niMtH3gIRbyOQqSDO891StIi/j15lhwYWPivvbyk5YUQBb5bHxClD0XjA0A2P6J
	 ssXyrpVBqTP80k3s405ROqvsRPExyhwD58gfPJtCjgVnezK/9ixykbZPk85t2MyVuc2By
	 0/O9xPewiXmSIA2BmZ3ezy84+8brsRpGEkyLT4w0Pr9uuqFXAfIWy6/8U4xWTzmUXeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hCKS0CHo;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F5C606A335
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61F5C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hCKS0CHo
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a210470b49so9999545e9.2
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193317; x=1795798117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MAl3F0k9iy6k2KNkXTe8oCF/FD/4FQZFRAvUuFl7Rb4=;
        b=hCKS0CHoy6MC5d9LB2ssukppgyw9oj6LxyHhv5Aen8XIOejrvcQkBRjqTHmgua10Xh
         ikRos9uQ6Z1cuRUmhUtZa6A2s2M4eveubEIrnv/ksY84m3eIWgZZM8ridD5ReFxuQnJl
         7G+fvkY6UIA2y+QeY/IWzaBKbNfbbkizfS7DM52zWjog0/cpUMvxRwd0wJIO7A2jVFLA
         2Morlhihdid5NoESPbyRQ7NrjeRYyW6i3eYsKkiAAmLtjQqGq288MhrVVM+8FVhiBqQP
         ltGVCm0grRmPMOoYOSPrLo5j5BAJj0NkJ3yVKmbkTWxsZjKJ7Ik83t2/y410QzRoLFwZ
         /EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193317; x=1795798117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MAl3F0k9iy6k2KNkXTe8oCF/FD/4FQZFRAvUuFl7Rb4=;
        b=pdX/wzEvOELYQMC3hQFau5FS72HmoggtK+PQtocxsVlZakSeJ1uHqXH8VxEzkpdw7z
         Gbvb9Clv3qyo/on8jX4p7yq/8nP7zSyjCxmJ0GDJtzZU8E8aLSDd5/JrHWhovrkcflVo
         VUeGCEY6MYwdPRUudfA+R5p3i5pqWA1+xd7yg6MffTLkvDV/di4PVRKrUpuyKqaRaaUC
         LFZ0jt3IwKcYkcZuzhG2TpZx6eBoCjnv16u5BZu1CQK6B6f6723n4Exfrv7lrYZY72mH
         n9BLwxQw/mCF3Xx1mVUy5g6CN3zIfwUoh1PPbqsJHb6WrZMj45TYELMAwl23UYFbWJnd
         t+6A==
X-Gm-Message-State: APuU4Z89S9va4OrRE5QDiFhvLsNpOahgvM89/xcmqMjl4sRlJ329TtmY
	KchOG+qq9Mt+5X+OcN2dMzIP6ZwZJDnGND7UO5PdoXsAgUsevHYCtQ2DDJ+WaA==
X-Gm-Gg: AYBFou1/JEI+WBCtCmE3WmBESLhdhWe/DKPTHVit+cuiULZVhxzaBM9WOciFPSKA+Dw
	1EhDVDH0fsItxZGKNFTOxddE89LcwgzvA1wZed5Mhx0KZsk0GJSnmf75+POntHEf6pmXn88+TMN
	IZpCUDtWg1G3LwSyULIPue6pzG/Y31ff+ZUmXDtX7uI5Xf4tSQg6prKpERNtx2GEEnibZmpZIJV
	RP9ZPvGuSvYGutmcmeNBDJck4YJ2xRUOayTVCFfME2IWrv76CSP9IsQBGwQA3Czbuh68sXOgaCC
	WiZuOE0yVOMenCD4b75nwuHzUIkAetv3VUKPcDEdvWNUu/6/tpil17ZI5RmlQ0BRe/oo3Jewvlf
	qy12Puu6uC5UEXpUuHW/+oBl8dkgYtOdo6yYUrAXnWarSxKD0/yD0G1lmferngTHhflkSWrpGZc
	lRjOVyTmGaLyPlZ9Ws/QsqC/0ja6bC2AOBgbBrcDJXPdaVNINSdiGlSOD7EYWE0vtuxcD1CPaYK
	xOsFCbXStH7RIMkm4DrODQIq+5w/dasin5O/U4pBt3UvnQzM+n3b/zWvhvSEqkDQQAQL/u8KaPU
	vwsvLKcw0s8C9FEOYIlZ474gXPcwFo5cOPFtcZVpZMC7tdCphaVUxDs32hSAo+DvV+dFyuX2fAA
	TghCFHKNlOVCxEx/mtZjHvguF8NL8leelfQydW8J+Qu9Y/UbOuXbfpiorKGM+zXH4p80JzovMlL
	Nlv2Zr4oUW5LkApIsj/894NgeOcz2/udQ5TpK5Fv4=
X-Received: by 2002:a05:600d:82e4:b0:4bb:6847:7927 with SMTP id 5b1f17b1804b1-4bb8882677cmr85434805e9.7.1795193316904;
        Fri, 20 Nov 2026 08:48:36 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f281sm6232752f8f.22.2026.11.20.08.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:48:36 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matt Cote <mcote@nvidia.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 1/8] connect: pass capability lines to write_command_and_capabilities()
Date: Fri, 20 Nov 2026 17:48:14 +0100
Message-ID: <20261120164812.707946-11-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.596.g78bef52d5b.dirty
In-Reply-To: <20261120164812.707946-10-christian.couder@gmail.com>
References: <20261112195858.53788-5-christian.couder@gmail.com>
 <20261120164812.707946-10-christian.couder@gmail.com>
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

There are three different functions that write capabilities on the
client side:

  - get_remote_refs(),
  - send_capabilities(), and
  - write_command_and_capabilities().

They duplicate code and make things difficult to understand, fix and
extend.

To start rationalizing this, let's make the
write_command_and_capabilities() function more generic, by replacing
its `const struct string_list *server_options` argument with a
`const struct strvec *capabilities` argument.

This will make it possible for other functions to reuse this function
in following commits.

To allow callers to generate the "server-option=..." capability lines
that can then be passed to write_command_and_capabilities() through its
new `capabilities` argument, let's also add a new add_server_options()
helper function.

No change in behavior is intended.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 connect.c           | 32 ++++++++++++++++++++++++++------
 connect.h           | 17 +++++++++++++++--
 fetch-object-info.c |  6 +++++-
 fetch-pack.c        | 11 +++++++++--
 4 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/connect.c b/connect.c
index 87d2e8bccd..5f73fd9e7e 100644
--- a/connect.c
+++ b/connect.c
@@ -723,9 +723,22 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
+void add_server_options(struct strvec *capabilities,
+			const struct string_list *server_options)
+{
+	struct string_list_item *item;
+
+	if (!server_options)
+		return;
+
+	for_each_string_list_item(item, server_options)
+		strvec_pushf(capabilities, "server-option=%s", item->string);
+}
+
 void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
-				    const struct string_list *server_options)
+				    const struct strvec *capabilities)
 {
+	struct strbuf key = STRBUF_INIT;
 	const char *hash_name;
 	int advertise_sid = 0;
 
@@ -737,11 +750,16 @@ void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
 		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
 	if (advertise_sid && server_supports_v2("session-id"))
 		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
-	if (server_options && server_options->nr) {
-		ensure_server_supports_v2("server-option");
-		for (size_t i = 0; i < server_options->nr; i++)
-			packet_buf_write(req_buf, "server-option=%s",
-					 server_options->items[i].string);
+
+	for (size_t i = 0; i < capabilities->nr; i++) {
+		const char *cap = capabilities->v[i];
+		size_t key_len = strcspn(cap, "=");
+
+		strbuf_add(&key, cap, key_len);
+		ensure_server_supports_v2(key.buf);
+		packet_buf_write(req_buf, "%s", cap);
+
+		strbuf_reset(&key);
 	}
 
 	if (server_feature_v2("object-format", &hash_name)) {
@@ -754,7 +772,9 @@ void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
 		die(_("the server does not support algorithm '%s'"),
 		    the_hash_algo->name);
 	}
+
 	packet_buf_delim(req_buf);
+	strbuf_release(&key);
 }
 
 static const char *url_scheme_name(enum url_scheme scheme)
diff --git a/connect.h b/connect.h
index 957e5fe2b9..2d5f9e2b83 100644
--- a/connect.h
+++ b/connect.h
@@ -35,11 +35,24 @@ void check_stateless_delimiter(int stateless_rpc,
 			       const char *error);
 
 struct string_list;
+struct strvec;
+
+/*
+ * Append a "server-option=<value>" capability to `capabilities` for
+ * each item in `server_options`, which may be NULL.
+ */
+void add_server_options(struct strvec *capabilities,
+			const struct string_list *server_options);
+
 /*
  * Write a protocol v2 command request, along with the capability
- * advertisements, into req_buf.
+ * advertisements, into req_buf. The "agent", "session-id" and
+ * "object-format" capabilities are handled here, and must not be in
+ * `capabilities`. `capabilities` contains complete "key[=value]"
+ * lines and must not be NULL. The keys in `capabilities` must have
+ * been advertised by the server, otherwise we die().
  */
 void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
-				    const struct string_list *server_options);
+				    const struct strvec *capabilities);
 
 #endif
diff --git a/fetch-object-info.c b/fetch-object-info.c
index 0a58308f9b..cd14105836 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -8,6 +8,7 @@
 #include "odb.h"
 #include "fetch-object-info.h"
 #include "string-list.h"
+#include "strvec.h"
 
 /* Sends object-info command and its arguments into the request buffer. */
 static void send_object_info_request(const int fd_out,
@@ -17,8 +18,10 @@ static void send_object_info_request(const int fd_out,
 				     unsigned ask_type)
 {
 	struct strbuf req_buf = STRBUF_INIT;
+	struct strvec capabilities = STRVEC_INIT;
 
-	write_command_and_capabilities(&req_buf, "object-info", server_options);
+	add_server_options(&capabilities, server_options);
+	write_command_and_capabilities(&req_buf, "object-info", &capabilities);
 
 	if (ask_size)
 		packet_buf_write(&req_buf, "size");
@@ -35,6 +38,7 @@ static void send_object_info_request(const int fd_out,
 	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
 		die_errno(_("unable to write request to remote"));
 
+	strvec_clear(&capabilities);
 	strbuf_release(&req_buf);
 }
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 55d311c0c3..ecb384211c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1385,8 +1385,10 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int haves_added;
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
+	struct strvec capabilities = STRVEC_INIT;
 
-	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
+	add_server_options(&capabilities, args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch", &capabilities);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -1451,6 +1453,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
 		die_errno(_("unable to write request to remote"));
 
+	strvec_clear(&capabilities);
 	strbuf_release(&req_buf);
 	return done_sent;
 }
@@ -2242,6 +2245,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 	int last_iteration = 0;
 	int negotiation_round = 0;
 	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
+	struct strvec capabilities = STRVEC_INIT;
 
 	fetch_negotiator_init(the_repository, &negotiator);
 	mark_tips(&negotiator, negotiation_restrict_tips);
@@ -2257,6 +2261,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 			   add_to_object_array,
 			   &nt_object_array);
 
+	add_server_options(&capabilities, server_options);
+
 	trace2_region_enter("fetch-pack", "negotiate_using_fetch", the_repository);
 	while (!last_iteration) {
 		int haves_added;
@@ -2269,7 +2275,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_command_and_capabilities(&req_buf, "fetch", server_options);
+		write_command_and_capabilities(&req_buf, "fetch", &capabilities);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
@@ -2324,6 +2330,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 	trace2_data_intmax("negotiate_using_fetch", the_repository,
 			   "total_rounds", negotiation_round);
 
+	strvec_clear(&capabilities);
 	clear_common_flag(acked_commits);
 	object_array_clear(&nt_object_array);
 	oidset_clear(&negotiation_include_oids);
-- 
2.56.0

