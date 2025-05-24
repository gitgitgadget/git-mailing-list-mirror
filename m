Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624E1DFD8B
	for <git@vger.kernel.org>; Sat, 24 May 2025 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748072201; cv=none; b=ja2FwKPuVAcLwKtg1xawJ9P25/T+6YzZ5L9GkbKzRGyqvJrH4v9ODI8QJwyTcb6HVGL7/bVWAlJ/sDtjZDgX1b5RX3WGMDUwKRe5jpmokn0fR965w7dwJx7tijpSDH5iBssZTzvy+49c+ifLxKnz1WpQ+ZERqJbXChdZgkWIEzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748072201; c=relaxed/simple;
	bh=suTvdBi/6Tu2bWT2s9rD8wOX9c37VtLAYS3zHoAmEPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyGHHjOlpGZJJVULuQUk61C85v3lolMhMpaQ7yjCJ7gZo9IKocRm3YuKgxWL2xnIDryOw8hGhfWslSvy8ps0VRHq5xBDgHtIdzGpgHVovb7S/0Y5w3WQWiG/tGcW94fcX0cMp5PlPwW4r7NLLYwrIcf50/OeC3/Qr6IVCfXUXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzhqyapS; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzhqyapS"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-879d2e419b9so373159a12.2
        for <git@vger.kernel.org>; Sat, 24 May 2025 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748072199; x=1748676999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xK3BrXFiPkKW2yZc5vpS2YbiE9JkJEFn9rWduXA783g=;
        b=NzhqyapSqSAZ6t4jvkMweI+AoDoUjLlfwLqwr2FTbFVMAD9BCEDSAfhiEXq+RSiubS
         /8XwrNsuEPaSdKkSwX798d51s03XnMVkVRiQpojtkrC3DEH/DTpYSkTPmDPYi4hSZvJ6
         KZZ73V92kostsFNi/am1TZ4yv3odUqCDF2m7jHKqYX12Z120QTphWrgsrbinPDs8eqFB
         QPFcxOyuuObL0HwJKZIIwNDR0BDXOEQYuJ1zJJXOHxdDhkIFH2Xby+/WVpdnhYKr/kaN
         Dgh2c7uOhsqJxi4enz0LDgQfkDD/1+6napUFkkRfQ2xgCQoBipBF0xe73KMuK1EHnlUA
         gmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748072199; x=1748676999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xK3BrXFiPkKW2yZc5vpS2YbiE9JkJEFn9rWduXA783g=;
        b=vtQHp/9NPN9qd2Qz5NnuK9g49woIEBp3uJIEokUk9RlNo3nPM0CqxVvV0eDKp0vOwL
         F5lmmu6NvhB36H1ppc2/cfPKpQZpmeZeLcb6xLpeuzAIT4bFAwWdQIx7ID+V2dq4Pyrq
         DhDhzafNmnWNunuRmnyxp7rGXCOf8+thR5ScUZ6lduOowFCXaANOdJ+cTKysg7pDJlkT
         Wi72OfKO/9B4oE443NCTb3BbJH2IRlDqsh1fAFRb7Q4el0bz0B7YbzHUNyOh+9QlGxH/
         myo7S/Kv2MPN24n3VEYw3qATwENF81ZZxjxHJqU7lS3gG0qn9Vrn6gRMkB0iQE/jw2GJ
         bL6Q==
X-Gm-Message-State: AOJu0YwEgXJSIh9T/rwxx1gc1/lJI182knBd8neAwXQ3kZwu4WTYSpKv
	pY5dPX9CiI9tN7JpAsgTvHdXHs78R5HUeEWHYcoxrqn8kT05z38QAofVC+yznGQU
X-Gm-Gg: ASbGncu8zH5WqcU4nq7fdsOrY0D/b/x1+1UVV9JxFOZBfQV4GIh6SUBU2/NJjecqqQF
	l4epZBAZvo0QJio5KpDaNt5+tKSIaAz/p+hpk1W7GFnNucsjfLpQGOlgV7pk5lUi6LWiDsRMZWi
	H0EBpAbdQEVxY+TNPaqG8E0T/UnMv46ZU5HfnYSns3MDsQTHwR4sXs+BoQzJaglWBc2JdBA8x1N
	cH1buTu68cHLrcMqY54K/OVWZopn85QLIMJJtilUHeed5yVudypATn581DV6flX9bKMXMGwFdJ7
	2uS0UZADZRAUK9naxSQ/TEFZzGUiV1Q1ojNIdUiW25Jpx6v/0c3klPYhlNWefrS/5Ho=
X-Google-Smtp-Source: AGHT+IGJMxbAiBdbTTGGrf136LN53+gpw0jMxUd70gu7x+KAB6eJPIKdJnWqkHUpoj3ZTzTokISJtw==
X-Received: by 2002:a17:903:2988:b0:224:c46:d167 with SMTP id d9443c01a7336-23414f6e2bemr33517295ad.16.1748072198646;
        Sat, 24 May 2025 00:36:38 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231e2118b07sm131949475ad.43.2025.05.24.00.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 00:36:38 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH v7 2/2] submodule: skip redundant active entries when pattern covers path
Date: Sat, 24 May 2025 13:06:28 +0530
Message-ID: <20250524073628.58944-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250524073628.58944-1-jayatheerthkulkarni2005@gmail.com>
References: <20250524073628.58944-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

configure_added_submodule always writes an explicit submodule.<name>.active
entry, even when the new path is already matched by submodule.active
patterns. This leads to unnecessary and cluttered configuration.

Introduce a single helper to centralize wildmatch-based pattern lookup.
In configure_added_submodule, wrap the active-entry write in a conditional
that only fires when that helper reports no existing pattern covers the
submodule’s path.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/submodule--helper.c    | 32 +++++++++++++++++++++-----------
 t/t7413-submodule-is-active.sh | 15 +++++++++++++++
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9f6df833f0..8872c0fce3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -32,6 +32,8 @@
 #include "advice.h"
 #include "branch.h"
 #include "list-objects-filter-options.h"
+#include "wildmatch.h"
+#include "strbuf.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -3323,6 +3325,24 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
 	return ret;
 }
 
+static int submodule_active_matches_path(const char *path)
+{
+	const struct string_list *values;
+	size_t i;
+
+	if (git_config_get_string_multi("submodule.active", &values))
+		return 0;
+
+	for (i = 0; i < values->nr; i++) {
+		const char *pat = values->items[i].string;
+		if (!wildmatch(pat, path, 0))
+			return 1;
+	}
+
+	return 0;
+}
+
+
 static void configure_added_submodule(struct add_data *add_data)
 {
 	char *key;
@@ -3370,17 +3390,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get("submodule.active")) {
-		/*
-		 * If the submodule being added isn't already covered by the
-		 * current configured pathspec, set the submodule's active flag
-		 */
-		if (!is_submodule_active(the_repository, add_data->sm_path)) {
-			key = xstrfmt("submodule.%s.active", add_data->sm_name);
-			git_config_set_gently(key, "true");
-			free(key);
-		}
-	} else {
+	if (!submodule_active_matches_path(add_data->sm_path)) {
 		key = xstrfmt("submodule.%s.active", add_data->sm_name);
 		git_config_set_gently(key, "true");
 		free(key);
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index 9509dc18fd..a42060cac9 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -124,4 +124,19 @@ test_expect_success 'is-active, submodule.active and submodule add' '
 	git -C super2 config --get submodule.mod.active
 '
 
+test_expect_success 'submodule add skips redundant active entry' '
+	git init repo &&
+	(
+		cd repo &&
+		git config submodule.active "lib/*" &&
+		git commit --allow-empty -m init &&
+
+		git init ../lib-origin &&
+		git -C ../lib-origin commit --allow-empty -m init &&
+
+		git submodule add ../lib-origin lib/foo &&
+		! git config --get submodule.lib/foo.active
+	)
+'
+
 test_done
-- 
2.49.GIT

