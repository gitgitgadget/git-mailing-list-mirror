Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7530FC21
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 05:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772428559; cv=none; b=XQLI5EuJzU3Cye0vf/v6XF079M898efjA1j/WBfBS8xN1dSyOCUlF/CznW+Hvq2khmwWgJzDVP9k0w2B1Gdhm/p6xg1Exk0UbLvtjuCrM9w+RqecZ1hvPYJrnx4KYpgc/GD21vyN4oxBZjMNb1fhBwa+XZa1SY6Yy96K4nxVJSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772428559; c=relaxed/simple;
	bh=izEvDRKz/7z+iIIwA1htGKlNikCB5h8OeokTmrnIqkE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MAwVbmXfFRVu6PU4537ITrDcY8RuXQ/C74q9Wxnav9v/ltz6z3m4qR7id522FsXKNVlBLYJp19rinxmaMFfNC7i1PJcJcXhh1b+PeqkDUrIZe0g84xiyzkLZ3y3S3xF9VMVgR6K5LueoeqQ+27AhslclHjlxaq4+4ovshriAfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT8ZKcZ7; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT8ZKcZ7"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cbb6d5f780so418178585a.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 21:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772428556; x=1773033356; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FYRuz68f7kW4xYOqm3gsfrW1LdamRGDdOyiOUocm1o=;
        b=lT8ZKcZ73mW+Wo6LmItsMDIAxTEC47uymVvHs0NgBd6ghsRc1DE7+BCaj3q/Wd3jxN
         u/vf2pwkoPHAsiw0dTLxegotKBSw1IOrXLiAaflcRzzwmGMB1A4GUWoJvwHGyObuuoLr
         gFDuyOFPLpTV6iV746yzEvBk+X660D7GdYhOwPr3CPOstV+BUhWRSZh1okf01Bva8SfM
         sj+i6HorvF5M4ortqFjM7FMiMu5H1pq78Qqrqi7a7R5cMWATS8aTWzxCIIz289GXUATT
         VOHIvwFxEjYtOQSQO9VqJLoqNrikQlJSaADYS8fKTxxwdlMfgLGrVNDawL1q2PXoH5zJ
         XDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772428556; x=1773033356;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1FYRuz68f7kW4xYOqm3gsfrW1LdamRGDdOyiOUocm1o=;
        b=RQEkKaor1ESKtkJUtG7crHakzK+R2ePwEsWQ0vRBZ9X/cyQHTUSiesiL+kKNrac7kv
         hxeVkcRyB6cMODogn2LVbPceFbRdKE9uXAFjUBp1RTHYiCWpQH1shQXalN7ktY7CSFIe
         XhvhkyvkhX18hTF6tAfCI+YnynydNE8uvAxkW6bQwpcfuYQ5t/mBV8cUVXSQcqncHyOe
         U6jWSn3sgOw+Q1HkOPbgepuUXoPTf2bm4SvsADuR1hZpSVyucO7DtcIu8fqPhCvZ/+Dv
         bFWYMuFzERovWwJ6EFSiaABLfC8fnce8Blew2zQ/dsTgjDL/HJLanC8Ybnn3ndgdApvH
         dwGQ==
X-Gm-Message-State: AOJu0Yyl+bVf/FDJnX0Um2a3DxOk2Bd9rQDUP1g42JZHeIWC/kllxVRW
	1aMecPQlXP0OHV2m6NaplaDTAuW1YImshxJ83FRc7ea50cK7s0/a5ojRacF3edBM
X-Gm-Gg: ATEYQzxDCU9b5FAMrWmCY/oPzPhw7RZ8ZKBgYRu+62kLpn0MAmYSBnQXoaswE6EplYy
	SeqTAVV0wLiRbEt2bEjMI/eQLzMxVv1WNMUoFycRrK5Mkzd57z+xK3UXYwzlWfpJnZ0gpOYeAgM
	OIR6BUWGNV7XFNhpr6OBmLYsJZvBh3Y4whJOLOMw6lPnRcQ+mrTun8f11BI1/1hilA2E4aUnsUd
	Mkh9y/YKU9jczc1ZtOIIcrKPSkdn5T8rr72Yu4dV+tsXdcIuVGriw4Ol1VYkampHYI5XBUXxd+8
	4v5g325L+GfImPKyHxA75IQSB4RN+8JhIQ+4IhCfFPfHtH2sywMswz2jXcAmZk6GEwCKz3JtXen
	GIhaxS3qokX0p9Az2BLNXQx8HU2OABue0tYjvoRsFjXpFgiKlu8bnBKFgwJLl03Prn+tDkfmois
	Ns2Lkx3FymFsZsMkp2K1xbTTOr3Q==
X-Received: by 2002:a05:620a:1726:b0:8ba:2b0e:fa36 with SMTP id af79cd13be357-8cbc8d9aedamr1355335385a.24.1772428556265;
        Sun, 01 Mar 2026 21:15:56 -0800 (PST)
Received: from [127.0.0.1] ([172.183.95.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5075feb4db9sm50981711cf.22.2026.03.01.21.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:15:55 -0800 (PST)
Message-Id: <477333a94cdc1c98be8b0dac75a72e2745902bc6.1772428548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
References: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
	<pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 05:15:45 +0000
Subject: [PATCH v6 3/6] repo: add path keys to repo info
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
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
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
 builtin/repo.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index f614298199..87c5850929 100644
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
@@ -41,6 +44,13 @@ struct field {
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
@@ -62,6 +72,87 @@ static int get_object_format(struct repo_info *info, struct strbuf *buf)
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
+static int get_path_prefix(struct repo_info *info, struct strbuf *buf)
+{
+	strbuf_addstr(buf, info->prefix);
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
+static int get_path_objects_directory(struct repo_info *info, struct strbuf *buf)
+{
+	repo_info_add_path(info, buf, repo_get_object_directory(info->repo));
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
+static int get_path_work_tree(struct repo_info *info, struct strbuf *buf)
+{
+	return get_path_toplevel(info, buf);
+}
+
 static int get_references_format(struct repo_info *info, struct strbuf *buf)
 {
 	struct repository *repo = info->repo;
@@ -75,6 +166,17 @@ static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.common-dir", get_path_common_dir },
+	{ "path.config-file", get_path_config_file },
+	{ "path.git-dir", get_path_git_dir },
+	{ "path.grafts-file", get_path_grafts_file },
+	{ "path.hooks-directory", get_path_hooks_directory },
+	{ "path.index-file", get_path_index_file },
+	{ "path.objects-directory", get_path_objects_directory },
+	{ "path.prefix", get_path_prefix },
+	{ "path.superproject-working-tree", get_path_superproject_working_tree },
+	{ "path.toplevel", get_path_toplevel },
+	{ "path.working-tree", get_path_work_tree },
 	{ "references.format", get_references_format },
 };
 
@@ -233,7 +335,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	enum output_format format = FORMAT_NEWLINE_TERMINATED;
 	struct repo_info info = {
 		.repo = repo,
-		.prefix = prefix,
+		.prefix = prefix ? prefix : "",
 	};
 	int all_keys = 0;
 	int show_keys = 0;
-- 
gitgitgadget

