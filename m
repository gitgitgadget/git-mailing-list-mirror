Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293728;
	b=LyjP10CBF+/9BI95ve7znmAO5J4Fec5Nf/EG0evHNPaN5+084eoJiWhQ00tyc2fEJ+lH
	 jTqSjKCTCuS7HaSsg36Rpv8tL834Rf7OmtoAnqYslD0y/THmlwxWXNZA7u/Y40A8EtKyH
	 oAR7LTrwqKEeEmoRBtwk/JwtbnD0hpJmda4dmLUMKwovPtQjasCxVmTQBlTMNCDAWHpKd
	 zVsIioEMWrsTPYth09txyN8NJQSi1cnf0jFtD8PwlIXfOdD2yRhnIpt9D8IuIDx2VnWzp
	 460qRZ+QBhxofdMTCGy57Od+/h03w1UM44HJmYz5O9T/KuGZ01O806ipbu3RrQpsr9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=tSI2UO/gkRCgj/ZQtNb/XzehA+fC8/Lp8N8nvS5yHBg=;
	b=AKhiCHWGDOnNizKDkXq3eDsJYlYxNPpPMd+1JnpfURdHnBKFw4HC5DQpiqeSuHlGMTE5
	 In9fSvtzVKJK1ZovQAisxYsChEm9hrfzuNsbKL6hwgyV4koAsEcavlmy+E93Z7WkL3DDm
	 BKFqnl4fuO9ybGxzafDPkEsEULAr8VWlp/+nMoP7KWEwptHYpdbAxbYA/1K96IeCUeiQ2
	 bBiI2CVsTruLEhjdkUawfS604FFwwEIyBKd/sCEg3TqCEaVdBRDDAkUR7KWA9iicuPd4c
	 SJ27/hGZepFOKFBWxprHcgSYYDDptgykfg0NlJ5qIj04fQFaa2vXaYuKdp7x0KgCx2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xNw90wYS;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E783606A33D
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 20:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E783606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xNw90wYS
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-55c48582654so26034341cf.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 12:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795293726; x=1795898526; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tSI2UO/gkRCgj/ZQtNb/XzehA+fC8/Lp8N8nvS5yHBg=;
        b=xNw90wYS/6+j4rqs2WHEdNeWbDGZgwR/XmMEE452K5LvFv48tECc7HhiJYCpyx/ENE
         U8d3/ywlPELfLPMMRZ+Lb45UFKkklk95499GIPJgKZ1xp6ydQYNHhDhjOyGUi8ALxM06
         sH6aORUTt+y4TsnGycPmgj66bcKSRJ4AN8Y00A1zaI5icitn4pmBGGA9ZJBs2tqAVMK5
         U9zSGwkMCVRFI0KxoYUyrPFW4EVAcshUnsR7xOJwmKNsGrIYllPaW+9gE3ajK3bM493E
         FS6Q6G2/5+zSdZfEZpdh2WvXUF8CDv4mr8eV23fuoMnECHWkC/WbXq1MUHkrUOWFEQX8
         UloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795293726; x=1795898526;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSI2UO/gkRCgj/ZQtNb/XzehA+fC8/Lp8N8nvS5yHBg=;
        b=25tfwmDIF9fseoK19eQZ/7wusqyWY+TKeHu1yqvYqOlKPn7HCYNBzf6HC0QzaiLJYx
         pZ8/DVYLM3TplJe9ZKzcNthmtVYh8GQKc5YYD/lvyWZ0ScKEVwvBXHRRcXJ2Gos5S+tk
         HopinMfPMajf0rnNsAwvfPR3tSYyYZVwKiobqsSpRIR836rvMXnGs+Gr6/bQFbI3GuES
         Nc40DZM644ws4PDqheoUCSIAtZBbb0XoGQXmHu+0Amsxy9m2cml9msFCMd4blGgZ5ZmJ
         Roy58zlxilX1tqK2Jr2UpV8XJGUgxE4NBV7s3CKOxd3Onw34CNF8zeMP5fRYbzjQH4/E
         +2AQ==
X-Gm-Message-State: APuU4Z+E9YqPqJ7ZZtLMyt6wVOrU7pSwJ6dYvd2zcYqLyZTCpHa/yFBV
	iJSZLZe+WDM99oVKy/oQK//pW6zUJyguKEHVwsnQ+3XdrpKKltoKMsPLVYZ0NQ==
X-Gm-Gg: AZFdTZdSrAs/WwW021cviGh7bCG4iK40X5RFN8u2+29eOMW6tnty63c+otwy5E0Su/H
	FIqFPjvjxc9tx6YGcvOOtBSu1fAb3cbp+Vlvs00e+W6yTC8TuUAnA8ljW/YLNqj1DDO3jRX5yAt
	knDOguswApFSB+rfmlIO/Qb6Qv33VQnYMOtfpX1UhAmwESG6fmi4obhKSIgaY/hdWyc2HtBkvcj
	rPPGEIi3gQt5mFMwHvTme5eaia0yxJNfBzfnOk84rs453rGthbe8E8WFSE+EYE3rTeXk5/CCDjx
	4wVYoDKg7Xi9CIz/NnMQFECuBOBN1PEPM2AsL6crvmbxf8x0FGsSVjjLoHENQzc7tGsfEHOg99H
	ksgMJAsDnwzbD+T34O0s/kwUew9MfKBXnqXL0SCQq+57TOW0dEFxb8fcCyd0aycefH5ToEc44qJ
	NE4yYFoR+NsHvQPvYuGAitF9Qj4YOzLPJ37PBO7KxFbYFROeh35lSn0zn/gOwRQdpK/VyaQ7NF/
	9TgCCAskOmA/+sMv65NzHvKy3VVeFeTxKV2p6q5T9JRoTUNyIsP0+U7firow7xHvy1OVkK/5Dke
	AJcS2hGs5M1elw/Wos+ens85d2WVzUf7RQ==
X-Received: by 2002:a05:622a:2609:b0:55a:df3b:38d4 with SMTP id d75a77b69052e-55d76b5b9b8mr124942911cf.75.1795293726158;
        Sat, 21 Nov 2026 12:42:06 -0800 (PST)
Received: from [127.0.0.1] ([172.203.213.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921347a0b6bsm60690146d6.1.2026.11.21.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:42:05 -0800 (PST)
Message-Id: <efdf71003877f31480d5b8611bcd955a70a268d6.1795293722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 20:41:59 +0000
Subject: [PATCH v10 2/5] branch: let delete_branches() name where a branch
 landed
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jasper Mayone <me@jaspermayone.com>,
    Tuomas Ahola <taahol@utu.fi>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A later commit lets "git branch" delete branches whose commits are not
in their upstream but whose changes are, such as after a squash merge.
Their tips are not reachable from the upstream, so the merge check in
delete_branches() would refuse to delete them, and the output should
say where their changes went.

Let delete_branches() take a map from branch names to the upstream
commit where each branch landed. A branch in the map skips the merge
check and is reported as

    Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).

No caller passes a map yet, so there is no change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 58 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7ccb36364a..b7c3554b63 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -236,7 +236,7 @@ static void delete_branch_config(const char *branchname)
 }
 
 static int delete_branches(int argc, const char **argv, int kinds,
-			   unsigned int flags)
+			   unsigned int flags, struct strmap *landed_commits)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -251,6 +251,20 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	struct string_list_item *item;
 	int branch_name_pos;
 	const char *fmt_remotes = "refs/remotes/%s";
+	static const char *const msg_templates[2][3] = {
+		{
+			N_("Would delete branch %s (was %s, landed as %s).\n"),
+			N_("Would delete remote-tracking branch %s (was %s).\n"),
+			N_("Would delete branch %s (was %s).\n"),
+		},
+		{
+			N_("Deleted branch %s (was %s, landed as %s).\n"),
+			N_("Deleted remote-tracking branch %s (was %s).\n"),
+			N_("Deleted branch %s (was %s).\n"),
+		},
+	};
+	bool dry_run = flags & DELETE_BRANCH_DRY_RUN;
+	const char *const *use_msg = msg_templates[!dry_run];
 
 	switch (kinds) {
 	case FILTER_REFS_REMOTES:
@@ -334,6 +348,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		}
 
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
+		    !(landed_commits &&
+		      strmap_contains(landed_commits, bname.buf)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
 			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
@@ -350,28 +366,32 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		free(target);
 	}
 
-	if (!(flags & DELETE_BRANCH_DRY_RUN) &&
+	if (!dry_run &&
 	    refs_delete_refs(get_main_ref_store(the_repository), NULL, &refs_to_delete, REF_NO_DEREF))
 		ret = 1;
 
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
-		if (flags & DELETE_BRANCH_DRY_RUN) {
-			if (!(flags & DELETE_BRANCH_QUIET))
-				printf(remote_branch
-					? _("Would delete remote-tracking branch %s (was %s).\n")
-					: _("Would delete branch %s (was %s).\n"),
-					name + branch_name_pos, describe_ref);
-		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
-			char *refname = name + branch_name_pos;
-			if (!(flags & DELETE_BRANCH_QUIET))
-				printf(remote_branch
-					? _("Deleted remote-tracking branch %s (was %s).\n")
-					: _("Deleted branch %s (was %s).\n"),
-					name + branch_name_pos, describe_ref);
-
-			delete_branch_config(refname);
+		char *refname = name + branch_name_pos;
+		struct commit *landed = landed_commits ?
+			strmap_get(landed_commits, refname) : NULL;
+
+		if (dry_run ||
+		    !refs_ref_exists(get_main_ref_store(the_repository), name)) {
+			if (flags & DELETE_BRANCH_QUIET)
+				;
+			else if (landed)
+				printf(_(use_msg[0]), refname, describe_ref,
+				       repo_find_unique_abbrev(the_repository,
+							       &landed->object.oid,
+							       DEFAULT_ABBREV));
+			else if (remote_branch)
+				printf(_(use_msg[1]), refname, describe_ref);
+			else
+				printf(_(use_msg[2]), refname, describe_ref);
+			if (!dry_run)
+				delete_branch_config(refname);
 		}
 		free(describe_ref);
 	}
@@ -902,7 +922,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      FILTER_REFS_BRANCHES,
 				      DELETE_BRANCH_SKIP_UNMERGED |
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
-				      flags);
+				      flags, NULL);
 
 	if (!ret && !(flags & DELETE_BRANCH_DRY_RUN))
 		clear_deleted_upstreams(&protected_branch_names,
@@ -1142,7 +1162,7 @@ int cmd_branch(int argc,
 			die(_("branch name required"));
 		ret = delete_branches(argc, argv, filter.kind,
 				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
-				      (quiet ? DELETE_BRANCH_QUIET : 0));
+				      (quiet ? DELETE_BRANCH_QUIET : 0), NULL);
 		goto out;
 	} else if (delete_merged.nr) {
 		ret = delete_merged_branches(&delete_merged, argv,
-- 
gitgitgadget

