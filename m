Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE71BFE00
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774850; cv=none; b=FZ+JyzcLnU/EZGJzvxqNRr+C1Ktqj7r/UehtYyyVuaYqagmgI4wF0rLYAj5B4O81p85XYbl/fyNAT0GZ2gYXO4FiBYh/V5pCLumgDzQWOOKyMw6tKKdR/9MOaRs/K7XEJURIPzupkwLcM+HRFk16HOO69oAvMldh0deJ/5T8gU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774850; c=relaxed/simple;
	bh=SUfPLe2cyTk7OHh9/pNm0aZuQddVHDUpsrnRJd2sN/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf19d9bnIm+SNCsDns0/Pulp/GYYr99c03oP7soXrAKlGJFLxVDAJoC4gkpU1eaypgpCRi64fx7j8fmCftcqt6OOb6veLg/q5wVp/mtB8IQjtUSvPNrFIqvu7uiI2iyeIIiskBh7lJIfe+J1aoAVzCc94r1sXNzoO0t6hgQG2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xuv3U1Uk; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xuv3U1Uk"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71431524f33so4804557b3a.1
        for <git@vger.kernel.org>; Tue, 27 Aug 2024 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724774848; x=1725379648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jsIZ1l/wDwukaEwsniotiPY8pApzP7Lrrjlz3XeAU+s=;
        b=Xuv3U1UkEOZ9G59JGat4f0xw9RGEZmsK1XmjFToFmKibZX4LUhDShU4zn/e22M6gwB
         EsJb+v5mO+WwbK8jFaEpgjdHbIfQZWYRSM3ScmkJiv3W35ugezV0xuwd7s2Q6+NqESNF
         WMfSl7Ps2OkgrSXakVAfeUehKq3HIEJ/4RMfCNU6wtc++1B1MEvk5/e7cOMpQQMTEGUb
         VaPWXt6nR3WKXvzohe2BEXCLxWJDo4IyGqZsSbUalQFbdutjyEXroY5lUsl+CSAy7Z7b
         DxaZEfTEdWDhI56IZZ1OZGWnAI+OAdFptRIQjvC7yBDtVV2dnXwtp7bxEdXUqniETw8f
         qNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724774848; x=1725379648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsIZ1l/wDwukaEwsniotiPY8pApzP7Lrrjlz3XeAU+s=;
        b=RHDMFfmNb/t9oaaQSHjA18lQG+JRGGYueJNC7AkeSUy3tB4bgKHkn6tgP2NtV4Y0ka
         5dmFOUSryYrTKWTc+gcHSLuZQu5KjRmdEcl+mdtHhxmnSVs16eeFGrfW50QQrc+OM0L9
         jzjXhWwmmze0bnHjt4Z+NxBAf2qeAROVH3nwoEQ07JJt5GIvem80B0brdedxLTosPXzM
         31CcC4cnmmPQfwGpn7aDZoIeqYtc9r3lCBGgM7CgvPYcn60EMudKVWsEIyktl+kwmc6B
         gkO3LPwcBaJDgFe9tDcVpKXLqug9fSDzs+5n1ZgXREEynQyr/MBlhHwXnNRx6M5DBl2T
         QWxQ==
X-Gm-Message-State: AOJu0YzUtlUofbwNUqP28qHQ6yoXyioMYVGXT9sh4Rz6J/T28y0Czt7+
	UWVfB3FMyONbP3v+SDr2XDdjlEe3D6UhhbjweOt2laHlehtDYFCxo6ETZg==
X-Google-Smtp-Source: AGHT+IGkKtoH2d/Hx3CVf2W0S6DBfbnpk/AhmhHmZWbDDhNKIUqQPOg2Q3nWWvVeNsypalBv2vmAFA==
X-Received: by 2002:a05:6a00:2d9a:b0:70d:3420:9309 with SMTP id d2e1a72fcca58-715c0003324mr4185208b3a.17.1724774847754;
        Tue, 27 Aug 2024 09:07:27 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715a2c8ecffsm3922937b3a.151.2024.08.27.09.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:07:27 -0700 (PDT)
Date: Wed, 28 Aug 2024 00:08:17 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] ref: add symlink ref check for files backend
Message-ID: <Zs358SAI5AYnX75v@ArchLinux>
References: <Zs348uXMBdCuwF-2@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs348uXMBdCuwF-2@ArchLinux>

We have already introduced "files_fsck_symref_target". We should reuse
this function to handle the symrefs which are legacy symbolic links. We
should not check the trailing garbage for symbolic links. Add a new
parameter "symbolic_link" to disable some checks which should only be
used for symbolic ref.

We firstly use the "strbuf_add_real_path" to resolve the symlinks and
get the absolute path "pointee_path" which the symlink ref points to.
Then we can get the absolute path "abs_gitdir" of the "gitdir". By
combining "pointee_path" and "abs_gitdir", we can extract the
"referent". Thus, we can reuse "files_fsck_symref_target" function to
seamlessly check the symlink refs.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c     | 68 +++++++++++++++++++++++++++++-----------
 t/t0602-reffiles-fsck.sh | 44 ++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 18 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 382c73fcf7..8641e3ba65 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,4 +1,5 @@
 #include "../git-compat-util.h"
+#include "../abspath.h"
 #include "../copy.h"
 #include "../environment.h"
 #include "../gettext.h"
@@ -3437,13 +3438,15 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 /*
  * Check the symref "pointee_name" and "pointee_path". The caller should
  * make sure that "pointee_path" is absolute. For symbolic ref, "pointee_name"
- * would be the content after "refs:".
+ * would be the content after "refs:". For symblic link, "pointee_name" would
+ * be the relative path agaignst "gitdir".
  */
 static int files_fsck_symref_target(struct fsck_options *o,
 				    struct fsck_ref_report *report,
 				    const char *refname,
 				    struct strbuf *pointee_name,
-				    struct strbuf *pointee_path)
+				    struct strbuf *pointee_path,
+				    unsigned int symbolic_link)
 {
 	const char *newline_pos = NULL;
 	const char *p = NULL;
@@ -3458,24 +3461,28 @@ static int files_fsck_symref_target(struct fsck_options *o,
 		goto out;
 	}
 
-	newline_pos = strrchr(p, '\n');
-	if (!newline_pos || *(newline_pos + 1)) {
-		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_REF_MISSING_NEWLINE,
-				      "missing newline");
+	if (!symbolic_link) {
+		newline_pos = strrchr(p, '\n');
+		if (!newline_pos || *(newline_pos + 1)) {
+			ret = fsck_report_ref(o, report,
+					      FSCK_MSG_REF_MISSING_NEWLINE,
+					      "missing newline");
+		}
 	}
 
 	if (check_refname_format(pointee_name->buf, 0)) {
-		/*
-		 * When containing null-garbage, "check_refname_format" will
-		 * fail, we should trim the "pointee" to check again.
-		 */
-		strbuf_rtrim(pointee_name);
-		if (!check_refname_format(pointee_name->buf, 0)) {
-			ret = fsck_report_ref(o, report,
-					      FSCK_MSG_TRAILING_REF_CONTENT,
-					      "trailing null-garbage");
-			goto out;
+		if (!symbolic_link) {
+			/*
+			* When containing null-garbage, "check_refname_format" will
+			* fail, we should trim the "pointee" to check again.
+			*/
+			strbuf_rtrim(pointee_name);
+			if (!check_refname_format(pointee_name->buf, 0)) {
+				ret = fsck_report_ref(o, report,
+						      FSCK_MSG_TRAILING_REF_CONTENT,
+						      "trailing null-garbage");
+				goto out;
+			}
 		}
 
 		ret = fsck_report_ref(o, report,
@@ -3510,9 +3517,12 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 {
 	struct strbuf pointee_path = STRBUF_INIT;
 	struct strbuf ref_content = STRBUF_INIT;
+	struct strbuf abs_gitdir = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct strbuf refname = STRBUF_INIT;
 	struct fsck_ref_report report = {0};
+	const char *pointee_name = NULL;
+	unsigned int symbolic_link = 0;
 	const char *trailing = NULL;
 	unsigned int type = 0;
 	int failure_errno = 0;
@@ -3557,16 +3567,38 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 				    ref_store->gitdir, referent.buf);
 			ret = files_fsck_symref_target(o, &report, refname.buf,
 						       &referent,
-						       &pointee_path);
+						       &pointee_path,
+						       symbolic_link);
 		}
 		goto cleanup;
 	}
 
+	symbolic_link = 1;
+
+	strbuf_add_real_path(&pointee_path, iter->path.buf);
+	strbuf_add_absolute_path(&abs_gitdir, ref_store->gitdir);
+	strbuf_normalize_path(&abs_gitdir);
+	if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
+		strbuf_addch(&abs_gitdir, '/');
+
+	if (!skip_prefix(pointee_path.buf, abs_gitdir.buf, &pointee_name)) {
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_SYMREF_POINTEE,
+				      "point to target outside gitdir");
+		goto cleanup;
+	}
+
+	strbuf_addstr(&referent, pointee_name);
+	ret = files_fsck_symref_target(o, &report, refname.buf,
+				       &referent, &pointee_path,
+				       symbolic_link);
+
 cleanup:
 	strbuf_release(&refname);
 	strbuf_release(&ref_content);
 	strbuf_release(&referent);
 	strbuf_release(&pointee_path);
+	strbuf_release(&abs_gitdir);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 69280795ca..36992fbc7f 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -230,4 +230,48 @@ test_expect_success 'symbolic ref content should be checked' '
 	test_cmp expect err
 '
 
+test_expect_success SYMLINKS 'symbolic ref (symbolic link) content should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	git commit --allow-empty -m initial &&
+	git checkout -b branch-1 &&
+	git tag tag-1 &&
+	git checkout -b a/b/branch-2 &&
+
+	ln -sf ../../../../branch $branch_dir_prefix/branch-symbolic &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-symbolic: badSymrefPointee: point to target outside gitdir
+	EOF
+	rm $branch_dir_prefix/branch-symbolic &&
+	test_cmp expect err &&
+
+	ln -sf ../../logs/branch-bad $branch_dir_prefix/branch-symbolic &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-symbolic: badSymrefPointee: points to ref outside the refs directory
+	EOF
+	rm $branch_dir_prefix/branch-symbolic &&
+	test_cmp expect err &&
+
+	ln -sf ./"branch   space" $branch_dir_prefix/branch-symbolic &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-symbolic: badSymrefPointee: points to refname with invalid format
+	EOF
+	rm $branch_dir_prefix/branch-symbolic &&
+	test_cmp expect err &&
+
+	ln -sf ./".branch" $branch_dir_prefix/branch-symbolic &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-symbolic: badSymrefPointee: points to refname with invalid format
+	EOF
+	rm $branch_dir_prefix/branch-symbolic &&
+	test_cmp expect err
+'
+
 test_done
-- 
2.46.0

