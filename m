Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D818A6D7
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734996356; cv=none; b=LHSItQmpXghSfc6PWH7Wh0+iOcrF4iUJJi4aVu/ql3QTaRJH51oXafpUQPHYcK62uANmt1hXD3b+JOZ2L5sdZIFCeGrxQzTMkDwpfqmEWTswEwcT8GzSGw96RibwX8kfI3Wb90YKjbCZzVVEdNJ6vtaPwcBJqOYCTWxVzX3O33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734996356; c=relaxed/simple;
	bh=AR70hk6E4F2585AB9FuGf+LbJawpKuTJfk18XHW+5F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcMFA/PNLhXH3l6VO2mqSq7zMpEyexSit45gnU4okqob0EVGNG5nqPLg1uo74vrqOvtbDGShr0YQGbJKRJeqj4FH9LBzyc41b90jFWRBb+5l2Cv+3v/ux7Via5M0XGs0ogg+zQgOTDavM1gO153IQ5eoqn2E6DMHnoxP3ua95Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRpK3GeY; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRpK3GeY"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd1962a75bso33150936d6.3
        for <git@vger.kernel.org>; Mon, 23 Dec 2024 15:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734996354; x=1735601154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ED23Y9czMSb7AGSbbsyvcfCTTC2OzgzdUsan54CKZYQ=;
        b=PRpK3GeYDmL+EdWAHwBBRGqGWN3sNrjBbO0vCWTh2I7JCMIJqXRfRTW810vp6JbVDt
         MIFJB6QahKQcYuNQowoXMF+pyQma3iDAXe/enaMQiFwQQz5ybs+a0nyqo8zD/ah4AXYm
         fxxzWhvpFwpJBeD7pBZrsafwjisDm+mLpDT4+HBcwirPR6v07Br5CHs7A948h45mXLlJ
         WyZX6mJOdY7eMxrvhMiD7Qxm05qPIdP0sFH/OvVveHZSn1dBUxQbegczSesQ5QkDdjvd
         CMeObKJ1H23eScHAM8Ec12MlbvGaRh5Th2jJyLnzGTUqhu3fEL5qV1II0Y5u/ZtSZybS
         DOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734996354; x=1735601154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ED23Y9czMSb7AGSbbsyvcfCTTC2OzgzdUsan54CKZYQ=;
        b=xGrtFhxqNJ+UImL0PZtYfpK+KAvsvt64gv1hLXgaD4r87wXXrD+de1v6VyEjkiEltT
         Hozl+H5nxeSz9dHHAOj+t/tbImWjOb7gfnW+BBwm7T+tewbiywBXNex2EOmNFnfwXS5t
         kcV8CHJprZXN9U/Gha4ZCYEdUizZQm2dEmWFEza0Fd5hvodd8pmjBwuldFUbpTp6tY7T
         R582fz5q4wG6/0J3uq6sLy3fJRTdl8A4gXL+ofUwqrGNbeTeLjVjutjtwlK0Ln3gVknn
         V9VaETwjpeTU/UUJEP4cobr7aDQzeKT73VieVsQ0g1Di4FSXmGZO2rCRMVvK6imd4Chs
         JeJw==
X-Gm-Message-State: AOJu0YwqZmUv+fEdYOsrm0OpkbaFxY1pl5Rb8Y9HsAyg+206G4vyHjEY
	dfKvoBOx4Ekv7cBrOfnLpScJIK17A65V38UB8RdelnZIwCw+KoOlgGWBE41Z
X-Gm-Gg: ASbGncslYzrxWeV9cRQEgRSD9PiiDqdPKBxGbE3rM7918+cmQAYaIrtcNMUNDnvYl4E
	VE4O7XhoSoPbdrcdyowxYl8Q76paXUBxZmtSHXZeZPTQiHqMfL61kcQQTGbtKPUnpkPpppa0Ggj
	g6B6IXWN3Cq86csNiXK4sJj3gSozGrrHLHpqJ+1t9NRVclPAokirD/hfiUtx5dAK214XU9IKnQa
	idvKdkWZFtM07NXW5kKquqP/1djaGkhvkzO0+TcgZnxMBRlX1ND71WZwvzh612qkWSj4m60U9lA
	s7+VB9LEqcbr+XqHWnoW+2CqpesWBRLM/f6cfBLRXyqhiIC0g5THTBViPY6tiA==
X-Google-Smtp-Source: AGHT+IEmZdzjbBSl9FnFARcp25pWWkGIumeaZ7sofS8QLpC0RWQ7VRTznhNjO2rtsdgXcBkzfDJfgQ==
X-Received: by 2002:a05:6214:1d26:b0:6d4:b1e:541b with SMTP id 6a1803df08f44-6dd23355afdmr217932226d6.21.1734996353984;
        Mon, 23 Dec 2024 15:25:53 -0800 (PST)
Received: from localhost.localdomain (pool-174-118-208-220.cpe.net.cable.rogers.com. [174.118.208.220])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18136e56sm47672496d6.61.2024.12.23.15.25.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Dec 2024 15:25:53 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v8 1/6] cat-file: add declaration of variable i inside its for loop
Date: Mon, 23 Dec 2024 19:25:18 -0400
Message-ID: <20241223232523.76236-2-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241223232523.76236-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241223232523.76236-1-eric.peijian@gmail.com>
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
index 3a227721ed..72c6a254c9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1329,9 +1329,8 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	if (advertise_sid && server_supports_v2("session-id"))
 		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
 	if (server_options && server_options->nr) {
-		int i;
 		ensure_server_supports_v2("server-option");
-		for (i = 0; i < server_options->nr; i++)
+		for (int i = 0; i < server_options->nr; i++)
 			packet_buf_write(req_buf, "server-option=%s",
 					 server_options->items[i].string);
 	}
-- 
2.47.0

