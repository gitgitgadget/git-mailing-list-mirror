Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74B22030A
	for <git@vger.kernel.org>; Sun, 18 Aug 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723993275; cv=none; b=ZcOOvGrzqtU2fFQmkQXc1P6vzuVu9JKsJAe1hz0r24UMXZAmKnQA6r2j2cRvOWALw7929g+jmFvKR1AFIET9Rg6suI7h8D8CW1V7SwPwJPs6lUIKjiDifr/TpvD/EI09VHI6yqZ0z7WUai8Ip8chR+U6+8rtqZRwIOyYRRKL5fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723993275; c=relaxed/simple;
	bh=Zz+nnlGp2ks0g1HFORfhfEwpHfemz4GyC6CftzKBQJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYsY+Eb9HJ4yNX9SLN4s9iUBeMOOWw6blyyBcP9asInvwo93RH20xqiMxT0FBC6UGrtwMMTZHq0t0QTLaifGuCHcEJ3ThVERItGBSk+woT2jcu6MQnqgxaJg5iHd/UAQBwcz+JgeVU+v6zeXxKqcup2ppUmlzjjVnXNwPmgsgaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUGA3+nw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUGA3+nw"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3c05dc63eso2585389a91.0
        for <git@vger.kernel.org>; Sun, 18 Aug 2024 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723993272; x=1724598072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1B5FyzX7CLB7sr9powUtRqhJHBICxPMVl7lEh95rJs=;
        b=aUGA3+nwhGt2aHzqubsjUCiRcfYCzswpEjkQjFKY4Jy3HEOBk09B9CEXKZkBsBDXX/
         uw9cjHvJ+DL/DLFfd/z+TCVgzsv7Vb5rpdZBprizqqhlT6sGnmfHTQ1DBrZ5+U58eKYJ
         XWhaW0YT1mlmWC3MtyDgE61zVbejO+nGb5j14/vxHXuDoCm821Hfkib5vddpJvDneeiU
         OkDpQWMgpSQJ5ssuKlwJpiqrHpViWda1ZDssq2elXJGrp0gv33LKYJ0FJeGm/5jMGCNi
         A1xV93MtfZi9QVvXALLUA/XXxFyOHKmhcBvvBJasyuG9eAcTTQO1U2FfvmHFyD0vTUL+
         b+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723993272; x=1724598072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1B5FyzX7CLB7sr9powUtRqhJHBICxPMVl7lEh95rJs=;
        b=LAuhDc60pd7gDWzHMIVjnnSLQhvt1jzFu6BA4DvHcYh/T7oPD30eU9nFaTkPj5IQbD
         Prlb2raQ+DpYBcv1wHKkmCYxbSVh2dBqAnBHpryfsZKClY54lkjbK0vqEvX9NAVF0HxP
         iFkSCr/Q3z9m9tPuwyxPx/mUxPOK6YIBA9z0pab6HlfFCFy6c4HgX9Rr4+G+36cPD7eD
         llpMidS0ITobE5gOr3nDb6FZ0tcJ7QwAR8FOYtKDjw0oZkwqSsBhZI9Ym2OSjSEKoN8o
         L4dM68LOu3dlJqGKWkkwb2zgSUO1ZSV2Kpi1jRvGzFErB0ur5QNhwoD0MY2nXBeHN8rD
         ge6g==
X-Gm-Message-State: AOJu0Yxw8UjBe6TxvEHaKtnj0O9X64l676yEzTw6F9yRZ9K1AHwR23eo
	nEJJz//T5QqxmS4fDfsGxUke32DD71qfwhLoSDH3INT7uh5u2v0uBgpagA==
X-Google-Smtp-Source: AGHT+IGN4ar71xQeXrBXg4fqeEwItKc/zhETpF4Mm64Q+I34d2ScS5TupGGSWrYAHZKiBZaOaLE2fg==
X-Received: by 2002:a17:90a:fa8e:b0:2d4:6ef:cb14 with SMTP id 98e67ed59e1d1-2d406efccc1mr5080469a91.28.1723993271896;
        Sun, 18 Aug 2024 08:01:11 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3d0b3b6fcsm6667045a91.43.2024.08.18.08.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 08:01:11 -0700 (PDT)
Date: Sun, 18 Aug 2024 23:01:52 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 3/4] ref: add symbolic ref content check for files backend
Message-ID: <ZsIM4OZWfylcP5Ix@ArchLinux>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsIMc6cJ-kzMzW_8@ArchLinux>

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
symbolic contents.

1. "ref: refs/heads/master garbage\n"
2. "ref: refs/heads/master \n\n\n garbage  "

In order to provide above checks, we will traverse the "pointee" to
report the user whether this is null-garbage or no newline. And if
symbolic refs contain non-null garbage, we will report
"FSCK_MSG_BAD_REF_CONTENT" to the user.

Then, we will check the name of the "pointee" is correct by using
"check_refname_format". And then if we can access the "pointee_path" in
the file system, we should ensure that the file type is correct.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  3 ++
 fsck.h                        |  1 +
 refs/files-backend.c          | 87 +++++++++++++++++++++++++++++++++++
 t/t0602-reffiles-fsck.sh      | 52 +++++++++++++++++++++
 4 files changed, 143 insertions(+)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 1688c2f1fe..73587661dc 100644
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
index 975d9b9da9..985b674dd9 100644
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
index ae71692f36..bfb8d338d2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3434,12 +3434,92 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
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
+	unsigned int newline_num = 0;
+	unsigned int space_num = 0;
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
+	while (*p != '\0') {
+		if ((space_num || newline_num) && !isspace(*p)) {
+			ret = fsck_report_ref(o, report,
+					      FSCK_MSG_BAD_REF_CONTENT,
+					      "contains non-null garbage");
+			goto out;
+		}
+
+		if (*p == '\n') {
+			newline_num++;
+		} else if (*p == ' ') {
+			space_num++;
+		}
+		p++;
+	}
+
+	if (space_num || newline_num > 1) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_TRAILING_REF_CONTENT,
+				      "trailing null-garbage");
+	} else if (!newline_num) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_REF_MISSING_NEWLINE,
+				      "missing newline");
+	}
+
+	strbuf_rtrim(pointee_name);
+
+	if (check_refname_format(pointee_name->buf, 0)) {
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
 	struct fsck_ref_report report = FSCK_REF_REPORT_DEFAULT;
+	struct strbuf pointee_path = STRBUF_INIT;
 	struct strbuf ref_content = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct strbuf refname = STRBUF_INIT;
@@ -3482,6 +3562,12 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
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
 	}
 
@@ -3489,6 +3575,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	strbuf_release(&refname);
 	strbuf_release(&ref_content);
 	strbuf_release(&referent);
+	strbuf_release(&pointee_path);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 7c1910d784..e8fc2ef015 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -176,4 +176,56 @@ test_expect_success 'regular ref content should be checked' '
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

