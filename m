Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5734A24678A
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349627; cv=none; b=PNYhOMN65j/wauMzPFyS8ZMv35qHZWIXNEbDdNCcDCCwIWwthKcXSfx/DmMYST9KRiZdOTynMHiwOC6xwFibcK3t/I+k6A32oxVRnPQLgoWsKjPR0c829dqAheZRPfkfjKz4qWt0QdrA6B/j7bmhDvdgLQqdoV6WJ88VNSwNEzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349627; c=relaxed/simple;
	bh=M9C/YSO7ItwcAi9/M1qXMRp0rrn1edz10C+yvDoJjY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Wa/Lal2WM2HMnn69JjuIInsKwAdCv4v00eALjy6yU3+ESg3TxCyTsdsUSmWN0jPp5MggAtXe1EdXj8s1A5RiVFrJhrCOMilwlBN6GgN5MT5tIKphZuwhDvSOKsPvbx+4pUWYQRtkzE5whtrJkB4ywiGAWfzfH3vBN03XUZm44Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcpwUrlO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcpwUrlO"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-75ab31c426dso691386b3a.3
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753349624; x=1753954424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyi/lMsmB5YlXfzk2g4UBiNnVvgRhpw4HHAI9d6f8OA=;
        b=IcpwUrlOQ9pV56XFYl92hl+x3MYdRulpPRcdMlO7AZQM3dNR8uDNhVFo0unHlStotS
         gp4eI76URM+SX62M2N7lAA1egzNzxYm7eZUsa717Gc+uotkygx3FW08NEHqmxayrp3SC
         F7FbuPlC0avaGa5EF1KHw5aOgCwSN64NIsLjcNp4rRRTV1pR7uKkQmZ1Wwooo8U5tkQo
         2LR07VneVgsEzyqBBzRe7K5DXYqtBh2bK/333YrraK5pM6I1KCYERYHCZTT2U2bFTDTR
         dCbQxX477iAb5sAVbUixO8hW4D/cKc+hVdHkjw1daS0mR9Y5KCSDrNCZXF+udRMEq6Bv
         My/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349624; x=1753954424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyi/lMsmB5YlXfzk2g4UBiNnVvgRhpw4HHAI9d6f8OA=;
        b=Mc6qS3cHcX4ROF0Hwf2l0thqIVqQycfYVNp2LZzfZV7VpZtZ6hiqbI9o3TDaTk5r3h
         7Pgz1yGXcum/qLGTI4II2HMggf7E+E9IBguas+PFGCvzlAefjM2YRMu7CVd4zf+5ROGj
         3EsLejByj4L98X8m7x7vizWd4P0ocb6QelyU3Ml+wdx6+3J/9mmOi/Oju2zJ8py8NWaD
         Nf6vrAwM2Uyirswk4szFksZfmWQQLT2/bRnDCXHmVc0uxcujSDtNQb4qdGJ+JMBqCdvz
         XL8pXWwIHY60+JjxNv7UPGbSWZIjBcl6Et5MALUb+6hNajsjUHOIOP/bVvsRL634Vki1
         sCTw==
X-Gm-Message-State: AOJu0Ywy8gRBD9ntbM2ZDQPbHg2yeywXjHkrlOi5zNkl6ZbNNn5bsJLS
	RLwDBCMgjBiwCqVsN1TutIQBEZdW3nf/yAKl/uVvDnIcpBdGNp4rnNEmF+qwbg==
X-Gm-Gg: ASbGncsm6K22cibyGziDOgdzOShB+/T7TqAEdh2nrqU2IGl9ab1/Dp+QZDPe+5oAB+Y
	f2XzmfuQ8CeD5yx9NxzN1u2pTVwlYiguDmx04iUdLkF+j+cCcvkNHZ9rhMUB3ltuyz890mu6zJx
	uFYSqWs8xyj+V9690QO8Ci6XWW0LZs5DXY3uvfCKJzENgg8fgPbdm5Si9pw05/pdkJApX8FdXnW
	xQ/4MXKr4W/XB5CKc/LlSUCKWrmDVtSsxyvfhUomFs6f/Il/qgx78lmkD39xMfOjLVZcZPaX4Lo
	Xgfwm1uubZ+Nv0/GPwxuRF1T31bpKTG/CyJE9OJ1BGCEjrUmPH+YmDMftQRcHFriEV8SI9630Pd
	kTykW1DOcp5Y0043kMBRzytlkow3oYPd1/Q==
X-Google-Smtp-Source: AGHT+IFUguo4qcba/kwU/LiVfbr25PQx0tiMu3PG597Qo3d9lrxAVny/i5uTX6fArTPDIRitk0giqQ==
X-Received: by 2002:a05:6a20:7285:b0:215:e60b:3bcf with SMTP id adf61e73a8af0-23d491bf04dmr9573343637.30.1753349624064;
        Thu, 24 Jul 2025 02:33:44 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c07f7c1sm1025319a12.13.2025.07.24.02.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 02:33:43 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH v4 1/1] test-delta: simplify delta helper with strbuf and better cleanup
Date: Thu, 24 Jul 2025 09:33:27 +0000
Message-Id: <20250724093327.2261615-1-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactor the `test-tool delta` implementation to improve clarity and robustness:

- Replace raw pointer/length buffer handling with `strbuf` for `from` and `data` inputs.
  This simplifies the code and avoids potential issues such as:
  - off_t to size_t truncation when allocating large buffers
  - reading fewer bytes than expected without notice

- Add an explicit `close(fd)` after writing the output file to avoid leaking file descriptors
  and to properly detect and report close() errors.

- Use `die()`/`die_errno()` consistently to handle all failure paths, simplifying error handling.

This change not only cleans up the code but also improves safety and sets a better example
for writing robust file-handling logic.

Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
---

Thank you very much for your detailed and thoughtful feedback.

I've taken your suggestions seriously and reflected them fully in the updated patch.
Switching to strbuf_read_file() not only simplified the code but also helped me better understand subtle bugs related to buffer allocation and file reading. In particular, I learned a lot about the risks of integer truncation between off_t and size_t, as well as the importance of handling early EOF conditions correctly.

Also, your note on leaking file descriptors and the explanation around why we should avoid combining write_in_full() and close() in a single if condition was incredibly insightful. It deepened my understanding of how seemingly small patterns can lead to subtle bugs or bad practices, even in short-lived test helpers.

I sincerely appreciate your time and guidance — it helped me not only improve the patch but also grow as a contributor.

 t/helper/test-delta.c | 95 +++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 62 deletions(-)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index f5811e96ad..1c4322b7c0 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -11,76 +11,47 @@
 #include "test-tool.h"
 #include "git-compat-util.h"
 #include "delta.h"
+#include "strbuf.h"
 
 static const char usage_str[] =
 	"test-tool delta (-d|-p) <from_file> <data_file> <out_file>";
 
 int cmd__delta(int argc, const char **argv)
 {
-	int fd = -1;
-	struct stat st;
-	void *from_buf = NULL, *data_buf = NULL, *out_buf = NULL;
-	unsigned long from_size, data_size, out_size;
-	int ret = 1;
+	int fd;
+        struct strbuf from = STRBUF_INIT, data = STRBUF_INIT;
+        char *out_buf;
+        unsigned long out_size;
 
-	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
-		fprintf(stderr, "usage: %s\n", usage_str);
-		return 1;
-	}
+	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p")))
+                usage(usage_str);
 
-	fd = open(argv[2], O_RDONLY);
-	if (fd < 0 || fstat(fd, &st)) {
-		perror(argv[2]);
-		goto cleanup;
-	}
-	from_size = st.st_size;
-	from_buf = xmalloc(from_size);
-	if (read_in_full(fd, from_buf, from_size) < 0) {
-		perror(argv[2]);
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
-		goto cleanup;
-	}
-	close(fd);
+	if (strbuf_read_file(&from, argv[2], 0) < 0)
+                die_errno("unable to read '%s'", argv[2]);
+        if (strbuf_read_file(&data, argv[3], 0) < 0)
+                die_errno("unable to read '%s'", argv[3]);
 
 	if (argv[1][1] == 'd')
-		out_buf = diff_delta(from_buf, from_size,
-				     data_buf, data_size,
-				     &out_size, 0);
-	else
-		out_buf = patch_delta(from_buf, from_size,
-				      data_buf, data_size,
-				      &out_size);
-	if (!out_buf) {
-		fprintf(stderr, "delta operation failed (returned NULL)\n");
-		goto cleanup;
-	}
-
-	fd = open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
-	if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
-		perror(argv[4]);
-		goto cleanup;
-	}
-
-	ret = 0;
-cleanup:
-	free(from_buf);
-	free(data_buf);
-	free(out_buf);
-
-	if (fd >= 0)
-		close(fd);
-
-	return ret;
+                out_buf = diff_delta(from.buf, from.len,
+                                     data.buf, data.len,
+                                     &out_size, 0);
+        else
+                out_buf = patch_delta(from.buf, from.len,
+                                      data.buf, data.len,
+                                      &out_size);
+
+	if (!out_buf)
+                die("delta operation failed (returned NULL)");
+
+	fd = xopen(argv[4], O_WRONLY | O_CREAT | O_TRUNC, 0666);
+        if (write_in_full(fd, out_buf, out_size) < 0)
+                die_errno("write(%s)", argv[4]);
+        if (close(fd) < 0)
+                die_errno("close(%s)", argv[4]);
+
+	strbuf_release(&from);
+        strbuf_release(&data);
+        free(out_buf);
+
+        return 0;
 }
-- 
2.34.1

