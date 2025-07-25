Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098272EF2AB
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460662; cv=none; b=VF1/c/9DNfW2Jz1NkA05XQa+ux2qZ8bgJ9ztc1rFYUxynNLDRTpkIFaKZr3IybKjk9cf4Nbo3lYqMCliVB8rwrdo6Bp3eoXO4Gy+5aZApOwI1r6ien8IOwLUJJJKRyvR56Yz72LTjU0SVh5LWdOgw1aOEFLfITxBhSnQEnVgrHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460662; c=relaxed/simple;
	bh=58qFvNIjtgXveTOgSA5MwcnYLzpsBmItwKkVEpCVIho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSJLsxEffINjH0Yr/n/T8LJlbm1xCe2NktE3+BDfUmk55aCeml9E1AiGwdfyTSVUovJzjk5vHtz4JQusS0Y2fAVEHYxBz+EuynST6OyWdhhqKIUvvCNszCzeEwvBXx3WU7LWXdpX6MPI1O5ALVlUbz8gZae3Ic+3Dx8O6QXy6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAaQRCAi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAaQRCAi"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23fb6415a04so5349095ad.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 09:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753460660; x=1754065460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1Hv9JZnPUiRGdOf1R91Z0BFwPb5f2Vdb82ZNlvZBJ4=;
        b=WAaQRCAi52+QmGZhz3Ka90dSseSPGw/FLobDxMCyBB3wb3DPVcXWrA0mRw29DtUmvq
         deZX1KqlVuLlvcIN1c2d50u6qU9NhC8qnGvkgGSwZdyPaxB5wf8TJ9pFGjryZzq5q/sT
         2+x8HagKenz1jPoK6TVdIvsPA6MG0k57XQyvssYhW3clF5zYYCClqtWPIjjQCxtwMeVk
         PFCyFVQB+9qT3jldke57nOfGKflGl/YlhUEFGbtvJQNIBki7GzY20fj+qdiLap39sO0U
         Mwb6vAHGcp2nomFZvTKa7IXx7XuqTA4smtw2ZmIBY7RPCZIFy9ZZuaIYmiBF8vx+Tu9F
         7ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460660; x=1754065460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1Hv9JZnPUiRGdOf1R91Z0BFwPb5f2Vdb82ZNlvZBJ4=;
        b=ml/M3fa/xDky+nKnxZpmFIuq8hh+7JitOFebF8iw2MioAj4Yf6frJP9h19YL5TJHdD
         TFaunol4iK9phy5ueqGW4aGNZzRkCYed8DqCara9hLfjr8ESqN77wXtqx39p/edckKxr
         TcVL0XUQoUq7n9BpXsP8nNbaQK+tNdRqtH0oZN28kbbtYNA0yVrQTJf5TJKf8wneubec
         ZzIeA00PoY+p+XhJ6E4RegifdoyzmYQYXFry8WIGCV47NrWQ1HtNLLffAxBtr6Ya6jGN
         8kF1zsUofCsIFst5xDrMUJXdbEFLAh753IsfCIRCHxwUc9zebMGq104bEDyAYg19lvu2
         emJA==
X-Gm-Message-State: AOJu0YzkFrpzbWVPT89wCbvKzUjlgOQIlyr5FvcyDqGSGlzBzmgfPKUV
	+oZ02kxdJ69jC3lqioG9kIfUg7oOI579VnNiENXmL65ahr7xYW++m9I8
X-Gm-Gg: ASbGncuOq4Z8fSSin66oVi0004B2JUs8oax9istVcT6AKP7CZkqa8JPz86kC48WM6VJ
	AJeS0LYjYdL2O0gJUn/srL/FUco6APCv7dDzbTXlF9T8VPU7LIobnTGBkc4X7H91zAJ7G3AabLw
	FNp5V8MvXYA5EYM3PHEidCn7lC9SMqNMrKCDhMkOXt9Qtfb5adL9/11AGNeEBbvvaqawJGdhJ4D
	LllN26ruLv6e6hEK+bT676X3kXmYHvY7s+B9d3SzcDLNt5/5UOjvSLFZWTdiapxKh9b6Gj08e6C
	I+I2qDqcjFMSli48CtDsgH0BD+dNtOTz4LX142/J2/kcPNmVQo+5y4BHgA70vQ98y/5bgAS91zr
	9QgU3P/Yf1wVvQWeDm0rniKO9CQ7uu7UJlDE=
X-Google-Smtp-Source: AGHT+IEKSnST3bZYU/E4tyTn+X1v6IeB80NyYJplhkUurrYrMz2+T1Zr+mEc1KsB8gouX10gQiuYxg==
X-Received: by 2002:a17:902:da2d:b0:23f:adba:fc5b with SMTP id d9443c01a7336-23fb317bf0cmr45460915ad.49.1753460660303;
        Fri, 25 Jul 2025 09:24:20 -0700 (PDT)
Received: from fedora ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe5740d9sm704335ad.200.2025.07.25.09.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:24:20 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 2/2] submodule: skip redundant active entries when pattern covers path
Date: Fri, 25 Jul 2025 21:54:02 +0530
Message-ID: <20250725162402.92098-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.50.GIT
In-Reply-To: <20250725162402.92098-1-jayatheerthkulkarni2005@gmail.com>
References: <20250724152418.45226-1-jayatheerthkulkarni2005@gmail.com>
 <20250725162402.92098-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

configure_added_submodule always writes an explicit
submodule.<name>.active entry, even when the new
path is already matched by submodule.active
patterns. This leads to unnecessary and cluttered configuration.

change the logic to centralize wildmatch-based pattern lookup,
in configure_added_submodule. Wrap the active-entry write in a conditional
that only fires when that helper reports no existing pattern covers the
submodule’s path.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/submodule--helper.c    | 28 ++++++++++++++++++----------
 t/t7413-submodule-is-active.sh | 15 +++++++++++++++
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9406e732c4..d4c4d9b0e1 100644
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
@@ -3307,7 +3309,8 @@ static void configure_added_submodule(struct add_data *add_data)
 	char *key;
 	struct child_process add_submod = CHILD_PROCESS_INIT;
 	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
-
+	const struct string_list *values;
+	int matched = 0;
 	key = xstrfmt("submodule.%s.url", add_data->sm_name);
 	git_config_set_gently(key, add_data->realrepo);
 	free(key);
@@ -3349,17 +3352,22 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get("submodule.active")) {
+	if (!git_config_get_string_multi("submodule.active", &values)) {
+		/* The key exists and we have its values. Check for a match. */
+		for (size_t i = 0; i < values->nr; i++) {
+			const char *pat = values->items[i].string;
+			if (!wildmatch(pat, add_data->sm_path, 0)) {
+				matched = 1;
+				break;
+			}
+		}
+	}
+
+	if (!matched) {
 		/*
-		 * If the submodule being added isn't already covered by the
-		 * current configured pathspec, set the submodule's active flag
+		 * No pattern matched (or no 'submodule.active' patterns
+		 * were configured at all), so explicitly activate.
 		 */
-		if (!is_submodule_active(the_repository, add_data->sm_path)) {
-			key = xstrfmt("submodule.%s.active", add_data->sm_name);
-			git_config_set_gently(key, "true");
-			free(key);
-		}
-	} else {
 		key = xstrfmt("submodule.%s.active", add_data->sm_name);
 		git_config_set_gently(key, "true");
 		free(key);
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index 9509dc18fd..6fd3b870de 100755
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
+		test_must_fail git config --get submodule.lib/foo.active
+	)
+'
+
 test_done
-- 
2.50.GIT

