Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9AA334C21
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 22:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761001030; cv=none; b=RNyIxdjoE4/YG9NcfVv6h5nfGnklSIq3shmS4SCPfDSvsnfeIZ/uX0ZyMyW3TnBbRPeYPBeiZfIcDGSBUvjXz7lonq+GujrtUCxh3Fhy2HEC+zPGAPnaseaU5yJF9MLzGBh5PRzuzZu4NkhfZc7EbJBj3rw2vhlzLcrZIRuFlwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761001030; c=relaxed/simple;
	bh=/Swe6hsdsJw5dxM722cWYE0r/UOPh/9ZS6zocrtZ1yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hru26MyLnDUNMmoZKLqOcKoTSU70WlnSyCC+rE5tBA51f/0baMa7kpd4GB7OPa6bx4AyaW/hv63y9TZi2KbEB6qqrAE74f0d4XFv88n7qx2YEJMOwxaSjAnOVBBRVrUxQwaZGMn7nBWDowOfG+kW+yeE5FiXICeLMryo/fCOU9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRTtFQTx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRTtFQTx"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47118259fd8so29271385e9.3
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 15:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761001025; x=1761605825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iUAO5FHLFYffNmIAJHvrveGYnU5nUbUePRuqBxotuQ=;
        b=nRTtFQTxbdlVy6eUuL04Qsvs4J9S/vcVYA+IuXKhVCb+d/pmqC6gfrN1nCLTyrpbdn
         B8vkREMNbS0IPEf0LF8vky/bm795ypWFZBkK3EG34Bh50Lbg9kE6DgV3kZNcYO65X2ud
         Eys2V4v0fcTXQkFILPAD0ENr04pA+z9boZbgDdfz+TcNKr9W9ohMRDkcM4Vn4VKiB7NL
         LoRunbZjox0VhWBSd7gVtlSTOi2pepr3AS2Ys4yMmbngwJGexY2jZm6xkFGX2AODVHkL
         GD9PV2KU3ZL27Pwm2vbprLS//dQouFb8XpXvy++Fp+FPrz+rnH1DLg3ajMPQffRHauXO
         w0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761001025; x=1761605825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iUAO5FHLFYffNmIAJHvrveGYnU5nUbUePRuqBxotuQ=;
        b=f9yekEGDF8tIUPrfb1WeB0N/a72nuQfmsWLgFzdKVocnz0TvtBwnwlfI8rb7ml1afj
         tcPlhBrSx8T5gxO6kvJmnZTe4gUZCX4PPdKfCy0xfVM7cCSl1zioFFt5oGOPNlkaRtfX
         03qr4Cu9vhgNsLomXefwCnvpjsYVzSamwsTKDQLxrkpxA31ksK8WR2UPHxjk85O/FONw
         o99lO4I2w7Gp//LOdu79Xxrhj6UW7F60bf+0t+iWTOz2DoQO3cx2sbl7DoiP8yKtZwrW
         rM8lJ8x8cgO9HnNm1bftHbm6OWiI+U1bLdMNGTFIh6/URjRsSSVEOIH7iA7HFnYNO6P4
         emOQ==
X-Gm-Message-State: AOJu0YyXxNrXW3zTecUnZLVPEr4mWjD8G0BMv4Wa6r0ecE7fxQ5wYJhF
	spw9QWPTYHMWKY5ohOFJaChXj001WnL3ypzGOPBU8+BcKxfuMsKLU1lV
X-Gm-Gg: ASbGncts+OeTsj7NEyZ71sCG+gRtXbI8J1QojOcB2HXxdbGSn5TUTFUVR7f8G0azINf
	u0TFGa8h5YdFf8guJ/ssgTwrbSEJcxXRg1xUEDplMnVHv1Nrynjl/0ESyCMaQgPO7cChPXCkneq
	c1h/eDumtPTaiLHzAHyFEcZgFOa1EuztlhGvEs8WvGCWVbVCLhbz1jKsPV41IXIhvBHxJMqEq47
	nsy4fAncnQu4hpNxTVQJJZCFPIj6hvHCs18tdwFMKMJojmbvG9F9sTn3fRe6FMXULFcb33cAqat
	qW4+bkQfuS9rrROF4zxva5CTUKC0lkr9vmBaE56669uqqtVBOylGbQKqwW7HJWeSZpT8nUsLlGr
	wWkEYxS+RRSryq80FackEjKn10EKn0JjnADtpsGpGMMKqh8mvWEtyX0bma1E/W8et6g==
X-Google-Smtp-Source: AGHT+IGVPVdeBcGl9A/0T4RWDt2QWAK59e9yx3RQzVUq0K1OWzNwe9ulKDhsLSRk4Yy8JVp9sadkYg==
X-Received: by 2002:a05:6000:26d1:b0:426:ed9d:4072 with SMTP id ffacd0b85a97d-42704d52321mr9250735f8f.21.1761001024782;
        Mon, 20 Oct 2025 15:57:04 -0700 (PDT)
Received: from ubuntu ([105.117.8.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f88sm16706668f8f.7.2025.10.20.15.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:57:03 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v4 2/2] gpg-interface: do not use misdesigned strbuf_split*() [Part 2]
Date: Mon, 20 Oct 2025 22:55:21 +0000
Message-ID: <a830de15ecdb5e5f45625927cb69b2be552bda42.1760997183.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
In-Reply-To: <cover.1760997183.git.belkid98@gmail.com>
References: <cover.1760997183.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In get_default_ssh_signing_key(), the default ssh signing key is
retrieved in `key_stdout` buf, which is then split using
strbuf_split_max() into up to two strbufs at a new line and the first
strbuf is returned as a `char *`and not a strbuf.
This makes the function lack the use of strbuf API as no edits are
performed on the split tokens.

Simplify the process of retrieving and returning the desired line by
using strchr() to isolate the line and xmemdupz() to return a copy of the
line.
This removes the roundabout way of splitting the string into strbufs, just
to return the line.

Reported-by: Junio Hamano <gitster@pobox.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Junio Hamano <gitster@pobox.com>
Helped-by: Krisoffer Haughsbakk
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 gpg-interface.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 1d793a56d2..420e3a6646 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -865,12 +865,12 @@ static char *get_default_ssh_signing_key(void)
 	struct child_process ssh_default_key = CHILD_PROCESS_INIT;
 	int ret = -1;
 	struct strbuf key_stdout = STRBUF_INIT, key_stderr = STRBUF_INIT;
-	struct strbuf **keys;
 	char *key_command = NULL;
 	const char **argv;
 	int n;
 	char *default_key = NULL;
 	const char *literal_key = NULL;
+	char *begin, *new_line, *first_line;
 
 	if (!ssh_default_key_command)
 		die(_("either user.signingkey or gpg.ssh.defaultKeyCommand needs to be configured"));
@@ -887,19 +887,21 @@ static char *get_default_ssh_signing_key(void)
 			   &key_stderr, 0);
 
 	if (!ret) {
-		keys = strbuf_split_max(&key_stdout, '\n', 2);
-		if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_key)) {
+		begin = key_stdout.buf;
+		new_line = strchr(begin, '\n');
+		first_line = xmemdupz(begin, new_line - begin);
+		if (is_literal_ssh_key(first_line, &literal_key)) {
 			/*
 			 * We only use `is_literal_ssh_key` here to check validity
 			 * The prefix will be stripped when the key is used.
 			 */
-			default_key = strbuf_detach(keys[0], NULL);
+			default_key = first_line;
 		} else {
+			free(first_line);
 			warning(_("gpg.ssh.defaultKeyCommand succeeded but returned no keys: %s %s"),
 				key_stderr.buf, key_stdout.buf);
 		}
 
-		strbuf_list_free(keys);
 	} else {
 		warning(_("gpg.ssh.defaultKeyCommand failed: %s %s"),
 			key_stderr.buf, key_stdout.buf);
-- 
2.51.0.463.g79cf913ea9

