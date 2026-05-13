Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0053B774A
	for <git@vger.kernel.org>; Wed, 13 May 2026 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700889; cv=none; b=C2/KLkfulLS/4NgtFylablybJtYmzdQ3xHQ0mPiiaOubpB0T5OhOMWSYuU/e2xjuUopkuXcLT7iHDz8HmitWkUSadSDAYne81gioIqdK2d6qBcOhZ+/WAIqtPNSBVOdvseDw2nahw9Ac33nnuYzR2GaGBMXTXs54bD76mbPQ4YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700889; c=relaxed/simple;
	bh=yT+o62yAXT/D84VrkzQ9c5MAKAq4vhT81AvBDf2HMeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XIFsHXfiwYOoPx5ri2cruljWSsKkgRNdn2taihTyZI+ltUOT8CZc4cYEQPWGMgHp22kVgBSLH3EWAGWE7dTjE7cBxrPMAch2d70J6Mju3RdHPpAmUdldFPTGVyOsBHVFgWd2x3GJOXOXiw5jWYARRwRDC7ciaEHHAhsj96nGHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igHEsstB; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igHEsstB"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-90eb7a63a30so136863285a.2
        for <git@vger.kernel.org>; Wed, 13 May 2026 12:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778700887; x=1779305687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yeg66v6kvOfuzDGUnbddN5gBrn3lQF4J1+DDnlwVl0A=;
        b=igHEsstBghSs6v4/ileC2E9ASQ84Ujyumnx2a+9IuEb95mymdA5WnZHipJ4TRkMhxf
         87JTxu3cEgQpNL4m0RLaemRVg5hsJKCU/RUTLgD21znALsFqVVfSRFXU383jiJswwJD7
         O9UnwQY0WmiIHPqAqhgZZTYRJCoQXnjZ/qElrrOr/BL1OtC5Wv0UNrgDQHjiZ7AGCGun
         Jqxw1DeUW9R7Jdv/d6Qa1SMspex7pqzvk12KgSnl7Kco04X2RN8apurUFgW4xM73Dair
         y1R7y9r3xng6mnA58tC1DY+f5HE04To37/2TqstgYglQgo+Jer8UcmOcGfBmC3Re+Rj5
         lmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778700887; x=1779305687;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yeg66v6kvOfuzDGUnbddN5gBrn3lQF4J1+DDnlwVl0A=;
        b=mjysZyVT6VeqmTt4ksGCkCwUd5vVvOR+OFYeKvSrPEPDQQ9kkV4P/PjR4arMrZHaUB
         H1o3PX/qc+4J+IptZEPZvZo/q+yKhxTjLu3SsMpym4gjZqCXU+y6fyFaULhwLJ+tlN+e
         J2T6Wy3pRkoFr4nKqH1mwLSuuAaBzYjTTFmty6d55zM7WpW6GCAhdIlEzpSRrq5xlSP0
         OtoQiAjZM+fAOqpomWshjqCghicGFIudf9+buzNpmSIfynU4UyQVJt9GaHk5U8xX1GzS
         OF5m2BMqwYW+hZm94DC7MVcsy25Uqqj9CXHIr2k3uIPllYPzdDR4gL9m8lszRtsr6ChQ
         UDtw==
X-Gm-Message-State: AOJu0YzGbgz7tiXQS1ZQzs9tALWPz2lERkgB4Xw+b2iGakdFuZ/LgqSg
	uocsPmN2rbpKAmn3N/dGVMP6jnad/efv0elqAXBqKGQpadKFyT/wadFeue0vXA==
X-Gm-Gg: Acq92OFt3GRcSVSihoaNO0Ue1fNyq3EfW7XSDdFXCP6EhkswcotpidsFRYIsyWr/UjQ
	wsm/NPqOTqATt3vaZF97GnECx9VpH1GqvpB1kYLvafFz2dqUfSrEtHnRevH5G9AF8tKq7R06/j/
	u4pySZbr1BU+WPKI+n4yLwy0Juey+pd3+oztdlLUisiPYuL0H0QF0a7IVxGVCQx/8TOzopYbsgv
	BHCeYPC5DQ+gQmGUehPKRVUmI6RIL2OstqIOL6HVWWCalnxrKJNCjFWil+UMpGVv4TIRnpZcdh5
	23iTDwS+586h6Gt52V+bue0U1NPZDW6p30HeHQkqzi0tEjl10IlhL+uIxRcxepBSwA47J3gyFQw
	6/rLcGSV+Fi1iAnbLlGIIujK+btGxz7KTQb9a7agmzbBEfB7N+iYw4rqJAbfhOz2WhKSZTGB3uv
	duFOn4co+JYq9RLtdBDP8U1A37UgIrd5BifTg=
X-Received: by 2002:a05:620a:4694:b0:8ec:c4a7:f8fc with SMTP id af79cd13be357-90fad96747amr662493485a.43.1778700886690;
        Wed, 13 May 2026 12:34:46 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.54.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba943761sm46264785a.11.2026.05.13.12.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:34:46 -0700 (PDT)
Message-Id: <2a13e5d4bcd9a1cec616ef85f4f407d211669078.1778700883.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
References: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
	<pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 19:34:40 +0000
Subject: [PATCH v9 2/5] branch: let delete_branches warn instead of error on
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

