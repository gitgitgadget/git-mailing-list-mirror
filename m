Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E903E16D9CB
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182466; cv=none; b=sp8pNZdb+UB5h+piZxFeTov2WIxGWBb5fW8lhtuPrngsXsQibCYzjcMSwqeCUZGPRfTr5PtAB5XHaPigBY0m0hka8UlfQKEhhb0VHpsnA5bkpErOmUd5QZwBUYbYzlmhSLYuIiu17woSCPTeTgp6p69VFRZCet8nBBZBwnRcavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182466; c=relaxed/simple;
	bh=KfoyAKJWPGHc8g6D2xYX+CKMdHKxCm5taJ9cU92++JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRFvm8zau9lY9VRXa12oU/rvOEEmmbbzCpt0s2RcgToUX9AtUNOxYwKmttfZe8ahUuIIMEAYo1ZBsNicnnKqhV9ztGHgXbLU0rYWJmF1F04nhOMKNr1B7pprOw7tEWkrAylnp0mbp5q2V2iKdvmnv67ZM2LfLan8t3BMFZkX3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn3dHZ6w; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn3dHZ6w"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6f1677b26so5301745ad.0
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 01:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718182463; x=1718787263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Adr1aTY4PIcN/p1Sima3KZzpZR/F0+dyYceAUbihrUM=;
        b=hn3dHZ6wmU53cpkTiFyYcd0Z+qsF8XWgcc3uodF2JdeijxXaZu72PFQ1oA3k1vIq6S
         FVS3yaIbg1y599jhIRchgzDqJs0QKd4wXJwnxARt3VZsmgpqDhHys/pl5NqBMSZDpLQK
         TBoslcgS5A/p/d1YymWJUrs8eyUBsRX1C4w41u+Xki41O0yd0e+co1tT2/VeJEeRkqtt
         qqt03IICbGeNI6EqxM+PFt6Y5zakdUKsUCLOc3xq7FblV4b+l8SzVD/cNypqqQKiDzDW
         kYBzaBorQoPdDPnftFnP4/SAs1LVDvGJlBwWBS8UrRzbc+ueliiy0LmfUxkZclevAC8C
         y5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718182463; x=1718787263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Adr1aTY4PIcN/p1Sima3KZzpZR/F0+dyYceAUbihrUM=;
        b=TnHHtvxnutWv20+yWt3sc3H/csfkY8cUO7uKctjYl283ifDHosKRkXPkeLrCAVmwm9
         sP/4UrK6VTHv7kHeuqYbn5zpSlHFUGgg/n6wbcWYj2MSuRh55stxqbJbNR/uH8cvxP0f
         3Y2zlnS+8MuZgs8TqPYmsyzLpx/EDUmakWhkhmc45Usnd3BkHSDlQ9iMiSKjFeJYcrzd
         ghcYWQS2VV424KB6Ko/6tDsXtVURtBmUGPxkiSVSuohkq8vwt0C4z+Tkfu5ut3eHMeWM
         IGUTY0QXoZPbnXbJb6qCEUmrw9oRVdu50nGU646iAVz3cbF9YQn/y/N9obSqichEUyBc
         PDmQ==
X-Gm-Message-State: AOJu0YzxpLeZIPNsaYxAAC5+mvH0JWXi4YM4zv9eBYyEBio2t7n5mrBi
	TaUfZldbsvXt+BC8wvCOOxpoAGePDFxIrcizLVDUVgZxEz/Oe4rkGczx5+ZX
X-Google-Smtp-Source: AGHT+IHAFinF8LOd8/bsToZpzOSZvWahHFPtLVXdT6bE4CsU4pZT2OZU46uTh839JZMOXqiqyigFgQ==
X-Received: by 2002:a17:902:bf47:b0:1f7:12f5:d7d6 with SMTP id d9443c01a7336-1f83b1b31f8mr14113655ad.33.1718182462672;
        Wed, 12 Jun 2024 01:54:22 -0700 (PDT)
Received: from ArchLinux.localdomain ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6eccc0bd0sm84066855ad.105.2024.06.12.01.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:54:22 -0700 (PDT)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [GSoC][PATCH v2 5/7] files-backend: add unified interface for refs scanning
Date: Wed, 12 Jun 2024 16:53:47 +0800
Message-ID: <20240612085349.710785-6-shejialuo@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
 <20240612085349.710785-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For refs and reflogs, we need to scan its corresponding directories to
check every regular file or symbolic link which shares the same pattern.
Introduce a unified interface for scanning directories for
files-backend.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e965345ad8..b26cfb8ba6 100644
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
@@ -3402,6 +3403,78 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 	return ret;
 }
 
+/*
+ * For refs and reflogs, they share a unified interface when scanning
+ * the whole directory. This function is used as the callback for each
+ * regular file or symlink in the directory.
+ */
+typedef int (*files_fsck_refs_fn)(struct fsck_refs_options *o,
+				  const char *gitdir,
+				  const char *refs_check_dir,
+				  struct dir_iterator *iter);
+
+static int files_fsck_refs_dir(struct ref_store *ref_store,
+			       struct fsck_refs_options *o,
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
+			   struct fsck_refs_options *o)
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
 		      struct fsck_refs_options *o)
 {
@@ -3410,6 +3483,8 @@ static int files_fsck(struct ref_store *ref_store,
 		files_downcast(ref_store, REF_STORE_READ, "fsck");
 
 	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
+	ret = files_fsck_refs(ref_store, o);
+
 	return ret;
 }
 
-- 
2.45.2

