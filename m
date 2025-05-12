Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02126248F5E
	for <git@vger.kernel.org>; Mon, 12 May 2025 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747015808; cv=none; b=c4AfbuKvKd0tsLWoZ/u2XdnkK+mnQ6HAXaQouu8KV199dZj88rOszhyWTMQMvT0LShCwEoKtAa2y7p1AFGi6Wp0ZKC9vf+9qT9iE7y1V/M/cBGCfZHqMw95canWLOP/DSfW6h67d18Vdbb058XcEdmbpH6SPAixVRcrL/sHC4ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747015808; c=relaxed/simple;
	bh=T8D/7mRmf5fDxmUYIZ4GeqKTvnOg1h+iFttiHB7KU0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZu7u1QJVD6yC/qaRcGpKfpFrtuzCGF7N0cE1HZsDVSuD55r466jhJJGTu7ts9Ms2QLd7vJ5ckMHhrxfQnK+yYFOmAHdX3MCRK4p+zbzyxMry7ih+7Hcza0taYUmFhCGyeyIoXlQ3dxBeRg0KezE1i5w6ANqvPLB7k2ZIwuD7rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXbdv13d; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXbdv13d"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7424c24f88bso1964555b3a.1
        for <git@vger.kernel.org>; Sun, 11 May 2025 19:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747015805; x=1747620605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg+2HbLU/XD0EzFjoFloixotWG0xfqHzNDOo3XJCsHM=;
        b=WXbdv13dZYdzDm/9lcmjG+E4ml2mtJeLZMeRitOo5N91XbdipX4Iz0iNzOFlOHVlhB
         tO0ITofqzuE3a5Qd58o6qAWJJHOIngCDCyY37DNI9Gfe/3Z/aay2YgxeAH3+z7red6Gf
         /DrXPA23LGh3/55SSLZRHuFhBu66r7a3104/g+r+YK55SyryKMAq8i57T2P72NaZTwXV
         t6ZiCZN9a+H6XS2FoIbpcCJgCkrXLL85CFyIQ5ul/qULDPNgI8pmoQ5VkeaCNsK2Qom3
         qGAOy02L+reIZB3FeA2nwn3nI2pyh9ji01DWKcnbvNiHxXe0z8pgOhzO5QRIRx2Ufw86
         MSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747015805; x=1747620605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kg+2HbLU/XD0EzFjoFloixotWG0xfqHzNDOo3XJCsHM=;
        b=nqKacHndPK6KsdtjlvmW2OQGAmq552IRP26ofciuwHJ3NL4lOrxz+9gHZVz07eIHe9
         dsSBw+lfA32nL65us1qDXCmPhnQcG5YY+mV0pNFyUBOgNuYtaRwIse5YYlcefBKuf6W8
         ApYz6nGPr49O6fvRZe1XYR21kL8ovvXAncbZrR+U9Om60FA5xOsziVgWDQsSrpjDBsMp
         qCje+/B0TjF83H4m5JV/aOpfYWkJyZZr7ZkVC+iYUpjWU/xTbdisNacwsK29Pd0yNA9A
         X4VCUwnp31Hurkf6MZ6pXKUEdjcMxj2WATWBMxWRdPLwLGwDdBh706gOE05ImxewB6Fe
         ksfg==
X-Gm-Message-State: AOJu0Yz3870FhLJeZ+HkvEaULMccXC/6xs5novtPDBqm+jlaF2bOhoSz
	VOh0Vt4ftGPrl+smYTN5JuJR//BBkUWJ/+/lE1JwbOAm+Q1UlxPRML32m1nZ
X-Gm-Gg: ASbGnctNiMmqlT99OLqJNn2/KDXnYYacB2OjlcQ3Uf+Oo3WhMKmEzD+7sl3WOxgrK/3
	lEhPeOTQ64NVBcUjZtsklteKbpbBxs5amBxoGEWZasUKwT6u8Sg9YScoBn+tFRJsNxdEbtUVJJG
	IZFlkqfZStrnO9oalK983gx3tbEDwXROFUwxoGxJ+svwbk3ZxyTNt0oVDUQIjS/rd/hWcX2ozxf
	B8url/k4WAzItRJvtVBA1Yk2X3JHMdwXXzDSZchlaOAWh16PDdVdVnt6cZUgu+t6OF65UveItpr
	IXArdCpMzoMaZ1C+IrYm/MjyKGa4R7/IDsClGMCLPBeeuBA0lfhxg49f9tqYZXrB77MoWUXgcYl
	xvZcG8TyWETg/MFcY
X-Google-Smtp-Source: AGHT+IGt5CD8hKHTi3y02keHPSPJdfG5Gj2slPD+eEOm5Gk905SJZeg8JgHxFj3mgMIbBklAgqW/JQ==
X-Received: by 2002:a05:6a00:1254:b0:736:34a2:8a18 with SMTP id d2e1a72fcca58-7423c030959mr18721203b3a.24.1747015805171;
        Sun, 11 May 2025 19:10:05 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:e40:9405:a1de:10d2:a65b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a0cdd7sm5212185b3a.90.2025.05.11.19.10.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 May 2025 19:10:04 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v2 1/2] json-writer: add docstrings to jw_* functions
Date: Sun, 11 May 2025 23:09:34 -0300
Message-Id: <20250512020935.73140-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250512020935.73140-1-lucasseikioshiro@gmail.com>
References: <20250512020935.73140-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a docstring for each function that manipulates json_writers.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
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

