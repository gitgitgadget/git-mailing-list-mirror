Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357592;
	b=S2zco66PZ+OU7S+4xUJ8YPBMhUrgVQx5QEbaFEwyXfqU9NXhfrwvdqIGpJIhjyy5zI1F
	 NgCW1Ce6MDciMNK02E4HtUo2jWg522PiGjc+QlLwb8ibqalPbZM43tu5WTKJQCZ8kaRKM
	 +WJD4qynKzLZsRCsuKS6mO7azF0eRJqXYrYUYRuJyWyI75p4TY+bcyWbAC0THb6dFYSYz
	 Fn+ToZX3zAJ7shKbt7MDMfwBYNJynptbSwK1nay+WDK0xLoU3koshKqoM+/5rrgQvQXzQ
	 RsDRx9HXL+gIvxrk+kyQzG+e5I9At9q8fEeOKBPTcprfsw4xyroXi8Z9p4CRSffx6Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=NK8gSGp4VBVGG6kpBecF+pYClz/6hCovNqylU8icwWo=;
	b=d06BG6FG7y5K68ztvGC9R+sq2tRlvoMuXMbISg7D3xx2n/YK2olJlj3d+/xB/HSHWEbR
	 8Dz4rSozQ0WNsaoGqqQjVQJS9IQfwTO9hJ3UFtbc3mf/OZb3FcsF1GBpvTuJBTsvhUCLW
	 Q4WSXp9nFwgtvnWydylNhPg1T7F7WEKPVEOAs/hOUAlI6ETpmXYdmnth6YUGrJhqsp7E2
	 KXBh3N3te9/qhbYTSuqtZ5R0/cNwhr23SUG/6XyTVqg+gl9Q2qcrYfo0QhRNRW6kHrSUh
	 ILmKVMYZGLi+drBTJCUBdgsrubxk7yUO0S65TiMXKH72eKqvdqWBAMYAmLQ2Bo+mTcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0qNAhHmv;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D35E60A3837
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D35E60A3837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0qNAhHmv
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-825b40f8a26so273657a34.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357591; x=1793962391; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NK8gSGp4VBVGG6kpBecF+pYClz/6hCovNqylU8icwWo=;
        b=0qNAhHmviBpbFKBSbWckdazAUye8Q5o+/C89H7Ko6w0WPPzYqjofY3v4OYPvCoJ9PZ
         tgo2/qQzB1r3fRLbrSrQL1d476K/M0PbO2Sam4d0AllNwJyop0bkVBWFw9rQmiOk3wB2
         19kFhDpxyumv1rXRD7ZcsCr/Mci0sI1bX5YZFcp4nCsZda9OLtHEz8dwc5j2p1Ri2JKk
         Jur75p1W6Fda9O6J1GJCvxzGjEAvNH9ZxDm+OjucPT4qyOx2vwmxcoV8BtP/STa6ep3A
         wR1d8IpAm7P+iER3oRFNTS/NvnGSblu/3u3usNn435OEx4TszWiNAjhWzT6TJjBrb+xC
         Q9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357591; x=1793962391;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NK8gSGp4VBVGG6kpBecF+pYClz/6hCovNqylU8icwWo=;
        b=Qa1Wez+LOnjOENUEfZ3/hQUs8WlsFS2ueDNSaWfGyKMLMw2ujypypKhJvWwqEeTWNe
         m8cFzIcjMr7bQ4/U9gZVC0qcPqt6C7tVwe4ze70Y0B+ezqEkU1s0a7LKApbKbE3NwqUu
         QYAn63Hd6SgGEzgBKaLELjUffL93KFLRyYn56FdzR5tK2LIYOg/WIdsrNLcO5T9iHlj1
         gU3qvgqLhKJdC/+zDkmb2UE8ds7Fzmj50IoFx8O6eeA3TMFrG2beE5jYgoXr6m4g15nh
         wbMzZWbNKwRkRms8wq6Bqc1rBFQ6Zs2F4h63MFF3NLSXwLP3lKBg0D/X2v8qXFLpv3xv
         U64A==
X-Gm-Message-State: AFq9FYKvVWO/CrZFoC/fUVdu1HvicaBqWVqzob9Ek/jq4xT0HEkccmiG
	sil+rGtqWs3LEVYeC84O4//JJKxqiU2010ru2H2TVK/rSSGTtMWNAHG+e1gcUdOG3QE=
X-Gm-Gg: AYBFou1x+puUmeEJ0/U14GI/3Dp44nptZAw2k8q2+kypSslpXy4xF9gytuiV4+oCD2B
	EAiUDWD+xh60AbBX/e7aqusJFly+IvWqIW6c82hF+ANmwWLaWij0L/vXJFCVaa8SyaJH/cb8IT+
	ckLNWMqn+txwObMeRVsUVfbGkZiEUsxBm0B8L3dhnPvsBMR/T1OAVJn84DBSurzu51E/5OL+/vR
	j0qu2Bi8WQTOe9lvrG0QmD4fgmbD256wYt199UzKnhAON4ZiMjpcMMn/oYqSREQ+76tqu1MKcYv
	GFsfqUg/0dtIoRdL3BDjN4RPkq4xvl3X+v5JpEgGGrprtO8zmDZKbxLv/3k79/UYmvyGPdFN7vi
	DQq7hi7vK+Qgu0rkrBRmV8klWEyLUXdHe7UzHipMjqSNE6LJK1AaGul//OVYrY5zBAOkb2272gf
	1Rr79lrWwismICzhJ4y2U4U6G+Kuv6sMF6xpsaVQuyYnpETt3g6+Wgjxc/m0xHnMxry9qPLVPWC
	4B3I6trz3W2KNFq8lRbpysDyzWQNQoP40LmN+Ogo1OqPGKM0Ys5KtTU5riyLrUV0W1zYM2/KKvZ
	DAqeTPInNegqcoYFe++HfHPI0qzT/tomMXres+WNd3HARzqNJ9km2Mc=
X-Received: by 2002:a05:6830:82ee:b0:81e:b1d2:95f with SMTP id 46e09a7af769-85d366853f4mr1189937a34.28.1793357591011;
        Fri, 30 Oct 2026 03:53:11 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.62.244])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3545b880sm1859855a34.8.2026.10.30.03.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:53:09 -0700 (PDT)
Message-Id: <24180bf4a2163188632efe6c234888e3247fb532.1793357582.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v5.git.git.1793357582.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v5.git.git.1793357582.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 10:53:00 +0000
Subject: [PATCH v5 2/4] branch: let delete_branches() name where a branch
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
index 171b13b081..99b0dd45e9 100644
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

