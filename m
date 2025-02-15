Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4BB672
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739634707; cv=none; b=CW4yBgrMaoMmxJdVc9wrqZg0DlgH+VAMXHvpGrMLubOyONXCCLyhIFLpI9Mw1Ai4f3qhkCdr9LQM9vucYTvm9kwNUyuJfhjJMcgiZrSvkIRNW7QjxE4RcqG5giYDTW0KSBy1P2tJ6d+bL6epP2xJFKyEm82UTpfdd6pnHIItUmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739634707; c=relaxed/simple;
	bh=auT7Nq8j/Oj7j5e0/1qmYiFTBmU1qvLdasGT5WYJd5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uj24rFBB3pRnTJFJzpUhNqQ6zrhSfbGJ84yCMQCYL/6ja4wz/oahLeEhZe7FVp2lkMv7ZWKtXcuY4w1HwNvnC+HVXd8znUq/5GHJS25mB7l/OaEj2/jkjxq6pgVU0ufHMfs191WG77+PQHiia/q0RWMiR9O49iX64alaYsAhUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es9IDGE9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es9IDGE9"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2210d92292eso9573525ad.1
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 07:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739634705; x=1740239505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcvhFf9DLoHV/4B16FqnaOvirPJd2dOTFDpMtuyEBGY=;
        b=Es9IDGE9YfGDSPZtdZ2kQDEgWMUaO5TDNnD/PzM0hRH5FiPbPr1h7cMTkGort4xtkR
         W/AL4HSqGayAT3xv5SkJ3p4mI5f5oaOvI0xaGAo2an0v1Xje5LA687PoBP5xx9RImqXF
         0vNHBHUq0lQKHiWXdiPbUKmXU2SD9IkM6g/ECj0KRedBoSgXBAVEv5qIoAUS+yQBQa9S
         zIRaBD7imu0f6LQrUOJO1bY+dRYdu26Iddn1+6xRJWPbZG1VSuHA0lBvKjzQaQulRN7y
         lH6d5nfDEDzF7GDyMYm29bgOEdtza3yrhIxd5a49spovJFSvSKbMD8n0yUscjGAJMIg7
         ZIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739634705; x=1740239505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcvhFf9DLoHV/4B16FqnaOvirPJd2dOTFDpMtuyEBGY=;
        b=jlOUrFr7RDMaHIHOeVfEedLQbpSiB7frRX157BjDp5meoXRlefd/ZePARCSndlvY7J
         JcJChcW6mh1QdTxmsSR9//6lq0nCNWx0pCUFJfcZ4l9+Ey2ij0LCYO+WbbQTWK6cHx5a
         ch6WcEPnxN61Ui3djHiRLnW4qltOA9fJtZeHGAt2Qwq+13klNe/ZNHY2O3XLOr8tLjAq
         gUkfUvE2e+ZTOAlRwvML5ZmMdxduEUQVsb6AQzPZSJ0y70ajEZZmBDkUYtVFTa3HDXYB
         LUm9RU+d10SYq1h5KORGj9v3QEZBY5a84vBjmjKAPAIhPNjMf70N2i0HmyvWR1sgKFc5
         QzvQ==
X-Forwarded-Encrypted: i=1; AJvYcCULPuZ4eLOH0q52SRQNvsBNon2fvBbaP+9HmWKYzXygIOsg6FjQcIUMXE5HMqOncKzlbTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/uQQiYHZtzbpY7kVB5ptQc2CZtelerkHxHesm+ZXvwLglmdH
	F982G6Ggfrf2S21rslY1IMi9aIL5cn28GsB3IvFCR1ExW5wYsRza
X-Gm-Gg: ASbGnctfrmx/c4o/4o8zhoDM0rZQS4VzrkT4+yyrmvriEaRrYVyJdy6Vn6D3KgSCjNQ
	h2TCcdgB3fPpmI0ZgIqGShJ5Dhu8pzfuBey9jKI2jeXypW/D+W1ZmoOSykADnNBIkfFLwRFEQRj
	Uh/HM/IlpAFxNfB024TMT/U9Pl/d61FF6ahXfZQomT6N/kDAfm2J4+8Tf1jM6zPND/w6Ey44iPh
	aG396FdRDwyE3zO9RsD1wE0ipA8uYAquFDrH1BMQNnCVa3PWnGxfc8dVRPeJTwaLATI+RmdjfnV
	6ZEpq/5Shdhmd7zzkPWb/nqgfv/ZVqXdRD7URL6M
X-Google-Smtp-Source: AGHT+IGZO5U5Lr3HRkh95veHwsd3A7XxxgE3BP9lvcyrbB1wv/LX3YYL5SX7IBrADEIG2xQqKGTl6Q==
X-Received: by 2002:a17:903:1a07:b0:221:337:4862 with SMTP id d9443c01a7336-2211c55231bmr5054705ad.15.1739634704876;
        Sat, 15 Feb 2025 07:51:44 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d559089asm45024285ad.241.2025.02.15.07.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:51:44 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: christian.couder@gmail.com,
	gitster@pobox.com
Cc: Johannes.Schindelin@gmx.de,
	git@vger.kernel.org,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 2/6] version: refactor redact_non_printables()
Date: Sat, 15 Feb 2025 21:20:48 +0530
Message-ID: <20250215155130.1756934-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215155130.1756934-1-usmanakinyemi202@gmail.com>
References: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
 <20250215155130.1756934-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git_user_agent_sanitized() function performs some sanitizing to
avoid special characters being sent over the line and possibly messing
up with the protocol or with the parsing on the other side.

Let's extract this sanitizing into a new redact_non_printables() function,
as we will want to reuse it in a following patch.

For now the new redact_non_printables() function is still static as
it's only needed locally.

While at it, let's use strbuf_detach() to explicitly detach the string
contained by the 'buf' strbuf.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 version.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/version.c b/version.c
index 6cfbb8ca56..60df71fd0e 100644
--- a/version.c
+++ b/version.c
@@ -7,6 +7,19 @@
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
 
+/*
+ * Trim and replace each character with ascii code below 32 or above
+ * 127 (included) using a dot '.' character.
+ */
+static void redact_non_printables(struct strbuf *buf)
+{
+	strbuf_trim(buf);
+	for (size_t i = 0; i < buf->len; i++) {
+		if (!isprint(buf->buf[i]) || buf->buf[i] == ' ')
+			buf->buf[i] = '.';
+	}
+}
+
 const char *git_user_agent(void)
 {
 	static const char *agent = NULL;
@@ -28,12 +41,8 @@ const char *git_user_agent_sanitized(void)
 		struct strbuf buf = STRBUF_INIT;
 
 		strbuf_addstr(&buf, git_user_agent());
-		strbuf_trim(&buf);
-		for (size_t i = 0; i < buf.len; i++) {
-			if (!isprint(buf.buf[i]) || buf.buf[i] == ' ')
-				buf.buf[i] = '.';
-		}
-		agent = buf.buf;
+		redact_non_printables(&buf);
+		agent = strbuf_detach(&buf, NULL);
 	}
 
 	return agent;
-- 
2.48.1

