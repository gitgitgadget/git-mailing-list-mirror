Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1313B33CFD
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551381; cv=none; b=aLqaHTtJZWyO/I+UEcMtkUQF8TG2dOUYhnrx8oDOWNPvAC6xTJ2se7Nmi473lqNyO0vwxnMkaZj+PAVgF3ZG+kF16MHjSEG8cyeza62qRHhRvcXi9jVc4JLf1MGs7I7K3YX3zrgrGvzAd+kB+YrerfYV8rO4vYSusk3fioJI83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551381; c=relaxed/simple;
	bh=zFhECkymcguulK3XnrPy02C6d5XxIYHYUTrQc0bmLVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHRT8dXxdi2s9I3/NpamFkYORyJV67MbWBsHcDqo63rRaVFT4F9fAw1ZfrPMJDp0mMdBq7lNQF1snHmhLadkBnqqdb1uErs9YiQ2Hx0fKyKOoqG/AxYQApvPy0H0rMWB1vTKnKNJ62rQcUuTfAv9tN751Slpr0snCewZwmVlSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHjM/5X7; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHjM/5X7"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e12f8506ccso806732a34.2
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 23:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707551377; x=1708156177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WZg+VIjxjZgay9VGBQR3BKb50qCRXcJlivNFqma9SQ=;
        b=CHjM/5X7M2pR9fkW7q9yuu+w5FQ/4k+vR0PRkWir03pnEAUiy+RhlONrdcud1fAN65
         gsGrwE8eiIdQLx5Ntpw7TLJUWrvBphCUOK0pOz5HGA3X01S16GSbMFij9YSWKLeNIHYP
         a95Knd9fgx69SPSoNWRTdpZ8EonEu3OmR+xi+zlQpdyatq4xTm+cDOVRzxzVclavEeeE
         v9M+xwlyw/S8m5FUfOAkdvJu1ershg6B8Xl/7J0N8hXlZIEYNcifnUk/XKdROFR8jVRF
         jMnQndij2HRt7F+IzwGnvreHFJpicAf+YYrUWovIKixVybLXVVgSRWYIQZX4Zxg0uyLo
         VU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707551377; x=1708156177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WZg+VIjxjZgay9VGBQR3BKb50qCRXcJlivNFqma9SQ=;
        b=woa+41zD7u4Q37+MR6hfkTHHAhE8yG28aPwyVzIQeHlsh6jiii7WdShiVK5WP5rLoV
         aFq3K28UVaRlWrAxLPDjF9ECsKRZtxjQ863qbm8+10Z/6eZ8PJjSFbtcMIFEzZ9UZ8fR
         js5tovjW1j51fRmJXgLBMguwawZvJaRjm0KbmiKICqGn6adniUSzDbOgB27T0wRHIqlW
         omkAdh4zA4Jev/VtW+d9b8DoBe5zYnnGwb8WNcELFT+Duh6CeVMm5Ytm+rQuClo1zb2I
         +EFyUD+V45MRUbqz+NQinjE4mYkp5v19LAeJAz3SB3Vxfj4RtoNjTR1203I8NC2Iql4R
         dA1w==
X-Gm-Message-State: AOJu0Yye7mehR60MdVpWt4SfLZkqyz5SK41jwk7hn1BsO+RrtjVgXzVD
	3vDo35e5+M8iT1i1hDhMvXdiPPxVg0KFWyviOeda5Wve3HD2RiGYH30RNKNGRy0=
X-Google-Smtp-Source: AGHT+IFjNnT8OAaSElaEniNmKYJoyz3Qy+jze8alfU+zAbbizxNlEZRLnoQKWWgG/FwtFtEBwtPwGQ==
X-Received: by 2002:a05:6870:96a7:b0:219:432b:abca with SMTP id o39-20020a05687096a700b00219432babcamr1380254oaq.53.1707551377119;
        Fri, 09 Feb 2024 23:49:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqbGbi3BBbDiNA907kcE/5V4gQ92qFCGUjOakdnLlrtnccNWRqfCUrI/1gfy4ntvjVjyPSnK+p6adaeI4WA43Q4jxR/X6+gePmHKTSuFqL0C+zMQWLVFm0b6WgrjhI9XmZ+AhDn7LBwlwAtd1aaVZICp0wBf2h9c9eilFKtsfCmGLlk5N9sb5B4I7FHOcXAaVDFXFdSY4nSCmnyA==
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v19-20020a056870955300b00219fd9e3194sm310028oal.7.2024.02.09.23.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:49:36 -0800 (PST)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 4/8] sequencer: treat error reading HEAD as unborn branch
Date: Sat, 10 Feb 2024 01:43:52 -0600
Message-ID: <20240210074859.552497-5-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using git-cherry-pick(1) with `--allow-empty` while on an unborn
branch, an error is thrown. This is inconsistent with the same
cherry-pick when `--allow-empty` is not specified.

Treat a failure reading HEAD as an unborn branch in
`is_index_unchanged`. This is consistent with other sequencer logic such
as `do_pick_commit`. When on an unborn branch, use the `empty_tree` as
the tree to compare against.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

This is another new commit that was not present in v1.

See this comment[1] from Phillip for context.

[1]: https://lore.kernel.org/git/b5213705-4cd6-40ef-8c5f-32b214534b8b@gmail.com/


 sequencer.c                   | 36 ++++++++++++++++++++---------------
 t/t3501-revert-cherry-pick.sh | 11 +++++++++++
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3cc88d8a80..b1b19512de 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -769,30 +769,36 @@ static struct object_id *get_cache_tree_oid(struct index_state *istate)
 
 static int is_index_unchanged(struct repository *r)
 {
-	struct object_id head_oid, *cache_tree_oid;
+	struct object_id head_oid, *cache_tree_oid, head_tree_oid;
 	struct commit *head_commit;
 	struct index_state *istate = r->index;
 
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
-		return error(_("could not resolve HEAD commit"));
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
+		/*
+		 * Treat an error reading HEAD as an unborn branch.
+		 */
+		head_tree_oid = *the_hash_algo->empty_tree;
+	} else {
+		head_commit = lookup_commit(r, &head_oid);
 
-	head_commit = lookup_commit(r, &head_oid);
+		/*
+		 * If head_commit is NULL, check_commit, called from
+		 * lookup_commit, would have indicated that head_commit is not
+		 * a commit object already.  repo_parse_commit() will return failure
+		 * without further complaints in such a case.  Otherwise, if
+		 * the commit is invalid, repo_parse_commit() will complain.  So
+		 * there is nothing for us to say here.  Just return failure.
+		 */
+		if (repo_parse_commit(r, head_commit))
+			return -1;
 
-	/*
-	 * If head_commit is NULL, check_commit, called from
-	 * lookup_commit, would have indicated that head_commit is not
-	 * a commit object already.  repo_parse_commit() will return failure
-	 * without further complaints in such a case.  Otherwise, if
-	 * the commit is invalid, repo_parse_commit() will complain.  So
-	 * there is nothing for us to say here.  Just return failure.
-	 */
-	if (repo_parse_commit(r, head_commit))
-		return -1;
+		head_tree_oid = *get_commit_tree_oid(head_commit);
+	}
 
 	if (!(cache_tree_oid = get_cache_tree_oid(istate)))
 		return -1;
 
-	return oideq(cache_tree_oid, get_commit_tree_oid(head_commit));
+	return oideq(cache_tree_oid, &head_tree_oid);
 }
 
 static int write_author_script(const char *message)
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index aeab689a98..390e0ed186 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -112,6 +112,17 @@ test_expect_success 'cherry-pick on unborn branch' '
 	test_cmp_rev ! initial HEAD
 '
 
+test_expect_success 'cherry-pick on unborn branch with --allow-empty' '
+	git checkout main &&
+	git branch -D unborn &&
+	git checkout --orphan unborn &&
+	git rm --cached -r . &&
+	rm -rf * &&
+	git cherry-pick initial --allow-empty &&
+	git diff --quiet initial &&
+	test_cmp_rev ! initial HEAD
+'
+
 test_expect_success 'cherry-pick "-" to pick from previous branch' '
 	git checkout unborn &&
 	test_commit to-pick actual content &&
-- 
2.43.0

