Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7AC3CE083
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913698; cv=none; b=dkfTer3DYTDPaplX1dyb7G+s5cBNjB4KPdfDEf0s47I2mna3MYOM4eKWCTXBivoumrdMhA3rRWW7DE87INMMOKX2h4ttOkgC5ndFwtKpy0NbwMKyJY07KrDYpLRjYK6CfkwMzlSUPmrzBzwp3Hk6VaPjDk44JDquL/HzPHd1nkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913698; c=relaxed/simple;
	bh=krpAPUdxei3UPXxMylFrZYK6jaA+nqlDCRBLUV+jdLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZvh1xF6Y8OGjNyrHJOgKUCOLElEAFB65aLmMDlSfqNMBwK95M/ilnLf0HFrWEwGzP02PUfDNVC8bklGMT2CTllCj44n55GF09eph2RNhmZDsuErtW/EencGNnpyHKI+e28yk7F7noN5ayBvvhBPFztqw9hrn7KwdFdM/QSMLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQnhC1wk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQnhC1wk"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-46015dc517aso3314669f8f.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780913695; x=1781518495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+D6U0a7mQ5Ty4EVr5wMRO6JPWxts8zrp/uGXLKqfFs=;
        b=RQnhC1wkPV9fk7um1KJG6xtwc8NY/zhOhGC3oFV3wSU5z5j0LKKqBPTcnUQCKTqjbP
         5cMx6RAIXe5uCVMkBDQbV39lkE0MLLDrk5HNA8pNQ1uueesy50tEJYUOw6WcP1YyEJuU
         hon4oJfsOF6xU6AMzuCfC62+QMdghU5P1xQwEMOCG/rTIz5lirov9UxcpeQzJmynYsA2
         t/8mgnKwNWuPd0kQ204cWF5GcGiEjlkR9CxmJZshM82uiTr+GEYY00TxyzDjt/OdAmZi
         MLLBa7G9SIfkbhN2CQb5t+tmUCaVZJQj9oh4GA3QEnNuIyIGMgrxCnQxrDwp3H7Mfu/e
         5Hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913695; x=1781518495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3+D6U0a7mQ5Ty4EVr5wMRO6JPWxts8zrp/uGXLKqfFs=;
        b=HQGC/DdOlvGyKbQctsMYAfQsIlgvDMXi5sss1Lqzu4h5CYkrDp7G3f1d0Pfvhs+WFu
         suglbuAerHIQWaPdtqSYVanrZLe03DncwCFqcCaQLPEQR0FvwiIlLv0lhBM82V/0UpkW
         ph/FqBMc8NU5aul3JcnnLqUUBWxy/TAc/SaLy4To0QM07C5AqF+qHYq/KOlS5+MMPKL+
         2TS919c4T9YXR43++6w/w5rx2iqm/MkHxoelmgkWD78E2T+MZUrV9nbxm9KKTrGK7GDd
         tZs5KhTAnSqXxwrQrry0KiHf5SF6H0kcolQXltFEWoNNUTa260fD6I6rYgqWnFl5myCQ
         /6wA==
X-Forwarded-Encrypted: i=1; AFNElJ80fg9hWUp5mnHFD4+EWd/FGvjwSVrTCmF/57Dn4rR+Lcw/2mGSIJYw9IvdlylIPIDrk9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzco3iFID6zx130sj+ModLlv3F4U4dYpsX6rsO3/lkMhxFveMSR
	Nl4Xf/fQalymBheHwUzr9u7aCQt3g2hyEdCEl7dnwZYnHA9YS12s8exT
X-Gm-Gg: Acq92OGKXY+kqOqgl7jJNW+YAFFpGjU1r9z4DWYeuwh4oiHzZRlyRsBiiNq2BaO6Tbp
	Lcu+b+gwMUSEbukNYnIPyIGUSycRqJ/3mgrMPottXSIA5VVB1Ix0VFUv5hXt5Ec3OeJBXUlH88c
	CiFLK3zhIHpbAxIgz+OONjcWbwfPSuHrFwm8Z9tCXQfo3vXg2OSTB5/Ay145JlVlyEa1l7HxNAv
	5d/LeSbRhIxvcuzO/h/zZzx9eCsu23OzRKgNEMrqDgp3yB501NvhBYWrsxwd1FGr7HdyT8aHY3V
	NeY2FPDm9xkLpScsAxwcKQJ/lcsb+o4k+obW/xcpiT5M6SO/vRvHdjO7PEk+Wtq7axMKR4Qbhwb
	MtyYy/Nh2R9mdwNswqmTQjgZdnEt+XqEydiAYMpwY1D7pqKLeOdInmnsL675WNExrMXqFN2+0tr
	kz/rCZmUabx1LqvZzhK/qKBOcv00u/wf6cxHFdqt9hXKx10nwZnjW+yMYw/pMG0+f9wRFLmC7x/
	N7/BgJHOESXBvh2IfFakXFTs2wPPMvcifvSc72LpQx33T82buGolTeBS1VND3M7gdkIhAseMxaz
	U0UPWYGemiIed7ULM0Me98RQ4VzNEeZugZXVNMr7ruRtI+BhV2mv4f9g9EU8NYVG9Q==
X-Received: by 2002:a05:600c:358b:b0:490:b591:b5a1 with SMTP id 5b1f17b1804b1-490c25da474mr267823745e9.32.1780913695385;
        Mon, 08 Jun 2026 03:14:55 -0700 (PDT)
Received: from localhost.localdomain ([188.87.4.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm51131949f8f.0.2026.06.08.03.14.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 03:14:54 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: eric.peijian@gmail.com
Cc: calvinwan@google.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	jonathantanmy@google.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v12 06/12] connect: refactor packet writing
Date: Mon,  8 Jun 2026 12:14:29 +0200
Message-ID: <20260608-ps-eric-work-rebase-v12-6-5338b766e658@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
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
