Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7EA1DE3D6
	for <git@vger.kernel.org>; Sat, 24 May 2025 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748069342; cv=none; b=gzjYzDoacJUS64lkWPQXkVHWw/GhmioYerWxlWkgQLCFNAcX/C4Pz2BAt/gJ1/U4Uu7ublo2UQpfy3NItdd/pVShwDf+Cv8eLk/qcRH2DD1xkGKtvBKVPtmojlPSjYAUYLLQin3LxWGPKeTZbzps2F5rh2RJfvvn23J7KGax2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748069342; c=relaxed/simple;
	bh=suTvdBi/6Tu2bWT2s9rD8wOX9c37VtLAYS3zHoAmEPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyOIppxN93v8ukciEscPIJea/p38DZ/pdr1Sa+nAQZ5gqwUHLrtmBUYPWtFigckrBAJCEex5p/K/PX8Jm0N7pEP0WAxlTisP9XuvUMk0hjvruj/yAF+uoFzwyIZ3SMafhSTu1RLIklNU4aLOOdIqsKzx/SXTMRkxgOgK8t8PMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHYQmWlh; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHYQmWlh"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30ea7770bd2so713341a91.0
        for <git@vger.kernel.org>; Fri, 23 May 2025 23:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748069340; x=1748674140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xK3BrXFiPkKW2yZc5vpS2YbiE9JkJEFn9rWduXA783g=;
        b=nHYQmWlhXUM15pWeBRhtOOWMRvCkh17sYEgxZciESXp6dscM/MSDpJdymfWhIle3oe
         JrwpAWoLHa6rsfj4NQq1DFqSUyRgcsEE6VZC8iGsgJ9T0Bwv9Z/n+UzmyW4SntGezi7n
         zrIG9o4v90xDSgk9jbkdhgmTH8p9pN9D12SnHJ0dhaH4pV4ql6Awfx6DWoZ7moisT00n
         +zp4e8bciRNdtBgDCzbmfieOOws1Fco5jCnLduu0kKryBP5kfNLBWI5RWc6OsB0rPIAR
         9sk1dy5o2g8jbOKltkIkCIkHo4d8zpmeu5nmyETrDjEffeeAxtX3T06vAZrTzRYJllyb
         TuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748069340; x=1748674140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xK3BrXFiPkKW2yZc5vpS2YbiE9JkJEFn9rWduXA783g=;
        b=nn+Wq7ykp8/gGCUUX15d7YuCKAUJasPhtFPEJqFZVBFkcGq2cqTJEUWWXy2GlczSB/
         +isnWJ1p6AzbqW3zcaMYktrmMgeIl6x/NSQjLa5f8lnt1P/L2NamIcTujJW6ck5xOsaw
         LmNBijk1VRxWdL0ry3qY2PTCopWAhzwwuxk+5+wyRvTT7H4GJootaEp2/KcTN3AHcprn
         ljKfaq2S+tgtdh34duZNATiR8BF7D8Njgr2dadhjhx8K6P7cCltjnHE4p6HZe/umkzIm
         O6B9CThNcQ2pgdI+WmmwQgh6sHaXg8nlrTdS1mjpHkHQjniHhiOfR5GXc47D/icu933l
         JU5Q==
X-Gm-Message-State: AOJu0Yw0HWuZYHSxvIfQuKn88uh3eV5K560uhvIlk2ENd5rBZNWLYulJ
	kxZ29Iy2riOvi8SVYLl9CmpbImCkYRdro/kq4z+JPhqv4q1ZsvqWCfUbUC4dp1NX
X-Gm-Gg: ASbGncs5nbzeHmpy1EdqEz9tsJQoC78fJ3QgbvxHELYVc0yskhkt+O874xnm05wgwqc
	AJGXaij01fhvkfDdaI6eWWSfdTy1sdCgd6D75TjVF1stMTT3OUHldHEM2iMaK++1iqalCLj5Xcp
	ahBGXYs6gsU98lSk12P9KaqnBPPbBAKBjiV9b1o8fx8J87Vp5O6x7S4PiJp+rjoE0NnTAy2Nvtn
	hnmJTkdhQMCPtIFFGkTna1BzE6ZxXQufYbKGcg3UDhFM0q+cGyPTlvLh4E7lECudU2DZZTqmyQM
	3UK/e+4/vUbAP/WwQLhPu5jMecuO1hIX1XtjbBDgDcoXsi50pEQeCOwY9C2pMpeSCSI=
X-Google-Smtp-Source: AGHT+IEgZUpWy9PSKWm7vN6z7VzQ+RKQPMkFNTxOebL+agrHdaH5BA6SFH+gIMlQW2SqeJDAZHMLrg==
X-Received: by 2002:a17:90b:164a:b0:308:65d4:9dda with SMTP id 98e67ed59e1d1-3110f112179mr3223819a91.16.1748069339594;
        Fri, 23 May 2025 23:48:59 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf8e05fsm11862401a12.39.2025.05.23.23.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 23:48:59 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	mlell08@gmail.com
Subject: [PATCH v6 2/2] submodule: skip redundant active entries when pattern covers path
Date: Sat, 24 May 2025 12:18:47 +0530
Message-ID: <20250524064847.51900-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250524064847.51900-1-jayatheerthkulkarni2005@gmail.com>
References: <xmqqsekzjo7g.fsf@gitster.g>
 <20250524064847.51900-1-jayatheerthkulkarni2005@gmail.com>
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

