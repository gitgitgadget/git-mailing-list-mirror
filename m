Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4284A3F33
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736547; cv=none; b=T7GJ/wYv5541P073JeZKDoLMYrTUbMFjZFpLc/xfy4+APQbPbj5E1KT68dge6CbGb+QiHKof9Y+f529BusWljpsu0/Nz/JsyO7M93PfBqW4fqIltNUdhmQbzN5ckr8M0aztRzdnQaXxspzusWLctuKCvMoH4FgjjtWRj+8ykCCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736547; c=relaxed/simple;
	bh=YPAhU5/LiWkiyr/q8Rd22UKB3ICzg6OmfEsPNdV5gxA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Eq/4fj1LcvByrnBs6vfRKJncebYDAwkCff+YCJhwAOqLezaO0VcZh6rn7ABvR2sWt5TqGufnhmlUlNiMFYA8QAAJQinlXDxRcB2/74knVhSLOEFsssWUyhCtLORcLe9WzGm9BnCDYRU5nXyG+OutZCjaiFvbY4ye4PHui8rhmF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/GmJoiD; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/GmJoiD"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e211a3so633962b3a.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2026 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789736545; x=1790341345; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ViFeLYdy4RMvH02RGXYtSuv/Z0x+JOI3m54KKT/UxFE=;
        b=a/GmJoiDa5uru5q+fje+YqO19uU0MusCM9c7bWGo/4dC3gcEFaco3v64QF7w7BPdam
         syuBi+Lld5t7q6y0dPLQt9wRcF2o2yR8LEOb6+GlC0P5vVHWloQAS3flhT1w1nDb7skO
         8l7XDUqmO/FxbWC33/8t0pVWzq0Wz6oS/1B6CjJc6BwNE676AL7LFxspH1bBLM7uJ5GD
         GLFbPQcAFR7sdk+wmUHY+ksglHM7y0KO/jGfdJtkvonIbx6UZ6ilv8dDpJRL3oRJEpDN
         litoxpY/zehi3m3AGNJdIMvdTMdubA8TXBSOQ7/eviJktp/8NtfLNHoPgIpVh2Lvjl53
         Q4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789736545; x=1790341345;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ViFeLYdy4RMvH02RGXYtSuv/Z0x+JOI3m54KKT/UxFE=;
        b=jys1oqY2A096XR0T0A2xdYcN0IIn/1PMq7cznvrgThWKp2KKueyALfVHhcwK7wR2ha
         nhdy8N3JeW8jBCW9xeEG3LMuMpEa3cME6xFFiYSig95emRJuVQl4KFdHLRU+khMIPYqw
         /aNVATG7WqySygfry9uYSqyablbITCXmsBaoeUJuIZs6Ys35CEpa0BEfLhhUqeyT8A3Z
         05B/O1fRgNwBUGnFdQ6hoMmMsqE0BWmAkbwjYCe9qzngBKLtuncq8fRBhoDc2RdmWgkk
         SUZ0hFiH/iBHBdaChiwWLxTMyP8ozVGp604++ygsTMVksOiErbIIS5ud1jTJWGfmnPVT
         6aHw==
X-Gm-Message-State: AFuF++n6cw6INxebrTfLUbgosc+VEBTMamDCE6flfqdZh3FAiqEnpWgA
	qPN6WYru/CSMSvMDC+ci2spbxcxDupfw1Znc1Hvt5arT00+4G2vAbfhSENdKcQ==
X-Gm-Gg: AYBFou3YscC5p/4JFZe7vXmpHVnUDo3mRZowK+N9v+X1eh497nV5Utl6P+MIzB8VHzA
	xXuvLAVORhR4SCR5Wf6HIoMek9/DSxM9CF3SM9oS2Z6wLn1wCMsx21N7KZMf17cZSWc6S+2VSsD
	Ht9Ih4yM7KJpaZFi3tg9gRdAlS2jBqkN8MyDhQWf+Us6x/r2ExjyqdDMOM7UiXhul1vcEs7mjca
	3YuPr9NKGttLW0VPd5q2u4u9JADWdSCBY81EYUldZ83jI/g+P5nvH3DL7TYMYsIfA0xNki/G9yu
	MCbLd6toOeAGXUHZMdFGd2SxKJuHFCelYR8IoPqAaiWQXigVj3OJN3Ln8TboXbqFbJUKgsmaQqu
	W6csVUVLX71brYaH+soJq81MHQF5zm0YsHDYLjenHJ4rxtrx0XlywBI/3Lbvxek19Xx4AnQtjfM
	2VTEKj3i8vtZwrqW5iek7vy9i3KOYL4JwdqDx3utDJ8SGr0FD9B+6E0leKiiyw3+eCVhsgjAwS
X-Received: by 2002:a05:6a00:909a:b0:86d:7462:4169 with SMTP id d2e1a72fcca58-874dbedf144mr4954403b3a.11.1789736545171;
        Fri, 18 Sep 2026 06:02:25 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.95.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-875dddd77c4sm774271b3a.60.2026.09.18.06.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:02:24 -0700 (PDT)
Message-Id: <8d30730feac37d2cd42c969dca3f33c007c2065e.1789736540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Sep 2026 13:02:16 +0000
Subject: [PATCH 2/6] wrapper: initialize GIT_ALLOC_LIMIT proactively
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
Cc: gitster@pobox.com,
    peff@peff.net,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Before making a safe version of memory_limit_check(), create
initialize_git_alloc_limit() to externalize the static memory limit stored
in that method. Initialize this intentionally during setup_environment()
instead of implicitly during lower-level allocations.

This will allow a future version of memory_limit_check() that doesn't call
die() at all, which will require not calling git_env_ulong() directly. This
comes with some assumption that initialize_git_alloc_limit() is called
before moving into safe APIs, though we will make some reaonable assumptions
in those cases.

The GIT_ALLOC_LIMIT environment variable is used by some tests, but is
otherwise not advertised. It was added by d41489a642 (Add more large blob
test cases, 2012-03-07), which may predate the GIT_TEST_ pattern. This is
long enough that it may be possible that someone depends on it in the wild.
Thus, I'm choosing to document it instead of renaming it to
GIT_TEST_ALLOC_LIMIT.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git.adoc |  6 ++++++
 common-init.c          |  2 ++
 environment.h          |  1 +
 wrapper.c              | 26 +++++++++++++++++---------
 wrapper.h              |  6 ++++++
 5 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 8a5cdd3b3d..07da5c4f12 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -688,6 +688,12 @@ For each path `GIT_EXTERNAL_DIFF` is called, two environment variables,
 
 other
 ~~~~~
+
+`GIT_ALLOC_LIMIT`::
+	A number limiting how much memory can be allocated in a single
+	hunk. This only limits single allocations and does not limit the
+	total memory used by the process.
+
 `GIT_MERGE_VERBOSITY`::
 	A number controlling the amount of output shown by
 	the recursive merge strategy.  Overrides merge.verbosity.
diff --git a/common-init.c b/common-init.c
index d26c9c1f20..bf73c754b4 100644
--- a/common-init.c
+++ b/common-init.c
@@ -39,6 +39,8 @@ static void setup_environment(void)
 	char *git_replace_ref_base;
 	const char *replace_ref_base;
 
+	initialize_git_alloc_limit();
+
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		disable_replace_refs();
 	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
diff --git a/environment.h b/environment.h
index e7ec5b0437..86b67da877 100644
--- a/environment.h
+++ b/environment.h
@@ -5,6 +5,7 @@
 #include "branch.h"
 
 /* Double-check local_repo_env below if you add to this list. */
+#define GIT_ALLOC_LIMIT "GIT_ALLOC_LIMIT"
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
 #define GIT_COMMON_DIR_ENVIRONMENT "GIT_COMMON_DIR"
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
diff --git a/wrapper.c b/wrapper.c
index 561f9ee9c9..3de6b21cc2 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -6,6 +6,7 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
+#include "environment.h"
 #include "parse.h"
 #include "gettext.h"
 #include "strbuf.h"
@@ -18,22 +19,29 @@
 #undef SystemFunction036
 #endif
 
-static int memory_limit_check(size_t size, int gentle)
+static size_t git_alloc_limit = 0;
+
+void initialize_git_alloc_limit(void)
 {
-	static size_t limit = 0;
-	if (!limit) {
-		limit = git_env_ulong("GIT_ALLOC_LIMIT", 0);
-		if (!limit)
-			limit = SIZE_MAX;
+	if (!git_alloc_limit) {
+		git_alloc_limit = git_env_ulong(GIT_ALLOC_LIMIT, 0);
+		if (!git_alloc_limit)
+			git_alloc_limit = SIZE_MAX;
 	}
-	if (size > limit) {
+}
+
+static int memory_limit_check(size_t size, int gentle)
+{
+	initialize_git_alloc_limit();
+
+	if (size > git_alloc_limit) {
 		if (gentle) {
 			error("attempting to allocate %"PRIuMAX" over limit %"PRIuMAX,
-			      (uintmax_t)size, (uintmax_t)limit);
+			      (uintmax_t)size, (uintmax_t)git_alloc_limit);
 			return -1;
 		} else
 			die("attempting to allocate %"PRIuMAX" over limit %"PRIuMAX,
-			    (uintmax_t)size, (uintmax_t)limit);
+			    (uintmax_t)size, (uintmax_t)git_alloc_limit);
 	}
 	return 0;
 }
diff --git a/wrapper.h b/wrapper.h
index a6287d7f4d..69df68ee7a 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -180,4 +180,10 @@ static inline unsigned log2u(uintmax_t sz)
 	return l - 1;
 }
 
+/*
+ * Initialize the global state for GIT_ALLOC_LIMIT at an appropriate
+ * time so it can be effective for safe allocation methods.
+ */
+void initialize_git_alloc_limit(void);
+
 #endif /* WRAPPER_H */
-- 
gitgitgadget

