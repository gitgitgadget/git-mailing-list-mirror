Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4A13FA5E5
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701694; cv=none; b=HXmqvtIV4EYZfldlVHiAqWLV3xX8O59vl6tYIxJaZoI8U0M/AffDkYzusqOAtSxIhMCgsUjd/5eI/q/FcZHv2WoxB5ZiNtlN45z6O0RzjzKz+tB4fcKlMeUobdFeX1U4Xj7/rS8DBNWwKRb3BcjkQv4aBcPixV43PU5kz/DHiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701694; c=relaxed/simple;
	bh=vp+uYO5Xw+05gA1ijE59mdgdHWbKDHqtG/kH/mDpA0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ig/nuBJRQfhKYHIuUOP1mo85t34e3nUyG/i0gl3/A1Z+LSKTg4ud2yUMF+J0mX74xifB/HUcvZq0ZqhfrYAOLE06BM/xtROmadnOWDPAh/hJmrE740xoJJ5SHyEu6GAsbvf0pIDha0HEP7ksAKEKDg7shNrbxszlWM7/8XzQ8GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKA1WlEr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKA1WlEr"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-476a130c138so1464504f8f.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701690; x=1784306490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vnxUQtuBg/crHTGOidTsObMZ67UAC2hoXWC8zCOJbIo=;
        b=ZKA1WlErA7CXunFB+OYSr1BXGyVlfTJhnjhUrCCYm31IPiJfGOpm8aWeWKd4MvbGMp
         KI8ZHCaxUam2IA+M9MEEHMIe9Qc/bfCKZy++2eCurrRP7BjO5dun1lGjVKxYQuXBXmom
         7/L0WYeK8WcnpVwseDCzR7eORPbioUjq1grwhcQ9fJMVAhOcFR09zR5gwRlKdKjL2/Ko
         Z1Afqtm9FEcsN/M+anwZx+c7teKnAzo/1CHL/fHDg35TD4s+sbEUXA3Vuq42OIhBodU5
         Fxn1sGyKjrCa8JUvO1C1Nmr0SjXKBngmafQcyxC9J1Bszun8pEbqkFCWG2xceqL1z150
         tGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701690; x=1784306490;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vnxUQtuBg/crHTGOidTsObMZ67UAC2hoXWC8zCOJbIo=;
        b=kA3sCLHmAhike4TIrqab7U4HM/TXVPt/ChhsFVU7iBK4zEn9QsAyj4W+nCmnXdLsBU
         Hgu5Wy5Hq4WHFsAxV0oZugM8isEgwATjjSNMna/XAdhEd3FJ31RSZDis5aKhbbuR+GOW
         wT5f+KdpjcszLAPVOmnabU1z0SzQpR7oi1xMEdPRvheRXCQUg9vZAS32k6r8EmD8x6c6
         88jyPfuQMn2gp/q3FopDg8W71ksgLH3u857PegV/migR1hHMVqD76vVAw7rc6lFKfmc0
         S03xRsYPf/ebcKNK98Py6t1/pWXPa1fIY05fioIwafrmlD+qUGPPJ9he0n6MA6LBFhLE
         yx2A==
X-Gm-Message-State: AOJu0YwpvXjafk6v/w9fUk9HJal0LvyyH8e+pxS2DK+CszvilZnTRTCT
	Wjr6L7gwqnq8dlZ0pTmdoWDuiXL2WI2Jcag5D7lWyowQ9WcuSVt8KcxpG68/GajQ
X-Gm-Gg: AfdE7cmQYJM7oSfhwk0bUVArnrkY4cksBdg0w97ZPQZWht6uDZdcYwDHlVClnOhfu7r
	y4PsvJ5wnzj9WnfeIu/oBx2WMXhdu0cGKTA7Dz06QODCJxHimQO2fMtN5EvmMMZX7Vy5gl4V18A
	prxUdkqx/oZG0gpl5Zql85IihJVDDS7x54P8n9HMhaIER4u4DUgPOBsZX3JP5nd60Tjs1GezJ7a
	V91cDBZqpOCAq2KZHh4xWWNomJKj9UmLTc0HcnOIetQoeuynd3sSDdLy4gVYmhPwWfcSYnkFedr
	Wz6lATPuMaBp4kYFOgpa/wihntWEFs+xKOSjXBTjBaTzX3NElwnG0Vmpq3LPNdfwqCvmj0s1GVV
	+T3I+ysriCWcQJq+ZjlHu6W2iWY3WT+FW6XFP+7xK21z48R/Cl0qn8gGW6nrfujZZQn9FUXyQrv
	yLzBUXFAwMxH0/abYa9/suK+A38Rr16PAAXyFo4dYOJtL8XHFw3kIBDWawbc0T5N+bvdAjJ5epD
	44OcEH0I7hFxA9IuALryG9CteePfGS/3gWDFsPrZg+1n9EpQ7xus2IKy+Rvr1kkuzqCI5K1wb5B
	04kQ6KaQrX7XpVmLlY3gKaCcJ2aRq2A8BEGfphFbxOZoV9c6JGxdoHJD815i0Md5i8iNtyP04ZL
	grlHyleFWkoiqOo+uoQOe
X-Received: by 2002:a5d:5d0e:0:b0:475:f100:35f6 with SMTP id ffacd0b85a97d-47df0770d5fmr13386952f8f.51.1783701690113;
        Fri, 10 Jul 2026 09:41:30 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm63643639f8f.2.2026.07.10.09.41.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 09:41:28 -0700 (PDT)
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
	toon@iotcl.com
Subject: [PATCH GSoC v16 06/13] fetch-pack: move write_fetch_command_and_capabilities() to connect.c
Date: Fri, 10 Jul 2026 18:41:12 +0200
Message-ID: <20260710-ps-eric-work-rebase-v16-6-66e07b58a8fe@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
References: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
 <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
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
