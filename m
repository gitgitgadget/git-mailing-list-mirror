Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0042B9BC
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721354; cv=none; b=g3EJO/GCRlHfbz3ZZkQ9PH4NesUkNnWYkrUPVD2ayhpEKo65guDNz2KBedbhKzjfXzE4bed5cUr8pvDvQt759pdQvrXLRxbrwsDo1FYUdYLgoyxzS4RfRA+/NeIAluRaylM+xS2SNWQmo+e0awbgGWD6EUg2JkqLt4ly28bMhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721354; c=relaxed/simple;
	bh=eJZCiA3SfT4ew0r7R3XPDXFgIMz4tB6YNA1/3s4GWDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhEejcKEhrd6eMUPNTTpzTIGV3A4Z1isTxAgy1pEYh2PzDZr/pmEXn8a0E/abV3Yr36d2JSxzAvL7q4gjiFINyBhRSRXzW48Ua3R0PIb+f71DOqEmucY8qx4WPWweQK0iPNJ//1GwZqdnLYNgOVGfENy8EUbsMJxcvX7p+v/WRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BX/0jRQJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX/0jRQJ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so3820288a91.0
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 04:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737721352; x=1738326152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7lnvd9Iws+Yv4PNiwqYjxa2/7Y2vhqfLzesyN2VZ+U=;
        b=BX/0jRQJEfTC75afUNjhJNP2MlnJKdHDIbzquFZbht7ItAPctszG2GEsf/Gj7OMUos
         J5Nf8pxed4W1ZXcIxNFuoa+3/wUfujqnf++vTuI74WwzARKXMuH+fZ3rAmOGXCiiMgkz
         J+syqXyqC0yqQO90aPkYFLtZ6z5Ffd9tndHil/PcgeNN/2mIcUiB6ejONUt/HrNtS0Kz
         GghNDU1TsZJFnDBMLro9uNRdOLRObMTmJDH55lPWCveOjSxHlqX3I0qYECbWxXDq9l0B
         zMwsl8inAWH5Q2fVJN55lSdKkuc5EgVqoitmNBQ7dHh5rKowAX7X8SGhtcLTR7TVYYwb
         zCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737721352; x=1738326152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7lnvd9Iws+Yv4PNiwqYjxa2/7Y2vhqfLzesyN2VZ+U=;
        b=oFiZn+6tiW9c3wctBOcsAop2mb/7aG6eYgcvsXaFlXKtdHEfWjkGKwBpg6VWaxfJP2
         j4EGXQw/wwxKPvdYDmhUEj+kOP7cdck60b0ZUodbq9IzVy2Ez5rYpPgbogh0BVfxt4rq
         LGV5LyjkqR40JsdZ2mRJjqlUXICVW+kmXhHW9lmKJdQ1CNxb2eOEzYqm5FYFYKzG938d
         J5+1/QLn/XJGmusGAOciOgNCr1OmZ5HyNirfv3Glz/e2JiDsv/fGpnLaESVu87SkJSnW
         qJwmgSqV8/h1Bzik/i5IwsARSHyyEddP9ElcKtI5vHJa3QrOB6Dm+6kR6qOnmh+0r0dF
         mDdg==
X-Gm-Message-State: AOJu0YzVPu0QF7zVR0x3C0fuCpCQmLax8e3pl0aRtYHNB/evFnZhcYIq
	xqRGwZp7IseSMn5ceHcf+iRtElmrX1wf0Wf343Wm2HDo6qJVd5caRfwesDcOd+k=
X-Gm-Gg: ASbGncv7qzrYiooLv5fJIwcZvwa/1M2UfyRoV7i5Rdq7ikkamkQLRbQtcYJySShPVjn
	PFZpxme5NqU+FU3NIGdW4VoHttlL+8l0DpPwtlckgyMp6oAefqeLA5/xmQJFvkFoU9iDwR9E06n
	YibADXPsOzmEDEs2ha5tTq7WvLLneDMDlx+8UgL5dd566FLNfwv2rcNJ2AkqY9nAOd4EYDOaYlj
	raN75S1oX8peeDGR9WKKaSmOhMz0rcENGu/LV/Nn9oGQ+2BfrxOb9DF3rBTQWkw6igN6/pSQvkf
	D9iGY6r7RO6KEN+2DTsFd+CwMoN4og==
X-Google-Smtp-Source: AGHT+IFKREMj29xZPiRC0vlBoQA04Pl/JQKt2xfpUglikl3ADsykF3aDl00kG0LJmCHlOdahwwxN6w==
X-Received: by 2002:a17:90b:2c83:b0:2f2:a664:df20 with SMTP id 98e67ed59e1d1-2f782c6750cmr48188958a91.7.1737721351824;
        Fri, 24 Jan 2025 04:22:31 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffb1dc56sm1685056a91.49.2025.01.24.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 04:22:31 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/6] version: refactor redact_non_printables()
Date: Fri, 24 Jan 2025 17:51:37 +0530
Message-ID: <20250124122217.250925-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250124122217.250925-1-usmanakinyemi202@gmail.com>
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
 <20250124122217.250925-1-usmanakinyemi202@gmail.com>
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
2.48.0

