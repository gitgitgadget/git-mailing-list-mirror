Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBBA34CFAB
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411420; cv=none; b=sIFAA45P4U1mTJp0jSlBFg+sDjhWjz+S/DIcnuhrp8+oyOg/4O19IARCEhSXWkiBJe8MtFHzeSJLw4WktIDpaXO839eEN5nW2Py885SKlZnmw9L/9flIVQxSAyJertWWyCCoP7zRdK7gnzZIVr1idN+VyTwKdLo0FgGLg2pNPKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411420; c=relaxed/simple;
	bh=oXtxDnl426mCBMPlUhOyy8NVZLhLhwJa64vE4bdrdoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e48tHVhc/qnwr3qwK6kOKPmn96aDzzJLqLLQgR8a/1YNR/At45Mjseb2XGGu0/FIMpQ/L8K/gf9MjNACAJKVCSeAzkmKCQ4qvtjnE5xuBs64vQPNkoSPGxBSrEq1I+r7w5kAGPzjhcAtSF0zk7S/RGjAyf4KmpD+WlCs9uWsbEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbGGP4vQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbGGP4vQ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4953ddae026so28331885e9.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 14:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411417; x=1785016217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cPpkno0dnDFbDUeSKUTmunU0vTYn4E6RJVsYyov0Ils=;
        b=IbGGP4vQtQfUSsDfo9w8D6oVifdSltTrC7pNqhxfFdGTRhb1S3oRYeuiU04J5Y2o71
         MuCoLvs44gZdCGXES8Y75U1ZK1glMgKUwyRyhLGSj8T3A+v4tiHx/6ZawJYtoabm08T3
         Z0GoEd/8S5CF1FNOi36MWIrI7qO19qSnIie386G3v26hp5iQbw3fjKrNwDewLY2UmCWd
         BXuPBF3hBwlfOsQKUJoI9GbivPcw5xdVrQQU/i+jWs6f7IUGwwHFeVjHMkBMtZCo8K9h
         9yJNYnnGVphkdLtR4kNJdSUpv6J/cg1JGP97XmN0Ba8kV7NqzofXfJHu46WBn7J/1L8j
         Mbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411417; x=1785016217;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPpkno0dnDFbDUeSKUTmunU0vTYn4E6RJVsYyov0Ils=;
        b=K3hnAFn3BlBb/cHDP/1RzTk4a6Nr+VW77oPr8cFDtukmYOoinKO0LeFmFRppE3lf2t
         4NS5WmD77G+bpN7ytpCBEhhOW5eV5Vjzp7gquvdJfxzxvgEMimdfKqyTHkvKRaXUyLtd
         jIPCYYjBFuUExojY584Z4AUqQPTI65T8ffxKryVV14zcoT/8ZVDmRtf8QC7Msc58Q0fd
         2gePAwjEInbIkmNt5sT0YGKnJTw3tYGfP8c0T6nQX6+xGZTskE4J2tTXO5m/c+ACVJ1J
         bdjQ6hYtKzTsmohnf31F0LdBDnE0IvSGdnMbDEg+Exe+4AOZcDYes9dXdFDM3xBUKGI4
         /Whw==
X-Gm-Message-State: AOJu0YyeI9oWeyc6ta931v+tdqR+K+qIX1Ad85ffmYVw2CrwBev3yvyr
	TZo/Qhf+6S7hauq0uFm6QzjwkzIDq4EPQpCRBXjScWIHjXfQVmkOAk7r6+UbZ2JP
X-Gm-Gg: AfdE7cmoWk+/7PIFDMQ6yfo3isiwEW7nT/+0nMaH6G0HIZM9tSPkDWACrZddrF7gqSI
	xR1GjLQ7TefDRR1ZLeBcPgSgIp1nA0JD2IxQPM5B2866AObhe0vnlbZzxRT+r8PPkMqYKzXip25
	DRKVmhN2XGvwNinqFNA/lYrW33aQzLiMase1BExYy0ukT6aSPhcvBiLXbIqANmV4MoLLUfbcEqX
	OYJCktAG7XIrOGiYzJvS+YEBO1dwiXyuhix3tmngpsHvYzgH5uM+xeWMIMJaZgrwENgzsIH4I1R
	309NgAR6O2nDSFRCUBCwBUF4NEHpBYN4iisDwBGcop9LxeViPFamWLaQcqDf42bPmSNHQTLclgQ
	pfW4TdeWf3VBntUW44buEp+Ymqh+c+9CDtNrDIyrMS69QkYPoZXbZFRKqH2fEHRoyzi4H6dzbb5
	7sb9pCK63tVihPEjKuNXffvwLY8KQ8ParcUxUGlZ7JSj6ismpSTviYt/LzLPNTUF/9izLW1Ds5P
	MB0TkMBbiazBSRIOcPZ40n4t5n+rS95/kSws9Pf2GXXCHwOY5Ct3nNceqCkrZQ6rzzzlvGwvLQN
	P+A42U6B2sd6wuMewfhuORtnOTzkLH/X
X-Received: by 2002:a05:600c:1d18:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-4954aa1a264mr86001675e9.9.1784411416771;
        Sat, 18 Jul 2026 14:50:16 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm146225145e9.13.2026.07.18.14.50.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 14:50:16 -0700 (PDT)
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
	toon@iotcl.com,
	szeder.dev@gmail.com
Subject: [PATCH GSoC v20 07/13] connect: make write_fetch_command_and_capabilities() more generic
Date: Sat, 18 Jul 2026 23:49:56 +0200
Message-ID: <20260718-ps-eric-work-rebase-v20-7-0c13962ac532@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Refactor write_fetch_command_and_capabilities(), enabling it to serve
both fetch and additional commands.

In this context, "command" refers to the "operations" supported by
Git's wire protocol Documentation/gitprotocol-v2.adoc, such as a Git
subcommand (e.g., git-fetch(1)) or a server-side operation like
"object-info" as implemented in commit a2ba162cda
(object-info: support for retrieving object info, 2021-04-20).

Refactor the function signature to accept a command instead of the
hardcoded "fetch".

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 connect.c    | 8 ++++----
 connect.h    | 8 ++++++--
 fetch-pack.c | 4 ++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/connect.c b/connect.c
index c09947cc56..127ed4a2e6 100644
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
 	int advertise_sid = 0;
 
 	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 
-	ensure_server_supports_v2("fetch");
-	packet_buf_write(req_buf, "command=fetch");
+	ensure_server_supports_v2(command);
+	packet_buf_write(req_buf, "command=%s", command);
 	if (server_supports_v2("agent"))
 		packet_buf_write(req_buf, "agent=%s", git_user_agent_sanitized());
 	if (advertise_sid && server_supports_v2("session-id"))
diff --git a/connect.h b/connect.h
index c4f6ea4b0a..957e5fe2b9 100644
--- a/connect.h
+++ b/connect.h
@@ -35,7 +35,11 @@ void check_stateless_delimiter(int stateless_rpc,
 			       const char *error);
 
 struct string_list;
-void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-					  const struct string_list *server_options);
+/*
+ * Write a protocol v2 command request, along with the capability
+ * advertisements, into req_buf.
+ */
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options);
 
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index f7789e8456..3695059cd5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1386,7 +1386,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	int done_sent = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
-	write_fetch_command_and_capabilities(&req_buf, args->server_options);
+	write_command_and_capabilities(&req_buf, "fetch", args->server_options);
 
 	if (args->use_thin_pack)
 		packet_buf_write(&req_buf, "thin-pack");
@@ -2253,7 +2253,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 					   the_repository, "%d",
 					   negotiation_round);
 		strbuf_reset(&req_buf);
-		write_fetch_command_and_capabilities(&req_buf, server_options);
+		write_command_and_capabilities(&req_buf, "fetch", server_options);
 
 		packet_buf_write(&req_buf, "wait-for-done");
 

-- 
2.54.0
