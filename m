Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94E29D0B
	for <git@vger.kernel.org>; Sat, 10 May 2025 05:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746855951; cv=none; b=bCaLqRtsHP01l1ywiDe+7ZpjdDugkzViltUMcc7/TvzU/kdr8fCHWIgmpYA/hPIV4YLg/EFGDfslX0wiyKRtsauqRCMfigE7THwmC6rKhJJuyysz7P7ieMg+2oc9RV6o1OqwyMTTv1D/LROqTj2RRRMVk4UVfWQaabmDWvttGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746855951; c=relaxed/simple;
	bh=CAkvlu/UkI74XbikPl/3B3ouvgqNgYpIvyfpiAuPJ3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gbl+uWoRibGcmbMNPTs6hGEt/vl5l0x4szjCdEGywggMDecCEQz9jmpwFsLBa+Cxz0dW8p+iR517mKFhF43GFKzTtJGmK8bPM6bQcGCLAoO1TSEi8p1/BzaIhv/eRF+0ioy+Yo8dcz6pb2YUnLB8oSsqoR1oS1Uhrs5Pzi15PN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrSybZnG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrSybZnG"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7418e182864so2058533b3a.1
        for <git@vger.kernel.org>; Fri, 09 May 2025 22:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746855949; x=1747460749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzqGtB0df7p78tzIHVG6KxhTtijgQotAFJ0tnF5usr4=;
        b=mrSybZnGwZBoGVjn+h3nNGs0/e9yppVvc0pNmYNbZoX8o+lb2rj+4jkbsZlz0KDqP3
         PZVMDsevGhmkC8V7mu96leOG5Y8WN/kNFPPP+k0OKUJNkBDvNcRQczq9QEJBh0coEIeK
         9LqTjzrPleiWsZLxoO6npl22LjpC5u6I35+xNz73j9n/mnREh2LSMPRxQk/mLquuKsAG
         HpdeNZtCMPqQPoi8DHi/gn9MncNJ+ogvKwaqGbQeYtQgreKmABQqrqkbD4trsCLG+wLa
         6x02Q8jXxMd2x1WHTwgG5r0+6I+5f+W0o8eUriIoYb2Vh/zAWKWVLs1S6527P9FJdirG
         3Zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746855949; x=1747460749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzqGtB0df7p78tzIHVG6KxhTtijgQotAFJ0tnF5usr4=;
        b=w/UJG3Fap7nFej2fmnDWcBSGrtbPuyhG4oL9f7K+2ps2K0jC+cgwNoPtMcQ/UUfTfW
         gb1GZ/2B83BgQmXl0xeEWFrdDqyAT0/IpBofX4c5yUclnMsebhBgC1cs5BeSfEiD+XH9
         FjBzh1jVkDuNSWhmCI4GJnUKwE7SiYyvYM5VHW+6jAQcpZey6f9J++Wud5fJDpsnTuVL
         q3KlSYkHvlLXOxrdXa3VZsxNlc//AemCzrIN9CsuWuVWvUV/xPm7HoIg65tYJnwSZvRX
         nLlG3FQIYSdQWlTADS7/phjPDFGolfWzK6rot4bdCQAeO+mT/FvpFq6ITdW15k1BY/zv
         fVuA==
X-Gm-Message-State: AOJu0YwjU/LQTO6PMJvV8/gLSuzf0x7EZiH5ISDhJ6g5DVUMa+i2ZCe8
	CBdPj5d159pqTmXEoDHib0Bv78Su7uy9QBP9f64eOJPvvgpErxwDmJMCtw==
X-Gm-Gg: ASbGncuXLFETJMzs2deDj6DZ2OJREEYEcK78yeqK3LoCYoP68k3zGYcpnSs88Xsyko9
	WWvSNL7q+OT+UAe/H8uY5QQFR6XY9g7fZbCqsWoASKr+mW22DIqMaO00ctMqAFXzOvC7BzILRCm
	fVtTp+EwKVG/tuxhZeb21t34Iw0TeSM/anmIReRitMKfqMIkvzTDPG8GDGP/4uj4icqL0SWwWPu
	YIHBkF04QVaoXG1HpVvzBy1N05C3q/ismOrpTELqNgCC3lhgJLh31Vb0/YUwVn0IyHFboelVvVZ
	dDWu21HMslD6HmOQ0fj2uVT0YxS5E+Ke3J5XVroPYIPTtg5fZ9C1XMQk9+hTJHuCbiU=
X-Google-Smtp-Source: AGHT+IGIQNvIGGvVgVedNnZVWrIPVcdY0I2wfwXm0K8/GqxXMRbR74ywsUQ+naYtcHhgmUOSdy/EvQ==
X-Received: by 2002:a05:6a00:84e:b0:740:6f69:f52a with SMTP id d2e1a72fcca58-7423b3f138dmr8042125b3a.0.1746855949026;
        Fri, 09 May 2025 22:45:49 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237704619sm2589651b3a.20.2025.05.09.22.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 22:45:48 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jayatheerthkulkarni2005@gmail.com
Subject: [PATCH] submodule: prevent overwriting .gitmodules entry on path reuse
Date: Sat, 10 May 2025 11:15:42 +0530
Message-ID: <20250510054542.556401-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.0.533.g80f4e02b4b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a submodule is added at a path that previously hosted another submodule
(e.g., 'child'), Git reuses the submodule name derived from the path and
updates the corresponding entry in .gitmodules. This can silently overwrite
existing configuration if the old submodule was only moved (e.g., to
'child_old') without renaming the submodule.

This patch improves the `module_add()` logic by checking whether the
submodule name already exists in the config but maps to a different path.
In such a case, Git now errors out unless `--force` is specified, thus
preventing accidental overwrites. To proceed safely, the user can provide
a new name via `--name` or use `--force`.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/submodule--helper.c | 45 ++++++++++++++++++++++++++++---------
 t/t7400-submodule-basic.sh  | 23 +++++++++++++++++++
 2 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116dd..0f98ef122b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -32,6 +32,8 @@
 #include "advice.h"
 #include "branch.h"
 #include "list-objects-filter-options.h"
+#include "wildmatch.h"
+
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -3323,6 +3325,23 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
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
 static void configure_added_submodule(struct add_data *add_data)
 {
 	char *key;
@@ -3370,17 +3389,7 @@ static void configure_added_submodule(struct add_data *add_data)
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
@@ -3443,6 +3452,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
 	struct add_data add_data = ADD_DATA_INIT;
 	const char *ref_storage_format = NULL;
+	const struct submodule *existing;
 	char *to_free = NULL;
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
@@ -3546,6 +3556,19 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	if(!add_data.sm_name)
 		add_data.sm_name = add_data.sm_path;
 
+	existing = submodule_from_name(the_repository,
+					null_oid(the_hash_algo),
+					add_data.sm_name);
+
+	if (existing && strcmp(existing->path, add_data.sm_path)) {
+		if (!force) {
+			die(_("submodule name '%s' already used for path '%s' "
+			"(use --name to choose another or --force to overwrite)"),
+			add_data.sm_name, existing->path);
+		}
+		add_data.sm_name = xstrfmt("%s.%s", add_data.sm_name, basename(add_data.sm_path));
+	}
+
 	if (check_submodule_name(add_data.sm_name))
 		die(_("'%s' is not a valid submodule name"), add_data.sm_name);
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d6a501d453..5c3f471338 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1482,4 +1482,27 @@ test_expect_success '`submodule init` and `init.templateDir`' '
 	)
 '
 
+test_expect_success 'submodule add fails when name is reused' '
+	git init test-submodule &&
+	(
+		cd test-submodule &&
+		git commit --allow-empty -m "initial commit" &&
+
+		git init ../child-origin &&
+		git -C ../child-origin commit --allow-empty -m "initial commit" &&
+
+		git submodule add ../child-origin child &&
+		git commit -m "Add submodule child" &&
+
+		git mv child child_old &&
+		git commit -m "Move child to child_old" &&
+
+		# Create another submodule repo
+		git init ../child2-origin &&
+		git -C ../child2-origin commit --allow-empty -m "initial commit" &&
+
+		test_must_fail git submodule add ../child2-origin child
+	)
+'
+
 test_done
-- 
2.49.0.533.g80f4e02b4b

