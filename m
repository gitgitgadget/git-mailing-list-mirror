Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C143B489
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701694; cv=none; b=fEt/+f1QHlxBcdtCX/56AbMNEiD5yMXw8bEO2fmU7GwyGY1pkwGaQlD+uHQte4mupd/xovHvvBzYmtj5um3qoUvUJIMND3PL/EPaSbtzw5QpLRnv2KDLYoonXcBsZcG/LU+Z1q9RqarZFzeCbj7BYwjnKYW4k8Rneuo51I2CM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701694; c=relaxed/simple;
	bh=Bnee36W2p94XD3UYp9ZZBSfOSPequOU8Ss5DlFucYpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+F4rErcjg+fQywWiSfWTEu1YJ23FspDr7dvogT77eEqG1xFga2MuIu2VJV8UrIM3a4OMsestEBJ3JDJ9lRvEjdqmq674+GRRe1RvzPidBO8rZ/nqg9lF3QnJ1kpMdRD+D/muwx1YQ3FDJEr9K11c/F8S+Anq3z1YvWH5qUwSYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwBnbNPA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwBnbNPA"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-476a130c138so1464529f8f.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701691; x=1784306491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gkAmkM6JVkhy385xVgrQ7ee8ZA94lGvMaX2peGSZup0=;
        b=MwBnbNPAStDNeF2WIH8hJnhGafFKuXT+5oPUlst2KXh4M+HFl5rOo9JXdHV7kzO/cX
         tNCGs+ANqLngMNZMG9ZOKD2o1XPCeV8hEnUim7/FupV1HdTU998Fw00VcZGeQdIiqU6x
         GJcCAadIoQ6lC+ppszO+ZUrNaQ0tSx1EcqHDCs4xsiBrUmBbXC8Q2dj7laEMy9LarnDF
         vKzvPI+8cMuG2GxdG3fcFaCGtXO5FFgsRBzNut+DeQ97wfiIyuQ0b2wVXy9PS1+wgsdG
         0F2h+5f/cDcKI3s8DkYMBFfR0UFsBY+PKljBx8e/XAzq+fAZOq2uyVoxT//Tfs+WAiOT
         ZTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701691; x=1784306491;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gkAmkM6JVkhy385xVgrQ7ee8ZA94lGvMaX2peGSZup0=;
        b=TLECSAnBZinwPgf/55eJZOkRwdsG9zqBAjRaxC08c/T8g9IH4HMMkGIdob0mW4GC4q
         IwKc3SbWsk8ZOKAvSxrZvWNr7c+mdkrNT/rzF2BtH+NbiTlI3mcwbUwNNK4QwgXK3c3V
         7G/a3dDnZ2PTgS/1BDpJOs5fI4DfW0OmutQKYYOBTFGa0yQYKY26sni2080/mc1gXUKD
         qOqoL8b3Ol93S1gLwecQi0Ak4DTxvvlex4WJNV5lOFzg8jhfbASV+fAkGKm2bj0IFDee
         2z1MN0uQcNM4e+UkJiTUI8VnGEFqjYGa58F+nqlPfOeSjkQAnCzuL0ilhGcTCrLJfG68
         feLg==
X-Gm-Message-State: AOJu0YyjxAahIpLPGKAvmhsMtK2S1NG7lR7lIlf2FDE4pTK1338qLaQG
	P8mM5SLrDRJ1tnl2kFoH6waLuUByBxYM5YRBYhEN9BWeSWzRIIm1dzlp/MJL7h5m
X-Gm-Gg: AfdE7cmpMRNyOwW9jKRbp1zzQMEgIl6f8QxLzb6EsVcWGSEtFC2tN2tmj2Vv8TxRMz3
	PACAuOkwpSCijZ9m8IbBPs+bpPrIFwNO68O6wXCoCtJeIb2bZ7S0wqGfBt+ciiMYT1Hl7u69Gn4
	l69CgA81Ib8v/CFZf7DsCiiRNLOOvlQxgLfe+kqREbNqhfKY1DLLwgRAKRF5zmusKmuEwh8PKGL
	bcZOLchmWaAdmHYoEyfAH4NT+n41YVmYxwss5tY37a99JywW25LHa0JQ11n3aa8pVHSi/GTmMwJ
	xMDChbBB1bFNe7WyaI272jVePqZ03fhm/1mlikTGdpvMwLPl+gstiutSsq49IWzNSfMS9xuAjzM
	3pS30DpUAxfVXpiGWZmeQhBPM+oiEv3/8voK2a+9bu5TpxoQEL2XIrNoUI62qtOcvuQgpdp/Qgl
	oEi0Mpz3hZZ0qQgkW+YKcEGKN0pjO0oyuz05ojoURBxTIqvJ3cwy6vfX3M0OSRmgVqFtDVIDbff
	0ufZx13npbebWj0wJ4hdREN2ctK6nUH+thmceUfC6o30MluGE5vzTO06z4XDuH4Dsfhll9TMFU7
	cvq7AKLEe8j6Jx2BlYxEXHxtBPOsj1K/oeLpuvLgoy6WcDc9ih3V4hHkYcaHlZFlSttxC/Z87fG
	n9dFPoz3i2Q==
X-Received: by 2002:a05:6000:2586:b0:470:390c:1e73 with SMTP id ffacd0b85a97d-47df071eabemr14021184f8f.18.1783701691229;
        Fri, 10 Jul 2026 09:41:31 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm63643639f8f.2.2026.07.10.09.41.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 09:41:30 -0700 (PDT)
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
Subject: [PATCH GSoC v16 07/13] connect: make write_fetch_command_and_capabilities() more generic
Date: Fri, 10 Jul 2026 18:41:13 +0200
Message-ID: <20260710-ps-eric-work-rebase-v16-7-66e07b58a8fe@gmail.com>
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

Refactor write_fetch_command_and_capabilities(), enabling it to serve
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
index c4f6ea4b0a..c2bf492ed9 100644
--- a/connect.h
+++ b/connect.h
@@ -35,7 +35,11 @@ void check_stateless_delimiter(int stateless_rpc,
 			       const char *error);
 
 struct string_list;
-void write_fetch_command_and_capabilities(struct strbuf *req_buf,
-					  const struct string_list *server_options);
+/*
+ * Writes a command along with the requested server capabilities/features into a
+ * request buffer.
+ */
+void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
+				    const struct string_list *server_options);
 
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 5e7c4f1d46..783e3474a6 100644
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
