Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193F7477999
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140497; cv=none; b=B435axaTrJp3UbsJAKeV29k0nUdVgcjtXrrSAnx3Wu3WpGK7LAlGN+2wWTxfPROYmgrm6Q7aGaPr8/NohIWfhyQz20C2lJl6KDZXM1yt+7h11tUhuGinYHzFJ2oRO7kaxiSyceEs3fjIa1damZSJntdZUePnYHtLh0uaniD63cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140497; c=relaxed/simple;
	bh=0bUZXmla5UsacimDsqCATAe2H7uu1M9i9KT3JienMJA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WSgY42L0cPDiOi2xSv+TlCEYzfkd8JLbhxIj4lWaWj5s7/lqLmBzd+U2CMocmgKrTTvoihVddEnHBVk2CbMo1tnv7OAj+V93t0D/d7umJWLx6WMzOa2L8FycLcATVX4/pIx/4BblTGm/y/TLPfWYsjfMBY8S+i1g+UE14wTEb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpDNwCqM; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpDNwCqM"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb3b3e643dso81570885a.2
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772140492; x=1772745292; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VMgLadHKUC5Slj27qjnqYHkUgr6izYn0jYmmMwo+0k=;
        b=FpDNwCqMiN0Apaq5IxoVdQamoSn2oAOv+tw2tvqqckSfkEe9DRr/c5eNt/w7hN7Jaz
         +66QmVK+/pWO9BrSU+kSC4+G3EPVfoNvuHPa1jIWEpKhhXkvBvK2bzxqD9nrnSH/iwcF
         c6ip2tMFyBfaU3OxzWGgZfjv9uvsE+N/2ZBwootlLIgrMb/uCSLLGOhkCmR1mP22LjYx
         RA1XEz5W3J6D/My9Su2L5rvtwx4Y5djb44y5uoFN6L/rjUeI8I8C9syWZF0nSqZgUsPQ
         DbZIWfnX84uWka2AaCY65PXkXfkN7D9Na6EyyEiYgDcKk0KzdNvaNmCmL+4JhejAUgfl
         IIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140492; x=1772745292;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3VMgLadHKUC5Slj27qjnqYHkUgr6izYn0jYmmMwo+0k=;
        b=JYnJMlyTjayV3x2T7DOS1yj6Xlk9dOL1ckEJYPyuZH7j5t7A88HyNdYVTCSkbrGYnz
         92f3nWRKaCW3oRfwqhCJeFpIX1wcqfBFUYsGvKs2hmXxczzWNz/79g5NVSIr5E3PBMN+
         ya48DYYSXq5E0WXcefe00zUtpZ6RXwQn8D8nivBYvlOs0jFX8Oza+08ZRkwg+xIOtUkV
         pmKCeB8XDfB8+Z35zxZaOx+7mgg4BRT2oUdZPGqTbCC3dFjSM+qjtMI6Ohu1kyJasX9W
         kEfjCsUqQwUXWOwK5kZxOuWf+n3PtFpTesKncLnQVoX5AFjhAz0HJ15bLqNs1BafEqY5
         6quQ==
X-Gm-Message-State: AOJu0YzpFQEYCFyQnYv1k6MNl0v8nrYTqQEysZNQLqMzgLWZfrSlesfa
	Tuo8LVRXqBHibUWnJRU+hR+ahz7fkDTaxAk0J6aKvQTOZ8bzulDa0xxVmZXg4g==
X-Gm-Gg: ATEYQzwI5vIS1eq/7i/Wukf/MuAVKpw/XpR7Cd+VTtELALhvy0Eq4ImZ9oamX5fEyha
	0P7jtSd8e1XDmSxHvtl3KZtzzn57oDaD2/rENgF49+xNg3wKZQMRDZwsvYr/8n5kr+3bIW3d67x
	C2Rx3VqhyjuWdRx58amaPw2gk7W163BMfrv7vnypCdLTu5IqwMgiu0ZQzShrRyWv3RO6dAm8/Qx
	t7m9eb2OJ3yFZO0QrL4dRABaelVfPSYoX2Bkax30xTdBLjlt8mt+mcq+qIUxgDHY1jv8ebAVtPN
	WuDAAaGpNI+1A19wQxPJQaCI4B9hU5nFKn9p3+7GXdXrW0ENt8TrobtYX33XQNtSs5TmN0e7fFX
	lfF91twMID6nI5gYAOPtaxga65pTuogLE9yBqFAhL1XxkW/tZnOnOn+ZgfUmHERRDRXFz8TuIHy
	v0ENpfoOXVUylT0T/b7xEjhsLjew==
X-Received: by 2002:a05:620a:40c6:b0:8c6:a809:862a with SMTP id af79cd13be357-8cbc8f15f3fmr53741485a.45.1772140492285;
        Thu, 26 Feb 2026 13:14:52 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf673060sm300903285a.14.2026.02.26.13.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:14:51 -0800 (PST)
Message-Id: <5c438d045be1becc10b687a772055df5745372ae.1772140487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
	<pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 21:14:40 +0000
Subject: [PATCH v4 03/10] repo: add --path-format for info path output
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
Cc: eslam reda <eslam.reda.div@gmail.com>,
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

