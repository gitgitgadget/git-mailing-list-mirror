Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE94473C67
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788301488; cv=none; b=OEmpg6RgapSj5Uwa1tMmQphZLtNLV92uK0U8H6mIX/Lzkb3Hc3OMhf480VqzrnRjHfieYAmCRd11ZsKQLlUDeFrJ5Xa9W95krnLj2ZwRiMFRI29CO1rnKxGUxnMun8TXHfsrL44aTHkl10YcITp/0iylZaHFbJ3Q+ID4+jM8Hl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788301488; c=relaxed/simple;
	bh=MmCSbt0b2F1o4h2APzi42oBtZ6oAfN0RzWmGvB9dFtQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nBdqlJWufv8Z+PpVy91wwSY7l4ihFojOIsOfeA2jwEg2KSB/SPTLMVXEeAFTdYPgGbLj3+Pg2Q4VTaseg5OCiCMoW/GxSbcHc3zEMV0GVq15Roqgx5/e8mHeBcByKEejPUeRL9LXRv22muOD8W4bnGkV3P45umRwWjzeksW8Apw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWwEbjIU; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWwEbjIU"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso469674a91.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788301486; x=1788906286; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g4tz0f2/DwA98ISmI1Fg0So9ZXpBP02jdacVWqKWbCQ=;
        b=TWwEbjIUQH8rT3lHEbRv1jZkRdV9naLCkAMEv7DHBNQ+PMN1dmO3j9AVETgNtecKtA
         URus1MQg4jPWQOhCTzAVHkYzJn5mLtySl0LWd0h39F2aWrAYYHkonhkXzVNUOjBve5pB
         Zqk7CJG1L0hErHdhvFc4n5rBYJh+Tav9zVG1kCeRyTFqgpVkDcjn/6E1tSjRU+Qf1sAC
         5xkZ7LTxgGZx9ro/yZA20GivlIORCk61vynq/XoEDBrSC9RRDZTq+oJgcti1jcJz6wpz
         vQP79CqkmxJ6c2sU7dgenlY4pBdM7KRRvKD2G8cs/Ryn70OxltgR7O2UVHWdOrE/rO9a
         JE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788301486; x=1788906286;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g4tz0f2/DwA98ISmI1Fg0So9ZXpBP02jdacVWqKWbCQ=;
        b=MHClUwzO/u4/LaCj8LSkOkYm0DknGMFb7mVYWcV0nUP5aHOrOZuGmbhXPL+rfphbIP
         wdlAdqNv6lBqMrN2EYyNfyNqqPDHsnIl1g74XsKgENQ+2SOHFy5tgbLMEaZ+rWqNFzkF
         dUKo7WqWxI46M/EuWQZ1ym1ECt3WiaL59XpIjq0AkayCPkkM2RqymSrek/EucnfnQpTz
         4gMq3rNK5ofpez6A0qlvvEhtjsGnwT8w0brk2uAtKxvNMR2HcXqm/Mo4/bmWtA5/8+eA
         C0FwE2u1mO77LO0uBUSSAc4YjAnG1v6fZw2BqxDUpvNwl2wA52uK5NIH0IxckxNQQzph
         LOyg==
X-Gm-Message-State: AFuF++mPEsA1t7pyUgv+EhT1RgUk2fVq3NY213Ed43E/F8VCUMCUMX+5
	/RcccIwCBWr7+1X9BBkaufU3a7L6qkxJYCj2WKahFmO2N9ueyRfgGdcmDDgARAu2
X-Gm-Gg: AYBFou1JfFk0sSERqsPMvBfAqWSkjwL4yTQIB5BELST9saHPVuCeOrE2Juo3EBAZwUk
	UcFzHcqzg8D7gY/MdfVUiyn0MH3tb5y2IEDDqZhc3FTeuh6f2WTgB5+9CIa7kNzkb4SG8gF1GOE
	76VLms+61d57/HmOhIq6D2kdaadFWTuYkOMFpiwMlyLkIX4Q3yR2BotFc0Bsr1xbMr1r059oUWQ
	nxupxs0RJ6ezWQqVg7CMWNKmbEdkXgnf/nZlHiB1x/FIgvxpdA1KA906YGV/cgzNcCGg8QcvwAP
	3X83AXqyygwPuGaCAz0eyIqfZ706eSwc6W5II7Qjjqj7AVI1G3NPaTQqlcwwllt75fXA4lUpiJv
	CmJZAQdEGxhvMt26Qrt7A3IWtExo+TVSd0mw+MtYoWK8tCHd2oG7DbmxqxoTSEKmzWWotcBrkVm
	SduiyASJ6pgF42P5ydPq5C0tU+v6sX5eetLDf7MeA8pOZZFRw1iIaIhsSiP0WO
X-Received: by 2002:a17:90a:d00f:b0:38f:5869:387b with SMTP id 98e67ed59e1d1-39aedee7737mr298804a91.9.1788301485935;
        Tue, 01 Sep 2026 15:24:45 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b79cf9sm1037915eec.18.2026.09.01.15.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:24:45 -0700 (PDT)
Message-Id: <a0b9900437e7c2833960e5046b5acb6703f014b9.1788301481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 22:24:38 +0000
Subject: [PATCH v4 2/5] commit: allow a partial commit when a rebase pick
 becomes empty
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

For years, we disallowed partial commits during merges or cherry-picks.
In commit 430b75f7209c (commit: give correct advice for empty commit
during a rebase, 2019-12-06) it was noted that the "cannot do a partial
commit during a cherry-pick" message was also printed when rebasing a
commit that became empty, and rather than drop the check in that case,
that commit opted to make the message print the actual operation that
was in progress.

Since a commit that has become empty comes without conflicts, a new
partial commit poses no problems; remove the error in that case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/commit.c              | 2 --
 t/t3404-rebase-interactive.sh | 5 ++---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 17cc27e53e..01b79185e7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -520,8 +520,6 @@ static const char *prepare_index(const char **argv, const char *prefix,
 			die(_("cannot do a partial commit during a merge."));
 		else if (is_from_cherry_pick(whence))
 			die(_("cannot do a partial commit during a cherry-pick."));
-		else if (is_from_rebase_now_empty(whence))
-			die(_("cannot do a partial commit during a rebase."));
 	}
 
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ff11abb2f2..3588e16543 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1858,7 +1858,7 @@ test_expect_success 'post-commit hook is called' '
 	test_cmp expect actual
 '
 
-test_expect_success 'correct error message for partial commit after empty pick' '
+test_expect_success 'partial commit is allowed when a rebase pick becomes empty' '
 	test_when_finished "git rebase --abort" &&
 	(
 		set_fake_editor &&
@@ -1867,8 +1867,7 @@ test_expect_success 'correct error message for partial commit after empty pick'
 		test_must_fail git rebase -i A D
 	) &&
 	echo x >file1 &&
-	test_must_fail git commit file1 2>err &&
-	test_grep "cannot do a partial commit during a rebase." err
+	git commit file1
 '
 
 test_expect_success 'correct error message for commit --amend after empty pick' '
-- 
gitgitgadget

