Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10F01FE478
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164719; cv=none; b=MlrHpXrsmMcaipxZmS4P5+sHAb+AKBlJwdbJPxQamPszDmrXO81fb6sgThm1tnNCTvH7ixstMURUiBCqRaBPYLh1qDsTBJ0vvfhUyf44+6ky9d3Rnc00xoXM78wRp4uB62OMXL9P/CHlRePzn1OrRcRpd5+0EZVovXaXKfU2EQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164719; c=relaxed/simple;
	bh=SjEnCrPrm4Qv2ChtweqKFDdVkF6Z6tpZKoj0tRMLrls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGwtJ4E/0w9D1+Yx5GjHKHfhGnQE1uVEkfT10Dzn+qcBIA8/vTKkQE4M5N+VGv4yITIZIk5okZFglYNEP8sEA6Du7eVUbjNqJwLD/hYJEbCVCyMtOL5aTKyK/l5OhkFjKEomfe3ygnozpJ0eyJg6vwZ2v3zZQ6sCmyGcFk9TwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgWI7Ncc; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgWI7Ncc"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46c8474d8f6so22130061cf.3
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 11:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740164716; x=1740769516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b83FKPkXpJYK0zzWmboTAHheqaybnwW+PnOPiPNB0C0=;
        b=RgWI7NccTZkU1wxucojrSwSPjp67PJRUnSm8IabF3HEv1Ei7yafl0RVqk/IN3JiDwM
         Ujm9AI17ZJsZz5gsnlSguOFXY5Y0PNeHkti1mLFtrOi9ySaY0TboKYj4e2Dj8slAnS0s
         RUo8emmXZmhm9Hbdardve93/vunahCcOKQkazw9xApKV5/5cabnCsOUVj717w005xo3B
         THM66ePXxUd6lkVFKipDQ7Qzp2eJU42pBpoDsqX7VrRzoWwHMTLgZWyWaPntd8h6NZov
         iF8y3YS5C9Nt1JmwCBCbq8KaOESnYUL8cbfptUrHcc91Ti4UmkOyzWMpCEjpWBQyn/aQ
         OM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164716; x=1740769516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b83FKPkXpJYK0zzWmboTAHheqaybnwW+PnOPiPNB0C0=;
        b=uhmEiUDkby290+PkhH9uVhnlwxMByRl4nbKjCEZVb4Vm1kKa35ZQWpYre16RgNEIzB
         c/AFRz6fNMHc+x5TKNnEZmZQQE/3vRLpn4oeg0mI6gO1Dxx2KtxQzIuSbjerFV3z/TCt
         UpZN+aPO4JGXMqdPGH+MvJ2s8k/KzjmjWob1Z/SyNMKhBGhXUSu7pDEIfLhISG80dW0h
         zXlb0GDGHZvEEfu8fkVjpeWqFUy1AzbGWLJtoLBhAY05CZ4lCFiVL4MER/8VnyOczeT5
         zjWE2ltVeXEahFcZ3aEmieNshJmqPKjA487Yh6CQyw+R/ALq3zeITtt3ULUJfUPW95mx
         p3QQ==
X-Gm-Message-State: AOJu0YxpL26sUVRXbtDUxQcOVEDQNYvbN5UoOhTVIDScdruxOw1hmizy
	4m4vxAG/NkMYCwThtGsuSLhA89L1EmqpbaZzOGClt26m4MGe76jNthl/U2WNrPE=
X-Gm-Gg: ASbGncshmAGWHyZ3ly1/GUkkoOX/MjYm1fN0YYpuVyzVl2SQhFU9L30qGl/+CFaol0J
	iAnSTlMu33CelMirdBChdAEy2xijoKT4vVeTZ7ePQwjsx3X9m+R4U17LdLRsUcfjCrH0XXZVfl7
	ITnZgYePu/+S7e2Qd73gNz0Q7eOmUFt1uMjU3TtmHv4Iz4iAB8Mh/HTYNI3UdDwjpHoQLlbJSXB
	kPJSy592l5Yq+GXvt76YIPsUiIkjzjIvk2GZpiIopSxROydVFurq/J8NIYd9TsjuGoEp+dQ0n2t
	FdIrVK5heNqGLeaR3KOBJGkkTvEgkmfqAaZLJ6fmTR9SPNH9xDoj
X-Google-Smtp-Source: AGHT+IFq9bXsT7gzLqKZn35JBKuqbIlNSFzNoiLJjKOZMLajH8veY64XdWEANx6J5d9QXhLtFviFsw==
X-Received: by 2002:ac8:5942:0:b0:471:f790:3cd4 with SMTP id d75a77b69052e-472228e0a0bmr62807671cf.26.1740164716548;
        Fri, 21 Feb 2025 11:05:16 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720b1fe010sm32945661cf.60.2025.02.21.11.05.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 11:05:16 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v11 2/8] cat-file: add declaration of variable i inside its for loop
Date: Fri, 21 Feb 2025 14:04:43 -0500
Message-ID: <20250221190451.12536-3-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221190451.12536-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250221190451.12536-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some code used in this series declares variable i and only uses it
in a for loop, not in any other logic outside the loop.

Change the declaration of i to be inside the for loop for readability.
While at it, we also change its type from "int" to "size_t" where the latter makes more sense.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
---
 builtin/cat-file.c | 11 +++--------
 fetch-pack.c       |  3 +--
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b13561cf73..69ea642dc6 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -676,12 +676,10 @@ static void dispatch_calls(struct batch_options *opt,
 		struct queued_cmd *cmd,
 		int nr)
 {
-	int i;
-
 	if (!opt->buffer_output)
 		die(_("flush is only for --buffer mode"));
 
-	for (i = 0; i < nr; i++)
+	for (size_t i = 0; i < nr; i++)
 		cmd[i].fn(opt, cmd[i].line, output, data);
 
 	fflush(stdout);
@@ -689,9 +687,7 @@ static void dispatch_calls(struct batch_options *opt,
 
 static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 {
-	size_t i;
-
-	for (i = 0; i < *nr; i++)
+	for (size_t i = 0; i < *nr; i++)
 		FREE_AND_NULL(cmd[i].line);
 
 	*nr = 0;
@@ -717,7 +713,6 @@ static void batch_objects_command(struct batch_options *opt,
 	size_t alloc = 0, nr = 0;
 
 	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) != EOF) {
-		int i;
 		const struct parse_cmd *cmd = NULL;
 		const char *p = NULL, *cmd_end;
 		struct queued_cmd call = {0};
@@ -727,7 +722,7 @@ static void batch_objects_command(struct batch_options *opt,
 		if (isspace(*input.buf))
 			die(_("whitespace before command: '%s'"), input.buf);
 
-		for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
 			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
 				continue;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 1ed5e11dd5..71fb2ca054 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1331,9 +1331,8 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	if (advertise_sid && server_supports_v2("session-id"))
 		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
 	if (server_options && server_options->nr) {
-		int i;
 		ensure_server_supports_v2("server-option");
-		for (i = 0; i < server_options->nr; i++)
+		for (size_t i = 0; i < server_options->nr; i++)
 			packet_buf_write(req_buf, "server-option=%s",
 					 server_options->items[i].string);
 	}
-- 
2.48.1

