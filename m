Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC1F3905E7
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029521; cv=none; b=QAvfN3LrxhEgwn7VHOmscAH620VK/DKVp+DTezCEY0eKJlMbC9H4AAmxWqAhyD/TfpL10vtcpeCk63+wFYDR26XXbHjVtPxAU0ux861Ehllq9kJdSSPe6lA/cDvVea7ichia8d4M5px/JiLmun8faEks2m+W4GY9+jANIHv15AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029521; c=relaxed/simple;
	bh=6k0kMfYnJmCwIdPkWssD5zEV/eauRPzgV77mGG1iYGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTV0OMtPXYABXOBK7fPsi/LKehqd3I/OFVK6vLs1vGCeJM+NNgLPz1yu/qkHu2mt5Vtlem45Akgo67tf41urJ18Dk/r+uSjMRLauMMFdtqlEenx5NvknNX2znSU8rEqiG8RZSnr1hx7qipds9+SFSms29p6HZtfJX1KQdBqWhgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBxtlhLi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBxtlhLi"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493f6de72faso4486345e9.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029516; x=1784634316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xDH1k+iBTJ9gcIBuqIu9IzburDWmK30cfWuLZdlEKtw=;
        b=JBxtlhLisEbHslPRqdkXUTQOKldj9tPbuAVI7TiVFKRiOypUuvdvUFnjFrygzZ5zFu
         h4jVgq6kWWcM0KQgPHQsVmk4wkZZF7pSD6ZOCyBTkgo0nYJoinABHMaNN8NSuqEhpds4
         wLGIV5fIGz0hLJAYQH/xlTk9EBrgxbqyS2TdxJaQSPoE2opehG1cckIwtDiQP5m1GeEz
         6QX5PPxyyVN2+ywVsy4WNBld7vsRU+mYuv+fK8kkXoug80cuo2Dw55Cy5YW7anT/8zHW
         bkrlA/10/pTivRqq50u+APj3NrL86yH4xGTJHN43/oxA+D1z2yYAqHxUj2jBIqdn+Fvz
         xjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029516; x=1784634316;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDH1k+iBTJ9gcIBuqIu9IzburDWmK30cfWuLZdlEKtw=;
        b=JWXtY518ClyTl/2De1yXmvwbhsvOyTmaU3Y8Hhnungnp7j+h4td4IfBnxy5GhL6cZN
         F6EzEZSjWuRD/RBW6G8xJX2FiO+YEGESPuBHcQihnyGnezGGB5oiyvU9+6lY4H8JPdxb
         XoAwX8tivEDpDvYYJ/w2EUUVip3yIaQKlLRYjYEvd+9QGnGffpDo2jgHRGCEfSgaaWzE
         n3EWfBtw7v+LRSXaJFb017Vuh5WfEQakPCPXUJcYtL4b66LUzctzn4kD6ObojIzkV+JM
         Gs5ozmA5+R6MD0BJa9+3O6tLZRJWh7Ui5Gsegv40yAnIInb4FvXJJsaaVyXAKL3NE09S
         UTpg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/Dv//ysmMbbA3Mlp3VbBf/6XXFWAaf9TqLSl1zHTw7hK05sPY9IhSsnvY7EMb65f40+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDbPj7VG6L99vCZZFAOf1GfQ97Pj7MoUzWpVU0jPsCdW5U0Q3M
	YDrPV3c+zbyLmxD6ZhVZ2egFmTu1bKz+BUYRXjUj1glm39VtHXPEHjFr
X-Gm-Gg: AfdE7clMJMLPEKYKpLwzgP9s8dT4rTNOJvtBj8osg+Irkm1MNYVVZ1Jsg8t9affo5lX
	ekGvNR6JCemoEhUTeUYeiISr3juMneafOdFJdoaEO5duRJwJvzChpFv7q6KSZJRNX6t/pVAw+Xa
	kcB0myRBlJFmLtPn9/SDHg8De+hZbuzzPkICg4A6vUYFxqzcfPzF9y3Npf86yfxL+w0baTanp0O
	8/78NYUynONF03uYgZw1/8Elm4C4NPxqhr3W6hCIdboFBrD8i65TVL6vcSAxMFrv1PSq4tbLKlQ
	i1vgmm3LP8KRPBRfK+iUnf2B5rUMLoBr334ZSdDwySZTFsp92Wo+BQF6w/aOQuw2kuwdywEZN7N
	JONdE7uq/+XFiSmMkCxu5JHuN+9Jwgj9QJHmq8fotfSDGkeKgj65ESqfn+XEQt/jagXeSDl4eHe
	x3ScOXrwrp7WVwnI9aepnXOKVAWK9vSQJAdf9dwv7A0ZltWLl6RegwCZHRrqdR2LQEAOGMhqW7m
	p4rjwBYOm+nNlVdNgVj0H1Soppy7qEzNJl7MEKCJWxRM+x+HFYtez+yyxUr3kj2mDSM7kUtOBhg
	rJOxjHvF6Oy5P9eIHcJYJSxZ+Eq6SiGojdIy+mGkSleXywrGkQv+C8MGO38wvVEO451FwhY24iP
	WfCZcMHfgKw==
X-Received: by 2002:a05:600c:6749:b0:493:edde:54c8 with SMTP id 5b1f17b1804b1-493f8885b92mr139291295e9.8.1784029515460;
        Tue, 14 Jul 2026 04:45:15 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm179791355e9.2.2026.07.14.04.45.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 04:45:14 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v17 02/13] cat-file: declare loop counter inside for()
Date: Tue, 14 Jul 2026 13:44:58 +0200
Message-ID: <20260714-ps-eric-work-rebase-v17-2-afabfc83260e@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
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
