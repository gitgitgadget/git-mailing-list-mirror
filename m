Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193325;
	b=QLoAXrNJUex16YniJXT0s1OlwWjL7mUmqtoLnMJ5CLifaP8OYrSh++honczobqVz1J98
	 E1X5ti902SraILIoJqsL9xa1+ziNAR+dFDcVdk5IwAsBuAtaShr64UM8Ta1Kh1WjefGCp
	 HSBZ8ClZkUnR0UhsWzo/gSuZIt0t85xDoysEVAoKINjSgtNcQhMXyoVd3srBu6oI+FbHo
	 wIEXXtPCPQk+a2q+Hk/94V2CJGmlJGh7h64+TiZwlwCyQKB9Mw2t+ftPLQAJeNmNr+vHN
	 jX0Wy5e/nhMNQSQnweqdCvatr6dgBi6ZoQ2+13NFy4qLx0gvZ+Y2ZAXvr2C0M9ChbEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=20cKQSk9YQ6WA68fqALYIIlwQC+6CX8Rk1fqh1g0GxE=;
	b=Rtk9zQ5nOK7k+0d9gFX4AcvroWfUbOzr5vGQ1ZjHwsNVIN93/p/WteUqjAHlfi8Cwm7N
	 Go88FZTr9xmlt2vE3A/2mazRofa+cIHUkEKQMvoOSEB4z/tzjPiDgcRcQbQfnhHT5n2Ls
	 Nf/HkdQ9Eas4g8I68scISiDqAnzEPu9mh3/sPSGifVIs0mT/VodNbpzpDcQgkJwPcTOyf
	 DjrHOOvEmFAx5lIuDE3SURj9VSP97/DbdbZdw2kFPmUiSw0zrKvawQ/dGK0HeJcEJRIMU
	 KZcTnNN1MjubfHF6ZO+tam1PecQ2zYFGg8dgOkNDLxgvnZinQKKojPwXRq9+G89hIdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BS4MiefI;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3BF60A2619
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE3BF60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BS4MiefI
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so602024f8f.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193323; x=1795798123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=20cKQSk9YQ6WA68fqALYIIlwQC+6CX8Rk1fqh1g0GxE=;
        b=BS4MiefIpn9v09Mbyy09gMXeVisf4/q+8Uzo0NtlFp9aAkXWPN8yFo9txoloMeGcrl
         L69SyfPu3XB0TaSHLHYvM7YxzMbz+35fTfP3XCRHNSaoIJOvsudA7gewbkqdNt5yg+8i
         h5CbgEgCL5WhUChDHLBM1Pj0JfTVi77Zmasm3hUMs537AmLmzY544O1j7PgZ7x5iIYF0
         XAbg1t64afSyiSsnWsNlmcMNTIM5IK6JuQEbrO9Po4I+lhSynJo+kr1thcP4e5SoYuu7
         YRyeQ0I0oGR+XOStdSF9la9RQ0tvIyxJeOp51arMB4xGvYpzq1JePJ12iUlFo/60la81
         V9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193323; x=1795798123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=20cKQSk9YQ6WA68fqALYIIlwQC+6CX8Rk1fqh1g0GxE=;
        b=IBRR4jRj7PxUY8LborkD+QvSq+tTt7Q9xUoLG3go8NNPk3RTjpCNXNxN5W6CyhUCgU
         u61QMIFoHFqUQfUbtP3wb8VzhJZ9a2ks2exv8MFgU3jGpxlrE5Y2TA8gMwGpWRwFOpt8
         keCv5oHTT3GApYl8aIoq4EEQVlrux3gOb7GimayukdZAfK8eBOhPnaLxZPHiOPcLMKNA
         Y+HgHxOpshfNcQyC3X9EIorQT94EnJwB+jL8oNxVptc8JDS6M/Pqzp8Z2i+mRqeNQ2UV
         JIRhrpcG2cJQs/M0+maQSgHVYAhXqEfgt/Z2qbrvU4k9UokX+KQYdCUupJTYW4veLIR8
         ASww==
X-Gm-Message-State: APuU4Z8Erx89FjRpKzbC4PshR8/i74AkymmMH+mSIpJ4PJQKsW7Nd2DR
	UsFwDDDDIbMtPkRHeLI4/Xnia2X7LQ8dKVylGaTLiKXf5GD6QSoRAdyiKIzxcg==
X-Gm-Gg: AZFdTZfmJjFCqQLT02MJgF2QgsG76UF0EM2hYIUn2MGVuXf7d4pGA5gsfOv62VgCVem
	hqiGom6uLoI0pDlcuNIQ1SIgn+X3XQlvFdGk2UzaLqbCC9mQVJ+/JHvxsOm1gHSc7grqonjmMTo
	TUxmu9yzeiDJLzN+m3FEamc2GxM8gxknnfvd9bzixEO3LcnW509IFIw/n9g5Fe2+B1zFvFh8vue
	eFPOTWkj7hYgwndr8hmkAPXN16BQ4MjGVJ8ENICEFqg4cDx60ZhkmlWCPje890m3/OyOyA671Ym
	5beKBeO2i0lRycW6jzpdi1rw6T+Ld1ZDPkK+YbGof29Bpv8zVFQHKrIGwDI2fpjH5KBeHi6qH2S
	jR7BrixcgfLxABly5q7oyi8/x3Y70UfVq2w0X4VfcHmMTRASnW/tlWjc0IgPPrUFa1rA65eUGlb
	5S17sORwcr4QkFlIHlIpQjOZRycwcT1kgZNWf6IdOoClR49htG15mf7N+tUkbW0g6eTX0QwF8V2
	/owjy6xu59uQupv4ZcS5Vvpp+TXB7MWZ70xsxPZEvvK5KkNj8Iw/NqYWuaj9ucqdtNsNjV1jOYs
	jmndJeoBJ8jUQ4T2tXBW3MEW8dkl0n+TCDZ7SceHNi7wozTTwuH+/oehr7+D85keGy+n7HVH01G
	+GmW1D9fT+9fbG6Wbs6SS3D/D/IX32cjNcuopkg/ww7yfUKdTx7D5ftodZ7Ym5keCTZpR6203EV
	tkgFZRtpezuQaCkQzWBd0AxJW9j8G0W3XPwDG4CYQ=
X-Received: by 2002:a05:6000:47ca:b0:48f:bc05:76fc with SMTP id ffacd0b85a97d-4abb0e46a55mr4518035f8f.11.1795193323250;
        Fri, 20 Nov 2026 08:48:43 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f281sm6232752f8f.22.2026.11.20.08.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:48:42 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matt Cote <mcote@nvidia.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 6/8] connect: use write_command_and_capabilities() in get_remote_bundle_uri()
Date: Fri, 20 Nov 2026 17:48:19 +0100
Message-ID: <20261120164812.707946-16-christian.couder@gmail.com>
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

Now that previous commits made write_command_and_capabilities() more
generic, we can use that function in get_remote_bundle_uri() instead of
send_capabilities().

Let's do that then, and let's remove send_capabilities() while at it,
as it no longer has any caller.

As before, no "server-option" capability is sent with the `bundle-uri`
request.

Note that now "command=bundle-uri" comes first on the wire instead of
last, and "promisor-remote" now comes before "object-format", but this
should not be an issue as "serve.c" accepts capabilities and
"command=..." in any order, and JGit doesn't implement "bundle-uri".

Also note that "command=bundle-uri" no longer ends with "\n", which is
harmless because the server chomps newlines.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 connect.c | 49 +++++--------------------------------------------
 1 file changed, 5 insertions(+), 44 deletions(-)

diff --git a/connect.c b/connect.c
index 9d5585f72b..3d0afb2d27 100644
--- a/connect.c
+++ b/connect.c
@@ -516,60 +516,21 @@ void add_promisor_remote_reply(struct strvec *capabilities)
 	}
 }
 
-static void send_capabilities(struct strbuf *req_buf,
-			      struct packet_reader *reader)
-{
-	const char *hash_name;
-	const char *promisor_remote_info;
-	int advertise_sid = 0;
-
-	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
-
-	if (server_supports_v2("agent"))
-		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
-
-	if (advertise_sid && server_supports_v2("session-id"))
-		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
-
-	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
-		if (hash_algo == GIT_HASH_UNKNOWN)
-			die(_("unknown object format '%s' specified by server"), hash_name);
-		reader->hash_algo = &hash_algos[hash_algo];
-		packet_buf_write(req_buf, "object-format=%s", reader->hash_algo->name);
-	} else {
-		reader->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
-	}
-	if (server_feature_v2("promisor-remote", &promisor_remote_info)) {
-		char *reply;
-		promisor_remote_reply(promisor_remote_info, &reply);
-		if (reply) {
-			packet_buf_write(req_buf, "promisor-remote=%s", reply);
-			free(reply);
-		}
-	}
-}
-
 int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
 			  struct bundle_list *bundles, int stateless_rpc)
 {
 	struct strbuf req_buf = STRBUF_INIT;
+	struct strvec capabilities = STRVEC_INIT;
 	int line_nr = 1, err = 0;
 
-	/* Assert bundle-uri support */
-	ensure_server_supports_v2("bundle-uri");
-
-	/* (Re-)send capabilities */
-	send_capabilities(&req_buf, reader);
-
-	/* Send command */
-	packet_buf_write(&req_buf, "command=bundle-uri\n");
-	packet_buf_delim(&req_buf);
-
+	add_promisor_remote_reply(&capabilities);
+	write_command_and_capabilities(&req_buf, "bundle-uri",
+				       &capabilities, reader);
 	packet_buf_flush(&req_buf);
 
 	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
 		die_errno(_("unable to write request to remote"));
+	strvec_clear(&capabilities);
 	strbuf_release(&req_buf);
 
 	/* Process response from server */
-- 
2.56.0

