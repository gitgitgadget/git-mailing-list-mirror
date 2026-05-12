Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877073B8111
	for <git@vger.kernel.org>; Tue, 12 May 2026 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605667; cv=none; b=lb6Cg9YgQU8g3nr/soYTBD/bUDN5t1Tjbsu52oChv6EyRARKQx0eZf9g6c29Ecuk8eCsy+uL0oan2CCoIu5rj1C4kZb0F7CfO1U/qK7oO31uUTOvjTCa20/DzEtMlFklxWjsBkqk9XzY6Pydmk60yv3tkyEXwlcl8TuO8vk8V1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605667; c=relaxed/simple;
	bh=yT+o62yAXT/D84VrkzQ9c5MAKAq4vhT81AvBDf2HMeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EMbLuhyFMrAXAymUaJpxKJo5nMDhk5s9/0F/wy8Nxs4a3K98Cli7Sqh8gbXCadJnj/pqEmlngnxY52DDWVGIV1nEc90/9+wAYAtRzX3f7b6O18PrgS5dHy+bgJTNZgKKF7OD1PV7YdsoAx+AQfqV8On/BC5osoW72r03zkm7c+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPkvGlfx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPkvGlfx"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aaed195901so28659655ad.0
        for <git@vger.kernel.org>; Tue, 12 May 2026 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778605665; x=1779210465; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yeg66v6kvOfuzDGUnbddN5gBrn3lQF4J1+DDnlwVl0A=;
        b=VPkvGlfxXBgkWvjsLrkC8gjJIyOvTcP9H5raguwHR/2Wdi1JG068xz13OIs3eM4CJ+
         1ZFce8xYH1bYvwCl/Aw1Lz0gHa1sv+qmjtf2Jc+EJ1xYJnqq1Z5tQNanu5lBfdTdGpgP
         JLXD6RC7JRMNYJmp8kO3qBsQh4Qh69fgxOfXDZ8nH0Ttaq+wkw54os9wbg6wRcGIHqyQ
         Goc7takp3V+BL3ZfowaoJH8jBK7ok+dC9s3Foqyep1wfOAyBvOjY9A4hAsHr3NUZRGXE
         bX+2Lgu2BsEhdPnK3O6dKKBrhCIn+qxxSEfqIFFuam+Lto5SIYrt7jL1Be+Z3jJSLXzQ
         35AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778605665; x=1779210465;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yeg66v6kvOfuzDGUnbddN5gBrn3lQF4J1+DDnlwVl0A=;
        b=VtPBccgFP7t2QuY2TRWUpiTK7bi+3rZ/dc4c3RvFn5DtD0lJ+l2ue7JEh73sfelV2p
         8vS+Klx48n/lighoDE8bpcRNn5zWqv0xfeN9ThSAvRNceH74SLL9NAzZ22H6Uuu8hTcu
         eZNW6xwSJfGKWx821S19+Clcxk2MGUDKUZ6pkrHhxDfkHgCBZgLE6LIBpw2Km1TVEv1N
         vwqLws/AXZqms+fSpsA9YxVDnWKs8AJD+tjZdKFLpeXPF7bK0Zc0HkUIWDraPHJnis9g
         PZBjDezNvCoesK1odBLFJj1jtOA+AVdMSmIJ3fW7Ar1vrEU7F2Teqk888wlG/gTW1FN2
         0TYA==
X-Gm-Message-State: AOJu0Yzi1CJbaQTxCv/qY++3MOx0f7IbB7Tu/NJteypW8Nb+zQOweTk2
	GhHKiXzCzz4iZ+my7y/Zmqmuhlp8ULh9YKHEiefcC+RVZD4LWNnCB2LMEohUIBxQ
X-Gm-Gg: Acq92OFlxBTGgV6/05S7fcjufJzHIsSjnhHbI+2PgTsuoAEk9Rm98aFwh9X2qiRkYeC
	GdMG1uAY+S8Wn5wC+6lj5qcIg6ud/pMpDBMjAqaNWqMoGpKcMNDvLFEX3FfzIVwKrxYqvo0bZi6
	7KzixeqkprKOKCQBEBZ2KF4mW3cr1NnUJTNyvYryUU4gKXtqPcHyoYy+bx7eN1PLQ8pUimU+JVx
	YVZ9G0SiGcXgXPIOlHqxXCNPup7w8hebim8Jr/SQECi2ucy77cUeMXk1lUB6kMnYhDqhTbh781c
	0+msXMT3CZptjAx3HRI2HNm8TCVvWsBzjGZXiMkeH5HVR2gdOBjvZUJljQjjHZwuIMOABXpRCoG
	7wZCIYzEdUGIr5Dy+EX0+aWxngTQ6jrwrsB14UWz3f/omNAzayxakWvfx7Xm94uUQ5jhTiPY8vi
	6XMXTy2pbdVVA4vD77kAJz8n14+BU=
X-Received: by 2002:a17:903:2a8b:b0:2bc:f1ef:2e64 with SMTP id d9443c01a7336-2bcf1ef316dmr63052775ad.12.1778605665272;
        Tue, 12 May 2026 10:07:45 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.246.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm140504155ad.66.2026.05.12.10.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:07:44 -0700 (PDT)
Message-Id: <b443f0f3676f0382929df0ab95ba7faf0c80193a.1778605658.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
References: <pull.2285.v7.git.git.1778574229.gitgitgadget@gmail.com>
	<pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 17:07:35 +0000
Subject: [PATCH v8 2/5] branch: let delete_branches warn instead of error on
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>,
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
index b3289a8875..1941f8a9ad 100644
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

