Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F3379996
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477489; cv=none; b=dVNUkf//MWhSZVKtjKoDIH6HIPawKt5rSrdwlPqXKPMGKXxIIzFcUDpwersTDJ8LsdBJDcT8YUPfNv7nA1iY828ygO3s7woZz0UnvdnjT7kC8HCmf2kKJB9JBaVKGIr1mLFv0QoOgr9EplhVrb8wqsiv7v+ILH6mdAwj2xiIoFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477489; c=relaxed/simple;
	bh=/nl0seT8oQ+0HA1YbSHoB22AJBbVKhA9RpkZ951Z98c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J5Ls372ZVGNPXtiVzZ2nASbUI6mUTxqwksHbTilD/PdIkLbmxnUWydMz/htSBFNbjKIoclUsSvmY1G3rLUki2mwvZ6sQPJzlFWiGpA+44rLukI8GOWEoRDZG91uFgWUF0k3nyJfJ3JK6OpJ0WJ8v4hGx/Zy6cDatB0ZXd3cwUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQjXRsvA; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQjXRsvA"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30759632453so292559eec.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780477486; x=1781082286; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6f6BKZdlxS/RirXvysOCOy1fi2/id0g+uuiQ07UQhY=;
        b=rQjXRsvA9LzcBa3QRZrwvfl/pqmA60aWFTvTh/PgB3VASBFqiRvFZlxEJFIsk523F9
         10AxhXkBWXCHcj4zQ3ZKXPveQMj2ZfQyoEA38cKQmMFZLd695lWM3XRN0+JHyYhYRDHb
         KXHwiNp/Y+eYvyzzJJzu1kgTyCttjbajrXYYUpfhTNs4sP0xlIwO1a5JCxVOx/Z7L4qy
         l+ArYCecrjWIamRFatCEYIyVyPYiQCBhMopjCCmI4X4RILbT6eEQ6CygYQ6pU2++/Oto
         TGDCPE+hv28ku3h0mkJDlkvFRapFQqpof79m3shYD9vMabgavVkMrJ9XXEdHUkqG9uAt
         XWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780477486; x=1781082286;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g6f6BKZdlxS/RirXvysOCOy1fi2/id0g+uuiQ07UQhY=;
        b=HbVwyIp0lwNsq3GVZZCqHaBW6tx0KfBEUNmtgY14l6W2SlcgzeL4KrQxtHQrxs2x7t
         ijIh6m7XxE3m+IGD/1i7VZFJ9t15zxBpOBFfCO7xs5ay+rpuiDXjjk7G/ggfWxhh37pR
         ZnkfBvvfTmUle0+wwNfNYSXHVlW0qtEEW/kxShQIoewmzlWsk6W5kTUtpgTn8zqIhM9K
         tWiVPaYnoVVIocfcL7whxbDZLFr1kMRgj0Ao2O55VL8O0bnIRyEkDuUeIdlr/F++5C4z
         /yfVmo9p3+cZ7NxNByRFW/pGPl/a5d4fzw6XWcmn2WlebRgTFPcg9AshRr8wHLkSUnzE
         pB1A==
X-Gm-Message-State: AOJu0YwOjiS7ZQldS7lPza2qAWIY1lRFvuEKfhqbdC0wz5UKbZr0OMoO
	NHPmnhDsJqsWeMpr6PZwjqaF+7vhSkncLC4jT1evmxvW0babJ2bI1fq78FfFcA==
X-Gm-Gg: Acq92OHSDSzd3VJQx4jrneoWqfJcgwTw3YqUDb1EpMeCRg/JHQLaFUt5oPEVwHjD3iy
	2jRLjL1urh9OwSWfS+D1qKonhB/nJrhfA/dkom6njpkLy0bxDEJbbGfZevrxG9pGbJLM4v6TLDx
	Q+vTGSXKgRD+ZFr0pWiGtxZwtFv7r3+2lbaSFAyb52L5gQfrCiVmvRbi0Tgxa9AEmxnTGZsVjlE
	/GIrI5H4ului4U0I/VKYOoSDqwwYIHunwpb4ezgwjR+fZK3ZMZIbKtOxSrAVBvbmkKpoob8EiUF
	CAx2JOx0bk9EOywgHegS9mdwYuv9oRM4vrGkWZFdwkUd+FqtROGXwnfQEJFUpgK8Rgm/RnU6nhL
	XQwMcy3eD2acaSyuYpFRr2trkHqK9iMMWc/Pom7SjPVuxlhMxrgtKvAzQRHMD9o9xsZ2+u5+VOg
	CPERV6c/iv76LOxBX2ND6ZY+M7mSP7lqenMVVfpQ==
X-Received: by 2002:a05:693c:25c4:b0:2dd:6937:79b8 with SMTP id 5a478bee46e88-3074fa52073mr1303968eec.5.1780477485460;
        Wed, 03 Jun 2026 02:04:45 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.228.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8e76sm1890723eec.18.2026.06.03.02.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:04:44 -0700 (PDT)
Message-Id: <6c95e4e77cf555194b83eab92c7564e6b639f500.1780477479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
References: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
	<pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jun 2026 09:04:35 +0000
Subject: [PATCH v12 2/6] branch: let delete_branches warn instead of error on
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

Add a warn_only flag to delete_branches() and check_branch_commit()
so a bulk caller can report not-fully-merged branches as one-line
warnings and continue, instead of erroring with the four-line "use
'git branch -D'" advice that the standalone "git branch -d" path
emits. Default callers pass 0 and are unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 12711b29cf..93d8eae891 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -192,7 +192,7 @@ static int branch_merged(int kind, const char *name,
 
 static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
-			       int kinds, int force)
+			       int kinds, int force, int warn_only)
 {
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
@@ -200,10 +200,16 @@ static int check_branch_commit(const char *branchname, const char *refname,
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
 		return -1;
 	}
 	return 0;
@@ -219,7 +225,7 @@ static void delete_branch_config(const char *branchname)
 }
 
 static int delete_branches(int argc, const char **argv, int force, int kinds,
-			   int quiet)
+			   int quiet, int warn_only)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -309,8 +315,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 
 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
-					force)) {
-			ret = 1;
+					force, warn_only)) {
+			if (!warn_only)
+				ret = 1;
 			goto next;
 		}
 
@@ -995,7 +1002,8 @@ int cmd_branch(int argc,
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
+		ret = delete_branches(argc, argv, delete > 1, filter.kind,
+				      quiet, 0);
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
-- 
gitgitgadget

