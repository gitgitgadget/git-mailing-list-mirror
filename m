Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69BB472783
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140496; cv=none; b=YXOZSN8HGfxISTaDBbzADR+f73RoKFJUOwHEDMBsmBOzoVie7ZGuqygyu8Ms60bIOWukn12RbKFYQBaNJ/fper7V9zolL1wZEpGRHfBmgR6zg2JNiIbhMBpTQKYJbmGa0jiEirPK5Ft+w0bc6131HaZG01pWlQdBREIin9Gzvs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140496; c=relaxed/simple;
	bh=OjNb9GbMmvoo/AvzqMKMll5S6aCm26qmvy45GbcFE+Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f7eT+XGs8NTN0/Vo+yktz8bQt6rL2ZUrEtC4aOgSjmGCA7t7h4mMZhRGY4vg13Wzm5yJt3WsDF0lOPKkcJKiIMrSUSLixC9nYHuMK1s2tGgi9q1SPsfz7lNSeO+IujUdssTo5SkakuFhPAJTBg7G9puynDteAwVk0PV2y0zRe6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW2cQ83p; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW2cQ83p"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5069df1de6fso11404761cf.3
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772140491; x=1772745291; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMW1I8meSSb/l+AUNZEA2AyUORzirRK8gxnH32iO8mE=;
        b=GW2cQ83pUt0ciDsmK1/P3+nMbjEsEb0rP8nWo2TC5AnlwYBEOtB7JI8eFvfjgkny8K
         1EcserEPOfIdUmH92jSH0Kf+sIZov83lSKR6sMCNwIJOHVq6ygBzl4nn5TzBEIhOLXlq
         cFHZcn0fFdMzkR6dPsqlF3Lxjz9nvdpbfPblINptKf1zCYZxSsxU4C7zzHjynYjtPno9
         ToypCO+GCA+08a7JfqTDW4DwlPN6tdqvd61AD0Nca4zZCo/581AWr3cV2j3ec3EEzvU1
         Ki0DoRPUf8EGe0HduY7R1f3rjM7SBH9+rFyo7V5XYQlWB6jNatFaW62ICj1mev5kAngh
         h8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140491; x=1772745291;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMW1I8meSSb/l+AUNZEA2AyUORzirRK8gxnH32iO8mE=;
        b=jWt+czF8KpPTu3gCdvNiSI519N7TT+XPBC5BXa0lc/0yiD/GW9lQqKp0YQxdToQ9wi
         XzNvxCbDK8T5yD1V3JU+3biyKMp5T+ykcbuGjMhSVQtLA5lk4LpMOJDtW8ZTwJsAdZdT
         XBl9aqUb2ZM1pFBxjPDGMU/Tjw1S2XXXaCkn+ZIDG583vAhEazNfKduTpmYLkcKSPQ2Z
         D2v7op6CZOpTwdskkfvFJWnPe8z1CASVGU9dur1UFHuOGYNQj73HDyU0WgSUrvGFzwN4
         NmX6wKg2qab2A6LUw7eYZ46E/xpggl+ODNhUJuIOzUdWBNh9ofyxIa12hlntOKhYgaBh
         fB+Q==
X-Gm-Message-State: AOJu0Yx5peJFjN9zEWiWSgbrz4F8E5lHchplHeedKZw5vfi0jTYUw7MC
	vFPYgP1W70RtwyTbZfcrYPqd1wydT1mCaJxGWuMrsHOJJ2DGLCW5s3mbb2Y8sA==
X-Gm-Gg: ATEYQzzsC4TKCWGcsBg2zqZfc1f4G8/jKK2gcFXf3dswdrKIbRuW67i6J+0+Q+y0HlR
	ykYdUtSExUB9iT5g0qHYYEZd0DF5x0aidlE5DY7XSa+lZaowYLGWU1pEeZuo3B2B10s66/Zp7v8
	H/XoNo1iyiZ2b4qQNrzNsKgjLg7CryomSoi5K21SABBzLtoLfP1CiE7LGYhOarq5UC4PVfYNxZo
	108W7UzoryUkx+zLy0EXCG17sJFuXn3OyMs6bFhPTtuMPHE/JGD83tRuKpGQXl5r/J8q+AAW5ye
	c0v3iIQtl7BIaVUzAYgdIAyPXnFBziKCd36cDre8Mz7hAGaGhXbME17vcd483D3FQpaDeBg7SZx
	K/0p1nRzwg1T9d++QnCzFArLE6gXWa9osxyP5yoFZcXQM0BQ2iBQjcNMLsjZidDdaSG5YsZHbN0
	Li6jH6gyTv2PTObxKFBfdmA9eY6A==
X-Received: by 2002:a05:622a:30e:b0:4ff:b231:eea8 with SMTP id d75a77b69052e-507527146b8mr5808031cf.14.1772140491003;
        Thu, 26 Feb 2026 13:14:51 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf677448sm283409085a.19.2026.02.26.13.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:14:50 -0800 (PST)
Message-Id: <6d5b9ff07566e1cc28a672cf1f47988e9c8c45da.1772140487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
	<pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 21:14:39 +0000
Subject: [PATCH v4 02/10] repo: add path keys to repo info
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

