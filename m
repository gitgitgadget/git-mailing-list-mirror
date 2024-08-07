Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B876F30F
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040228; cv=none; b=jeygqqwmkCKMvBnPZerL4G2ZoBjAlxF6SBwyfSp8uhjIQBAsp73BigisPfuecV9vjo8NOemUkkZ+hVVDH130qz227I/xirXG1ia93tTlM+V+GXZhV6r9OAQt5939wf2Hqq5bE6Ave4K9xiR0u9gTMMNp/TxgfaQ4Ph1FjRRgHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040228; c=relaxed/simple;
	bh=SssNslPjSsfYZ9shahd5fXGEigqzQQQFD9Ov1Q10OOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLGH2WrEcYe1visx9D9Ivwyxc6MOZ29VtjDYD4XnTAlS6MZE24oFtoilyl+Ng7UNABFtgcrc7iuD3qt0+gTKgZwTQ2kIXN/EY5OFvGQZok+f8jo2bnWOhVlEmXV5kpk58OutVGP6ZqFqeo8qs9I3YfcI3Mngn2aaJOR7StEb604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bruDmJGo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bruDmJGo"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb5243766dso1517352a91.0
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723040226; x=1723645026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieCvH3IpQOFsuNFQLYDD1RJgReIjXcY6lWpvV54jsI8=;
        b=bruDmJGou0+pNjuj8HXP60R3/gVbwCh8FM0a7UiRq08+IGqcRWU0qVpywczRgL+rNc
         tfyqRTCWe7BCEVxh5c2iV5bMJOce+HYAcOXSjrfpHMd6Q31YzwwB+Q3oQKDARwqXjSmP
         WNjsIBrXb+JoMNce/Q/XlDcxCunt+BlIHumbXkymgbzd9i2AyXIoTi4hWRmkwCS57MKP
         yVmiCn3KcOd35u4tNmbLQbvor8tADO7aXkqJnkypLHMPwE53SUpj3cTZqqI2SxHMjFlV
         LPQl8fWo43LZE18ay/YddePIpMz9T0r8aEFLqoDMmevHsbSfJiYFnCP6uZwDLpqctSap
         E2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723040226; x=1723645026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieCvH3IpQOFsuNFQLYDD1RJgReIjXcY6lWpvV54jsI8=;
        b=CutRoGgrJlrDuLr1crHjGDIn1B7mgxin1UF6YQs0JrRTpX/3uyvwdEL1xIoZaGDBj7
         t5c1T22H84TluyAOCoE4ohGnWOzHY0LXKkj9pwdqzorVyL9u6DR+jWgW8INZ/dipmL4m
         oRcplcY7r8qTQrMPjKu/WSw9M2Rzqfcqu1qxHVkJXcIj4CC791Kf2kxnHWAsdXSBu700
         au1GY0bKW4AxzwbwdfK8Tq5UIwzRgkK4f1tUoKlJfPoTqFnd1IOORU4jj1HwfmzfJDmw
         lBQqsEYP0Agp6KErjug454rxs5pJQoNIeoLpzEErQhlhrRyv9pq9T8TiRVDwJsKVT8VM
         tNdQ==
X-Gm-Message-State: AOJu0YwNmTzRVH2UJ2AusZGEg3yCcvRCEpvB2QJnKyMrTVjxPhMe9hes
	ys9q0vCzvA+MvE7CZbO30RumtxTpSeaNnRS/ijMIIFAtgKl/yTKXQ6PCLXPv
X-Google-Smtp-Source: AGHT+IEcYWB6sWTLBN/jYu4VCEHDSpdsm9tX/x4com40ZRQgcfv1eymrzWiqK9qdOIusKlAYKMgyRQ==
X-Received: by 2002:a17:90a:7307:b0:2c9:6f06:8005 with SMTP id 98e67ed59e1d1-2cff9524412mr20880793a91.26.1723040225816;
        Wed, 07 Aug 2024 07:17:05 -0700 (PDT)
Received: from Ubuntu.. ([106.205.252.196])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d1b374b3cesm1635059a91.48.2024.08.07.07.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:17:05 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/5] t-reftable-readwrite: add tests for print functions
Date: Wed,  7 Aug 2024 19:42:01 +0530
Message-ID: <20240807141608.4524-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240807141608.4524-1-chandrapratap3519@gmail.com>
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable/reftable-reader.h lists two print functions useful in
debugging, reftable_reader_print_file() and
reftable_reader_print_blocks(). As of now, both these functions
are left unexercised by all of the reftable tests. Add a test
function to exercise both these functions. This has the added
benefit of testing reftable_block_source_from_file(), which
currently remains untested as well.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-readwrite.c | 75 +++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index a5462441d3..8c6f2f1f5d 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -11,6 +11,8 @@ license that can be found in the LICENSE file or at
 #include "reftable/blocksource.h"
 #include "reftable/reftable-error.h"
 #include "reftable/reftable-writer.h"
+#include "tempfile.h"
+#include "write-or-die.h"
 
 static const int update_index = 5;
 
@@ -25,11 +27,23 @@ static ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
 	return sz;
 }
 
+static ssize_t fd_write(void *b, const void *data, size_t sz)
+{
+	int *fdp = (int *)b;
+	return write_in_full(*fdp, data, sz);
+}
+
 static int noop_flush(void *arg)
 {
 	return 0;
 }
 
+static int fd_flush(void *arg)
+{
+	int *fdp = (int *)arg;
+	return fsync_component(FSYNC_COMPONENT_REFERENCE, *fdp);
+}
+
 static void t_buffer(void)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -944,6 +958,66 @@ static void t_corrupt_table(void)
 	strbuf_release(&buf);
 }
 
+static void t_table_print(void)
+{
+	char name[100];
+	struct reftable_write_options opts = {
+		.block_size = 512,
+		.hash_id = GIT_SHA1_FORMAT_ID,
+	};
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_log_record log = { 0 };
+	struct reftable_writer *w = NULL;
+	struct tempfile *tmp = NULL;
+	size_t i, N = 3;
+	int n, fd;
+
+	xsnprintf(name, sizeof(name), "t-reftable-readwrite-%d-XXXXXX", __LINE__);
+	tmp = mks_tempfile_t(name);
+	fd = get_tempfile_fd(tmp);
+	w = reftable_new_writer(&fd_write, &fd_flush, &fd, &opts);
+	reftable_writer_set_limits(w, 0, update_index);
+
+	for (i = 0; i < N; i++) {
+		xsnprintf(name, sizeof(name), "refs/heads/branch%02"PRIuMAX, (uintmax_t)i);
+		ref.refname = name;
+		ref.update_index = i;
+		ref.value_type = REFTABLE_REF_VAL1;
+		set_test_hash(ref.value.val1, i);
+
+		n = reftable_writer_add_ref(w, &ref);
+		check_int(n, ==, 0);
+	}
+
+	for (i = 0; i < N; i++) {
+		xsnprintf(name, sizeof(name), "refs/heads/branch%02"PRIuMAX, (uintmax_t)i);
+		log.refname = name;
+		log.update_index = i;
+		log.value_type = REFTABLE_LOG_UPDATE;
+		set_test_hash(log.value.update.new_hash, i);
+		log.value.update.name = (char *) "John Doe";
+		log.value.update.email = (char *) "johndoe@anon.org";
+		log.value.update.time = 0x6673e5b9;
+		log.value.update.message = (char *) "message";
+
+		n = reftable_writer_add_log(w, &log);
+		check_int(n, ==, 0);
+	}
+
+	n = reftable_writer_close(w);
+	check_int(n, ==, 0);
+
+	test_msg("testing printing functionality:");
+	n = reftable_reader_print_file(tmp->filename.buf);
+	check_int(n, ==, 0);
+	n = reftable_reader_print_blocks(tmp->filename.buf);
+	/* end of blocks is denoted by a return value of 1 */
+	check_int(n, ==, 1);
+
+	delete_tempfile(&tmp);
+	reftable_writer_free(w);
+}
+
 int cmd_main(int argc, const char *argv[])
 {
 	TEST(t_buffer(), "strbuf works as blocksource");
@@ -953,6 +1027,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(t_log_overflow(), "log overflow returns expected error");
 	TEST(t_log_write_read(), "read-write on log records");
 	TEST(t_log_zlib_corruption(), "reading corrupted log record returns expected error");
+	TEST(t_table_print(), "print tables and blocks");
 	TEST(t_table_read_api(), "read on a table");
 	TEST(t_table_read_write_seek_index(), "read-write on a table with index");
 	TEST(t_table_read_write_seek_linear(), "read-write on a table without index (SHA1)");
-- 
2.45.GIT

