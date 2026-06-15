Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C653A1DB
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499138; cv=none; b=Y5y3opyZeZTz4l6JpYFMYUpR5qNEwdowaLrRC8c25j4w0/gWOL4xfFd1DgKrspaO83+Ew/kf+tZoDdL3d0z3QTTNijW/ebgCsDXor+PZRSmo2NlYGiBUDMvktYuJ88K6HOOlk/P8tIX/a9UXljVTzkqE2FZf2sRuYzjEsPofr+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499138; c=relaxed/simple;
	bh=mbEEUiZymbg4G5XJHWjdbpElpDwrzIu1aN5RCut61sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uc6wqaOlaftZcangaHhwVl5jUWDDM7u66m2TVRMXMfTjkzNf5zr75SOxyVfkaGFRFQ6rRelLBm51TEyg/VAV4sEdaB5WZNPqrI2ZWWvgj7FD+FF+uUMdB//KiUqqm39clh7lZmga8DFu900WeRvxKC5RtZzW2kpJSmvdq4tgQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXepxw/E; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXepxw/E"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c3543590so19378685ad.2
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 21:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781499137; x=1782103937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhfHHHPF0SkqPQSI0xfLwOJuPPm1a1LI6Y08SVx9jXI=;
        b=kXepxw/ECJCGK8Jh1WWdIAaIQjLbLCfKr/cNK2XZ/zfQw/MyNU8K2RWck6H28b7Wa1
         S7eGC3eqkk9G4AcjFZBDYwc+P/8xdAJRz2HrXvfDx8GGFb2zYt2rSzn7fUX46SVB+U+i
         nD50zb8H28DmLStkLg+D9ZMO8G4OldMbCDIGHm0Vlu5aJ7OTM9PhMg7OxxGo15iu7SOd
         yJq4k0I/rpdE3r9hmTMybKsqbKNB6qcXTOtF5XfdxjGUmq78YtNcDrqmERRU69b+kmdV
         KPi8mc0Zdesv4vwP4pCXERjIXwYqSQlp92F8iDFboOK1z1KGBLC+F7Gqfhoh4ar8qBZa
         at2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781499137; x=1782103937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GhfHHHPF0SkqPQSI0xfLwOJuPPm1a1LI6Y08SVx9jXI=;
        b=PVFh0BfbPrZtMzky43Ei0dYwUAyWFRUxJ/WZlQljzcAzw9wdF2Hs47ulwz/5xuFs+Z
         NGw/sB5yAjrX9dbDcQ6YIu9V/y4qopztvNeWOTO6C5XJZpdLxTTrwZFScXjwsTOA0kJW
         MQeN6jlOCVVLVwrLB6X0q6xh1Sq0PK6rSSQeOKSSQqX2xYI6qcXy+Yla0c4ECW1l9YiE
         uewtttrUYjFQiS0PF0rzJaOG/EeoSgc/8CWdPNHSgdVzPjD/AExHaLbr9T4bN8J/zXBw
         hl77Tp64F8bHF1nwcO9s/63AqqsCJowuCptL9yqqA96RJG671QPdzC/rn//E/skhvzNH
         S8lg==
X-Gm-Message-State: AOJu0YzRoWRF2cTX1//4jmYQLTTZqHLPmd92SSNnXBHU49bHmDcnwlW0
	AgfncQdePAGDjB2FPXzBWBIXSdJ9jvktPjETuLen0pIwK6F+xpqAkBqCVVGkHA==
X-Gm-Gg: Acq92OHdmWzaybr8kKU9Bvoce/g6dhITr00WpeLWHaeYbiMT13lXnPMGu8a2nYCkU3w
	3AhyowcADgmB+HkxtcN/bxG58Qyi6vUNOScSZjMW5xRNMP6b5xLD2Vj60wHeL1EpmlJY2J30wVq
	E/aT0K2qXZhuPxWyTA1QR8aVOvqeA6KGX9wOm9hRy7vIUqdPf5CnE6YyXlv9IdsWYMctgadO93Y
	bmmZXLQ6yQkdShnvnWOfpw9By35PS5u7MJ3Q3WhIMex9U/gKEmTftEAuHXb1LxNLiD3tyg8ePJo
	HFX4DGvMBhU3UalDUM2imoVbSh4QqjntuA/6kNtDdq6PTyKKqhRKl5wuBWDuANIQkxnvPIzbMfh
	aI5fGcBKGSWhT+XcBSDob8fs2Rykgn38/KJqNbEjQVQ7ISp5FeEvlUmUqCwPwQ7F/0+Uh4JGLyU
	6rqzRn+QJ8EUuvszIATAo7U3fy5JcJeRRYxnc1orkc33yvXFSKUjMWandUDP02Hd39xKPtNHanX
	pSimuesHdSoTFpqaTqIedBW7AK9rfJxCl0LbdliPy3Q
X-Received: by 2002:a17:903:2310:b0:2bc:ac76:c1cf with SMTP id d9443c01a7336-2c4136e81d7mr129347835ad.24.1781499136866;
        Sun, 14 Jun 2026 21:52:16 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a4c1fsm85528075ad.53.2026.06.14.21.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 21:52:16 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: a3205153416@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kristofferhaugsbakk@fastmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch v4 1/4] path: introduce append_formatted_path() for shared path formatting
Date: Mon, 15 Jun 2026 10:21:09 +0530
Message-ID: <20260615045112.50686-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615045112.50686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260615045112.50686-1-jayatheerthkulkarni2005@gmail.com>
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
 path.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 path.h | 36 ++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/path.c b/path.c
index d7e17bf174..5e83e3e4f6 100644
--- a/path.c
+++ b/path.c
@@ -1579,6 +1579,76 @@ char *xdg_cache_home(const char *filename)
 	return NULL;
 }
 
+void append_formatted_path(struct strbuf *dest, const char *path,
+			   const char *prefix, enum path_format format)
+{
+	switch (format) {
+	case PATH_FORMAT_DEFAULT:
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
index 0434ba5e07..6aca53b100 100644
--- a/path.h
+++ b/path.h
@@ -262,6 +262,42 @@ enum scld_error safe_create_leading_directories_no_share(char *path);
 int safe_create_file_with_leading_directories(struct repository *repo,
 					      const char *path);
 
+/**
+ * The formatting strategy to apply when writing a path into a buffer.
+ */
+enum path_format {
+	/*
+	 * Represents the default formatting behavior. Treated as
+	 * PATH_FORMAT_UNMODIFIED by append_formatted_path().
+	 */
+	PATH_FORMAT_DEFAULT,
+
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

