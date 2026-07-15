Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487923CEBA6
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109151; cv=none; b=TLAh9lsawKthKjLMLjiY9acYGTq+hAJgPIfr3nPJUPmP3mN1pPWyj/2Oq2KFlgsvyGBCya6nTVYSzMGOgrrgS4U3LCuqWhBmCieyyKxV5qf4fRCcUCr3iHKcdaU17h9W+vZj2wHAbSbJdRQHO4mFV2a3177030sVoFd3n0Il4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109151; c=relaxed/simple;
	bh=6k0kMfYnJmCwIdPkWssD5zEV/eauRPzgV77mGG1iYGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlE6Sc3XigDIqpkLOfI/E4y9ZKr3DYgZ/Cw5n9qvrpVu839HMbZcscvD4vlWgPinHgt/Uk1oNj7tuXaCHhYKT4Qa1s3DvqjUHl6WDMMxK0r+kKkOd9RN+2wNvHhqwP8yBP+vQS5IYRHbPc79PUYyzwR6QCQVlgYgMlxFPNOiY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pub/zbRI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pub/zbRI"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493f60208a5so44497715e9.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784109148; x=1784713948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xDH1k+iBTJ9gcIBuqIu9IzburDWmK30cfWuLZdlEKtw=;
        b=Pub/zbRIWNEApxB07BBPKdQsZiTPRK1/0fV+dJMeLWb5lQ+kicZU/e+1SDuA8jQPsO
         A+08u65uFmZg4TWA7yDxy1S46GlKk+EnftZcnw5bozXSu3GryEb56OR4Xao709l4VeK4
         o2e6DUq7exWOqmvgY+8CzeL0JCvu4Mk+yJTei+Jid/wRzWgdMxPqyyNWeVhDKoNpMMcE
         1ZNU56DViFzXlJYs/0oQrbjjNDdrNIsEQaRCMK3kBxqZktgcP0L/3Kw7iM284KjpK2q1
         96SPklpPpRYNve4b+LyvH3kKme7iwrxl0qwDrLDVH8qcpv10sbl/SQmKz9zhx3Zg3MtF
         OVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109148; x=1784713948;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDH1k+iBTJ9gcIBuqIu9IzburDWmK30cfWuLZdlEKtw=;
        b=DvDy1pavXmHBtwFCNzyxkjw56d1HidnujykW1iEXgW0BIw8X0s05jiXiwbgUVIlfy+
         nSFe/jPp/LDFYeLlyz2uTMUebI4BFqn4IKSy3qXKNmqYFaT4koG4sOVQfEVgICRyEQUg
         WU7ghDzDFw05Ofouq6znJMZjhXGR9+DFDVlUlldv/V+kcbjyP+8FLxOwcsnSQhqnOF0e
         Br2CvQeAkmzGEAjEbX6e5O9dOIJXYub1E7KXPpGu/nquZ4tsZZ0kPl8T+5N0s5fADnzL
         Cvx7kvelAuc9E/j1Cns3bMxza57fuDVBQAFSAzRhN+SaMcyF5TzSN+UYWgSjCSsv1pbS
         iMiw==
X-Gm-Message-State: AOJu0Ywmf4XS7J6q/yopLrTI5VhUvUWJ0YFVyHBiCOx3d8mORQl7e1Lr
	E/qo8n1s051pRpuouAP8+UGfOE03RzfPblNDQ8mniDv9XCTHDLsOakIKAAqAWdgk
X-Gm-Gg: AfdE7clVujXRbFoNdo1bfnCx8I8B5RTe3FvKJzUErLoDfMYuXy8ALLIy6NIx16kcyTM
	jyhziDkVcVdGWTPViElRsxcpPET0IDFfbLoDNSm44wbUVgaGe/xW3JCavvjLPEz1BckpVDxmgkD
	kb6OA5ftvdHUMhNcw+En1l/mHC84it0pfmHg9MRwzadjnXRpX2Vntv5xvab6G4Y0WZjqCmWrnOq
	bh3iCcS+hd6nO/Wt/nXWUg5TuP5rc9XsBbFyP1weMGHHEMlhA4bOqBarJwN/yxTiBs3feFoZtin
	TKUEDElYKN9MQJVVN/sD8lVyMWlA33bUKINlcFRDwOa6sODGGFCX6rKcTr5OcfGM3wV/2Vp9q+0
	uorQlS+Fv/ICUoFtgsEy8s8On1iqAVk/5w0Mf1InQH55h1ylSTAOzw5tA856H1wKkRu9ruvsiuy
	/k/zt2HE8o1mIeV1h6wwWSIpvLSG8/w5tZc4B5YJyqOiqDWyAHwgEEo3f4c1rSrIezcePhWPeOu
	6Iyg2oI7Kf1KZSX3JRAAm7wsFV4tEn6G8k1S6rJix22Kss/GmZjKKsi4nLz60cCxPQBZV3UV1pO
	kfbOJFOkHC3vD2TcVkLBdOSaORUOEi+074Zf597tcvZIMC8EHjhBQvd9hDJNnIHgIzV1IIJDZDu
	VA0zGhaOsXQ==
X-Received: by 2002:a05:600c:530d:b0:493:f278:ba2f with SMTP id 5b1f17b1804b1-4953c157140mr24399855e9.9.1784109148374;
        Wed, 15 Jul 2026 02:52:28 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm15630419f8f.35.2026.07.15.02.52.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 02:52:27 -0700 (PDT)
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
Subject: [PATCH GSoC v18 02/13] cat-file: declare loop counter inside for()
Date: Wed, 15 Jul 2026 11:52:10 +0200
Message-ID: <20260715-ps-eric-work-rebase-v18-2-34d7adb051bb@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
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
While at it, we also change its type from int to size_t where the
latter makes more sense.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c | 13 ++++---------
 fetch-pack.c       |  3 +--
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 60869b8b37..26ad07b62c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -721,14 +721,12 @@ static void dispatch_calls(struct batch_options *opt,
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
@@ -736,9 +734,7 @@ static void dispatch_calls(struct batch_options *opt,
 
 static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 {
-	size_t i;
-
-	for (i = 0; i < *nr; i++)
+	for (size_t i = 0; i < *nr; i++)
 		FREE_AND_NULL(cmd[i].line);
 
 	*nr = 0;
@@ -765,7 +761,6 @@ static void batch_objects_command(struct batch_options *opt,
 	size_t alloc = 0, nr = 0;
 
 	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) != EOF) {
-		int i;
 		const struct parse_cmd *cmd = NULL;
 		const char *p = NULL, *cmd_end;
 		struct queued_cmd call = {0};
@@ -775,7 +770,7 @@ static void batch_objects_command(struct batch_options *opt,
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
