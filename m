Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FBB3E6DDD
	for <git@vger.kernel.org>; Mon,  4 May 2026 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919257; cv=none; b=OeAaGLtKleFpdKQxGl+fhwW0btkTV+IxAlPRF7co5jMbOvhNOosjqoEdqZFBaosMz6BVF6yzgeZq8dc+oa+QoOd0cANZhaYx4Qv9nTsG15Nn7rgoBy4m7kRFzY1lGUoHdQ54csEk8YxZKIew9lDLUHc6nTlU7hJxGT9UAGnjSGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919257; c=relaxed/simple;
	bh=gjtsISTwVjZJpDzakEUOMmN2m6Nr81dPnP9L1SyRZ9M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VQyqNHmC2yXLwUoxJ3Yr/5HWUSuzk+E/XL+auScxeOEQarEd8jn2BaTdGCdphSu46luEvyb43K0wQw6NoGmgMrbU/LDJi33NrnE52yc4kQVj8N0AFqwT1SOUFEAPTgfrImsTfI8Dc4xIcgb5s8nyzjCpOrDP3A52cpOksuxHPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceNEjeZj; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceNEjeZj"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a747448dso30445971cf.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777919254; x=1778524054; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2JaEHNxBxGkFE5l1GS9FbwxlpSzjX4HxYZeACjRXHE=;
        b=ceNEjeZjhOCwtvMIawDvjL5vliqOhXY8E9349AtlTdqqcq29bzleAGh2mcLxqUdRlx
         FrUj2MTvVWRAr033UqlnP3WH3dl27bydS93qI6czzXR0cXJqWLgS/IZau/XLODdjJVgq
         mjLY3+THJjVtdbsLBkUAWu/OBm7TjK+GLnag49Qp0iiRThynvlVsh5I8Y4pkmw/tBb5z
         eU0uEVNocjWxnqWAX7hSHAd5rDY/1GIJUieuQZ+81DUPyeFm8EPU9LTOl3cCXxeBzHol
         cfNhXal4yblxW8lX2+hj5HEcd9JzVBcUEfHzm4QF7ABSv5bjUGyZ6SDde2dfv/ZK4Mw1
         g4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919254; x=1778524054;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O2JaEHNxBxGkFE5l1GS9FbwxlpSzjX4HxYZeACjRXHE=;
        b=XymQ2wbELyjIN237Pw3YWnaBaHp9z8xVBvRiSUDGt3uEPG2k/D+5g13DNkTXZjgYCG
         VVVmI1/if15RJ+6IU6hTuJG6Ov0vAvoyUyGVYqgGviQHV1Uk9en0it6cWI1qUY3cIgG/
         5i3F379PrQiOJdXGGaqb5X7eyLZxO06IyWFoN+cSiNMkjGkVgPu5SkhhYlvW/IG55Rd1
         oHYmL9YRuhd5LR+Io1GwFgCp7FYM91oQQNZVRKQYXSsGuRBKDkU0N/vTVN+9DXToWbWc
         xHyBJfXb31ETS2cYyyhXGlf71lkWE+nT3COjqg6uf3vuwa0VN+boyzTnCNhU+uZOWNM7
         SzPA==
X-Gm-Message-State: AOJu0YzdIZ0B6NG6PxLd7FYebXsWRvdT+2gIUjTTerAPqHZMp2xa9jwP
	wctglR+xtdFDD7QmMhk9L6kAO7O3CREZPwCPeAWX2qsM+XGC6x9TtHMYkNkeUw==
X-Gm-Gg: AeBDieviWGoCSBineaqAR1Fw7+U9Y2JSunxq7M5SB2t9RC4wrIdi4oguVVZb+SZZ4ch
	4vG2Msi82YwT64YMytC7rHUp/NQWpoRjgkWrfNe0briBD1aZcVdJ0D9VDrs2eT6yjbnVx84hPnj
	7JIhiV9k2+MBJf0teNZhNHby5rvv8CF7TQgjwpma9V6TI++JzA90jfWi18IhBGdgcKUF4hypJMu
	V6FW4PZSKuA4DjebQItvVvNQMF8tfdgcPptjh4/7j+1FbL5h/geJyhJ1TuilhwBMZitLQtyBblI
	6kAyi3W+VTlVAFyU+lIy5gPK3hhDct/xr2hh2b2rDg8O+CGyVr/0bpTrUjvz6beRliVryCu9QwP
	UCnx2JeiYnzrEQPwGMuwq4UR76XIDWLQ+/1pVUJ3EIf/3uKzB9qLoWzEx5ekVu8oJlr/U/T3ZMF
	G1cdZroKJV8BupGvpYv9hMS/iKy3oAIHYJYQo=
X-Received: by 2002:ac8:7dc3:0:b0:50f:c36a:3826 with SMTP id d75a77b69052e-5104be225damr169746561cf.16.1777919254471;
        Mon, 04 May 2026 11:27:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.30.56])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-510416dfc75sm120684161cf.3.2026.05.04.11.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:27:33 -0700 (PDT)
Message-Id: <cd4a7e47af2d041f711fa2f3980ba19777d57d0b.1777919250.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
	<pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 18:27:26 +0000
Subject: [PATCH v2 2/6] branch: let delete_branches warn instead of error on
 bulk refusal
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

Add two new parameters to delete_branches() and the helper
check_branch_commit():

* warn_only switches the per-branch refusal from a hard error
  ("error: the branch 'X' is not fully merged" plus a four-line
  hint about 'git branch -D X') to a one-line warning, and
  causes the function to skip those branches without setting its
  exit code. Each refused branch is still skipped from deletion.
* n_not_merged, when non-NULL, is incremented for each branch
  refused on the not-merged path, so a bulk caller can summarize
  rather than print per-branch advice.

All existing call sites pass 0 / NULL and so are unaffected. Both
parameters are wired up so a bulk-deletion caller can suppress
the noise normally appropriate for a one-shot 'git branch -d'.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 03b15452e9..176dccb8be 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -192,7 +192,8 @@ static int branch_merged(int kind, const char *name,
 
 static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
-			       int kinds, int force)
+			       int kinds, int force, int warn_only,
+			       int *n_not_merged)
 {
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
@@ -200,10 +201,18 @@ static int check_branch_commit(const char *branchname, const char *refname,
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged"), branchname);
-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
-				  _("If you are sure you want to delete it, "
-				  "run 'git branch -D %s'"), branchname);
+		if (warn_only) {
+			warning(_("the branch '%s' is not fully merged"),
+				branchname);
+		} else {
+			error(_("the branch '%s' is not fully merged"),
+			      branchname);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					  "run 'git branch -D %s'"), branchname);
+		}
+		if (n_not_merged)
+			(*n_not_merged)++;
 		return -1;
 	}
 	return 0;
@@ -219,7 +228,7 @@ static void delete_branch_config(const char *branchname)
 }
 
 static int delete_branches(int argc, const char **argv, int force, int kinds,
-			   int quiet)
+			   int quiet, int warn_only, int *n_not_merged)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -309,8 +318,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 
 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
-					force)) {
-			ret = 1;
+					force, warn_only, n_not_merged)) {
+			if (!warn_only)
+				ret = 1;
 			goto next;
 		}
 
@@ -961,7 +971,8 @@ int cmd_branch(int argc,
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
+		ret = delete_branches(argc, argv, delete > 1, filter.kind,
+				      quiet, 0, NULL);
 		goto out;
 	} else if (forked) {
 		ret = list_forked_branches(argc, argv);
-- 
gitgitgadget

