Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751471BFE00
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774841; cv=none; b=alSl0LihpDOZnWnpGjQ30DUjfigCm2AfaOHsus0S/uDQbgPBiuCxZ+TEQtVwEi1tDwtml65hRW7qeYqW/mIxol+z13dEeuOFZBlX52IetLipEG2GffIAuowHxSZOuxZfQa8F2G/czBRm9GQdJ0t2XPb+E/GTo95LHl451lw2Z14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774841; c=relaxed/simple;
	bh=InAbJorLUaGwnIzVrSSSWTe6If+FcIgJ+95pLkQGLiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbowqaB8ogIQhARtVsE8xDo4Oszq5fyOB3hPewKjt7gyUsRLLQOZBG6SATr0a/IVPUD7OinHLu67eKBHnc6FrWhVOMG1/TunXfXBp958cI1Ti8LO0OYbBsrI5h6N+7c9jEkNvUdmqj7itn0X0FPz0Khmn8EkILzggFpGmpjdJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyJOniTf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyJOniTf"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2020ac89cabso51671465ad.1
        for <git@vger.kernel.org>; Tue, 27 Aug 2024 09:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724774838; x=1725379638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GigmFyM2jVUZNw11LS15DDLVzycUW3R7qYop1260sw4=;
        b=PyJOniTf0W4msjxVAN5Id0dgb3ueVCotDFReSTQe085gQuV1uEgHukIUuYaQLOVpHm
         Kd+Lj8W+mmr7xsWRgalqEPprtqNDKNXn081HdRIQxZPpoUF/owkTP7QK5NLvSnNUYnV+
         aYuVEZBK7fRwbpPFJtkX5Xktk4eQTdLIiLWBkTRGhV+75lNceJDBS8ryXp8aJqvq1Dzo
         OdGckpWZ6yMRv1SJyHMgZsc2dM9S0IuV/DrKThskKHFpif7a0qImNFxZPFgOQVsHRTnR
         A41p/iJXgCZpLkuf4F18AfgbfgGmnPH+Os1oEaILVHVDAv/iOOUhxWMgnO2xk03ZrFYt
         uY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724774838; x=1725379638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GigmFyM2jVUZNw11LS15DDLVzycUW3R7qYop1260sw4=;
        b=e60oIz1bxLHfPLe09LuyjSGZPEXesm5gUk6AFhBq3Pt+XR+v2Xtf5/gcBzMiGqZpFE
         61jxOk7YP+blMpibBCOo1cubnYC+s0+WbDHc8T/4LIxEf32tp+Um7ccosqEPNUYvxEpx
         DqZHJ4PbWYYC9aOO89aU08uPKrAuIDMV8T43bYY5gb/Oj4oAiNh8HlFMblkz66rC+PUO
         gkjlTzVr3HyOpAv/u9Bb3xZXDgIyBVrkkKfR6RgCPZKzQXOBHgIQGejn0u8HRbqv0kkG
         AQrEhTRhvcyDwVa44Ou34gaYrs88NQEgTaGtuZ3H3spFfOONvHNGdZ9y+HQrZ/ffQgrB
         RAAQ==
X-Gm-Message-State: AOJu0YxCEIUUlMkHSwUQaW7PUSCUPxlN0ouOFw+SNjqy9JhIwjCHxhKA
	uPSam/A+uw9B/c2cSMotjicDGP1yFjQDK9FzLrDh9oMevqLwW1Z16syvjg==
X-Google-Smtp-Source: AGHT+IHkTn+lJ+DzMddBXHHYP5JikpHnv9vgYfkPHCU16ysHoZa0ujzO6kaKspwJREoVui2kehuzog==
X-Received: by 2002:a17:902:a705:b0:1fc:2e38:d3de with SMTP id d9443c01a7336-2039e443915mr98254315ad.7.1724774837775;
        Tue, 27 Aug 2024 09:07:17 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fc6c26sm85011205ad.297.2024.08.27.09.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:07:17 -0700 (PDT)
Date: Wed, 28 Aug 2024 00:08:07 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] ref: add symbolic ref content check for files backend
Message-ID: <Zs3558scHssaG_XS@ArchLinux>
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

We have already introduced the checks for regular refs. There is no need
to check the consistency of the target which the symbolic ref points to.
Instead, we just check the content of the symbolic ref itself.

In order to check the content of the symbolic ref, create a function
"files_fsck_symref_target". It will first check whether the "pointee" is
under the "refs/" directory and then we will check the "pointee" itself.

There is no specification about the content of the symbolic ref.
Although we do write "ref: %s\n" to create a symbolic ref by using
"git-symbolic-ref(1)" command. However, this is not mandatory. We still
accept symbolic refs with null trailing garbage. Put it more specific,
the following are correct:

1. "ref: refs/heads/master   "
2. "ref: refs/heads/master   \n  \n"
3. "ref: refs/heads/master\n\n"

But we do not allow any non-null trailing garbage. The following are bad
symbolic contents which will be reported as fsck error by "git-fsck(1)".

1. "ref: refs/heads/master garbage\n"
2. "ref: refs/heads/master \n\n\n garbage  "

In order to provide above checks, we will use "strrchr" to check whether
we have newline in the ref content. Then we will check the name of the
"pointee" is correct by using "check_refname_format". If the function
fails, we need to trim the "pointee" to see whether the null-garbage
causes the function fails. If so, we need to report that there is
null-garbage in the symref content. Otherwise, we should report the user
the "pointee" is bad.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  3 ++
 fsck.h                        |  1 +
 refs/files-backend.c          | 77 +++++++++++++++++++++++++++++++++++
 t/t0602-reffiles-fsck.sh      | 54 ++++++++++++++++++++++++
 4 files changed, 135 insertions(+)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index fc074fc571..85fd058c81 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -28,6 +28,9 @@
 `badRefName`::
 	(ERROR) A ref has an invalid format.
 
+`badSymrefPointee`::
+	(ERROR) The pointee of a symref is bad.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
diff --git a/fsck.h b/fsck.h
index b85072df57..cbe837f84c 100644
--- a/fsck.h
+++ b/fsck.h
@@ -34,6 +34,7 @@ enum fsck_msg_type {
 	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
+	FUNC(BAD_SYMREF_POINTEE, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 69c00073eb..382c73fcf7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3434,11 +3434,81 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+/*
+ * Check the symref "pointee_name" and "pointee_path". The caller should
+ * make sure that "pointee_path" is absolute. For symbolic ref, "pointee_name"
+ * would be the content after "refs:".
+ */
+static int files_fsck_symref_target(struct fsck_options *o,
+				    struct fsck_ref_report *report,
+				    const char *refname,
+				    struct strbuf *pointee_name,
+				    struct strbuf *pointee_path)
+{
+	const char *newline_pos = NULL;
+	const char *p = NULL;
+	struct stat st;
+	int ret = 0;
+
+	if (!skip_prefix(pointee_name->buf, "refs/", &p)) {
+
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_BAD_SYMREF_POINTEE,
+				      "points to ref outside the refs directory");
+		goto out;
+	}
+
+	newline_pos = strrchr(p, '\n');
+	if (!newline_pos || *(newline_pos + 1)) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_REF_MISSING_NEWLINE,
+				      "missing newline");
+	}
+
+	if (check_refname_format(pointee_name->buf, 0)) {
+		/*
+		 * When containing null-garbage, "check_refname_format" will
+		 * fail, we should trim the "pointee" to check again.
+		 */
+		strbuf_rtrim(pointee_name);
+		if (!check_refname_format(pointee_name->buf, 0)) {
+			ret = fsck_report_ref(o, report,
+					      FSCK_MSG_TRAILING_REF_CONTENT,
+					      "trailing null-garbage");
+			goto out;
+		}
+
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_BAD_SYMREF_POINTEE,
+				      "points to refname with invalid format");
+	}
+
+	/*
+	 * Missing target should not be treated as any error worthy event and
+	 * not even warn. It is a common case that a symbolic ref points to a
+	 * ref that does not exist yet. If the target ref does not exist, just
+	 * skip the check for the file type.
+	 */
+	if (lstat(pointee_path->buf, &st) < 0)
+		goto out;
+
+	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_BAD_SYMREF_POINTEE,
+				      "points to an invalid file type");
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
 static int files_fsck_refs_content(struct ref_store *ref_store,
 				   struct fsck_options *o,
 				   const char *refs_check_dir,
 				   struct dir_iterator *iter)
 {
+	struct strbuf pointee_path = STRBUF_INIT;
 	struct strbuf ref_content = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct strbuf refname = STRBUF_INIT;
@@ -3482,6 +3552,12 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 						      "trailing garbage in ref");
 				goto cleanup;
 			}
+		} else {
+			strbuf_addf(&pointee_path, "%s/%s",
+				    ref_store->gitdir, referent.buf);
+			ret = files_fsck_symref_target(o, &report, refname.buf,
+						       &referent,
+						       &pointee_path);
 		}
 		goto cleanup;
 	}
@@ -3490,6 +3566,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	strbuf_release(&refname);
 	strbuf_release(&ref_content);
 	strbuf_release(&referent);
+	strbuf_release(&pointee_path);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 7c1910d784..69280795ca 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -176,4 +176,58 @@ test_expect_success 'regular ref content should be checked' '
 	test_cmp expect err
 '
 
+test_expect_success 'symbolic ref content should be checked' '
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
+	printf "ref: refs/heads/branch" > $branch_dir_prefix/branch-1-no-newline &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-1-no-newline: refMissingNewline: missing newline
+	EOF
+	rm $branch_dir_prefix/branch-1-no-newline &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch     " > $branch_dir_prefix/a/b/branch-trailing &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing: refMissingNewline: missing newline
+	warning: refs/heads/a/b/branch-trailing: trailingRefContent: trailing null-garbage
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch\n\n" > $branch_dir_prefix/a/b/branch-trailing &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing: trailingRefContent: trailing null-garbage
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch \n\n " > $branch_dir_prefix/a/b/branch-trailing &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing: refMissingNewline: missing newline
+	warning: refs/heads/a/b/branch-trailing: trailingRefContent: trailing null-garbage
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/.branch\n" > $branch_dir_prefix/branch-2-bad &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-2-bad: badSymrefPointee: points to refname with invalid format
+	EOF
+	rm $branch_dir_prefix/branch-2-bad &&
+	test_cmp expect err
+'
+
 test_done
-- 
2.46.0

