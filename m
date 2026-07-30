Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B943F09B
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419923; cv=none; b=d2aIb5+PNUrzGKX6dMJRqUe5LIeHexomUQDiys41RoRxcP34C8O8h01VRNfAU03ENS18lg2VTeB1G4N/Pd/RNjxeNmtHH6VDrdKVWMD1lwp5AhkDub5gdmE2Dsqm4+R9siEJ+ErEiTyFkpfIovgt4KZEBde5Tn10f0kOZqgMiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419923; c=relaxed/simple;
	bh=MpDB3cqFH+hwVAGsX+VKTrMzuXGx2I/ztAK6r3FvVQE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EY5DwzsfuW/7Uo8+6vSbIsvAn52T8CqMGOtXjdp+XyFpyG5jntikNAfooe1GxNU/q9e06afLhUtxHMEAjPnGiR4JAju7IZzWGp00j9S27/BXOIRNCpaQxwOtbhgv5EIyNfeDQ6mt4Zkv2wssOqz0k1CY8U/7yqlR2/cqdf5PHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nC1z1Kgp; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC1z1Kgp"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3811f512167so2021746a91.3
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 06:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419921; x=1786024721; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mcF/+heMd1JhSstuSajEvhhfEk3Y70H/0lW5l+AemvQ=;
        b=nC1z1KgpxrJFMqTUeWunkvjmPemf0zz4syvjkHtDYNtgZdK9J7nN34heoc4tQr8iRX
         qV4eXBXxSYjzZkT33Ag76R0cOUQhWpnoCFz1e2gmYInyUzU9gep+sqdI2D8E9eW03+7q
         kifmCw+GloRiUESDNEyN5qVouCE+AduiD7RnTKzybAdY0TE/zddg9WuuBO74t8wuFn3W
         XehaYpVNg5HNNsvI2WCgKwjV4G0API6Jr36mbFZOZZ1rPJgZxGUUOys0sGL97GjGWDXV
         5B82ATzsC4AbuSi14lTykOa/ZbW9fPrUkj38gIc5Uu9pCB+VDuge9ygg//LBnRcY2kR5
         JDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419921; x=1786024721;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcF/+heMd1JhSstuSajEvhhfEk3Y70H/0lW5l+AemvQ=;
        b=Y1yBMb89EaFArKMwgNA/WEbAKg7tbq7dsnGgLa2pZ5tEToHlk+PbCKAE25I04JB+wY
         V4vByJ10EO+E22DA9yRw6xY5SEU1ZdPgcieyQMVQ3Gn/P3uPLqk6W0dQz1WefY76wkuh
         iSCkIlb8piU75xTzI6+ebgnRNsGJr6WK9xhE6/Cib0xc4QCG9BUhznxAhCa8TxB7SFbi
         SRkqw6wCrQbEog4fLO422+EDHdynF4qLqByGs9+HwSsAkTVKLmQ4GXQGPAPpIIEnfXsq
         zaJpeempRD+lWgCr3G9YBYtJgtt2Fe1UuwTcu8IFLHHQJrmhRjLM6dbhFUppJ3gYA5Wb
         J7Ug==
X-Gm-Message-State: AOJu0Yy8clD4zbhdyhZNf1fam2lQ1KW609KDx0yIrkwKQ8yNoNy+ZUuG
	zwKhHB/ZTpKPz+mI2W/VDKe09sFE3o0TmbHNI5FnQOPC9gZqsBMxJifKbSN92w==
X-Gm-Gg: AR+sD12Y9mfT96/KD2CispQ85sS9rudfPQnkhOYbLhPpXfWIhTUNdkJihA0Kl3NWW+V
	9fA/tCJkoHXkfo2++6a4QN2vFZeW6KV3gZulLnErS5f6IfXUgw6ViTFeEmfttaG+8BoE0bQiord
	WXEsbkm+Dvcwkaa3OGpCvqSm5AG6iI2E9+bunRRULRrw9ihh3C2je+6IG/JS5DYWupmnt5iwA5w
	Cx6jrDsLo7smGd2NqSSdHWiUOpknJ3v1lY+EjL41tS3EnJdJr2bALazkQTISzyzxg56xjZtYpGG
	T/o6DUjIxIGqmVBC0Jvh5T7lPP9HmOTvqEBButK+ICZxQi+oC/cs08Jy9EJWe4yvs1Uo8fdfvQG
	FPeypBimpxnd3cQuQR9Y3j2eqDc+VeJ/LLej96JJruqWGThhXswlwAyXSoNwkFE0RP4hPliF4tx
	uc/u5LHMgjrbPC6TtriaXeLS3MIYUlgrpSz41NSHUUMrk8ThWtkE423WvUB6wA6kDhoBm5/PuHq
	gE=
X-Received: by 2002:a17:90b:3908:b0:38e:69ae:7190 with SMTP id 98e67ed59e1d1-38f9bef787cmr2216212a91.26.1785419921224;
        Thu, 30 Jul 2026 06:58:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.230.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f8150241fsm1605193a91.4.2026.07.30.06.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:58:40 -0700 (PDT)
Message-Id: <263e90f6ed63ad3c9fc7a383a34836cdd959b985.1785419916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com>
References: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
	<pull.2285.v24.git.git.1785419916.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Jul 2026 13:58:32 +0000
Subject: [PATCH v24 3/7] branch: let delete_branches skip unmerged branches on
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a skip-unmerged mode to delete_branches() and check_branch_commit()
so a bulk caller can silently skip branches that are not fully merged
and carry on, rather than erroring with the "use 'git branch -D'"
advice that the plain "git branch -d" path emits. Existing callers are
unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index db7cb01190..c44f710a48 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -192,6 +192,7 @@ static int branch_merged(int kind, const char *name,
 enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
+	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -205,10 +206,13 @@ static int check_branch_commit(const char *branchname, const char *refname,
 	}
 	if (!(flags & DELETE_BRANCH_FORCE) &&
 	    !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged"), branchname);
-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
-				  _("If you are sure you want to delete it, "
-				  "run 'git branch -D %s'"), branchname);
+		if (!(flags & DELETE_BRANCH_SKIP_UNMERGED)) {
+			error(_("the branch '%s' is not fully merged"),
+			      branchname);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					  "run 'git branch -D %s'"), branchname);
+		}
 		return -1;
 	}
 	return 0;
@@ -316,7 +320,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
-			ret = 1;
+			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
+				ret = 1;
 			goto next;
 		}
 
-- 
gitgitgadget

