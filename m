Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3295B451069
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220649; cv=none; b=Tji55aBDybIObMnmuxw2uxiTJXWV87UYzAhPtWA0d2Qjpd0E8MPOjKC9e+EK4cDEApYB+0EprRCQNVOOnjGxrIMRhSBHFNW6Ro+iECMKYVqItTC63r0lhbdkSmceGa9xkWyVBmoAYJ4n7o0umnp+MpJrmMEkvSeEO7E2McREviA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220649; c=relaxed/simple;
	bh=0bUZXmla5UsacimDsqCATAe2H7uu1M9i9KT3JienMJA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EncAUs52k3pNVQMjdXAW92Kkupbk7g4VhwvXktjQxOmBpvsp7h8M6LbLGsT7gccmHWUa0cf1imCKtWDADCkPdlbZwUeg+Mg0okcpvqwWCUswSqLDQVvrXhNhgSvNUOOHnm7hRi0okv5OgJl5vgyAGuE3NyCBqrFUBbXSg8D75Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz5va5iQ; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz5va5iQ"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b4520f6b32so3030398eec.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772220646; x=1772825446; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VMgLadHKUC5Slj27qjnqYHkUgr6izYn0jYmmMwo+0k=;
        b=Hz5va5iQUsZ96rfoIl119bgl0kR4q0242BoiEmmhnNIjc41g6AjmQsmDupCFqeYmzt
         Mx5bxrLDUhzC3SgNl2a9OLSRcKMM1yyaXzuPc6QGMLsNzE/UWiZYLsP71xIFctbrjjt6
         eqRzMa2ZrlYXxdN/iWFIdpg/7BgQthUbsyPLYxhwXK6u/MJ3oVZUeClMHJC8ky4bpn+x
         wUCyOvBScYm5nheghwI5jLqTEKV3nshRhWrnni0fwB/rSlA7EYTZTxTHaVdWhOJ/E9Qv
         7cD3Lg88cOuVb5PB6oX+M0iNwEt9u96c61ssf03FUeHk1OrQMoTDM2pdKszV3s+LZUrR
         gd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220646; x=1772825446;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3VMgLadHKUC5Slj27qjnqYHkUgr6izYn0jYmmMwo+0k=;
        b=Y5MwulHoB0GG3ZqPIRInyxB4ICyqJ1Ixyg7VFVmLQ2NBh6dVNIpDf0XSm/Gd8IhIc9
         TW6iuzr9aDjYSkNc65Lk5jDuCQ12oGGS12IkzV31asIET3aBVZaSE2WJuAs/7B0TXiWq
         wMuOlXM6CGaTUB1ZYES+1KORlxgGucFti08REeM/x+Lf/DWed8jz3pyF3QRAvClSO6UN
         ZAqdnYK9pDl+Uz1eeJEg1AgKSYmxXLAuenmLmoG87vZeR4EPoHBc5HkzaFtlvuM7z7sH
         1yTscUnjs0807kE3Oj416n0AYXdw5YDtXvAPNEF51mCLSYk0gO+ZwNHSkz/XbEfOHWiy
         dnqw==
X-Gm-Message-State: AOJu0YxVaSkpE98ToD3id6Jff/GyVvVlNo/FCB5dI9yImN6Cf9RPJqRd
	sglOjHxaVzmKqpZGZV8oBMkndBXxyKTZcnVj9cJC3K83TgrKCsz0XcFFCCGbaw==
X-Gm-Gg: ATEYQzzIf2Hgie2X5ygGnxDieMti/XsCYGKFLwAPTEpu99hMATa+F171QWBeHVVTFbO
	2e6OGyDA1hi/FvJjKFyA9XosmdmkpoKn0QiNvFRWxidtpgHwQSYlXbomyZYOIpdk7/gYsw40jyr
	pjO1WJb+Ga8CkOl6ucW/fNmPlA1mX2fZM4A42DalLFjU85vZLFs/zifATBHM+iHwaQbxNlm3JgP
	WY4ggr4jW3yhJQeqSvoxEZ4pLQtoEjNGyc73VZkUVwrPp++G/zP84mK0zAu6Dn8i0cUh7GlUpES
	x52eBxftiWC2ochg5Vp2obp98CguwlAeMPDhwTiZUcMp9v192lbVXpc+3Ye2uSWg0ZJy7Qqcm15
	vQejVgZ07IMBP51Jhb0vHMsvUCeuDxrwwsCIlqYb5MSaCF73YdsKAGEaasocW/JnvRwC5q5Y/02
	gsimxVGgt2VTtfvGKBRM90wMI5RnE=
X-Received: by 2002:a05:7301:1005:b0:2b7:f145:a9c with SMTP id 5a478bee46e88-2bde1eb3a08mr1346614eec.34.1772220646197;
        Fri, 27 Feb 2026 11:30:46 -0800 (PST)
Received: from [127.0.0.1] ([172.184.191.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f7ee87sm4333324eec.31.2026.02.27.11.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:30:45 -0800 (PST)
Message-Id: <5c438d045be1becc10b687a772055df5745372ae.1772220640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 19:30:32 +0000
Subject: [PATCH v5 03/11] repo: add --path-format for info path output
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Teach git repo info to accept --path-format=(absolute|relative)
so scripts can request stable path style explicitly.

This aligns path.* output behavior with existing rev-parse usage
patterns and reduces ad-hoc path conversion in callers.

The option is wired through repo_info context and used by
repo_info_add_path(), so path formatting remains centralized and
consistent across all path.* keys.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 35e1eaf7d7..e5078e5459 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -20,14 +20,20 @@
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
+	"git repo info [--format=(keyvalue|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]",
 	"git repo structure [--format=(table|keyvalue|nul) | -z]",
 	NULL
 };
 
+enum path_format {
+	PATH_FORMAT_ABSOLUTE,
+	PATH_FORMAT_RELATIVE,
+};
+
 struct repo_info {
 	struct repository *repo;
 	const char *prefix;
+	enum path_format path_format;
 };
 
 typedef int get_value_fn(struct repo_info *info, struct strbuf *buf);
@@ -47,6 +53,16 @@ static void repo_info_add_path(struct repo_info *info,
 			      struct strbuf *buf,
 			      const char *path)
 {
+	if (info->path_format == PATH_FORMAT_RELATIVE) {
+		char *cwd = xgetcwd();
+		struct strbuf rel_path = STRBUF_INIT;
+
+		strbuf_addstr(buf, relative_path(path, cwd, &rel_path));
+		strbuf_release(&rel_path);
+		free(cwd);
+		return;
+	}
+
 	strbuf_add_absolute_path(buf, path);
 }
 
@@ -340,6 +356,21 @@ static int parse_format_cb(const struct option *opt,
 	return 0;
 }
 
+static int parse_path_format_cb(const struct option *opt,
+				const char *arg, int unset UNUSED)
+{
+	enum path_format *path_format = opt->value;
+
+	if (!strcmp(arg, "absolute"))
+		*path_format = PATH_FORMAT_ABSOLUTE;
+	else if (!strcmp(arg, "relative"))
+		*path_format = PATH_FORMAT_RELATIVE;
+	else
+		die(_("invalid path format '%s'"), arg);
+
+	return 0;
+}
+
 static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
@@ -347,6 +378,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	struct repo_info info = {
 		.repo = repo,
 		.prefix = prefix,
+		.path_format = PATH_FORMAT_ABSOLUTE,
 	};
 	int all_keys = 0;
 	struct option options[] = {
@@ -357,6 +389,9 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			       N_("synonym for --format=nul"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
+		OPT_CALLBACK_F(0, "path-format", &info.path_format,
+			       N_("format"), N_("path output format"),
+			       PARSE_OPT_NONEG, parse_path_format_cb),
 		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
 		OPT_END()
 	};
-- 
gitgitgadget

