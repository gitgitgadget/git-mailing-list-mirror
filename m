Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D91A8F68
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995423; cv=none; b=CAZpNR+2/Cw1bQpFxY0tZGN03+XhUbKsujY0onPmrO0ER7FmU/u1HwsG79UmENAwWPtPgkFbm8WdEYH4HlX4oE8J/WZeFUtmVghe7gqGAR2oiBEWW9gr30yzG1hU7YdcYjjcJDkXOBWzAwtQsXojEyCasrpFWestXM+MW962c/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995423; c=relaxed/simple;
	bh=jjn+be++MAbJOI0aVZV4A/tMAwUdmrLwTJO5pnjqhpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fk6q5wah+CNjuwLkc4W/80hj9h/GL3Ik/UKZmfTHeoqBqdmmhPtg/4Y0X9Bo28SWB1jBc0cSNqsaeBKpfSogP5Z+/H/9glDIYMOghmBfwPfKuiBgmNkYvuN//Ap00LSbYuXk82GDKFG3Wme3SuyZddH1lHyJR76+iFqDDZMFjAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOyHWZSy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOyHWZSy"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22622ddcc35so31771735ad.2
        for <git@vger.kernel.org>; Fri, 18 Apr 2025 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744995420; x=1745600220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0/X4hAupTyFnkavILCwY/QIbwgv2pbZ0eRPWR8Zpe2s=;
        b=SOyHWZSyekfMtLy2VEilESCH5Jue3++j1wMeZD3EtZKgvyfeqGcoM6kIpnwcdbqk3z
         WICJMqvUSQ8D9zRIs/GegU1OJ1v6Bs3WYxcczNiHFeASRWsy0wr/1RdMmmOFIjPRWmAv
         sbh/YAgXG9TEg8DfeJ2mS0Gq0lzcX5RTkL9fuAZXFwZs+/H7MIHLoJfAcO21Mk3Z+SNR
         IVpO1cLgwp4UfSF5EPA8mxnsT8TvVd74BtZFd900Zet8+8u5z5n8cK2pf3b+5/wJveHQ
         SNB/8zMIvDhe58dvlLbPnKbUE1AtREbG70TafxMl3jqxUFQ7PqV5IsZidRty97CzfR9i
         Cjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744995420; x=1745600220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/X4hAupTyFnkavILCwY/QIbwgv2pbZ0eRPWR8Zpe2s=;
        b=cFoY5+CJhGphPCmZYWPd0k3qCZIbnReS1buDyUjHqz6fGLVCn2afAfyHVrGAABV1ax
         eh2KOoEiowfxtxWgc8dvlmK7XmEkmGe7Ps3RdGINeRSitWx0jHiDbwlypnQYQhuGvFZn
         xfTQSK2hb9VMm0dXBbI7rtEf8mwc3NAYw1s2KpuV6Ek+m9dmTrHmFIpLQbXPnJWzxd2d
         irMXokbiwHTJavT9XjHSmBcNFoNr6ha5N5tu8PSTvh1Ho51A61yQYpUtSmhTLN6C8oGq
         7B8r9ehe8myYTbLb+jcQpjJOn8h7ONSB6gbCS1IgwTOOQbKDtz7LunzRoKKHNfpKv9YR
         nA6Q==
X-Gm-Message-State: AOJu0YxU85dATZ4z1yhpnxbhSSM4gIHhL5cEqnlXf3YgtCz/OuVkJ7gX
	PHH7glje8FWzEGqXv3ZrCoJ+Yv2cAkzbq30RMeYfWUGbVXrbTQ9+rEbmYA==
X-Gm-Gg: ASbGncvlse9FPahR/M+ZQghj9L3mI2+0Pii+sTDVg6NaS0L3wHtqmjWRY3l0wRnCfhL
	DR8lui0iRyvLoVEA4EJXkQxo+/aJCM+C3Di5GXMic6di//VKiO4OuWT/3AGh2WzrLXaqIOVKKgu
	+tKzcGaKedBNWAtwvaNwvwrvLkuHOYsPlwQCEXBEXNX7s7NxyoChBslAuqaSvdeeV3rgdtTnE7a
	pFuaQ+zvbfOUr3AiG7Wuhyrq4boRrSdf0O5oBI8NoflgoZjCZFDBVdtA75gtCjGPTOaV6332gQv
	GLif7jCH3D9JN96XuPdV563CCNRF5H07LczwUfVV0cmnrgpudiOaWVz1x1z/mgamfmm32FLW6dY
	V49w=
X-Google-Smtp-Source: AGHT+IH//eDAmAeOHZP1LD9Dbexq8SiIr/X0TdIJYs8vGi4AD83gDm8t6V4Q7miew4ijKisGgskWvg==
X-Received: by 2002:a17:902:db01:b0:223:501c:7581 with SMTP id d9443c01a7336-22c535a4e39mr49855645ad.16.1744995420129;
        Fri, 18 Apr 2025 09:57:00 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8e7e:fd38:6c06:abf:271b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdb805sm19032525ad.216.2025.04.18.09.56.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Apr 2025 09:56:59 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: jeffhost@microsoft.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH] json-writer: add docstrings to jw_* functions
Date: Fri, 18 Apr 2025 13:56:51 -0300
Message-Id: <20250418165651.14125-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a docstring for each function that manipulates json_writers.
---
Hi!

Given that my GSoC project needs some form of formatting JSON output, the
already existent json-writer.{ch} will be extremely useful. So, before
GSoC actually starts, I decided to study a little about json-writer and
just found that it doesn't have docstrings.

Here I'm documenting what each function does, as this module is a general
utility that can be used in any place of the Git codebase and other people
may be in the same position of studying of it does by directly reading its
source code.

PS: I'm sending this as single patch as many docstrings are similar and
json_writer was introduced in a single patch (7545941). But I can break
it into smaller patches if you prefer :-).

 json-writer.h | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/json-writer.h b/json-writer.h
index 04413bd1af..aa513e86cb 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -69,42 +69,175 @@ struct json_writer
 	.open_stack = STRBUF_INIT, \
 }
 
+/*
+ * Initialize a json_writer with empty values.
+ */
 void jw_init(struct json_writer *jw);
+
+/*
+ * Release the internal buffers of a json_writer.
+ */
 void jw_release(struct json_writer *jw);
 
+/*
+ * Begin the json_writer using an object as the top-level data structure. If
+ * pretty is set to 1, the result will be a human-readable and indented JSON,
+ * and if it is set to 0 the result will be minified single-line JSON.
+ */
 void jw_object_begin(struct json_writer *jw, int pretty);
+
+/*
+ * Begin the json_writer using an array as the top-level data structure. If
+ * pretty is set to 1, the result will be a human-readable and indented JSON,
+ * and if it is set to 0 the result will be minified single-line JSON.
+ */
 void jw_array_begin(struct json_writer *jw, int pretty);
 
+/*
+ * Append a string field to the current object of the json_writer, given its key
+ * and its value.
+ */
 void jw_object_string(struct json_writer *jw, const char *key,
 		      const char *value);
+
+/*
+ * Append an int field to the current object of the json_writer, given its key
+ * and its value.
+ */
 void jw_object_intmax(struct json_writer *jw, const char *key, intmax_t value);
+
+/*
+ * Append a double field to the current object of the json_writer, given its key
+ * and its value. The precision parameter can be used for specifying the number
+ * of decimals after the point, using -1 for formatting with the maximum
+ * precision available.
+ */
 void jw_object_double(struct json_writer *jw, const char *key, int precision,
 		      double value);
+
+/*
+ * Append a boolean field set to true to the current object of the json_writer,
+ * given its key.
+ */
 void jw_object_true(struct json_writer *jw, const char *key);
+
+/*
+ * Append a boolean field set to false to the current object of the json_writer,
+ * given its key.
+ */
 void jw_object_false(struct json_writer *jw, const char *key);
+
+/*
+ * Append a boolean field to the current object of the json_writer, given its
+ * key and its value.
+ */
 void jw_object_bool(struct json_writer *jw, const char *key, int value);
+
+/*
+ * Append a null field to the current object of the json_writer, given its key.
+ */
 void jw_object_null(struct json_writer *jw, const char *key);
+
+/*
+ * Append a field to the current object of the json_writer, given its key and
+ * another json_writer that represents its content.
+ */
 void jw_object_sub_jw(struct json_writer *jw, const char *key,
 		      const struct json_writer *value);
 
+/*
+ * Start an object as the value of a field in the current object of the
+ * json_writer, given the field key.
+ */
 void jw_object_inline_begin_object(struct json_writer *jw, const char *key);
+
+/*
+ * Start an array as the value of a field in the current object of the
+ * json_writer, given the field key.
+ */
 void jw_object_inline_begin_array(struct json_writer *jw, const char *key);
 
+/*
+ * Append a string value to the current array of the json_writer.
+ */
 void jw_array_string(struct json_writer *jw, const char *value);
+
+/*
+ * Append an int value to the current array of the json_writer.
+ */
 void jw_array_intmax(struct json_writer *jw, intmax_t value);
+
+/*
+ * Append a double value to the current array of the json_writer. The precision
+ * parameter can be used for specifying the number of decimals after the point,
+ * using -1 for formatting with the maximum precision available.
+ */
 void jw_array_double(struct json_writer *jw, int precision, double value);
+
+/*
+ * Append a true value to the current array of the json_writer.
+ */
 void jw_array_true(struct json_writer *jw);
+
+/*
+ * Append a false value to the current array of the json_writer.
+ */
 void jw_array_false(struct json_writer *jw);
+
+/*
+ * Append a boolean value to the current array of the json_writer.
+ */
 void jw_array_bool(struct json_writer *jw, int value);
+
+/*
+ * Append a null value to the current array of the json_writer.
+ */
 void jw_array_null(struct json_writer *jw);
+
+/*
+ * Append a value to the current array of the json_writer, given the
+ * json_writer that represents its content.
+ */
 void jw_array_sub_jw(struct json_writer *jw, const struct json_writer *value);
+
+/*
+ * Append the first argc values from the argv array of strings to the current
+ * array of the json_writer.
+ *
+ * This function does not provide safety for cases where the array has less than
+ * argc values.
+ */
 void jw_array_argc_argv(struct json_writer *jw, int argc, const char **argv);
+
+/*
+ * Append a null-terminated array of strings to the current array of the
+ * json_writer.
+ */
 void jw_array_argv(struct json_writer *jw, const char **argv);
 
+/*
+ * Start an object as a value in the current array of the json_writer.
+ */
 void jw_array_inline_begin_object(struct json_writer *jw);
+
+/*
+ * Start an array as a value in the current array.
+ */
 void jw_array_inline_begin_array(struct json_writer *jw);
 
+/*
+ * Return if the json_writer is terminated. In other words, if the all the
+ * objects and arrays are already closed.
+ */
 int jw_is_terminated(const struct json_writer *jw);
+
+/*
+ * Terminates the current object or array of the json_writer. In other words,
+ * append a ] if the current array is not closed or } if the current object
+ * is not closed.
+ *
+ * Abort the execution if there's no object or array that can be terminated.
+ */
 void jw_end(struct json_writer *jw);
 
 #endif /* JSON_WRITER_H */
-- 
2.39.5 (Apple Git-154)

