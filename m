Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09853C24
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259635; cv=none; b=jIRZhC0ZyQpVX/mUWIhpa1jWoHXZ7I37iS6fxL2TbSwhS+DrYQ5dHXPq2y+XUl3wYmHqqr0bZDH2y3tmyG0uxYkyhKhdv1jXZgOe2Mh5DNXVYha1ss05jIKnKaTP4P/kz2KVLHn2XYGmkvdY1kIsFxlCXeFddLO7cwLti2wYH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259635; c=relaxed/simple;
	bh=TE8NwQjzKd/O58pspBRA4ktfrmwk6VvxZtCQa0mIB44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/Zhj08VezAPXwGFz6j/XxtS0uMq97Q7usVnV8sTMrpNIQMFnXbGJTFOjKE2QMAMjvtK7pl43JMg/vUd0H94gUp3uYd/iPGyWIppv0Yjf8G0XA10B8AgwLb/FGj4sQZ0smHPlsFzas0S+tr3Gv/8vURFxDEj0UqriCyn/csen48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD+V+HBU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD+V+HBU"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ab34117cc2so2253724a12.0
        for <git@vger.kernel.org>; Mon, 29 Jul 2024 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259632; x=1722864432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XWbdsMOjOn7D48XySucSjLbWZNhjLeRNinKbtQiQV1Y=;
        b=mD+V+HBUxw4yMesZ9qqkyI6R2ODelP+DrU8P4pxs/Z6svc8tDKbNrQPAa6FFeE2Glj
         0F5OgwOxaWGFjZ2w9LfJESyYfdxr9L49Oy/53ATWQcY4qTZ2APeyJYB8FhYPwlvv1Uad
         +3fXx8CDfsGJ5jrYkhfUBX76fmjbpXFWOMZ1kNa/TkYfB18bINAh3qqGiCKyihwOtOQ3
         9+Ua7AFI4Tzbph+nUoC3ZEpBtInt4gMVW6wxI0jRqpJvkzzULY/FtzGT1wxJbLJjLDy5
         Qd/V8ojCOgs9cb9FFaBpdbG7KVAKbMIBIfY7y8Pamf8IcWOJ7QdRTupnLshnmQUbDHHV
         nqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259632; x=1722864432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWbdsMOjOn7D48XySucSjLbWZNhjLeRNinKbtQiQV1Y=;
        b=Tl4uCV9nlJ9FUqYleiOf2AtzjGONy5Wj5eTXIAthEqtleM4ezlOQ+it0pT5A4JVda2
         OkOKbdLoofKvZNVdrdugWjqmMJqaPCrx9GQ2WN9E/sJ07hESSlQy72UbmrboutDh9Tt4
         TFEbgBe1ytX8p3yhkK2i1tZNxIVRugxgk7JZ0mx3lfrdSpILBCo23OZrm1q7tSQVqIG8
         ReJMK5R4YesDOV1y1YsRNq/Lht5/kJ0NAkvqy2BWhBKaiyiwXZhaf13lH8YgSSQHu2uC
         GjdKIz2xLziIlaYAkzo0fIlM9e4752QZ6+njLANpqA8UdsjT9NkXf/HDvTTkfBjq4OTr
         nzcA==
X-Gm-Message-State: AOJu0YwOud+Hh2deynHKocRSjyMsWLma8hoqYYUanHQa+SjhK781VDSU
	XnDeVLD4whjvDEl1zvDJabAb0ZWC8PXqRGY8A1S597pzsb1agEy8Cm9CSw==
X-Google-Smtp-Source: AGHT+IHqazEYZvE9KiRZWKTqw/R8q4Tihx7jK0PR5S8ZuzVu0VUIvl8lZBUHYiuYF+zSk/CwCW/3AA==
X-Received: by 2002:a05:6a20:9146:b0:1c0:eabc:86a8 with SMTP id adf61e73a8af0-1c4a1183fddmr10884498637.5.1722259631894;
        Mon, 29 Jul 2024 06:27:11 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8cd90sm83083115ad.44.2024.07.29.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:27:11 -0700 (PDT)
Date: Mon, 29 Jul 2024 21:27:31 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v13 08/10] files-backend: add unified interface for
 refs scanning
Message-ID: <ZqeYw-k-MzhPTNRf@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqeXrPROpEg_pRS2@ArchLinux>

For refs and reflogs, we need to scan its corresponding directories to
check every regular file or symbolic link which shares the same pattern.
Introduce a unified interface for scanning directories for
files-backend.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c | 74 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4630eb1f80..cb184953c1 100644
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
@@ -3408,13 +3409,84 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
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
+	files_fsck_refs_fn fsck_refs_fns[]= {
+		NULL
+	};
+
+	if (o->verbose)
+		fprintf_ln(stderr, "Checking references consistency");
+
+	return files_fsck_refs_dir(ref_store, o,  "refs", fsck_refs_fns);
+
+}
+
 static int files_fsck(struct ref_store *ref_store,
 		      struct fsck_options *o)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "fsck");
 
-	return refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
+	return refs->packed_ref_store->be->fsck(refs->packed_ref_store, o) |
+	       files_fsck_refs(ref_store, o);
 }
 
 struct ref_storage_be refs_be_files = {
-- 
2.45.2

