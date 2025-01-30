Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF72770C
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738209954; cv=none; b=XfsZ5o/1O92TISXH9bN2ss3DqNFFk2zw114iCyCcAaOJDS4hgBozPmbttJPTawIswG9vq6wAMUqPIFwtmvdCCglzaO624lHFmXosbmK+SIaGPZSdE4ZvA91Hvg0Rn7HMqarEgOV3FXNtwVGQq4RT3p2f0sbXtYPjKE4Q/OTHRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738209954; c=relaxed/simple;
	bh=zKM0Eoc9VHZz0AvI2yWD5QXIp7fi1kGHvgc4TJOkCd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arnwCNjuNGqZP23EDZjEvtaA+PCcOh5OPNrMwrQO0rJEUafJE/xpkQTeKcCHdTqHt3k8D1Ms4mxJVrdiS4Y8xhXc87r7N6KQeMcBDTYYITwuUdab6T2ryv6zmuy4sFt+8rIlnHOwANXIyg/M9BQa8wjXpeTlRLspUZynnfOx9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZUyXXz6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZUyXXz6"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so2342880a91.0
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738209952; x=1738814752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxedQoDButnnQ/p6lCvAmJMZOsm/Q1LU5IpGg2OrhM4=;
        b=BZUyXXz6fuCkHeB66pnilqScTdgewcBQ8kA5STPfxcxWLwacfOpJ0UfKbDO0ALJNj/
         shJlJVOQXPd1CvBCyXX6iUaj0HclZyhINTlpqtey9GPxhD9x8F+gmChye6+hDQpLJhIV
         ejgW0TvLkVtdd/CV/s3Djh7Q4MDeJDmrSwR21ahCsT+1MhQOAGUHRwHe0PmUWZeCxOVF
         hBZoqUrUyUUm/P84TkPZsUL7PWBQRSBS2Fa0AIvFFhcNM7DKE+jl8k8SdVNpbiGmS/6A
         7GoCZqDqu3AJ+WDlkAaHUHxSM/KFOkSxNZRfYBVLtziwaOaw+c4Wf8NoXjofykD9dOap
         7Grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738209952; x=1738814752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxedQoDButnnQ/p6lCvAmJMZOsm/Q1LU5IpGg2OrhM4=;
        b=jOPky/kmg6ClZD4RN+g7U/NTPdn27KTX4PZ04MKW+Crqfi0xIFnSdNEdiiA6awM3tC
         4UiWUeW5dEcZirY8RjeDcP59hK8/Jo33DeFcHHQujOdVJHpsm1IIav0DKXHz/T57oitP
         S12b+K0DUvYwlXoXNIVrvQ69b4UzDW47JvZyqeA8Uc59Bid2TutSrt/ST3CoDfVWbSq7
         GJ2DZrOuVRp5qgL1lmMCg/mtpnB/BEBAxiWu5LIkL2/yhNeyJRAU2ILAdpfK5O0RjyA+
         6GYecUMr8SB2Riym6RIFmDFt9kNa81wqHWV5Lc78npBYNqvMTO/oI6oqppJ3XXquvkNF
         vVqA==
X-Gm-Message-State: AOJu0YzELn1wOFqGJux/ba3ExUc8Fw5WmZ9Hq1c4iQvUP22PwcfNziOw
	qQVkPdmD6D9slFlTb8A7nFK94TZ8jhQEXA0nzzDs+4dP8WFmXmhNNhZ+xBU/
X-Gm-Gg: ASbGncs0ddi3wKr9dcMDo++LQJ/Xdx3HCnLu+qgYuSt7udrcH5cFRy4uMBAqvRE1ET4
	3B7JLYLTnliZB807t2DBwMFD66AQPN9zmEJ35ainl62A0Mo2yKlxpt/Ew+poTKeoELKtMmIxRzI
	cCc3lHN3RN0wJnM6LzHUBGepqFELkem9QuThPlI+M7nJzKv63W+BMPVSuCTxFPYZEWjD7Tn8Am1
	F2jSDjf2qfWCNDLP49sdQr892wJ39gsO3vSJfc6FVOmcBfodr7x9glpq71vYofRd/TMkw==
X-Google-Smtp-Source: AGHT+IFvskboRP12e9tlfbQniYMslWKTjUgR4kvJGzGFEchh1o0+z3KlORnpn/ZkPvlhWxH1yAsDCQ==
X-Received: by 2002:a05:6a00:6404:b0:725:4a1b:38ec with SMTP id d2e1a72fcca58-72fe2ccc1b9mr2629725b3a.3.1738209951588;
        Wed, 29 Jan 2025 20:05:51 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe69ba3d9sm328099b3a.120.2025.01.29.20.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 20:05:51 -0800 (PST)
Date: Thu, 30 Jan 2025 12:07:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/8] packed-backend: check whether the "packed-refs" is
 regular
Message-ID: <Z5r6-52eBgT4TUYG@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5r6ZnLH3Ee8IQnN@ArchLinux>

Although "git-fsck(1)" and "packed-backend.c" will check some
consistency and correctness of "packed-refs" file, they never check the
filetype of the "packed-refs". The user should always use "git
packed-refs" command to create the raw regular "packed-refs" file, so we
need to explicitly check this in "git refs verify".

We could use the following two ways to check whether the "packed-refs"
is regular:

1. We could use "lstat" system call to check the file mode.
2. We could use "open_nofollow" wrapper to open the raw "packed-refs" file
   If the returned fd value is less than 0, we could check whether the
   "errno" is "ELOOP" to report an error to the user.

It might seems that the method one is much easier than method two.
However, method one has a significant drawback. When we have checked the
file mode using "lstat", we will need to read the file content, there is
a possibility that when finishing reading the file content to the
memory, the file could be changed into a symlink and we cannot notice.

With method two, we could get the "fd" firstly. Even if the file is
changed into a symlink, we could still operate the "fd" in the memory
which is consistent across the checking which avoids race condition.

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

