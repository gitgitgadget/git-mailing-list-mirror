Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DACB22257C
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806067; cv=none; b=blyi5GLB59Pbjpqart8pnkNiq3HUt6CHQ3PK/ZnN7gCEMOpZlEzQfTpHSVcu3SYkZmXOhCugWk8msPN0cHYDU0uUgH3gpxgEs4LmtEN9x2prgPMYH4fL0ENMNG3GThPa1PqEfPXfSpuUPCBLTbHrlTL/Jc9MUyYvOpmgx4WT8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806067; c=relaxed/simple;
	bh=QbPFCBVDaJb/jpgXZ1C/HMwZphNri82hZPKncFvXjG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daS1bxZ/k3EmFWAdQD91Ax6Qlc++HhFc3WA7xlzOl8fVAnksIoRoEIoNd5jb+kftwA8rtAPRQ6tz+F2Mc7bLGe3qiQX+Tgd5yWX3OZTRzb5oVEjMt6lSpI2swtcP7y24Efqfd8mE+2MhHi+eU/xewsT7K9OiEoUgiN3kMSDzc2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4OzHs4X; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4OzHs4X"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2210d92292eso49323745ad.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 07:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739806065; x=1740410865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfTc4V0SRbAqfX/uDsL/sc3AyJsbsuQxrW0lpSVAAqY=;
        b=J4OzHs4XlR4l+eMY8G1AxhZlXjY6SR6qRVZKutZyHtC6i7J39z9gshTMN9GDhSf4TT
         zvjpU0pOvl/RU7yKJZ+/etjhatsyNXfhf6aRlDYEEUHsw4zp9cEJ8ZMOHb39wiRW860s
         2T1lZH5FFkpIbrP+/JlWMNwnWtztuNMIAlEGVRz7C/B7lHzJc03j6b+m2LyihRScFZWh
         r3JDFAms+WAG/WGahRPmEXNAEi+d0WuDjBz011pkHxYvuOVdwz6u5jHhTriijjSWBjZW
         XcT14Udmm/4bUmHjatFe1pkS+G96TC7Dbr7PM33ijs0MHZZyc5MdoFbtPYdQu/D1gq3B
         kU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739806065; x=1740410865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfTc4V0SRbAqfX/uDsL/sc3AyJsbsuQxrW0lpSVAAqY=;
        b=l0JjAIAp4vMSyCFmT+/+X3DzhM2ej0oeuI6m8gZXpROgVXyohYXwrwidKnt6dojPJL
         TkdwOBIHPp3KhJ+XOuoYlMjtCdOqE8j2+w91+XRmJim5WKhppuceX6znftSCVVOFptu+
         q6ygx3ygid3u5ENiyRn7S2OH7e0HtEsl/B+cuzldKK1a25+t+HyxUph83Mgx5cpj81GX
         6qT1lj8XnFDB5ppqLp793nSDIe3CoJkK/69LlV0f/+oLwIdzkEDMHUoekQGSdHmP8YlL
         DQ1taVjZHQ1nOKd53WqdOJa66Nocb72pXNJf3Mqx5rv6vDhmJ6CCvamTC5qVT+SuekB6
         R8vw==
X-Gm-Message-State: AOJu0YwpuI37UVtMTm30RA2ny2zpOsslleymvc70WlE4YmzUyDdeBVWP
	5RToKLwkg/kSG9h+LiA2R19HwlfXYpv2OW+nIasCcf/DvYtuQBRKNK2oTw==
X-Gm-Gg: ASbGncuBUdaUuabbCTMix9lMWVsKnYABy0BwWXLVhEBbK9Us8vGFZ6ectNmAyJkXFoj
	lBigcgMj1xY1Eg6ikAcrOuy3oyN7i8T0YlKsXBIaNcYwupaE7wmD9VY4pNnMeuoA3VQrCi/F28X
	RIFbhAL0dJ6aI/bL7RQz3bScw8xlf+bo9CdQjnrfooHdgMl9msStFRXlofgxSiVIIsKbLXqvXsU
	omXSz0URK7N/4eaIQvU3or+waQVpshB9i3gBzgmR+HAbAifyrPoGfJ2rLB8xGJtqPzn7vm4u3/K
	f0R2VpR5TLQ=
X-Google-Smtp-Source: AGHT+IGyaTR9xrxxnqTeeNJHXMvCBbW6CP43AK1sA6OQo3TIklyxBSf9k472HOrHJC8vSJi+bBRvbw==
X-Received: by 2002:a05:6a21:6d97:b0:1ee:be88:f5cf with SMTP id adf61e73a8af0-1eebe88f812mr2227100637.32.1739806064835;
        Mon, 17 Feb 2025 07:27:44 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7325fec3dd9sm5164835b3a.86.2025.02.17.07.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:27:44 -0800 (PST)
Date: Mon, 17 Feb 2025 23:27:42 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 3/8] packed-backend: check whether the "packed-refs" is
 regular file
Message-ID: <Z7NVbvyZTxspTjWX@ArchLinux>
References: <Z7NU5fZfc8vfSvZ0@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NU5fZfc8vfSvZ0@ArchLinux>

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
index a7b6f74b6e..8140a31d07 100644
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
+		ret = error_errno(_("unable to stat %s"), refs->path);
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

