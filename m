Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7209D770F0
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783037; cv=none; b=MxRu2ot3gJKAGdZoQtEbkfMjPxdETr8nIkaGsNA1TRabXaxbmzvZ6KqrQuqFmGRZRnApDiQHjcQqVp6cBfojI5XcTY+1umxDG3nqv+ktnfmEmvoPBK6DzDeZ9KV8CifMrHWbcuxjjbO8tBOKeMC+lhSp0Cf1PoI5to4kct2nA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783037; c=relaxed/simple;
	bh=08n7DPHdXvQUAImOxYUWMSvkjmt4sf5l7yGSwwRjkf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZU0th5CQtRaxC8k9of0MXOsjwePPLkRUabJwemm8K9a8RfNKlMCOqC8aUYeeFzhGp8l1v6Szd/adiP7Or+cBmlMZhi2VnpH+7PKPQwul879RQSaQTkDizkh1MDr9eB+h937jOpo1W4by4fMsvwbUsBpr2BoFY3Na6l65W61htQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSmWQ0z6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSmWQ0z6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f99fe4dc5aso11287265ad.0
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 00:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718783035; x=1719387835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VrURskpzped2/CY0H6zThCVDKrCajOhzffR3MJDStK4=;
        b=DSmWQ0z6OgF4Zg6tNDtQOSWsOvRpAZdB1XWj0o8VAEuQ91MR7qT6mH4zMHoF2ASzSI
         40DRTgvBB6G2IvSedB6Ls3LOt7CU3aNToGQ3105Jm3XJ5f7y3UNjoweBP6d07wMR96YP
         JtxifIkqqDRWBKgyvcd+ZkkiIuDXhHGGNiIu0obfR97wqi3Yqk0ldg8YPXXuotE2fET5
         WDQWn5y5EDFSIYa6lEu4s032/xdEeEhPlliYsu2KYI2jMhADbu/vEzd0FG7xgUDHDk7a
         PI3Hj2br/q1x1UmYBt1TEVCHU7pRN272xkrLpqemFZnw72KZ0WcRe8x2opWDD9xXAf+j
         ql6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718783035; x=1719387835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrURskpzped2/CY0H6zThCVDKrCajOhzffR3MJDStK4=;
        b=Qt/Vv1cR/mL+C4jiHxXeHBNu5sGLhW+lMT6fvdfr1GctMNOcuOr03RL+QqQ+zscV5t
         48Eg5JjM4PHNwIXEB+puDJoTS6k9gD10+87kNqsm9ba0Rg9VjSvN32zitzSKBnkXqGRZ
         TuXGDSR3v7zPmh0gMzxipMxk6PKgCvZRMIwA2T2zjoYyeJM48fQSpU4DuM3jueP14znn
         uLqfbxxlf/tzTMxnP+LC8LgdhNcPsOpg8hLnFeZeZXjEqXA/F36wAcJlKsgaZvC4NTjJ
         HH3wfN3pcYaUHuS14LfjjM+METjvlci+dVqxSKAwXd/77EnKNfFrDZjqWU/kRl0o9zCB
         zmKQ==
X-Gm-Message-State: AOJu0YxMtbylNMP5kcmUtXxEEyaUxX4NDLfU65jp4stka8AaUABa1MlB
	o/qyqO1PvAbJYAHlZtx0dy9uB87gvaeTpUqxNaGIbaXSDnWNHM6OP0fdYg==
X-Google-Smtp-Source: AGHT+IEfEh6IBXRlSOch+36hRY9pOdAQacig57+3drMJmqzJpE3m9G4gDKgwYNvl4GtAUfwogThIBQ==
X-Received: by 2002:a17:902:e54e:b0:1f7:111c:2d3a with SMTP id d9443c01a7336-1f9aa47cc5cmr19200265ad.65.1718783034625;
        Wed, 19 Jun 2024 00:43:54 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f13dd2sm110040195ad.215.2024.06.19.00.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:43:54 -0700 (PDT)
Date: Wed, 19 Jun 2024 15:43:53 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v4 5/7] files-backend: add unified interface for refs
 scanning
Message-ID: <ZnKMOVsHs-RlheS_@ArchLinux>
References: <ZnKKy52QFO2UhqM6@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKKy52QFO2UhqM6@ArchLinux>

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
index ba9e57d1e9..5156530774 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -4,6 +4,7 @@
 #include "../gettext.h"
 #include "../hash.h"
 #include "../hex.h"
+#include "../fsck.h"
 #include "../refs.h"
 #include "refs-internal.h"
 #include "ref-cache.h"
@@ -3405,6 +3406,78 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
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
+			if (o->verbose)
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
+	if (o->verbose)
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
@@ -3412,7 +3485,9 @@ static int files_fsck(struct ref_store *ref_store,
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

