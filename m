Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4C3E0234
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389626; cv=none; b=Ytff9GXXxIhuUjkHuUxdSWcjqOY8+i0TtUs5921rLY174OYYv4lLi6rNp9gstSsjtrFMuHyT7193qLROSHrEZntI/IKquelfdVoeUuughmGLaTyMVRDwzQnNNUhNWmXnKVOjOL52NLkTBHsak785yaDjyi7AWR8t04PVI6ausvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389626; c=relaxed/simple;
	bh=fdOxmRzXBi47Gk0QGVtNipDAT+6h0hQhl0fVwYsdjrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5E4UZtCv9whmC+gM8dPR+jNEL0P7kOlNGCk6MkKn0pPP+tCajylofQEbrjNun1IMLQqnrDLXlqhotJxgVBAaknQlFPXoniz/RqJi5LKbDsGKdBtO0pXlXJ7168UxFMx5yerBQMZyWeZzpQZpeOlZjTNTIWx43+8pMrTxDBFTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8e2AySg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8e2AySg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so21541655e9.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389623; x=1782994423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPok4xX9ni6/En8EfFk+Cfoi6gzWwrDKin6kwLPRsg0=;
        b=i8e2AySgBAhBDz9nbaBtz3YMIo/6N6483VL1LDVY+TRcnANi9S5Bgfd5uEg5Vzn5h3
         k8wOq3IhOZfy7fVXDcLJScEBMRxDHA31cWeCRgc4eqw9P+Fe0J1t/TfL/8AmrpAE4WuQ
         ifIzO6wgVzQe0Kt/+/nTTrV3X0VOwjs/rTyn0b99SkHrYMq2iKlUowkedKZeZQC705qH
         7cHefzyFr/qxIOh3pHkkkqZEwGxT7rqefy6skpkwxoOkRzBPorjr4sx7pT+n9kFT50ls
         4/ojdTEzI8o0VWsDxtYdhY0ezzWsuaxqNmLLixnyCcJrYKEkIDk7wvaz9+UysP59aZRZ
         Zd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389623; x=1782994423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XPok4xX9ni6/En8EfFk+Cfoi6gzWwrDKin6kwLPRsg0=;
        b=ReVLAvQpVRdRBNRV+HqBv/qAClgnSdOvprwhDd0L/39K3CNjHjTQcviQPICNEd0B86
         DCpkLRCOibtPsvU+l77Qf4mz8WrM8RPIffic/BLVHT/2KDr4iCNHaZZRWUcW3+VK6gWk
         r6tA6ngtI/Beh/fJmDadBdH6BeQPqGwejY3jR/0mFX11tzJr0wT3W6/zkUOhq5tR8MWb
         Mu5AKMcmsAWDc70/sKJvHnKZ1pk4+DGhYhJFk0dKFaSwGRYhEfLM1YfMUSROTDMPQGJL
         nR8Yo6xSIvYb/GEnl9ejLgQA5iCH3q7sOjC0htygB0TySRMd/XhsFtQ4G1d2u2XGZkup
         jeXg==
X-Gm-Message-State: AOJu0Yx1aUMhsLkAfAOOgy31F5FHdpooPkBoBk04MF6ASD/0MQDNsIYI
	rXdc2tK/wUhmn/nk5TK6KSN/ILdNHFdOxPryaqdkDiDO4B5HwY3zH9baZYV5Ev0B
X-Gm-Gg: AfdE7cmQhpmxRnS/Li6JdDO6ol5EPGpcfSWSahi/9vPwCtct1SCrucMRXTHMLc8S0bF
	YiMHdPtCSaCt5APNH0991xBYDokt+YPG4BKqP4NOxs4Sf9yayLNS75x/LLhuECgJR0HiqltglwJ
	RjQspEY6kS1yx0ydHSDdXkZdztaJ/EzFbI69f6dHjM5vYfy9Ex09lWuE9W0L247ujTYLNEeRy1+
	/InG+SZvgc2o9TcHYWBsGcdcjthyRAeKhV5NUpviIPb6py+AixbNc681yFASuPTh362Zzkuk5Dy
	eoX24UhtVEIh2/+B7bBKgYUWk6LgiNI9yiH7CHYWWBEAKzMvp18mkd74sRihhVnL9Jho/nJHInV
	tRBBQWbydmH4XKvxViC/pUzXGDhE5UuMDGCKLccB9nLMQ+E5ijqIG9moAtAwXcqD8lADQ9v1F8/
	JZwN/gUd5gmAhBGbqfzByeys6nT8blJxYuNYxFXcakJq+JiVvMJ0mhSmTn6OYREXRJ/Tjqlp01T
	tz+8E5eTM0wCjHIBkgZsKeMNt6zdKTDKjK5O7wyYwwP4PG4bWnj/KZIRMOUJxCNvWbr1jJVbxcm
	AiJupiKqIlfwcxRwhlL3s+v2jaiHdQyj3vM7YjDRpBbShi4rQ/LxMqeuMxHI5Q5QJH6kG6jl3N9
	2t/zXgteMhg==
X-Received: by 2002:a05:600c:8a16:20b0:492:62d9:4e57 with SMTP id 5b1f17b1804b1-49266862d66mr25387295e9.2.1782389623303;
        Thu, 25 Jun 2026 05:13:43 -0700 (PDT)
Received: from localhost.localdomain (62.174.236.137.static.user.ono.com. [62.174.236.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660adaecsm62207245e9.5.2026.06.25.05.13.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 05:13:42 -0700 (PDT)
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
Subject: [PATCH GSoC v14 03/13] cat-file: declare loop counter inside for()
Date: Thu, 25 Jun 2026 14:13:25 +0200
Message-ID: <20260625-ps-eric-work-rebase-v14-3-09f7ffe21a53@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
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
While at it, we also change its type from "int" to "size_t" where the
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
