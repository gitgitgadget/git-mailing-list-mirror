Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C3B2C21CC
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779609; cv=none; b=GXZACSMxZeeiiP/qG04ad/jtnjcwVuvmU/D5cHzNUeqN1UH0l5gzTHWZbt603dFYs4BmM0zEJ83xKFfmQFtyZ6Aq8beEpPM06UiJ39PHadNwXfXOThM33dQM8RDWeVPWYcPcnL6oQoZffaVhEMqkbB/9/dIVeyJ0+d/FlYuSoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779609; c=relaxed/simple;
	bh=KAKsekaDzZV1URcFERNV5WOFKu2P+U2W9KO3kJvLsoI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=svQvbI/o7BBkZDmlJN9JfVgn/hIZjJpBbev2Ncu0inggMA0P3zs/C9uQGlNvdMJDqpB4CaaT+x/z1Hfn7O1RPlSyZLI8+AfVtWCP2eMn22ctjK1hdx3fLCKF30SNW0yGLpA4yNz1o/zLOgdHwxA9PBP4T+56NU4XdWmSPqk0PhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eksz+tmZ; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eksz+tmZ"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40418578e28so764410fac.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 05:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769779606; x=1770384406; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0haXv2jVhVVKaWlM4SwuMSENQUsKycukh9hVqwrIxA=;
        b=Eksz+tmZeDDlMfjMzrrH/3p5/YvHBG/1QLWMvORPKg3kEb+co/hhnZKLVBx1OPrNjR
         MkidKz+z0Gol666Iah3Q+hX5gjWmRbEBWKU86vCjpWFtkOyeq6UBeoTdBW0NboH3LhMw
         AncBYgS7yfRxb1O3Eb0JMEb5MP8M5k//i0LJGBabgUnaNSWrOzLugrwT9AAxqUAt1wqf
         BBM3ivo81T9tluGtJo2m8AHSNa/TI/eC9AHE9dMgCVZ7LTBkMAurG3VN4iVr63ALeQxd
         udzvXfkSNHndYyV9QVnXGLjC0NlqUvgV8w7uOKiiZNUIr5ZDmC6NWIQtOD7+CfQHhLzq
         xsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769779606; x=1770384406;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h0haXv2jVhVVKaWlM4SwuMSENQUsKycukh9hVqwrIxA=;
        b=HD8kZqXQfi0zNi6Fg1nF1wHoaaflI+vg9o/+M6WrfWe77TReGOW8UkA2xo0B8sDsS0
         0x5Uu1wE7JsyudXCxGpqa4kFyGa4zVpIKbLaVz0rrFWuR2CNzDWozMWxJXSpKythQpVK
         V8kXF3UUf6mDJ1KKhiD9l+OFukul7NW4QTpcOBIc+8ztTm2dsRNuCxij8UwutOJj6CGV
         RKQWlTT0frZUA7s1+aWG7q9xTp4EZMK1fCXX82rIKA/4fsW6Ki1N+BfyOCb6W8E5j1+7
         PXLpQ1RG1DZ9Th5ALcZuTo8IT35jbMc4E3oAlOxPZCHMP0qzkug4WZmjXbEBRl3tFdHa
         NP+A==
X-Gm-Message-State: AOJu0YwoNWOVAA+QaERymCOt45NM6JMvWv7RvxWYxaTsy8mak9sZZIsA
	sGix8U3ksqqgR1AoG9dm4+7zqj9Y/lhbecurvwOodFOGCi0hvoFGsFEKIdb3nw==
X-Gm-Gg: AZuq6aI792uvZC810qvBTqeYbX8FoT1QUe6d9AukJxD6GT58M6l2yELODhVRPIhc1I3
	RgHrc0bWDP6XZChSYbFTDItHiohgU22qNd6Pf6pumyAayFKihPXNV4mzTaLdu4EzeTD5Z4C/snO
	juqNwlghnj/+ka4ukpC38Uf0vMBTcQ+i3IUyYC7SHyQtiMzaVWmG7OC/f94+1VYVyfiyHt+qem1
	Uhor54zdCHbfl3go5Q8yFxohizmec3G8L4C5DnCYJRutN4RpymOIOaxZRUR9SAZFw2mU6ddGrb3
	xEWB4kWgCk2gqYQVf2oROt9GYc3J0/BaLdOihIA/dtm5EA+pTIn07zFO/hgB4dU0PY2rxCYC0+F
	lfdCPLP1LwUVLKB7q58QWhsbSNZVPQfgZTAzmSQD4f7KAjOtA/x5SRs+2So6vOIV7XEeyr07PF6
	GjDMaulj1661E+NA==
X-Received: by 2002:a05:6870:204a:b0:404:23a5:1891 with SMTP id 586e51a60fabf-409a6f9d2a8mr1568919fac.44.1769779601375;
        Fri, 30 Jan 2026 05:26:41 -0800 (PST)
Received: from [127.0.0.1] ([52.154.130.216])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4095749f19esm5714140fac.13.2026.01.30.05.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 05:26:39 -0800 (PST)
Message-Id: <pull.2183.v2.git.git.1769779599196.gitgitgadget@gmail.com>
In-Reply-To: <pull.2183.git.git.1769700352081.gitgitgadget@gmail.com>
References: <pull.2183.git.git.1769700352081.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Jan 2026 13:26:39 +0000
Subject: [PATCH v2] revisions: add @{default} shorthand for default branch
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Git already has shorthands like @{upstream} and @{push} to refer to
tracking branches, but there is no convenient way to refer to the
default branch of a repository (typically "main" or "master").

Users often want to switch to the default branch regardless of its
name, especially when working across repositories with different
default branch names. Currently they must either hardcode the branch
name or query it via configuration, which is cumbersome.

Add a new @{default} shorthand that resolves to the default branch
as determined by init.defaultBranch (or falls back to "main" or
"master" depending on Git version). This allows users to write:

  git checkout @{default}

instead of having to know or look up the default branch name.

The implementation follows the same pattern as @{upstream} and @{push},
using a new branch_get_default() function that queries the default
branch name and verifies it exists in the repository.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    revisions: add @{default} shorthand for default branch

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2183%2FHaraldNordgren%2Fdefault_shorthand-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2183/HaraldNordgren/default_shorthand-v2
Pull-Request: https://github.com/git/git/pull/2183

Range-diff vs v1:

 1:  72b75e106d ! 1:  abe0f0c2b7 revisions: add @{default} shorthand for default branch
     @@ object-name.c: int repo_interpret_branch_name(struct repository *r,
       		if (len > 0)
       			return len;
      +
     ++		if (default_mark(at, namelen - (at - name))) {
     ++			if (at - name > 0)
     ++				return -1;
     ++		}
     ++
      +		len = interpret_branch_mark(r, name, namelen, at - name, buf,
      +					    default_mark, branch_get_default_mark,
      +					    options);
     @@ t/t1508-at-combinations.sh: check "@{-1}@{u}" ref refs/heads/main
       check "@@/at-test" ref refs/heads/@@/at-test
       test_have_prereq MINGW ||
       check "@/at-test" ref refs/heads/@/at-test
     +@@ t/t1508-at-combinations.sh: nonsense "@{0}@{0}"
     + nonsense "@{1}@{u}"
     + nonsense "HEAD@{-1}"
     + nonsense "@{-1}@{-1}"
     ++nonsense "new-branch@{default}"
     + 
     + # @{N} versus HEAD@{N}
     + 
      
       ## t/t2012-checkout-last.sh ##
      @@ t/t2012-checkout-last.sh: test_cmp_symbolic_HEAD_ref () {


 Documentation/revisions.adoc | 17 +++++++++++++++++
 object-name.c                | 26 +++++++++++++++++++++++++-
 remote.c                     | 12 ++++++++++++
 remote.h                     |  6 ++++++
 t/t1508-at-combinations.sh   |  2 ++
 t/t2012-checkout-last.sh     |  6 ++++++
 6 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.adoc b/Documentation/revisions.adoc
index 6ea6c7cead..17bf42765f 100644
--- a/Documentation/revisions.adoc
+++ b/Documentation/revisions.adoc
@@ -149,6 +149,23 @@ from one location and push to another. In a non-triangular workflow,
 This suffix is also accepted when spelled in uppercase, and means the same
 thing no matter the case.
 
+'@\{default\}'::
+  The suffix '@\{default}' refers to the default branch of the repository,
+  typically `main` or `master`. This is determined by the `init.defaultBranch`
+  configuration option, or falls back to `main` (or `master` in older Git
+  versions) if not configured. The default branch must exist in the repository
+  for this syntax to work.
++
+Here's an example:
++
+------------------------------
+$ git checkout @{default}
+Switched to branch 'main'
+
+$ git rev-parse --symbolic-full-name @{default}
+refs/heads/main
+------------------------------
+
 '<rev>{caret}[<n>]', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
diff --git a/object-name.c b/object-name.c
index 8b862c124e..254705d1b0 100644
--- a/object-name.c
+++ b/object-name.c
@@ -947,6 +947,12 @@ static inline int push_mark(const char *string, int len)
 	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
 }
 
+static inline int default_mark(const char *string, int len)
+{
+	const char *suffix[] = { "@{default}" };
+	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
+}
+
 static enum get_oid_result get_oid_1(struct repository *r, const char *name, int len, struct object_id *oid, unsigned lookup_flags);
 static int interpret_nth_prior_checkout(struct repository *r, const char *name, int namelen, struct strbuf *buf);
 
@@ -998,7 +1004,8 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 					continue;
 				}
 				if (!upstream_mark(str + at, len - at) &&
-				    !push_mark(str + at, len - at)) {
+				    !push_mark(str + at, len - at) &&
+				    !default_mark(str + at, len - at)) {
 					reflog_len = (len-1) - (at+2);
 					len = at;
 				}
@@ -1707,6 +1714,12 @@ static int branch_interpret_allowed(const char *refname, unsigned allowed)
 	return 0;
 }
 
+static const char *branch_get_default_mark(struct branch *branch UNUSED,
+					   struct strbuf *err UNUSED)
+{
+	return branch_get_default_ref();
+}
+
 static int interpret_branch_mark(struct repository *r,
 				 const char *name, int namelen,
 				 int at, struct strbuf *buf,
@@ -1798,6 +1811,17 @@ int repo_interpret_branch_name(struct repository *r,
 					    options);
 		if (len > 0)
 			return len;
+
+		if (default_mark(at, namelen - (at - name))) {
+			if (at - name > 0)
+				return -1;
+		}
+
+		len = interpret_branch_mark(r, name, namelen, at - name, buf,
+					    default_mark, branch_get_default_mark,
+					    options);
+		if (len > 0)
+			return len;
 	}
 
 	return -1;
diff --git a/remote.c b/remote.c
index b756ff6f15..2c829c8c34 100644
--- a/remote.c
+++ b/remote.c
@@ -1961,6 +1961,18 @@ const char *branch_get_push(struct branch *branch, struct strbuf *err)
 	return branch->push_tracking_ref;
 }
 
+const char *branch_get_default_ref(void)
+{
+	static struct strbuf default_ref = STRBUF_INIT;
+	char *default_branch_name;
+
+	strbuf_reset(&default_ref);
+	default_branch_name = repo_default_branch_name(the_repository, 1);
+	strbuf_addf(&default_ref, "refs/heads/%s", default_branch_name);
+	free(default_branch_name);
+	return default_ref.buf;
+}
+
 static int ignore_symref_update(const char *refname, struct strbuf *scratch)
 {
 	return !refs_read_symbolic_ref(get_main_ref_store(the_repository), refname, scratch);
diff --git a/remote.h b/remote.h
index 0ca399e183..5ebb27e173 100644
--- a/remote.h
+++ b/remote.h
@@ -366,6 +366,12 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err);
  */
 const char *branch_get_push(struct branch *branch, struct strbuf *err);
 
+/**
+ * Return the fully-qualified refname of the default branch.
+ * I.e., what "@{default}" would give you.
+ */
+const char *branch_get_default_ref(void);
+
 /* Flags to match_refs. */
 enum match_refs_flags {
 	MATCH_REFS_NONE		= 0,
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 87a4286414..ff9f8e90cb 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -69,6 +69,7 @@ check "@{-1}@{u}" ref refs/heads/main
 check "@{-1}@{u}@{1}" commit main-one
 check "@" commit new-two
 check "@@{u}" ref refs/heads/upstream-branch
+check "@{default}" ref refs/heads/main
 check "@@/at-test" ref refs/heads/@@/at-test
 test_have_prereq MINGW ||
 check "@/at-test" ref refs/heads/@/at-test
@@ -78,6 +79,7 @@ nonsense "@{0}@{0}"
 nonsense "@{1}@{u}"
 nonsense "HEAD@{-1}"
 nonsense "@{-1}@{-1}"
+nonsense "new-branch@{default}"
 
 # @{N} versus HEAD@{N}
 
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index 1f6c4ed042..59999f0852 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -27,6 +27,12 @@ test_cmp_symbolic_HEAD_ref () {
 	test_cmp expect actual
 }
 
+test_expect_success '"checkout @{default}" switches to default branch' '
+	git checkout @{default} &&
+	test_cmp_symbolic_HEAD_ref main &&
+	git checkout other
+'
+
 test_expect_success '"checkout -" switches back' '
 	git checkout - &&
 	test_cmp_symbolic_HEAD_ref main

base-commit: ea717645d199f6f1b66058886475db3e8c9330e9
-- 
gitgitgadget
