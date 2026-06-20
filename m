Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868727442
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781925472; cv=none; b=PXknqPv97ULtnPBtxM640Se3qP3t0JTmuuVUFPRrZc4EewfaBIBesBVzlf6Z5hIGh5KjKr2PePdPvCwM+MalSUFUnvesLXUOa8vZvB8EgSL2LbHm7OVKGH+L7WnM1Gz1pQOWUIs06l/wd0nDdkxuzZG/wkyqCxamSC9qJUjATzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781925472; c=relaxed/simple;
	bh=OBLck4q3ZAUJ2FDBah/7WxX0dWgvfV9IOTfW9oWtzFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLx5TlOZebqrYSDy7DlBuGQE0i9xC58Bm8Wwae6habN+IKTGomxJDPUtWHoSqKQY5md4uPBBGE+50dcdZeX59+lOfWFnstB/4HvrIHToe53iGNFLfScamkeKFXtKXFsP3rNOgGfFehcIhTCM/l8clAmAanExMRozhiLBSF6fEVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbbuboyF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbbuboyF"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf2247e38eso31053165ad.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 20:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925471; x=1782530271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njTmItTn69Qt6ck9V1f59QL1MUkiSbWkmSQgoGiPKSE=;
        b=FbbuboyFcVU4TEi5rryZy8milI7Yafb4s0028VeCHhccaeBFp1v2HNnhY1MUNbLY7b
         jcELkgg8IQYfgPv4NClnRr3VjgwA5u91VIWCoo9/d1VYu9eaz1qfOCEAtSpLmZWpin60
         wE8kzMjVxRoW9zxydjrkewTwn8Jw+Jxa5XRO55KJO9rhhsjXcPsDJ4JZv0h12bGxN7r3
         hyTN7jh69kruOrdQYaXZ6LPN69Ud538+EGE6BJbtHXvu8oOcdeBj92ZVQ3ahp8qsXHSF
         3rb6YDG7Oo0DpNbne8LhK/4zEhhiqL04/TKOzIxEg9lVMLCiIg5j2sLQ4xyVXn5rtEHz
         pR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925471; x=1782530271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=njTmItTn69Qt6ck9V1f59QL1MUkiSbWkmSQgoGiPKSE=;
        b=RU7mnH8l0+fGS1g0erEssSXTJ5EbMqK6dbhvoGkeOYoygV2rn2R+Fo31BwlOoWKFYu
         gFHWd8fmy7kYIgy2CGclNbAcLVjtrhs49P9ZvjZekEltKdu509V6xyscxvv9dsF0iTUC
         poI7TTpyhe+znvomRXe4LVcrX0wa2eGkQ2qvQCJBitTReJveGPiLibpVMsIxVa7ZmobM
         bPV6ZMB73xcKBEgLJT8pecUtBJuTlo4YCfXLTmT4ucTwRtcIQXJ956Yb984sMguIVjWe
         2NlMISqMTqCVKocMiYP6VM1pNbtOfrTbSxy9oaMMAi4u0dP8cnrOK8OGH3Hem9IRMFpm
         grSQ==
X-Gm-Message-State: AOJu0YyUgL9f5mgFQBr0uqmoz41zj24AE5fppA0kWkCk04Ozw+pD6XQ+
	DUajWuZ3tvfjA1pEmTxKMQhFhhJqRdJYtirkoB3eVsdDcWPruPMUyqncwu787w==
X-Gm-Gg: AfdE7clheSvcLudOSKGdb/wx2RJznvbWNihksQhzW4PJ26ietxVokpOvExbZLWmXnOb
	gDMN7rTk6Kychq3uhCu56WdSW8iICI0+sLz0RkO4FG253+lPbNBGH47w4Eet85eQh+eNHSMHsxi
	tP0baMQ7OtVHKfXdyqKUBsZfKPMcNuKjy6kKdYX22vLJ8h5kWka+m9HWqXiYsUhypGLCqmC1TJ9
	COaLs4elIAqMq94Fqgb1UTxd8KHXTt+d5iakOiYtR+mAb1fjj9gceVo7tr+gDLjSpfVaRSEZHw6
	Jnx/KzPKy/UF+5Qh67S/s6e9YsX+wsu8GSneoYhoQGwgmB6xo68S9iM93/vp0w6JhPA29muCrnM
	w4aboycmN/8OP0hx1HZTpKMnj+SKwQQsWqGEtbNAHl13qXYk1OcW429rjKwWdYzz2sh9CN88vMH
	2NmEbCIxyYZ+80nOBbfg67431tH5iL5FML9wkhvaci7UTMGS9frnuvfxaZeb5x/mGDO6D1YuCkP
	15aF/dhJGZrnFjgbsA=
X-Received: by 2002:a17:902:d488:b0:2c6:9758:9db2 with SMTP id d9443c01a7336-2c718caf4b0mr63719135ad.3.1781925470896;
        Fri, 19 Jun 2026 20:17:50 -0700 (PDT)
Received: from jayatheerth ([2409:40f0:f:5924:9ce6:f181:f81b:c57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af590sm9581675ad.17.2026.06.19.20.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:17:50 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch v6 1/4] path: introduce append_formatted_path() for shared path formatting
Date: Sat, 20 Jun 2026 08:46:41 +0530
Message-ID: <20260620031644.353772-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620031644.353772-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260620031644.353772-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The path-formatting logic in builtin/rev-parse.c is tightly coupled
to that command and writes directly to stdout, making it impossible
for other builtins to reuse.

Extract the core algorithm into append_formatted_path() in path.c
and expose a path_format enum in path.h so that any builtin can
format paths consistently without duplicating logic.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 path.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 path.h | 30 +++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/path.c b/path.c
index d7e17bf174..6d8e892ada 100644
--- a/path.c
+++ b/path.c
@@ -1579,6 +1579,75 @@ char *xdg_cache_home(const char *filename)
 	return NULL;
 }
 
+void append_formatted_path(struct strbuf *dest, const char *path,
+			   const char *prefix, enum path_format format)
+{
+	switch (format) {
+	case PATH_FORMAT_UNMODIFIED:
+		strbuf_addstr(dest, path);
+		break;
+
+	case PATH_FORMAT_RELATIVE: {
+		struct strbuf relative_buf = STRBUF_INIT;
+		struct strbuf real_path = STRBUF_INIT;
+		struct strbuf real_prefix = STRBUF_INIT;
+		char *cwd = NULL;
+
+		/*
+		 * We don't ever produce a relative path if prefix is NULL,
+		 * so set the prefix to the current directory so that we can
+		 * produce a relative path whenever possible.
+		 */
+		if (!prefix)
+			prefix = cwd = xgetcwd();
+
+		if (!is_absolute_path(path)) {
+			strbuf_realpath_forgiving(&real_path, path, 1);
+			path = real_path.buf;
+		}
+		if (!is_absolute_path(prefix)) {
+			strbuf_realpath_forgiving(&real_prefix, prefix, 1);
+			prefix = real_prefix.buf;
+		}
+
+		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
+
+		strbuf_release(&relative_buf);
+		strbuf_release(&real_path);
+		strbuf_release(&real_prefix);
+		free(cwd);
+		break;
+	}
+
+	case PATH_FORMAT_RELATIVE_IF_SHARED: {
+		struct strbuf relative_buf = STRBUF_INIT;
+
+		/*
+		 * If we're using RELATIVE_IF_SHARED mode, then we want an
+		 * absolute path unless the two share a common prefix, so don't
+		 * default the prefix to the current working directory. Doing so
+		 * would cause a relative path to always be produced if possible.
+		 */
+		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
+		strbuf_release(&relative_buf);
+		break;
+	}
+
+	case PATH_FORMAT_CANONICAL: {
+		struct strbuf canonical_buf = STRBUF_INIT;
+
+		strbuf_realpath_forgiving(&canonical_buf, path, 1);
+		strbuf_addbuf(dest, &canonical_buf);
+
+		strbuf_release(&canonical_buf);
+		break;
+	}
+
+	default:
+		BUG("unknown path_format value %d", format);
+	}
+}
+
 REPO_GIT_PATH_FUNC(squash_msg, "SQUASH_MSG")
 REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
 REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
diff --git a/path.h b/path.h
index 4c2958a903..4d982a2c8e 100644
--- a/path.h
+++ b/path.h
@@ -262,6 +262,36 @@ enum scld_error safe_create_leading_directories_no_share(char *path);
 int safe_create_file_with_leading_directories(struct repository *repo,
 					      const char *path);
 
+/**
+ * The formatting strategy to apply when writing a path into a buffer.
+ */
+enum path_format {
+	/* Output the path exactly as-is without any modifications. */
+	PATH_FORMAT_UNMODIFIED,
+
+	/* Output a path relative to the provided directory prefix. */
+	PATH_FORMAT_RELATIVE,
+
+	/* Output a relative path only if the path shares a root with the prefix. */
+	PATH_FORMAT_RELATIVE_IF_SHARED,
+
+	/* Output a fully resolved, absolute canonical path. */
+	PATH_FORMAT_CANONICAL
+};
+
+/**
+ * Format a path according to the specified formatting strategy and append
+ * the result to the given strbuf.
+ *
+ * `dest`   : The string buffer to append the formatted path to.
+ * `path`   : The path string that needs to be formatted.
+ * `prefix` : The directory prefix to calculate relative offsets against.
+ * Pass NULL to default to the current working directory where applicable.
+ * `format` : The formatting behavior rule to execute.
+ */
+void append_formatted_path(struct strbuf *dest, const char *path,
+			   const char *prefix, enum path_format format);
+
 # ifdef USE_THE_REPOSITORY_VARIABLE
 #  include "strbuf.h"
 #  include "repository.h"
-- 
2.54.0

