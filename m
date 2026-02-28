Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30892DB7B4
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772310683; cv=none; b=fa3q1qB2HRX1XEGEE0R4XkMCGdD44e7S5bBJjkzVBuKVrxDhOoHKiEFp0TU0fkB31B9oz7tLzbADNXxk1ujfUUIEbEIBEOGBtAGnMstWnAA5l02PlDSqJQDe3f/kg2bhejYU6XDNGyZje/5cTgn6y0mgN3Y3rmpWsLIr5WHjleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772310683; c=relaxed/simple;
	bh=dE3n/peZTyoBz7tF7a9ploSl+nPV7tgMFffOssV06BU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=vGjNsIVb33K47NFJ3EdMy71cRQICUkJWtkniqcJgGIZLQbnuYXkkDgZQ1O0qKKQe6HISo4qzYKKeKAxWj1ZBogKgJUgYOGK/U3xptHDjhIJbj0Q7RkwgZw83cOzJN7RLM9Ng15Ru2NzmZds1/2TTpkLLnaVLPqkcOdaJnQN46F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGv0+zJi; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGv0+zJi"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5033387c80aso54844431cf.0
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 12:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772310678; x=1772915478; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y3aNkSKf8mstdumIvjPT1ZilMFu3Wz09dtDxc1RQa8Y=;
        b=DGv0+zJiKQvU0rR+XecQHIPWR7MmUUaDpRsk9kgNqpPCztMfv5XufM0HjWQ0ONiJhB
         wezmZ8m+W/wEkfuivAmHEm5NoyVDoHyJwWCSwzi3X5DE2aeYcwZPmfoHQyA6dHAAs1LR
         kRddsCernOHtZLHgVawsMy3+Gaf0q5rHfRXeZgcNt34btNUoznhWfa013zXXndG5tR/W
         56eMkkuXbfjWzShw+T7bMnMFxfHnoYwhqBSvvJ31qnfxy60KXwalLxn9XOSukKB1hTO9
         eLh0KGU/DAqd+lqfoXYc55zx5WSXEB98QhKsKWViuVTy4fawrVxyYYctRcrmRuBtNIrq
         4K3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772310678; x=1772915478;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3aNkSKf8mstdumIvjPT1ZilMFu3Wz09dtDxc1RQa8Y=;
        b=ZEnWrHOtfX1FynPw2PPJiURqcCd82iMNLQu/0MvGl5anPRZm0lTIirIbnj2g+7RR3c
         P3eNNeCyyKqC9YGSCSflrCAwSUsgvs4qfNxIKDXAnS/MpaSnrOugpG7LowroNsqON1xA
         UioKXJMgBLGmeVREGMQnP1fTnfdq1CDqgTlIEoPHOnN0/SLw1ZYPbvQRpvuuIQJ4AgIX
         a0mH7i7Sa7gryQJ2YVCGdZ/27EHFdJzxKe/KceIahPlz7Pjyp7+sXQnbVCKdMx6DWeMc
         eHp3t4/qk5zpGGb7FqcEAoM6g7T57FoAIPrW5AcT5e5OMA91WsdqtVvpqONfrdoLokn8
         6mew==
X-Gm-Message-State: AOJu0Yyc9q79/t6a1ktFFNJPGQ9ti4qIcNXXB/pGIowOrpMTdOEvmOW6
	g/3mXs6055mmxFuyF37QuufwMrYcK/lZGkzJA9zac+daFfiBWCFMsXS5PXRbGg==
X-Gm-Gg: ATEYQzz2C6HgQO5IUHHEGeYC+103G9RKt4gGwaDjTMHgh51I/l+yvRripGc7IPXvxCf
	Lrev0aEQ2wDQyv4r0jqOpaS3E5yIhzAdzTZkG7cpaUjVEPGmT6llrsBcP8b3tBK3pY/BQKEcJN3
	itk0+NdshyaWPWn8nrH3hHbsN/5KTN2H9uWNxzD21O3h/+0Pi9ayPOim43NfVoq+fveMrenyJdE
	y8L4hfUeFycpQcfWvvQ4wmJ36PiE1/tXGpUfdjERWCX8ODTfBrKWnxoIvyEmpTHszfRWhgQVVZb
	EbKjIDY/60cm+DvZBzQFbLobgYTAxi4J/xukw4VtcVREC4bvXG4iDt1QhfY4mmUVoUoxwaEROdl
	KynAj/siJnsMHwBhUXJHTEWSJIb8fumWBnejdkJbDBw7CoYXv8IXdXAi1O1IPT+g9nbigJ5ECpj
	7Ci3rumsQZZU/GYDU3kSCtEGQA
X-Received: by 2002:ac8:5f46:0:b0:501:3aed:fa5f with SMTP id d75a77b69052e-50744369f36mr139254051cf.12.1772310678149;
        Sat, 28 Feb 2026 12:31:18 -0800 (PST)
Received: from [127.0.0.1] ([9.234.149.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6fb519sm777714485a.29.2026.02.28.12.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 12:31:17 -0800 (PST)
Message-Id: <pull.2057.git.1772310676438.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Feb 2026 20:31:16 +0000
Subject: [PATCH] diff: fix crash with --find-object outside repository
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

When "git diff --find-object=<oid>" is run outside a git repository,
the option parsing callback eagerly resolves the OID via
repo_get_oid(), which reaches get_main_ref_store() and hits a BUG()
assertion because no repository has been set up.

Check startup_info->have_repository before attempting to resolve the
OID, and return a user-friendly error instead.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
    diff: fix crash with --find-object outside repository

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2057%2Fmmontalbo%2Ffix-find-object-crash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2057/mmontalbo/fix-find-object-crash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2057

 diff.c                   |  2 ++
 t/t4053-diff-no-index.sh | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/diff.c b/diff.c
index a68ddd2168..8f0f141be7 100644
--- a/diff.c
+++ b/diff.c
@@ -5215,6 +5215,8 @@ static int diff_opt_find_object(const struct option *option,
 	struct object_id oid;
 
 	BUG_ON_OPT_NEG(unset);
+	if (!startup_info->have_repository)
+		return error(_("--find-object requires a git repository"));
 	if (repo_get_oid(the_repository, arg, &oid))
 		return error(_("unable to resolve '%s'"), arg);
 
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 69599279e9..15076dfe0d 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -76,6 +76,16 @@ test_expect_success 'git diff --no-index executed outside repo gives correct err
 	)
 '
 
+test_expect_success 'git diff --find-object outside repo fails gracefully' '
+	(
+		GIT_CEILING_DIRECTORIES=$TRASH_DIRECTORY/non &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git diff --find-object=abc123 2>err &&
+		test_grep "find-object requires a git repository" err
+	)
+'
+
 test_expect_success 'diff D F and diff F D' '
 	(
 		cd repo &&

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
gitgitgadget
