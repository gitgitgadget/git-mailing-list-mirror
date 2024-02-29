Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF153DB86
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709185268; cv=none; b=M7V2HIlBlftbzqESF//CCrB0q7HtCSs9a7VUh+oqvllFqLGi2gSvUhSeNURZyoZzuJWmGP2ctqMnp6FS7tgGYOTTVkjWratmiual1ri/rdz3adLlj+H9Mh8eHra0NjMfWfXcYQeONPPZmWzVQr0Qqqsq9AD6CSzPsfAvLpijnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709185268; c=relaxed/simple;
	bh=Peyy/cfngEi4hLikXL0JhBil1rSjuXeKSf79iRxJgu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMRPC/gUmVMbUbSiDu+NmcfsWQCr3ZmDUAFB4PCUq4YAzHdVAz3fYfl2HZXlaGIz2X+fme7Tlz6lHJ0gwIwsiEUUVcZYSV2WGBzCXmeVc0uU/6UDOBmsPA+p+z83xZn2SgZAOh1HZGu/GGsgQSE041M1BvGKQGvI4xJ7RZJdNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWHBMy/J; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWHBMy/J"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-33dc3fe739aso943029f8f.0
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 21:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709185264; x=1709790064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daKubJiFo9MM9yjOURztByP9ha3sIdkgZZp06hvltK0=;
        b=PWHBMy/Jnh6OTj2g9cSJLobG77q2AEybUOaGKXc4KEkIb9UHgg6NBH54an86PxJkKB
         9EwbHUTRmiIJ5XDjBTGH8uRsx+sWWOP4IzwxURjQZDjwhIzZUh88hMietJ/LeW5ZQauQ
         RWu5NMku9Kc3O59iotAocgjHgdLXDgTkuWrWmeTcs5u/Osad1Ykejui1bO2A45VL88je
         pSvXercZydDsXQr1asCcZfheOs7t2t/mWqEF4oB9YK2kU2qJ1uFNWYpPzM3JeIyTJnFJ
         xe+WJRMdo4bBexpxwuuu76IKQ5a5Zv45kfK2slM+UnZI2Rt3714HQZ09pZaxGNgvt3Yv
         /P7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709185264; x=1709790064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daKubJiFo9MM9yjOURztByP9ha3sIdkgZZp06hvltK0=;
        b=cO5inbhmrBDB5GLFNxJfXFy3/Mvg8ZFTRZk02WU27T7Enu8w1muac/nOeUlorf7LD+
         a9Os+qzDWNSTtxj3E39VPJ2J+jLsENJ/lZeDGrxUnqPKSecdxA6patuxvarnv6RkM6Si
         ypcM248XKq/SjNkMEM5yMj0julHqSMmp/Sbwjb3hHeUiNsxR+xIiaYNunwoHX7+5tzFv
         Id549v1TlDE1EgWHZreKpQDUzFIzjyq+gk3204R5/bZexsHUvFpMSVY24bCQHvYF4+2U
         MjHIgyaVzk8FmdjgW0kklKVrksf5pKR5xnCxmdLicqL52mr50gIvdzeW0TBeo3D3UYA3
         Y4dQ==
X-Gm-Message-State: AOJu0YzBwQ8on8RLCRx4gLScAmmhu2L6iQR0+NEtI6X3hzDNnq3W27on
	tq7YT+knI2ItdHNomU/MxCpRelAmWmOkdaUCTI7oaCmis2iDM15kA/aemYHaQAk=
X-Google-Smtp-Source: AGHT+IHtQTowMrqHtM9tw0WIXl5vgk8isfWFtcNKX+7I/m5OeWBg5s/W02ZAtrA3YiULMg5XIdxk8g==
X-Received: by 2002:adf:959a:0:b0:33d:9d76:2f82 with SMTP id p26-20020adf959a000000b0033d9d762f82mr770777wrp.26.1709185263991;
        Wed, 28 Feb 2024 21:41:03 -0800 (PST)
Received: from localhost.localdomain ([129.0.78.209])
        by smtp.gmail.com with ESMTPSA id f17-20020adfb611000000b0033d9f0dcb35sm683214wre.87.2024.02.28.21.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 21:41:03 -0800 (PST)
From: Achu Luma <ach.lumap@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	Achu Luma <ach.lumap@gmail.com>
Subject: [Outreachy][PATCH v2 1/2] strbuf: introduce strbuf_addstrings() to repeatedly add a string
Date: Thu, 29 Feb 2024 06:40:02 +0100
Message-ID: <20240229054004.3807-1-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240226143350.3596-1-ach.lumap@gmail.com>
References: <20240226143350.3596-1-ach.lumap@gmail.com>
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
 The changes between version 1 and version 2 are the following:
 - Remove memcpy() that involves manual offset computation
 - Use strbuf_add() repeatedly after calling strbuf_grow() once to avoid
   repeated allocation.

 Thanks to Junio for pointing this out.
 Here is a diff between v1 and v2:

 -       size_t len = strlen(s);
 -       if (unsigned_mult_overflows(len, n))
 -               die("you want to use way too much memory");
 -       strbuf_grow(sb, len * n);
 -       for (size_t i = 0; i < n; i++)
 -               memcpy(sb->buf + sb->len + len * i, s, len);
 -       strbuf_setlen(sb, sb->len + len * n);
 +       size_t len = strlen(s);
 +
 +       if (unsigned_mult_overflows(len, n))
 +               die("you want to use way too much memory");
 +       strbuf_grow(sb, len * n);
 +       for (size_t i = 0; i < n; i++)
 +               strbuf_add(sb, s, len);

 builtin/submodule--helper.c |  4 +---
 json-writer.c               |  5 +----
 strbuf.c                    | 10 ++++++++++
 strbuf.h                    |  5 +++++
 4 files changed, 17 insertions(+), 7 deletions(-)

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
index 7827178d8e..f4282b70ad 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -302,6 +302,16 @@ void strbuf_add(struct strbuf *sb, const void *data, size_t len)
 	strbuf_setlen(sb, sb->len + len);
 }

+void strbuf_addstrings(struct strbuf *sb, const char *s, size_t n)
+{
+       size_t len = strlen(s);
+
+       if (unsigned_mult_overflows(len, n))
+               die("you want to use way too much memory");
+       strbuf_grow(sb, len * n);
+       for (size_t i = 0; i < n; i++)
+               strbuf_add(sb, s, len);
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

