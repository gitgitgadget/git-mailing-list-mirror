Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5683E8C77
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291770; cv=none; b=QQIOwiTstGbQ1fVGBqVSvTaGwfO8BOLncnmEPvY2si0HtlD8mYwWDStUt9IEt+7EkUhb8eFiMfsgX4eld5egajN449TLvwX6InP21YQh60UqE60R62yZFdb0WMOaGLOdvwf0fs4Ihxudy5VL4lVqTTovWxDpBKe9vru8cyl2Ssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291770; c=relaxed/simple;
	bh=S8hDSmz5dAKrl1R4qd6lVNpAWPjg6Oad72GdOuzUGTk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dlijvPIJNNp7xKoW9PEcbbOvOJsfGjwM36vfNqrrjMzBM6PwzYhM0Ln4NGiU8EeEfZOlR03YlKhNFgQXyAmRJDoAM8A1KuixNfkdGJz3ccH3l8k5yKptnApf72/LdtHO7QJREoaCmqfe7XWBiJuvtRkSo0UILHxjlaqbRlZ+LQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAi4OCYD; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAi4OCYD"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-535179e995bso5066091cf.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791291768; x=1791896568; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lZkySZ+QgKjUTpcMPjer8MupG9iaGdAU9+W2gQq1sRs=;
        b=BAi4OCYDkWUzwNfQgksdW0+g4xm/xAxkS+Uhjg+9mMm+2Wnaf3C21rq/VcMvn9PqF/
         vGubgi6YFeLhUzvT9SVs2cYmdr8hQiVsiFJEmAQxosT46oMbfsEzmJlf+r2DmjIKcfZn
         R7RW0U4cGYyWT6qE/vlIoBMPJcZdYXdpA572kAWmK0boUpNBdXCxnv+bzCt39K/ez7pQ
         aLRkvdY0MvNQp0XScwdVY7Fids6QOl7iym2koI8xsWXCaDDOBjXJD03eOhbUJGau4ATD
         CJXx8Jx9rngSjuRNFQ0ceFMrxfD0++AWQXwYrGetxJZF1Vi50WsGEUV2kQJSdTPxX33I
         PsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791291768; x=1791896568;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lZkySZ+QgKjUTpcMPjer8MupG9iaGdAU9+W2gQq1sRs=;
        b=fYvIA5uxrwpMKn4fSc2WeD8folGA+3B+3OYUy3EVdJcRsERc7awBZ7osfx4J3W5CXF
         Wbm7o3CIVrgJPKC4pfgkzNCcEdHFYXJAeRtr4zniDBrHMfDUyd7EIE+FA7Xt15hYOBpY
         25yWA9WViw7CpIP28fy8lJ8K4XTtcXMW0JSsibQEmHZ9+mTBuKBBNwD2WLDYwYOo5l4e
         GQIr1vx8zlm6CcJK3CSp5tLv32bUZRCAjTRGs/msC3KpMrUXFS6qOXclyp27udjzEhPy
         wQO07Xr1mOlPK2nZT8/Z4C2aBzjFDLnksYhiSZ1XBeikzHEYV3ClF9n30fuFMVkN5Dtf
         vf+A==
X-Gm-Message-State: AFuF++kxN8eYcrPnhvgC9Byr7DjKmST9CbmfnBeBu3MlMdmWqiI0acHi
	u2bICpV/gegI0iUymD7VuiDxG+YkPEnY92Pg582H+nQrfjKII64ET5JSzJpByWpW
X-Gm-Gg: AYBFou0eLzNV1k5pg9F+Muw2hDahc/BO1nTdBWFVHsoFSnBXDJsbSyJ+5wd5EBlcsYH
	W/gAZQl+wywTPgyjxs/VIB3FSVYw4c21LBwXX8S+p1ddtb09gFMk7Ow/jba3bfteTzSnoQH6KHE
	mYDAZlWCh6GhvfnXA/yvepb+Tracdyq70ktpETyMzigATu7Txr4r2hgesrkdErw9pvBiv+O1XD7
	NqpG9WvAjhgxwKAZuJLeLWhPcwEpg/HULPT5gi7SJVwQldEkRhWzz5dmHbHQjNoRtNOgWczWBsq
	rDm1UcQ1RPeay7t5xp+iSgyTvV9KIY5O8h5/XU8Y3hVz4dkAQpWqlM5cGTqT8f5hiidj58Td9sW
	DjQMwcbVBcuLIO/K5b79bVl/lcr0cjOgaCzxL1LQ0M7wK/cBO6rw3S86QbLMDCZgswlvukjZlLd
	bSCNtQKc4zdw3ty5PghU7ZYp8NHkpxVXRuqgyMGUdX0IaTUizBpLHFO08pSxGCE4lmfrW4+4Kyd
	A==
X-Received: by 2002:a05:622a:549:b0:535:28bf:5561 with SMTP id d75a77b69052e-53566338612mr20496961cf.6.1791291767723;
        Tue, 06 Oct 2026 06:02:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.158.139])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398aa0baesm120248181cf.13.2026.10.06.06.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:02:43 -0700 (PDT)
Message-Id: <pull.2249.git.1791291762665.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 13:02:42 +0000
Subject: [PATCH] status: suggest `git merge --continue`, not `git commit`
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
Cc: =?UTF-8?Q?=22D=2E_Ben_Knoble_=3Cben=2Eknoble=22=40gmail=2Ecom=3E?=,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

During a merge conflict, we suggest using --continue to continue the
merge for rebase, revert, and cherry-pick.

Change the `git merge` advice to be consistent.
Commit 367ff694281ce569edd8f6e444fc770f92f5d215 says that
`git merge --continue` is intended to be a synonym for `git commit`,
and the `git merge` man page already suggests to use
`git merge --continue`.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
    status: suggest git merge --continue, not git commit
    
    We discussed making this consistent in another thread:
    https://lore.kernel.org/git/623cdf71-8076-4967-aff1-3ebeb57d1e3a@app.fastmail.com/T/#m4bdcb555cbdff4132fb1a678594f26b598e0b38f
    
    From some research:
    
     * git merge --continue was introduced in 367ff694281c in Dec 2016. It
       says that git merge --continue is intended to be a synonym for git
       commit. (thread here:
       https://lore.kernel.org/git/20161214083757.26412-1-judge.packham@gmail.com/)
     * This line of the advice was last touched in July 2016, before git
       merge --continue was introduced.
    
    So I don't see any obvious reason not to change the advice.
    
    Translations will need to be updated, I still don't know how that
    process works. Updating the translations should be straightforward since
    it's just a change in the command.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2249%2Fjvns%2Fadvice-merge-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2249/jvns/advice-merge-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2249

 t/t7060-wtstatus.sh    | 8 ++++----
 t/t7512-status-help.sh | 4 ++--
 wt-status.c            | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 942ddbbf0e..a9b435b5e3 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -37,7 +37,7 @@ test_expect_success 'M/D conflict does not segfault' '
 	cat >expect <<EOF &&
 On branch side
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
@@ -141,7 +141,7 @@ test_expect_success 'status when conflicts with add and rm advice (deleted by th
 	cat >expected <<\EOF &&
 On branch main
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
@@ -174,7 +174,7 @@ test_expect_success 'status when conflicts with add and rm advice (both deleted)
 	cat >expected <<\EOF &&
 On branch conflict_second
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
@@ -198,7 +198,7 @@ test_expect_success 'status when conflicts with only rm advice (both deleted)' '
 	cat >expected <<\EOF &&
 On branch conflict_second
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Changes to be committed:
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index aca4b6d332..776a0dd5b8 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -31,7 +31,7 @@ test_expect_success 'status when conflicts unresolved' '
 	cat >expected <<\EOF &&
 On branch conflicts
 You have unmerged paths.
-  (fix conflicts and run "git commit")
+  (fix conflicts and run "git merge --continue")
   (use "git merge --abort" to abort the merge)
 
 Unmerged paths:
@@ -53,7 +53,7 @@ test_expect_success 'status when conflicts resolved before commit' '
 	cat >expected <<\EOF &&
 On branch conflicts
 All conflicts fixed but you are still merging.
-  (use "git commit" to conclude merge)
+  (use "git merge --continue" to conclude merge)
 
 Changes to be committed:
 	modified:   main.txt
diff --git a/wt-status.c b/wt-status.c
index 57772c7501..f7b0dc29d5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1273,7 +1273,7 @@ static void show_merge_in_progress(struct wt_status *s,
 		status_printf_ln(s, color, _("You have unmerged paths."));
 		if (s->hints) {
 			status_printf_ln(s, color,
-					 _("  (fix conflicts and run \"git commit\")"));
+					 _("  (fix conflicts and run \"git merge --continue\")"));
 			status_printf_ln(s, color,
 					 _("  (use \"git merge --abort\" to abort the merge)"));
 		}
@@ -1282,7 +1282,7 @@ static void show_merge_in_progress(struct wt_status *s,
 			_("All conflicts fixed but you are still merging."));
 		if (s->hints)
 			status_printf_ln(s, color,
-				_("  (use \"git commit\" to conclude merge)"));
+				_("  (use \"git merge --continue\" to conclude merge)"));
 	}
 	wt_longstatus_print_trailer(s);
 }

base-commit: 5a7d1e8045ce66c908f62598e26cbb8df7b39a90
-- 
gitgitgadget
