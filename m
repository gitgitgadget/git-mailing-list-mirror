Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB045A2A2
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140450; cv=none; b=j73IdfXoGJHdTwaV/iYbhN9wyYUGVeAGn1ghFAMCqKEFVLHoDLtyyyu+tU2TzZke/+l4drp47ciPpxV9RVM6X5jnegoltRMOjWSkW7Knl37MBpYfkvzXRxO8eWrm08GqKFydNy4ziIBlMK1HWp7hTXifv2+ZfdIX5RWTt7t+g8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140450; c=relaxed/simple;
	bh=d/e233X9nvzVUyGYYUOncfmc8oDU5ERmd5fXypJw4lU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SX9mxENVzUDjjrLT1LO1mSuRi3u09CV9WsDWsEyyF9w/cnQSNNsaaOxmBGSRTbZhZco7yGBiwUhCnp8qWJAHZU0wY5glf+CTksNzGbOcW6ROMNvcF0BLDaq23Q1HAvye56YRCy8i5s5zvK9foKNBID84ci6IaoTqrq9Dm+3ec9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik+6X4ZT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik+6X4ZT"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so327365e9.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140447; x=1786745247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XQHkcoeYyr3/T5LhrWk6tk3JTEOO72l3EClLHqgqkQE=;
        b=ik+6X4ZTw8KvpLyD0AroVlQbPDyli/uDBBZAhqzOtUxAjSGBcVGPUeFO8adVAALKE4
         xvlQivneLbscvPinEpRVU2aTPSPssODzPf6si9Kx1icz/itiWrBTjQw7ABXXSFRxXRD6
         tnPQhA7mFYgWjih79cp7q6c9tPw1/Vo7VzsJ3G2DaBJ34L96MxYVrkabidKlBe+YKESQ
         cPxI6DgCVtpC0BqPoI/gelwqRJWHoq1j4m27UtsMwVKkotOFmpJf6/uCxZatBFqDa7dc
         enwWyKp/dFZSS+68LtG3ab/ZAqB+kJ1uKhxDS/GmmyOP500CGbSxKxgJrdBlG6YALxJe
         0mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140447; x=1786745247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQHkcoeYyr3/T5LhrWk6tk3JTEOO72l3EClLHqgqkQE=;
        b=hi20PL+g9+EwDMEt9Lvl+lFX3mTHfbmT6Tl2H411zL56uamv1g5+UPhCUX6YXIXuef
         KWMsq0gdHGtKSw4VnLXhW0Sb0Ra/cdrtG2c5uzJxTKrdqQlnyvMH6rkJZQUy2NLcqZRT
         z5kWOgEaMtj2sFJWlrkEoxYVEmHGh+XKksmHZfrLj4M697HjRgOobSJNHNJ6jv49tSJB
         tL4Z8RKDNEYYhPu1v1ajv/dehpRjTcojknbYuyNk79Wk5/nGcNKQZdUN8QfnItoWrne8
         gpWmIaCnIqr13yGJKDX3+KV5SX/3LPp89pDfz4IABKhChHCYGJ1fl1W1U+0LgYSalcuI
         2v5Q==
X-Gm-Message-State: AOJu0YwUwmywDmzqg3X49HR546n0nqq+EWqKA7LBv2ZjHFg5fSHuMhi0
	njpjXRPPRSUR6fljuAuUaoThtPU6G8rP61S4lqQZI2RtfbZsnT0zd5oDFoiaqvjS
X-Gm-Gg: AR+sD12XrS63o/JRbasfV1oP8kozoCCBqGj5R8oY50MaZ2WMqbRiOhUdeA8+QWSI73S
	5IMnVXcZziZhiHIHonFRe/rbliUsZwpdgdOgrHUKsoJzZZE/SlCECZFyqYp6fHuXGUVElYPRXdM
	cnijkdXGi8N27d2L+8bW7cX4FonLkkUTUJm41J8uIR7DzORlqNHtDiHK2+n8TCLjepFzGt/DFgg
	ojiF4OvkF1Ns4/lSOg5I6OIcfD7fg3jePp48HSvnZX/vH3rZQGbkRQcLa1DYZ4ViuvVL/am0lSv
	t04lKG6R1MvH/c9+VmER4rXmSZQJzckL0X9evBeVoMAMP81iPLKi/RAGP59NlTTRZRUM/r+oP9a
	JAa9gmLDHG0vmhElCsup8OR0ORP5hXeAVIZb4zTB1e/0uqFBWZZ66WD4CIfIzoN4QXl+IQkux4y
	REaUaqNDrlOFluW2z8tEkerZhUeGM2/kQ6UafeQevl5buuoAhiX/JNK7ddZB82XNLSLGHRvi6iB
	SCPjIKfClJb9Ee83w6KDCI7g5xZexRsVOWnPa0+dccJJEojX6XCVXuMkWVdgIm6VU05Iw1mOF37
	eHQYF2S87IkF+cWtJ0FQuPEpte3TcHK1dY4KOyxMt5vTIDzkHx4Cx1mJTnZTwMLF/ATbwTFYiQG
	N2XDQN5zIwn4qR9cKgScm6UsB1E0LIex0anp9NC9v4/gL3Zx8cwK3zCnkqG86eVUzkXPS/0dt+W
	yqin0=
X-Received: by 2002:a05:600c:4595:b0:498:952:e276 with SMTP id 5b1f17b1804b1-4994e79e377mr249016315e9.8.1786140446695;
        Fri, 07 Aug 2026 15:07:26 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b4499sm69478545e9.3.2026.08.07.15.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:07:25 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 00:07:03 +0200
Subject: [PATCH GSoC v5 08/10] fetch-object-info: parse type from server
 response
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v5-8-86f22bec04b2@gmail.com>
References: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
In-Reply-To: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The server can handle type requests but does not advertise the
capability yet. Prepare the client to know how to parse the server
response once the server advertises the type capability.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c  |  7 +++++++
 fetch-object-info.c | 38 +++++++++++++++++++++++++++++++++++---
 fetch-object-info.h |  3 +++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8dcad2f5eb..8502020083 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -842,6 +842,8 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 
 	if (data->info.sizep)
 		results.wants_size = 1;
+	if (data->info.typep)
+		results.wants_type = 1;
 
 	if (get_remote_info(count, argv, &results, &object_info_oids))
 		die(_("failed to get object info from the remote: %s"), argv[0]);
@@ -850,6 +852,8 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 	string_list_append(&data->remote_allowed_atoms, "objectname");
 	if (results.sizes)
 		string_list_append(&data->remote_allowed_atoms, "objectsize");
+	if (results.types)
+		string_list_append(&data->remote_allowed_atoms, "objecttype");
 
 	data->skip_object_info = 1;
 	for (size_t i = 0; i < results.nr; i++) {
@@ -868,6 +872,9 @@ static void parse_cmd_remote_object_info(struct batch_options *opt,
 		if (results.sizes)
 			data->size = results.sizes[i];
 
+		if (results.types)
+			data->type = results.types[i];
+
 		opt->batch_mode = BATCH_MODE_INFO;
 		data->is_remote = 1;
 		batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
diff --git a/fetch-object-info.c b/fetch-object-info.c
index f269a5d8a8..ba0540853e 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object.h"
 #include "pkt-line.h"
 #include "connect.h"
 #include "oid-array.h"
@@ -12,7 +13,8 @@
 static void send_object_info_request(const int fd_out,
 				     const struct string_list *server_options,
 				     const struct oid_array *oids,
-				     unsigned ask_size)
+				     unsigned ask_size,
+				     unsigned ask_type)
 {
 	struct strbuf req_buf = STRBUF_INIT;
 
@@ -21,6 +23,9 @@ static void send_object_info_request(const int fd_out,
 	if (ask_size)
 		packet_buf_write(&req_buf, "size");
 
+	if (ask_type)
+		packet_buf_write(&req_buf, "type");
+
 	if (oids)
 		for (size_t i = 0; i < oids->nr; i++)
 			packet_buf_write(&req_buf, "oid %s",
@@ -56,7 +61,9 @@ void fetch_object_info(const enum protocol_version version,
 		       const int fd_out)
 {
 	unsigned ask_size = 0;
+	unsigned ask_type = 0;
 	int size_index = -1;
+	int type_index = -1;
 	size_t wanted;
 
 	results->nr = oids->nr;
@@ -71,11 +78,16 @@ void fetch_object_info(const enum protocol_version version,
 		    server_supports_feature("object-info", "size", 0))
 			ask_size = 1;
 
+		if (results->wants_type &&
+		    server_supports_feature("object-info", "type", 0))
+			ask_type = 1;
+
 		/*
 		 * Even if no options are left, we still send the oid so we get
 		 * at least an existence check.
 		 */
-		send_object_info_request(fd_out, server_options, oids, ask_size);
+		send_object_info_request(fd_out, server_options, oids, ask_size,
+					 ask_type);
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -83,7 +95,7 @@ void fetch_object_info(const enum protocol_version version,
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
 	}
-	wanted = ask_size;
+	wanted = ask_size + ask_type;
 
 	for (size_t i = 0; i < wanted; i++) {
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
@@ -100,6 +112,13 @@ void fetch_object_info(const enum protocol_version version,
 				die(_("object-info: duplicate 'size' attribute"));
 			size_index = (int)i;
 			CALLOC_ARRAY(results->sizes, results->nr);
+		} else if (!strcmp(reader->line, "type")) {
+			if (!ask_type)
+				die(_("object-info: unrequested 'type' attribute"));
+			if (results->types)
+				die(_("object-info: duplicate 'type' attribute"));
+			type_index = (int)i;
+			CALLOC_ARRAY(results->types, results->nr);
 		} else {
 			die(_("object-info: unknown attribute '%s'"),
 			    reader->line);
@@ -149,6 +168,18 @@ void fetch_object_info(const enum protocol_version version,
 			    object_info_values.items[0].string,
 			    object_info_values.items[size_index + 1].string);
 
+		if (results->types) {
+			const char *type_str =
+				object_info_values.items[type_index + 1].string;
+			int type = type_from_string_gently(type_str, -1, 1);
+
+			if (type < 0)
+				die(_("object-info: object %s has invalid type '%s'"),
+				    object_info_values.items[0].string, type_str);
+
+			results->types[i] = type;
+		}
+
 		string_list_clear(&object_info_values, 0);
 	}
 
@@ -162,6 +193,7 @@ void fetch_object_info(const enum protocol_version version,
 void free_fetch_object_info_results(struct fetch_object_info_results *results)
 {
 	free(results->sizes);
+	free(results->types);
 	free(results->unrecognized);
 	memset(results, 0, sizeof(*results));
 }
diff --git a/fetch-object-info.h b/fetch-object-info.h
index 10cf9f5f63..2fba96c6f7 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -1,14 +1,17 @@
 #ifndef FETCH_OBJECT_INFO_H
 #define FETCH_OBJECT_INFO_H
 
+#include "object.h"
 #include "pkt-line.h"
 #include "protocol.h"
 
 struct fetch_object_info_results {
 	size_t *sizes;
+	enum object_type *types;
 	uint8_t *unrecognized;
 	size_t nr;
 	unsigned wants_size:1;
+	unsigned wants_type:1;
 };
 
 #define FETCH_OBJECT_INFO_RESULTS_INIT { 0 }

-- 
2.54.0

