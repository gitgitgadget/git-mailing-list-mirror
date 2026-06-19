Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A23B19D9
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881020; cv=none; b=LJ2Kc/4eHOPa9eFwKwN1vFJrcnhkjWbMs/Gt7YCtK5g8QvENXwDaw/2ijnqfHanf5zAHtuW1REndtN7EMUP21iIzt4IujyfadWTv/z3ymta3I7ZOCF2IevCHduJi/poSAsw19G8Cv4dFiJgXvSJLYAaUptciIwDXnMW9rbTJ6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881020; c=relaxed/simple;
	bh=krpAPUdxei3UPXxMylFrZYK6jaA+nqlDCRBLUV+jdLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQjsF5lmBCZ8LGm7yGngLE28VN3H1BHOzTokqoItGbbqGr01c/aFy7q9QXt2u4Ah++8jRGy1Cq0bq2dcNxjJeYL0lJVY0SlGMdBY4Qf8ewAWuWQ73vB3UsCyZiDBbTsQ5+8uOmnkwOowzRDh02FGBBLiIOMCDFeQI8AlgwLhx8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxIOzl17; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxIOzl17"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso16741885e9.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881017; x=1782485817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+D6U0a7mQ5Ty4EVr5wMRO6JPWxts8zrp/uGXLKqfFs=;
        b=UxIOzl17bOr4FqqZHQjhWhAic30G1RgaFLVkfswat+mKkIqNn81LEqLvNdvq2OxdMw
         LIXBDKCAS+iHvL6WVJNeBSO1PKtTEI2ma3cIH63oCIF7eLw4vfDN/CAxJ9Lp+HnBnQrL
         JvSKZondOlHZJARg3M2JhL4KVTW/TrHqkg/It2X/iu7AwWtv07GLmTHUIxWcjez8AjcJ
         rY4w++WVt1jb7l+ZoFImNDDwMHjd1YgD2OQN7xK8ua+naqHZD3wT0AAeu/Wu3DxEiKac
         wQnf7T0w0O3U6azj0t5RWue5Nhmybpjkb4bKbYl0vfj+BWW9hFXkM/oMKmErwkLiDQdT
         sktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881017; x=1782485817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3+D6U0a7mQ5Ty4EVr5wMRO6JPWxts8zrp/uGXLKqfFs=;
        b=FqPBkCSkkXssetkkN3JoFjw7qJn7zrJsRKB8fcVxzvsFKb6zFHWsBF64fyjsTGJ/97
         5E/0GrdA2UTXDOK/0T0QYeMHKJEICxgDWhN07rNq6i23/9MWSxFxr5vv7+3swgfrVSUa
         U1+/qPwPRN4tY4XDy5o0cdM8KMDtTgn34U7SBuoGwevTMH3mrC8DZoCbuRYyDag2xWBq
         PCzJ5DjPrqzZVjecf+sNpTwO5nXBlFg8Z/ghbJtWe8ufnr91yNKVORKP9w5AH0KFt1So
         fGzIjqnTdIkVZxYjhPcU8N0YCVaECE2RhS63tbCxvgqpSM6Wih0sCfiFRWqwtL8jYYB0
         pJaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RAA7CI4U/QRW0MfPcIsWDMso2+tTg36RnGb5yEZkp4yAXeCulj4MiMO6nCYadPi5E6To=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCHACdE/7KDvUld/SzyFkIE6xV9SwTCBaGriqQo8pls0hokzSa
	rpW5ymOIfPVYcOtKQ7e5iaTJImm1lJDhKZryaGrmPVtG8UKaTrlKrCwr
X-Gm-Gg: AfdE7clnJeUx0zGr/wQxYJJGxQMOPOFhER8hwgUcLuzFjuRKMlg0+yV5W1Rvn+pjmam
	PrFw1e516yJ3+Nf5KqEX2Tls6D32PYRWdp2VxJ/a+DbZKpuEmfqs8vavmip+66lCq14v7r3xUvd
	x/p/CkUBV6kixzy3SXLxxdDEa00I5h0BCVu3/a7gkJ7107Ot2Hykw6Wo0hdR8t2KlbTBb8HjAwK
	ucQxXpBPh+zfbUc8Ou4I5oTGqvTzTihl86KSnbxv75EBUiT5wm5kjqeMRasOYNEjH741zmEKqUr
	v3QTS92W+V2v4iMIjJOKqBA3CrX5gdLOTKXoL9L4bCSbalFGkfeYilO+ByempNtFRfmMvSBftC1
	udMCeDLWjjkjt0YsrrYyh31OCXm1DBhkXUbhZIs7C5OdR+6lhry+lHzSdGWBtxOoPLwx0io9e3l
	0IZDTDxs8OKxPakjVOqzC0DPmCKwloMYOVGlzXAWHqi1wizwf7BODl7pgTwtOS4dZJ7Z/iAjXf6
	BBxt9xPD4pVz9FImYoxnlSiqMCcAQA88NQmkxmDsrqUZ+QeaWWHZX4RKWMcjBmE73oWg1YjA2dr
	Do1ly6SPspWCWFdUocU7ELGCi0hFZwQU+nQR8aryQwt/jqNuoy4LB9D/O6n6cfBQ96TIugpj8R7
	jssxkHJMMOBiElA==
X-Received: by 2002:a05:600c:3b17:b0:490:bbc1:c9be with SMTP id 5b1f17b1804b1-4924089a2aamr51321965e9.0.1781881017250;
        Fri, 19 Jun 2026 07:56:57 -0700 (PDT)
Received: from localhost.localdomain (static-204-100-6-89.ipcom.comunitel.net. [89.6.100.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc63fsm39430795e9.1.2026.06.19.07.56.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 07:56:56 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: gitster@pobox.com
Cc: peff@peff.net,
	eric.peijian@gmail.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH GSoC RFC v13 06/12] connect: refactor packet writing
Date: Fri, 19 Jun 2026 16:56:35 +0200
Message-ID: <20260619-ps-eric-work-rebase-v13-6-3d4c7315d2f8@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Refactor `write_fetch_command_and_capabilities()`, enabling it to serve
both fetch and additional commands.

In this context, "command" refers to the "operations" supported by
Git's wire protocol https://git-scm.com/docs/protocol-v2, such as a Git
subcommand (e.g., git-fetch(1)) or a server-side operation like
"object-info" as implemented in commit a2ba162
(object-info: support for retrieving object info, 2021-04-20).

Refactor the function signature to accept a command instead of the
hardcoded "fetch".

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 connect.c    | 10 +++++-----
 connect.h    |  8 ++++++--
 fetch-pack.c |  4 ++--
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/connect.c b/connect.c
index 1dced8e632..78c69d4485 100644
--- a/connect.c
+++ b/connect.c
@@ -700,16 +700,16 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
-void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-					  const struct string_list *server_options)
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options)
 {
 	const char *hash_name;
 	int advertise_sid;
 
 	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 
-	ensure_server_supports_v2("fetch");
-	packet_buf_write(req_buf, "command=fetch");
+	ensure_server_supports_v2(command);
+	packet_buf_write(req_buf, "command=%s", command);
 	if (server_supports_v2("agent"))
 		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
 	if (advertise_sid && server_supports_v2("session-id"))
@@ -727,7 +727,7 @@ void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 			die(_("mismatched algorithms: client %s; server %s"),
 			    the_hash_algo->name, hash_name);
 		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
-	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1_LEGACY) {
+	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
 		die(_("the server does not support algorithm '%s'"),
 		    the_hash_algo->name);
 	}
diff --git a/connect.h b/connect.h
index c4f6ea4b0a..8f4c523892 100644
--- a/connect.h
+++ b/connect.h
@@ -34,8 +34,12 @@ void check_stateless_delimiter(int stateless_rpc,
 			       struct packet_reader *reader,
 			       const char *error);
 
+/*
+ * Writes a command along with the requested server capabilities/features into a
+ * request buffer.
+ */
 struct string_list;
-void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-					  const struct string_list *server_options);
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options);
 
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 4a8a70b5f3..3d32114907 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1387,7 +1387,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2255,7 +2255,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, "fetch", server_options);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 

-- 
2.54.0
