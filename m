Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184671;
	b=blIf9oo0CVdiYpEKQ/cUUu3ty9dxDfWpS7q2lQOAl5kPpwZEVYaI98O77OolvLhSM8om
	 8Q/+9kYeM63ix4dbtNXF3Wsy9Oy40BrDAdbQ2KOQGytt7SEo1AYAiQA1H7ubwMprgCG/4
	 bX9a2ikWLOar3lvyKS6fKa+SQ7Otg2h1kwYEmTovRCsjJn8L3ID6eXP2ceNSo5StKPOjF
	 WfuROTpXOFcu4spHZ63vdpvIT5W9pn1ao26TJVSz+Bi8f8ZKTs/XFJHls78olwc4mJ/1s
	 GAmDpgmd0uf2+qESn0mF7SLMR5lW27ElNX7fnW1ssmV83YtENPUGXvGBRLcTUFn0xtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=S2bERXMK3QM4AL6CpU2NcC/Zp7XlFZu6dtozdtJ9w3w=;
	b=y/YiydrejTGRIy18F+grfbOyNX8xGYPcS6OsTdjcuqUF3cuDDaqQZQecram9nR9Vbe1w
	 zJGoYvuz3lFn5fdMDikdB4B0MJrljCXLosNUSsZtKD7TLhUDJBCkWoUW7DEfDARZ7doX9
	 77bYgMtgxEru/fcHY8T3bgPATYVRYV3yWHk9zi69HWYNnwk/WFvsqZXZy5vKN6DQ6/94x
	 nEYYHxz/1M/MJ0rdKAplJmXm3wDJToRL4RjT7x4/h/iE4vxKYxdG1cKW32fzF15qqasWa
	 m3fDxYdyu/0F5HxpFn0upGcSSIqnmcZSO5ZfyBJsUpQftdAggK46Pi/rQfJ51SFzWNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Cp/O+zSA";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60460606A339
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60460606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cp/O+zSA
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-382c3c9671fso1293865eec.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 06:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795184670; x=1795789470; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S2bERXMK3QM4AL6CpU2NcC/Zp7XlFZu6dtozdtJ9w3w=;
        b=Cp/O+zSAaWCjxdRocFvjeNvMbT+wepa2E+lPziAHrAt3aEzo6KTwPyky8qg/zc2TPW
         l5cT68J1DBvh3jQYf6JIqBjfpzmH6HVmjvyoK5Ab4d8Md+8ixi/Toz8TKSNjKKav/0KU
         6Cu7pMFPsVF/Np5X6pGT6wbDCX6I3v+tpW1WT8ILbgwsEGJ7zOUEp+cGbVZRVBKVtGTc
         lTLdhEs7yBApn8V/1Uu5IWdtLeFXVuPYyTVBulUMud80gsBQkvXKIaBQkHrIrhVvVLGM
         av7t5w7NGILtPFj4Fdw4/BF8owbJvCCn25Bu05dzVu2QS90BcCO2crTXEDJDzCAt8fWI
         MsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795184670; x=1795789470;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2bERXMK3QM4AL6CpU2NcC/Zp7XlFZu6dtozdtJ9w3w=;
        b=eMg6IAr1bmFeWynp3p8K/Nv19/xJOdc8Y8eyGqsot6lJuRH4Cngmvap8yfhUBEsSpP
         0SFUYiSRFXJFSLRX9lE2nq+9YkkfdxVQ4WJvEkQmNpVEsWNAZwY76U6k/J1tRd2Sl7gr
         iA6DhcbA2BVyz/doMWtr13udPyP6Q4UEbyhq6+eBA+xiiQfNdrH5NZRDHVsWX6VmPBJx
         C6+pThLoiQwnxkpLK15SjIXjxFX2XAqzQZjqqPppriDc4bmj9+RIMDKTgb7Vjz+H+tkn
         dCIlJD2hG15kF4uKopCLB88pwxabmPgRm/KdwTzVsJ26iVYiy6Qr2nxzZ164MvYIxBDQ
         tCXA==
X-Gm-Message-State: APuU4Z+5/jxRrxFCmFW4o+u2mwJ2fKpcuiV1Z6ErhYY8sCk0dk9/tvxD
	8o+12Q8JbDQlokdQmAes36upUk2C1SS/eWnO7x2QlBS5D4RmtKLFQNX1557Fg06f
X-Gm-Gg: AZFdTZcrdjq3u8Bx/2ttWaBwHjVSsQpNDQ4ZyOn2cnJc1sSM+N3KP0U4BeGksNAAvmY
	3WmBboUp7vyPbO9hu5F8wFO4zzDDyAOyncATaib6yN7M3imlei7MWjeBVG4K8euaWjhZx8c97jb
	7nO78oH4cWy71AHh3bEpAumqFph4zmnGqYkAcF9EllZUN9D76FiZyqQ2//2yhyDCe0r7xt2ld0v
	L4MXjIx9dJzqTMxujVU8EwWtYU8OTuboatA/w8wJd4CeKlrmrcbCWEW4fmUkxP86QKawvAipwz+
	nqfykWPZDX02KPlCAL+OVEhd4dIKMKuQtxqKErgqNoNj0zKH6Z6bvF7WrdMO4OddWpygl8DkV4F
	OgpkxrGBtrw2Cq/HzyhUNP83Qhj8hYn1ajgVuJcJOvbv0SyyNb+c+x2nYHuBFwYSmIiZMUZb6WK
	cmM1MPBrqEfGKazsrI0AygA6kT9KHuX7P9zrkDdSf3rrkZKvNmAky8CtX8+XancuFeUoAdpWEKj
	6HeHMU00CIusqGhlzE9AziDhi+mNWYCXh2r8Rw9WGFaE8m7xrNvJLXpY4Rp7Bz2M6h3cVZaZp2I
	sE/mdcFuORi2wNCuzP2CkAMOlJ+xCQ==
X-Received: by 2002:a05:693c:6010:b0:385:2057:eb95 with SMTP id 5a478bee46e88-3857073f2a3mr3730639eec.31.1795184670236;
        Fri, 20 Nov 2026 06:24:30 -0800 (PST)
Received: from [127.0.0.1] ([20.171.3.187])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm9904197eec.28.2026.11.20.06.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:24:29 -0800 (PST)
Message-Id: <c4513f9ec1315c34b7a75b95bf50bba59043c274.1795184664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 14:24:22 +0000
Subject: [PATCH v9 2/4] branch: let delete_branches() name where a branch
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

