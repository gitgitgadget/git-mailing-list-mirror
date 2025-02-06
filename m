Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191F1F60A
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821434; cv=none; b=i89yA9AfFU28JpyrHFz/yYodD9LpV17jAadhUGIRZFrZFq1qyDTMciGbuoMWRVRfhEuNiCJEWCkMkump6nfLVHjecUNrQF3N/HRibjAS4XP5GB3NVfDS3ZPcNL1XyyLUxDgMPLXgBtag/4JYxCMNxdp6l7bqWNtbnpIH6R3ra1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821434; c=relaxed/simple;
	bh=hvB8RSAeuHpGr5D4Vm3uLHj1yMDuoW9Kh8KYzt6v5wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmB2/9pwH0M7tEcCUerk20t895vsooiG0pSLANER+aTv9rFAO+bA0vTjpEGCDoptn5GwVirJX0J+J2zMpcinLp+r5GAKKDbi0vtjHWV2OFMajv+TeNt6paPNAr5vO6rd2eQe2dkoJUB1YZEdyu0S7/D765ykTgKgX+KnjicFHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqqjVNwT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqqjVNwT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2163dc5155fso10373685ad.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 21:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738821432; x=1739426232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QScxn0YiELptPi/YqbglTfJ8vukbjirrSQIaMxw/KoY=;
        b=BqqjVNwT4IAscpGSh5w73vyKs2Tn3bRfjkPcsVQ7sqFzz3EbOstGgeg0+qexgeGfwc
         v1U0GY3r/0EA6+CA36fIZonyx57lGC+7YbbzL8KkGJq3yl9dtfPvbGsp8kR22o8t88um
         MaMEm+HnMx8JPafMCXkBgi4OlvQWA7DtWM1Vga5Xp9ja0w1dGv68FqYzhlElaliS/orp
         pWXuINQ08U0zZ6o0wtpEJ4cYZPromdAjFOLs02fsbYbBbfKWqLTKtBriybtFud5eCR5Y
         /lwivnSrNshVANL7ztf/1PCeR0N22iasZv4RN0DN2O7Ja+l9fP829fmxZTtis9z4D4TU
         Z69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738821432; x=1739426232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QScxn0YiELptPi/YqbglTfJ8vukbjirrSQIaMxw/KoY=;
        b=kIHej2eBkKONXVyYWtTMq06B8q30i++mhldSG5UXXAbWz2KClSAEjeooqPc+9Bguwp
         BELvlkIGvof/G+qqT+mgRE+axHGmu5BSl8cz9K5623OlIwbQ84q0wuuPQ2WhxqfAgiAw
         jWCFtVqxn8ysnHoLGepXfi6/MB9TbcP2jeoboRmbvbSLryHEY+9mHVv8h1wWiRnx26Ia
         QsIxFFdkAx4wa1TEbcwYGK/Zk0WTRiO/KUVeKUZVtzGp3PiA92MfkwP8NdwXVo1+c7/h
         EnsX4vu2kJMBVBUWK5uLtyObF9tSl1avEIPH4wHrMzUiQ0ugLMNjRjhJoxUH51Bj85fe
         QkBg==
X-Gm-Message-State: AOJu0Yy9y+OuKvcV+tHrKlyBX2YVCu7dIAgmm0v2xnFLYlG03HhoYsZt
	sm5yDh76hwEgvz5ufHb4WhrtVkX63excX3Xr8twHvtXX9i2EU4HV85iPig==
X-Gm-Gg: ASbGncskKjwbs7JClktAt/XAm5UVA9fi/ccl2O5qU043lkhtQgiqtuv7KGLNalp4R4g
	kvvtTYELRNwxiXss6e+K1cpA2QihVolZ4ns24RXQUI2hFLRTRm0m722KEYTd+H1qsFqCIhu0l6A
	okZc6ygsN6B6G3hcIOkJ3cE3QN7NAeK/YoaIkxJvux//jPSt+VvXlzfxLrk+fUpKeshbFvumuI5
	EMf0mAMFp0vrGTc58MQzlYAGh6vC8FJcDp4tOtZUvInJLPNUItbWkSmp14D9w0YXgfcKA==
X-Google-Smtp-Source: AGHT+IHfmGN0hjAXgOoLNgYnZT3asQn/anfU+LU6fdPl+EMBeOS4f7ZZpLTEddbKJabr1CIITfYvkw==
X-Received: by 2002:a17:902:db04:b0:21f:3e2d:7d33 with SMTP id d9443c01a7336-21f3e2d7f3bmr2196985ad.11.1738821431674;
        Wed, 05 Feb 2025 21:57:11 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3687c555sm3929785ad.182.2025.02.05.21.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:57:11 -0800 (PST)
Date: Thu, 6 Feb 2025 13:58:53 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 3/8] packed-backend: check whether the "packed-refs" is
 regular file
Message-ID: <Z6RPnX3ff5ub7ojM@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6RPJI10-2QkwyqH@ArchLinux>

Although "git-fsck(1)" and "packed-backend.c" will check some
consistency and correctness of "packed-refs" file, they never check the
filetype of the "packed-refs". The user should always use "git
pack-refs" command to create the raw regular "packed-refs" file, so we
need to explicitly check this in "git refs verify".

We could use "open_nofollow" wrapper to open the raw "packed-refs" file.
If the returned "fd" value is less than 0, we could check whether the
"errno" is "ELOOP" to report an error to the user.

Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
the user if "packed-refs" is not a regular file.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c    | 39 +++++++++++++++++++++++++++++++++++----
 t/t0602-reffiles-fsck.sh | 22 ++++++++++++++++++++++
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a7b6f74b6e..6401cecd5f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -4,6 +4,7 @@
 #include "../git-compat-util.h"
 #include "../config.h"
 #include "../dir.h"
+#include "../fsck.h"
 #include "../gettext.h"
 #include "../hash.h"
 #include "../hex.h"
@@ -1748,15 +1749,45 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
-static int packed_fsck(struct ref_store *ref_store UNUSED,
-		       struct fsck_options *o UNUSED,
+static int packed_fsck(struct ref_store *ref_store,
+		       struct fsck_options *o,
 		       struct worktree *wt)
 {
+	struct packed_ref_store *refs = packed_downcast(ref_store,
+							REF_STORE_READ, "fsck");
+	int ret = 0;
+	int fd;
 
 	if (!is_main_worktree(wt))
-		return 0;
+		goto cleanup;
 
-	return 0;
+	if (o->verbose)
+		fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
+
+	fd = open_nofollow(refs->path, O_RDONLY);
+	if (fd < 0) {
+		/*
+		 * If the packed-refs file doesn't exist, there's nothing
+		 * to check.
+		 */
+		if (errno == ENOENT)
+			goto cleanup;
+
+		if (errno == ELOOP) {
+			struct fsck_ref_report report = { 0 };
+			report.path = "packed-refs";
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_BAD_REF_FILETYPE,
+					      "not a regular file");
+			goto cleanup;
+		}
+
+		ret = error_errno(_("unable to open %s"), refs->path);
+		goto cleanup;
+	}
+
+cleanup:
+	return ret;
 }
 
 struct ref_storage_be refs_be_packed = {
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index cf7a202d0d..42c8d4ca1e 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -617,4 +617,26 @@ test_expect_success 'ref content checks should work with worktrees' '
 	)
 '
 
+test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+		git branch branch-1 &&
+		git branch branch-2 &&
+		git branch branch-3 &&
+		git pack-refs --all &&
+
+		mv .git/packed-refs .git/packed-refs-back &&
+		ln -sf packed-refs-bak .git/packed-refs &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs: badRefFiletype: not a regular file
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err
+	)
+'
+
 test_done
-- 
2.48.1

