Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A50C427F99
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890481; cv=none; b=sj1hKXnghNlOZxpLtSkzm/JaILBH9BCtVTDuZpo9IXqdkJxhQC2gFt/AB3+Xi3Ah60AgJKaC7mIUU1zr05P3FpuDyvjcajfMq2sPP3Mltc7f3PrtFCgm2rp5Atq++t+avOCC1kEu/WSeB+GpwG3mGR6ITsQJZC8FW/rRprts1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890481; c=relaxed/simple;
	bh=ghFASLbKO2e/glOr6p2JlD3WJTnkCJP7dl7lQCffyoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pN3vEdvsTnMRZE3HMNDzsKZMntM8nY1tEv9yrZt8+Ud3KvIudhPPSJt/NWw4nHTw6kidXGlmCnvzM5fxMYoxdwn7rJFG83C8HXLO54GjIgMLdwwdvDmEnsqwYJad0Aj46Asz0DH7S7qLYnVGIQ2tnMGL1guGLGMgEmwXqFK2Fik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWUow6MU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWUow6MU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954afac04bso3253145e9.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784890476; x=1785495276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1+K+Crw4YE6XNswOIdCSXQbxGNaJiMbbRPuyArqtqwQ=;
        b=FWUow6MUr6K7fPTks21YUzIYBGMV84SZMC0hVgRTufR2/DkEd7SjrU4wDe7OlAt6Sf
         1EJgU/SMTkUySNJo0tIHDVbBUyFtDw4Am/jHN+c8y0C2b1vdmD5Y4J8JDC2QZ0gzcitf
         o8NcDqYDgqOlUGFDSxcFJy82gHF18Cul8PQi//Cl07+rCkLruSQpGFRG7l6tAbTruwzl
         l+EnEsaxsCcqAvtc65longjlNjRGpG6vMDk3kNl6Akzh1CmYqPw3HCA/GNteA7G4yWal
         r82oKeFgpDCmhDtxMtJn2n0zOyb1yL44wkM6q9BAOHTO7bnCu2CthhSmJabhB5rpY2SD
         xFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890476; x=1785495276;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1+K+Crw4YE6XNswOIdCSXQbxGNaJiMbbRPuyArqtqwQ=;
        b=JRMe0D59XWv6hO6vkEdc9A3Kee6HMIjTJFgOgly1qrv3ZshyND+QoUEEdRGl9PZwHp
         cMMLclEuQ62zf6gjKrxDhATVAziGCN6LZXjV36dLd9h1H034iaRueA1arESs0jXQHraw
         jSBF1BFuuCdcsXO4S+Zj6XDQgnDlJKG4nm3IQxgO+L+A0anfkFteh/kba0DHWgEmbeU3
         ojILvOoTeaLaVqNR0GavdPe0/68v6qmI9ajszVgqoLoLnmV0ry0rcRhO/G+fgHzzVpAR
         575QBofO9ZaQQhaygwFQlLXIw7VXs8U9fpwyC3iQ8XXNmWlpB98pNQPMEi7By9LJhQr8
         H5rA==
X-Gm-Message-State: AOJu0Yy1PoDzsu06vLXY8g0Stom8wCyYOHWdeqZVxqxk3nmIoGEuzT01
	bAPGr1YgI7Kce0EIVTobTXAH+HBbzsOZl0eEKlv+h/CKn5QpYcCrK66BEUQFQVf2
X-Gm-Gg: AR+sD10u6tH98Frjl5m6EuP3eGQS57zvXbr0Dk8zCqOlWWgpyF54uYWjMOjF5kna/30
	jdEgqrY+e5rhsnmyYPdPEB10mDnd7YIcR5iLntMzZ2uyu2kFF8sD2rAMWAdqqw60l4nDPKEvBZi
	MmQkq6ZwbKHaeZYWHk3QInDQICQ8kVD9u29QE9+q8r30AtoykeJmNyoKUnj1AGk1ssdlXskAuYn
	ew4PzfTS9Khir+XwA5Z4V6ysStXlzGLBBrqZOLREAVMwtIgILDCTKrOxKsTWwOdhnniAcnSrgmx
	+GJlmDFreI1euNeOemMShB9Gfm0mvuVdbW5VjOJlaUmrLuQwqOk9fzwv1/tz5PIOJ7gTJGlmSKj
	m2d6aBW5wIHbElW+fPjbtbTUkPRgL3Hi0wxTfdCEhLis5OMHdq1DXIsXmrokmpH8pXXrDyTN25Q
	XrABfDwUFe+P2FA84PvBggAJIHGm4CNdmL+xz8kZ93Qnrpthc1lsJ5X53VD8d60rg7/GmiuaqR0
	Z0INAo3ZMvShFza2t22nKKt3G07T4wgIJxLhJwlPC/GevN57qHkluzlwpBWUN73wsL701LZ2mZS
	vfAOL5PYBdSvK3378C3wrc/iHAq8UOQV3wOwJH3Y6pnAw+A=
X-Received: by 2002:a05:600c:a20d:b0:495:4df2:7412 with SMTP id 5b1f17b1804b1-49573d2885fmr53641575e9.32.1784890475587;
        Fri, 24 Jul 2026 03:54:35 -0700 (PDT)
Received: from localhost.localdomain ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm41797645e9.0.2026.07.24.03.54.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 03:54:35 -0700 (PDT)
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
	szeder.dev@gmail.com,
	toon@iotcl.com
Subject: [PATCH GSoC v21 07/13] connect: make write_fetch_command_and_capabilities() more generic
Date: Fri, 24 Jul 2026 12:54:18 +0200
Message-ID: <20260724-ps-eric-work-rebase-v21-7-ba67f024fdff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
References: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
 <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
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
index 0d197eca84..feb0420b0f 100644
--- a/connect.c
+++ b/connect.c
@@ -709,16 +709,16 @@ int server_supports(const char *feature)
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
