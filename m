Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA151C5489
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753423854; cv=none; b=eoVgxLIqwo6xIqcxfJ+tNl6ey8oLXxzUnN4t7idyNymKBAYIoBx1D6l4jUJmMuCVFgpombqM9GMI22jAYDz841YFqMrNI8Ubh+oXAFLJ7hEshtLaH3n5jRyovfruwrXFkXDC80NBbpyhlOrOkqEZwRcq64nj6hHbW8/esYbkUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753423854; c=relaxed/simple;
	bh=Ilx7tV92Vut/OUr4lu/aUlLu/9Ty0iH2AQ0kn3Au5t0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b2AQwj9wlYaLMS/79A2SSxZofTOq/jZNiQhTC+mmvHaYlftDRqSd17+L+oCyoYgMKOoihSXVmydk+0ANyCd+nrrh7RujR0aKP1ArOrs6U2AyIJ5Wa042RYpakUJifjhEZyQnebK95+hFxad5BwsWUFfcpaa5kCl86gnqODovOk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNoYwyfl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNoYwyfl"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235d6de331fso22239785ad.3
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 23:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753423852; x=1754028652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WG1JJiWEvEfxJWM2z84xsNhsesQP63IZIzqtSM7BKu0=;
        b=MNoYwyflW8lb1VAIYdmBpWMtScoM0UvH5BfBIDuFqej2EGcAFyYF3iI7Kcr16PFDaT
         CL0kSuhBqg6rmfxCx1ktFk9ROjPNfRfcVQQp170RMfHHrMRVXZ9S97MVSbmRmd2h0bHO
         z2W4jkxYOz+mznC+TNHFiVj++fSfjVrEqY/ba/QZKmz245tS0MSvlv/DJ6vlmAcB8EBF
         Ulao9aqC1ebrc17V6Ko6vfbzAJllfsdEGKhu3Tr26w5bJu4dg76AqwsLuba5y9cK6cUD
         eQ27cTETSVk/Xyu4xFWvl0CY9vGaurtkLNrOcWaMCA6zq2Xyic84Qbi0fC8rO7g8pxLd
         LjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753423852; x=1754028652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WG1JJiWEvEfxJWM2z84xsNhsesQP63IZIzqtSM7BKu0=;
        b=ttYpZ/LYQ/ASYxWkSWVXTVYbs9zA/TTKTyDhbZP8Bihqg43/Fs5EmN6SQv6QJyyFim
         n6t6vu5nwUJDgBsbrwsDmMheDP1d8nw3aJqsOjqw2IsEmbC+rK8oiGswawyLJJ/VBqui
         diZxmNT5EOW63ue/dD4CbLf2IWjRBHx6Ku0oXgCDK7kLY6I64LrIKPnHPBVuaxXE47ZA
         9RmCaF9LCZvjGbPiRefHqwsly5rdTX4h4c5kAudUD0qbNgI/k9kJ+MYCKC/QYoZCCMI+
         cfG7/uEI4Z/LglOJrJIE4oVhcXoeoX6UZtrOTexQeqHIiLbifgQqv/NvVMH8xyr0taLW
         6X4Q==
X-Gm-Message-State: AOJu0Yx8cZywZ6bas9FMMOnKqGcKBJIUGH/IsEIsnR/JXM9UR5C7b/Mc
	dF8bYxjaxoT7xoFijIOpDJTyXoe2ThjvrhchIad4I9hr0ziZi7H32ZJdO8UNqg==
X-Gm-Gg: ASbGncvIvRuayr+JzPOG3uXou+jb7Jsn9Q6+2B85I6e4mzuaC2u90S2bHuhDuy50Nkn
	jnJkjuxdI4Q21bfB/FPufF00OlGDL6euprcCIjWrTXlujk6z576850tuUM3stTUN6fdoYcmRCAm
	EJNVEyaNCfY1QTXgNMFJdStm7gLGxjSy3gngukHDo9ZQqW8zB0yRWTmecLa8o9dIKE1Fg3WfLnr
	8UJjFV987ZxyRCj9Bf/+jtpWZ1pXK0F7IxyM3zLMzNq/HC+PJiGMzNMUV03Efgg8lJd8UuUYqtP
	Id3iMP5Lch6XVsw+164/yWbTRxL5Xh/tKz4zLIKY1w14SvHahfl6Yh+TPHb+04J0pKwgOPwKhQh
	Ueuyixp0Y5pjwZ3K71LsMF3VuFsfpcDrYiQ==
X-Google-Smtp-Source: AGHT+IHoFpEkuSR4MdfHf0Q9PCVtiDkODWfHJcNh7jxfrbescB4sJ8no1sz57qwdNSqEMmR+FsIHmQ==
X-Received: by 2002:a17:902:d58f:b0:235:be0:db53 with SMTP id d9443c01a7336-23fb313a91bmr11610885ad.51.1753423851779;
        Thu, 24 Jul 2025 23:10:51 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476c147sm29121385ad.46.2025.07.24.23.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 23:10:51 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH v6 1/1] test-delta: Replaced space-based indentation with tabs to follow Git coding style.
Date: Fri, 25 Jul 2025 06:10:38 +0000
Message-Id: <20250725061038.3130912-1-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaced space-based indentation with tabs to follow Git coding style.
No functional changes.

Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
---
 t/helper/test-delta.c | 78 ++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 53 deletions(-)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 6bc787a474..4977ee4eaf 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -11,6 +11,7 @@
 #include "test-tool.h"
 #include "git-compat-util.h"
 #include "delta.h"
+#include "strbuf.h"
 
 static const char usage_str[] =
 	"test-tool delta (-d|-p) <from_file> <data_file> <out_file>";
@@ -18,68 +19,39 @@ static const char usage_str[] =
 int cmd__delta(int argc, const char **argv)
 {
 	int fd;
-	struct stat st;
-	void *from_buf = NULL, *data_buf = NULL, *out_buf = NULL;
-	unsigned long from_size, data_size, out_size;
-	int ret = 1;
+	struct strbuf from = STRBUF_INIT, data = STRBUF_INIT;
+	char *out_buf;
+	unsigned long out_size;
 
-	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
-		fprintf(stderr, "usage: %s\n", usage_str);
-		return 1;
-	}
+	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p")))
+        	usage(usage_str);
 
-	fd = open(argv[2], O_RDONLY);
-	if (fd < 0 || fstat(fd, &st)) {
-		perror(argv[2]);
-		return 1;
-	}
-	from_size = st.st_size;
-	from_buf = xmalloc(from_size);
-	if (read_in_full(fd, from_buf, from_size) < 0) {
-		perror(argv[2]);
-		close(fd);
-		goto cleanup;
-	}
-	close(fd);
-
-	fd = open(argv[3], O_RDONLY);
-	if (fd < 0 || fstat(fd, &st)) {
-		perror(argv[3]);
-		goto cleanup;
-	}
-	data_size = st.st_size;
-	data_buf = xmalloc(data_size);
-	if (read_in_full(fd, data_buf, data_size) < 0) {
-		perror(argv[3]);
-		close(fd);
-		goto cleanup;
-	}
-	close(fd);
+	if (strbuf_read_file(&from, argv[2], 0) < 0)
+        	die_errno("unable to read '%s'", argv[2]);
+	if (strbuf_read_file(&data, argv[3], 0) < 0)
+        	die_errno("unable to read '%s'", argv[3]);
 
 	if (argv[1][1] == 'd')
-		out_buf = diff_delta(from_buf, from_size,
-				     data_buf, data_size,
+        	out_buf = diff_delta(from.buf, from.len,
+				     data.buf, data.len,
 				     &out_size, 0);
 	else
-		out_buf = patch_delta(from_buf, from_size,
-				      data_buf, data_size,
+        	out_buf = patch_delta(from.buf, from.len,
+				      data.buf, data.len,
 				      &out_size);
-	if (!out_buf) {
-		fprintf(stderr, "delta operation failed (returned NULL)\n");
-		goto cleanup;
-	}
 
-	fd = open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
-	if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
-		perror(argv[4]);
-		goto cleanup;
-	}
+	if (!out_buf)
+        	die("delta operation failed (returned NULL)");
+
+	fd = xopen(argv[4], O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (write_in_full(fd, out_buf, out_size) < 0)
+        	die_errno("write(%s)", argv[4]);
+	if (close(fd) < 0)
+        	die_errno("close(%s)", argv[4]);
 
-	ret = 0;
-cleanup:
-	free(from_buf);
-	free(data_buf);
+	strbuf_release(&from);
+	strbuf_release(&data);
 	free(out_buf);
 
-	return ret;
+	return 0;
 }
-- 
2.34.1

