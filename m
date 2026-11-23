Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472034;
	b=LeLE8DSuAJkesCdvmV4m8Ax9Q/bUXFBwifEIVIFGR+83dYQmqxKudNn3o6XVjVPUsbbD
	 8u3qgbpCghzhRIRFAYFjOfiPms6dmxeL4bjIMtvYWKOwupeTB5+r2BvCDhJFcffjHgYD3
	 DTK8+Jqd5Y+I/jTGaRugxwOlDY6Nd22MGY85v5YKQKBDZFGpBS2frKb+mMR3BSchiIrQO
	 4tl/LryiF9yUhm3EkH+deP3ch2svlZhEw2Rm6C8+Z5yRXs5ucwsVWLBgVW1Ps1LxRsFPj
	 p8hHMMl7o1V+RxdQ4jq1bOQJUJIerSxmL/BIA67nLgPD2vErawfAJCzJP63St9/50Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=XrFgrLnR8R7lYBR/GGSKEkkiR0lMp4RhnuLScMkz3qA=;
	b=rcK+XxO5m5IqoOCmJthFc6p9RftlUJvb5IXebznZN7YXqp8lWaU1HzaUSkiFl+PpqpFQ
	 CYw7fupbfdq8Haq+peuovGYL187WL1OLGcLxpDGTweMaG7qYJd1zkaRiGKn0bqGwzsC2s
	 fzaAoTOMYirfQ09HL2g0n7gKtMRL/bm361nok+n01vSbbp+3JbR2LSdDuQ7ybFZJpOmL0
	 lHsmSyi54GU6RKcMb8l70uSGffXpVxR90iV56rmQ5YNHCndkOdvW1wE/3B8hIroehiR0n
	 rRezXrI0iBA8DvSzTydd4zbqXeF5Fu+kA3EvPkVKteuX1pWDQj2wTgo03NcbBR2JhUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PslpZ7zR;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD8606A684
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 22:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5BD8606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PslpZ7zR
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-38644aedba1so5826586eec.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 14:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472033; x=1796076833; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XrFgrLnR8R7lYBR/GGSKEkkiR0lMp4RhnuLScMkz3qA=;
        b=PslpZ7zRzHS6ejkjMBJqEDPQ7OoMEGsb/dql5jY5QVLNN8SbCjOyf8Q9DgIAm+M1ij
         x/xzco8VohoHPlN1PBWlfYlYJP3XiL+/cjma659BVvfXt9log8f0SYrfJTz+iW2qJlS/
         qwDoR6fF5fdSgXC7PnQcC5O8JjWmw3/R2KZ26mDYs1Ec8Bej33PhsvvUiMSB+YcdemeL
         vD0oDuPaK3lluczBE0jDuzWtJA+HAroYWZNxrquuwpMwwMFPMDjMXWgyBCB6KwtQnyjN
         YaS7Ig/AP6mPndFzmrZuwuMON/U833y1O4ecH90zxsWWHnZzNKrj+RBR6seofZHom0TC
         eIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472033; x=1796076833;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XrFgrLnR8R7lYBR/GGSKEkkiR0lMp4RhnuLScMkz3qA=;
        b=WrAvBhPKpGpTt/Ni+sj1zuYPEQbVGGARcJXCOGk87tn7jP7rVlPuBgjEk9VfgJsVpC
         W0hVW49KfJdPzt5teS+e7lxPvK7LSCxCuoZurI5dj1JIpb5TjX8gZdzG+JRU79inhpiz
         g560YGr14ErrFVigo1p4M7H9BsMjSRQQ6MPVyoanUuUwG9uIEJDms7G7JSB6DyozGt4M
         Zj+mXffn+my6EXeUdx8fpnaRtJUl+lpiH2BwFDlmlJ0EnSUTSdnRPOc7GrdzzqfuMQny
         BJieGBrI57mfgvmsc2gBeOfO3lfpu+OvFFtQoYzvbIYh+H7y5WRbX/X+434Z5nrTDpcG
         cqHw==
X-Gm-Message-State: APuU4Z9eqZNOZqWYnrXet/Dy5N1OXkid5JB+0Owg9CSPPe7CSR0l4mOn
	tbd1MZlzr6KCUtK+kthNYcIgKwd3TBuNoUsMGKSvvHehZo4ebGRdYxAeRkIHaD9H
X-Gm-Gg: AZFdTZfyrJ6qSDF+s4oNMwRml1FevGSJOEETJjstjQsAwjB29y4JIriaWI/qmVoONbX
	2Ta9n5RWjNrnyb+a66l0lSmzqPoZ6tEHWZv5KFf3/yNyqwykR5s52KOZqjjMD5IptWdiVRd7wcL
	tQVDbNeX50FUVczIpuwlGHKjKyzgvOGEbVTwrKM/T9Zd716G1LGhMDnVf5CGbGdoKpa3I0wpcKt
	iUfnynzD5uxRw0bsknd+OPTe3MxNmIQaACewld5u8HRCYGhtspoZhdYmvzwss3GdbGf9tsKbEFr
	SQusnFKNuapLSdcekWwt0usrjuVGwxe2RXJtPQeAP2JeSnUOR2OfaJT6QnyIqsycOh1KTNFGIcF
	wHwzqtrWkiiu5tmx0xDB52j3aM5OrUAET1g2deKpPRypQL6hTbgfoN+hiySlIeZjlnYnIBA4oRp
	3JW1CwwyEi3dPs42gSWAE0h6LYC8Lv3BU/CTjilu6iM4duveTgDc5cVPV0uM6x7cw+cUItevB0i
	WKXqWgoW9TkgU/20lwnbEFW1v2G11FzTdZOI/hJGv+49YN47/JNa5Ws+TpS5vXS1OdpbGvFdZKZ
	IkqbMuWqofWXzg1oHlb/7rLyqnT2qA==
X-Received: by 2002:a05:693c:8843:b0:386:b429:fe0 with SMTP id 5a478bee46e88-386b429175cmr3255766eec.16.1795472032873;
        Mon, 23 Nov 2026 14:13:52 -0800 (PST)
Received: from [127.0.0.1] ([51.57.82.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm44590776eec.26.2026.11.23.14.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:13:52 -0800 (PST)
Message-Id: <ca30ed613d94ab11348e46ea60bc4f970e2f506c.1795472027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Nov 2026 22:13:45 +0000
Subject: [PATCH v2 4/5] wrapper: add read_in_full_or_error()
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

Callers of the `read_in_full()` function want to read all requested
bytes, or get an error. However, limiting the return value type to
`ssize_t` is insufficient, as file sizes can easily exceed that type's
range.

For those callers that do not require the return value to report the
number of read bytes, add a new function, `read_in_full_or_error()`,
that returns a Boolean to indicate success or faiure.

Callers that do need to know that byte count can still call
`read_in_full()`, but will now error out early if the requested byte
count exceeds what `ssize_t` can represent.

Pointed out by Coverity.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Assisted-by: GPT-6.1
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/blame.c          |  2 +-
 combine-diff.c           |  6 +----
 dir.c                    |  2 +-
 grep.c                   |  2 +-
 refs/packed-backend.c    |  4 +--
 strbuf.c                 | 10 ++++---
 t/unit-tests/u-wrapper.c | 57 ++++++++++++++++++++++++++++++++++++++++
 wrapper.c                | 50 ++++++++++++++++++++++++++++-------
 wrapper.h                |  7 +++++
 9 files changed, 116 insertions(+), 24 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 1e753a0b60..ddc49d8d30 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1006,7 +1006,7 @@ static void parse_default_ignore_revs_file(struct blame_scoreboard *sb,
 	}
 	size = xsize_t(st.st_size);
 	buf = xmalloc(size);
-	if (read_in_full(fd, buf, size) == (ssize_t)size)
+	if (!read_in_full_or_error(fd, buf, size))
 		oidset_parse_buffer_carefully(&sb->ignore_list, buf, size,
 					      sb->repo->hash_algo,
 					      peel_to_commit_oid, sb);
diff --git a/combine-diff.c b/combine-diff.c
index 717d537688..49202c6581 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1073,7 +1073,6 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			free_filespec(df);
 		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {
 			size_t len = xsize_t(st.st_size);
-			ssize_t done;
 			int is_file, i;
 
 			elem->mode = canon_mode(st.st_mode);
@@ -1089,11 +1088,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			result_size = len;
 			result = xmallocz(len);
 
-			done = read_in_full(fd, result, len);
-			if (done < 0)
+			if (read_in_full_or_error(fd, result, len) < 0)
 				die_errno("read error '%s'", elem->path);
-			else if (done < len)
-				die("early EOF '%s'", elem->path);
 
 			/* If not a fake symlink, apply filters, e.g. autocrlf */
 			if (is_file) {
diff --git a/dir.c b/dir.c
index ac246ced1d..1c9599c2bb 100644
--- a/dir.c
+++ b/dir.c
@@ -1190,7 +1190,7 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 			return 0;
 		}
 		buf = xmallocz(size);
-		if (read_in_full(fd, buf, size) != size) {
+		if (read_in_full_or_error(fd, buf, size) < 0) {
 			free(buf);
 			close(fd);
 			return -1;
diff --git a/grep.c b/grep.c
index 1d75d31421..c1c33fc140 100644
--- a/grep.c
+++ b/grep.c
@@ -1964,7 +1964,7 @@ static int grep_source_load_file(struct grep_source *gs)
 	if (i < 0)
 		goto err_ret;
 	data = xmallocz(size);
-	if (st.st_size != read_in_full(i, data, size)) {
+	if (read_in_full_or_error(i, data, size) < 0) {
 		error_errno(_("'%s': short read"), filename);
 		close(i);
 		free(data);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 53511f2d91..ff7ef84109 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -543,7 +543,6 @@ static int refname_contains_nul(struct strbuf *refname)
 
 static int allocate_snapshot_buffer(struct snapshot *snapshot, int fd, struct stat *st)
 {
-	ssize_t bytes_read;
 	size_t size;
 
 	size = xsize_t(st->st_size);
@@ -552,8 +551,7 @@ static int allocate_snapshot_buffer(struct snapshot *snapshot, int fd, struct st
 
 	if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
 		snapshot->buf = xmalloc(size);
-		bytes_read = read_in_full(fd, snapshot->buf, size);
-		if (bytes_read < 0 || bytes_read != size)
+		if (read_in_full_or_error(fd, snapshot->buf, size) < 0)
 			die_errno("couldn't read %s", snapshot->refs->path);
 		snapshot->mmapped = 0;
 	} else {
diff --git a/strbuf.c b/strbuf.c
index c3baa47b3f..55825d20e8 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -537,8 +537,12 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 
 	strbuf_grow(sb, hint ? hint : 8192);
 	for (;;) {
-		ssize_t want = sb->alloc - sb->len - 1;
-		ssize_t got = read_in_full(fd, sb->buf + sb->len, want);
+		size_t want = sb->alloc - sb->len - 1;
+		ssize_t got;
+
+		if ((uintmax_t)want > maximum_signed_value_of_type(ssize_t))
+			want = maximum_signed_value_of_type(ssize_t);
+		got = read_in_full(fd, sb->buf + sb->len, want);
 
 		if (got < 0) {
 			if (oldalloc == 0)
@@ -548,7 +552,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 			return -1;
 		}
 		sb->len += got;
-		if (got < want)
+		if ((size_t)got < want)
 			break;
 		strbuf_grow(sb, 8192);
 	}
diff --git a/t/unit-tests/u-wrapper.c b/t/unit-tests/u-wrapper.c
index 713ac0df92..28adfbdf8e 100644
--- a/t/unit-tests/u-wrapper.c
+++ b/t/unit-tests/u-wrapper.c
@@ -40,3 +40,60 @@ void test_wrapper__write_in_full_error(void)
 	cl_assert_equal_i(write_in_full(-1, data, 1), -1);
 	cl_assert_equal_i(errno, EBADF);
 }
+
+void test_wrapper__read_in_full_or_error(void)
+{
+	int fd = get_tempfile_fd(file);
+
+	cl_assert_equal_i(write_in_full(fd, data, sizeof(data)), 0);
+	cl_assert(lseek(fd, 0, SEEK_SET) == 0);
+	cl_assert_equal_i(read_in_full_or_error(fd, actual, sizeof(actual)), 0);
+	cl_assert(!memcmp(data, actual, sizeof(data)));
+}
+
+void test_wrapper__read_in_full_or_error_empty(void)
+{
+	cl_assert_equal_i(read_in_full_or_error(-1, NULL, 0), 0);
+}
+
+void test_wrapper__read_in_full_or_error_short(void)
+{
+	int fd = get_tempfile_fd(file);
+
+	cl_assert_equal_i(write_in_full(fd, "abc", 3), 0);
+	cl_assert(lseek(fd, 0, SEEK_SET) == 0);
+	errno = 0;
+	cl_assert_equal_i(read_in_full_or_error(fd, actual, sizeof(actual)),
+			  -1);
+	cl_assert_equal_i(errno, EIO);
+	cl_assert(!memcmp(actual, "abc", 3));
+}
+
+void test_wrapper__read_in_full_or_error_bad_fd(void)
+{
+	errno = 0;
+	cl_assert_equal_i(read_in_full_or_error(-1, actual, 1), -1);
+	cl_assert_equal_i(errno, EBADF);
+}
+
+void test_wrapper__read_in_full_short(void)
+{
+	int fd = get_tempfile_fd(file);
+
+	cl_assert_equal_i(write_in_full(fd, "abc", 3), 0);
+	cl_assert(lseek(fd, 0, SEEK_SET) == 0);
+	cl_assert_equal_i(read_in_full(fd, actual, sizeof(actual)), 3);
+	cl_assert(!memcmp(actual, "abc", 3));
+}
+
+void test_wrapper__read_in_full_empty(void)
+{
+	cl_assert_equal_i(read_in_full(-1, NULL, 0), 0);
+}
+
+void test_wrapper__read_in_full_error(void)
+{
+	errno = 0;
+	cl_assert_equal_i(read_in_full(-1, actual, 1), -1);
+	cl_assert_equal_i(errno, EBADF);
+}
diff --git a/wrapper.c b/wrapper.c
index 87e1b4bfd2..dba8b90dcc 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -283,23 +283,53 @@ ssize_t xpread(int fd, void *buf, size_t len, off_t offset)
 	}
 }
 
-ssize_t read_in_full(int fd, void *buf, size_t count)
+/*
+ * Read until count bytes have been read or EOF. On success, store the number
+ * read in out if non-NULL. Return false on an I/O error, with errno set.
+ */
+static bool read_in_full_1(int fd, void *buf, size_t count, size_t *out)
 {
 	char *p = buf;
-	ssize_t total = 0;
+	size_t remaining = count;
 
-	while (count > 0) {
-		ssize_t loaded = xread(fd, p, count);
+	while (remaining) {
+		ssize_t loaded = xread(fd, p, remaining);
 		if (loaded < 0)
-			return -1;
-		if (loaded == 0)
-			return total;
-		count -= loaded;
+			return false;
+		if (!loaded)
+			break;
+		remaining -= loaded;
 		p += loaded;
-		total += loaded;
 	}
 
-	return total;
+	if (out)
+		*out = count - remaining;
+	return true;
+}
+
+int read_in_full_or_error(int fd, void *buf, size_t count)
+{
+	size_t total;
+
+	if (!read_in_full_1(fd, buf, count, &total))
+		return -1;
+	if (total != count) {
+		errno = EIO;
+		return -1;
+	}
+	return 0;
+}
+
+ssize_t read_in_full(int fd, void *buf, size_t count)
+{
+	size_t total;
+
+	if ((uintmax_t)count > maximum_signed_value_of_type(ssize_t))
+		BUG("read_in_full() cannot return %"PRIuMAX" bytes",
+		    (uintmax_t)count);
+	if (!read_in_full_1(fd, buf, count, &total))
+		return -1;
+	return (ssize_t)total;
 }
 
 int write_in_full(int fd, const void *buf, size_t count)
diff --git a/wrapper.h b/wrapper.h
index 726c5c2f6b..47d441e6c9 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -44,8 +44,15 @@ char *git_mkdtemp(char *pattern);
 int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
 int git_mkstemp_mode(char *pattern, int mode);
 
+/*
+ * Return the number of bytes read, possibly short at EOF, or -1 on error.
+ * The requested count must be representable in ssize_t.
+ */
 ssize_t read_in_full(int fd, void *buf, size_t count);
 
+/* Return 0 on a complete read, or -1 with errno set (EIO on premature EOF). */
+int read_in_full_or_error(int fd, void *buf, size_t count);
+
 /* Return 0 on a complete write, or -1 with errno set on failure. */
 int write_in_full(int fd, const void *buf, size_t count);
 
-- 
gitgitgadget

