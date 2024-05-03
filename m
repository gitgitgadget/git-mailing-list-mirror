Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B64139573
	for <git@vger.kernel.org>; Fri,  3 May 2024 04:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711836; cv=none; b=dI5W4faa9pTUaKw1+SDchF8pkoemO6h92mH/8SIA7nCqe2CPLaHrBjh7EKPhzcg9X3kdGmvKEOnKknkS50G1n8MYjgZjIM+nHmBe9OSaEDN6pHXd4YP+9lK7YI/OiU93eepAJ5XGFKKs+12qtOM6rZ2XU9Uahu1bUkA24X8SYlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711836; c=relaxed/simple;
	bh=vX2G5B2HXQ1TM31kzWXSRf/z95A7mxMVhnXIQ+ZrcYA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tCalF9gAoNBi7bRQ9A0/pKUMql7lmmbYtslIjXQGxIYS+Fpwg/yMwVQTSBkjVUM1Px3RqKTH3irwFm5FFlwg4TvNHtQvGbck+QMWysvr79Pn2Fe7JPbjwqvacogo7Z1EJaF1mj6E+xy1GOUDsc5T/UAqW9bslR0EhsFFy217D7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZA/1ZFl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZA/1ZFl"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41ba1ba5591so50897445e9.1
        for <git@vger.kernel.org>; Thu, 02 May 2024 21:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714711832; x=1715316632; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtuBm2iu5RvXdeUY5tUOIpWkhlem4CWLCX7bg62pgYA=;
        b=XZA/1ZFlOetj+D5kxfRWhS5PwSLP8Y9754GoRcPmJ+RaGAUazfelIkxMdbe4+a38hG
         OP4ZRMBNzsnrMceDOiyPwkCGomCCxkvgTbybpT3oi4b8Wffer2im7d1YWrYTwItuhx1F
         aPNFvbdBIIvFFcANkKvpRnZsIoF5qkqe4bajaKkmFg2qaqWuoBaz+U/OF9BEdBLxwZyK
         u8ejHYvcJRmmk/D5GeoK9cBc3/xVKxVk9BNQWB17yTO0W4ylcfkOGZO5XX0jigPDN51n
         J2QsP9NU/meiz65faaVNiOtwQLIJS8xE38MMrVZLvrl+E9jhli1VgsaExwOjeGuGmJGx
         FW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711832; x=1715316632;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtuBm2iu5RvXdeUY5tUOIpWkhlem4CWLCX7bg62pgYA=;
        b=gh//btdo0HyhQZIm7kM6+1mnn9qBoqhQoy2yV6Sd/qokuz32ySto1C49kggk8cfAFl
         T9DTgbvyt5nB+A7XlnkKokZ+7K1b05gyfwhlnj6/I8FpmuV60vipk2gBlZG9Nn6Ri/gN
         LLR86BYG6fc5xX8AnkczSVvcBA5YcflvXn74qszgNGa8bFu4rql2zRY8Fp1tLprXGti+
         2ylChq48GXrVsJW1M0AicjE90rGkCja7lgBACsgpkoM93RbCZfXtE0Tgpa4OfYStBb9W
         EBNruxi4ZciZRoyYXKbPq/4gdHiJPfOvxWxn9MG98M6CucwT3CnnIhdScYEUH7il+m9j
         fwjA==
X-Gm-Message-State: AOJu0YxVBwIDaoWOB+wl8Yfz0+5dvUWVCk2lGAEmKaUFe4bVZaaY5T+R
	cOF8qryUsmTnkcyE1o8BUIjwfDsu/ydQvgseePHgJz+HNQDL7ogHjPwtgw==
X-Google-Smtp-Source: AGHT+IGy29Np+Iz+SUlvaqt8vRGPiKdelmlTx4KcNBe5I3NLek1Ow3kkVxDPuac/YOcOQDnPpWRm5Q==
X-Received: by 2002:a05:600c:458d:b0:41a:b8be:a0b5 with SMTP id r13-20020a05600c458d00b0041ab8bea0b5mr1106016wmo.10.1714711831845;
        Thu, 02 May 2024 21:50:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7-20020a7bc407000000b0041674bf7d4csm7833986wmi.48.2024.05.02.21.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:50:31 -0700 (PDT)
Message-Id: <pull.1716.v2.git.git.1714711829698.gitgitgadget@gmail.com>
In-Reply-To: <pull.1716.git.git.1714488648294.gitgitgadget@gmail.com>
References: <pull.1716.git.git.1714488648294.gitgitgadget@gmail.com>
From: "Ivan Tse via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 May 2024 04:50:29 +0000
Subject: [PATCH v2] refs: return conflict error when checking packed refs
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
Cc: Ivan Tse <ivan.tse1@gmail.com>,
    Ivan Tse <ivan.tse1@gmail.com>

From: Ivan Tse <ivan.tse1@gmail.com>

The TRANSACTION_NAME_CONFLICT error code refers to a failure to create a
ref due to a name conflict with another ref. An example of this is a
directory/file conflict such as ref names A/B and A.

"git fetch" uses this error code to more accurately describe the error
by recommending to the user that they try running "git remote prune" to
remove any old refs that are deleted by the remote which would clear up
any directory/file conflicts.

This helpful error message is not displayed when the conflicted ref is
stored in packed refs. This change fixes this by ensuring error return
code consistency in `lock_raw_ref`.

Signed-off-by: Ivan Tse <ivan.tse1@gmail.com>
---
    refs: return conflict error when checking packed refs
    
    Changes against v1:
    
     * added test for the error message during git fetch
    
    Thanks for reviewing! I've gone ahead and attempted to add tests for
    this behavior. It tests that the error message is shown for both cases
    when the ref is stored as loose vs packed-refs. How does this test look?
    Also, should this test have a REFFILES prerequisite?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1716%2Fivantsepp%2Freturn_name_conflict_error_for_packed_refs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1716/ivantsepp/return_name_conflict_error_for_packed_refs-v2
Pull-Request: https://github.com/git/git/pull/1716

Range-diff vs v1:

 1:  a87ba267e44 ! 1:  58b2cda5c18 refs: return conflict error when checking packed refs
     @@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
       	}
       
       	ret = 0;
     +
     + ## t/t5510-fetch.sh ##
     +@@ t/t5510-fetch.sh: test_expect_success 'branchname D/F conflict resolved by --prune' '
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success 'branchname D/F conflict rejected with targeted error message' '
     ++	git clone . df-conflict-error &&
     ++	git branch dir_conflict &&
     ++	(
     ++		cd df-conflict-error &&
     ++		git update-ref refs/remotes/origin/dir_conflict/file HEAD &&
     ++		test_must_fail git fetch 2>../err &&
     ++		git pack-refs --all &&
     ++		test_must_fail git fetch 2>../err-packed
     ++	) &&
     ++	test_grep "error: some local refs could not be updated; try running" err &&
     ++	test_grep " '\''git remote prune origin'\'' to remove any old, conflicting branches" err &&
     ++	test_grep "error: some local refs could not be updated; try running" err-packed &&
     ++	test_grep " '\''git remote prune origin'\'' to remove any old, conflicting branches" err-packed
     ++'
     ++
     + test_expect_success 'fetching a one-level ref works' '
     + 	test_commit extra &&
     + 	git reset --hard HEAD^ &&


 refs/files-backend.c |  4 +++-
 t/t5510-fetch.sh     | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a098d14ea00..97473f377d1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -794,8 +794,10 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		 */
 		if (refs_verify_refname_available(
 				    refs->packed_ref_store, refname,
-				    extras, NULL, err))
+				    extras, NULL, err)) {
+			ret = TRANSACTION_NAME_CONFLICT;
 			goto error_return;
+		}
 	}
 
 	ret = 0;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 33d34d5ae9e..ae0828e26a1 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1091,6 +1091,22 @@ test_expect_success 'branchname D/F conflict resolved by --prune' '
 	test_cmp expect actual
 '
 
+test_expect_success 'branchname D/F conflict rejected with targeted error message' '
+	git clone . df-conflict-error &&
+	git branch dir_conflict &&
+	(
+		cd df-conflict-error &&
+		git update-ref refs/remotes/origin/dir_conflict/file HEAD &&
+		test_must_fail git fetch 2>../err &&
+		git pack-refs --all &&
+		test_must_fail git fetch 2>../err-packed
+	) &&
+	test_grep "error: some local refs could not be updated; try running" err &&
+	test_grep " '\''git remote prune origin'\'' to remove any old, conflicting branches" err &&
+	test_grep "error: some local refs could not be updated; try running" err-packed &&
+	test_grep " '\''git remote prune origin'\'' to remove any old, conflicting branches" err-packed
+'
+
 test_expect_success 'fetching a one-level ref works' '
 	test_commit extra &&
 	git reset --hard HEAD^ &&

base-commit: d4cc1ec35f3bcce816b69986ca41943f6ce21377
-- 
gitgitgadget
