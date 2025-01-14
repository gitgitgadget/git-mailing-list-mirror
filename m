Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE6A1C28E
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820931; cv=none; b=joacVDxdfHTo+1gmF3QxGVIyyrM9cYYrALX7IwCj1QQ1TR2XmbBJaWebfjVLEKNrAgaKczF2gp05UkfDotlo7xT1uABbXAcIFPUCJmTQnPooE7C7cn7nIKgiPr6k4xgzm8MCm1pZ1YmmSs47korjZpphvWcyEu+4DI2eYl9Eztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820931; c=relaxed/simple;
	bh=+h0HDFo3bdJ4wHhGp2kbQQEXVSfQJD8tNPFJgwAQnqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ar4MJZfM2BRKylQN/7BB0V9/LWEklCiRKelP1ZMKUOgX5xwE+NKyOqFzXTR9mtCluRJJaxc/wbLsxUfHC8Pr3pNv3PP6JPA3HT258ua/oyjfCVqsJc3BdFLMi0zO4i+0syTMTgvlvygzM4fveIB9RETw1IXsTmQ6l7FR1f0qDSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlZHyNrp; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlZHyNrp"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467a1d43821so51034491cf.1
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 18:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736820928; x=1737425728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERVjA08E5HyJCLNIWeU1AsRWjK8rZvD+7prWlEyJSYE=;
        b=mlZHyNrpqObm8O7rN0hW4AOp9IK7I+23PisfVHGPgTKP2WSr/Q5kl6weCiKeUKHj0q
         FIo5jyDuybFRw4FIlkH0Z7FPX+37O9Q1wLPsl5Pg5B9SmBeKCoFg58u3s1lvLjcRuRJN
         xWJISAS1DFrGPnm0KdkUKM+gjeetyNOKrj+Z7rD3rGcHiR5bpCiwjiQrNucx6mmX+5yl
         rOp8fU/0zD/1SQJm+53NaLRIY+TAS23ndWOVowXm4k8R4lk37TtLaFP3MIE/DF79Tjgh
         b/C53lQVSXeS8UN2VdrBTZ49M8xa/5FYRR1mDK+x422l9qm4cEKSAqkWS0Cb9aIyXQCC
         2+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736820928; x=1737425728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERVjA08E5HyJCLNIWeU1AsRWjK8rZvD+7prWlEyJSYE=;
        b=ps9vLWD1yIIKR/DS5NbbTUgq/M0z7G+KaOYPv2KqUNDS/KJGo6+VtoQeJ4rllDYJ6T
         QgMMdkgDbk4VtqgDPamaO6u8tZqA8JGrx3hczvoyh3+qyBLDb2JfDcaiBYZNtaAOiyVk
         vBEtxL5MvGG3FhQ2qDEIpIRoRI6tNHXkZA4ItaMIKD5wUI9sYeb2fvpo3aI28Z96amq7
         aBzM72eIKuryU4HFXWRT3xVw5phR/r1SJVeTJTVAyRVW7LyJ6FQ+xwHQEmM1MxBYsSqM
         kM10BVsuPQpOhY+GR5ESGuDnxBTZyy1zJsIphkq6rCq8AUUiT2dDAAmktfxcT3jjEsNN
         2s7w==
X-Gm-Message-State: AOJu0YxX2W9Qk8/5MuYcGHljO0McehmyscRGs1SPA/ooJo23IoquMl//
	XSRv6Vh10TMdxmsGzAyPkaxlvlz8Ic4Arg15c43qq+TFr8cH9IH5koRYYavHTSI=
X-Gm-Gg: ASbGncu80x5mRDeAH/7+Mg+TbJGBoMyEKTPWiO7GGKjjkPvPtNb3OktlYOW1mJxs9Of
	XaqKBP6DfkjmvHZj42KJFxebMpePgVOTNPtIBEzj0sXzuEjgqfoxb9HKkX5WkNnnJ6aEa5Dm0Gy
	eH5BmReEKAlxojBm9rx3OUWOv8XnFuT6lUVPB6kk88lgJc6Gg4LaLs7tD+wMUvuaKFNrMJ4LeQi
	26mKiyfdIGsBPFyujC0OAA1uJVZUja7OWjQ1T+qjzVRmmi9HIVYyp1fZFetpB7QC1ICu9WS8bKn
	K5fbKz0=
X-Google-Smtp-Source: AGHT+IH229NBUJdV/rLBxr+EOzlIxIkqCwYGciWVp16Tq/6mpWrAtALenI6tTvdfMCNkUw3EiSYnUA==
X-Received: by 2002:a05:622a:199f:b0:46c:82dd:9a64 with SMTP id d75a77b69052e-46c9965b2edmr202566161cf.22.1736820927943;
        Mon, 13 Jan 2025 18:15:27 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c8734072bsm47572221cf.33.2025.01.13.18.15.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:15:27 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v10 2/8] cat-file: add declaration of variable i inside its for loop
Date: Mon, 13 Jan 2025 21:14:54 -0500
Message-ID: <20250114021502.41499-3-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114021502.41499-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250114021502.41499-1-eric.peijian@gmail.com>
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
index 3a227721ed..f5a63f12cd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1329,9 +1329,8 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
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
2.47.1

