Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3662A4508E2
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220647; cv=none; b=HAgy23yFrKT6JuUbASmNIR9+L93lpsX7/LcC0vO1sBwgULOIi6zVsvZti6Ggr3tGy2PGuWKVOOanpnN8bwEYQ3kUkk72LGWq9km7+O5PZXHacbyrHeejilctCJmYEWju9ESMB0lMXY+OgwcU2WbmYnkgEFmTI6n7l3cHIwvYrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220647; c=relaxed/simple;
	bh=OjNb9GbMmvoo/AvzqMKMll5S6aCm26qmvy45GbcFE+Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IOKKbbNFdk4jfB0pdfWb8la+NuMrkPr8rEazlgWytJp9EqMZsdxa68vf4GJ3BNLReu6NM6gABhrSY0shcwRkDP1mzQl50DUUIkPHBE2xUptipS+C8zRJ8/vEtmzuqvY5pgcMgt2kk1jiqr5joQE6uOwpJEHGPfKGxp6C49+Sfjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jly5Dohq; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jly5Dohq"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b4520f6b32so3030353eec.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772220645; x=1772825445; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMW1I8meSSb/l+AUNZEA2AyUORzirRK8gxnH32iO8mE=;
        b=jly5DohqnigudCv0RIAhihMy784LMTIYh8GbsiNm8VaIr8Liak7hbtw50FVI1/zzHV
         Wdyl1sLtUOc7asgbTpohPpNlD2GgLNWQL31svIyfAy5vfE/lBgj+GfE0laDIW5siNS91
         KRH+jVhPDJV5O+9atumcoNjc01Fg3YbvWNLaePs8bBoHGjrkNB1a3xrJFxFklrhtX8XT
         yhg0QW4qsFRpLL6imYz57/6C1ipRmOwyPicHg/4xdulOm8JKcXw2GVLRhKHJFomERi4Q
         OtAZxVTh1HXpmjnkXO3GyFWv5VOZ2Qd3k4GYyTY4vX+VhGarffYnesG7jWQCmAPLIS0f
         eN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220645; x=1772825445;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMW1I8meSSb/l+AUNZEA2AyUORzirRK8gxnH32iO8mE=;
        b=OYuWa1mStbsKNqo7jPhIdjud8QEoRqhDXYABP8sn6zicK9MFxs6gDFkPpHVypFjtpI
         zhCI95UtRGvfBqW++B8MWrU4roZBDtQihzA6Fkv8jParTQjuvgi6elUH2UfGWLm3cmAs
         Y3voDG4nufFAdYRHu2OV0ZhdqSn/NRxlTDSQZqKyWsBIu847WiJugGnoVzMMY+pkRO/v
         o+F0HaKFupTcx1n1xUa0zItiFhpLwhRmI3OilYy2B+pIHXeSLmsYK9fOPjoeRbWEsnEA
         ca7HHyuugF07wNY/JiIAtB9WoO2cv7mBjDQEOymi/a3dnsWjhweO4jGT43gDxqh2siSL
         fq+w==
X-Gm-Message-State: AOJu0Yypiej4/Y1U5ViR2dvDlV+s1T4w3/dNxAP8PRo/5vcUl5i/jjio
	DlM/p5Dy5xoya+BUqlJvfoQXD+qGshXMtukMGS2bxZXEg1kYdmoUmKovCRPbVA==
X-Gm-Gg: ATEYQzyunFnOu52Y0R1+fH+/6bQzH2PAviQFArzJVWxV58bgEijXi+7YxA/dxidI8bm
	hejcqNNLnFe/EekbHh4Nor8ue04GXo2kh2uTkYYap5bkf8thpCd9hAuYxPqQkeJ3C8HiWGgOLqu
	t1JB0/fQOsi9lV14jyCjFoFzsI2hTf5RorvRhUus1hF5hwZZDqDF5V3CFc8B3RCNOhy9nHf1v2A
	jpYhq+TQF2GtixhsbckDEc9iUwxALwz6nwUWuoKqVo18gjbXwum6gb1tsXBIHMk6B0UW8O7PksP
	q6/ClrEU1SJgvoxvSRbYNRYWSFkUYiYFSleQwFEXO+mwXMq7Wk/8qhmuApI/D8cPvZbScb8/LEw
	sBbW6CaViPrA4WZsnmCUb99nK2/eA8IPnEsYOYnD6UY5TZSIpBZMY5Z/ZkDlNr0K6c2aS2Q1aVT
	k7NHYcXVX7RpHLP6AOEUIheN4yk2I=
X-Received: by 2002:a05:693c:290c:b0:2ba:7b63:3f4f with SMTP id 5a478bee46e88-2bde1c0d809mr1638466eec.15.1772220644710;
        Fri, 27 Feb 2026 11:30:44 -0800 (PST)
Received: from [127.0.0.1] ([172.184.191.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f23c1csm4262596eec.18.2026.02.27.11.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:30:44 -0800 (PST)
Message-Id: <6d5b9ff07566e1cc28a672cf1f47988e9c8c45da.1772220640.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 19:30:31 +0000
Subject: [PATCH v5 02/11] repo: add path keys to repo info
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

Add a path category to git repo info with key-value pairs that
mirror repository paths users commonly retrieve via rev-parse and
git-path lookups.

This makes scripting against repo metadata more direct and avoids
shelling out to multiple commands for related paths.

The new keys are introduced as explicit path.* entries in
repo_info_fields and are resolved through dedicated helpers.

This keeps lookup behavior predictable and makes future path
additions straightforward.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/builtin/repo.c b/builtin/repo.c
index e34914a9a7..35e1eaf7d7 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,10 +1,12 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "abspath.h"
 #include "environment.h"
 #include "hex.h"
 #include "odb.h"
 #include "parse-options.h"
+#include "path.h"
 #include "path-walk.h"
 #include "progress.h"
 #include "quote.h"
@@ -14,6 +16,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
+#include "submodule.h"
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
@@ -40,6 +43,13 @@ struct field {
 	get_value_fn *get_value;
 };
 
+static void repo_info_add_path(struct repo_info *info,
+			      struct strbuf *buf,
+			      const char *path)
+{
+	strbuf_add_absolute_path(buf, path);
+}
+
 static int get_layout_bare(struct repo_info *info UNUSED, struct strbuf *buf)
 {
 	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
@@ -61,6 +71,119 @@ static int get_object_format(struct repo_info *info, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_common_dir(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_common_dir(info->repo));
+	return 0;
+}
+
+static int get_path_config_file(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "config"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_git_dir(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_git_dir(info->repo));
+	return 0;
+}
+
+static int get_path_git_prefix(struct repo_info *info, struct strbuf *buf)
+{
+	if (info->prefix)
+		strbuf_addstr(buf, info->prefix);
+	return 0;
+}
+
+static int get_path_grafts_file(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_graft_file(info->repo));
+	return 0;
+}
+
+static int get_path_hooks_directory(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "hooks"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_index_file(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_index_file(info->repo));
+	return 0;
+}
+
+static int get_path_logs_directory(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "logs"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_objects_directory(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_object_directory(info->repo));
+	return 0;
+}
+
+static int get_path_packed_refs_file(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "packed-refs"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_refs_directory(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "refs"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_shallow_file(struct repo_info *info, struct strbuf *buf)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	repo_info_add_path(info, buf, repo_git_path_replace(info->repo, &path, "shallow"));
+	strbuf_release(&path);
+	return 0;
+}
+
+static int get_path_superproject_working_tree(struct repo_info *info,
+					     struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (get_superproject_working_tree(&superproject))
+		repo_info_add_path(info, buf, superproject.buf);
+
+	strbuf_release(&superproject);
+	return 0;
+}
+
+static int get_path_toplevel(struct repo_info *info, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(info->repo);
+
+	if (work_tree)
+		repo_info_add_path(info, buf, work_tree);
+
+	return 0;
+}
+
 static int get_references_format(struct repo_info *info, struct strbuf *buf)
 {
 	struct repository *repo = info->repo;
@@ -74,6 +197,20 @@ static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.common-dir", get_path_common_dir },
+	{ "path.config-file", get_path_config_file },
+	{ "path.git-dir", get_path_git_dir },
+	{ "path.git-prefix", get_path_git_prefix },
+	{ "path.grafts-file", get_path_grafts_file },
+	{ "path.hooks-directory", get_path_hooks_directory },
+	{ "path.index-file", get_path_index_file },
+	{ "path.logs-directory", get_path_logs_directory },
+	{ "path.objects-directory", get_path_objects_directory },
+	{ "path.packed-refs-file", get_path_packed_refs_file },
+	{ "path.refs-directory", get_path_refs_directory },
+	{ "path.shallow-file", get_path_shallow_file },
+	{ "path.superproject-working-tree", get_path_superproject_working_tree },
+	{ "path.toplevel", get_path_toplevel },
 	{ "references.format", get_references_format },
 };
 
-- 
gitgitgadget

