Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472033;
	b=Eyxs8pftDhe3oUNvVnfUZoLR2Z96gbgM1a24xQIUef8hbNmdQ16e35bL1yl1vZiwjZZ2
	 xoEz0eaJVyPUIgqEdqbu5y5E+K56RzIuWFLs3hIB73Pt0wp5UlbfCPQBLlWQhjAG3hL1s
	 5/csKukL62RkHN9k6N9HtpX0Yrm0+9OIbBMxbPuumMrPD/LXhYFSwAvxslrC1y83vkQbY
	 W6DpK+OM5vZLmavQDzG6vieisA0QJpEjNShPmu9+yCAbfBQNFEDsHDCUHqcFfBmCV71hC
	 iA3KJN66VwzVqIOVUzeE84pCmfAvgb5C8N5fuLHp9jL/5UZOBkn+HPCetBFDnqjuuuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=NfeOIejW0KZGbxCJtJBpEHpQ+VBLcGnHNf00I2uV+E4=;
	b=OIbpnULo1kN132b3TFQBeyZERcgBFfI/oWv1XIikLezMO9yxr3DJL3iuXp6EPu4sPdyC
	 rix7HOpVIGMeU+ykSk6F0MENjXJ1lkZgBL1MOFGvVez+WyrjYphuxejsTQhYMrdSA8/bc
	 ajlehsxvqb08zQ/iWVZNIsZUYvN4fHDUZLM/DXVU2ILt1sYzwZoOPdo2NMjJLln5L0WEQ
	 4PLEIR1jH4kfuMchJZVLOhDEr8yP2TybMk0WX8mBlKU+6I8uVSwFDVbdNZrUKDLrdCl30
	 ws+oq/CF+BLEINLpCdO5rKgQ3lcXhwNqMdNNTRJmVE7zvbrO+LDphUHAfJtb+3Lk4bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yfd5LWEI;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE085606A685
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 22:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE085606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yfd5LWEI
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15dd124bbe7so3116222c88.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 14:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472032; x=1796076832; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NfeOIejW0KZGbxCJtJBpEHpQ+VBLcGnHNf00I2uV+E4=;
        b=yfd5LWEI9NFiHrGy2zk8dFUKV+vI+Mtsu0S1pyxCVgvLcEknRAHHf2Y4TFWOllX/7u
         fYEbNpG/MQN/tgXbiWuES4euQVFvhdDYVisbg4ePF0kTt5pzdDPmz6VjCuIgUaQIQxH/
         MPDfmiolLE24H/wPsEZyqMF1AM5t4yxuapAFdiQFQ8MhPYx3j1kZOsTxsLTnEWNJDu/s
         MwvQAkLK4yKqksJsO5XAQ/TA7ebV83Ou4UUsktiOKo3CdphfEz1hy8JX4OeJ76D02jv0
         liusxdPKqjCLudwLPYwboc7nt9ZtES4N+cVvFgqQ8O3p1bSi6e+kSHsW5x9ZeHz5tAgV
         tDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472032; x=1796076832;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NfeOIejW0KZGbxCJtJBpEHpQ+VBLcGnHNf00I2uV+E4=;
        b=ZZwO3DfinnZJtHQkx9p9PFG1iyd3ZAoWypMxXIvO4jxABtX4PzEE4Nw10a/murqTEc
         yWo7UK2oYL68w0rstHZgMoCiIbkzkDyugJHSpN01GmUxD9V+p3dlqyUL2BA3JEwiAd+q
         zGJBZ+I2IRC6ldiR3cR0+js98L/feNxW6yCQrmzDoS8Ynjt6WO537MfbY4yMvHjQ0Syt
         NXFyt+s0sE/ZZ9AsyahVC6mcO/k+Tj9AVgSp8SmhILSVBbgY4gMe8mdJWoYSJzzdB8NC
         yBPX2/pSZLJhZLCDVSdBdjV7Zktfh9rsqSMQ9ZfhIEyLtdPgxQin4/PvywXBn4z5A6Z3
         1k6Q==
X-Gm-Message-State: APuU4Z/0gx6YgGtPBr1owrzIDTkw8ytIaUQH5rUeYUl2Ms6+v+H1XAW1
	G1AlIa4rIJmOTOYvqu1U7pQ6kUOy6a3aghBL+G6+h8ost4Tt0pG1TSDoayybyUwu
X-Gm-Gg: AZFdTZc3OZUIufsulorG9ugWGH9hPwfEt+MI+6ejcyAYh4QeZRIPzpJzatIiG8TSbzZ
	JV3jYvHJxaYhpcLFJp7CEGxYiKPKHKxSWpsEJEDxLc387na4UM6qr0xvs6ipuCe5aMf2+dT8tOL
	F+oEfpYwGSkgpPPzqgsS2mPlEDJSvzxxTrmOYvMx+ZlAvalzSc7Yu96txPjL3/OqqlyHF6HgFBq
	fDVV7U+7RBAxEaeJBW+6JBxd90iQGv740Y2NoUEcjLgKhNTvyEnqmoXzZnTr0q4j33uPIifo4Gf
	E/hmZfXVT/v2eQPYIcAl2lrtisN0YAurz5/jLQ4x68XMwKFpjYxy6lV3BRgAjovSkoGD5LcXnzA
	jQVpcvYXPOfu80dzFkVkKuyGd7xx9fSe3rwcqFaubJfBDJqrfwewIS4oTO4K+8b3yEZL9MeQp+F
	OH3iF+B7G7tJjs0s+ZPjdno//toMhgdUu/HD8Btm+2Pve2VylUmRg9EclarIBddVBI/xGOq/jGo
	nTlek7oHXkZcMSHL9kxN0iSxYD7JwwgePIlxO153xhDReVOU1W6HsAu4o1X9GcTppZfrAPx4xR2
	LGjG2UYR6OkvxDvODcMykNqz7wVLAg==
X-Received: by 2002:a05:701b:2814:b0:1b5:1a5a:1dc with SMTP id a92af1059eb24-1b5568bcbb3mr15148377c88.12.1795472031763;
        Mon, 23 Nov 2026 14:13:51 -0800 (PST)
Received: from [127.0.0.1] ([51.57.82.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm17798659c88.4.2026.11.23.14.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:13:51 -0800 (PST)
Message-Id: <b24520c50dc1ccc079ce6194b9ff9028e38e1b2b.1795472027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Nov 2026 22:13:44 +0000
Subject: [PATCH v2 3/5] wrapper: avoid byte-count overflow in write_in_full()
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
 imap-send.c                     |  2 +-
 notes-merge.c                   | 13 ++--------
 t/meson.build                   |  1 +
 t/unit-tests/u-reftable-stack.c |  2 +-
 t/unit-tests/u-wrapper.c        | 42 +++++++++++++++++++++++++++++++++
 wrapper.c                       |  6 ++---
 wrapper.h                       |  7 ++++--
 8 files changed, 55 insertions(+), 19 deletions(-)
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

