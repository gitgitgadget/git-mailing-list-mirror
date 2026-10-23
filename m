Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767834;
	b=cMz4SdJYyHhR1u7isZBSGV8lawXDtOaBuTm1zhSNxPGc1hutzm3z6i/AKR0wkQQCDgnn
	 oLnp/XritbpEFbssO5iaLJK7ZaagWYfsX1v4oGv00qesGLncEcyPv7BBiPg+0ZE0AWH3W
	 w8F678AdxdSGKfZXUTSBWqKR3Xulk6TZSMyQRYr/eiQylB7wJk3AAgIY/3l6ihh0jgStP
	 7Qw9TMyOfLsRAComgp9i7ZMNl1J77HXv9euFAVdXMcPkFUI12ZL6obmUjzDwZmMcPRkxQ
	 e94DEWX6W6OtTCplgsclB/7lhiKaxepLpvQ2xzFFfLCDKPUxaVuyB82XVW9EvS34zAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SbvRFNq0QRYqfPS6k1DOuL1JODm1cVjjkZLSjly90eI=;
	b=3R0qu6RZrPZrQyfLvwo4iEshYi2qFc01049wxK9Jpb/lALRSm/pBcVCVkXAfRnbP6mXr
	 8GGRmzO3e1BQlhwBSt6jyyU/Y8NmA7oRA+9w3b7Ng4lhJxKMesYngNqvKYiBEjA+yQB9I
	 XA0mLPoX4f1as4ukg2qIfUORKtpk+yB9wJXojQ30U93vXfV+Bo1z8fxly/+gWB32+Dfwj
	 VobZpkUlYaolCCKgSEIuXfhjQNsmtJw39uGq/1Qd2N6pwkN1KpvcWpFK7uQB9koqcHgoY
	 Urh6rnr0hGCslklS1Ke4VmzBCXmE8DAYLkbOkHfs9PKT/EGsBftfhlCEaQXwTvQx4GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kJhLRqdr;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60D606A321
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D60D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kJhLRqdr
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1df146015so7183155e9.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792767832; x=1793372632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SbvRFNq0QRYqfPS6k1DOuL1JODm1cVjjkZLSjly90eI=;
        b=kJhLRqdrFVK8ta5n3RVtU2QMKKnAebzO5WcXNEuwpVXwEiAgrqw9nGElFJYjQm2ESV
         ZX7gSRMJVjkC1hWwVto1MgYXRXBWOqbMKB7Vm/y0oF4AzPk/N/8OVRHAL5R5C0VB0nj+
         y4O8486J6nLpBUEDrZQOITtdfLUFGBLj/UeavqWn4pf4QslqKXTyO24RhjqfnxfKpHKg
         GFGzR4p3ombfYnm8YKR2QGTxgTCAwNLjkOtOHoAM5PfyMkOlwBRbV+CA+/Pu5/RlDNHN
         AWGzvH/ozNEH9EFj246DvdeHxEv/IkV1RU6GN9CoSvkRkRAVa/9YSUiqQzxCJttT864/
         8O8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767832; x=1793372632;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SbvRFNq0QRYqfPS6k1DOuL1JODm1cVjjkZLSjly90eI=;
        b=MwwOIZTxM7K/Z5MSGFYcdOxg65feBV0LhCxBH2Yx7Qw2L6dq/BJFpjBq5Y9Izv3GKg
         7UMGVHJbAHen/5Ycfjt1IbAR1+C6QtnzFTqI/5QWzdysI6Ns/in1Nj5LfByukJqfSY8X
         +8qnhZXI+/mLwig/4Al1tDMMA0tjZHvcErV66ztAKKzZsxmFOdMKe1OxGbJYlCtMf5kY
         6k4lJoHpVcdi5v1Op02URpo9z23RzWGbVpXjHvZPT3XQV0vfAzRaJJBMEDnCDeFMZThI
         LryCpA95QIVD1+XC2zwe18uaH8RMgz8M/2JS1F8zIJlFlSX/TBvfjTGt14cACSLfsx/D
         TyFg==
X-Gm-Message-State: AFq9FYK5QfTeg3d/SKceI8RK6ZDc9WMkiQSJLY/Cty9cHTZ4PPlfyuUj
	JW+v9peiVXF8UMEdCFwM+azMG2Ux4k1Lsehf1SPQVa6YNCadPEs0MnasyQ9AJA==
X-Gm-Gg: AYBFou3JDVlhnHsVlNrV/zase3hDyPyvUccVu4/ufGQ8a4LLCw0tRXqBEnCFYGDVB7t
	C4YFKH0yj4XYwomiV3EVhhRPuuw+HBJmwiTQYOE6jlJ+g1sWjJg8nlCtdCCshIf/WHHc5E5YK6i
	UDqwZirjq/Hxcqx5E4IEYZSM5OPMl8WB7s1okf4D5x79EEnt+jugL50XfQ/08TR0SBYPPG06Ioz
	WIRT+sEAXoTJ4qG33YNVs3AUiH2JCdKSNfl7fT2xIfsXQcABsIYAGnUuZBSctktDRioKqU52JFC
	W4YNBNrb36+eD81tmENCJhhwS66YXdz5Pm+30lCxyr7sbKXeZkUAWpUhMVSvfw+pBtCTGGgOGJF
	lTxs4zFLzMVPS3uRQf8mK4gL49rDLBp7Bvxu/dRG05/mHK0BWmIQPUpVRXkwsnnhZNuwK/jGBX0
	KFelLIw/PxCSsKY1yjwWaRzYGSy0ORHAWty9ZDmIpSM3RaQHl9kPXHExwGSoJWFZr1YZKEYr1Il
	aHJIWaHUOTFWvPVagdh850S2QpU9lPpX4NCWFVKH6d/eYTGxRFjrrMs89k=
X-Received: by 2002:a05:600c:6309:b0:4a1:7d9b:d4ae with SMTP id 5b1f17b1804b1-4a211c90054mr41175205e9.5.1792767832234;
        Fri, 23 Oct 2026 08:03:52 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d427e68sm296326f8f.52.2026.10.23.08.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:03:51 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 5/7] stash create: rework temporary index creation
Date: Fri, 23 Oct 2026 16:03:33 +0100
Message-ID: <b62d3d080a8ff0d9e14741a886aa45d70019bd64.1792767795.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1792767794.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1792767794.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

We use reset_tree() to create the temporary index file used to stash
uncommitted working tree changes. Unfortunately, reset_tree() reads
the tree into the repository's in-memory index and writes the index
to the repository's default index path. In this case, we read the
tree that's already in the index and copy the existing stat data
across, so overwriting the in-memory index should not change its
contents. To write to a temporary index file, the caller has to
use set_alternate_index_output(). While that writes the index to a
temporary file, it updates the timestamp of the in-memory index so
that the timestamp no longer represents the index file the in-memory
index was read from. In practice that probably does not matter, but
set_alternate_index_output() also relies on a global variable which
makes the code harder to reason about.

Use create_index_from_tree() instead of reset_tree() so that we
can create temporary index file without overwriting the in-memory
index or relying on set_alternate_index_output(). This also makes
the implementation consistent with the way we create the temporary
index for "git stash push -p". As create_index_from_tree() does not
modify the in-memory index it is clearly safe to remove the call to
repo_read_index_preload() which saves one lstat() call per changed
path. It would probably be safe to remove that call without moving away
from reset_tree() but it is much easier to reason about now that the
in-memory index is not modified when we create the temporary index file.

In order to use create_index_from_tree() we need to add a new
parameter to control whether the index is reset, as the new caller
needs to merge the index rather than reset it so that we still detect
intent-to-add entries.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 8db75d9e135..e17f75641a4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -374,7 +374,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 }
 
 static int create_index_from_tree(const struct object_id *tree_id,
-				  const char *index_path)
+				  const char *index_path, bool reset)
 {
 	int nr_trees = 1;
 	int ret = 0;
@@ -403,7 +403,7 @@ static int create_index_from_tree(const struct object_id *tree_id,
 	opts.src_index = the_repository->index;
 	opts.dst_index = &dst_istate;
 	opts.merge = 1;
-	opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
 	opts.fn = oneway_merge;
 
 	if (unpack_trees(nr_trees, t, &opts)) {
@@ -1399,7 +1399,7 @@ static enum create_result stash_patch(struct stash_info *info,
 		goto done;
 	}
 
-	if (create_index_from_tree(head_tree, stash_index_path.buf)) {
+	if (create_index_from_tree(head_tree, stash_index_path.buf, true)) {
 		ret = CREATE_ERROR;
 		goto done;
 	}
@@ -1458,22 +1458,15 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	repo_init_revisions(the_repository, &rev, NULL);
 	copy_pathspec(&rev.prune_data, ps);
 
-	set_alternate_index_output(stash_index_path.buf);
-	if (reset_tree(&info->i_tree, 0, 0)) {
+	if (create_index_from_tree(&info->i_tree, stash_index_path.buf, false)) {
 		ret = -1;
 		goto done;
 	}
-	set_alternate_index_output(NULL);
 
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = add_diff_to_buf;
 	rev.diffopt.format_callback_data = &diff_output;
 
-	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
-		ret = -1;
-		goto done;
-	}
-
 	add_pending_object(&rev, parse_object(the_repository, &info->b_commit),
 			   "");
 	run_diff_index(&rev, 0);
-- 
2.56.0.134.g299a3c16181

