Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A787153512
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528580; cv=none; b=n/Dc00/19mWRae2FaXLaQq0aiOIu/v/fuT8gC5B7IF6HDsQzaCNGEPuPrM1DbAp/onVgn3YD2LXwX+V6dzBorZPv6eKOA13Tyka8B1L4O/RaKgaIloDidnHpiw4i3Wvrqsi+GzbANprZhdtmf8uJc/WV8FY2RxwXZrIMo1pDYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528580; c=relaxed/simple;
	bh=S0bP3/AX3MX3DxFnCOPiXKJrLhQV20Me5gL9Jqq5Gbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tno0o0O1wuYXODtlqOS2S0vuDgktFvB9S7QvVUpaEmdPNkvro/C9hT/R+dHEw/1ehhCcMcDpaAyoXTcssraFqsMVjqolaHDlhqmNp5i1jkj0dp4Wim2VUMQV2Tj4xs4wiE4czUoxSy3086gXfug1c7rs2mUdIDwXgYR6bj4gm0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkQovh3y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkQovh3y"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb64d627b0so13598065ad.0
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720528577; x=1721133377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=57TGoVIpBiCRGE1WDkAeGjYn5Dq+phJkTaZrEfb0Ta0=;
        b=XkQovh3yaWfB9XXF+pHoWDXTHp4LkuG9stgPERyaQbZtCXi9r1f9cnfqJzMwK4y4jE
         kow04+12Zk4ArYmfliz3VBNTGLBiYXbLUZgJW7Pse/cBcef5kuOuGEd178D8tZF6Pu/h
         qaRYRHDPd16Z94zQKkhHwS3pmYKvB+fTq2O3+BrBpkcJQeUKmgvvnD51zkWWrEOzglf0
         nOfUF5ypdG37hC3hEGufDC/SuSEgrQhfxu/fdx0G6KKADpvCxgaTkeDQ9cC5iBwxPD0N
         Ldodi+8ogGi7SWvwnMIhmqb91LruyE20y9mxjus99UGoy9etZekN2VH2nEaG3n1NagBu
         SbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720528577; x=1721133377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57TGoVIpBiCRGE1WDkAeGjYn5Dq+phJkTaZrEfb0Ta0=;
        b=vKmScYnk12c++0hpijDUH4OLsl39XcGo0yX2eGTIxUbdFoboIlBPGMa2aLp6B1/JNN
         XaiQsMmsXbQA1r87by3Rmegsp2CsX8G0ZH40Ej0UTaxbcZT/GSgBdM0ZsfBuVeuMCuxT
         zBiC9ORHJhxM2JSRqeiTO56rXtwhfTcgBr0fFlSHTcmm2EG2TZBxkT3gowuDEBHSB1XG
         HRERJK2xsnyR5Vj5olhM7xxbkHgiy0JlyOkl92s1NvwGquibp3FB0NbUUdWIALaNRhsb
         Lbavggey+f27bGalfw0vh+N2j0+7cN17ABYyklEsNVIKHjay2TxB8cWmLrU45b4FAmdy
         RaTg==
X-Gm-Message-State: AOJu0Ywa2XQ0baX8TLhmNr+l5t3otRYYbReLGal30hPLKBQa4EtX3Lp1
	2Dex3KZN0rcIN4Xjij2hLjXnH23W3e3GeEMtViHXd3pfk9x/eJBYOGgEQPdR
X-Google-Smtp-Source: AGHT+IH+JpImJJWqnF/6ICh+Au+t+YxG20xkEdd9rkeIJlI8UTS21Bs5Pxnh8BY+IsILPF8aslCSNg==
X-Received: by 2002:a17:902:ecc9:b0:1f7:1b42:431d with SMTP id d9443c01a7336-1fbb6d23aa1mr21822355ad.30.1720528577163;
        Tue, 09 Jul 2024 05:36:17 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca352c1e24sm1768382a91.44.2024.07.09.05.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:36:16 -0700 (PDT)
Date: Tue, 9 Jul 2024 20:36:15 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v9 7/9] files-backend: add unified interface for refs
 scanning
Message-ID: <Zo0uv4MKz2T6sOt7@ArchLinux>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo0sQCBqyxX8dJ-f@ArchLinux>

For refs and reflogs, we need to scan its corresponding directories to
check every regular file or symbolic link which shares the same pattern.
Introduce a unified interface for scanning directories for
files-backend.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c | 77 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d89eeda8ef..84acb58782 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -6,6 +6,7 @@
 #include "../gettext.h"
 #include "../hash.h"
 #include "../hex.h"
+#include "../fsck.h"
 #include "../refs.h"
 #include "refs-internal.h"
 #include "ref-cache.h"
@@ -3408,6 +3409,78 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 	return ret;
 }
 
+/*
+ * For refs and reflogs, they share a unified interface when scanning
+ * the whole directory. This function is used as the callback for each
+ * regular file or symlink in the directory.
+ */
+typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
+				  const char *gitdir,
+				  const char *refs_check_dir,
+				  struct dir_iterator *iter);
+
+static int files_fsck_refs_dir(struct ref_store *ref_store,
+			       struct fsck_options *o,
+			       const char *refs_check_dir,
+			       files_fsck_refs_fn *fsck_refs_fns)
+{
+	const char *gitdir = ref_store->gitdir;
+	struct strbuf sb = STRBUF_INIT;
+	struct dir_iterator *iter;
+	int iter_status;
+	int ret = 0;
+
+	strbuf_addf(&sb, "%s/%s", gitdir, refs_check_dir);
+
+	iter = dir_iterator_begin(sb.buf, 0);
+
+	if (!iter) {
+		ret = error_errno("cannot open directory %s", sb.buf);
+		goto out;
+	}
+
+	while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
+		if (S_ISDIR(iter->st.st_mode)) {
+			continue;
+		} else if (S_ISREG(iter->st.st_mode) ||
+			   S_ISLNK(iter->st.st_mode)) {
+			if (o->verbose_refs)
+				fprintf_ln(stderr, "Checking %s/%s",
+					   refs_check_dir, iter->relative_path);
+			for (size_t i = 0; fsck_refs_fns[i]; i++) {
+				if (fsck_refs_fns[i](o, gitdir, refs_check_dir, iter))
+					ret = -1;
+			}
+		} else {
+			ret = error(_("unexpected file type for '%s'"),
+				    iter->basename);
+		}
+	}
+
+	if (iter_status != ITER_DONE)
+		ret = error(_("failed to iterate over '%s'"), sb.buf);
+
+out:
+	strbuf_release(&sb);
+	return ret;
+}
+
+static int files_fsck_refs(struct ref_store *ref_store,
+			   struct fsck_options *o)
+{
+	int ret;
+	files_fsck_refs_fn fsck_refs_fns[]= {
+		NULL
+	};
+
+	if (o->verbose_refs)
+		fprintf_ln(stderr, "Checking references consistency");
+
+	ret = files_fsck_refs_dir(ref_store, o, "refs", fsck_refs_fns);
+
+	return ret;
+}
+
 static int files_fsck(struct ref_store *ref_store,
 		      struct fsck_options *o)
 {
@@ -3415,7 +3488,9 @@ static int files_fsck(struct ref_store *ref_store,
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "fsck");
 
-	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
+	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o)
+	    | files_fsck_refs(ref_store, o);
+
 	return ret;
 }
 
-- 
2.45.2

