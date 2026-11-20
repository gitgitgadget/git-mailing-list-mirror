Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193322;
	b=IeCg3vKCSMckujrmcOMh2hcwUx0wLtoq7Wxizh7Bf4V58k+6zBrNvjuuTod+QmrMQq2n
	 8O6BmTrCPdAae0uciIayx4neX1m3Jx/ZK1xipgTY1BYh53LChbBLTcomSJGQMuAQw2Yw9
	 DdkP05/hZ5hDX5gEvOA2f9apgB7HBeRhdKZmOMGvke1nB+KqFHNESLmd6fIzqv0LrMSIG
	 /RDMHPPWXTSNmDXhnZA+wIhegVc0axCW1qDqX/w/15avgAZD7QHS+JGwttXmbd2UfrDp8
	 gJs4inwWR8iVgALJPpkPXn+HTeLQjcSrWBaFp7jMvLS/kvEV/9r1VqoqQw0YFmw5pvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Cn4+h2TfuMNdAaamKB+zFZPxAdrfrIedMqPU3JSDm9I=;
	b=ZAnz8A0CmJemgpCtpKNaP+mKeSRkJXs5SAGTeVvFiSsPR5xu2vJscs37M5iJb4n6JeUB
	 WddO8x4ETlNuNxZCx6okYOrX0k5pLH24qCXlzew9Ai9xEW08QM7d7AcHW12zCio9nD+vj
	 o6Hm3NN6nHrBJ8ViO5JIYQca616sVyF/oDeu+xmPGtDduez/dvG64Q6rNQxJPTujp9VfK
	 HGzkVIXa5JlCxVdCi12S9NgsXQzFX22fZ6gmn+nG9VODTYmbs+RUnI2GxWiI9naHn3btr
	 7guynSM4cLz8GqMR3xP2kUWzSrdfDNBGDVpa9O9DozrItR3yEREEunWMt1Z/446tZOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AIwgeMOH;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4BE606A32A
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C4BE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AIwgeMOH
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so602006f8f.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193321; x=1795798121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cn4+h2TfuMNdAaamKB+zFZPxAdrfrIedMqPU3JSDm9I=;
        b=AIwgeMOHAdhIc0tXq5ZkJsYGIEdl91TzfBOGUISBSemr7XrOn5n/sdJMoFhC0sqMLT
         Pyyl7Icu/PFOqf4QjC3lPIq/N8J2sIuoUJeR2fhZ5Ac9Lc6Z2KTIYgnEMF0ApGBYFoDJ
         tCeUV5J60NPAjRlAUi51fKsJI+SUK2jE636yiT1+wPN83XgfRvszQZM81aVAC+G9CkLQ
         dz6Fg6i5f2064oxkDmVu0wZLo3TXQDYtoDihBCyPI5rj74AbYTl6wovwydnHL2lA2dth
         A2DR40m5bKCGjqvDn+Ahu/o3C+rUOWtwx74mTMXvfkmqX1bcYfjBg5IGMMYTXGrWQG8W
         rBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193321; x=1795798121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cn4+h2TfuMNdAaamKB+zFZPxAdrfrIedMqPU3JSDm9I=;
        b=L17WrLybSjsW9FzwL2hxUG7OrdHBKxATqU/tcvtQ7s3CRrhFYeTqBGOQ/8LCwQAcEo
         DXpU8l+trgHwftGkrN4qp57kVwT/L8aHB5mkU2agdu6T1DQAtQ7RoTcGayrnYVNZ/CIH
         QhZkRPxneIJeFzlxSpv+2K7iXOE7FX/UiZH+AyYI9lWSHm60A0ab8Y36kq/XrwOBUaCE
         3hWXKEefUJNCeSJmDz/GZ8bkClHYhUshW/dKmgAilcrXkd30wPv8ZBuUuHRZciZgPHy9
         xQP06J+/C19ZvaaFBoI7FlvcLDNWeKkZI4RvkK3fdQMJ9rP9RSDnlE1rUa3pLhrvHoka
         66zQ==
X-Gm-Message-State: APuU4Z+n+/SSZxQNHutu2Npxf0B39kbo9M+MjkE/S7d0hFesDuGrR+AD
	V5BVXHLw/S7NWRvNKrQh/Z2jaWRGqsqoj28bBp1hqSzoHXuS7AdD1wABQgfNJg==
X-Gm-Gg: AZFdTZdMdFRwnkfS4HqYCJiqDA9mFMGuE99DNtIQGIB9vZ+upAWzZGtm5dEVSyTh3bA
	R02c32Kdd9lmezxNKTDy5dRIR27o8/Fmwmo2einz7ED4lfRc8AemXYfkTQk0cEJPdRvpd6z44mc
	jFPrtLECJ74Y/Z7GRooweufuW16DbSDqGWT7eliLxqhpoX6HyT5ljkXLrJXaVqZD7CTDuS2NdE9
	xJ5dRYIKsh0Nk32YeZTmLqiSKio/G4K0mL76bt70ClE31gqlt8x0Q8M3nrGbfkp/z3bLWLE0Vjo
	g4drPwJmKhUQ+KQVL2jc3VRcQlaI8ogkuijfTSpoXrESHFx02H/fxPDTF65Gl7hAeM7BrGEiJSk
	gBF5BzCDK6DFFkSO8PWiWdTbG3ESkUUYL2jdk0w9d+Vofc1sX19+ggJi05UFZoZwkoiD3GIH91P
	jtn8cEytHlA/zWRc7c9UB9VoY4SuHfW/HggApQ+jFY8q4sRwZWwxtKQuxDriU7C9oqRinqc/Nr8
	RW4CXTat6wpaiENlKs/zN8kSXxwKk1ZWRpJotOoHMViLNo7Cnq4EsH55d3ga3Vd1sDUtKg3zCSl
	EkuXntmAnEChWEMxYZ835hMF9OznsM9VUuP+oc+2OCorbZR2UYHcs8jbgOY+8X/XwdSIPWtUI6l
	ySt9nd45C/t1HvkIP+08uu5Jpg6oC1Z742OXd+Tk15fgGR9qge0yRSGll+ct4AdjQoapvYeBFlX
	LNItJndWKpJlaoRC7q0z2eRdFJsj8BKCx1A47CoFI=
X-Received: by 2002:a05:6000:46c7:b0:49d:a36c:2d66 with SMTP id ffacd0b85a97d-4abb2726975mr5472491f8f.27.1795193320680;
        Fri, 20 Nov 2026 08:48:40 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f281sm6232752f8f.22.2026.11.20.08.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:48:40 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matt Cote <mcote@nvidia.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 4/8] connect: buffer the ls-refs and bundle-uri requests
Date: Fri, 20 Nov 2026 17:48:17 +0100
Message-ID: <20261120164812.707946-14-christian.couder@gmail.com>
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

The `fetch` and `object-info` requests are built into a `struct strbuf`
using write_command_and_capabilities() and packet_buf_*() functions,
and then sent with a single write_in_full() call. On the other hand,
the `ls-refs` and `bundle-uri` requests are written directly to the
file descriptor, packet by packet, using packet_write_fmt(),
packet_delim() and packet_flush().

To prepare for using write_command_and_capabilities() in
get_remote_refs() and get_remote_bundle_uri() in following commits,
let's build the `ls-refs` and `bundle-uri` requests into a
`struct strbuf` too, and send each of them with a single
write_in_full().

As send_capabilities() is used for both of these requests, let's make
it write into a `struct strbuf` instead of a file descriptor too.

As packet_buf_write() and packet_write_fmt() format packets in the
same way, the bytes sent on the wire are unchanged. If writing the
request fails though, we now die with "unable to write request to
remote", like for the `fetch` and `object-info` requests, instead of
with "packet write with format failed", or silently from SIGPIPE on
EPIPE.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 connect.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/connect.c b/connect.c
index 71d9e98a4b..1d923978ba 100644
--- a/connect.c
+++ b/connect.c
@@ -501,7 +501,8 @@ void check_stateless_delimiter(int stateless_rpc,
 		die("%s", error);
 }
 
-static void send_capabilities(int fd_out, struct packet_reader *reader)
+static void send_capabilities(struct strbuf *req_buf,
+			      struct packet_reader *reader)
 {
 	const char *hash_name;
 	const char *promisor_remote_info;
@@ -510,17 +511,17 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 
 	if (server_supports_v2("agent"))
-		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
+		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
 
 	if (advertise_sid && server_supports_v2("session-id"))
-		packet_write_fmt(fd_out, "session-id=%s", trace2_session_id());
+		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
 
 	if (server_feature_v2("object-format", &hash_name)) {
 		int hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo == GIT_HASH_UNKNOWN)
 			die(_("unknown object format '%s' specified by server"), hash_name);
 		reader->hash_algo = &hash_algos[hash_algo];
-		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
+		packet_buf_write(req_buf, "object-format=%s", reader->hash_algo->name);
 	} else {
 		reader->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
 	}
@@ -528,7 +529,7 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 		char *reply;
 		promisor_remote_reply(promisor_remote_info, &reply);
 		if (reply) {
-			packet_write_fmt(fd_out, "promisor-remote=%s", reply);
+			packet_buf_write(req_buf, "promisor-remote=%s", reply);
 			free(reply);
 		}
 	}
@@ -537,19 +538,24 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
 			  struct bundle_list *bundles, int stateless_rpc)
 {
+	struct strbuf req_buf = STRBUF_INIT;
 	int line_nr = 1, err = 0;
 
 	/* Assert bundle-uri support */
 	ensure_server_supports_v2("bundle-uri");
 
 	/* (Re-)send capabilities */
-	send_capabilities(fd_out, reader);
+	send_capabilities(&req_buf, reader);
 
 	/* Send command */
-	packet_write_fmt(fd_out, "command=bundle-uri\n");
-	packet_delim(fd_out);
+	packet_buf_write(&req_buf, "command=bundle-uri\n");
+	packet_buf_delim(&req_buf);
 
-	packet_flush(fd_out);
+	packet_buf_flush(&req_buf);
+
+	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
+		die_errno(_("unable to write request to remote"));
+	strbuf_release(&req_buf);
 
 	/* Process response from server */
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
@@ -593,6 +599,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     int stateless_rpc)
 {
 	size_t i;
+	struct strbuf req_buf = STRBUF_INIT;
 	struct strvec *ref_prefixes = transport_options ?
 		&transport_options->ref_prefixes : NULL;
 	const char **unborn_head_target = transport_options ?
@@ -600,30 +607,34 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	*list = NULL;
 
 	ensure_server_supports_v2("ls-refs");
-	packet_write_fmt(fd_out, "command=ls-refs\n");
+	packet_buf_write(&req_buf, "command=ls-refs\n");
 
 	/* Send capabilities */
-	send_capabilities(fd_out, reader);
+	send_capabilities(&req_buf, reader);
 
 	if (server_options && server_options->nr) {
 		ensure_server_supports_v2("server-option");
 		for (i = 0; i < server_options->nr; i++)
-			packet_write_fmt(fd_out, "server-option=%s",
+			packet_buf_write(&req_buf, "server-option=%s",
 					 server_options->items[i].string);
 	}
 
-	packet_delim(fd_out);
+	packet_buf_delim(&req_buf);
 	/* When pushing we don't want to request the peeled tags */
 	if (!for_push)
-		packet_write_fmt(fd_out, "peel\n");
-	packet_write_fmt(fd_out, "symrefs\n");
+		packet_buf_write(&req_buf, "peel\n");
+	packet_buf_write(&req_buf, "symrefs\n");
 	if (server_supports_feature("ls-refs", "unborn", 0))
-		packet_write_fmt(fd_out, "unborn\n");
+		packet_buf_write(&req_buf, "unborn\n");
 	for (i = 0; ref_prefixes && i < ref_prefixes->nr; i++) {
-		packet_write_fmt(fd_out, "ref-prefix %s\n",
+		packet_buf_write(&req_buf, "ref-prefix %s\n",
 				 ref_prefixes->v[i]);
 	}
-	packet_flush(fd_out);
+	packet_buf_flush(&req_buf);
+
+	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
+		die_errno(_("unable to write request to remote"));
+	strbuf_release(&req_buf);
 
 	/* Process response from server */
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
-- 
2.56.0

