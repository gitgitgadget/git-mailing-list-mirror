Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640163;
	b=oXLiB504zKxYqhJ8k97wM5hCy7HGQXz+606F1Bt5CaFYU1fgVrgkvhLjsH7WiRcMClhA
	 gjJ5muuhegVk4uFT+jBjThdTewVBwc8MMWUYFinD9Wj0Mgt8ISWlv0PZC+Ik7wpgpumQV
	 NPGihIFEFrTyGjLeRtuiOErgsFar9XiP1KaM6lzsDrQbBSesbzQK7C2xPlPo7Iv4d3Lqx
	 ddGAdr2gP+LgR69vWPKvcp6UbCT70aVURr3VIdc8t/v8XRmLzHOfZsFPrSEGYiBXaIGY3
	 DeMKVS7OnHrkHpDgnKlpiPEC7FWqyg7+7rpZ5mutqFVDsirlYg4/tIHcGxeRtp6Vm4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=pnZ/ZX2Pm6gfIxoTAx4E7Ecq3QDhp8BchClVkw0Cm9c=;
	b=ezNnLbQwE5SKBAsfSvfkBlen7I+4pQI3umpjbWN5tSINQYC6+mX03NiyNo1BIvWz082x
	 LnW0Xf/x+SjMSSdJ0+5Qi6aY+fc1S8faM3WZlW6+8O688rj0xIwrtySKFcOz1YW5WkLHc
	 7sp+w2Om3iZwkQyUs4m4ELSRxkTi6wLOsijo77nqEYRyGVw1Q4WuX1X4MbZtIL0P/z6I0
	 aYbg+B4izquUYr5s2zIDrZrARm3IGtDLRvQtmXaTA6DQMfCSeyTCZzkjOrulzW14lR/FP
	 H0nGFZT7KIG8Yzu2Y7nKXIuLAEeOcplJycTPKXAqjG2A6ADlzI8sHi/7mq3FaPvXjvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bveXI38C;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B432606A333
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 20:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B432606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bveXI38C
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-844a8bf7e25so3380738a34.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795640160; x=1796244960; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pnZ/ZX2Pm6gfIxoTAx4E7Ecq3QDhp8BchClVkw0Cm9c=;
        b=bveXI38Ct6UTJEziWGbDSbwAQhAFMlXvJBwUuJnpB3LMeoIaB2/pPSHKiQg/5S02Cv
         TdMjAZRNh4hEEOBHr7zTkgSHnPiGruMr4jYfbjV133eP8Kz3qje2k4K2S4RQsxbgc43+
         LB9ZnbkrT/WE6/AuPdMN1jTGnaOku+sdqmDeH5aH9dqbzqSeXnbKYfriZiGo2MvEepbr
         oAv/4RaapI4h3YUT0t+CxVGFG5TAdxr1qcRRxVOEb1Qzl5uc86YNj2lvUkMIaUO064wh
         Eqe0ug92a3GLo5oWkwATdCrL25Pc3JOtX2Jz/7A2nqeOsjaGIOemnMHmOYpN0oCVghX5
         rE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795640160; x=1796244960;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnZ/ZX2Pm6gfIxoTAx4E7Ecq3QDhp8BchClVkw0Cm9c=;
        b=ZeMRXxXLysleepaQJv4zFsmel1Ip2w1KiUyWvKJHQxJI0edOsAPhrvpHv73gIqIXqB
         QXmwAPaSOYTjnAkmQKuMRVTDjMY5jZxjbPASZePWRFGhjMl3C83IEJP8XGzzcYPuTXqj
         xZYmYjCfLGShpb81nwdkV4b8834ELRsAn5gps+l8zweZeqh9245NyILTWC3Ud3fBadJe
         VI4vAcja1sEZBvTvWR2Y75s4Ui0AOtn1dJpFz5vS+paUMk4l57+xC8ZiTCMZWS4XQAfU
         K8WT/4rY6qeD1+L+1hvYKKcjo5GHAOKObxTlIhb1oI8S7HG+abOqXr+JDihQr+3XwMeJ
         xDYg==
X-Gm-Message-State: APuU4Z8QlGzC5eOWOUV/cTZgcyNQUuYzkL3QMF8C+41MfFQTbMjYM1+k
	e7+crmiX57Rp5az89fE8lXyi8Ci5YR7in0GFhA7aLK2vTY80tlFC91P+xrn7CNaf
X-Gm-Gg: AZFdTZc1bFYesJbJQhev3fVSTSDyl5aih44MswFSJS8MaB/8iqMZtEyOneSPYYuruBm
	IHgWGC1KrQySlPQEeG9EzwV2ypV0QECi4wdtzelXbZoR3mmhabvTM2PgtmtaNLvYIXD4rVa334j
	8dNBk9JGHQu6gpHyUHutd4pooolPPNZ7UPmamQ6wzLx90P0W+ukKqzxvGP014bxGAFuWcRZZ8I+
	2hjcTD4Dyo+nZ+u6n4QqUM+6rRqX7h04BQcxb2un3HDbTG+Os39qcaRxewozWqO/8huKbykvx8J
	RpSVvUrzK6oghRCmoS1cPjtxtW+RUuNjXMCerJWvQJ9kgKpzt6uGei7nvkO3hQ/JMQ20fGaYn2S
	2mLbspSoIwDQeWfrY2kdtC9PgbiIKVerjEUWnhbKznj7Llqt6UwaoIiFYxcU7gOxTqjRLxKug2V
	1yPf6x/fED7qFYurJeNpdF46+8XxrNSDcygbdV7GNFDniH2uKDmjs3nTt4+h3duxQ+5xqDmVpmd
	x8jhlktfTqcmxJlDofLaSvps/5WHchxuLJpz8gjxRfyWUgI8LzMi8CkyAenVmvkGfEdgUD1rrsY
	oM3YDK2kZOr3MlQvWZQG7R5mEshdZqT6
X-Received: by 2002:a05:6830:4c0b:b0:862:b918:2019 with SMTP id 46e09a7af769-86315a6cccemr19895847a34.29.1795640159917;
        Wed, 25 Nov 2026 12:55:59 -0800 (PST)
Received: from [127.0.0.1] ([132.196.38.97])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863607d0f48sm4194559a34.7.2026.11.25.12.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:55:59 -0800 (PST)
Message-Id: <f38c7e71337632f2e86ef5716e90c776c491b762.1795640149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.v3.git.1795640149.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v3.git.1795640149.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 20:55:47 +0000
Subject: [PATCH v3 3/5] wrapper: avoid byte-count overflow in write_in_full()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Simon Richter <Simon.Richter@hogyros.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Accumulating the output count in `write_in_full()` can overflow because
it counts via a `ssize_t` variable which can overflow for valid `size_t`
sizes passed as input.

Since this function either completes the requested count or fails,
callers already know how many bytes were written on success. Let's just
return status instead, so the total transfer size need not fit in
`ssize_t`.

Pointed out by Coverity.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Assisted-by: GPT-6.1
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                        |  1 +
 config.c                        | 14 +++++------
 entry.c                         |  2 +-
 imap-send.c                     |  2 +-
 notes-merge.c                   | 13 ++--------
 odb/streaming.c                 |  6 ++---
 parallel-checkout.c             |  2 +-
 t/meson.build                   |  1 +
 t/unit-tests/u-reftable-stack.c |  2 +-
 t/unit-tests/u-wrapper.c        | 42 +++++++++++++++++++++++++++++++++
 wrapper.c                       |  6 ++---
 wrapper.h                       |  7 ++++--
 12 files changed, 66 insertions(+), 32 deletions(-)
 create mode 100644 t/unit-tests/u-wrapper.c

diff --git a/Makefile b/Makefile
index 4c84eea6e2..0687eb82d3 100644
--- a/Makefile
+++ b/Makefile
@@ -1564,6 +1564,7 @@ CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_SUITES += u-trailer
 CLAR_TEST_SUITES += u-urlmatch-normalization
 CLAR_TEST_SUITES += u-utf8-width
+CLAR_TEST_SUITES += u-wrapper
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
diff --git a/config.c b/config.c
index 5976a418d5..778fa247a8 100644
--- a/config.c
+++ b/config.c
@@ -2768,11 +2768,11 @@ static struct strbuf store_create_section(const char *key,
 	return sb;
 }
 
-static ssize_t write_section(int fd, const char *key,
-			     const struct config_store_data *store)
+static int write_section(int fd, const char *key,
+			 const struct config_store_data *store)
 {
 	struct strbuf sb = store_create_section(key, store);
-	ssize_t ret;
+	int ret;
 
 	ret = write_in_full(fd, sb.buf, sb.len);
 	strbuf_release(&sb);
@@ -2780,12 +2780,12 @@ static ssize_t write_section(int fd, const char *key,
 	return ret;
 }
 
-static ssize_t write_pair(int fd, const char *key, const char *value,
-			  const char *comment,
-			  const struct config_store_data *store)
+static int write_pair(int fd, const char *key, const char *value,
+		      const char *comment,
+		      const struct config_store_data *store)
 {
 	int i;
-	ssize_t ret;
+	int ret;
 	const char *quote = "";
 	struct strbuf sb = STRBUF_INIT;
 
diff --git a/entry.c b/entry.c
index 1c4f0f4407..03959a6c2d 100644
--- a/entry.c
+++ b/entry.c
@@ -290,7 +290,7 @@ static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca
 	char *new_blob;
 	struct strbuf buf = STRBUF_INIT;
 	size_t size;
-	ssize_t wrote;
+	int wrote;
 	size_t newsize = 0;
 	struct stat st;
 	const struct submodule *sub;
diff --git a/imap-send.c b/imap-send.c
index bf1d2cf74d..dccc2264de 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -392,7 +392,7 @@ static int socket_write(struct imap_socket *sock, const char *buf, int len)
 		n = SSL_write(sock->ssl, buf, len);
 	else
 #endif
-		n = write_in_full(sock->fd[1], buf, len);
+		n = write_in_full(sock->fd[1], buf, len) < 0 ? -1 : len;
 	if (n != len) {
 		socket_perror("write", sock, n);
 		close(sock->fd[0]);
diff --git a/notes-merge.c b/notes-merge.c
index d361e70a48..991490a187 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -319,17 +319,8 @@ static void write_buf_to_worktree(const struct object_id *obj,
 
 	fd = xopen(path, O_WRONLY | O_EXCL | O_CREAT, 0666);
 
-	while (size > 0) {
-		ssize_t ret = write_in_full(fd, buf, size);
-		if (ret < 0) {
-			/* Ignore epipe */
-			if (errno == EPIPE)
-				break;
-			die_errno("notes-merge");
-		}
-		size -= ret;
-		buf += ret;
-	}
+	if (write_in_full(fd, buf, size) < 0 && errno != EPIPE)
+		die_errno("notes-merge");
 
 	close(fd);
 	free(path);
diff --git a/odb/streaming.c b/odb/streaming.c
index 5ac172beb6..2228f31b57 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -247,7 +247,7 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 		goto close_and_exit;
 	for (;;) {
 		char buf[1024 * 16];
-		ssize_t wrote, holeto;
+		ssize_t holeto;
 		ssize_t readlen = odb_stream_read(st, buf, sizeof(buf));
 
 		if (readlen < 0)
@@ -268,9 +268,7 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 			goto close_and_exit;
 		else
 			kept = 0;
-		wrote = write_in_full(fd, buf, readlen);
-
-		if (wrote < 0)
+		if (write_in_full(fd, buf, readlen) < 0)
 			goto close_and_exit;
 	}
 	if (kept && (lseek(fd, kept - 1, SEEK_CUR) == (off_t) -1 ||
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 0bf4bd6d4a..a0dddfd0bf 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -274,7 +274,7 @@ static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
 	struct strbuf buf = STRBUF_INIT;
 	char *blob;
 	size_t size;
-	ssize_t wrote;
+	int wrote;
 
 	/* Sanity check */
 	ASSERT(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
diff --git a/t/meson.build b/t/meson.build
index 1cf1d95f70..8938d4eb47 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -27,6 +27,7 @@ clar_test_suites = [
   'unit-tests/u-trailer.c',
   'unit-tests/u-urlmatch-normalization.c',
   'unit-tests/u-utf8-width.c',
+  'unit-tests/u-wrapper.c',
 ]
 
 clar_sources = [
diff --git a/t/unit-tests/u-reftable-stack.c b/t/unit-tests/u-reftable-stack.c
index b6f1c6cc52..3e19f0466a 100644
--- a/t/unit-tests/u-reftable-stack.c
+++ b/t/unit-tests/u-reftable-stack.c
@@ -86,7 +86,7 @@ void test_reftable_stack__read_file(void)
 
 	cl_assert(fd > 0);
 	n = write_in_full(fd, out, strlen(out));
-	cl_assert_equal_i(n, strlen(out));
+	cl_assert_equal_i(n, 0);
 	err = close(fd);
 	cl_assert(err >= 0);
 
diff --git a/t/unit-tests/u-wrapper.c b/t/unit-tests/u-wrapper.c
new file mode 100644
index 0000000000..713ac0df92
--- /dev/null
+++ b/t/unit-tests/u-wrapper.c
@@ -0,0 +1,42 @@
+#include "unit-test.h"
+#include "tempfile.h"
+
+static struct tempfile *file;
+static char data[128 * 1024], actual[sizeof(data)];
+
+void test_wrapper__initialize(void)
+{
+	file = mks_tempfile("wrapper-test-XXXXXX");
+	cl_assert(file != NULL);
+	for (size_t i = 0; i < sizeof(data); i++)
+		data[i] = i % 127;
+	memset(actual, 0, sizeof(actual));
+}
+
+void test_wrapper__cleanup(void)
+{
+	delete_tempfile(&file);
+}
+
+void test_wrapper__write_in_full(void)
+{
+	int fd = get_tempfile_fd(file);
+
+	cl_assert_equal_i(write_in_full(fd, data, sizeof(data)), 0);
+	cl_assert(lseek(fd, 0, SEEK_SET) == 0);
+	cl_assert(read_in_full(fd, actual, sizeof(actual)) ==
+		  (ssize_t)sizeof(actual));
+	cl_assert(!memcmp(data, actual, sizeof(data)));
+}
+
+void test_wrapper__write_in_full_empty(void)
+{
+	cl_assert_equal_i(write_in_full(-1, NULL, 0), 0);
+}
+
+void test_wrapper__write_in_full_error(void)
+{
+	errno = 0;
+	cl_assert_equal_i(write_in_full(-1, data, 1), -1);
+	cl_assert_equal_i(errno, EBADF);
+}
diff --git a/wrapper.c b/wrapper.c
index 05a9cd369c..87e1b4bfd2 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -302,10 +302,9 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
 	return total;
 }
 
-ssize_t write_in_full(int fd, const void *buf, size_t count)
+int write_in_full(int fd, const void *buf, size_t count)
 {
 	const char *p = buf;
-	ssize_t total = 0;
 
 	while (count > 0) {
 		ssize_t written = xwrite(fd, p, count);
@@ -317,10 +316,9 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
 		}
 		count -= written;
 		p += written;
-		total += written;
 	}
 
-	return total;
+	return 0;
 }
 
 ssize_t xwritev(int fd, struct iovec *iov, int iovcnt)
diff --git a/wrapper.h b/wrapper.h
index a6287d7f4d..726c5c2f6b 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -45,7 +45,10 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
 int git_mkstemp_mode(char *pattern, int mode);
 
 ssize_t read_in_full(int fd, void *buf, size_t count);
-ssize_t write_in_full(int fd, const void *buf, size_t count);
+
+/* Return 0 on a complete write, or -1 with errno set on failure. */
+int write_in_full(int fd, const void *buf, size_t count);
+
 ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
 
 /*
@@ -57,7 +60,7 @@ ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
  */
 ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt);
 
-static inline ssize_t write_str_in_full(int fd, const char *str)
+static inline int write_str_in_full(int fd, const char *str)
 {
 	return write_in_full(fd, str, strlen(str));
 }
-- 
gitgitgadget

