Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7C72E091E
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756183927; cv=none; b=Ju7kJXzKaZOAltUG+JCb/20S04dfOevJr5SvDJiyNnyJQoEvZ3oQ+DcouUP8mieQHa9ieO+8ekZFIwt+OvvSE0xBTqMBc41xuO8MhPCj0QPBhwY+ZWAtMUiIepfGQnzJvNPIiKZTJRn8qvzps5pC9yWN8FtV/5KOhmZXUlgmN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756183927; c=relaxed/simple;
	bh=hqSmOWmXXXQ26DMy+p9pD1TO4j5SJ9SYQpexEnJQ4Y4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Z+dapguGED9jCWD64uQhxuvH+2E3Ajudj9iXykvATZ3l+N+e0CBac8zQUSnNOsmvssIOx77Ypfcx6uo/sr1X4fWAx9h9DhQ+NL3XxtiGcaEKzSn9aXLEK2ffG6ATrevzzbOA7F77HwVokrf7TSqMzvYk3moUhAoFwXtczueKxjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXG1PhTs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXG1PhTs"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso44190835e9.3
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 21:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756183923; x=1756788723; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bf9CAH1AW6SLmK9AKV/whDq1MJBJXCqDcSFFNqoHnyY=;
        b=HXG1PhTsyI0C/loyu2basm4ZrPwtK0UFsIYHolVzLvLYC7NuaeDsZk+crtDA4Cmeky
         axdXUO4s7NPfZ9VRO4XPM3Ym7Qpkbhj4+Azw8NACOREETXhXb1OKwLx1585ig4fy1yfM
         PfJ3wItNZ+D/QnN0lHTK4k1xoq4u7VLQDA7SIEi6zZC0xFk9whs9ntS/eDU9gORoB0bY
         kNMY1ICR/43oOhyTJGt9LN3DbNYvg1fW1XltpfuDhCH9nkUFiGDnUGj7aWvN8QjNo2TK
         mhYlQ5hCDrMivyRHqt85yGwmUs5YF9RFFc5qOTDzWQPhzV8jZxxed8qpFeUg6tbT6VaX
         mIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756183923; x=1756788723;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bf9CAH1AW6SLmK9AKV/whDq1MJBJXCqDcSFFNqoHnyY=;
        b=dfGYde5EyCWNenBcd+rPTppY68Ju90aOmbQ8oT/rHBf0SbE/58BszbeSuQen+LcPTo
         fgezRhbyZClWNlTiBVK/t0TUFzHMwQ/4VwfYoJTictGwgc3GzBfqX5buplub1eVhby6v
         IpBk1+s5SfaicksU0i26jS0FvFPIl9NQtH2FdbOyUgvSMOBu+sZ9qP9vAeb7pfPPj1fu
         X7Y9qY/+QJbjLOVlQAccyz7OZLp8MKyWN/pQDJhPIAnDj3W5J/YZP4FS5JOdFQxKJnnE
         fmgM21FFtLtOdVoubCHPnGLxEeXBcF8TL7YNDArXugrpcKeLPzlZaow0q7ls2PB6Z23E
         Odwg==
X-Gm-Message-State: AOJu0YzuUbPlelW1Aypdkd9XJmBq7uogrrhFC4wmo6de8YYGY8AQzqo7
	s4/q3IVtYGB84WCEGHI67YZgTGyf2yXSw3KsG9TjiAcmybCUcP+vGjMfUP+L5g==
X-Gm-Gg: ASbGncvqJ4RHzxyKMmiBvGBv73oFg8kbh3+6PVHrvgETBMo2axyQbOWg/1Dw0mmHujU
	LztYHAgpZlxf+0mPSw6Lw360zFwTyhdGCjI/BLPidWVBfybMikwvRjhjL4gz9tjrvhzHJAIyeIs
	DQIJPUuq/gHuAsVm2HCsT96S45wGtEwRjF+uYGcQxZAFW0Nd9+eoWHIKiAmNYU72kWew0bMdKUI
	oDwnmTvem3wc3fbhzV79CxazOmAIyypEEN5dAPlBKwzMMEPAvWIdJkAjSrH4Fo0Ua3pdCpTFO0Z
	sEgHbcdgAp5q032Tp8ZAJZ3l3/ym/4vb2ep62UYP8mpN+A5XpF+rAO++8WKo4q+0wHU8PXckLz7
	mS631LoeZ9g5fTBL3fGraKzzVn8g=
X-Google-Smtp-Source: AGHT+IERzWaEVaW0NEHyYJ4cN8WyFZZYKI/pNpLnS5gxX67JZpm1m25pgP7CX/PU9Aul9eQbTOCmDg==
X-Received: by 2002:a05:600c:198c:b0:45b:47e1:ef69 with SMTP id 5b1f17b1804b1-45b517e8e28mr106480055e9.36.1756183922985;
        Mon, 25 Aug 2025 21:52:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66c39f72sm6265085e9.2.2025.08.25.21.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 21:52:02 -0700 (PDT)
Message-Id: <pull.1961.git.1756183921623.gitgitgadget@gmail.com>
From: "Wing Huang via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 04:52:01 +0000
Subject: [PATCH] rename default branch from 'master' to 'main' in refs and
 test scripts
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
Cc: Wing Huang <huangsen365@gmail.com>,
    Wing Huang <huangsen365@gmail.com>

From: Wing Huang <huangsen365@gmail.com>

Signed-off-by: Wing Huang <huangsen365@gmail.com>

	modified:   refs.c
	modified:   remote.c
	modified:   t/test-lib.sh
---
    rename default branch from 'master' to 'main' in refs and test scripts
    
    This patch updates Git's default branch name from 'master' to 'main' to
    align with modern naming conventions adopted across the industry.
    
    The change affects only newly initialized repositories and maintains
    full backward compatibility through the existing init.defaultBranch
    configuration option.
    
    Changes made:
    
     * refs.c: Update hardcoded default branch name to 'main'
     * remote.c: Update fallback branch name for remote operations
     * t/test-lib.sh: Update test suite default to 'main'
    
    Compatibility notes:
    
     * Existing repositories are unaffected
     * Users can still set init.defaultBranch=master if preferred
     * The change only applies to new git init operations when no explicit
       branch name is configured
    
    This follows the precedent set when init.defaultBranch configuration was
    introduced in Git 2.28, which already acknowledged the community's move
    toward more inclusive default branch names.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1961%2Fhuangsen365%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1961/huangsen365/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1961

 refs.c        | 2 +-
 remote.c      | 2 +-
 t/test-lib.sh | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 4ff55cf24f6..929e9ce60c6 100644
--- a/refs.c
+++ b/refs.c
@@ -653,7 +653,7 @@ char *repo_default_branch_name(struct repository *r, int quiet)
 		die(_("could not retrieve `%s`"), config_display_key);
 
 	if (!ret) {
-		ret = xstrdup("master");
+		ret = xstrdup("main");
 		if (!quiet)
 			advise_if_enabled(ADVICE_DEFAULT_BRANCH_NAME,
 					  _(default_branch_name_advice), ret);
diff --git a/remote.c b/remote.c
index 81d8fc017e1..ffc4089a1c2 100644
--- a/remote.c
+++ b/remote.c
@@ -2379,7 +2379,7 @@ struct ref *guess_remote_head(const struct ref *head,
 			return copy_ref(r);
 
 		/* Fall back to the hard-coded historical default */
-		r = find_ref_by_name(refs, "refs/heads/master");
+		r = find_ref_by_name(refs, "refs/heads/main");
 		if (r && oideq(&r->old_oid, &head->old_oid))
 			return copy_ref(r);
 	}
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 621cd31ae1d..4e273a6e94d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -129,7 +129,7 @@ fi
 
 # Explicitly set the default branch name for testing, to avoid the
 # transitory "git init" warning under --verbose.
-: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=master}
+: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=main}
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 ################################################################

base-commit: 1fa68948c3d76328236cac73d2adf33c905bd8e3
-- 
gitgitgadget
