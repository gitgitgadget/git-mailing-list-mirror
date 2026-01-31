Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3505C2C86D
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769817992; cv=none; b=tq6KJDOUnGS4XrCN5UuXsI8titnPKxAPwgZcDyjtGG/WP568ZDk7Csn3Cy7Q5UfzvImpwkGA2+0YKd5IBbe+JKNh6fXK5o8CH9QbnZd+sc7jCukX2S6epP0LX+MDvp2DvIOxFtS67gr7G5D9uE1ZgN6vmQpbbAcLMUTMCg1QiPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769817992; c=relaxed/simple;
	bh=ZXvXAyORNG/O474ukfYiENjBCf7vg59H9c1J3aqctDE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GFpPyVF+Y8652ctgtm4TiZ5zQTHB3i2xXSw16U6KhJTlBQDnsTEMTPqTmbIggT4pKfCH1lPWoIduloIbN6CEcai4dF2jmpqLXwENEFPkM1T/Zu/LUqhoJbsX8pbZqTSNzudzRstjSVvLFs4V8+9k9uRjYlHEyLrMBZSGcm5NHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0D9Erqu; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0D9Erqu"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c6a7638f42so377602485a.2
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 16:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769817989; x=1770422789; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIhPmxKXwv9syBOIpdSP8Uu2JQkyCqRJmw6i+J+0JpQ=;
        b=H0D9ErquAJwyFtYyT8Dyl0qMiohF5EADpDpTVHqDs/JLJ15raNq+8E7pZ8zap12yP0
         FwRcLeOMRXNZ0gheGUEu/NXIfGbXpHIFZP4AqNlPTltAms95bLobsQqKfc5gKT29ByXh
         CiqTFMgJTPKJ0+l9+LiyyrYIB0QVPtltDm0sQWLkzrcnRI7nvvXr39hmYutMEQGpb0r8
         1riu+5/XmBACCz45kJ3KmoEWVwCI9aB4PW/SZp0/iFvwEh8CRGnG9rmUrKwviHkE4Dox
         PbBvRgtc4EqFLiinzZsKEXKMWBTZ320JglCE2uT2AZU6UFh67UUakccea0SAHJMdaTAq
         +F6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769817989; x=1770422789;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PIhPmxKXwv9syBOIpdSP8Uu2JQkyCqRJmw6i+J+0JpQ=;
        b=mYSBxlRiYlPUNAcbWym+qPeBoUCGa+ACbzbaz8sOlbKViD855iCIEqcNxB7t3sjo0q
         zFTRS50JWH9tEbxpV281Al5tvlZDgDKHk75efawYjpaICL+XtZm/44iOGHJO8mH38zYc
         1tJf4eal29x88C1OCD+KG/BVyIE9sMH46kCdjAonackSU2kU5715165xlhaTYzvHwNzX
         WkdRcRsC3H1/7qfK409dx+MsBvfpKfvV5T95dBqqknFYHCvOUUxh7Fei59Psjm0ukWxW
         fJawaU6/3hUZPiORToGfUW+7G8nS2MPzqme9+4uJi729w8Uido5P5IVDpBgLymLc2zM2
         ejTw==
X-Gm-Message-State: AOJu0YwFedzFLJjIL5U8jll4mLCx3WFy9JZWOgEyPoyGzUaHTSMyYCw6
	uitacS0RyxnckXxLYYVJduKlFxG0E1vp8HJE+mKmQIZXT4EGZPL15Lp7TP6Tbw==
X-Gm-Gg: AZuq6aJPg13xwo2GJ+KvdwalmP6vUF9LHv4tG1ruhj/yBUHnve+cCCUuFYld71fcA2L
	L9fbBwVh0MyRNBWACWJVHjDQlFOfv4CKcxsUTefx2p4cqiGtf4BBiilfBDXJ/nMZxT6zpgR7cmy
	WCuW6oRteM8y0OWjbmmCWPK2gjGlrpZ09ALu+GGiwcZ+aj0h43Qws9CjfqxFMnM8a0abm6CVaGl
	sYztCWmrNl/a4kU0n8SaYkrH1/XG5uBABvfk1scVekLy1b/5bOYoF70RMWGze/HsANAPhKmUT7j
	bCwUqUNYGoZUB1za8aJeghVmTMOvoO9pwe2rKQghUVI+R64ddMiXSJ4oEUzdCROYdou3pPAnIlq
	7NL/MAzi3wyK7Pc6wX1eILnYN3IwNzAhUv2CyGT5m1IFaVj3zQGub1pf+JZfJRAS7v2mmVhLxT1
	9DBOG5NqmUb1+6eQ==
X-Received: by 2002:a05:620a:690d:b0:8b2:e069:6911 with SMTP id af79cd13be357-8c9eb2e84a3mr718247585a.59.1769817988603;
        Fri, 30 Jan 2026 16:06:28 -0800 (PST)
Received: from [127.0.0.1] ([172.178.119.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376e0d8sm67616106d6.53.2026.01.30.16.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 16:06:28 -0800 (PST)
Message-Id: <pull.2183.v4.git.git.1769817987594.gitgitgadget@gmail.com>
In-Reply-To: <pull.2183.v3.git.git.1769805948018.gitgitgadget@gmail.com>
References: <pull.2183.v3.git.git.1769805948018.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 31 Jan 2026 00:06:27 +0000
Subject: [PATCH v4] revisions: add @{primary} shorthand for primary branch
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
primary branch of a repository (typically "main" or "master").

Users often want to switch to the primary branch regardless of its
name, especially when working across repositories with different
primary branch names. Currently they must either hardcode the branch
name or query it via configuration, which is cumbersome.

Add a new @{primary} shorthand that resolves to the primary branch
as determined by init.defaultBranch (or falls back to "main" or
"master" depending on Git version). This allows users to write:

  git checkout @{primary}

instead of having to know or look up the primary branch name.

The implementation follows the same pattern as @{upstream} and @{push},
using a new branch_get_primary_ref() function that queries the primary
branch name and verifies it exists in the repository.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    revisions: add @{default} shorthand for default branch
    
    cc: "Kristoffer Haugsbakk" kristofferhaugsbakk@fastmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2183%2FHaraldNordgren%2Fdefault_shorthand-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2183/HaraldNordgren/default_shorthand-v4
Pull-Request: https://github.com/git/git/pull/2183

Range-diff vs v3:

 1:  0fc9eb75ea ! 1:  cfad3c3197 revisions: add @{primary} shorthand for primary branch
     @@ object-name.c: static int branch_interpret_allowed(const char *refname, unsigned
      +static const char *branch_get_primary_mark(struct branch *branch,
      +					   struct strbuf *err)
      +{
     -+	return branch_get_primary_ref(branch, err);
     ++	return branch_get_upstream_options(branch, err, 1);
      +}
      +
       static int interpret_branch_mark(struct repository *r,
     @@ remote.c: const char *branch_get_upstream(struct branch *branch, struct strbuf *
       }
       
       static const char *tracking_for_push_dest(struct remote *remote,
     -@@ remote.c: const char *branch_get_push(struct branch *branch, struct strbuf *err)
     - 	return branch->push_tracking_ref;
     - }
     - 
     -+const char *branch_get_primary_ref(struct branch *branch, struct strbuf *err)
     -+{
     -+	return branch_get_upstream_options(branch, err, 1);
     -+}
     -+
     - static int ignore_symref_update(const char *refname, struct strbuf *scratch)
     - {
     - 	return !refs_read_symbolic_ref(get_main_ref_store(the_repository), refname, scratch);
      
       ## remote.h ##
      @@ remote.h: int branch_has_merge_config(struct branch *branch);
     @@ remote.h: int branch_has_merge_config(struct branch *branch);
       /**
        * Return the fully-qualified refname of the tracking branch for `branch`.
        * I.e., what "branch@{upstream}" would give you. Returns NULL if no
     -@@ remote.h: const char *branch_get_upstream(struct branch *branch, struct strbuf *err);
     -  */
     - const char *branch_get_push(struct branch *branch, struct strbuf *err);
     - 
     -+/**
     -+ * Return the fully-qualified refname of the primary branch.
     -+ * I.e., what "@{primary}" would give you.
     -+ */
     -+const char *branch_get_primary_ref(struct branch *branch, struct strbuf *err);
     -+
     - /* Flags to match_refs. */
     - enum match_refs_flags {
     - 	MATCH_REFS_NONE		= 0,
      
       ## t/t1507-rev-parse-upstream.sh ##
      @@ t/t1507-rev-parse-upstream.sh: test_expect_success 'log -g other@{u}@{now}' '
     @@ t/t6040-tracking-info.sh: test_expect_success 'checkout (up-to-date with upstrea
       	test_grep "Your branch is up to date with .origin/main" actual
       '
       
     -+test_expect_success 'checkout @{primary} (up-to-date with upstream)' '
     ++test_expect_success 'checkout @{primary} same as checkout main' '
      +	(
      +		cd test &&
      +		git checkout b6 &&
     @@ t/t6040-tracking-info.sh: test_expect_success 'checkout (up-to-date with upstrea
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'status from @{primary} (up-to-date with upstream)' '
     ++test_expect_success 'status from @{primary} same as status from main' '
      +	(
      +		cd test &&
      +		git checkout @{primary} &&


 Documentation/revisions.adoc  | 17 +++++++++++++++++
 object-name.c                 | 21 ++++++++++++++++++++-
 remote.c                      | 22 ++++++++++++++++++++--
 remote.h                      |  3 +++
 t/t1507-rev-parse-upstream.sh |  6 ++++++
 t/t1508-at-combinations.sh    |  1 +
 t/t6040-tracking-info.sh      | 27 +++++++++++++++++++++++++++
 7 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/Documentation/revisions.adoc b/Documentation/revisions.adoc
index 6ea6c7cead..d5c98bfdb1 100644
--- a/Documentation/revisions.adoc
+++ b/Documentation/revisions.adoc
@@ -149,6 +149,23 @@ from one location and push to another. In a non-triangular workflow,
 This suffix is also accepted when spelled in uppercase, and means the same
 thing no matter the case.
 
+'@\{primary\}'::
+  The suffix '@\{primary}' refers to the primary branch of the repository,
+  typically `main` or `master`. This is determined by the `init.defaultBranch`
+  configuration option, or falls back to `main` (or `master` in older Git
+  versions) if not configured. The primary branch must exist in the repository
+  for this syntax to work.
++
+Here's an example:
++
+------------------------------
+$ git checkout @{primary}
+Switched to branch 'main'
+
+$ git rev-parse --symbolic-full-name @{primary}
+refs/heads/main
+------------------------------
+
 '<rev>{caret}[<n>]', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
diff --git a/object-name.c b/object-name.c
index 8b862c124e..6d38df2f08 100644
--- a/object-name.c
+++ b/object-name.c
@@ -947,6 +947,12 @@ static inline int push_mark(const char *string, int len)
 	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
 }
 
+static inline int primary_mark(const char *string, int len)
+{
+	const char *suffix[] = { "@{primary}" };
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
+				    !primary_mark(str + at, len - at)) {
 					reflog_len = (len-1) - (at+2);
 					len = at;
 				}
@@ -1707,6 +1714,12 @@ static int branch_interpret_allowed(const char *refname, unsigned allowed)
 	return 0;
 }
 
+static const char *branch_get_primary_mark(struct branch *branch,
+					   struct strbuf *err)
+{
+	return branch_get_upstream_options(branch, err, 1);
+}
+
 static int interpret_branch_mark(struct repository *r,
 				 const char *name, int namelen,
 				 int at, struct strbuf *buf,
@@ -1798,6 +1811,12 @@ int repo_interpret_branch_name(struct repository *r,
 					    options);
 		if (len > 0)
 			return len;
+
+		len = interpret_branch_mark(r, name, namelen, at - name, buf,
+					    primary_mark, branch_get_primary_mark,
+					    options);
+		if (len > 0)
+			return len;
 	}
 
 	return -1;
diff --git a/remote.c b/remote.c
index b756ff6f15..2316dfea07 100644
--- a/remote.c
+++ b/remote.c
@@ -1842,8 +1842,12 @@ static const char *error_buf(struct strbuf *err, const char *fmt, ...)
 	return NULL;
 }
 
-const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
+const char *branch_get_upstream_options(struct branch *branch, struct strbuf *err,
+					int omit_remote)
 {
+	static struct strbuf upstream_branch_buf = STRBUF_INIT;
+	const char *dst;
+
 	if (!branch)
 		return error_buf(err, _("HEAD does not point to a branch"));
 
@@ -1866,7 +1870,21 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 				 _("upstream branch '%s' not stored as a remote-tracking branch"),
 				 branch->merge[0]->src);
 
-	return branch->merge[0]->dst;
+	dst = branch->merge[0]->dst;
+	if (!omit_remote)
+		return dst;
+
+	strbuf_reset(&upstream_branch_buf);
+	if (skip_prefix(dst, "refs/remotes/", &dst) && (dst = strchr(dst, '/')))
+		strbuf_addf(&upstream_branch_buf, "refs/heads/%s", dst + 1);
+	else
+		strbuf_addstr(&upstream_branch_buf, branch->merge[0]->dst);
+	return upstream_branch_buf.buf;
+}
+
+const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
+{
+	return branch_get_upstream_options(branch, err, 0);
 }
 
 static const char *tracking_for_push_dest(struct remote *remote,
diff --git a/remote.h b/remote.h
index 0ca399e183..879be2162c 100644
--- a/remote.h
+++ b/remote.h
@@ -347,6 +347,9 @@ int branch_has_merge_config(struct branch *branch);
 
 int branch_merge_matches(struct branch *, int n, const char *);
 
+const char *branch_get_upstream_options(struct branch *branch, struct strbuf *err,
+					int omit_remote);
+
 /**
  * Return the fully-qualified refname of the tracking branch for `branch`.
  * I.e., what "branch@{upstream}" would give you. Returns NULL if no
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index cb9ef7e329..27b45442c2 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -259,6 +259,12 @@ test_expect_success 'log -g other@{u}@{now}' '
 	test_cmp expect actual
 '
 
+test_expect_success '@{primary} resolves to correct full name' '
+	echo refs/heads/main >expect &&
+	git -C clone rev-parse --symbolic-full-name @{primary} >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '@{reflog}-parsing does not look beyond colon' '
 	echo content >@{yesterday} &&
 	git add @{yesterday} &&
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 87a4286414..88bf625c74 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -69,6 +69,7 @@ check "@{-1}@{u}" ref refs/heads/main
 check "@{-1}@{u}@{1}" commit main-one
 check "@" commit new-two
 check "@@{u}" ref refs/heads/upstream-branch
+check "@{primary}" ref refs/heads/upstream-branch
 check "@@/at-test" ref refs/heads/@@/at-test
 test_have_prereq MINGW ||
 check "@/at-test" ref refs/heads/@/at-test
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..b42d56d438 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -106,6 +106,33 @@ test_expect_success 'checkout (up-to-date with upstream)' '
 	test_grep "Your branch is up to date with .origin/main" actual
 '
 
+test_expect_success 'checkout @{primary} same as checkout main' '
+	(
+		cd test &&
+		git checkout b6 &&
+		git checkout @{primary} >../actual
+	) &&
+	cat >expect <<-EOF &&
+	Your branch is up to date with ${SQ}origin/main${SQ}.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status from @{primary} same as status from main' '
+	(
+		cd test &&
+		git checkout @{primary} &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch main
+	Your branch is up to date with ${SQ}origin/main${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'status (diverged from upstream)' '
 	(
 		cd test &&

base-commit: ea717645d199f6f1b66058886475db3e8c9330e9
-- 
gitgitgadget
