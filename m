Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090061A83F9
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700356; cv=none; b=ngMcHU+oMi9lI6zpdlN1ykr4PyJN5n9CWU8q9RHvZ1pr5hw+h9V5cBhuhtfjJSIYkx/FhWJf64IiBvu/QnaTcxqA7zE96SeLaIupUa7905g1heC99yzo0iHVhKs4nqYLVlJaSShto2pr6iDcy0sxCNRVfIofH245g0EahtdLDjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700356; c=relaxed/simple;
	bh=EgSaG1uCSr8LcLjnaYxefgybkg0gt/HUPOxY5iJaCxI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=F/OiJwR309mg46KO5+bWDGJcr/paSQk0DBvAD0rXZt1g/kld6buFOREcTnaiDsLFUVnab7eM93CPRJzHsJ63CmV2S+K4WcjHcR9896wQpoD3HbJmB67yUFUA52374OCVDE+WtmK2R1OYgV9uckSojPZiGaIOIfauvoyMna7i9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVDIbQGt; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVDIbQGt"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c70ce93afaso121991185a.0
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 07:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769700353; x=1770305153; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r2roo27ThyjbRe96Cdkm31QfnOe+askEPNzQWTC9V7o=;
        b=XVDIbQGtiPwry20K2DbN9v2aZHdPBUYFPDaOVVZqgPeF6p2tHpVDF3GhCCYy0Ll0nO
         LnsCc/oZ3pasZTcUdvncmjwLQgDLouqqV6n8E7q1NX8ScH2X9pxcn1V8AOv8auYHpOtV
         A0p4lEjGDFuYdRa8T+/dQ5dlZSrF1o6+RdacJDdJcwA8eYDSu915FXqAurK+zI0PiDID
         Kzav7NC2COBDOeCvkRMBcN77lh3bT8WVEzz934khO2CagqpjCMGnkMYeDGm8WYBfJHbQ
         HwgiCenxfwKJKbVp41uyJl0JI0kSJI+hgaV+5c/rkhrSbH40f0bAkRXIIg9JgRKwZTX9
         Te+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769700353; x=1770305153;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2roo27ThyjbRe96Cdkm31QfnOe+askEPNzQWTC9V7o=;
        b=Wb4HmajurUqAyRzKDdJa24kJlF6qkdc7D8uXsI8+XYul5tzXRLGBNyASUVd82nRkIs
         YlghhegEU7u71BBFCill/YrpUdHNgnai73ms9qu3nFjlKmOHAtWVh26CeqIAm52Cz/Gl
         WWqHDl0tIfFZ4Sb1PB9dAOUe5zwyzc20VVCNyX7TOqTnjA1XKTHx3ztKh2/71uxZ0tK1
         dInyZ4CO78/+gXDvOQXpHdzJstW7vavkHP+7zg+fCDZ3T6NVy3HWRrEcBaFcQdxY8ha+
         gRyoJZoknpqQMfsLs07/59UdVb/V6kJh+SfEidwHj3X/78FXMMtSFTL4aoCu0Qv1ZAq1
         mPWw==
X-Gm-Message-State: AOJu0YygH51fizmlbAEU50yDcWbeKQt1bY+JsnLjguiQMacn+PnP6xj4
	6/yfMQBW4vB3o33Mkj6Y7CQ2P+U6pFdnD/iaBojz+nC5enni8HR7FXAIsJ+BoQA7
X-Gm-Gg: AZuq6aI88K/b7gq2yK2iCLqa8TPDFLZw8ruR7V/cdqGlKBpvEmK8Rvm9yTQLc1Z5fQp
	yZnierMdfeA7XTRWx+gXa/miFrJ/C9ztBLGF3OZnPvSPwJ/aPdF9WpdR2ymGxC+GQcg9iJUuqwt
	+/I7pP6WQFQY7VNlUCXOmEEytS4RZuBJ68av5b3KHU9NqBYGCJVpzoCKj+R+M8ni+8tBJ56Scmf
	it2vYSZ354S3zJby0s7HJdUAuiuPocTb5eGo3rMQr+GIybADpPJ+ZclL8JjYmCHkQUH4HBZQN0+
	AZIayQT773AipbEenktlCsBHjww2SCGoBOVLJAhBUaSGZZsaYAlRj1gRuKC3f3mLGj2ZbEPeXSs
	wx1XJLkKCTmDyhayYvLBSQB0rX5uuB8Gd8nuM5Ct7nw0vo3nePogCywjXaanexIBlCdLdfC7+DB
	0xLIs61A0SyB4/
X-Received: by 2002:a05:620a:3910:b0:8c6:f76e:c6f1 with SMTP id af79cd13be357-8c70b85a83cmr1134589985a.26.1769700353367;
        Thu, 29 Jan 2026 07:25:53 -0800 (PST)
Received: from [127.0.0.1] ([20.102.222.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d2cdbbsm404277385a.28.2026.01.29.07.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 07:25:52 -0800 (PST)
Message-Id: <pull.2183.git.git.1769700352081.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 29 Jan 2026 15:25:52 +0000
Subject: [PATCH] revisions: add @{default} shorthand for default branch
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
    
    Git already has shorthands like @{upstream} and @{push} to refer to
    tracking branches, but there is no convenient way to refer to the
    default branch of a repository (typically "main" or "master").
    
    Users often want to switch to the default branch regardless of its name,
    especially when working across repositories with different default
    branch names. Currently they must either hardcode the branch name or
    query it via configuration, which is cumbersome.
    
    Add a new @{default} shorthand that resolves to the default branch as
    determined by init.defaultBranch (or falls back to "main" or "master"
    depending on Git version). This allows users to write:
    
    git checkout @{default}
    
    instead of having to know or look up the default branch name.
    
    The implementation follows the same pattern as @{upstream} and @{push},
    using a new branch_get_default() function that queries the default
    branch name and verifies it exists in the repository.
    
    Signed-off-by: Harald Nordgren haraldnordgren@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2183%2FHaraldNordgren%2Fdefault_shorthand-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2183/HaraldNordgren/default_shorthand-v1
Pull-Request: https://github.com/git/git/pull/2183

 Documentation/revisions.adoc | 17 +++++++++++++++++
 object-name.c                | 21 ++++++++++++++++++++-
 remote.c                     | 12 ++++++++++++
 remote.h                     |  6 ++++++
 t/t1508-at-combinations.sh   |  1 +
 t/t2012-checkout-last.sh     |  6 ++++++
 6 files changed, 62 insertions(+), 1 deletion(-)

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
index 8b862c124e..34172f9f80 100644
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
@@ -1798,6 +1811,12 @@ int repo_interpret_branch_name(struct repository *r,
 					    options);
 		if (len > 0)
 			return len;
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
index 87a4286414..09d888df53 100755
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
