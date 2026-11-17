Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921883;
	b=nhqOW/K0UMsAvClsN9lMgaw57rL0+8Zqh4NWtYqrvkT9bWPu6bzrmatnxWXIjHGwW7Mp
	 8qLYo2vzwANlzjj3YojjyAvzR/Fxjf+bptCcqrDjZTp56YwliqWUoZ4TBPeioAmjMFUHx
	 LaCv4huFlOEqk9mYriGI1b+viq59xvMaZSnu8z7p/vL7RlKOH8jfnkWCyHlREyQsHcOAK
	 eBSAaIJm//fM09mdTdHxvg5CH11ieGJ/JfE1+r1ryyNpuqKdzs67jvdGvKf9oRO2G4b36
	 yzn6nERaDyF2x2wdpn/TKg8D6lM4RTSWReCD6/wX3DZDizchd+Jz5t/t2u8mKy0F2Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=S2bERXMK3QM4AL6CpU2NcC/Zp7XlFZu6dtozdtJ9w3w=;
	b=FXxdCmh/q9ox4zFchGxReQuJBz1aadDOuxG8ryR/DeTg+qGfra7nwbVbIJkpNDAVkzSt
	 tzyGvIL7G4ak6e+gNaDSgcvy4PfkdQDOiWCS6EEduGvuY/45wKnhinCxH8N2K2xi2BWc6
	 sk5FM9sRPHXqHhPfxA2F8xGZ7EIGSa0OJmZGF+tZkzUNemWIDw+wkhK5RTdUnof40Do0T
	 6MM5ITFFO7tXbPzrF08ZgCaz6I+W3cbsmBkkzuO/TozkaWgCoLLQcKOXM+BykyEhsOwW8
	 Iy6Bs3ZRm5209rSBgjJAT+I6PyKKsUYX0t4fWVi9h6cSec5wVj8A7PbBmeDs+cvp5Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fSSeRg+G;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE90C606A32C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 13:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE90C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fSSeRg+G
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b0bbdeae06so2965705a91.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 05:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794921882; x=1795526682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S2bERXMK3QM4AL6CpU2NcC/Zp7XlFZu6dtozdtJ9w3w=;
        b=fSSeRg+GK7uW6T2Skad/R4Y6ObYdtHObV1Lnial2WB585XmwU9NHxoiQ+0LRY87yLI
         lOtEmYp5cxrQ7ZH9BY2Skhb4g4URe/cOrIZbVXanM/GN6t5EZ7qh1/E3jgq4GTv/V8fk
         7yQBSlGNj8xHJu2Q/8RsRRORItDm6n/u3Fn4MTHUhkCCw0fEV8FPZsTFlzC3mCJ9TsMo
         7pZYoCOk00nHhFIlyAYHP7YJhqFU1ExrG4jwkVZEf6hwrirKP//AVGqeczjzqYAeiMx7
         VwxIFiMk1lslQAJ77Z0ETYWz/OXjXjWnaINE89CikvkYlUn48khT/kHRqr0kkHP+2HyL
         x5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794921882; x=1795526682;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2bERXMK3QM4AL6CpU2NcC/Zp7XlFZu6dtozdtJ9w3w=;
        b=lQttfJFeZpTwGimcBcn28BPpG59fhGtikShqoinQ2Fu9RqWgpZ+ZHRe/tiUSQClTXV
         6J9oNZiI8VL7sqpD43gTJAParafngjOEQnyGc3l6Eb5JzKjAkBbNDSmRdq3SlbAADLOm
         oSoNQP6GHHcrIKeAD0oUQfLqOpJinZE2yJDBmwZ2H9vT15eedqlFkEOTsPHg4BCzwkRX
         eAVVdCJC2kPGow3fM5GSKNOEklsPEFTG5BQpgPQm5YJCJ7jgqZnWn/DR8da8YZTvAyt/
         ScoqRrb+cw+Ho5JYac5/ijv0jYuHbOURV9IRtM8igbl7vBqMo25NaRIIL6cX105fbVoD
         ZHKQ==
X-Gm-Message-State: APuU4Z8TYDqb7Lw9z/MnOCDWAtmsqdkWb9glAgC0HpBCIhNtQF6xrX09
	Vp4zjQOgDPwC1a9Bw3WhDdQ71rvN/Ua53IpqlEak8nkcuJvFRKyiygOUB0Y4qQ==
X-Gm-Gg: AZFdTZegU5TJ04sKsminfMG05vjbLWtCjY2wLDlkQ+rYC0O0Yh67GX9XW4jZpPZmWTC
	scdelRpb8gcAHM8BqRa/UZ0xbAqSxeYerzu9tFTlESNbgJpt8BhOCrZ49qWzCJjRyL+7YTbiOmG
	rAMfJwHqp45lKqkw4ExYQf6oiox6NpIboW8/tBjdHsAOS0oWiKo41xd/BFQweYHpN0dahO1n1o5
	mCkGWyxyNp3Zvmdzg/kWmCrUTSxh3s2h7+58UgdAZulItvU1XeSsQTpAe7fM3CPkEKPZE5tdEk6
	Tmg2ccp6LvM6z/8LbaYmWxtsvktzPm50NkRqds/z6rFTVcRnxP/zCQ2VP6iQDeKhLqng4xamljv
	EKOv16o+9tn05oDgk1ekWWOC3v2Nz7xo2KUiaxilsTnXwFXy0M3gLOQNxJR6oVWFVGNvRZNpDEu
	W5vlYufvDp31OIC7ixwN8spNI8IicivZ0nsGIPPf+YZLnomA3CoIxCZmABL1P47aIoPNaUBqy64
	vt0q//5Munk3Qeyqd/6vDy3v5wygZBh29OhpTOegmSNvWZSm2o6OBPBpkYOI0xxJX0LiL/ocOWG
	gezvkqVEeb46lHI3KtPwhjyTBNOxHyMUhFJsTxdxozpt/siuSs7cBesI8V9bSntZtQQO4dikt18
	fICSveq42
X-Received: by 2002:a17:90a:d2cf:b0:3a4:e934:e85c with SMTP id 98e67ed59e1d1-3b1b0a50370mr12414366a91.41.1794921882097;
        Tue, 17 Nov 2026 05:24:42 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-42-157-125.us-west-2.compute.amazonaws.com. [3.42.157.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3f09b92sm10565854a91.4.2026.11.17.05.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:24:40 -0800 (PST)
Message-Id: <18c3edb6e3a12a1e82891728b0c7e3b189b3457a.1794921876.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v8.git.git.1794921876.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v8.git.git.1794921876.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Nov 2026 13:24:34 +0000
Subject: [PATCH v8 2/4] branch: let delete_branches() name where a branch
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
 builtin/branch.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2c1a8b8395..6e6b04b11d 100644
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
@@ -334,6 +334,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		}
 
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
+		    !(landed_commits &&
+		      strmap_contains(landed_commits, bname.buf)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
 			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
@@ -357,15 +359,33 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	for_each_string_list_item(item, &refs_to_delete) {
 		char *describe_ref = item->util;
 		char *name = item->string;
+		struct commit *landed = landed_commits ?
+			strmap_get(landed_commits, name + branch_name_pos) : NULL;
+		const char *landed_abbrev = landed ?
+			repo_find_unique_abbrev(the_repository,
+						&landed->object.oid,
+						DEFAULT_ABBREV) : NULL;
+
 		if (flags & DELETE_BRANCH_DRY_RUN) {
-			if (!(flags & DELETE_BRANCH_QUIET))
+			if (flags & DELETE_BRANCH_QUIET)
+				;
+			else if (landed)
+				printf(_("Would delete branch %s (was %s, landed as %s).\n"),
+				       name + branch_name_pos, describe_ref,
+				       landed_abbrev);
+			else
 				printf(remote_branch
 					? _("Would delete remote-tracking branch %s (was %s).\n")
 					: _("Would delete branch %s (was %s).\n"),
 					name + branch_name_pos, describe_ref);
 		} else if (!refs_ref_exists(get_main_ref_store(the_repository), name)) {
 			char *refname = name + branch_name_pos;
-			if (!(flags & DELETE_BRANCH_QUIET))
+			if (flags & DELETE_BRANCH_QUIET)
+				;
+			else if (landed)
+				printf(_("Deleted branch %s (was %s, landed as %s).\n"),
+				       refname, describe_ref, landed_abbrev);
+			else
 				printf(remote_branch
 					? _("Deleted remote-tracking branch %s (was %s).\n")
 					: _("Deleted branch %s (was %s).\n"),
@@ -901,7 +921,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      FILTER_REFS_BRANCHES,
 				      DELETE_BRANCH_SKIP_UNMERGED |
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
-				      flags);
+				      flags, NULL);
 
 	if (!ret && !(flags & DELETE_BRANCH_DRY_RUN))
 		clear_deleted_upstreams(&protected_branch_names,
@@ -1141,7 +1161,7 @@ int cmd_branch(int argc,
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

