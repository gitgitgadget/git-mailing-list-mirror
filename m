Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ABB1D5151
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772318683; cv=none; b=faHv7CZs43mB5ZN6QJEpKOTmfKlmBOw53sAw17h1zUjo9c/c+oOFsfc3jGPCetDO58VAiN889AT9S0frphMKkPjVhyxCPCu3psiC6IKnUFRISVO/EiDek/+aK7vdV0v+aBCDZBZWU0fUIwRZstds3gwLdxkIQXj7Mfqe+EFemhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772318683; c=relaxed/simple;
	bh=EzYBYphLAzKvRFpg8IZKA0Su/xzV9kT0ALA0mLIrwTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aR7aURkD9VY1sNnanqqxETIlSHyeXBC/vdN0Zo9occW1iVfh0+bPdrhkx/SOWeK1Hoxr9q6FH17CnJYDeh3UvrlVpOaYe2a5MKZWsZJERoTTjMmjCE+dD8KwELgq31STuvSJ5bEZYuNHfai6peJa0MyTwbQyAPiCIuwYHfukRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVT2WLxq; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVT2WLxq"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56a8fdaddebso1137238e0c.0
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 14:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772318681; x=1772923481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mmLw46Y6i6u4cCRWSpdGz6Ck8wqff6zrJIiAwwZQtU=;
        b=kVT2WLxqev71/cCl5yayjeVw8qsSj+Ycb+qJCqvedXyoj+FEmBOsMCmNFqzG8j0+QQ
         zuuEd8lbsysjr6eITzvFDJ6DZjxtJpFS9kdX8c3OHUTFRzJ2ua65G4H9AP+9OODnNR7N
         ocj9y0oHGrIv84W4kEOX6F+s0f8Vt+Bmh9yicw4W2lNhGO13NHT2OFY0a7QEVEDqlgRn
         sqMqpMaS7g+gH43pU3mlNIFIv38ivVUZHLAfXtTgBqfjBsX3R00kvre7OI0f+GRAENJQ
         7uWyEoZOmGYT1fq63cFkRCe6wLTUJfEtzKq9PMwjjaIHT7hwT9b24SlS603ZzLAXOSuo
         KFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772318681; x=1772923481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5mmLw46Y6i6u4cCRWSpdGz6Ck8wqff6zrJIiAwwZQtU=;
        b=kIDYYij57Fv63VPqRTj3I0XOUubKSoc2SuNFiV/KIgqQV6BS+vDBVz4YlTYqKdfvMz
         Dnf6Snj2l/V1wdOsSWtfqbcYTBE7nICSp25SqkENyyACNko5aT6EU2bCTa+NkJmr28kr
         iRpssJBzWcoCc9zvW/0wmN/LEug37eCCHDfSxNKkr4lLDN50hDTJpHkOAer5993vbc0a
         6ah1rmoxKQ30Mtr06WImgPcoyL2Bgy2v6yGDqS/2rCWrdOcPlnfe+KXrfX/lYwtQPku/
         gbhrkEudmWcwcbDANdfcZTD0mqMbmQBV41pEIxQGRvvkp9FXG1s39y/TbYNqTQfu4Bah
         10FA==
X-Gm-Message-State: AOJu0Yz+UobIPheSw/xTKiaoGNXqpLOKznQdtzRnjYgNwcMFPYsQpVID
	TC+mPeswGAFTVaSjQYFKGCVqXNX1xuJdL7kxSxksk/BRSkwrDUCU5u48ZwYVXHjs
X-Gm-Gg: ATEYQzxP4vCdi0Yq+ToYSKre66sxksZAUqMCyPLChwe7bdMLITgVvxmUJ6Abeu78zEA
	eFYt0fLLawsQMiXplFl2TXdLkhllUqhJ9sVXQTNHLuaDz26ngoCx9LFLXuk2Qur2jaSSH98qUJb
	myperE6Do7ddqDBM9Kh1npAKc/Kg3Aca5GZiJOheK5iGjBWDC9WwMuuprxN8aDrzvv39bZsHxZg
	YsUH5BUwb3vdQXzIdSDoH/AXCdhxODaSgpzsZW3qowG2dhsQ1rF1ZPqHo5s2ZMeO+2TDRTTlLqB
	+Ji6DOc9Dhoi76WalpjKhi3MIiGGcIqjsoKMtelOmeYZsHQqOf8P6OPRxKp8Ud2ku0pzKwLqQzM
	x384/uUwy1SM6st1Cyw6TtUsDacdeZO6q+aJQEMNWjRYx16RkYL1G/u22XvEax3qY5CL3hLwbp/
	zg4RvBejMvoKQ3BMVu/inPcKriCcts5nU/c4EIsk6vqQvJz9Z/8FRwF7ZYoAt/7XcxwXE=
X-Received: by 2002:a05:6122:2392:b0:566:3c22:c131 with SMTP id 71dfb90a1353d-56aa0a9e644mr3354925e0c.10.1772318681069;
        Sat, 28 Feb 2026 14:44:41 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:c4:89c7:617e:ea24:9d26:4bc7])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91659421sm11739094e0c.0.2026.02.28.14.44.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 14:44:40 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	jayatheerthkulkarni2005@gmail.com,
	valusoutrik@gmail.com,
	pushkarkumarsingh1970@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH 2/4] path: add new function strbuf_add_path
Date: Sat, 28 Feb 2026 19:05:56 -0300
Message-ID: <20260228224252.72788-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `print_path`, introduced in fac60b8925 (rev-parse: add
option for absolute or relative path formatting, 2020-12-13), is used
by git-rev-parse for printing paths, deciding between using relative
or absolute paths. This decision, however, could benefit other
commands, notably git-repo-info.

Encapsulate this logic into a new function called `strbuf_add_path`,
located in `path.c`. Move to path.c the two enums used for deciding
the path format, i.e. `path_default_type` and `path_format_type`.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/rev-parse.c | 72 ++++-----------------------------------------
 path.c              | 51 ++++++++++++++++++++++++++++++++
 path.h              | 23 +++++++++++++++
 3 files changed, 80 insertions(+), 66 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a2162ff39e..024a9e7d5f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -623,73 +623,13 @@ static void handle_ref_opt(const char *pattern, const char *prefix)
 	clear_ref_exclusions(&ref_excludes);
 }
 
-enum path_format_type {
-	/* We would like a relative path. */
-	PATH_FORMAT_RELATIVE,
-	/* We would like a canonical absolute path. */
-	PATH_FORMAT_CANONICAL,
-	/* We would like the default behavior. */
-	PATH_FORMAT_DEFAULT,
-};
-
-enum path_default_type {
-	/* Our default is a relative path. */
-	PATH_DEFAULT_RELATIVE,
-	/* Our default is a relative path if there's a shared root. */
-	PATH_DEFAULT_RELATIVE_IF_SHARED,
-	/* Our default is a canonical absolute path. */
-	PATH_DEFAULT_CANONICAL,
-	/* Our default is not to modify the item. */
-	PATH_DEFAULT_UNMODIFIED,
-};
-
-static void print_path(const char *path, const char *prefix, enum path_format_type format, enum path_default_type def)
+static void print_path(const char *path, const char *prefix,
+		       enum path_format_type format, enum path_default_type def)
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
-	if (!prefix && (format != PATH_FORMAT_DEFAULT || def != PATH_DEFAULT_RELATIVE_IF_SHARED))
-		prefix = cwd = xgetcwd();
-	if (format == PATH_FORMAT_DEFAULT && def == PATH_DEFAULT_UNMODIFIED) {
-		puts(path);
-	} else if (format == PATH_FORMAT_RELATIVE ||
-		  (format == PATH_FORMAT_DEFAULT && def == PATH_DEFAULT_RELATIVE)) {
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
-		}
-		puts(relative_path(path, prefix, &buf));
-		strbuf_release(&buf);
-		strbuf_release(&realbuf);
-		strbuf_release(&prefixbuf);
-	} else if (format == PATH_FORMAT_DEFAULT && def == PATH_DEFAULT_RELATIVE_IF_SHARED) {
-		struct strbuf buf = STRBUF_INIT;
-		puts(relative_path(path, prefix, &buf));
-		strbuf_release(&buf);
-	} else {
-		struct strbuf buf = STRBUF_INIT;
-		strbuf_realpath_forgiving(&buf, path, 1);
-		puts(buf.buf);
-		strbuf_release(&buf);
-	}
-	free(cwd);
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_add_path(&sb, path, prefix, format, def);
+	puts(sb.buf);
+	strbuf_release(&sb);
 }
 
 int cmd_rev_parse(int argc,
diff --git a/path.c b/path.c
index d726537622..ab9669abff 100644
--- a/path.c
+++ b/path.c
@@ -1574,6 +1574,57 @@ char *xdg_cache_home(const char *filename)
 	return NULL;
 }
 
+void strbuf_add_path(struct strbuf *sb, const char *path, const char *prefix,
+		     enum path_format_type format, enum path_default_type def)
+{
+	char *cwd = NULL;
+	/*
+	 * We don't ever produce a relative path if prefix is NULL, so set the
+	 * prefix to the current directory so that we can produce a relative
+	 * path whenever possible.  If we're using RELATIVE_IF_SHARED mode, then
+	 * we want an absolute path unless the two share a common prefix, so don't
+	 * set it in that case, since doing so causes a relative path to always
+	 * be produced if possible.
+	 */
+	if (!prefix && (format != PATH_FORMAT_DEFAULT || def != PATH_DEFAULT_RELATIVE_IF_SHARED))
+		prefix = cwd = xgetcwd();
+	if (format == PATH_FORMAT_DEFAULT && def == PATH_DEFAULT_UNMODIFIED) {
+		strbuf_addstr(sb, path);
+	} else if (format == PATH_FORMAT_RELATIVE ||
+		   (format == PATH_FORMAT_DEFAULT && def == PATH_DEFAULT_RELATIVE)) {
+		/*
+		 * In order for relative_path to work as expected, we need to
+		 * make sure that both paths are absolute paths.  If we don't,
+		 * we can end up with an unexpected absolute path that the user
+		 * didn't want.
+		 */
+		struct strbuf buf = STRBUF_INIT, realbuf = STRBUF_INIT, prefixbuf = STRBUF_INIT;
+		if (!is_absolute_path(path)) {
+			strbuf_realpath_forgiving(&realbuf, path,  1);
+			path = realbuf.buf;
+		}
+		if (!is_absolute_path(prefix)) {
+			strbuf_realpath_forgiving(&prefixbuf, prefix, 1);
+			prefix = prefixbuf.buf;
+		}
+		strbuf_addstr(sb, relative_path(path, prefix, &buf));
+		strbuf_release(&buf);
+		strbuf_release(&realbuf);
+		strbuf_release(&prefixbuf);
+	} else if (format == PATH_FORMAT_DEFAULT && def == PATH_DEFAULT_RELATIVE_IF_SHARED) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addstr(sb, relative_path(path, prefix, &buf));
+		strbuf_release(&buf);
+	} else {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_realpath_forgiving(&buf, path, 1);
+		strbuf_addbuf(sb, &buf);
+		strbuf_release(&buf);
+	}
+	free(cwd);
+}
+
+
 REPO_GIT_PATH_FUNC(squash_msg, "SQUASH_MSG")
 REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
 REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
diff --git a/path.h b/path.h
index 0ec95a0b07..c152d20c71 100644
--- a/path.h
+++ b/path.h
@@ -258,6 +258,29 @@ enum scld_error safe_create_leading_directories_no_share(char *path);
 int safe_create_file_with_leading_directories(struct repository *repo,
 					      const char *path);
 
+enum path_format_type {
+	/* We would like a relative path. */
+	PATH_FORMAT_RELATIVE,
+	/* We would like a canonical absolute path. */
+	PATH_FORMAT_CANONICAL,
+	/* We would like the default behavior. */
+	PATH_FORMAT_DEFAULT,
+};
+
+enum path_default_type {
+	/* Our default is a relative path. */
+	PATH_DEFAULT_RELATIVE,
+	/* Our default is a relative path if there's a shared root. */
+	PATH_DEFAULT_RELATIVE_IF_SHARED,
+	/* Our default is a canonical absolute path. */
+	PATH_DEFAULT_CANONICAL,
+	/* Our default is not to modify the item. */
+	PATH_DEFAULT_UNMODIFIED,
+};
+
+void strbuf_add_path(struct strbuf *buf, const char *path, const char *prefix,
+		     enum path_format_type format, enum path_default_type def);
+
 # ifdef USE_THE_REPOSITORY_VARIABLE
 #  include "strbuf.h"
 #  include "repository.h"
-- 
2.50.1 (Apple Git-155)

