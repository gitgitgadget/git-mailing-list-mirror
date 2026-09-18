Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71B4AF668
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736555; cv=none; b=LmzUXGhXqsiHTDufHECSTNRk15VYiyQHM3KWKHL+WYQEMRkaEZMg/X5PY4AcTnb8AUD0C8DHZtciy+/2WvUPuVVncHXj1dkAgp/Pr0CmXhHtH5Ljk0uhcQYdgRGHl4ck56cZb8my+ALtDk9AIW4TZm7lAMfADHNLcSBk2Eh0pU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736555; c=relaxed/simple;
	bh=8eH49pOZL0K6jUP+gvkytASQmNRypNe02Kw+VKEVBx0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kXGVcBZxNZhvcqruZkkT4n/I4Qq8YpaEEuyut6eyVtwCiDGEMYtQhcrAstIi0PGunsP2NEq0hBK+Hr1i5rIT176TjUV4BQDr5awNyNrD5javqVNxUHFmEP/YUb1dHwV+bqMiZ/TX5r2xgdVARJq7b5+LZzch/Lkb2wx06w+X84A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXGnikTw; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXGnikTw"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5121bcf1aso535281a12.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2026 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789736553; x=1790341353; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X+X2f9hNOwAqbZlLNdlWxDL9pbxuSBSca8CPFRk0pxA=;
        b=SXGnikTwsj6Q4URqGK1ztLrIwsAbAe5fJEXNAtvEQ14NjCKALWfbxyK8K9tDOnwBBO
         WuInur7qcWEtvbWmcgi6vYpO5a9WN4oGrTqyIjAAyuqpfL7WBOkC6/PBZWvFdDDU4yjz
         gcxDL4A2bFpD5YWTadX+9QB9jU8aHlcNA4eloOox+dxH2r4tkm1y8UqBzMc28FKZ2T/R
         ji32aK1I6ItQWif61DeYo0le6/5U+j+1EXk/Xp/UgTEG5Yysheo7EMkkY0XKnH8rjJbx
         Qu52hyZZ2sHBqduV269d/+nFGWa/SBga4oIq+mqbOcJXqqAd3kho1OsoxBgzQhAGRd0Z
         UscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789736553; x=1790341353;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+X2f9hNOwAqbZlLNdlWxDL9pbxuSBSca8CPFRk0pxA=;
        b=s/8IOsORkr95twcNdEYL7hd2HjaggCSWISbkkzQ7QO9yAArSL7o46slzf6FfqqRcPZ
         8sTijcyu7KZC81WvbqgRInTxG7foO3eq4lP7ILDomxDeAXMKg23FeZxSAGbzRSAasaMQ
         19tjGNTDhXqUrSVu7bZoYKxCmQbiCVR1/iaosyxm3poAXpF3RqiCodf9XvZNqUcSvUGP
         fRiyuGTyWy/HGg13fy0CgT4PzniRnZqRSGAN5KM71qWlgnV8KmkkzvsywUNPReGCf/D2
         yFKXaGvOytrcl/6SfaEcF2C93Xo9YB8jOoUNL6TevoqGlK6zXxjeIA1kTfaXLL4GO0dx
         Arrw==
X-Gm-Message-State: AFuF++lfGcvnEwknvuRNxiMk6h+r6Nm0rkq8AZdql8UatTsHk7XYSbhC
	fu6IaJ2ShTQlTtD0cYRCd/OwxOppEy6yo2PAzXm/7Jzbf33BnMZAaAmGtbHQbd5Z
X-Gm-Gg: AYBFou1TJGROyqwwSttbKbTMHjK1uT8eSU2s6b5loyic72NWXD3bqcsphOjzG88I5ai
	q32kLwhD/mNlHqtT1LDKmXrqr/+t5LDlpicYtwFWKDKjsx/6DDX9tppUk9zj1SD2KVYFTSdvxx7
	6AayDdx8dDnV6vOxtvkzt9ziPnVAVOlNxjgq4tRVA8mBby0u7gt/BVRModHUlqUEYoi6E/eMLBM
	6FHlm0uxhXPFfjWFTBNf22bPEdS23qVxQY5cwS0l3Zed8tgAr7Tr4s3SEbnlPSpa/QvpCR+zpzr
	9UnQiIUcllPzpxCCq020Zx5kS38zIUBg7qgqH3C8ZqjiEf0j5qzHdnABS7RI8bFIL9kJI4EtumL
	8JfBSfEi3M6p4j+R1A4Yc9ioR6t4pSptqmmb9yq/Qkr/eMxmK2MYWD41bCaSDm49Ge21SyajlaU
	5OaH7u/TNLxGv8cV1AXhxgrfi+BpD3A3LDxMKGr76UPd2x2tk+mHRM5myR7jZH6DO0NNe77kBH
X-Received: by 2002:a05:6300:2789:20b0:3dd:8d74:3a63 with SMTP id adf61e73a8af0-3dd8d7443b8mr3670238637.13.1789736553083;
        Fri, 18 Sep 2026 06:02:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.95.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-875dcee2b09sm783552b3a.31.2026.09.18.06.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:02:32 -0700 (PDT)
Message-Id: <dea925f31647e7c08f3fa467b8058351b463f593.1789736540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Sep 2026 13:02:20 +0000
Subject: [PATCH 6/6] strbuf-safe: add init and release methods
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

Continue extending the strbuf-safe API by adding these safe versions of the
initialize and release methods:

* sstrbuf_init()
* sstrbuf_release()

These both depend on sstrbuf_grow() that was introduced in the previous
change.

As we are working to make json-writer.c a safe API, adapt its use of
strbuf_release() to the safe version. To properly handle the responses of
the safe versions, some methods are converted to return their own error
codes. However, callers of those methods are not adapted at this time and
will be adapted in future changes. This leaves a window where json-writer
consumers may continue running after an error occurs, potentially leading to
a different error in the future.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 json-writer.c | 31 +++++++++++++++++++------------
 json-writer.h |  5 +++--
 strbuf-safe.c | 18 ++++++++++++++++++
 strbuf-safe.h |  2 ++
 strbuf.c      | 12 ++++--------
 5 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/json-writer.c b/json-writer.c
index e7fc5775da..38351f3439 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -3,6 +3,8 @@
 #include "git-compat-util.h"
 #include "json-writer.h"
 #include "strbuf.h"
+/* banned-die must be last. */
+#include "banned-die.h"
 
 void jw_init(struct json_writer *jw)
 {
@@ -10,10 +12,15 @@ void jw_init(struct json_writer *jw)
 	memcpy(jw, &blank, sizeof(*jw));;
 }
 
-void jw_release(struct json_writer *jw)
+int jw_release(struct json_writer *jw)
 {
-	strbuf_release(&jw->json);
-	strbuf_release(&jw->open_stack);
+	enum safe_result result = SUCCESS;
+
+	/* attempt both removals without short-circuiting. */
+	result = sstrbuf_release(&jw->json) || result;
+	result = sstrbuf_release(&jw->open_stack) || result;
+
+	return result;
 }
 
 /*
@@ -99,16 +106,17 @@ static void maybe_add_comma(struct json_writer *jw)
 		jw->need_comma = 1;
 }
 
-static void fmt_double(struct json_writer *jw, int precision,
-			      double value)
+static int fmt_double(struct json_writer *jw, int precision,
+		      double value)
 {
 	if (precision < 0) {
 		strbuf_addf(&jw->json, "%f", value);
+		return 0;
 	} else {
 		struct strbuf fmt = STRBUF_INIT;
 		strbuf_addf(&fmt, "%%.%df", precision);
 		strbuf_addf(&jw->json, fmt.buf, value);
-		strbuf_release(&fmt);
+		return sstrbuf_release(&fmt);
 	}
 }
 
@@ -235,8 +243,8 @@ static void kill_indent(struct strbuf *sb,
 	}
 }
 
-static void append_sub_jw(struct json_writer *jw,
-			  const struct json_writer *value)
+static int append_sub_jw(struct json_writer *jw,
+			 const struct json_writer *value)
 {
 	/*
 	 * If both are pretty, increase the indentation of the sub_jw
@@ -255,18 +263,17 @@ static void append_sub_jw(struct json_writer *jw,
 		struct strbuf sb = STRBUF_INIT;
 		increase_indent(&sb, value, jw->open_stack.len * 2);
 		strbuf_addbuf(&jw->json, &sb);
-		strbuf_release(&sb);
-		return;
+		return sstrbuf_release(&sb);
 	}
 	if (!jw->pretty && value->pretty) {
 		struct strbuf sb = STRBUF_INIT;
 		kill_indent(&sb, value);
 		strbuf_addbuf(&jw->json, &sb);
-		strbuf_release(&sb);
-		return;
+		return sstrbuf_release(&sb);
 	}
 
 	strbuf_addbuf(&jw->json, &value->json);
+	return 0;
 }
 
 void jw_object_sub_jw(struct json_writer *jw, const char *key,
diff --git a/json-writer.h b/json-writer.h
index fa8cf02253..72277d9839 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -103,9 +103,10 @@ struct json_writer
 void jw_init(struct json_writer *jw);
 
 /*
- * Release the internal buffers of a json_writer.
+ * Release the internal buffers of a json_writer. Returns nonzero on
+ * failure.
  */
-void jw_release(struct json_writer *jw);
+int jw_release(struct json_writer *jw);
 
 /*
  * Begin the json_writer using an object as the top-level data structure. If
diff --git a/strbuf-safe.c b/strbuf-safe.c
index e4a0707d63..7a8701e827 100644
--- a/strbuf-safe.c
+++ b/strbuf-safe.c
@@ -32,3 +32,21 @@ enum safe_result sstrbuf_grow(struct strbuf *sb, size_t extra)
 
 	return SUCCESS;
 }
+
+enum safe_result sstrbuf_init(struct strbuf *sb, size_t hint)
+{
+	struct strbuf blank = STRBUF_INIT;
+	memcpy(sb, &blank, sizeof(*sb));
+	if (!hint)
+		return 0;
+	return sstrbuf_grow(sb, hint);
+}
+
+enum safe_result sstrbuf_release(struct strbuf *sb)
+{
+	if (sb->alloc) {
+		free(sb->buf);
+		return sstrbuf_init(sb, 0);
+	}
+	return 0;
+}
diff --git a/strbuf-safe.h b/strbuf-safe.h
index f6adf7434b..fe04d9cf62 100644
--- a/strbuf-safe.h
+++ b/strbuf-safe.h
@@ -91,5 +91,7 @@ enum safe_result {
 };
 
 enum safe_result sstrbuf_grow(struct strbuf *sb, size_t extra);
+enum safe_result sstrbuf_init(struct strbuf *sb, size_t hint);
+enum safe_result sstrbuf_release(struct strbuf *sb);
 
 #endif /* STRBUF_SAFE_H */
diff --git a/strbuf.c b/strbuf.c
index d005666a07..835238dc64 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -70,18 +70,14 @@ char strbuf_slopbuf[1];
 
 void strbuf_init(struct strbuf *sb, size_t hint)
 {
-	struct strbuf blank = STRBUF_INIT;
-	memcpy(sb, &blank, sizeof(*sb));
-	if (hint)
-		strbuf_grow(sb, hint);
+	if (sstrbuf_init(sb, hint))
+		STRBUF_DIE("strbuf_init");
 }
 
 void strbuf_release(struct strbuf *sb)
 {
-	if (sb->alloc) {
-		free(sb->buf);
-		strbuf_init(sb, 0);
-	}
+	if (sstrbuf_release(sb))
+		STRBUF_DIE("strbuf_release");
 }
 
 char *strbuf_detach(struct strbuf *sb, size_t *sz)
-- 
gitgitgadget
