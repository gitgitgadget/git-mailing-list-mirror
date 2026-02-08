Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2633338F35
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770537561; cv=none; b=CKro7SQdzRDJT+YaxkgCqt0C1Hi/3qSX62iBO17lJQyD1wfZzvpCYvzcHoKJOF7YpE3eWYw823kqN7Dp6SxeSIUXD8RgXpiL97MhKaGwxbxkRvJyctfIakXIe6X4xLEDNUiUuxgw97EdfwbnClK1kUHqAsMzl9s7/wQz0uu+iT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770537561; c=relaxed/simple;
	bh=/8gJVtkXs3dK9x6ZwfHkLGOuwvBnCevekcxXzJDYj1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i5HEjmha6FF0yYlATClMbBkRFDwFBWtNw6aHw8A7xtEmi+64J0adGRgrQ5/QzYnpiRyzB/5WdxCT6DAEkzmAW9lAJwTXa6AfTb5xcbhFKhLLlJVHrmeWXMwlNx40SXba38GgZVOyZMUJ8B7X+DqZ2zFAoKrJu9x4kw/NHv1LmVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCUXPPQD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCUXPPQD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a8fba3f769so15467875ad.2
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 23:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770537560; x=1771142360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bWjQMs+vzBKBda20OWBPsXMDuXMinAcidyxGmaVINSM=;
        b=fCUXPPQDSnhuVxSKV514jCHM83cvDTnV+luuIvA7wG03Z8wACiMe6fuSph0nB+Dz0+
         OTDb6PQPk0ZFOrofztpyCiZJGgK2lK5H8c//+Oy34Ba7t4ccaEMUcz+fUCPpzVHPVpKi
         +9/IIt/1yZiEE8K7PEqnTukIcFUovGaBSY+ifyM6tOcxBk/yy54GRFvM90cH5jxSGAtT
         jcrewMOCXq8P327KwLEv/JKQG1IWPS1GhkqwaMPU4OiRoSusxjpD5Y3mwWnw0l03fmKd
         /4GYs+YMg/3A+bp6eUL/r87ZVvUB/BKKpXQurRKbK5WH2ia5Vou/PkAkBaeHKbXxYiaE
         JbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770537560; x=1771142360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWjQMs+vzBKBda20OWBPsXMDuXMinAcidyxGmaVINSM=;
        b=LJOLe5m5FJ3ueLnBcSfv7AOtSkVCy8dZ5+aQpYIBkYOgKADiJCAKrwAt1DRD1tyoyl
         8miGUIkAr0lHpLWm9CClxovFA28gTRTw4VRAvmXeAYGdlkN6qTx6XLzL1J+Mis7Do47t
         tLgyuj1Jsk7lutwIcbQsArm3cdwfYPkbmcGIYiHmKgnxrJm7CuUn02yliavp6Bm9kQHN
         uYF8bgyfPniC/C5p66M76K1C6dj12OSpXc78vZl14RHbSeLrBmsNFyuf/US83t4vUzJD
         LK0t5MKD4sKnBzOfuHP/kHn1YQoJcS7YWEFxsnZHuUy7AJNYngnGOz1mKJbstit9kOmD
         hgzA==
X-Gm-Message-State: AOJu0YyRuUJfc2XuO8r+HhPiDfixjlHSfwX0KpXsju7Z9JpGinH3N4i1
	1nLy9zzbuaIgQlsB43r/Ekt6QaoQ6OxWqRhNfdGVIMOBFABvJTglCryOXsmcI7/i
X-Gm-Gg: AZuq6aLaW6Y9IXhWaBcschapVI8/ftVm11L2obF7jqazy+he9veAoRsjbvSzBKCSYfv
	BQKihM2cL8aFP6VEePcBmIWVr4CGfKvRuQw+2NyrgCXDhOmZ7KJZ9WD2m0Qbg3+MmyECCDqSnE+
	NYwiCuog9oiOZ8EcPxfPNj69Dfi89u13mScq/T0jMSCavDnV/Ej8+mFF3nJVwkJX0Y0fG8Kaw+O
	IbNhVk8zJhI25Qb/KnaFDLPyhFvD6/u9a4okaUBAXopXYrAcfMsRQ4tFGNm9ao905+cMjp4DJKP
	yJ5Z81jnyB/03aJr0ZVuNMvntYrVBqaIpXX/+ZGVhqwpoiMbk2aDk5+SuNgviJ0QZC9AYTzAzGP
	HYAIdoDRGXKH8djh/Y0FEihik47CN4gsA42vswusl5abfmj5Atr9ALzAAUzVL0ZtcCYf58TsbYy
	qiHLEsdzHrevg2eoGBUWdSm2JUWA==
X-Received: by 2002:a17:902:c952:b0:29f:301a:f6cf with SMTP id d9443c01a7336-2a9516f8592mr93821455ad.35.1770537559419;
        Sat, 07 Feb 2026 23:59:19 -0800 (PST)
Received: from AyushJha ([2409:40e4:1220:63bf:40c2:a75d:9eb0:2777])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9522287d1sm67309435ad.91.2026.02.07.23.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 23:59:18 -0800 (PST)
From: Ayush Jha <kumarayushjha123@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Ayush Jha <kumarayushjha123@gmail.com>
Subject: [RFC GSoC PATCH v3 1/2] repo-settings: add repo_settings_get_is_bare
Date: Sun,  8 Feb 2026 13:29:04 +0530
Message-ID: <20260208075905.1807-1-kumarayushjha123@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The is_bare_repository() function relies on the global the_repository
variable, making it unsuitable for use in library code that may operate
on arbitrary repositories. Additionally, calling repo_config_get_bool
repeatedly to check core.bare can be expensive if done frequently.

Add a lazy-loaded is_bare field to struct repo_settings and expose
it via repo_settings_get_is_bare(). This allows call sites to check
bareness cheaply and correctly using a repository context.

Signed-off-by: Ayush Jha <kumarayushjha123@gmail.com>
---
 repo-settings.c | 12 ++++++++++++
 repo-settings.h |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/repo-settings.c b/repo-settings.c
index 208e09ff17..fb0af993ee 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -233,3 +233,15 @@ void repo_settings_reset_shared_repository(struct repository *repo)
 {
 	repo->settings.shared_repository_initialized = 0;
 }
+
+int repo_settings_get_is_bare(struct repository *repo)
+{
+	if (repo->settings.is_bare < 0) {
+		int is_bare_cfg = 0;
+		if (repo_config_get_bool(repo, "core.bare", &is_bare_cfg))
+			repo->settings.is_bare = !repo_get_work_tree(repo);
+		else
+			repo->settings.is_bare = is_bare_cfg && !repo_get_work_tree(repo);
+	}
+	return repo->settings.is_bare;
+}
diff --git a/repo-settings.h b/repo-settings.h
index cad9c3f0cc..bde87f9f29 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -26,6 +26,7 @@ enum log_refs_config {
 struct repo_settings {
 	int initialized;
 
+	int is_bare;
 	int core_commit_graph;
 	int commit_graph_generation_version;
 	int commit_graph_changed_paths_version;
@@ -74,6 +75,7 @@ struct repo_settings {
 #define REPO_SETTINGS_INIT { \
 	.shared_repository = -1, \
 	.index_version = -1, \
+	.is_bare = -1, \
 	.core_untracked_cache = UNTRACKED_CACHE_KEEP, \
 	.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE, \
 	.warn_ambiguous_refs = -1, \
@@ -102,4 +104,7 @@ int repo_settings_get_shared_repository(struct repository *repo);
 void repo_settings_set_shared_repository(struct repository *repo, int value);
 void repo_settings_reset_shared_repository(struct repository *repo);
 
+/* Read and set the value for "core.bare". */
+int repo_settings_get_is_bare(struct repository *repo);
+
 #endif /* REPO_SETTINGS_H */
-- 
2.53.0.windows.1

