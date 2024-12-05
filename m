Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD921C164
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413804; cv=none; b=XUHHr7iMFATQEbhgHbpFpGjYHvWbQFgpls3zKKD4NmflPgBevWPVc9gq2jmB33vfE46tXQJGLBjKoeNF9+jLG6RxXmgYzx7zzPFMzzp1nSerc596Gu7j4fh4JvBOZzZ86yPxqit5Dfupd0LRo68grI6zRosjONums67dAVIekfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413804; c=relaxed/simple;
	bh=fFFLtOP564VpooDeWAyxhtG8Oo3gBf5SiiTZKRRmnhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dRZgNcc4cfqcAJWmlrrckjhBE+QLiaBn1gFivtRmq+nRFZ/PNrcrfan4/dKGJm2rHo0s1KTkSAgG1SvY/2RSQTMzTtVHpfya9UXVIJbw28FFFpzUjgV77h/5C9SjDWWskI3/9pxgvTb5NBWUHCRzXHQjYqUDusjxI2rTTwAzbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djMJ7XUd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djMJ7XUd"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa54adcb894so186675966b.0
        for <git@vger.kernel.org>; Thu, 05 Dec 2024 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733413800; x=1734018600; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MXOkl1662KDxqJxgNJT1Fca6oEnzH65kzM+2cXNrJe8=;
        b=djMJ7XUdk0C9EH3J355He7xdasuYQo75ej4nXtL+m4PyMZ/a1NcY39ku3RCv4E/9Ee
         zKu9YsILXQV9mJvZaAkEVb/G4MkQrkmtFohVvF/e8drq/NtotEVozwRxYLPOWZ8FkM9D
         WviyU6y2yHFAirISiY8FutioFP1BcmuAQ6N2fsX6FXfFASdzS7tEsROnUjLuN4o37FNK
         F7Z5iO1V1BwZaLepWUrcxkVAe3PfJmtgzs/ktJJeskVdKag8BQJEMgDrYTPrm4htMZTV
         hg0IUtzgw6xjw7GRHc1doFACdurLfApFpjw/m8HbRmno7S/h+jZgAVjBKZS5zGntftS1
         ASMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413800; x=1734018600;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXOkl1662KDxqJxgNJT1Fca6oEnzH65kzM+2cXNrJe8=;
        b=sWYKXRUYr364dBRaspSHzDahE4ASmGOPsY1Jh6imasmBo8x78mpR/QvabcEJowDiR2
         fZ/TiXDlcqn7M4aDci+XrKpFKAkmwqi9IyXnfY+lRkLbBl683c51vCKQdHb0GtRbHYFI
         RLEyUQXa718NJj/FtGaoR9LgdRAmnDNMv9RazsWxMs3x5BOZjea0Fqco2UYq5EE1SwNq
         pg/pQmyLWtcFFnkfKGEG0zng4i5BV38sqsLJgc+oDmFnrhYPE1IsKubwnlXUjjedNfzi
         0tqO4H45PqKFfG4cRi36YI8Z9ll2S0CLVcneBH+KCA8n/qVziRdADz/UR7R46Qq1p1T7
         oN4w==
X-Gm-Message-State: AOJu0YxQiBPyM0wwAC0bnTB3SRN/6PcOg6Khs3NwgJSvAuhXznqinm2j
	QkrlNI9NPREjv+lfvTBQCfS/E6YtKys8SUu+vIgodCDM8SeUi2XFSy0dB5WT
X-Gm-Gg: ASbGncuZ20j4Dj9cE3r4vo8hxlTE/TvZMgP+kxBoqrLkUe2p4lCQhRSY/A7lpUGYOaD
	rIpzlfy21dzdR5mWwsnLsibGxXyD02zXgfwPKQ+Sxb7KfaF8pXhKQBJwY4/uAMGQE4E4xtamdtw
	47S/NeZBUl/YMrFKsiXYYF9BOA/hk17WU3h6JwaWjWQenRdQNjQ9rU+NpKYslQYGVdJyKVjRqaX
	ybvcledXynueHP7kk/amoFT5JVnIgsCWnclMFlr5/p529BZ1c97
X-Google-Smtp-Source: AGHT+IFa0x91+ETGOG/FRt/+GBwK4Sk8tYH4ahcBtXVKUnhifMVPuBoxyx3hDclAyHdByYN+GTCfGA==
X-Received: by 2002:a17:906:18a1:b0:aa5:15ab:a5d4 with SMTP id a640c23a62f3a-aa5f7d50305mr954039466b.22.1733413800019;
        Thu, 05 Dec 2024 07:50:00 -0800 (PST)
Received: from [10.82.4.202] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e5c660sm109255166b.19.2024.12.05.07.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:49:59 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 05 Dec 2024 16:49:57 +0100
Subject: [PATCH] reftable/writer: ensure valid range for log's update_index
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-424-reftable-writer-add-check-for-limits-v1-1-b287b055204e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKXLUWcC/x2NywrCMBAAf6Xs2YXsGlH8FfGQx8Yu1lY2oQql/
 27wOIeZ2aCKqVS4DhuYrFp1mTvQYYA0hvkhqLkzsGNPxA49ezQpLcRJ8GPaxDDkjGmU9MSyGE7
 60lbRUaQSz+544gv03Ltb+v2vbvd9/wHr5c7PegAAAA==
X-Change-ID: 20241120-424-reftable-writer-add-check-for-limits-01b1fb703528
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5696; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=fFFLtOP564VpooDeWAyxhtG8Oo3gBf5SiiTZKRRmnhI=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnUcun0HVkkP1Yz8SQMdIF4Fup3umVBTfCTO+pI
 z+L1ZT5d86JAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1HLpwAKCRA+1Z8kjkaM
 f1MVDACGqjh6OpOovfYxVZJRSKBeRxdWFmJg/Z5HcSpf5IKH9uVr4tkHtde3K51SzqliL0aenTw
 RmpeSSnJQa3gPf3HXbHyLidXwbWuYwP+F7+ETRxz0ykt0eKElCtGerZPGIP/xcGJXrH7Ad6h2PA
 UqpN1H3BV3LtpxAILx4x9f30pCUlDlGmLztwikuiygvteM49ZkpP0aaRwep7ecY4XqPcBeSW7vb
 n9lvgvE+tgOBJ8GysVT+rv8vmdxySr3TyuXOpryqPc7PJTQirLKZhZsk6U6+kgxiTMXuEIfx9Wv
 Hvdy77l5FhQNoLaIbDx9MP+G7kw+U06K8xlxrzTQGbc+o9AfOXQ/utTPf4jb2I7Z6aotKtDlMC5
 Ch3GpCTfY3alDWUSCpl/Y1gd0BLNBs+zokRGQQxmarRh9c03W20klQasO65c2geO1wAWfFQuj3v
 Oh1YwX0obHuzBbEzM3/+8eS+kPnXtYe4ED3S6waNcOAjk+OJMAK0wl8KnE4QJGKRZCn8M=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Each reftable addition has an associated update_index. While writing
refs, the update_index is verified to be within the range of the
reftable writer, i.e. `writer.min_update_index < ref.update_index` and
`writer.max_update_index > ref.update_index`.

The corresponding check for reflogs in `reftable_writer_add_log` is
however missing. Add a similar check, but only check for the upper
limit. This is because reflogs are treated a bit differently than refs.
Each reflog entry in reftable has an associated update_index and we also
allow expiring entries in the middle, which is done by simply writing a
new reflog entry with the same update_index. This means, writing reflog
entries with update_index lesser than the writer's update_index is an
expected scenario.

Add a new unit test to check for the limits and fix some of the existing
tests, which were setting arbitrary values for the update_index by
ensuring they stay within the now checked limits.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/writer.c                   | 12 ++++++++++
 t/unit-tests/t-reftable-readwrite.c | 44 +++++++++++++++++++++++++++++++++++--
 t/unit-tests/t-reftable-stack.c     |  8 +++++--
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index fd136794d5a27b33b5017f36fbd6b095ab8dac5b..f87086777cd20a9890a63f10c5d6932310dd5610 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -412,6 +412,18 @@ int reftable_writer_add_log(struct reftable_writer *w,
 	if (log->value_type == REFTABLE_LOG_DELETION)
 		return reftable_writer_add_log_verbatim(w, log);
 
+	/*
+	 * Verify only the upper limit of the update_index. Each reflog entry
+	 * is tied to a specific update_index. Entries in the reflog can be
+	 * replaced by adding a new entry with the same update_index,
+	 * effectively canceling the old one.
+	 *
+	 * Consequently, reflog updates may include update_index values lower
+	 * than the writer's min_update_index.
+	 */
+	if (log->update_index > w->max_update_index)
+		return REFTABLE_API_ERROR;
+
 	if (!log->refname)
 		return REFTABLE_API_ERROR;
 
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index d279b86df0aeda11b3fb4d2c15803760ae394941..5ad1c72f6901abcfe7fdc6c3e69e26b58d0013a6 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -90,7 +90,7 @@ static void t_log_buffer_size(void)
 	int i;
 	struct reftable_log_record
 		log = { .refname = (char *) "refs/heads/master",
-			.update_index = 0xa,
+			.update_index = update_index,
 			.value_type = REFTABLE_LOG_UPDATE,
 			.value = { .update = {
 					   .name = (char *) "Han-Wen Nienhuys",
@@ -127,7 +127,7 @@ static void t_log_overflow(void)
 	int err;
 	struct reftable_log_record log = {
 		.refname = (char *) "refs/heads/master",
-		.update_index = 0xa,
+		.update_index = update_index,
 		.value_type = REFTABLE_LOG_UPDATE,
 		.value = {
 			.update = {
@@ -151,6 +151,45 @@ static void t_log_overflow(void)
 	reftable_buf_release(&buf);
 }
 
+static void t_log_write_limits(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
+	struct reftable_log_record log = {
+		.refname = (char *)"refs/head/master",
+		.update_index = 1,
+		.value_type = REFTABLE_LOG_UPDATE,
+		.value = {
+			.update = {
+				.old_hash = { 1 },
+				.new_hash = { 2 },
+				.name = (char *)"Han-Wen Nienhuys",
+				.email = (char *)"hanwen@google.com",
+				.tz_offset = 100,
+				.time = 0x5e430672,
+			},
+		},
+	};
+	int err;
+
+	reftable_writer_set_limits(w, 1, 2);
+
+	err = reftable_writer_add_log(w, &log);
+	check_int(err, ==, 0);
+
+	log.update_index = 2;
+	err = reftable_writer_add_log(w, &log);
+	check_int(err, ==, 0);
+
+	log.update_index = 3;
+	err = reftable_writer_add_log(w, &log);
+	check_int(err, ==, REFTABLE_API_ERROR);
+
+	reftable_writer_free(w);
+	reftable_buf_release(&buf);
+}
+
 static void t_log_write_read(void)
 {
 	struct reftable_write_options opts = {
@@ -917,6 +956,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 	TEST(t_corrupt_table_empty(), "read-write on an empty table");
 	TEST(t_log_buffer_size(), "buffer extension for log compression");
 	TEST(t_log_overflow(), "log overflow returns expected error");
+	TEST(t_log_write_limits(), "writer limits for writing log records");
 	TEST(t_log_write_read(), "read-write on log records");
 	TEST(t_log_zlib_corruption(), "reading corrupted log record returns expected error");
 	TEST(t_table_read_api(), "read on a table");
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 72f6747064f62106e87c9a90e5fe315139d46e60..52b81475c36aa94ff09f3bf77a7d23992957deb4 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -770,8 +770,12 @@ static void t_reftable_stack_tombstone(void)
 		}
 
 		logs[i].refname = xstrdup(buf);
-		/* update_index is part of the key. */
-		logs[i].update_index = 42;
+		/*
+		 * update_index is part of the key so should be constant.
+		 * The value itself should be less than the writer's upper
+		 * limit.
+		 */
+		logs[i].update_index = 1;
 		if (i % 2 == 0) {
 			logs[i].value_type = REFTABLE_LOG_UPDATE;
 			t_reftable_set_hash(logs[i].value.update.new_hash, i,

---



--- 

base-commit: cc01bad4a9f566cf4453c7edd6b433851b0835e2
change-id: 20241120-424-reftable-writer-add-check-for-limits-01b1fb703528

Thanks
- Karthik

