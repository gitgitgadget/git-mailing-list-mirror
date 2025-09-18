Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F30275108
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183118; cv=none; b=UcZoBsD1jd4OglgZiXLRSk1Wkhf95ym18eB14Vehep0a7qbw9yNfOvaeF/0ZFdHHshFkPWOsYoGCBq/MX1fP1wy7DczzBuWdMEE18QqLI1E8+I6y9OVHMmc2hTRnl+IuCapLQ7iJJih0cz2yKeRuv63xyorXbMjVYtFUXvU59QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183118; c=relaxed/simple;
	bh=fIqfV1asczNbq6tdVCaPb2wXmxOMEsCfBKk9p6C9Ogk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qy+811e0ed+MP0pyQWHQwHtabphKQfeL0unWvjOjCN/DpdfP3qkV01jTb5kCIOKXmjw7fK5XPFLnv4nZxBrH1fupZUto8NQnSNi9MxPZyRQDhicI3O1pCK2jyUhJffRWOe+5VLjDjKgBnvFuHgGOCjirG2u/BaZ22tGU5Ws4yQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eI31Ay4d; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI31Ay4d"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b00a9989633so140350066b.0
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758183114; x=1758787914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmnF2fYY+KkVuXVuTRukuGtrjeuF1AY1J8QPUNVR+UY=;
        b=eI31Ay4dg7Npy5EsMcmjaavhlpoH71Q4semRgLXFROYVVnXZyd9icJf6Aru/2KENZv
         OABb/clfL2arMMJpcxdedsVW3fcgbEAJFU2rYXCEX3cV8HibXKn3U0TYjR1Z72HNECUm
         rltJW+KtDX1i9dyP3dQIhiFXJydhhXAngiuWnVsPUDHdUoFgZUVjCL3bzSSpFEZcD1nt
         NaRQUWmI3SzAb2Y3P6kqOa4zfx3wVWhjGxCAUAF+JaiHQRpoTBaue9+qA83rCZuQUFi8
         6PNIpK0GQ1THmg0PAmKW+8JWbBnU+UqR1Y0kBTxtvBxb1g3LmhMlZE31Hnx4bwHtYzVx
         2mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758183114; x=1758787914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmnF2fYY+KkVuXVuTRukuGtrjeuF1AY1J8QPUNVR+UY=;
        b=cnOUDiJQ6o0uyrYmt0TXFp8r0E5ReafdIMWycdYWtSXGDS05eTPlSeY5vJ7PfaKUs4
         tuIriIAyDKqY5mE6jDx/a5u3MNMVMH1OwY3Uz+UC+ELy5wTG2grpB/4XOMyJo226X2ku
         bZmQxsOVnoDQQgVbBJpwlA/Q63YzowP3PpTOkjmrFvA14HcWpPQ4O0ju5S838RDswNOP
         9sCtH4suJOca5jKmpxZ+5GawYuuexHrqyG+QMl5BDmJujaqV9qLMk0RJEVSiXbB9TVBi
         3MxC14uMttrVnK8YRp6Fh07JCaRTyt3+l/IeCrIWFs+UQAzXBY1MwUFa1kqjgkrnwA7L
         gJRQ==
X-Gm-Message-State: AOJu0Yy1xpCNpef9aM/sYHuZgnoQ6Ut3A7wrU62/IKID7zbGdw3prZiU
	9QUqMt3ZTmWRKR5AmdjO3j83F/iZG5Q3rwaZ9F28CvlXDLr2owCi6Wmz
X-Gm-Gg: ASbGncvcNrnoPS5RsGARzDqLFC6T6R22huDnljsdc4I3RUeapoDqNUyBeL+CMWswQwN
	lxspppEQkaU/hHy/haZ6KVNuDHZA054175KH3PoXiCEmYtZ5c8A5gHOuU4GOBPxZB1PLpR1Wi6S
	nqIy85PdKlNXlHh8101lKX0kKZabzVx9baFNa7yYiLR1XK6ukNqGIqDfouHC4MdctjLX1y4k48O
	2xLTGaDqfwnHnkhc13XG3V7vujBF5+pgLlh5+e2V12PnLz7NkIt8i1VeghjdHDwzLtGhUKyvfo3
	3BFWea2IK2BmUMlf2kiKJslneVWj27Adc4pya56KQqb82jtSdDRZBAKu1R3rby+wN2Nxm12wmh/
	fZBEgJpgecDBMJm2cJiPick+PnrgEPnydNcYzZ3/Xycim8CrHr3onj2GJYw==
X-Google-Smtp-Source: AGHT+IGHgbvsJU9rES2t8kbitHDdYYuAk9BJgfdnGe1f7lByZd7gS56g/VcD4UCJ68N00pQba9mnOA==
X-Received: by 2002:a17:907:d1f:b0:afe:8de8:290d with SMTP id a640c23a62f3a-b1fa84503a1mr258566766b.6.1758183114479;
        Thu, 18 Sep 2025 01:11:54 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2802:b9c0:7d04:71e9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd2ce20f4sm139986566b.111.2025.09.18.01.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:11:54 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 18 Sep 2025 10:11:48 +0200
Subject: [PATCH v3 7/8] reftable: add code to facilitate consistency checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-228-reftable-introduce-consistency-checks-v3-7-271af03eb34d@gmail.com>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
In-Reply-To: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, shejialuo@gmail.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6540; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=fIqfV1asczNbq6tdVCaPb2wXmxOMEsCfBKk9p6C9Ogk=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjLvsPl3DV7h8u/yog+TA80KoSd5UUsajnDd
 6V6yOvlA6cqcIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoy77DAAoJED7VnySO
 Rox/NQ0L/RMRnzCGM7UAIsxDQHLJMw2GMH3848hdNv8ENppvbd9FSNrZCxFa5EW3TMWaoXmOsFr
 jRURkiC450zMy9nSKY1U2V1IczjgW3K8R8+r+a8DD23AEUWFzcZqKHoJQl469v23yijlGVKAHqM
 e46jAt2qYFtGslyAbGAqlNHCo3pQwhZjCxnXm6E2fSwIb7vjc+4qLHLHzDlFUySv99YIIduNl7g
 y6DY0P3APMprxsfv7OE+/ikXt4ZV5nafCrDB7c1ImF2eMy+PHvV1ltyUSfLwvK+SezasBXRJO26
 +2MYVulbxaoqRVY6hrWcOkXILNWILB9SnWW18iWjbJwRPIx2FDA6btBqVcJDeQaVDq46bRRVKeM
 s5pjIKe08LIN51cRyUweF5/mTbMedEJLR9c00/rKtOBbnxsT2EtP4ZGHivaaZJ9aQq9bxE8j4p1
 VTkedFh6jGf+KZn3LwtIcW+C1cz+0PC3Uz2aoEAEzlizktYdD85HRDRnoPrr5nwH4S4WPmXvsE6
 h8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `git refs verify` command is used to run consistency checks on the
reference backends. This command is also invoked when users run 'git
fsck'. While the files-backend has some fsck checks added, the reftable
backend lacks such checks. Let's add the required infrastructure and a
check to test for the files present in the reftable directory.

Since the reftable library is treated as an independent library we
should ensure that the library code works independently without
knowledge about Git's internals. To do this, add both 'reftable/fsck.c'
and 'reftable/reftable-fsck.h'. Which provide an entry point
'reftable_fsck_check' for running fsck checks over a provided reftable
stack. The callee provides the function with callbacks to handle issue
and information reporting.

The added check, goes over all files in the reftable directory and
validates that they have the expected file type and a valid name. It
raises specific errors for both.

While here, move 'reftable/error.o' in the Makefile to retain
lexicographic ordering.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Makefile                 |   3 +-
 meson.build              |   1 +
 reftable/fsck.c          | 112 +++++++++++++++++++++++++++++++++++++++++++++++
 reftable/reftable-fsck.h |  42 ++++++++++++++++++
 4 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4c95affadb..03fbaf2b21 100644
--- a/Makefile
+++ b/Makefile
@@ -2732,9 +2732,10 @@ XDIFF_OBJS += xdiff/xutils.o
 xdiff-objs: $(XDIFF_OBJS)
 
 REFTABLE_OBJS += reftable/basics.o
-REFTABLE_OBJS += reftable/error.o
 REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
+REFTABLE_OBJS += reftable/error.o
+REFTABLE_OBJS += reftable/fsck.o
 REFTABLE_OBJS += reftable/iter.o
 REFTABLE_OBJS += reftable/merged.o
 REFTABLE_OBJS += reftable/pq.o
diff --git a/meson.build b/meson.build
index b3dfcc0497..8914252910 100644
--- a/meson.build
+++ b/meson.build
@@ -452,6 +452,7 @@ libgit_sources = [
   'reftable/error.c',
   'reftable/block.c',
   'reftable/blocksource.c',
+  'reftable/fsck.c',
   'reftable/iter.c',
   'reftable/merged.c',
   'reftable/pq.c',
diff --git a/reftable/fsck.c b/reftable/fsck.c
new file mode 100644
index 0000000000..785e4b43e8
--- /dev/null
+++ b/reftable/fsck.c
@@ -0,0 +1,112 @@
+#include "basics.h"
+#include "reftable-fsck.h"
+#include "stack.h"
+
+static bool valid_table_name(const char *name, uint64_t *min_update_index,
+			     uint64_t *max_update_index)
+{
+	const char *ptr = name;
+	char *endptr;
+
+	/* strtoull doesn't set errno on success */
+	errno = 0;
+
+	*min_update_index = strtoull(ptr, &endptr, 16);
+	if (errno == EINVAL)
+		return false;
+	ptr = endptr;
+
+	if (strncmp(ptr, "-", 1))
+		return false;
+	ptr++;
+
+	*max_update_index = strtoull(ptr, &endptr, 16);
+	if (errno == EINVAL)
+		return false;
+	ptr = endptr;
+
+	if (*ptr != '-')
+		return false;
+	ptr++;
+
+	strtoul(ptr, &endptr, 16);
+	if (errno == EINVAL)
+		return false;
+	ptr = endptr;
+
+	if (strcmp(ptr, ".ref") && strcmp(ptr, ".log"))
+		return false;
+
+	return true;
+}
+
+static int stack_check_all_files_in_dir(struct reftable_stack *stack,
+					reftable_fsck_report_fn report_fn,
+					void *cb_data)
+{
+	DIR *dir = opendir(stack->reftable_dir);
+	struct reftable_fsck_info info;
+	struct dirent *d = NULL;
+	uint64_t min, max;
+	int err = 0;
+
+	if (!dir)
+		return 0;
+
+	while ((d = readdir(dir))) {
+		if (!strcmp(d->d_name, "tables.list"))
+			continue;
+
+		if ((d->d_name[0] == '.' &&
+		     (d->d_name[1] == '\0' ||
+		      (d->d_name[1] == '.' && d->d_name[2] == '\0'))))
+			continue;
+
+		if (d->d_type == DT_REG) {
+			if (!valid_table_name(d->d_name, &min, &max)) {
+				info.error = REFTABLE_FSCK_ERROR_TABLE_NAME;
+				info.msg = "file with invalid table name";
+				info.path = d->d_name;
+
+				err |= report_fn(&info, cb_data);
+			}
+		} else {
+			info.error = REFTABLE_FSCK_ERROR_INVALID_FILE_TYPE;
+			info.msg = "file with unexpected type";
+			info.path = d->d_name;
+
+			err |= report_fn(&info, cb_data);
+		}
+	}
+
+	closedir(dir);
+	return err;
+}
+
+static int stack_checks(struct reftable_stack *stack,
+			reftable_fsck_report_fn report_fn,
+			void *cb_data)
+{
+	struct reftable_buf msg = REFTABLE_BUF_INIT;
+	char **names = NULL;
+	int err = 0;
+
+	if (stack == NULL)
+		goto out;
+
+	err |= stack_check_all_files_in_dir(stack, report_fn, cb_data);
+
+out:
+	free_names(names);
+	reftable_buf_release(&msg);
+	return err;
+}
+
+int reftable_fsck_check(struct reftable_stack *stack,
+			reftable_fsck_report_fn report_fn,
+			reftable_fsck_verbose_fn verbose_fn,
+			void *cb_data)
+{
+	verbose_fn("Checking reftable: stack checks", cb_data);
+	return stack_checks(stack, report_fn, cb_data);
+}
diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
new file mode 100644
index 0000000000..5e13ac9f02
--- /dev/null
+++ b/reftable/reftable-fsck.h
@@ -0,0 +1,42 @@
+#ifndef REFTABLE_FSCK_H
+#define REFTABLE_FSCK_H
+
+#include "reftable-stack.h"
+
+enum reftable_fsck_error {
+	/* Non regular file in the reftable directory */
+	REFTABLE_FSCK_ERROR_INVALID_FILE_TYPE = 0,
+	/* Invalid table name */
+	REFTABLE_FSCK_ERROR_TABLE_NAME,
+	/* Used for bounds checking, must be last */
+	REFTABLE_FSCK_MAX_VALUE
+};
+
+/* Represents an individual error encountered during the FSCK checks. */
+struct reftable_fsck_info {
+	enum reftable_fsck_error error;
+	const char *msg;
+	const char *path;
+};
+
+typedef int reftable_fsck_report_fn(struct reftable_fsck_info *info,
+				    void *cb_data);
+typedef void reftable_fsck_verbose_fn(const char *msg, void *cb_data);
+
+/*
+ * Given a reftable stack, perform consistency checks on the stack.
+ *
+ * If an issue is encountered, the issue is reported to the callee via the
+ * provided 'report_fn'. If the issue is non-recoverable the flow will not
+ * continue. If it is recoverable, the flow will continue and further issues
+ * will be reported as identified.
+ *
+ * The 'verbose_fn' will be invoked to provide verbose information about
+ * the progress and state of the consistency checks.
+ */
+int reftable_fsck_check(struct reftable_stack *stack,
+			reftable_fsck_report_fn report_fn,
+			reftable_fsck_verbose_fn verbose_fn,
+			void *cb_data);
+
+#endif /* REFTABLE_FSCK_H */

-- 
2.51.0

