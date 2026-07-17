Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B283AB286
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300743; cv=none; b=BmARySSao9AfR9oIOp+p64YUDQi9qna76jhuMXpGPtqEVjUgRzlW6JEzJqlBbw6oFGk8MM5+4eiI+QUmjlWJ5c/tNwGAqP5Q11CzQCN5uH4/khU2gIP56Bn0Vlhzm2v1TaWbwiNC6Lwr4z6ECq3qc7qe5O5jibBBCEOp/flR8Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300743; c=relaxed/simple;
	bh=f5N5tWnhRdlIyrj5zcbsJ7/LWTSbXx3OQbDPj89FBTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aa47OP0Xj5/7Gol9D/jaysKg4CHXlXJXk5WgOVKvWrDPj46bB+urW2qu6RIsaEZmdpjYCnPzioU+3FlXQ6umbpFxdXnLcR9rF5A/KfMNdCu1nFcTwh0gacZCGmdj7EzD7cebM/H/B2z0t3vtJAutaak8xhWmRErHLYqBvtuTqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImMnK6Jv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImMnK6Jv"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so56397825e9.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300732; x=1784905532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KW8AyFp369QxJe9yYHf5IRM+uNNxxl/pg6bEDv3Cano=;
        b=ImMnK6JvXiYrmfANuIyG+OTwlLXrFAdxzpeM5gxM5gMogRtBPfTKrimuf/M2lLgzIi
         QZ73CFp7xamETqAflX58p7/PzgvomoZRIAkscHU+Lue0CI9gGPIOKI8Un71krJMWoyZu
         4SzPbofoe3oP6N7fMgTiRv3lh2NtAUi+UKoHkziiQCYq3hSs5JCTQbjQ0pYKMi0nHiFO
         2w59clFqvc7FZ6332DwCoUI5np+q9Y0XSC8iKPeeQqC3mrsPK5IVgYM5uLtOsrQNoWNS
         X2uPW/GQPuuPf2+bJemzt6fMWIu9HRYDZIgmKzLBAAIH3Oe+5QDAsh83zNcLpUPW7fcV
         8CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300732; x=1784905532;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KW8AyFp369QxJe9yYHf5IRM+uNNxxl/pg6bEDv3Cano=;
        b=JMjxnPxjLmwx6Hgb40HwmsYjCLviZfVwSyOQulG84ERXVd6Z5+sh+LFAx3+571SaFc
         O7A3XM40CVg7VaAW1JQ/s+BKzuHZXX0NzWeHGnpueF1n/NgoxlJ1VUYFyyraby6bRXQr
         FhBQrSgtWRLXK5szTq+VLLLpwWqRiwNfm9X9Rwy2luW74HyVsei8urNeCr5deFGqV7gn
         qEOavDij4xgiGls16BiLy76R5vebK9kksXe8VRAlIKwqosf4CYrf01LdzV6wM7t3C/YQ
         4CtCN8737JESLcX29TPmzg1jJG2wjOc9OR4j38GI1OIQrCQ4Wj9RxUIYYa7mBFE4TyZ7
         kmaw==
X-Gm-Message-State: AOJu0Yy3G+ULZEPGZJ6s2R9WwDIGqFK8x4RnBqkFvddjJFqx5kMcWaBb
	mKR3j1TD2rysXabsbCpMqXeVtrMiC4KzNRtJlKH52i35YYrCGxd2Li2RkBWHFf7V
X-Gm-Gg: AfdE7cmGPP00VowesWoy04vojrHI/p6dc3E0fib20DgpyEFVwxBFSUrsZfv5iYHk2Wc
	CoCtWFWE7klzy6wznofQyvyHzRyiBIzbJvUtO7gyiV4Whd0wFddVUnaxoCjdis0Av6w4QqRsp1n
	t39SiOAlGAYJSxU9A3xhnZ05tVoghikWcAo6hzvGrHMv4IEB/cUiwOeERRLosOf4Hrp4m5GcQCr
	Iroh0h5ytOQp9melc5lE/LakHJf94y+FV4sbQKjfy+5y92h2T7MkfNC75B0qOpIum/2WT7Q+W7A
	dAj8JaMD9YBn3OUfqMs+RTBj8SFVAY35i679xp+6rtW4e27tEqB8HBLUn+7dZ1GOsGBAdbRtwOu
	z9EsR35m1Ft7znhoKgZcRkcEfxc+8VoNZ8/kwPh9UZ5q2adkAaubCniIjU7HqWknB+F47RKO1uC
	GEMmP+AjrPu1qluTfO9Wq4CXtK/nlqqMUvH5cMcapJ118Ew3FP39xF63j0+O1B3VQTkWfhuVrH1
	eusjlmH1ErD9rBWOJ4frp4zSLumjLIo24UdXm6wsqG46B7Lj8qTt66ZA+LACRYwE86eCLA8X+sk
	kJHhxn+Zmha4YXBGkMJlCaEm4wl0zlcJ
X-Received: by 2002:a05:600c:190b:b0:495:4d35:5eab with SMTP id 5b1f17b1804b1-4954d5a2d76mr13788935e9.24.1784300731745;
        Fri, 17 Jul 2026 08:05:31 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm50226025e9.0.2026.07.17.08.05.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 08:05:31 -0700 (PDT)
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
Subject: [PATCH GSoC v19 02/13] cat-file: declare loop counter inside for()
Date: Fri, 17 Jul 2026 17:05:12 +0200
Message-ID: <20260717-ps-eric-work-rebase-v19-2-d4faee35764b@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
References: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

Declare loop counters in the for statement when they are only used
within the loop body, limiting their scope and improving readability.

While updating the loop counters, use size_t instead of int for counters
that iterate over object counts.

Update the 'nr' parameter of dispatch_calls() to size_t as all callers
already pass a value of that type.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/cat-file.c | 13 ++++---------
 fetch-pack.c       |  3 +--
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b4b99a73da..03afc44c5e 100644
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
index 29c41132ee..9eb8fc5399 100644
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
