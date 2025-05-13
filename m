Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C338D529
	for <git@vger.kernel.org>; Tue, 13 May 2025 03:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747107257; cv=none; b=cTClLzn9HoeKJv/gEzZzTFa4/pzizRuN+qFP4HPg1cqfpcZRzQQ6QWuvIa7FPGWZKsrtB1h817gKTInA3o1cy/wgSFalXlrztdHPtWbmK0sZR6OFZfV/sTU0kwk/gqegZB5PuQxuiIWL5nTZppbUptVlUATa0YAW3wFstq603ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747107257; c=relaxed/simple;
	bh=76iqkD0bvCzmHYE6NdY6rXeDrbMvBvMZ+b6xxNE1a/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOcWYqpLQBw3BXCI9vkUj/JqwNty3oLUOd84Qlv4lEwIBjokaMslAwXA7b1OdvncnaqUgamVowS73NMbFfGP1l0HS8RaEpoJJGZLXp0SMHQgFwppfVABsD9sdxMiwZ3bxzaMi4IYaF8wRadvhT6X+mpfvDZ8q06HiTSISRtxBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGnMZ4t1; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGnMZ4t1"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74068f95d9fso4864846b3a.0
        for <git@vger.kernel.org>; Mon, 12 May 2025 20:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747107255; x=1747712055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vExY60/YWG/ES1gy67Nxy1vaCvVlrrXQZDXt7DN9sDs=;
        b=LGnMZ4t1PV4nKRgig9Eyy+EZbCseEZzwaEeljra+9X+QiIWxkdXqtYGvTtL0uOsi3g
         Kgy9r2IpyYraCoIC+aIlzaHUAQuZL04oBN0l6s3VhV8vd+foIrmvObmEEoYQFntb6JOE
         V1N1upa2XIQTmwy9QZR58tQpJTeiUySKJW5TcmzN/ycp5uzA5q4a1CtdTrxGUPCMbIaN
         84sSNtOFCV2yGYQ2T3bi/9VaeRVJUSow2UqUc+6jmhKJORM6zVz4DjIFQe1A4B58+QuV
         2oW5OC8auxd5bWATBjFGO20Lg7uXfyAIYLtCiX1qGFfr3jvJsamHT+VCBwLPe7Wy97sI
         JzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747107255; x=1747712055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vExY60/YWG/ES1gy67Nxy1vaCvVlrrXQZDXt7DN9sDs=;
        b=WrVABRYC215bgWi4NJN5J+qREP6icCHfK59GK1BIOKy5F94EpjYkPB5hGeKRmyuNn0
         zI1WVhI1NYnyBdQbvflMx1sYtljxhDaS5mvlaexwGanR22uZeNWM9CxQsncR8Y7sK7il
         piFIB51ZlZOLnxQow+QNjJfOYEXMz2K0NDDxxH2C1NG6TiBhr1tynnIw2JfGwQaIVDCJ
         8y2Qf5yZKKVDLlsEL/0JzOwP9z0mlp6bLmOwRSoM3OHE8DuLlPR1UNHjGoubacOpHaM7
         LIDFLCa3Mzz8pDLxy4nfan/yp5k6kq70im8k0QKQ9GXkRWrxEnsuHiZbv6znYfa0ST5E
         GY3A==
X-Gm-Message-State: AOJu0YyDgLiA2M9DUfBsTlRVZsKt4RUuHM1Ea/YwIRG5+bqpXJGXGZzc
	V3e5fGti5t8KEmuYO1l4uUPR/PSUgJJc715P+ABa3NehophzEi4waMt3Fg==
X-Gm-Gg: ASbGncsFD9/HMlIONTf9HJj19hxs+9Pm0HBv40GCdbe01MtJXKonU/ws73eY7sicFre
	HjsonKpJvugaDR1mQQkNNT8TbH187+0I8OvsTMcpYnOqE+jZKqyblFFsFNxV+JhxfNsFZmSJdze
	OF1pxhO7Bykn2LNwXhGwjRnPi5TZ3Ta0K0bhwA0J8UAtgCFBJlyJv/Mw4Hyac8o2Wkbp+2cRbWE
	37ApFu0cTHKq1/o8xXdbdHvDeSmmuykEZL41Wv+shzJRlVPCUcDgAfp9s6U1HxiLvQPdD+8BCHg
	AnhUVbCwYdP+Oq2OtygdY+hae2hFVd2Cg1NPIxgJRDFO/c3whRrs5RNj/KMwIs/Tscg=
X-Google-Smtp-Source: AGHT+IGKtAYbXhRZM0Tzirae5D8ekwC+Au2hK8XhhVaV5LSr1hJdNbY/ppsx58nuBRfPmKYfxI91mQ==
X-Received: by 2002:a05:6a00:2d1b:b0:730:9946:5973 with SMTP id d2e1a72fcca58-7423bc1d6dbmr19557079b3a.5.1747107254553;
        Mon, 12 May 2025 20:34:14 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237704486sm6899542b3a.17.2025.05.12.20.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 20:34:14 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v2] submodule: prevent overwriting .gitmodules entry on path reuse
Date: Tue, 13 May 2025 09:04:03 +0530
Message-ID: <20250513033403.91365-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <CA+rGoLdzT01jLigX=Z+_tw715O0BibgVA+Sj+65Qwee7i5gLfg@mail.gmail.com>
References: <CA+rGoLdzT01jLigX=Z+_tw715O0BibgVA+Sj+65Qwee7i5gLfg@mail.gmail.com>
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
 builtin/submodule--helper.c | 58 ++++++++++++++++++++++++++++++-------
 t/t7400-submodule-basic.sh  | 23 +++++++++++++++
 2 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116dd..e70aa584f1 100644
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
@@ -3546,6 +3556,32 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	if(!add_data.sm_name)
 		add_data.sm_name = add_data.sm_path;
 
+	existing = submodule_from_name(the_repository,
+					null_oid(the_hash_algo),
+					add_data.sm_name);
+
+	if (existing && strcmp(existing->path, add_data.sm_path)) {
+		if (!force)
+			die(_("submodule name '%s' already used for path '%s'"),
+			add_data.sm_name, existing->path);
+
+		/* --force: build <name><n> until unique */
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addstr(&buf, add_data.sm_name);
+
+		for (int i = 1; ; i++) {
+			strbuf_setlen(&buf, 0);
+			strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
+
+			if (!submodule_from_name(the_repository,
+						null_oid(the_hash_algo),
+						buf.buf))
+				break;
+		}
+
+		add_data.sm_name = strbuf_detach(&buf, NULL);
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
2.49.GIT

