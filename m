Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40826868B
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489686; cv=none; b=kknEEteP8DB3Tn3UIH0bBvbIPy4nz1Pkog6iXSvkvfJn5P6zr5bcxJslkNf0ZaWzAm+UfKt13IRQSIs+hMkzNSWprLEIUCIXZLHZ4abWwRWB877fbUKRodXEPpitBGwyH8ncc/++v960A9TCzA9dKENYcD7k3MCc4bY9kaZQy+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489686; c=relaxed/simple;
	bh=NEZrap5uRCMIn+O72hexQHgNj3Q2aEWqRNryyWSjQlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+VObqeXcS4xFanrE/nkLPx/cmV+ufA9Ks3kIJPLOtbMB3Ks9/flrnKDC1qCcCCGAn61TWlPhqI0G9EX/9m0xFVqBw7WfGe/5MznjYWdXPa8/Sj/xlqfwdLMuwvHLjGBHk7YWK3dOmK4hiluBkxZJKIvSZjF2oEa98Zo3HGBqBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtzYkqEx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtzYkqEx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-221050f3f00so125452495ad.2
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 05:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489684; x=1741094484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Zk38zjNcqxn99TYghs3Li7mlOd2BXLB5nECBVoJzWw=;
        b=KtzYkqEx34NfgYNW6szhuFRCVQMtjUhTKib4pqURkp91VAJFw9b6a+d00gV+AigYDp
         dvdXEZjN7mRptN7OmQbWOVKYf7xKdFb+v+R8XL/Q6VtMgjSSyQ7Jr4R40uWuvPcK4SlD
         sa5wPHnHW6cbOo/YkZ0Yv22U0uYHCc1zBUbejUofUhgVWHs1lLUGj/zeivh6e2ek9tb/
         eAQQogrCjr0RZXperKBl/OP3U0KOz1sRdrl2JzUHyrRTrVjL2XBFlcRNiFeZKvwixJz5
         PkWBi8FzfcnErJ6LvQwCGtw8lZsruuIIFVjJwF2dPf3ObqR9ZsMTLF2C2Pvuw+i2/6r+
         fAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489684; x=1741094484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Zk38zjNcqxn99TYghs3Li7mlOd2BXLB5nECBVoJzWw=;
        b=mcCGF7AgE01TmqWN+CpKdHywKWgFo6Xq3a/QYq+tm6TeqK4BGKAxtHP6J/g0J/u6xo
         WclYsw7bc37XlljddG04AeBezjgdOXPMhbbtTAMaMVSNe2FpuR/7IUbsKcOQdJLmArw9
         pweQU/lXuEcSARTdXFrECqrAFFptiuWYMOJBdl2wrIIMJATcqBWQOEKI90QjMjhbE//a
         LsO2btAeXEOt45QzAd+JTnuOUHNFdNHvTOuOYSnhx4Ny77n07HCL0jV2Rcc43teifE1X
         rWmONDJP/1XDJTxfebnKMIrd5Tqio59NZ/yOTvAGCsmrb6xlpyuPVPmQ2BkNSvwdlbCS
         O2Rg==
X-Gm-Message-State: AOJu0Yz8VsUrbEMKyzSSfNME5Pf5HW15m8BLbh7jJ0EAHaNftGxak6xl
	LqTW5zZc/adT62qQQWGGxPN+LPXJOr/2u4+dn5v/0ooA9nbsfNo+0Xs//w==
X-Gm-Gg: ASbGncvqVUkbEj3rt18sIvOR98IpNJ4/OBkPq3C+wQcMJDuYCrcE372iNCz/dNzz8eH
	b9gIUJk8gltkOhk1mMayCgbReluF9VBqv96436SuQHpdw3V8jzbg03aHlr2X/JUdKN3UBfVi073
	Er9MA+Z7umXHdTktInVIVcysJiFGb4LCAZ8qIrwc6X6Githj2ZyUWZSDlc9dy+wVLHPYa1QnYMq
	O+2gZX11M7FWXZjeoTEHK8UQZZpxnLwKk1ZRk6tRZ3wRcINja/MYLsBF9uc8xhDmcb5ux7yn0sM
	XHRXl3j9MKjs3le8gCmYBg==
X-Google-Smtp-Source: AGHT+IEqrO6oiAqnuvvaa5KoOaG1P9CyzhDgJBWEAcNLzHfDZe7MmfZ3CyUx44TkpY7KHmB47DDtNA==
X-Received: by 2002:a17:902:ec82:b0:220:cd5f:9d76 with SMTP id d9443c01a7336-22307e791d6mr40053015ad.50.1740489684216;
        Tue, 25 Feb 2025 05:21:24 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a0a617dsm13704205ad.183.2025.02.25.05.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:21:23 -0800 (PST)
Date: Tue, 25 Feb 2025 21:21:32 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 3/9] packed-backend: check whether the "packed-refs" is
 regular file
Message-ID: <Z73D3PdEFk_nciH7@ArchLinux>
References: <Z73DTwr9RicKMINe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73DTwr9RicKMINe@ArchLinux>

Although "git-fsck(1)" and "packed-backend.c" will check some
consistency and correctness of "packed-refs" file, they never check the
filetype of the "packed-refs". Let's verify that the "packed-refs" has
the expected filetype, confirming it is created by "git pack-refs"
command.

Use "lstat" to check the file mode. If we cannot check the file status
due to there is no such file this is OK because there is a possibility
that there is no "packed-refs" in the repo.

Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
the user if "packed-refs" is not a regular file.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c    | 37 +++++++++++++++++++++++++++++++++----
 t/t0602-reffiles-fsck.sh | 22 ++++++++++++++++++++++
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a7b6f74b6e..6c118119a0 100644
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
@@ -1748,15 +1749,43 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
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
 
 	if (!is_main_worktree(wt))
-		return 0;
+		goto cleanup;
 
-	return 0;
+	if (o->verbose)
+		fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
+
+	if (lstat(refs->path, &st) < 0) {
+		/*
+		 * If the packed-refs file doesn't exist, there's nothing
+		 * to check.
+		 */
+		if (errno == ENOENT)
+			goto cleanup;
+		ret = error_errno(_("unable to stat '%s'"), refs->path);
+		goto cleanup;
+	}
+
+	if (!S_ISREG(st.st_mode)) {
+		struct fsck_ref_report report = { 0 };
+		report.path = "packed-refs";
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_REF_FILETYPE,
+				      "not a regular file");
+		goto cleanup;
+	}
+
+cleanup:
+	return ret;
 }
 
 struct ref_storage_be refs_be_packed = {
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index cf7a202d0d..e65ca341cd 100755
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
+		ln -sf packed-refs-back .git/packed-refs &&
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

