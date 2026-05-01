Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4A37F8A0
	for <git@vger.kernel.org>; Fri,  1 May 2026 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777677326; cv=none; b=Ia9pEqRmCM3DEA3Dw60g46WJjmLNoL897fvS0FNHNrkkWipUXZGzf6iWj18E2F4ggckr/SKtmquhYNgWmW+bZrUMfVwvLF1IgeYxtgegWF3NYXAdTmmXwMa5ZsF5knsU0zfljzx8rEczRuW4yS7B+mjmULzGYf0id8X7afpjDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777677326; c=relaxed/simple;
	bh=8RsmtDeeVuxrMaPzCgRgO5UD9mJQJpruzjuRSveX+5A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PIPvOfyUGNgvZqHtN1HcspDWyuxGnc9fKf6QV0OQ4YUNYEVLnMQy2l3qyKZnM7QWrZvpCBNkYWdflUNTvQfueKfsclcdASPihC5VleHZprllBPh9W5ezJnJ9YviqtFoeTA1z934ULOCSQf3xYCzTvdfAqogGaBDRoF4FdURIFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhnRSLy6; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhnRSLy6"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2d832f2f44cso2320438eec.0
        for <git@vger.kernel.org>; Fri, 01 May 2026 16:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777677323; x=1778282123; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrbtUJlztfDvRlh4VwnHLUsZu5a+XHh4zc+Lm3NixPU=;
        b=QhnRSLy6ERzH7ZT4ZirYhYvES7oJglfcnz+YXjinFmBNumjkJbZz6+y2+boDEEQvPW
         3EKspf8vw1F9mEJY9B0l8u9QpuhOqEuzRTrwdBpBVcUA4eRy88KuzsxIrL78x+jFSTQG
         yQnW7Vo2SwQ9lTBMi0vhepGNmY/l24ej2q1e8rcbDIQp3ju1n/1en3Q2yYyq7ReThdWI
         jefAWFKdeUHTv3KAzALvCaPbbo7Oos+z/iOD9HZbP70pxHchlYpROZ3UFn66BX9HWKu6
         vlEwlrCMR59OBURMGvV8tpQREx0o1FrENrtHFP9qcbsCa4MOJ88Kcvr4N+JHzlG4g7BE
         5pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777677323; x=1778282123;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FrbtUJlztfDvRlh4VwnHLUsZu5a+XHh4zc+Lm3NixPU=;
        b=d0AMVWSAQr80gOqpDioSNrUv9wWcO/pbyPQtYsVKTl99kTgkyZ9LpRU7BZDbRmlv59
         58XvyXgz+s0nxiEut40bmtOVIpfICVL8XYDsPrTbWcKvisu/iDTPKyis1tcSqHRTtMvI
         WGOL3e4XlowfEP+Du6I6q/z/x3rP74f9aquh1nyekgQdd6Sxz4XiSS/UmRwnciQpMsV1
         56QIX+duJ+DD7DQk5i07Y3YceXejRSUDkk9viBOSaA9DJhH20g4rUTdS9/K8Pzx2QIQs
         fEpk01rf0IgSuICXLc4XDxOM62a6b7RaB1EwpzcNreZ5T0XQs1/doTaJRs8jPsiG3chE
         4ZSA==
X-Gm-Message-State: AOJu0YwiCNeEFs1qRnLi9MDDWajFhC8qGiPTASvLxMQ6v6RUpPMQsvo/
	Mb2qZqO9xh0RSe70zPnAxgBA+p+IE9dUoecxL0lT3/CqUnsFU1h0Sv3O8ISlaH6n
X-Gm-Gg: AeBDieu8mmwigaJi4S28sQ62XmWB6LurXkWhOZU06PAq22AgWnquFUO9WFWUbSVHPmL
	GIsJlCJlVGTy8c6BWvXdS3iyQRqJgTiv2d30WMqW1SP8lsPyZmAMguz9+0uXj+4MVsFFnRvAYGd
	3/j20fy1g08otnB+HKtpiDVsK+gr92lKYajqOLbywYuuNMOxoDN06TATJMlUylPyeJGxO5CR7w+
	QWneRPKNf3f5Ht88OHhwNObKqeaZ0bCqOlorvn2ORgunUg5r0SgBrBPVtYFBaV2bihav80e0zWu
	zuzYSxhCYL/ip8dkaXKhHZc4BDzrGcq6/OOTHyRacMoroLZK+EPudg2TzawL284XTgbPkd+Jqrc
	Hw4rigU3ICBooBW0OAZMPvG0O5bAsjRDdkA6UghY90WORswLwlrKyLeYcDbRghuD7BYLhRR64NA
	NWWEmSlYWoEEbx6kNIhFbhvl24FU03xlidowYVOP4=
X-Received: by 2002:a05:7300:7492:b0:2dd:649d:751d with SMTP id 5a478bee46e88-2efb7dcd24emr541860eec.8.1777677322465;
        Fri, 01 May 2026 16:15:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.231.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b783a95sm6059044eec.22.2026.05.01.16.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:15:21 -0700 (PDT)
Message-Id: <886a7d659ee3b018290ed24ad16d381525436b81.1777677310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
	<pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 May 2026 23:15:08 +0000
Subject: [PATCH v2 6/8] builtin: create url-parse command
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
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    Matheus Moreira <matheus@matheusmoreira.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Git commands can accept a rather wide variety of URLs syntaxes.
The range of accepted inputs might expand even more in the future.
This makes the parsing of URL components difficult since standard URL
parsers cannot be used. Extracting the components of a git URL would
require implementing all the schemes that git itself supports, not to
mention tracking its development continuously in case new URL schemes
are added.

The url-parse builtin command is designed to solve this problem
by exposing git's native URL parsing facilities as a plumbing command.
Other programs can then call upon git itself to parse the git URLs
and extract their components. This should be quite useful for scripts.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 .gitignore          |   1 +
 Makefile            |   1 +
 builtin.h           |   1 +
 builtin/url-parse.c | 132 ++++++++++++++++++++++++++++++++++++++++++++
 command-list.txt    |   1 +
 git.c               |   1 +
 meson.build         |   1 +
 7 files changed, 138 insertions(+)
 create mode 100644 builtin/url-parse.c

diff --git a/.gitignore b/.gitignore
index 24635cf2d6..c5673daa6e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -182,6 +182,7 @@
 /git-update-server-info
 /git-upload-archive
 /git-upload-pack
+/git-url-parse
 /git-var
 /git-verify-commit
 /git-verify-pack
diff --git a/Makefile b/Makefile
index cedc234173..1c757a1aa0 100644
--- a/Makefile
+++ b/Makefile
@@ -1497,6 +1497,7 @@ BUILTIN_OBJS += builtin/update-ref.o
 BUILTIN_OBJS += builtin/update-server-info.o
 BUILTIN_OBJS += builtin/upload-archive.o
 BUILTIN_OBJS += builtin/upload-pack.o
+BUILTIN_OBJS += builtin/url-parse.o
 BUILTIN_OBJS += builtin/var.o
 BUILTIN_OBJS += builtin/verify-commit.o
 BUILTIN_OBJS += builtin/verify-pack.o
diff --git a/builtin.h b/builtin.h
index 235c51f30e..c6f7672991 100644
--- a/builtin.h
+++ b/builtin.h
@@ -271,6 +271,7 @@ int cmd_update_server_info(int argc, const char **argv, const char *prefix, stru
 int cmd_upload_archive(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_upload_pack(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_url_parse(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_var(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_verify_commit(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_verify_tag(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/url-parse.c b/builtin/url-parse.c
new file mode 100644
index 0000000000..6c70c131e1
--- /dev/null
+++ b/builtin/url-parse.c
@@ -0,0 +1,132 @@
+#include "builtin.h"
+#include "gettext.h"
+#include "parse-options.h"
+#include "url.h"
+#include "urlmatch.h"
+
+static const char * const builtin_url_parse_usage[] = {
+	N_("git url-parse [-c <component>] [--] <url>..."),
+	NULL
+};
+
+static char *component_arg;
+
+static struct option builtin_url_parse_options[] = {
+	OPT_STRING('c', "component", &component_arg, N_("component"),
+		N_("which URL component to extract")),
+	OPT_END(),
+};
+
+enum url_component {
+	URL_NONE = 0,
+	URL_SCHEME,
+	URL_USER,
+	URL_PASSWORD,
+	URL_HOST,
+	URL_PORT,
+	URL_PATH,
+};
+
+static void parse_or_die(const char *url, struct url_info *info)
+{
+	if (url_is_local_not_ssh(url)) {
+		if (*url == '/')
+			die("'%s' is not a URL; if you meant a local "
+			    "repository, use 'file://%s'", url, url);
+		die("'%s' is not a URL; if you meant a local repository, "
+		    "use a 'file://' URL with an absolute path", url);
+	}
+	if (!url_parse(url, info))
+		die("invalid git URL '%s': %s", url, info->err);
+}
+
+static enum url_component get_component_or_die(const char *arg)
+{
+	if (!strcmp("path", arg))
+		return URL_PATH;
+	if (!strcmp("host", arg))
+		return URL_HOST;
+	if (!strcmp("scheme", arg))
+		return URL_SCHEME;
+	if (!strcmp("user", arg))
+		return URL_USER;
+	if (!strcmp("password", arg))
+		return URL_PASSWORD;
+	if (!strcmp("port", arg))
+		return URL_PORT;
+	die("invalid git URL component '%s'", arg);
+}
+
+static char *extract_component(enum url_component component,
+			       struct url_info *info)
+{
+	size_t offset, length;
+
+	switch (component) {
+	case URL_SCHEME:
+		offset = 0;
+		length = info->scheme_len;
+		break;
+	case URL_USER:
+		offset = info->user_off;
+		length = info->user_len;
+		break;
+	case URL_PASSWORD:
+		offset = info->passwd_off;
+		length = info->passwd_len;
+		break;
+	case URL_HOST:
+		offset = info->host_off;
+		length = info->host_len;
+		break;
+	case URL_PORT:
+		offset = info->port_off;
+		length = info->port_len;
+		break;
+	case URL_PATH:
+		offset = info->path_off;
+		length = info->path_len;
+		break;
+	case URL_NONE:
+		return NULL;
+	}
+
+	return xstrndup(info->url + offset, length);
+}
+
+int cmd_url_parse(int argc,
+		  const char **argv,
+		  const char *prefix,
+		  struct repository *repo UNUSED)
+{
+	struct url_info info;
+	enum url_component selected = URL_NONE;
+	char *extracted;
+	int i;
+
+	argc = parse_options(argc, argv, prefix, builtin_url_parse_options,
+			     builtin_url_parse_usage, 0);
+
+	if (argc == 0)
+		usage_with_options(builtin_url_parse_usage,
+				   builtin_url_parse_options);
+
+	if (component_arg)
+		selected = get_component_or_die(component_arg);
+
+	for (i = 0; i < argc; i++) {
+		parse_or_die(argv[i], &info);
+
+		if (selected != URL_NONE) {
+			extracted = extract_component(selected, &info);
+			if (extracted) {
+				puts(extracted);
+				free(extracted);
+			}
+		}
+
+		free(info.url);
+	}
+
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index f9005cf459..1ede48186f 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -202,6 +202,7 @@ git-update-ref                          plumbingmanipulators
 git-update-server-info                  synchingrepositories
 git-upload-archive                      synchelpers
 git-upload-pack                         synchelpers
+git-url-parse                           purehelpers
 git-var                                 plumbinginterrogators
 git-verify-commit                       ancillaryinterrogators
 git-verify-pack                         plumbinginterrogators
diff --git a/git.c b/git.c
index 5a40eab8a2..a073eed931 100644
--- a/git.c
+++ b/git.c
@@ -670,6 +670,7 @@ static struct cmd_struct commands[] = {
 	{ "upload-archive", cmd_upload_archive, NO_PARSEOPT },
 	{ "upload-archive--writer", cmd_upload_archive_writer, NO_PARSEOPT },
 	{ "upload-pack", cmd_upload_pack },
+	{ "url-parse", cmd_url_parse },
 	{ "var", cmd_var, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "verify-commit", cmd_verify_commit, RUN_SETUP },
 	{ "verify-pack", cmd_verify_pack },
diff --git a/meson.build b/meson.build
index 11488623bf..dc3cf68ee5 100644
--- a/meson.build
+++ b/meson.build
@@ -686,6 +686,7 @@ builtin_sources = [
   'builtin/update-server-info.c',
   'builtin/upload-archive.c',
   'builtin/upload-pack.c',
+  'builtin/url-parse.c',
   'builtin/var.c',
   'builtin/verify-commit.c',
   'builtin/verify-pack.c',
-- 
gitgitgadget

