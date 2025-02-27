Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D283E1ACEDA
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672377; cv=none; b=DHRS+UPKVko+JZuh8EIWblbznVtuhH6qlbet3hrmD/I42s/fFj5l8ZqcjhrW94vLffnHZs9L131Utrv763LPaj+GY10CIMIDs/7J29zc97+EeRHr37s3G+bz6yYSzHMAvj6t6UBTiAs1anhihxHUXZ2lMEpqk15A5wMK7DHLwH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672377; c=relaxed/simple;
	bh=wwVtxbrdxA3j+8YMqYC81eIbgEKdrVtscvQ8tDmFuE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbFM+FX5J4bdZ0ESuztL2+GjbRx4v7ikFY2mp8Lc79fzC09/h/4UsS+CfNZjPeFlS+jm8Q62Frf2Vx5cdxsJxrgY2ZEsf83COhmd3r4E4r183yZk9/w/eBKGizShYqUFZO0Oomnjiydut86zrJEh+5/lv8x87DPjJbdypFio1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYxbezUs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYxbezUs"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2234bec7192so30150605ad.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 08:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740672374; x=1741277174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFNwHSJ8dX2J9q1tv9DV9PiGrAJoFugwHBeCjPGyztY=;
        b=GYxbezUsy6qNfOYcceuEvHaULi2JAyEbfSBbzs2d5/8TeGuD8VNfpfFA8Sp4n2RQyW
         5kqTtTxq+fTGEnPkRCVuWsYSRQ23Op6JjhzyAHlKuMtZQCy0+OQ2746RxDeDdXUug3Fh
         HRFKSTcwk/cBzQiFnoUwatQmmq0TSzFYt0FeLy+YQ3npg/qNFPQLpzMNUiSXQghFwF09
         PGjczueSLDsZlCQB6ZHnDz1a7ukk1IfpYm1gvBO+MCsecbVkhGu9xViNaKvMs2VNqdhf
         DJJz7COYwS3Db2GR9og7PJzYQxX/Qo3AxGPuaJnTUl9NDYDEGKEHIcNxysOvhO2noX6Q
         9poA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672374; x=1741277174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFNwHSJ8dX2J9q1tv9DV9PiGrAJoFugwHBeCjPGyztY=;
        b=O0MUUY/r9Uz//2PX6SgQgiWzTiySJD5yqZHAOiQ3PlNei081tlVR0wBuBUgibHolJU
         2Il0iVZVrhuW/qybwTfVLi6ImCoXQRR7bKMz86U/FeD4LwDvgbbMwyqtcHf21hZxJps6
         6hpD2qZzF2HphTonl1jaDLZSrIy5oVV6WJGROh3a/mQnu5WygEuBzAj0swERcs31cXH8
         45faOyYNvrZXJ6bbYt5LyO8fHcOoKjlJGZBdwKe/WVWhZqF2RBrWLeQEwVu9pLpy4y5G
         kcCtFX+ous55LEBxw6lgQbbuI17oabfHcsWV6nIHCENgbYRNL7bkfxozKwNsNdwLnDgA
         s7Ug==
X-Gm-Message-State: AOJu0Yy6f+Z8cyjA/PIbxqFNzCNIa2kI5DRKSk4z8J7E6006L2XMUBI7
	KcFm36tVsYWm7zC5ooj+CEIL9n9LBfRce2nzrS2sl8Npyjsgw8uYaIK1XQ==
X-Gm-Gg: ASbGnctGLxUaUsf1J/BLbYYKFc2SuZYj+ic63mfkgfox81ir9Q8mzvFVQy8yXQC65S+
	5G9a0Bux78kGmlcFjWUzTv95bWTzGe7TOURdm8vFGltnpQG0yhpIjCQzM9nGmJ7qkbtQTlF0cY5
	DwCS8CpuA9Gy7tOr5nThrJqkRjkqN1QEvTPdVD9Oq2UutL3H9vZ9LdHaXvfY4/TpeCxvDVZ2qYV
	z1tCwDHme25vLjY83ylyMbUbxYr9rJ7PrE5IhsZegVjJh/uA4QDMkOvl57DPIzwzqtv5K3oMT2G
	/vhygZoYeC39VL3RyBCghQ==
X-Google-Smtp-Source: AGHT+IEB9nqd7oGv6NnfOecnlKtDo0RnoCdwIGBPP1dnx012Lo+Rlos/xJPMh53Lo7WZPp6SnD0scw==
X-Received: by 2002:a17:902:f541:b0:223:26da:4b6f with SMTP id d9443c01a7336-22326da4d3emr108752525ad.14.1740672374589;
        Thu, 27 Feb 2025 08:06:14 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501d2901sm16616695ad.30.2025.02.27.08.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:06:13 -0800 (PST)
Date: Fri, 28 Feb 2025 00:06:24 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 3/9] packed-backend: check whether the "packed-refs" is
 regular file
Message-ID: <Z8CNgB_9UWWNhAzy@ArchLinux>
References: <Z8CMx7O19PMs9sVY@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8CMx7O19PMs9sVY@ArchLinux>

Although "git-fsck(1)" and "packed-backend.c" will check some
consistency and correctness of "packed-refs" file, they never check the
filetype of the "packed-refs". Let's verify that the "packed-refs" has
the expected filetype, confirming it is created by "git pack-refs"
command.

We could use "open_nofollow" wrapper to open the raw "packed-refs" file.
If the returned "fd" value is less than 0, we could check whether the
"errno" is "ELOOP" to report an error to the user. And then we use
"fstat" to check whether the "packed-refs" file is a regular file.

Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
the user if "packed-refs" is not a regular file.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c    | 52 ++++++++++++++++++++++++++++++++++++----
 t/t0602-reffiles-fsck.sh | 30 +++++++++++++++++++++++
 2 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a7b6f74b6e..1fba804a2a 100644
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
@@ -1748,15 +1749,58 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
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
+	struct stat st;
+	int ret = 0;
+	int fd = -1;
 
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
+					      "not a regular file but a symlink");
+			goto cleanup;
+		}
+
+		ret = error_errno(_("unable to open '%s'"), refs->path);
+		goto cleanup;
+	} else if (fstat(fd, &st) < 0) {
+		ret = error_errno(_("unable to stat '%s'"), refs->path);
+		goto cleanup;
+	} else if (!S_ISREG(st.st_mode)) {
+		struct fsck_ref_report report = { 0 };
+		report.path = "packed-refs";
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_REF_FILETYPE,
+				      "not a regular file");
+		goto cleanup;
+	}
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	return ret;
 }
 
 struct ref_storage_be refs_be_packed = {
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index cf7a202d0d..68b7d4999e 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -617,4 +617,34 @@ test_expect_success 'ref content checks should work with worktrees' '
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
+		ln -sf packed-refs-back .git/packed-refs &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs: badRefFiletype: not a regular file but a symlink
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err &&
+
+		mkdir .git/packed-refs &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs: badRefFiletype: not a regular file
+		EOF
+		rm -r .git/packed-refs &&
+		test_cmp expect err
+	)
+'
+
 test_done
-- 
2.48.1

