Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE83C12B17B
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958056; cv=none; b=FKI4WmpcSGCGw4w/2pMA0JsjzQd0aj7ET+K1GDMu0AdyHwhgnaqnqxV158YqhPNKsDQzKwkyu/ZTOSJpPF5y/gFo4uXo/HhSJqs9eI4EETa8hw/iuwyIXPrsrz/tKqBOjQ+UqAMX++pUDBJGa+F0nSrZZ5LPkDwNwJw3iTudcPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958056; c=relaxed/simple;
	bh=WWJnBxua5uduD4QGqdX07l+p576ioyaZFlFhcGVNFf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cALZml03JrhYFHMgzM/RIM2U4uejoM1Qosrq7Gk1Ttd8kCuDXee6TeT5d1oefKXOamQoHQPFnI5dRon9wTroULvClvwwFHFh6by2bKEHRBWgQqw4ROp6+in4KrIo86382kjxVlWBe00VZGHnDOhg0y3upJ+WTst0YimHHEfcZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmYIv1rF; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmYIv1rF"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d208be133bso49144301fa.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 06:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708958052; x=1709562852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jU0YprvFCpoLlu+jpICBeiMWba1jpsOm4jNX79dN62U=;
        b=MmYIv1rFzpTyvLntXJrkq5PR/DcO2tMCW7Rs4dZKydOszxDjFuZzpB886MvqaCMbza
         uybqgF3O+pssPnLuJRGznyvbsj6mD5Uc6B87C4gi6FkjIxqmmf5xAfoX2lRYTqZDWGyC
         RebOwNVz9bkXFpvR5zlvgA3LcHK/jL5H0QX/2d6doygYrnvkY3INbzfGMM2E8mmo67Ws
         HqOaZswrtyvKudg0Elgzf+KGwe6KrvPsASM8OtbwlDY/6R1MCqnCv4C3PUCPfTwWv3b3
         Z8yU9w/tbRnuzwVZOV35Vgb3w55dHxLPdrQldCbaVd2O6EbLi9x/7ygf3brMYIcW5Rgt
         JdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708958052; x=1709562852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jU0YprvFCpoLlu+jpICBeiMWba1jpsOm4jNX79dN62U=;
        b=fDO3pX0FChaDxTOpn3hpPBfHCxQwfDOnSyKJZdNyPhHN9PGGgfIQ+1fOxbiCe3BE0j
         voQLi2SY4zkC9fBVyj3cwyt2LKeqVgueFFmGWcjYECwQ8x/lk9Vu50sjPyba9jMiPKcT
         sYojNyRpXEf8Tx8u3+2b4bgZNr/C5jcLL1S4HAH1o84KcZd+pAb/xT+FNaQf0cq8Dq0J
         B10A3ucGFsGFIGPGs6Em9xy4O1z9TFqrFzWxDzok8PEId3AwgNeWNwUOlTOuZDu5Pv8R
         /gkP4q1vL9R9u/99/piysv7GJOLrTw/u5P7EnrT+iGzyHjKo1nXs3so9JEfLV0bRdoZw
         0hJA==
X-Gm-Message-State: AOJu0Yz6D78pfx9rN4q5yHLi+41CRAYIzqoMemXcn0XGasBXS/psRz+T
	U6xeGnchMxyllhJV9BZ4ywXLig660YT5u7c6yjSDwzwjU5fCGRTXNh86RFD0
X-Google-Smtp-Source: AGHT+IG2RAGBwL7nGjFDHeWbA2fN9BmbnVXVq7lHU4QTmI9xl6oPRutkE2h79sVdTmE72dnlqtaRxw==
X-Received: by 2002:a2e:6a06:0:b0:2d1:1ef3:3c84 with SMTP id f6-20020a2e6a06000000b002d11ef33c84mr4004723ljc.28.1708958052102;
        Mon, 26 Feb 2024 06:34:12 -0800 (PST)
Received: from localhost.localdomain ([102.244.37.218])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041294d015fbsm8548033wmn.40.2024.02.26.06.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 06:34:11 -0800 (PST)
From: Achu Luma <ach.lumap@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [Outreachy][PATCH 1/2] strbuf: introduce strbuf_addstrings() to repeatedly add a string
Date: Mon, 26 Feb 2024 15:33:49 +0100
Message-ID: <20240226143350.3596-1-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit we are going to port code from
"t/helper/test-sha256.c", t/helper/test-hash.c and "t/t0015-hash.sh" to
a new "t/unit-tests/t-hash.c" file using the recently added unit test
framework.

To port code like: perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;"
we are going to need a new strbuf_addstrings() function that repeatedly
adds the same string a number of times to a buffer.

Such a strbuf_addstrings() function would already be useful in
"json-writer.c" and "builtin/submodule-helper.c" as both of these files
already have code that repeatedly adds the same string. So let's
introduce such a strbuf_addstrings() function in "strbuf.{c,h}" and use
it in both "json-writer.c" and "builtin/submodule-helper.c".

We use the "strbuf_addstrings" name as this way strbuf_addstr() and
strbuf_addstrings() would be similar for strings as strbuf_addch() and
strbuf_addchars() for characters.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Achu Luma <ach.lumap@gmail.com>
---
 builtin/submodule--helper.c |  4 +---
 json-writer.c               |  5 +----
 strbuf.c                    | 11 +++++++++++
 strbuf.h                    |  5 +++++
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fda50f2af1..bed08af410 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -257,11 +257,9 @@ static void module_list_active(struct module_list *list)

 static char *get_up_path(const char *path)
 {
-	int i;
 	struct strbuf sb = STRBUF_INIT;

-	for (i = count_slashes(path); i; i--)
-		strbuf_addstr(&sb, "../");
+	strbuf_addstrings(&sb, "../", count_slashes(path));

 	/*
 	 * Check if 'path' ends with slash or not
diff --git a/json-writer.c b/json-writer.c
index 005c820aa4..25b9201f9c 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -46,10 +46,7 @@ static void append_quoted_string(struct strbuf *out, const char *in)

 static void indent_pretty(struct json_writer *jw)
 {
-	int k;
-
-	for (k = 0; k < jw->open_stack.len; k++)
-		strbuf_addstr(&jw->json, "  ");
+	strbuf_addstrings(&jw->json, "  ", jw->open_stack.len);
 }

 /*
diff --git a/strbuf.c b/strbuf.c
index 7827178d8e..eb2b3299ce 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -302,6 +302,17 @@ void strbuf_add(struct strbuf *sb, const void *data, size_t len)
 	strbuf_setlen(sb, sb->len + len);
 }

+void strbuf_addstrings(struct strbuf *sb, const char *s, size_t n)
+{
+	size_t len = strlen(s);
+	if (unsigned_mult_overflows(len, n))
+		die("you want to use way too much memory");
+	strbuf_grow(sb, len * n);
+	for (size_t i = 0; i < n; i++)
+		memcpy(sb->buf + sb->len + len * i, s, len);
+	strbuf_setlen(sb, sb->len + len * n);
+}
+
 void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
 {
 	strbuf_grow(sb, sb2->len);
diff --git a/strbuf.h b/strbuf.h
index e959caca87..0fb1b5e81e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -310,6 +310,11 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s)
 	strbuf_add(sb, s, strlen(s));
 }

+/**
+ * Add a NUL-terminated string the specified number of times to the buffer.
+ */
+void strbuf_addstrings(struct strbuf *sb, const char *s, size_t n);
+
 /**
  * Copy the contents of another buffer at the end of the current one.
  */
--
2.43.0.windows.1

