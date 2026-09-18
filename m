Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7C24AAC63
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736552; cv=none; b=dcfcqmP7O1+77YYGutBmLwrn0ofTfjYf6DtW+K4PmpgzZ3NY7O9vyBpZYM1SZPyrTmRnaF3TdzEzdVZVKDsPjo95vq5BBI5KzKeVYYQNbReFj7wiAWZoZYVrgvmZ2pSQiKv+lAZIS+FlHYJFkTQq4+YFz/4XLnw6PaCKQF4gRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736552; c=relaxed/simple;
	bh=JnewqM0kGafcXeERMwJZpm6PfehPhklOqpXSRp4MJCU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rk8JFo3JkLs9Rx3DBauaFCK5CLa0kXkGF+VeAYZu9GGTPV4fZUaNRSIMgfvmCcEkDL8zu/J7gtMrs9VWkjB3YngQwgHb04EM1Vsy+UViOTsgcxSxlxZYZMLenMlKEQ7fK8ceV/0YzxV5zUX6JleIGLXePjwHLFl/qfq3aLE1kH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYUg75sf; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYUg75sf"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ed6d6eso6916095ad.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2026 06:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789736550; x=1790341350; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NZ8LyeSS3VkcrvmzTTvL6D250Wxk7XUzGHY3Ojkt4es=;
        b=SYUg75sfimB+lGB/h8rky7T9bLjMEB+h8xH/Nn9wPKtYfseQITEnNqHMg+byWJu/gE
         8mfR5GD8T6b/p4MWhQlr92zkEbFERFihvcQW0MIF+8/oVIJ6/jEe+F4tA9MWni3xlHWU
         yISJ6/0O+NeuVQ9Up8pwBC0TkyOcTt3zqXompzgldB1leGbwcFSAvP7sttEue5759rPE
         NIEHmdZHOAnvWrTQZIIDb5rOdsCusnkhaTZqfRUoiN4cLbIZO99BY9VQuyS+v5dMqmlJ
         c/trwf1fV/wXPpt0892lA8X1F46fz5WbeCpEy4A3zrstFivIrpdXGG6gldFeA2jOj4OW
         Ep0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789736550; x=1790341350;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NZ8LyeSS3VkcrvmzTTvL6D250Wxk7XUzGHY3Ojkt4es=;
        b=cnVxXDuur1Gmj3WFZOKCfd12CPX/P/oz0HcUdpahBXDq5Q4zus+iqXY6djizODMr5d
         or/kTkdXIMpi2mIsXj5FWp86/b/otCZ3MBJ1BnuxdcieRxxY1jEf7B4mifWOSXqUijou
         kvEPps/0r3kELS0BlThSxG1zOvkevZjRO/K72TVhSEc3YZe1bq3EUaC2agZiKF1qVF0C
         G9Ayn4Y5ycBq+qdnnWdB3rU9YbZ9jYOMB8g62wSZdbFPHfg79OwNHP/gPeTQl2U9Usau
         mhq2XiFpOdg7wB1FjIk0X7/FUwcoBWG9uCGMRlrQmQynXGpPGgf70S3XvE5eZWAL7hdG
         LBsQ==
X-Gm-Message-State: AFuF++kFmMWrDvh8+vvNWPEUdrrLAln4/AVTlYWJhm/+cN5jozzNSD9d
	nTYDFkMF6cG6n57krcb7doNVqRUocnEjQW9gK0v5lQUMLcKF4cyZhyeREqYCzXK4
X-Gm-Gg: AYBFou3zdZyC/CWKMHsm6zllGKkkZ4iU+J/lHe8u/zmKekdxMHc2qxJkQ6tqUcLABUc
	VBuwhYfVY61R/ve238b0QtUe8bPPwYGdy3qJsoc7zLm6nlWIqOrmu2VcWSt42wm7OD1piJBvqPC
	QWqvM1BERnX/UZBGdlm881HP/ado+WJELX16fVanMs2gL4SGLdfbS5ZiM50QUYFXmibuPbZibuK
	JhpQmiAtqeBL3IHzVHrIwNuZJIA9vblBTFXQ/Hlr6FHm7xnXxSH4Arx/iSE6ah9y67RJg0CcruR
	KJ9tLbmdlB/66Iy3CoYhYfyVblVhbgaIgVdmopgN/oGc6G99A7AUx4qrqJWfE9MKiTowFecxtU1
	DxbOwRT5VFPMaJSh7MN1VU37hJBYueetp6jHOQC4TggxLE2e9cjN89cvhBTU6+gEZbsmIGVeu9L
	6q8ns89gIUmmZ5dzWoCGMJfwtgfbjyk9xTilOHIw6ebcxAEnxg2HgVI/3kVLGhmPwJIf8n/paJ
X-Received: by 2002:a17:902:ecc4:b0:2dd:ad74:6d20 with SMTP id d9443c01a7336-2ddb1bc62afmr57456105ad.29.1789736549852;
        Fri, 18 Sep 2026 06:02:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.95.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb7549682sm7352465ad.31.2026.09.18.06.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:02:29 -0700 (PDT)
Message-Id: <ebd91b95209d778727dca1bfcce17dcb76b3151f.1789736540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Sep 2026 13:02:18 +0000
Subject: [PATCH 4/6] strbuf-safe: add sstrbuf_grow()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    peff@peff.net,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

After a few changes in preparation, we are now ready to create our first
'safe' strbuf API method: sstrbuf_grow(). This is a safe version of
strbuf_grow().

On naming: For safe equivalents of existing methods, I'm prepending a single
's' character. The intention is to make the safe API non-intrusive.
Alternatives could be to append '_gentle' like many other APIs that avoid a
die() on malformed user data, but we need to be even safer than these gentle
methods, which still die() on allocation failures or other system-level
errors. This 's' prefix is similar to the 'x' prefix used by git-compat-util
helpers.

I selected strbuf_grow() as the first method to move because it doesn't
depend on any other strbuf API method, but is called by many other strbuf
API calls, including strbuf_release() or strbuf_init(). Thus, this will be a
helper to several other implementations that are coming in upcoming changes.

No callers directly depend on sstrbuf_grow(), but the non-safe strbuf_grow()
now uses it as declared in strbuf-safe.h.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Makefile      |  1 +
 meson.build   |  1 +
 strbuf-safe.c | 34 ++++++++++++++++++++++++++++++++++
 strbuf-safe.h |  7 +++++++
 strbuf.c      | 11 ++++-------
 wrapper.c     | 26 +++++++++++++++++---------
 wrapper.h     |  3 +++
 7 files changed, 67 insertions(+), 16 deletions(-)
 create mode 100644 strbuf-safe.c

diff --git a/Makefile b/Makefile
index d4b775953d..5943853219 100644
--- a/Makefile
+++ b/Makefile
@@ -1327,6 +1327,7 @@ LIB_OBJS += sparse-index.o
 LIB_OBJS += split-index.o
 LIB_OBJS += stable-qsort.o
 LIB_OBJS += statinfo.o
+LIB_OBJS += strbuf-safe.o
 LIB_OBJS += strbuf.o
 LIB_OBJS += string-list.o
 LIB_OBJS += strmap.o
diff --git a/meson.build b/meson.build
index d86f2acd2b..368fdd00d5 100644
--- a/meson.build
+++ b/meson.build
@@ -532,6 +532,7 @@ libgit_sources = [
   'split-index.c',
   'stable-qsort.c',
   'statinfo.c',
+  'strbuf-safe.c',
   'strbuf.c',
   'string-list.c',
   'strmap.c',
diff --git a/strbuf-safe.c b/strbuf-safe.c
new file mode 100644
index 0000000000..e4a0707d63
--- /dev/null
+++ b/strbuf-safe.c
@@ -0,0 +1,34 @@
+#include "git-compat-util.h"
+#include "strbuf-safe.h"
+#include "banned-die.h"
+
+/*
+ * A safe version of ALLOC_GROW from git-compat-util.h and
+ * xrealloc() from wrapper.c.
+ */
+#define SAFE_ALLOC_GROW(x, nr, alloc) \
+	do { \
+		if ((nr) > alloc) { \
+			if (alloc_nr(alloc) < (nr)) \
+				alloc = (nr); \
+			else \
+				alloc = alloc_nr(alloc); \
+			if (srealloc((void **)&(x), alloc)) \
+				return MEMORY_ERROR; \
+		} \
+	} while (0)
+
+enum safe_result sstrbuf_grow(struct strbuf *sb, size_t extra)
+{
+	int new_buf = !sb->alloc;
+	size_t new_len = st_add3(sb->len, extra, 1);
+	if (new_buf)
+		sb->buf = NULL;
+
+	SAFE_ALLOC_GROW(sb->buf, new_len, sb->alloc);
+
+	if (new_buf)
+		sb->buf[0] = '\0';
+
+	return SUCCESS;
+}
diff --git a/strbuf-safe.h b/strbuf-safe.h
index 3cf14545bb..f6adf7434b 100644
--- a/strbuf-safe.h
+++ b/strbuf-safe.h
@@ -85,4 +85,11 @@ struct strbuf {
 extern char strbuf_slopbuf[];
 #define STRBUF_INIT  { .buf = strbuf_slopbuf }
 
+enum safe_result {
+	SUCCESS = 0,
+	MEMORY_ERROR,
+};
+
+enum safe_result sstrbuf_grow(struct strbuf *sb, size_t extra);
+
 #endif /* STRBUF_SAFE_H */
diff --git a/strbuf.c b/strbuf.c
index 44955669e8..d005666a07 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -8,6 +8,8 @@
 #include "utf8.h"
 #include "date.h"
 
+#define STRBUF_DIE(f) die(_("unexpected error during string manipulation: %s"), f)
+
 bool starts_with(const char *str, const char *prefix)
 {
 	for (; ; str++, prefix++)
@@ -105,13 +107,8 @@ void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
 
 void strbuf_grow(struct strbuf *sb, size_t extra)
 {
-	int new_buf = !sb->alloc;
-	size_t new_len = st_add3(sb->len, extra, 1);
-	if (new_buf)
-		sb->buf = NULL;
-	ALLOC_GROW(sb->buf, new_len, sb->alloc);
-	if (new_buf)
-		sb->buf[0] = '\0';
+	if (sstrbuf_grow(sb, extra))
+		STRBUF_DIE("strbuf_grow");
 }
 
 void strbuf_trim(struct strbuf *sb)
diff --git a/wrapper.c b/wrapper.c
index 97a29bda75..69ff9a8ff6 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -144,20 +144,28 @@ int xstrncmpz(const char *s, const char *t, size_t len)
 	return s[len] == '\0' ? 0 : 1;
 }
 
-void *xrealloc(void *ptr, size_t size)
+int srealloc(void **ptr, size_t size)
 {
-	void *ret;
-
 	if (!size) {
-		free(ptr);
-		return xmalloc(0);
+		free(*ptr);
+		if ((*ptr = malloc(1)))
+			return 0;
+		return -1;
 	}
 
-	memory_limit_check(size, 0);
-	ret = realloc(ptr, size);
-	if (!ret)
+	if (safe_memory_limit_check(size, 0))
+		return -1;
+	if ((*ptr = realloc(*ptr, size)))
+		return 0;
+
+	return -1;
+}
+
+void *xrealloc(void *ptr, size_t size)
+{
+	if (srealloc(&ptr, size))
 		die("Out of memory, realloc failed");
-	return ret;
+	return ptr;
 }
 
 void *xcalloc(size_t nmemb, size_t size)
diff --git a/wrapper.h b/wrapper.h
index 69df68ee7a..956de2c534 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -27,6 +27,9 @@ char *xgetcwd(void);
 FILE *fopen_for_writing(const char *path);
 FILE *fopen_or_warn(const char *path, const char *mode);
 
+/* safe versions of helpers above. */
+int srealloc(void **ptr, size_t size);
+
 /*
  * Like strncmp, but only return zero if s is NUL-terminated and exactly len
  * characters long.  If it is not, consider it greater than t.
-- 
gitgitgadget

