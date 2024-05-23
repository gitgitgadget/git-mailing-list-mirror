Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B6717577
	for <git@vger.kernel.org>; Fri, 24 May 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716508829; cv=none; b=KBlP04IolFYEY/Pb5izfog+n0Xx7aIpuLBDg0afD410VV9fFko18slgPFD/oFazRH8yYp39/R+K4L70NrRh+ED8udSnHaxp1533zB5xPM4aoPS81tf1LGfvlx90ZDarC+FpNRslOvyu1nscL7cXJYvgebdJCx+STVTkyfozhDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716508829; c=relaxed/simple;
	bh=6HQHjW+N/3w5tEldAEVg/0IebLJd0EFrnxQfepAygqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBTDqzXFdeDno/+9KRhCOWoPUMF8NtJamTuuad2epUbA9PecO5/6FTc7zvX7weEKd+kkrtqBpKlPlVibCvr0E6oWVaf2vEhWjSUyxzJ7WK26sxhKsqKMTsYgnRLQsLpNaK9x1eAWWeZn+GcVxiIzoeuVNCAFLMZB5o+h3mrpTb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP8e8jhp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP8e8jhp"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f8ecafd28cso284882b3a.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 17:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716508827; x=1717113627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAd+Gat3kCe+FrRUdxhA0S8JXk+VT8NM7ivA44jzlRA=;
        b=RP8e8jhpwdoUsObOF1VD7eRxGB3+5LhFlZjGV6pL74YQfr4qU7HEOjkEB8KWpw3j67
         FRlJdNTxUe9OmHMrf13yrq3Y0R+haRGsqhohBE0nYZj2C5bAoA2Bu66yGcztP9bqbKFi
         Xd/ECmmWbHSbm9maiJg0CpqGuVIQ62+rRGIpBoSmdzgrnHaQsXDeffnF5yMkl6yUdm5T
         o5OZr/NPfBYgWkkqzGfoNvH+3lTx8gR1N8DCgLQuPpHZYbVhDIbhQ94cn7sr1lrAURGO
         7Epnavp/zATWMPaEAaoxhqEQg5sCiDmgfkSiXLEsAzwIGQvznZoQ9yhtkTw9EDm7K/ue
         L9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716508827; x=1717113627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAd+Gat3kCe+FrRUdxhA0S8JXk+VT8NM7ivA44jzlRA=;
        b=U5ab2FtbykMY9dwRyZ5a+85CqRdQV8GgkwSdWCfckMblyjX/ZBfvQxbOvOjHnvWYpc
         68+Oy1BC+U5pseZI3247R3R9hqrwgpXAVppabxgrj9nIyfzNU7OmLjrC+PFvGlxymmzt
         FrYY3OWpDmMJUQqC09k6WaHtKIZIe/Lfba32wkv/cI0eIlgOruk1k+pNkSvpDadOxrQl
         OGVzLUrvBAcAlSOUUxAhaLX5V7dqPYJOkoU/A5M/CnR7/6rZ0rpXpxr/aOxJJ3Bz+cZx
         OeFEvBOmfbk1iWzQTR6xOIi+M6rptlrc/aX5qO/AZde0zuS+g1l48fP7pVbsR6whzTAJ
         ZJiA==
X-Forwarded-Encrypted: i=1; AJvYcCWWU93UIEOOwdv664+J+QxdsPBNhScyuxjGoepGnytKR3epoF+9WrETnR33PHe4ykffIRFCMoJTN7QcCxuOXH5W0qLC
X-Gm-Message-State: AOJu0YyOm2kQPx0drxm2GZ50b0NinVwepYDxeOY9hW/uGQvovNIf0dn1
	vwKZTfaYvqixPCB2rMVrpO/lK8pwlYP/fxz9sFc6BbJkqlWjiNyjBgjVdFMPPg4=
X-Google-Smtp-Source: AGHT+IFkj2KFkw6Q7Hypve6bOs1dypwTs428lE0bkh177QCmTneYUi9G+lPLM9ICsh0tTHZIzuC6OA==
X-Received: by 2002:a05:6a20:9783:b0:1af:d9a3:f399 with SMTP id adf61e73a8af0-1b212dfe3e3mr997539637.29.1716508826347;
        Thu, 23 May 2024 17:00:26 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc05ab4asm165454b3a.59.2024.05.23.17.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 17:00:25 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: ach.lumap@gmail.com
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im
Subject: [PATCH v3 1/3] strbuf: introduce strbuf_addstrings() to repeatedly add a string
Date: Fri, 24 May 2024 05:29:43 +0530
Message-ID: <20240523235945.26833-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523235945.26833-1-shyamthakkar001@gmail.com>
References: <20240229054004.3807-1-ach.lumap@gmail.com>
 <20240523235945.26833-1-shyamthakkar001@gmail.com>
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

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Co-authored-by: Achu Luma <ach.lumap@gmail.com>
Signed-off-by: Achu Luma <ach.lumap@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 builtin/submodule--helper.c | 4 +---
 json-writer.c               | 5 +----
 strbuf.c                    | 9 +++++++++
 strbuf.h                    | 5 +++++
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e604cb5ddb..5620a5bf67 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -256,11 +256,9 @@ static void module_list_active(struct module_list *list)
 
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
index 0d929e4e19..e3ca9b1ee9 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -313,6 +313,15 @@ void strbuf_add(struct strbuf *sb, const void *data, size_t len)
 	strbuf_setlen(sb, sb->len + len);
 }
 
+void strbuf_addstrings(struct strbuf *sb, const char *s, size_t n)
+{
+	size_t len = strlen(s);
+
+	strbuf_grow(sb, st_mult(len, n));
+	for (size_t i = 0; i < n; i++)
+		strbuf_add(sb, s, len);
+}
+
 void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
 {
 	strbuf_grow(sb, sb2->len);
diff --git a/strbuf.h b/strbuf.h
index 97fa4a3d01..003f880ff7 100644
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
2.45.1

