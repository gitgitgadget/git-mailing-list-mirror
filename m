Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60041760
	for <git@vger.kernel.org>; Fri, 16 May 2025 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417792; cv=none; b=ALiKPEUfK1Dsxc0+qKor89A6gH+gn2ij8GxGOj4A8XUD/07vH04SnauS9UVffVvM6izC3z1Ss48+NaSkmCj/ZTrLf09lmhEDvfTkZsSsM/HXUo7q/nFVu5pAZQt0KPisbGfREkzEqJ8E8XV0LigSWC1nDm8XpIoJodElFzEu8tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417792; c=relaxed/simple;
	bh=VeH35+de9/r77wlWcYSO+N+ashZpeLpq9b3UiCCPkDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAyOumnEqoI7wkrZ0nH3KwVzRYNTc6l8/JmnP+iY4DNzAm0X3+MFejk7s3HtUNCUd1zQ7l6bOQCDQkRdR+iK803bY2MbBHhZUJrwmwFNZO+WbuWtXo73DxgOmgBAdQ+UJg3xB+rc5RIHNAghYTLHwXTbM+t0AjiH1dQNSQQ+GlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvFCNV9j; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvFCNV9j"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so2458775b3a.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 10:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747417790; x=1748022590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnHKn/8BUlnCGuuhI/VDe6k6KzNVy9nR2SmUVZ73s9o=;
        b=CvFCNV9j6J72VHSFrwQFUGc4jyAs7c3hl1vrOo+UGRj/zE0+UVFKYiJEhAwpXa+Lc6
         2uHhd1N8mtPqoo3sI2m9/6kNDsniVeqla8cbJFFmjCvCxz2IIOnQYDGnQPQXWOZ1vwQ6
         DrmfdQN0qH/vZYt1twPugxx/YXDZWOEtJprEgJjq36iD5LJmjNGSRC6eh2svEiyIvM9k
         G/YdZwcU9dlb8MKeoSS7vW6jxOx+WIU3QB70Is4hc5K7kghhdwnDwijTK848E96qwmL4
         IZr/sqDC0jBYULu3AG6FgAJf8BvIMD1dPVEViPjs1omgSrMCnRd7wRaCINIR0nGaw+yk
         BR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747417790; x=1748022590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnHKn/8BUlnCGuuhI/VDe6k6KzNVy9nR2SmUVZ73s9o=;
        b=jFoLLDFL6ulpRgJwF7u+Rhae2o/S6ljp6Bv5SI1OHPeLM99SBYjkUF+sttexVoNIWs
         p7Qe/lXK6WEAnsHsLyY77AFe7fs3ZehCX5+NATacI1YoymGhvHh7Qm+F9/4jBHz8Ohn5
         n4lStG68hYNC3ZCiWYG0P4VeHLLTHS7bxTjho2AddyXDJvQH/Y6IUryjHTgQdsZWAhvD
         X7wWlHj2W0stceXGpnYDinRcNxFpdcp1iJ3CLe2tAsgt3LMLX1AwY/Q6tLVLaKSFetcQ
         6NtZZAYmHP315I4efFbzxS+zQklodf2cIvE3+ZdpSQorA/7u9m+qgr0ImAvcIzmfYM2K
         eD0g==
X-Gm-Message-State: AOJu0YzlVV26Pnqd+6yOHCwqAjJH0mn54uPydCQUX9KASbP6q5zNU5mZ
	9VNbONOz5QuhsyzFofJC7/HoRj+cqJeRjAPNXAe49ZlfacnUp86Tx8JwyLXfF56q
X-Gm-Gg: ASbGncvLCi9H1QGraW9xxi/xSuHQTYxxVVEA6e1KvipaiFZT9ueSOk/wkleH8nTACIz
	91n38s0g0P6CV9y43mU1GfgrzWYLds29Y+ez2vtn65bMkWdoNqOXFLYURtCZtBHdAOBRgWYC9ZF
	nSEpAxADT/iC0vBMpjOFJUEHXYBQHlBx/czmXyafUUu2HFX6Dp0qKCS4yDJEnyJqzNssVP7yjd4
	4aL7uH4n2uVh/YREubD4dRvrTIlBMRBi5uCvvUDsjxWgESclfdTrAehFR4I7VPbQACquvM8ze2Z
	b/NTrrerNzgwdslo7AAqDjTjm5NwLsTLih/eND1B7ABwluBwsKKbMRMiqet6RF3IzSo=
X-Google-Smtp-Source: AGHT+IFeXbPLyZrWS7nRyTEpD+hNzyA3J4CDvkVoOmEn/wfAnbYCghQXCTS2+n+iDrqgOHsAWarS1A==
X-Received: by 2002:a05:6a00:2288:b0:740:5977:7efd with SMTP id d2e1a72fcca58-742a97eb55fmr6239146b3a.13.1747417789568;
        Fri, 16 May 2025 10:49:49 -0700 (PDT)
Received: from fedora.. ([2409:40f0:41:81bb:63e2:a167:6132:4460])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970bd2asm1799350b3a.44.2025.05.16.10.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 10:49:49 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	Moritz <mlell08@gmail.com>
Subject: [PATCH v4] submodule: prevent overwriting .gitmodules entry on path reuse
Date: Fri, 16 May 2025 23:19:34 +0530
Message-ID: <20250516174934.45008-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <CA+rGoLfYLcx+tM6nif7E5vZDce7PeGyGJkTRraT7kF3ACAzBfA@mail.gmail.com>
References: <CA+rGoLfYLcx+tM6nif7E5vZDce7PeGyGJkTRraT7kF3ACAzBfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding a submodule, Git may write `submodule.<name>.active = true`
to the repository configuration to explicitly mark the submodule as active.
However, if the submodule's path is already matched by a pattern in the
`submodule.active` setting, this explicit entry is redundant.

This change inlines the logic, using `wildmatch()` to check if
the added submodule path is already covered by one of the patterns defined
in `submodule.active`.

If the path matches any pattern, Git now avoids writing the
`submodule.<name>.active` entry. This prevents unnecessary configuration
bloat and aligns the behavior with user expectations when using
pattern-based submodule activation.

Reported-by: Moritz <mlell08@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/submodule--helper.c | 59 ++++++++++++++++++++++++++++++-------
 t/t7400-submodule-basic.sh  | 23 +++++++++++++++
 2 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116dd..5a9c8bdc0c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -32,6 +32,8 @@
 #include "advice.h"
 #include "branch.h"
 #include "list-objects-filter-options.h"
+#include "strbuf.h"
+#include "wildmatch.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -3328,6 +3330,9 @@ static void configure_added_submodule(struct add_data *add_data)
 	char *key;
 	struct child_process add_submod = CHILD_PROCESS_INIT;
 	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
+	const struct string_list *values;
+	size_t i;
+	int matched = 0;
 
 	key = xstrfmt("submodule.%s.url", add_data->sm_name);
 	git_config_set_gently(key, add_data->realrepo);
@@ -3370,20 +3375,25 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get("submodule.active")) {
-		/*
-		 * If the submodule being added isn't already covered by the
-		 * current configured pathspec, set the submodule's active flag
-		 */
-		if (!is_submodule_active(the_repository, add_data->sm_path)) {
+	if (git_config_get("submodule.active") || /* key absent */
+	   git_config_get_string_multi("submodule.active", &values)) {
+		/* submodule.active is missing -> force-enable */
+		key = xstrfmt("submodule.%s.active", add_data->sm_name);
+		git_config_set_gently(key, "true");
+		free(key);
+	} else {
+		for (i = 0; i < values->nr; i++) {
+			const char *pat = values->items[i].string;
+			if (!wildmatch(pat, add_data->sm_path, 0)) { /* match found */
+				matched = 1;
+				break;
+			}
+		}
+		if (!matched) { /* no pattern matched -> force-enable */
 			key = xstrfmt("submodule.%s.active", add_data->sm_name);
 			git_config_set_gently(key, "true");
 			free(key);
 		}
-	} else {
-		key = xstrfmt("submodule.%s.active", add_data->sm_name);
-		git_config_set_gently(key, "true");
-		free(key);
 	}
 }
 
@@ -3443,7 +3453,11 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
 	struct add_data add_data = ADD_DATA_INIT;
 	const char *ref_storage_format = NULL;
+	const struct submodule *existing;
 	char *to_free = NULL;
+	struct strbuf buf = STRBUF_INIT;
+	int i;
+	char *sm_name_to_free = NULL;
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
 			   N_("branch of repository to add as submodule")),
@@ -3546,6 +3560,30 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	if(!add_data.sm_name)
 		add_data.sm_name = add_data.sm_path;
 
+	existing = submodule_from_name(the_repository,
+					null_oid(the_hash_algo),
+					add_data.sm_name);
+
+	if (existing && strcmp(existing->path, add_data.sm_path)) {
+		if (!force) {
+			die(_("submodule name '%s' already used for path '%s'"),
+			add_data.sm_name, existing->path);
+		}
+
+		/* --force: build <name><n> until unique */
+		for (i = 1; ; i++) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
+			if (!submodule_from_name(the_repository,
+						null_oid(the_hash_algo),
+						buf.buf)) {
+				break;
+			}
+		}
+
+		add_data.sm_name = sm_name_to_free = strbuf_detach(&buf, NULL);
+	}
+
 	if (check_submodule_name(add_data.sm_name))
 		die(_("'%s' is not a valid submodule name"), add_data.sm_name);
 
@@ -3561,6 +3599,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
 
 	ret = 0;
 cleanup:
+	free(sm_name_to_free);
 	free(add_data.sm_path);
 	free(to_free);
 	strbuf_release(&sb);
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

