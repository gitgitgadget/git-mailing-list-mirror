Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46931FE47B
	for <git@vger.kernel.org>; Fri, 22 May 2026 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779415894; cv=none; b=Om2lz+TXpIABQeOL5LqglKgwO7hgfIjkp8hxqCVUrMh1qSKfn8DQW50qBS3mAZrsywEgdMIFstJhbMTgCM+VLI57U9Tvj6f/KJAgJIv/MSK76sVl9Aj3Fw/GfloKtvPUWiFMTa8CnF8CAGwjPI3aHNqDP/piclkguCrbR8DOODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779415894; c=relaxed/simple;
	bh=d4w+PJrC7qeM8nfRRYHP+l64TXFxo8/IpsHbgY1XkNU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fcySiuhTn/W3dUG2GjJ5V7deKA9aIyySUm6LsAJito/p3SHtzIvqNVFVtZoWyRP855BgnAkD+mj97HPhU7s8QvTLWM8ubQYa+XbLsC52kRD47C3LFwZFe31HYf5dMOfNCI7LW26H8V+jZfkyLdOfuT+5+fsgsySaE9KwYi97Ufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUR1KLPP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUR1KLPP"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50fb8e9a4edso81202081cf.1
        for <git@vger.kernel.org>; Thu, 21 May 2026 19:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779415892; x=1780020692; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfowRcYmO4JhjKmV5zmmviLxbeffX8EcVX5s6qrCqsQ=;
        b=gUR1KLPPEFqXNek3olBcJhSpWKJ9eieXC519leoMW83xtzRbO+e4pu+uUnWVQvxfg6
         iWxGWJqnTFM3FZZMsQHx6a8BzDuBUd7YsYz6RGm7egh3to/e2V6o8X5J9OZHa19smZ4c
         pmKCiZDAaM9MS0o1iilG9H9JK0HJ/hDKIilt/O46XABR6Boh74FN2mM3t0OGwniFMdyp
         bxic801crDqaaMs4HM4Xpg12/FiScbJJ5g3jkAjTKiLYVLOWEK9LyRkVK3un5ZAdxEzJ
         RA9rAAzjXDP03y/e1ggZoWFPURleHB68AW50jrtE9OjtCYl6iJ6AUGOiP6YPBOQlodBz
         xySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779415892; x=1780020692;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VfowRcYmO4JhjKmV5zmmviLxbeffX8EcVX5s6qrCqsQ=;
        b=Kr28JFAuR7fQ1sqcIcMtnLDxVhe8yt/oaXbYe9gh3sKZR+nmEDIV3zuMYqmdPKCvlh
         S0kSfs5tEC5gqPwQC5q6MZUTXQTDqtU/MjF2cwb7IumccEnRSyeBLc7s+0rVp3Z72/oj
         PrZNUw32JYLT7fHzIKI/8tFqt1loRJmNmmQXEfzYCGTOSwSzttFYStN/cJ7jg9soqdl8
         kpOFp7wHoQ6bGY5r3rNoM8Rwh1nCM0G9/yxnZMHN+ETKLVnHY+crKoo5+nMpAeya4xpw
         TKeW1XWYTCgMHw24suq+ZyEXdMP6O03EpNwfXbSZFaFSBgs38r6ugwY7Osva5S6xJwHC
         9QYw==
X-Gm-Message-State: AOJu0Yw2jnZ7D4CqHuUWjyDYUNIBziV8YlQ3SQeA4xLkr0mvCd1KKiSr
	ClM6pLAy8Igd4X+g3w+flxq2qpsd++5sC+ERFif01KCUvJekd3eSxxW9swSxVA==
X-Gm-Gg: Acq92OENcSP7hy7gC2yZYgMasUgGaKLQ8QIogl5TU1eLJvz8LKtXe7PPcncb3Swmwj4
	o6d5o6Ty7dSeqpaTgXs6sjppmucahZ+r+BI2kjti1kYddZcYLKoRbFPlQAnebp5sHBsFnS0WwdW
	M8YrkXd4TW/SuYbk8MKP1mINgo5yM7dFyLfuy5Zj/DDcgMralErU5atsTVpCVFWaoWYKuvlLY+X
	+sKF5BiZdRlDn82YAqhZLBEvlFy9kh0ww7X+rGcXwWmp1usAsOyEDxACIPlKsAHj8/Uff3IQNZE
	fO3Pia5aoe6kJbNi6WtMdgSdxIBfxpDNKAJFEQNjC0wmMfOUbRkCA0Fgq8PJbmyPKxtuYk8fnyM
	8LUbzx/UZZ4qrR2yKMajXJMJMPZ4lPKqdcse0lCfssUuJqxWgByNZCB8UxUTM12mzzHURWYkLJg
	Wh63PuY73KcyNPiI9E+aFPQPR+
X-Received: by 2002:a05:622a:15c9:b0:516:d95f:bf33 with SMTP id d75a77b69052e-516d95fc2c8mr991581cf.50.1779415891732;
        Thu, 21 May 2026 19:11:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.81])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b25cdasm1738481cf.12.2026.05.21.19.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 19:11:30 -0700 (PDT)
Message-Id: <8c7359b8a1bb59087947993cb6b09fe3496d1766.1779415884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 02:11:24 +0000
Subject: [PATCH 5/5] diff-process-normalize: add built-in whitespace
 normalizer
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Add git diff-process-normalize, a built-in diff process that
detects whitespace-only changes.  It compares files line by line
using xdiff_compare_lines() with XDF_IGNORE_WHITESPACE (same
logic as "git diff -w").  If all lines match, it returns zero
hunks; otherwise it returns an error so git falls back to the
builtin diff algorithm.

    [diff "cdiff"]
        process = git diff-process-normalize

Update documentation to describe zero-hunk behavior for diff
and blame, and document the built-in normalize tool.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/config/diff.adoc   |   2 +
 Documentation/gitattributes.adoc |  15 ++++
 Makefile                         |   1 +
 builtin.h                        |   1 +
 builtin/diff-process-normalize.c | 143 +++++++++++++++++++++++++++++++
 git.c                            |   1 +
 t/t4080-diff-process.sh          |  60 +++++++++++++
 7 files changed, 223 insertions(+)
 create mode 100644 builtin/diff-process-normalize.c

diff --git a/Documentation/config/diff.adoc b/Documentation/config/diff.adoc
index 4ab5f60df6..475736c6ed 100644
--- a/Documentation/config/diff.adoc
+++ b/Documentation/config/diff.adoc
@@ -224,6 +224,8 @@ endif::git-diff[]
 	hunks that are fed into Git's diff and blame pipelines.
 	If the tool returns zero hunks, the file is treated as
 	unchanged for both diff output and blame attribution.
+	Git provides `git diff-process-normalize` as a built-in
+	tool that detects whitespace-only changes.
 	See linkgit:gitattributes[5] for details.
 
 `diff.indentHeuristic`::
diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index 7d66fa3aa1..3f1d7affd8 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -861,6 +861,21 @@ the file as having no changes and produces no diff output.
 where it reports zero hunks, attributing lines to earlier commits
 instead.
 
+Git ships with a built-in diff process, `git diff-process-normalize`,
+that detects whitespace-only changes.  Files whose only differences
+are whitespace produce zero hunks; files with non-whitespace changes
+fall back to the builtin diff algorithm.  To use it:
+
+----------------------------------------------------------------
+[diff "cdiff"]
+  process = git diff-process-normalize
+----------------------------------------------------------------
+
+This is useful after running a code formatter: `git diff` shows
+no output for files that only had whitespace changes,
+`git blame` skips whitespace-only commits automatically without
+requiring a `.git-blame-ignore-revs` file.
+
 Tools should ignore unknown keys in the per-file request to
 remain forward-compatible.
 
diff --git a/Makefile b/Makefile
index 22900368dd..01acfaf7b8 100644
--- a/Makefile
+++ b/Makefile
@@ -1409,6 +1409,7 @@ BUILTIN_OBJS += builtin/diagnose.o
 BUILTIN_OBJS += builtin/diff-files.o
 BUILTIN_OBJS += builtin/diff-index.o
 BUILTIN_OBJS += builtin/diff-pairs.o
+BUILTIN_OBJS += builtin/diff-process-normalize.o
 BUILTIN_OBJS += builtin/diff-tree.o
 BUILTIN_OBJS += builtin/diff.o
 BUILTIN_OBJS += builtin/difftool.o
diff --git a/builtin.h b/builtin.h
index 235c51f30e..c713a0417f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -178,6 +178,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix, struct repos
 int cmd_diff_index(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff_pairs(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_diff_process_normalize(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_difftool(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_env__helper(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/diff-process-normalize.c b/builtin/diff-process-normalize.c
new file mode 100644
index 0000000000..1580f6b7d9
--- /dev/null
+++ b/builtin/diff-process-normalize.c
@@ -0,0 +1,143 @@
+/*
+ * Built-in diff process that returns zero hunks for files whose
+ * only differences are whitespace, and status=error otherwise.
+ * See diff-process.c for the protocol and gitattributes(5) for usage.
+ *
+ * Uses xdiff_compare_lines() with XDF_IGNORE_WHITESPACE to compare
+ * lines, giving the same whitespace handling as "git diff -w".
+ */
+
+#include "builtin.h"
+#include "pkt-line.h"
+#include "strbuf.h"
+#include "xdiff-interface.h"
+
+/*
+ * Read a single pkt-line.  Returns 1 for data, 0 for flush, -1 for EOF.
+ */
+static int read_pkt(int fd, struct strbuf *line)
+{
+	int len;
+	char *data;
+
+	if (packet_read_line_gently(fd, &len, &data) < 0)
+		return -1;
+	if (!data || !len)
+		return 0; /* flush */
+	strbuf_reset(line);
+	strbuf_add(line, data, len);
+	strbuf_rtrim(line);
+	return 1;
+}
+
+/*
+ * Read packetized content until a flush packet.
+ */
+static int read_content(int fd, struct strbuf *out)
+{
+	strbuf_reset(out);
+	if (read_packetized_to_strbuf(fd, out, PACKET_READ_GENTLE_ON_EOF) < 0)
+		return -1;
+	return 0;
+}
+
+/*
+ * Compare two buffers line by line using xdiff_compare_lines() with
+ * XDF_IGNORE_WHITESPACE (same logic as "git diff -w").
+ * Returns 1 if all lines match, 0 otherwise.
+ */
+static int whitespace_equivalent(const char *a, long size_a,
+				 const char *b, long size_b)
+{
+	const char *ea = a + size_a;
+	const char *eb = b + size_b;
+
+	while (a < ea && b < eb) {
+		const char *eol_a = memchr(a, '\n', ea - a);
+		const char *eol_b = memchr(b, '\n', eb - b);
+		long len_a = (eol_a ? eol_a : ea) - a;
+		long len_b = (eol_b ? eol_b : eb) - b;
+
+		if (!xdiff_compare_lines(a, len_a, b, len_b,
+					 XDF_IGNORE_WHITESPACE))
+			return 0;
+
+		a += len_a + (eol_a ? 1 : 0);
+		b += len_b + (eol_b ? 1 : 0);
+	}
+
+	/* Both sides must be exhausted */
+	return a >= ea && b >= eb;
+}
+
+int cmd_diff_process_normalize(int argc UNUSED, const char **argv UNUSED,
+			       const char *prefix UNUSED,
+			       struct repository *repo UNUSED)
+{
+	struct strbuf line = STRBUF_INIT;
+	struct strbuf old_content = STRBUF_INIT;
+	struct strbuf new_content = STRBUF_INIT;
+	int ret;
+
+	/* Handshake: read client greeting */
+	ret = read_pkt(0, &line);
+	if (ret <= 0 || strcmp(line.buf, "git-diff-client"))
+		return 1;
+	ret = read_pkt(0, &line);
+	if (ret <= 0 || strcmp(line.buf, "version=1"))
+		return 1;
+	read_pkt(0, &line); /* flush */
+
+	/* Send server greeting */
+	packet_write_fmt(1, "git-diff-server\n");
+	packet_write_fmt(1, "version=1\n");
+	packet_flush(1);
+
+	/* Read client capabilities until flush */
+	while ((ret = read_pkt(0, &line)) > 0)
+		; /* consume */
+
+	/* Send our capabilities */
+	packet_write_fmt(1, "capability=hunks\n");
+	packet_flush(1);
+
+	/* Main loop: process file pairs */
+	for (;;) {
+		int have_command = 0;
+
+		/* Read request headers until flush */
+		while ((ret = read_pkt(0, &line)) > 0) {
+			if (starts_with(line.buf, "command="))
+				have_command = 1;
+		}
+		if (ret < 0)
+			break; /* EOF: client closed connection */
+		if (!have_command)
+			break;
+
+		/* Read old file content */
+		if (read_content(0, &old_content) < 0)
+			break;
+		/* Read new file content */
+		if (read_content(0, &new_content) < 0)
+			break;
+
+		if (whitespace_equivalent(old_content.buf, old_content.len,
+					  new_content.buf, new_content.len)) {
+			/* Whitespace-only differences */
+			packet_flush(1); /* zero hunks */
+			packet_write_fmt(1, "status=success\n");
+			packet_flush(1);
+		} else {
+			/* Non-whitespace differences: fall back */
+			packet_flush(1);
+			packet_write_fmt(1, "status=error\n");
+			packet_flush(1);
+		}
+	}
+
+	strbuf_release(&line);
+	strbuf_release(&old_content);
+	strbuf_release(&new_content);
+	return 0;
+}
diff --git a/git.c b/git.c
index 5a40eab8a2..6239240b02 100644
--- a/git.c
+++ b/git.c
@@ -568,6 +568,7 @@ static struct cmd_struct commands[] = {
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
 	{ "diff-pairs", cmd_diff_pairs, RUN_SETUP | NO_PARSEOPT },
+	{ "diff-process-normalize", cmd_diff_process_normalize, NO_PARSEOPT },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
index 5ed644b786..a6fa1df456 100755
--- a/t/t4080-diff-process.sh
+++ b/t/t4080-diff-process.sh
@@ -366,5 +366,65 @@ test_expect_success PYTHON 'blame skips commits with zero hunks from diff proces
 	! grep "$BLAME_COMMIT" with
 '
 
+NORMALIZE="git diff-process-normalize"
+
+test_expect_success 'diff-process-normalize setup' '
+	echo "*.c diff=cdiff" >.gitattributes &&
+	git add .gitattributes &&
+	test_commit normalize-base
+'
+
+test_expect_success 'diff-process-normalize suppresses whitespace-only changes' '
+	cat >ws.c <<-\EOF &&
+	int main(void)
+	{
+	    return 0;
+	}
+	EOF
+	git add ws.c &&
+	git commit -m "add ws.c" &&
+
+	cat >ws.c <<-\EOF &&
+	int main(void)
+	{
+	        return 0;
+	}
+	EOF
+
+	git -c diff.cdiff.process="$NORMALIZE" \
+		diff ws.c >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'diff-process-normalize falls back on non-whitespace changes' '
+	cat >ws.c <<-\EOF &&
+	int main(void)
+	{
+	    return 0;
+	}
+
+	int added_function(void)
+	{
+	    return 99;
+	}
+	EOF
+
+	git -c diff.cdiff.process="$NORMALIZE" \
+		diff ws.c >actual &&
+	grep "added_function" actual
+'
+
+test_expect_success 'diff-process-normalize falls back on mixed whitespace and real changes' '
+	cat >ws.c <<-\EOF &&
+	int main(void)
+	{
+	        return 42;
+	}
+	EOF
+
+	git -c diff.cdiff.process="$NORMALIZE" \
+		diff ws.c >actual &&
+	grep "return 42" actual
+'
 
 test_done
-- 
gitgitgadget
