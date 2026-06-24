Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B67B309F09
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272408; cv=none; b=WtcND+yqpvMjk5iOtiunFBFIMAfb09enU4Lsj0Lh7nGUspLKFRc2HhLafkwWEUzz5HIkVYC2gf/EoxRxMYeRknymoz+ExVzNpKf9yjJzg1Zb1HB8vheJChGJHU8kbj+HMxl+PFvAe9e2e/HledXM8+1XqjI/PH/KoiWod1UgjAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272408; c=relaxed/simple;
	bh=BjnGfR/NzwlqbP8of6Eso1294E//be1jUh0JPn9yrBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnDh4nzdDZJeEC2SXCK1/rbHfNHuYv00LwlMn+E4ZciJNElesLwaM/ZiEdLBIbu4Lnz1mMwt+V5OyINKmQ7p9rBjZGCPMXC/aKRzyj06JkECgOtodSUNvnWakgoN0mHjJfjZkLVBLuWd/W4vw4wm1i6grSAcdE9yehIvd7WvsrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avh4KaXz; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avh4KaXz"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-137335bc3caso921991c88.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 20:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782272406; x=1782877206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2NV6NWe13eWF9JUantvFgPM/b2bU9RhGlCeojYShvM=;
        b=avh4KaXz2rF3rdd1BexjrnSYofo3gVpys3sPMUfdzr3X1xW6u7CbNVftSj/41XQxqo
         NGeb/eUdzKO4VWQ1OdGnhG3ZMqApkctZbnkp6vyJbnEq8xEwM/lG1jcD4OWFV7OeXjvm
         PzQOH2xNw3aFc5VYOeXSVOPehuTCGMZe6Drttzm3+uZIEBAicKnap29RjviHLZHWb9k7
         RjoS35f5FCPRop1eIQicPfzamzms6BZtIL8SfLc07xN23JASvoBGbHYGYvCmaG5HEH69
         o7k+2rbGoh6df5Djr1jTtrV5vHKFGbp+kNvftvYAAfVndKu2KXwG9zzOMcqYQPeWXM3f
         ImYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782272406; x=1782877206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F2NV6NWe13eWF9JUantvFgPM/b2bU9RhGlCeojYShvM=;
        b=kfTBa6NhDoWNnxeWJSFZSg/D7164VVR0Ie1TJce3kcnm46QbiOIJ5UojVhiPSFEoIm
         SnZyhZ5BKE2i7dK80+cP6uyiQATz4SeZgaQM8NhMOqIHuSR5+ZYM77pjnBpH2hp11N+W
         gGxrWN48qxqdWhPlAQVWTSeI9LAhyBIHqn4UTiB3L2hDA0GnjEXnyBwxx0q6ljbTSBlP
         fAiCoOUss04wAI5gl8HRJLMG7uTFfkJmToaiM8gEV4rfs+Tkwv6IRvw89SvEPTLU/n/l
         JmV6BgLq0+Hlmmrw5b8lvCLm0o+LHpMk6cX0jqvxjI0KQVJiTFCgouFLiB/FC3ndkrsn
         T0ng==
X-Forwarded-Encrypted: i=1; AHgh+RrTF/lhG+nVxO6tM2un1biQvorp2kah/QQuAotZDXZD6uAz3w79PjFH+5vYAGuxhqcimFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx93gzKvE061R0JY9rXjL11KOQL8m51P0DWYfJDY69cT3Aa6kQ6
	MII91oz+d8PkujzJ8STiF8DikqhKYF2hz3TTGUHDq0+y99UrpTgXcABT
X-Gm-Gg: AfdE7cncZFcFi9CnEI5Oj86iX6230k0HI7I0ZLDJH/+DCA9DRd3T6h873bt9/R4mFxd
	UibOas87E//nY8QKfOH5sHwfd1b2oorkrFmN5TJks9Rbcwp6/KlGBKXI58cigZ8EqBV+XP67C4T
	8t3Rylu3p9VKruBLseYp9M7nGo9LoeXOXlsuzHIfkgUOup/So4olwUsKGARUZ/t9t/ffbpXP/OC
	1wl/VEDFjXLPuYORdiYKRJrKnO52aPgUVDxWI7WiJ57XL4x5HdRQjQI4TJqxglfBHGn9zN60vCB
	Bg8cjtWGUrN52FCSZGcz+ZYpE4Zbh5VaeI3D1XTUrScNXTf1hTaPrnhju6K97QgubKaHC+2GJas
	S2CjqjmI21iHsX4YH91ltidvfrfIqHz9HFGKrRxUXlfKQzPH51wppzmqMQ8S50RuT1DxpNCQg9z
	XgegyTKZZyJS1ERrCxL+CYMAQpJilKXcF//E4MWReSCad2bmtlFgQ1vs/RxTwFDsF9CHgIPfDxU
	W4t+Yeej4WiWJsBI9GkefIw5EiFl1OcMA==
X-Received: by 2002:a05:7300:3244:b0:307:d4e7:b177 with SMTP id 5a478bee46e88-30c692d8aa5mr2004678eec.16.1782272406082;
        Tue, 23 Jun 2026 20:40:06 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm23924891eec.20.2026.06.23.20.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 20:40:05 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: a3205153416@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: [GSoC Patch v8 1/3] path: extract format_path() and use in rev-parse
Date: Wed, 24 Jun 2026 09:07:46 +0530
Message-ID: <20260624033748.108281-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.0-rc1
In-Reply-To: <20260624033748.108281-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260624033748.108281-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Path formatting logic in builtin/rev-parse.c writes directly to
stdout. Other builtins cannot reuse it.

Extract this logic into format_path() in path.c and expose
a path_format enum in path.h.

Convert rev-parse to use the new helper in the same step to validate
the API against existing tests and avoid introducing dead code.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/rev-parse.c | 79 +++++++++++++++++++++------------------------
 path.c              | 69 +++++++++++++++++++++++++++++++++++++++
 path.h              | 30 +++++++++++++++++
 3 files changed, 135 insertions(+), 43 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index bb882678fe..7d6ac92038 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -653,53 +653,46 @@ enum default_type {
 	DEFAULT_UNMODIFIED,
 };
 
-static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
+static void print_path(const char *path, const char *prefix,
+		       enum format_type format, enum default_type def)
 {
-	char *cwd = NULL;
-	/*
-	 * We don't ever produce a relative path if prefix is NULL, so set the
-	 * prefix to the current directory so that we can produce a relative
-	 * path whenever possible.  If we're using RELATIVE_IF_SHARED mode, then
-	 * we want an absolute path unless the two share a common prefix, so don't
-	 * set it in that case, since doing so causes a relative path to always
-	 * be produced if possible.
-	 */
-	if (!prefix && (format != FORMAT_DEFAULT || def != DEFAULT_RELATIVE_IF_SHARED))
-		prefix = cwd = xgetcwd();
-	if (format == FORMAT_DEFAULT && def == DEFAULT_UNMODIFIED) {
-		puts(path);
-	} else if (format == FORMAT_RELATIVE ||
-		  (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE)) {
-		/*
-		 * In order for relative_path to work as expected, we need to
-		 * make sure that both paths are absolute paths.  If we don't,
-		 * we can end up with an unexpected absolute path that the user
-		 * didn't want.
-		 */
-		struct strbuf buf = STRBUF_INIT, realbuf = STRBUF_INIT, prefixbuf = STRBUF_INIT;
-		if (!is_absolute_path(path)) {
-			strbuf_realpath_forgiving(&realbuf, path,  1);
-			path = realbuf.buf;
-		}
-		if (!is_absolute_path(prefix)) {
-			strbuf_realpath_forgiving(&prefixbuf, prefix, 1);
-			prefix = prefixbuf.buf;
+	struct strbuf sb = STRBUF_INIT;
+	enum path_format fmt;
+
+	if (format == FORMAT_DEFAULT) {
+		switch (def) {
+		case DEFAULT_RELATIVE:
+			fmt = PATH_FORMAT_RELATIVE;
+			break;
+		case DEFAULT_RELATIVE_IF_SHARED:
+			fmt = PATH_FORMAT_RELATIVE_IF_SHARED;
+			break;
+		case DEFAULT_CANONICAL:
+			fmt = PATH_FORMAT_CANONICAL;
+			break;
+		case DEFAULT_UNMODIFIED:
+		default:
+			fmt = PATH_FORMAT_UNMODIFIED;
+			break;
 		}
-		puts(relative_path(path, prefix, &buf));
-		strbuf_release(&buf);
-		strbuf_release(&realbuf);
-		strbuf_release(&prefixbuf);
-	} else if (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE_IF_SHARED) {
-		struct strbuf buf = STRBUF_INIT;
-		puts(relative_path(path, prefix, &buf));
-		strbuf_release(&buf);
 	} else {
-		struct strbuf buf = STRBUF_INIT;
-		strbuf_realpath_forgiving(&buf, path, 1);
-		puts(buf.buf);
-		strbuf_release(&buf);
+		switch (format) {
+		case FORMAT_RELATIVE:
+			fmt = PATH_FORMAT_RELATIVE;
+			break;
+		case FORMAT_CANONICAL:
+			fmt = PATH_FORMAT_CANONICAL;
+			break;
+		default:
+			fmt = PATH_FORMAT_UNMODIFIED;
+			break;
+		}
 	}
-	free(cwd);
+
+	format_path(&sb, path, prefix, fmt);
+	puts(sb.buf);
+
+	strbuf_release(&sb);
 }
 
 int cmd_rev_parse(int argc,
diff --git a/path.c b/path.c
index d7e17bf174..c3a709a928 100644
--- a/path.c
+++ b/path.c
@@ -1579,6 +1579,75 @@ char *xdg_cache_home(const char *filename)
 	return NULL;
 }
 
+void format_path(struct strbuf *dest, const char *path,
+		 const char *prefix, enum path_format format)
+{
+	strbuf_reset(dest);
+
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
+	case PATH_FORMAT_CANONICAL:
+		/*
+		 * strbuf_realpath_forgiving inherently resets the destination
+		 * buffer, safely aligning with our replace semantics.
+		 */
+		strbuf_realpath_forgiving(dest, path, 1);
+		break;
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
index 4c2958a903..7e7408dd05 100644
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
+ * Format a path according to the specified formatting strategy and store
+ * the result in the given strbuf, replacing any existing contents.
+ *
+ * `dest`   : The string buffer to store the formatted path into.
+ * `path`   : The path string that needs to be formatted.
+ * `prefix` : The directory prefix to calculate relative offsets against.
+ * Pass NULL to default to the current working directory where applicable.
+ * `format` : The formatting behavior rule to execute.
+ */
+void format_path(struct strbuf *dest, const char *path,
+		 const char *prefix, enum path_format format);
+
 # ifdef USE_THE_REPOSITORY_VARIABLE
 #  include "strbuf.h"
 #  include "repository.h"
-- 
2.55.0-rc1

