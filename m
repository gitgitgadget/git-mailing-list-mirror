Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E683C345C
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029524; cv=none; b=lm27seEJqaCwFX99fEpHY3pejVinTCVu1tR8D8qKCBhs7OUg8vdM1J9w43+LGZM4ZhiyhaBFQAELyutoo9daJPBg2LzWqumhDVBj6fTXA5zKOcIdoOFHkTIPK/0FlGCKAHac7cSRYbj4LRZuOCef4agSRuFcMYoJTprTC2Fp2BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029524; c=relaxed/simple;
	bh=vp+uYO5Xw+05gA1ijE59mdgdHWbKDHqtG/kH/mDpA0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sauyC32Fcsp6Jnqtzb5InwBngY+Gxf3FlXmWeYze4zjrryZ/c5uDJvjdH9+k5OFprFNODY0fgY2wGvA6IeFEjR5H3vfYAbqadq+W19eP1AmM9iSYYXbwnVGe0nnhq+3wmEVnL5yh5ctLmnYkhThzwmHdKVnL5yOxa0tKLZWit9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9WSIOFE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9WSIOFE"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso32635295e9.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029520; x=1784634320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vnxUQtuBg/crHTGOidTsObMZ67UAC2hoXWC8zCOJbIo=;
        b=a9WSIOFEMySBUg7xv667eoStWRP+CZXWfx1Tzh6hKBXSnNEBR0R4KWkzhUxlolMfHe
         ukOqJb018Z4HxYMxJ7OUTyCXMU68nxCbd5pPG/9DoQdZAm/qEc23msP9Qi6zpa4tF63o
         C5bH1NHdDbnhmooj0yADIuwZWVty9++2llR2wGvWQRNj811dfLI65LQYPlGNfjawU5hV
         lI3zrLJSQuEMZTW0hDCw6389hWge4bgsib4CkgHRLRUEy0Cj9KI1MjAIZPQwZM6YT4Yp
         kI9ld2Yi7jUu1ck+xycolBSzT7AoynEOENWeDCcD6SiRYh0Mu3yKCRenFXN5NgXaEHO1
         trXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029520; x=1784634320;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vnxUQtuBg/crHTGOidTsObMZ67UAC2hoXWC8zCOJbIo=;
        b=YDtVGg12caEaOxu+xK9SuhFw5vCqcdtTDk481Wx8bg3k0dENzzvBKYl53xcg/Uxl4g
         WK/zMTx8UhVTK6thouuzDMoCIZwSe2dX3maiXDrgapNTF3oMCaHZMMnfLTjyt3kVQ0Bt
         vIUUyL1rAQs0tfaaGkVDMNr8g1r0XAH50YBBPyJ1hF3GfE00FJJRSFFIcCQEF982KRYJ
         JwzeEfzYeBBPG7TyFc7zrRH1eftlcSPpkXpGeMQoxGTnX4hYCeRHEDPh5jCOJRpe9H4a
         8KweA3KJbKouRtxSJMWYFOZ2QXThu316VmRAo7OnxveDx1nJMsJic40jmD7qlnBpW+5y
         w9dQ==
X-Forwarded-Encrypted: i=1; AHgh+RovKhX/A/XQj0VFwNUwq+4ajr4hYPexSrZiy+Zx4m44Uer4U4OhMbDga0Xz5PvopqLWhwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZdSstwTi475KLOJPW2RCDtyKQL5s5xDZ6O+I8+98Mb98GSKiq
	xfi1R+Fnr4o1VMq4PuoocNypktM1RvaGzPT5UxoZcjERCk1Am6N30AwY
X-Gm-Gg: AfdE7cmpXq4W98bVN0NquJZzr22C0ALjsJTznS8Athz22eQKO1fxYTtKxS2HBrJgyKL
	6ui0zNFWH9JIYrfwTDph2/r781XIs7drshgChRE4JW52iPcL96eFEX2Em/S4aVpgyaPDdjPLasm
	ZlwNx/7gMunXm6/04ya6U5Zo9cb99Z4Y+mKXpiTQeDWwNS98ttEmf3tseT58iHvnvyA/mYE5O4a
	PeNFJQsUSCJcr565LhTV5ePBGjpf6dM49LbGNBZXtuySyALKG8MfFUuwkhDS6ugIFaKFkxs4tG+
	egS0k9umDNfs7Duce+EbyuP7/cCP08I7pK7EpnY5lSdpSNy84/8s4DcyYWwO8/4E2co5sFw04Rk
	H9R7p9W+vgXEr5B4D15zCVoBQ/NSjmcX+5c1ZFTC0JzaNtXTDQQe81RmrSGYaDlEY0X4d+xWuW1
	hdkEW0IwmbgkOOhTUMiZbe8RcSSJHsYuhj9EjCA2eseXgWt1RVIlc3ATKt9O6GBGiunAKfS67bp
	LxMTKiXKeYd+uQZdVLNVDGsDfxpKS7zp2m/ZvBEBJrnw22E8nRy3zvQszNdvfHPwiXxZr5Kc/wx
	EfKQ0s3jtmw44zvGkohEbObRyUrEUmxR1asw23SfAJ1UQP4PprNtLBE4EfTco3FDWjEIugFuPRV
	q1xk5JNODDoBQ0OFJxOsA
X-Received: by 2002:a05:600c:4585:b0:492:4e1c:120 with SMTP id 5b1f17b1804b1-493f883260dmr136934965e9.32.1784029520385;
        Tue, 14 Jul 2026 04:45:20 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm179791355e9.2.2026.07.14.04.45.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 04:45:19 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Jonathan Tan <jonathantanmy@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH GSoC v17 06/13] fetch-pack: move write_fetch_command_and_capabilities() to connect.c
Date: Tue, 14 Jul 2026 13:45:02 +0200
Message-ID: <20260714-ps-eric-work-rebase-v17-6-afabfc83260e@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
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
