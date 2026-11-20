Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193321;
	b=KmNglWDOWSTshkCAWYYUhNjOJ9zH3DpuzmxKOG+iNViuvvBeZ6ZqmtfrB06k/Iuo5Cak
	 8hPJ2PEX02+1a3DmJUpvK/TEWzfknmtTjSkdP+8panYARmyOytEh/XUUOsbj/EVlEJq7N
	 065yBlQA1MMbTHZvX5wlttAL1PR91u3sdMmwHrOkQWG7c/x40/7ZDKPc5yxWcXo5hbB5d
	 MkiuQZA/55xVZNau2A+pUu3zSp+GmWC5QGQ42VflMLpumQcmCFaz3c5prRCFycEajjKkr
	 1r2x6nK84eTPzQFoBTllA3QWBmeYYfZpfXMlMvyqB55rbXLIXFwXRF2+I/0OB3WQvWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WtBd29oF+57tnFWU20z98LbqpEm7AvEb8vDudOWYiQQ=;
	b=GAIRWDdMpfabB90fd0s0472Y1WK7VvAozPzoHN4Pij7NNptMJ+4A6TGip5rktfG/5+gE
	 N9l6iDQWARLp2+UEcP0WqgilQOD1OjJ14xnXX84FGreBh1PGGh+Kq6iZD/7QhXV+CCPv9
	 kT2XZOVyJM56PmKOwWpXqGwXpjH+bvp0B4C3d4aKupxUKNmClqAaDeO1EQKeXWDAz3joe
	 C53qq42qMySCkcEaYx1ZOvu2ANL7AgFLXtpfjnvt7bM4oH6gJL79hHyIzOXR5fjjm3GLC
	 kLiRFMMncwB+9vryxOlhpJ2iXzXKRbKpbkr9el8zjoPAyEfJyB+dGHqH9qGnne4TD2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="THD/pLYj";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246FC606A33B
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 246FC606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=THD/pLYj
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso644457f8f.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193319; x=1795798119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WtBd29oF+57tnFWU20z98LbqpEm7AvEb8vDudOWYiQQ=;
        b=THD/pLYjq/YkeNJlp0OPGz8ebhAUxpribkQXTbvo+wqCiRSNar1EAdqxz65bLNgG9C
         Pp53zvtN0skX3Xr8uO7WI63dOFl8JXq0/3N4LETO6LQzThPBK0TS+7ir072VqhIYbYUQ
         LvSGmrGWMqosDIKp+axIInlmwRLQE5PWCf+SEaxFz+IOqfhS/b8w/jcL13p5NdfYpfy8
         /2RVkxz+7zzshH93h2Ks6FAAx6HHEqrSdwnRFzs4jEzCsVLBBDjXOU1Ypj1KQn3KL22F
         pAXhzJePsoeHt7qjwgphCQ2VWIE99302dXNO4amrSokOnJ6tZwubkVI8D2tN9bY8iotR
         JgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193319; x=1795798119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WtBd29oF+57tnFWU20z98LbqpEm7AvEb8vDudOWYiQQ=;
        b=ITA3TQwaeQLAE6pGwbZLGWynsx81iS7YGQTbY/T++iMqVOE/WxVSdSscIdsdFrI+2e
         Fq81Qu2QUqypAnAOCMn7cHjcmVeYN/mM5RO3mqfEvgtXaN9tLsu4VcYVOSZ8+1XfYYo+
         qcvCI6IPdj8KxEd8fszSHV3w5zq5GDYcJ3/nYIjukrc/mTPI9mEk8Oz6PmjD85QpQ+u2
         FAjykM85MqsXUOxSvS/o20WgcmRWj5hdDCbbuydOaRjCXcU8cVSKBfMfNweN6kf2ltwg
         n+BXOPazZMvCF3ZVHEbgZy70uKMKfPP+pedn25s2dZgpPh/gRKFOXG8VtDnc/YJBDlEL
         uDOw==
X-Gm-Message-State: APuU4Z+pNCK79H/+ZdujJpTjRFgMNRfYmncXSBs/9AyowVqtQLU0Xb3y
	TN8OdNnipDIJ8e3V/PAhCsbbfoX0vCVXiZiMRTtaQH61RymkgHIfEdH5k6SmRA==
X-Gm-Gg: AZFdTZedGSipNhHQh0/n7MDG9oiED1djKkpklse38iasia8C0G/8BTRp+D2J1C4dCTM
	e6RJ2XRNnZw5x8rzReFIsSlrrLHJgZXYuo3Eb7Wq50Rei2NWuBr8H+EjXngwXUWVtmkTty9/9Dt
	bCd1lqCX1moyJNB2JuPLp4EryTKzt7X8TvBeKpYUI+VnPO2JCcLTkUQ26DRXeppgh1n6vPnU24Z
	jZBcSTUcMoEvzfeoggUY7KGI/tCrVMd3VWMCYX03wXYjF6uaYB0PBiZqt4ZZOs446L7Ec4ZENJ6
	OIbxU014yFMcHSz/jCy5fp9SxuVutfoX5eP1OW5o3RAWWXZkCg9BLVP70iKhElRIWHzp0pBwL7z
	931MpM9xhY9I+JTbc9QgikS76ru4pg98IxR3L8SngKE+gbGPA1sWAyVf/myNiRnOKUVxOPd4NJi
	PkGokjjxbrRmeJerGr6dnSZQfyDW5TF+f8ohdRFR/D0+Tx0QPpOKHB8zPFHqjNoWQC+mSIH0PF8
	WBnKjLVCvJY9mIxyXQVg/lBqkDxKbuDQgXWxFges7euWVDLGcDoZKCBB+khfi7wQ1G0Muz6hvuF
	apR/0sBuZ82qrjsff/hoQVpXJd95u6pJ8gJIgkRZ9vNY9dBsAqYNlTOqvj4hq/wLU7C2k86lQ8+
	LwQbQT2VH1z/C1T8r0FY39UXqUGHBf3S4mGGuHQhJ7uZ26EBDMPkNhzbvFfGDiuWmbOT54pLeQp
	GCaiJOoAFNpX3dNskqinqSsu5/IWVsdUH48ZY1m7g=
X-Received: by 2002:a05:6000:4b19:b0:48e:3bc4:a367 with SMTP id ffacd0b85a97d-4abb3678d71mr7261593f8f.33.1795193319429;
        Fri, 20 Nov 2026 08:48:39 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f281sm6232752f8f.22.2026.11.20.08.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:48:38 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matt Cote <mcote@nvidia.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 3/8] connect: pass a reader to write_command_and_capabilities()
Date: Fri, 20 Nov 2026 17:48:16 +0100
Message-ID: <20261120164812.707946-13-christian.couder@gmail.com>
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

send_capabilities(), used for `ls-refs` and `bundle-uri`, sets
`reader->hash_algo` to the object format advertised by the server, as
the client may not know its own yet (for example in `git clone`). On
the other hand, write_command_and_capabilities(), used for `fetch` and
`object-info`, checks the server's object format against
`the_hash_algo`.

To enable write_command_and_capabilities() to replace
send_capabilities() in a following commit, let's add a
`struct packet_reader *reader` argument to it.

When that `reader` is NULL, write_command_and_capabilities() behaves as
it used to, but when it is not NULL, it behaves as send_capabilities()
does, and sets `reader->hash_algo` to the server's algorithm.

No behavior change is intended in this patch as callers always pass a
NULL `reader` to write_command_and_capabilities().

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 connect.c           | 16 +++++++++++++---
 connect.h           |  9 +++++++--
 fetch-object-info.c |  3 ++-
 fetch-pack.c        |  6 ++++--
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/connect.c b/connect.c
index 40cd279290..71d9e98a4b 100644
--- a/connect.c
+++ b/connect.c
@@ -742,7 +742,8 @@ void add_server_options(struct strvec *capabilities,
 }
 
 void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
-				    const struct strvec *capabilities)
+				    const struct strvec *capabilities,
+				    struct packet_reader *reader)
 {
 	struct strbuf key = STRBUF_INIT;
 	const char *hash_name;
@@ -770,10 +771,19 @@ void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
 
 	if (server_feature_v2("object-format", &hash_name)) {
 		const unsigned int hash_algo = hash_algo_by_name(hash_name);
-		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
+		if (reader) {
+			if (hash_algo == GIT_HASH_UNKNOWN)
+				die(_("unknown object format '%s' specified by server"),
+				    hash_name);
+			reader->hash_algo = &hash_algos[hash_algo];
+		} else if (hash_algo_by_ptr(the_hash_algo) != hash_algo) {
 			die(_("mismatched algorithms: client %s; server %s"),
 			    the_hash_algo->name, hash_name);
-		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
+		}
+		packet_buf_write(req_buf, "object-format=%s",
+				 hash_algos[hash_algo].name);
+	} else if (reader) {
+		reader->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
 	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1_LEGACY) {
 		die(_("the server does not support algorithm '%s'"),
 		    the_hash_algo->name);
diff --git a/connect.h b/connect.h
index 2d5f9e2b83..cff987ae38 100644
--- a/connect.h
+++ b/connect.h
@@ -50,9 +50,14 @@ void add_server_options(struct strvec *capabilities,
  * "object-format" capabilities are handled here, and must not be in
  * `capabilities`. `capabilities` contains complete "key[=value]"
  * lines and must not be NULL. The keys in `capabilities` must have
- * been advertised by the server, otherwise we die().
+ * been advertised by the server, otherwise we die(). If `reader` is
+ * not NULL, its `hash_algo` member is set from the "object-format"
+ * capability sent by the server (or to SHA-1 if the server didn't
+ * send one). Otherwise that capability is checked against
+ * `the_hash_algo`, and we die() if they don't match.
  */
 void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
-				    const struct strvec *capabilities);
+				    const struct strvec *capabilities,
+				    struct packet_reader *reader);
 
 #endif
diff --git a/fetch-object-info.c b/fetch-object-info.c
index cd14105836..b7a5996233 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -21,7 +21,8 @@ static void send_object_info_request(const int fd_out,
 	struct strvec capabilities = STRVEC_INIT;
 
 	add_server_options(&capabilities, server_options);
-	write_command_and_capabilities(&req_buf, "object-info", &capabilities);
+	write_command_and_capabilities(&req_buf, "object-info",
+				       &capabilities, NULL);
 
 	if (ask_size)
 		packet_buf_write(&req_buf, "size");
diff --git a/fetch-pack.c b/fetch-pack.c
index ecb384211c..176d625936 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1388,7 +1388,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	struct strvec capabilities = STRVEC_INIT;
 
 	add_server_options(&capabilities, args->server_options);
-	write_command_and_capabilities(&req_buf, "fetch", &capabilities);
+	write_command_and_capabilities(&req_buf, "fetch",
+				       &capabilities, NULL);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2275,7 +2276,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_command_and_capabilities(&req_buf, "fetch", &capabilities);
+		write_command_and_capabilities(&req_buf, "fetch",
+					       &capabilities, NULL);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 
-- 
2.56.0

