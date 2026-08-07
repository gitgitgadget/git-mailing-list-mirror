Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3611F45A2A1
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140444; cv=none; b=sePexsd+DDaZrQfMQiiKcrc+xs8XQ6DxyNnlM5jrVClEAqu8duqr+GZoZYv5TUHzF3D7PcTTM70Fidd8q2wA4w19wGuVW+x0gJRvIwZQtv2LtJZPIOWoMNJssagEosmtcGg/1dHdaEzITYuntQap9S3JMGz4IfpXvhqSCY4odYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140444; c=relaxed/simple;
	bh=/yFqJ2nA06vy4T+O4FSDy4Ca6ev2dJBhYuMXMOnUqpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bRWbdAn1GDph9KvlF7dB+E/qv/wORMt/drcxsDtdBPCc/HtciDSmggobEE0ZvylqYfw5S4b+zX78NaCNV8pCjJCV4bhhMIKdAet1NVJDphjLzYxNORlpvbc+eHN/FqOjTwj1okZFZP6xUEV+jM5X9gw6XPfl5uf1qSo1a0vURXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l93JOqYC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l93JOqYC"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49800c6a846so257615e9.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 15:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140440; x=1786745240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OBP0iCm8TzyXOYQMoBR+nVBWoCGPQcuJJqC99V4rZio=;
        b=l93JOqYC59/Z809B9TCXIG63MEgLhn7OgVFLRalJOrVO170WWa7fqYH8KeWceqFNoY
         6ZKUWfu/KndG4JTyD5lUJDagpyh0KtwqC64tk/aWz4SSrioTo1LL848GrYP5HruR9aOC
         jfBlAJ3GnSEoRzcHXDyEAJ/zekGxJc4+gWrO1zZZ0LQjrwrWe4MyaPnw6pW3Sjf007X7
         ebvNQpzTbKB0A+U6DyrC2Fbn42KCdKZaqCuxKjdkzo+VvZtfO1mEq0lvlqk9UfUdgMj6
         IQqBkZfShPmbG7sBPNzPKkEMtsxheBRqGfRk4oyLnJP4Bz2dAVPHJIeyK9ErHZR3AEFj
         epcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140440; x=1786745240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OBP0iCm8TzyXOYQMoBR+nVBWoCGPQcuJJqC99V4rZio=;
        b=VPwwXbhCG2aXNF2DieNCAGlxdTMKmSsfpLEglcuu2HVMYztPiDEGEGgoxsRnrUNWZX
         ug/6YC7AgeKpbmmu/X4JTwY+3fpu3CEvGK1niNSX/nOSMHFk+ayk7Gbq63nP8d47ODum
         TDvwQ7KNNd0Mjkd7k777bOmCuSix+pfJnMf4hO8z4UOCMG05NVMasECJSpUtsscKcmCt
         q2TOCBMnMz7MYZfBRsWf8bLWR3YGlcQX3EUnSZkHj7CnyWYshWi6RY5I0bVfjsBH0pcv
         kqlRe4/Ze1hXpQK0DGPbTtCHw497TgTWplYSY/CrxeuZlykCknVSQwCvCf73cE65WY/S
         /v8w==
X-Gm-Message-State: AOJu0Yzu4Vr1WxSwmRN0IrzjXWj4YTrplAA8aqzCzb0UejoM4PmDKTyn
	02RY7eok/onLhmk0XuLLjhlhRUSo7rh4rvQCAbYcOtuBUqLt60D2OoEF
X-Gm-Gg: AR+sD13EnwJD8D5Q6QDX3Sj6PYogj414NlUAZf5J8H1YGVsiuA8rjrz9Q2HneO6WfZk
	qP5yZkxx9e9cCmGCdhs7eKaK8VOnwK4T8sIrPmTVtGU/iRyFFOentMlgwvWq6+PeNFcqRREqVBN
	TZuDckiZLb2mslkARk57JOZ7VeavIdlC0qbNfw0GRGdepaQei2v0dvBkFoUMapycsCR0r0vz8lM
	nuqejW8ssDKERd0U0dIolRNrTRuzQ89G5DC/ezSUd/RZAmv80LLP8iXqeF7R49GurVrJ2Qflbjj
	ZEDnTJo56OZRlBgocgwCQ0+pbZ2B6G1tVYFfg84WkioK54bEAmjPQcv95txXNN+Fn4A0kdUz202
	mwIwh9aA8VD3WEMCZZpaiA24uj8F62zCdNC8anzzqKDBMEM6Tu8WWhRgCrTLdhWIXl2DPegU9O+
	TdhC2Fl+d9YbLq3z/B2Ecunc1FccNagVwXbehloIXwyivvt5jB1KjDoCotiKyIxmlftBM9PgyxP
	0ovtDQZp/ZwTMLJLXZMhpryyRGkFpIwTCgPqBAA6XERFrgbY3dySknxQ0PKFplUUxKTfbwuZHUG
	0pN7h57IO6JgxbjolGVqPOyzGlPGaZziz6L0uq1Syw3EIe/amn8/qXA3+/ihqtSxlmAtf74TobR
	kX3PW1tK2ff4bQjfCLBGZmeoac/hXEAYGxdPC0+QNRazr4+hwXEcjOehIj/vmYl+iH75b
X-Received: by 2002:a05:600c:a47:b0:499:484a:7644 with SMTP id 5b1f17b1804b1-49959e2eb00mr152220435e9.9.1786140440220;
        Fri, 07 Aug 2026 15:07:20 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b4499sm69478545e9.3.2026.08.07.15.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:07:19 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 00:07:00 +0200
Subject: [PATCH GSoC v5 05/10] fetch-object-info: die() on the remaining
 error path
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v5-5-86f22bec04b2@gmail.com>
References: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
In-Reply-To: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

Every failure in fetch_object_info() dies except one: a short read while
parsing the attribute lines returns -1. That -1 is then passed through
fetch_object_info_via_pack() and get_remote_info() up to cat-file, only
to die() with a generic message.

Die in fetch_object_info() instead, consistently with the rest of its
error paths, and make fetch_object_info() void.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-object-info.c | 19 +++++++++----------
 fetch-object-info.h | 14 +++++++-------
 transport.c         | 12 ++++++------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/fetch-object-info.c b/fetch-object-info.c
index 46a1289ff3..7a337a6857 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -47,13 +47,13 @@ static int parse_object_size(const char *s, size_t *res)
 	return 0;
 }
 
-int fetch_object_info(const enum protocol_version version,
-		      const struct string_list *server_options,
-		      struct oid_array *oids,
-		      struct packet_reader *reader,
-		      struct fetch_object_info_results *results,
-		      const int stateless_rpc,
-		      const int fd_out)
+void fetch_object_info(const enum protocol_version version,
+		       const struct string_list *server_options,
+		       struct oid_array *oids,
+		       struct packet_reader *reader,
+		       struct fetch_object_info_results *results,
+		       const int stateless_rpc,
+		       const int fd_out)
 {
 	unsigned ask_size = 0;
 	int size_index = -1;
@@ -89,7 +89,8 @@ int fetch_object_info(const enum protocol_version version,
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
 			check_stateless_delimiter(stateless_rpc, reader,
 						  "stateless delimiter expected");
-			return -1;
+			die(_("object-info: expected %" PRIuMAX " attributes, got %" PRIuMAX),
+			    (uintmax_t)wanted, (uintmax_t)i);
 		}
 
 		if (!strcmp(reader->line, "size")) {
@@ -156,8 +157,6 @@ int fetch_object_info(const enum protocol_version version,
 		    (uintmax_t)oids->nr);
 
 	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
-
-	return 0;
 }
 
 void free_fetch_object_info_results(struct fetch_object_info_results *results)
diff --git a/fetch-object-info.h b/fetch-object-info.h
index 9f72e91155..97ee5314c9 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -24,13 +24,13 @@ struct oid_array;
  * attribute is not available.
  * Release them with free_fetch_object_info_results().
  */
-int fetch_object_info(enum protocol_version version,
-		      const struct string_list *server_options,
-		      struct oid_array *oids,
-		      struct packet_reader *reader,
-		      struct fetch_object_info_results *results,
-		      int stateless_rpc,
-		      int fd_out);
+void fetch_object_info(enum protocol_version version,
+		       const struct string_list *server_options,
+		       struct oid_array *oids,
+		       struct packet_reader *reader,
+		       struct fetch_object_info_results *results,
+		       int stateless_rpc,
+		       int fd_out);
 
 void free_fetch_object_info_results(struct fetch_object_info_results *results);
 
diff --git a/transport.c b/transport.c
index b0e29124d1..35acdf71a2 100644
--- a/transport.c
+++ b/transport.c
@@ -448,12 +448,12 @@ static int fetch_object_info_via_pack(struct transport *transport)
 	data->version = discover_version(&reader);
 	transport->hash_algo = reader.hash_algo;
 
-	ret = fetch_object_info(data->version,
-				transport->server_options,
-				transport->smart_options->object_info_oids,
-				&reader,
-				data->options.object_info_results,
-				transport->stateless_rpc, data->fd[1]);
+	fetch_object_info(data->version,
+			  transport->server_options,
+			  transport->smart_options->object_info_oids,
+			  &reader,
+			  data->options.object_info_results,
+			  transport->stateless_rpc, data->fd[1]);
 
 	close(data->fd[0]);
 	if (data->fd[1] >= 0)

-- 
2.54.0

