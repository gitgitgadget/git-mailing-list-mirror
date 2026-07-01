Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE29547ECF6
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908336; cv=none; b=BJiDcdsYIE2qGIAPc1bWk56QBjQjFzedZ6ctU/2Yq6olY4OXIfp+Lvd2OeRSkRZ7azxSF/8OqwfrU2b5+qHtuW940Ew8dJRv79by/xlJCJXciSNChD6WFmH2qFM608H3ZRKYtrG+myx2HlfmYj9NXPj/XOGNlTNvcij4vzwbbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908336; c=relaxed/simple;
	bh=S8K2Apd9JlTqvjposBzihO5hkkXb5+d8KZby99en23Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVE5ROQmPByHaMUwluaWEpOiYFcpuYtYzVuqqucq88ozCQA9QvID/wlleHKsW72eM3kFNNN64L8Z97IABAbK9phL1Kwbu7eQTL9ciG5R0aDdlTVZvDR4Yiw4zwkOcEM9iqXAz0KkETxhsB5MCGVKZ5NvU5/tuDO2qoyuFB03Fcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNszSnZn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNszSnZn"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b691cb44so4004615e9.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908333; x=1783513133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnzxkSALcLAWHAHljw3Ji78HFG7NIzX5IfhYhNKPI+A=;
        b=jNszSnZnZF7xuYnmJq/ykr6vF0cJQc74vvknBa4a3v54A7SUBeDb9Dal5IXw3buqFW
         DydDAW4y8nPZEbxAtcH8NG+jjJ7FyzNZXE/w2L2OMY0QLCA6//AkcVbDQkbRYo77MmR3
         e47dKIWSluMJgFid5m6FaqD7tE2XpmTmEv9MgYYHJmFS8q/+neMYT6OcnyBJn3gwc5N4
         +FH7nNo3iaKg+/Ze3UV/0HTuvUD+olXi8cPuSoIuTbmGXieg7uoBOtpDUfOv9cTeSMmU
         3nRyBTyGaR9mQq+a/kMnIFQegifxtpKn+NwKh8fyOuH3NFWFErdadhJI5O8hoyWyPiUT
         bloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908333; x=1783513133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnzxkSALcLAWHAHljw3Ji78HFG7NIzX5IfhYhNKPI+A=;
        b=tW/LFl0ugpWeXFN82a/izN4ryhUGfr1oeFdEUphy/Z4dguJFPRt2G7g94PlcqOhhxC
         9wHvtnx8PoaLrG49L72l+bJfj7vGbnAt5LPsto9kSKjz3kVyrfSSlnCyQoW2q/XzI5MB
         r41PrjXIFrDV2ZjBpZGivk2EZbDSvfdPCK70AAH3yrNaWOk+QoNAgA4skQBV84VNnEEs
         2gS90Ru1Dtn9TlPeobWKOIhkkld8eUJ7CHh8NvKsRhqOD4F/9qXHf68xB3c4CVGiRPKy
         2qmH4ni0ZqewbehXSsLC902zKrMFkNq3CJZoi0FSsDI/kC/ghMhmvicRXrjS+lldHMMp
         jUyA==
X-Gm-Message-State: AOJu0YxpZn5fJjherSttcFQg9GcjhodKSiDf45cajrdcDevKtIRF0JMy
	HHgGq+SZooDcley3ldLFUcvO0WuqpMtETE8vnFzmHWOnjlxWsl49KA8MtX0V2WWR
X-Gm-Gg: AfdE7cm7ocXwdzlcUsyNKcZVPswGwSBclq3Mn7q3hb6HlYCkGDpdK0O9l0rQzvz01DX
	2fykKa7GfEvYXeKdEUA/AdLrLqAPmRos/QtT0QpXbguSWB1loO5S1uzhXIKPT/s3u0/j7dejxQ3
	IOKII6bfwfnogNNn4Gch6ugDgHPT4sZLFkWbZpoLJ04EBPxWemCGc5q57bCFUMA9KDF4tcUUoXg
	KH8GsnO98B5w3ivo5uyDZLULsj1DXR8cReWoZkhF4lzfvtg2BpargMazC/0YH+COEqy3TxLB8JJ
	q0jy2ZHa8glnk7s+dsYlCvjAOtUGv+c9xsADcYDAjC/GAELUt+zlfos6jiee6DA4pcvdb45GK4R
	cmD/Fxh/GugoCWh0o26LoKMR4AlNJyPdWXpoYtWMDB3ZOldMB+luJJGZODesQ4h/qZY3BnDdxKy
	LcOJoJOsmvs60CaCltsy2fhhZmDkxA9HzCkRbNfsQ3+ZUBku8fYWFhvCbzkzF6OKwxQYJgS9TlA
	trflMS7mNJWUp944J7be1Sevc9+72dUnbL1GYNcxkoRpbyNJaybzT5ktHhXtLtqw7P+8wYG4iAE
	Q8opDRxV9gFH44q5XgreD/3ldXEB/iZojQIXGKYb6rEPDY9a5N4BaZ8P6cfPPepN0USpB8XQl/G
	NkNfEjgD1ayHxdhmLOyuo
X-Received: by 2002:a05:600c:8590:b0:490:b2c9:e284 with SMTP id 5b1f17b1804b1-493c2ba2397mr17186835e9.30.1782908333290;
        Wed, 01 Jul 2026 05:18:53 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm68267235e9.9.2026.07.01.05.18.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:18:52 -0700 (PDT)
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
Subject: [PATCH GSoC v15 03/13] cat-file: declare loop counter inside for()
Date: Wed,  1 Jul 2026 14:18:37 +0200
Message-ID: <20260701-ps-eric-work-rebase-v15-3-c88a43b63917@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

Some code used in this series declares variable i and only uses it
in a for loop, not in any other logic outside the loop.

Change the declaration of i to be inside the for loop for readability.
While at it, we also change its type from `int` to `size_t` where the
latter makes more sense.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c | 13 ++++---------
 fetch-pack.c       |  3 +--
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d6ef8414ee..1e5473ab70 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -718,14 +718,12 @@ static void dispatch_calls(struct batch_options *opt,
 		struct strbuf *output,
 		struct expand_data *data,
 		struct queued_cmd *cmd,
-		int nr)
+		size_t nr)
 {
-	int i;
-
 	if (!opt->buffer_output)
 		die(_("flush is only for --buffer mode"));
 
-	for (i = 0; i < nr; i++)
+	for (size_t i = 0; i < nr; i++)
 		cmd[i].fn(opt, cmd[i].line, output, data);
 
 	fflush(stdout);
@@ -733,9 +731,7 @@ static void dispatch_calls(struct batch_options *opt,
 
 static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 {
-	size_t i;
-
-	for (i = 0; i < *nr; i++)
+	for (size_t i = 0; i < *nr; i++)
 		FREE_AND_NULL(cmd[i].line);
 
 	*nr = 0;
@@ -762,7 +758,6 @@ static void batch_objects_command(struct batch_options *opt,
 	size_t alloc = 0, nr = 0;
 
 	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) != EOF) {
-		int i;
 		const struct parse_cmd *cmd = NULL;
 		const char *p = NULL, *cmd_end;
 		struct queued_cmd call = {0};
@@ -772,7 +767,7 @@ static void batch_objects_command(struct batch_options *opt,
 		if (isspace(*input.buf))
 			die(_("whitespace before command: '%s'"), input.buf);
 
-		for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
 			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
 				continue;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 120e01f3cf..f13951d154 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1388,9 +1388,8 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
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
2.54.0
