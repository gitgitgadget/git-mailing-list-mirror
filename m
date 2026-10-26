Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003632;
	b=SoVzldLtXwaV7cOg31qxJe4iqKT56Xo9qblj0MGsUeVO9+hRrI8KP8oh45lH9JGUqNL3
	 PlTYNFBQGkI8yirGTNxN16KZGE3seU17akgwhm0ZIUx62b8GWRQfF+0GxOJI6tkHEE6EM
	 fr6wqtNlEPGQ1Zs4R1wmKEhh+and2oE0KOAcQyKk1p/2ZDXGsDlPSLxp8AgudoBsnLUQJ
	 ktem7j/ffFr6erq5bNbucergxysu0Z8GR17qKMzqr88uwAa4eydGvyTcEfNriboQgDrIH
	 TFm3/p1/4DqZWUxkrH2We3+dZladU/Bc5H1uTUWO7kjBgaKVw3wS6kMt5w/c8qs0sTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=NK8gSGp4VBVGG6kpBecF+pYClz/6hCovNqylU8icwWo=;
	b=xO628KfCvs+4m11C9NUiMa7dlAEm2eEmi3PGkQMUMyuqoB9cxf7DYynuUfahpsqTVL2x
	 aYiFjU2KAesgdB26W9tiPR+/+GXpiwPK3QsGADgdgyz5hRNsAaDvTPDNTTrVwuQFodFLs
	 OQr2H8BOz5I7NXFHRZhQABRXCH9kQevrtBBaSUWK3Fm3MZubNs8pQLx8EsuF/HBzYOsnx
	 Ej2G0u8OA7YEbIVKsgcE2Y0oBkoyFXS12iZbagD0raktUMOmdunLeUUuy9tL580q2Z/sY
	 GF/wjX0kH7dVHT41aUmNiAH5uQ9MKwCt+TyILSgNHBvVfL4j++DUuSORzkTvhyf2jDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EjITwwfF;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62870606A331
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62870606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EjITwwfF
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so1135172a12.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793003632; x=1793608432; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NK8gSGp4VBVGG6kpBecF+pYClz/6hCovNqylU8icwWo=;
        b=EjITwwfFYIr77Em4tEE/vNxlngfC1Fcdhb8mehbPnyEQEv9QquWIILv73W5B6HG92q
         gHfYTF7ASohRHOXrW5FRMAheGU+QBMaScsxk75rpUVhmWQWiESs07/P8I69wjpTsxM0C
         bpMR05C3UZcmXn4JCHjWmHU9ukbWJafko1u7Bm0/jhNcIUAcx3uX9SZVdma7ML1XMbF3
         1WTT16fG3FelvHo0SRLvOgOUDECyf6/sJym3EqXf4bSL7H/v5/nRmyhYzgmVI13K+iYX
         I1hoWKjpobb1CHGWunJLZP78n17wjbS5Ie8qPbIwweNNy4Y7YyJAnrz0GJuMaGv6B1FN
         ds4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003632; x=1793608432;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NK8gSGp4VBVGG6kpBecF+pYClz/6hCovNqylU8icwWo=;
        b=XsZ0uL7yWS/0JxRRfDadVhF9uY0Rq0ZoPD7VDKiEBhHnpeh1OWdqn6NS+WcM3Ri6kY
         b3mkku+RNNUTWLBiPiW+mbnF2y1IUCA1xW80UBxOB6krJAEMxaQDiYLvAm9a6i5BnmOK
         sfugFijhcf0ivlJZjxd4JRFz0taC9BbWLY9sUWzUWRM9pXhtvkw06pnZDycYttBlznDh
         FFL6C5Lk1InOtJUl2OdfycAiZc5/IxbCEtQ5kM1qTyBIVqSxrzrG3S3qxoN2oH/G5YTY
         YxxCwUlvZA4V0A2dvy2UGcaAT0rj1838/x6zokajokcuMsUvl3MHDnDFfx60Ye/ZO5vt
         kpuw==
X-Gm-Message-State: AFq9FYIiKb7S+lsw3jDKD6sb3nKd7RJTiIUrjT3H/f1xyOFmReaYkkyp
	UBQV+UsbQGsihkZFhpqkJf1tS9RWThyDVp0DjcyYMPN99yKPfnPC9LnXPM46GdZv
X-Gm-Gg: AYBFou1vZCUssezBKxi6Q5K8lCDfplOi3MgHzf+Tb7hpcVF8ydoQtnpbn/gnFvgT5hH
	B7ty76qkSwqBYlh5WxItmrx2LCwV0oo+pIunP5pFZDAyMebp5NAy+q6ZPEOBBs93BTS+8bh301D
	n+j1jyb/WMg2wQep8cQlLSbYfiSC57MQrA+8K9Mam2Ktrh4xodlohesCy4oaWJONtqpLegesyPf
	gzSZ1ZVfTWzjoBwNVPzlXZpoNBndqjFdInGXrpyVWqSqeZqRkbqSyq2STZ7dGnE821pmttlEG6k
	tefXX3eSipCnJ8vSUhlbC3mDPr9AIQVNtfGk2Gt7nQ5oGzN6n4aszX81awBQo8vBNsWiVlQjLdy
	GN3nVp1YAr3YzWjT0LBEjvVv5zxhJtm5aAJgZnt56sJ/PpZc4593jPDb26ZMhwJS58TUoyeh0Pg
	OLYl2p4Mb8wd8lXdvyWzP1YsmCpZLKl6onP4SynujNPL1QcA6DNOPS0cGUZGxhOFqTEsRrZrtTw
	18fRa+6k6qUVNNIe6qhw8vmbAwTnSBKQF/6ngCiRrBsIz1A40Fnmlm2UxQ=
X-Received: by 2002:a05:6a21:2c03:b0:3e2:2a4b:1bfb with SMTP id adf61e73a8af0-3e7bfc0c278mr3780481637.29.1793003631562;
        Mon, 26 Oct 2026 01:33:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.211.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc21274sm1240861a12.8.2026.10.26.01.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:33:50 -0700 (PDT)
Message-Id: <592562d7e766a0fc40a5ed3c5924e64582fc5505.1793003627.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v4.git.git.1793003627.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v4.git.git.1793003627.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 08:33:45 +0000
Subject: [PATCH v4 2/4] branch: let delete_branches() name where a branch
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

