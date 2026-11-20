Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193324;
	b=q7kXz4OxX/oB0ByRNVBArD/KmTT19hKDRgOsRjuVwVlG6nahE8Hd+r32m2CZQNh1A00N
	 R3XBZsoDPNVPyCPrwiFfwyMldAAN0rhYa55Otu/hovsaXtB0g6EWgIa3jy6QEvqvtW8YV
	 oREfr260N9AzAfSxBCBVt5Br61VRtS5lFvl9vJycRbtBG2xwAa5HJXE3Z12p0THrT/soF
	 4shrx+tsXwrK7KTlkoD74lIjyBCFpJh0yFt9Lnxqb7a9FbT8km8g610c9FQ2QNv8J67AL
	 g80cdTs2uWeKHJoaYljbsUNUw7qjrJeTPtJMwiHrYlBVPmkKk63f2j2BOefJ7B3ENuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0HnpkeSKttY0OlPreWIeiUqj+iQpSptfnhLEZSrwlmg=;
	b=HJGKVBRu1/xjGQ6to8xD9yiJO0/Sl4K1juwC2oTqdqk3n215U0leT9pqOjigEZBNSmyQ
	 W5grVQ1Ue6+rz6iZCLYp1+784ibvS9TfYRqrObULVyb0zK/94lUeYOfaifvVlt/TZcRP4
	 S2cL+j3nSvS0MOt1ySMu98PKKJ7Vx43G9m/FvdmVaMuOkjGd6QclYME69cKLA2Gt8wfZT
	 d/Dchlbim7ChE2meD7LGDwp519Zb4e1gL/Y+qsFRHzKv6OQRy/ltTOO4JTsBfj2IyNaBM
	 6ZgL0KSV8n6jX8qKRwCv+dQNhYJjTXoZ5p4dBBn2tTYZI6xVhWNdWpFqBoOIyYRMO/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wVxhA/Ms";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B5606A33B
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB9B5606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wVxhA/Ms
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so909270f8f.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193322; x=1795798122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0HnpkeSKttY0OlPreWIeiUqj+iQpSptfnhLEZSrwlmg=;
        b=wVxhA/Ms9K1vyICHftFymykF0AoeE/i//5+Az4bFkQxui2FUYoJgoAfOUxw16pJCNV
         VFwF5bNOhBvjxMmdnXZsrdwR5jh+e7sLmXoVrdKGE3LTIeIRR5PZJ5z8VBKI2FDz9pwd
         DG+IPQQD3DRN+yz59QGnZ9wYl80dqZWi3QRobA5SbqBKMYieRprJB3AaUIQ83F8AVL3D
         ZpcMi89V2QiUJxl0PIfGyES+nFZXPOjSISYkfUBn19f/y6Ny6H3tS8qaJL8agYIGuupg
         Wolp51IXyB1HeM+75aR7H0D+O6gGYxSDtdhJNFCSgWLxvX5OavibWoOApixAxrZNIwVf
         b5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193322; x=1795798122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0HnpkeSKttY0OlPreWIeiUqj+iQpSptfnhLEZSrwlmg=;
        b=F8jb+6SadXcLG/DXEGQstGt7OR0EiLAxwGi58zAOvjE0E2/UoUrW7LNLK+wPLz88mt
         KN/qgUW3/zG16TNceuwJm1+F2uw9ZtvHJRHOG4cp7/BauGYNqHynqc+tLbtI8QfF7ZuT
         wbNtnqQPJr0QdkzxDIe6rMf374wc7njgz1Wp2nVkmy9AOWEZGnUZ+UytNneh38zLcDAH
         tR3IBZf5F7ziwrvuVVSUavamooQVeG/u+IAlwbn4cNIz198gPbYn2ahifhl8rY9Zwqnm
         90fbk7OjVHJix8awNIgZxJi2Sqo138cV/GcBM0o8l2kJhq8h8EFK/8IlXhurbziKNVeX
         5UKQ==
X-Gm-Message-State: APuU4Z8DDMgVxswh61QxAUB2J3xYZgJzqzvh1ibuA1A0jWkqHw0yB5R5
	sbrn6tLBUTBYZWa8Fg7A4K/NLVMnge+BtDMhjqIJHpW9rJfxfsPoDtgno2zCwA==
X-Gm-Gg: AZFdTZfuXhRhEpojRdcjZfRXyPSdmgcwVjhWjBlpon0woStCCleLjZyj548kaOJIlDP
	RtFv5Tx4AMvqb/xTGd+95z15zSozKdSIvG8Sm068tReUq9puioWB6OGgv/4IkatMHojPpgkKy2P
	KGkVXJJxqx287rGptDD9i1Sy55WMo7+oOA6TxrlrI1n4shPtCpDkg3rHE2WHjxaqKGaTIbaKnxu
	RxgnvAK1EKIt+Q34sUzbWpLohHyPitukhcaTy3dVRLVnw339yOe1+9zN6fCmeN0aEK4iJuBuJFD
	uZseM0J5GYudLUIwQD1KWf+/hfhdZG1CbcbHb+aWNfsmvcVkgB/SKJ91hnEP9svPwMhVhI8Yp3a
	7MOGbnSVBL11n6lwIXyQCc+Bbz2m5NZrx+TfazdfrazVa1M3SQTKhqz9AWQBIhekWf5t9jukxw3
	irZQrPsjHNnSJ6cRAku3i08H+LRFr8xG+UR2e0bNZL6AcuAo0gFs+wGJ0bPrxvs1tyh6FIdjQrM
	HMctJJo1ZNrGC14KJyFH8iQr04sxlh3y3UUAw8fiFvmF/Bqu1fRnMYElW89OHr+w6HE/TPy9apZ
	Vz5jIao1d5owoU3fNWPTtx9AUx3qcb5idLSUrr/95kecR5+yFr/gX3saLrGPd0k592TT46sOzS9
	Cxx55TO9WxShPCRuVsynJOPQvBiW4G7TSmsqbRYYooc1Y9aOlgQNRzdbI3h0H6gg+4DRB9GpKJe
	etjnMxOFaSeCbcjZ/l6N9bFnpB/TUuUM7xG4fQ/Yg=
X-Received: by 2002:a5d:5d0a:0:b0:4a8:eed3:760 with SMTP id ffacd0b85a97d-4abb225faa7mr8146193f8f.31.1795193321898;
        Fri, 20 Nov 2026 08:48:41 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f281sm6232752f8f.22.2026.11.20.08.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:48:41 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matt Cote <mcote@nvidia.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 5/8] connect: use write_command_and_capabilities() in get_remote_refs()
Date: Fri, 20 Nov 2026 17:48:18 +0100
Message-ID: <20261120164812.707946-15-christian.couder@gmail.com>
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

As previous commits made write_command_and_capabilities() more generic,
we can now use that function in get_remote_refs() instead of
send_capabilities() and the open-coded "server-option" loop. Let's do
that then, which prepares for removing send_capabilities() in a
following commit.

Let's also refactor writing the "promisor-remote" reply into a new
add_promisor_remote_reply() helper function. This duplicates code which
is in send_capabilities() but we are going to remove that function in a
following commit. Let's declare this new helper in "connect.h" as it
will also be used in "fetch-pack.c" in a following commit.

Note that the order of the `ls-refs` request lines changes. After

  "command, agent, [session-id]"

it used to be:

  "object-format, promisor-remote, server-option*"

but now it is:

  "server-option*, promisor-remote, object-format".

This should not affect the server's behavior as "serve.c" and JGit both
accept capabilities in any order after "command=...".

Also note that "command=ls-refs" no longer ends with "\n", which is
harmless because the server chomps newlines.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 connect.c | 34 +++++++++++++++++++++-------------
 connect.h |  8 ++++++++
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/connect.c b/connect.c
index 1d923978ba..9d5585f72b 100644
--- a/connect.c
+++ b/connect.c
@@ -501,6 +501,21 @@ void check_stateless_delimiter(int stateless_rpc,
 		die("%s", error);
 }
 
+void add_promisor_remote_reply(struct strvec *capabilities)
+{
+	const char *promisor_remote_info;
+	char *reply;
+
+	if (!server_feature_v2("promisor-remote", &promisor_remote_info))
+		return;
+
+	promisor_remote_reply(promisor_remote_info, &reply);
+	if (reply) {
+		strvec_pushf(capabilities, "promisor-remote=%s", reply);
+		free(reply);
+	}
+}
+
 static void send_capabilities(struct strbuf *req_buf,
 			      struct packet_reader *reader)
 {
@@ -600,26 +615,18 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 {
 	size_t i;
 	struct strbuf req_buf = STRBUF_INIT;
+	struct strvec capabilities = STRVEC_INIT;
 	struct strvec *ref_prefixes = transport_options ?
 		&transport_options->ref_prefixes : NULL;
 	const char **unborn_head_target = transport_options ?
 		&transport_options->unborn_head_target : NULL;
 	*list = NULL;
 
-	ensure_server_supports_v2("ls-refs");
-	packet_buf_write(&req_buf, "command=ls-refs\n");
-
-	/* Send capabilities */
-	send_capabilities(&req_buf, reader);
-
-	if (server_options && server_options->nr) {
-		ensure_server_supports_v2("server-option");
-		for (i = 0; i < server_options->nr; i++)
-			packet_buf_write(&req_buf, "server-option=%s",
-					 server_options->items[i].string);
-	}
+	add_server_options(&capabilities, server_options);
+	add_promisor_remote_reply(&capabilities);
+	write_command_and_capabilities(&req_buf, "ls-refs",
+				       &capabilities, reader);
 
-	packet_buf_delim(&req_buf);
 	/* When pushing we don't want to request the peeled tags */
 	if (!for_push)
 		packet_buf_write(&req_buf, "peel\n");
@@ -634,6 +641,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 
 	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
 		die_errno(_("unable to write request to remote"));
+	strvec_clear(&capabilities);
 	strbuf_release(&req_buf);
 
 	/* Process response from server */
diff --git a/connect.h b/connect.h
index cff987ae38..00afc8c95a 100644
--- a/connect.h
+++ b/connect.h
@@ -44,6 +44,14 @@ struct strvec;
 void add_server_options(struct strvec *capabilities,
 			const struct string_list *server_options);
 
+/*
+ * If the server advertised the "promisor-remote" capability, compute
+ * our reply, which also marks the accepted promisor remotes, and
+ * append "promisor-remote=<reply>" to `capabilities` if any remote
+ * was accepted.
+ */
+void add_promisor_remote_reply(struct strvec *capabilities);
+
 /*
  * Write a protocol v2 command request, along with the capability
  * advertisements, into req_buf. The "agent", "session-id" and
-- 
2.56.0

