Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C381D0959
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366000; cv=none; b=tEeYIhDP/jO42x1DC91p+LVjiqevhGNh8DmsHc952/sUVI/WepRl1ds2p8EcoGQPmPARfXxPpQXbPobYaNdyKoZmGx1yXRf9aWnpVWkYzWZpU+adWeHVdKP3W2yQSyjJGWcvWeK4So9iHxPS3Ks0LTcfdpbiEJ1YDN7E6IbruE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366000; c=relaxed/simple;
	bh=nTUFVEU1sg54y98hc6zSfI27BEdRfK80ULzDm+q50fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdlnxBG7gtRqLO6FX3nmiRNy6IshFAuhBsU/MYWtE5CWaqVHDUQLZsNGiJAKswM8PaIGACWtV+x3hSash0rK+NuAHJu3Xz10O9VzQ+yohaw47lCkJhKSjt55EOwIfxRUiyXfQVVKWsHjyQsvQfWnTUYY0yWUh1EjKBd/ylCE2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBj2NCX/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBj2NCX/"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2057917c493so14699155ad.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725365997; x=1725970797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqogiwME54/0KhEoXddl+tZPabeEmKtz8FYWOuboFvk=;
        b=BBj2NCX/T9XqCbPxZXgvalJ4IfAr0/dmubDBRj5JdXsUlOVTGmz+CuoV1Wy+BAVCNK
         ttn9KPHEvLUsCAyX1DFItTcavdQAX6KEVY9U3MqIyfUSWvRzjPFCkd0V7/p4a9kWWK4G
         xj0alGDqVbBQe9MvkhHIDBgATIsY43WNziLqLRX39T0lQ3Zjt/6JbWkXJ+mz3YYJdnDd
         aQ0a07hP7uTMZeYAFOa0E6adBOR/Xby4EvktqAPiEeXMaL8cAAapoy4mpuXq8r/MGvjc
         l/LiWY0xd6voy6c9qXPkdW6V05oLJja9TAgWjaztUBD2uodmtyyf42BB9bkJiFyFUwlM
         +CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725365997; x=1725970797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqogiwME54/0KhEoXddl+tZPabeEmKtz8FYWOuboFvk=;
        b=BRRXqcXbC9nxgus64A7V6EF++bxafXcl/OK9eRMk7rAv/Nx6cRBWKbl9BvA3Veuf6P
         rPTCpYjrQe1gQGhpLHICZueRJJdjXO8M7UXKE1o+HMFkRwA15jGKowjFwmLururXhp+x
         kiRdaSHJjufocFzfjL0JQTaTZsGUaFlQ7Xh+ZbsDWz9Z3gQyUERHh+EOXL1UQoEgjJaG
         nvtGOuGiSE8D/Hh/gwdhVGTeJaPWSSZjVSaQcxf8DtmJlw+ABAyf/R4TaexdV7HxMw5F
         aDcuCs2Uul1meEclPNjaLwVybN7VQ0GVxcQnp6lWyjZKiav2A9FN/kKWfuzqRzugS5YW
         u/Og==
X-Gm-Message-State: AOJu0YykyuzRSFueZoc2JqFKarKXdInMAwXetKSQLk+hDYctsbiz2dkd
	vjVZwCCHzNAoK6ix5N3K8VW5Bzw8IU0Ogta5O7jvxrfvgJHFBDB3kJ6BlA==
X-Google-Smtp-Source: AGHT+IFrm6QXaaslwfrdUvjS1urYLKgIHiDef73a5picF6IJHaPSLxu+GF6oMMW9BMberPw6bJOnOg==
X-Received: by 2002:a17:902:dace:b0:205:8b84:d5e8 with SMTP id d9443c01a7336-2058b84dad4mr92713825ad.18.1725365997330;
        Tue, 03 Sep 2024 05:19:57 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2051553703asm80043785ad.181.2024.09.03.05.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 05:19:56 -0700 (PDT)
Date: Tue, 3 Sep 2024 20:20:54 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/4] ref: add symref content check for files backend
Message-ID: <Ztb_JuMjaoAbIZXq@ArchLinux>
References: <Ztb-mgl50cwGVO8A@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztb-mgl50cwGVO8A@ArchLinux>

We have already introduced the checks for regular refs. There is no need
to check the consistency of the target which the symref points to.
Instead, we just need to check the content of teh symref itself.

In order to check the content of the symref, create a function
"files_fsck_symref_target". It will first check whether the "referent"
is under the "refs/" directory and then we will check the symref
contents.

A regular file is accepted as a textual symref if it begins with
"ref:", followed by zero or more whitespaces, followed by the full
refname, followed only by whitespace characters. We always write
a single SP after "ref:" and a single LF after the refname, but
third-party reimplementations of Git may have taken advantage of the
looser syntax. Put it more specific, we accept the following contents
of the symref:

1. "ref: refs/heads/master   "
2. "ref: refs/heads/master   \n  \n"
3. "ref: refs/heads/master\n\n"

But we do not allow any other trailing garbage. The followings are bad
symref contents which will be reported as fsck error by "git-fsck(1)".

1. "ref: refs/heads/master garbage\n"
2. "ref: refs/heads/master \n\n\n garbage  "

In order to provide above checks, we will first check whether the symref
content misses the newline by peeking the last byte of the "referent" to
see whether it is '\n'.

And we will remember the untrimmed length of the "referent" and call
"strbuf_rtrim()" on "referent". Then, we will call "check_refname_format"
to chceck whether the trimmed referent format is valid. If not, we will
report to the user that the symref points to referent which has invalid
format. If it is valid, we will compare the untrimmed length and trimmed
length, if they are not the same, we need to warn the user there is some
trailing garbage in the symref content.

At last, we need to check whether the referent is the directory. We
cannot distinguish whether the "refs/heads/a" is a directory or not by
using "check_refname_format". We have already checked bad file type when
iterating the "refs/" directory but we ignore the directory. Thus, we
need to explicitly add check here.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |   4 ++
 fsck.h                        |   1 +
 refs/files-backend.c          |  81 +++++++++++++++++++++++
 t/t0602-reffiles-fsck.sh      | 117 ++++++++++++++++++++++++++++++++++
 4 files changed, 203 insertions(+)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 06d045ac48..beb6c4e49e 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -28,6 +28,10 @@
 `badRefName`::
 	(ERROR) A ref has an invalid format.
 
+`badSymrefTarget`::
+	(ERROR) The symref target points outside the ref directory or
+	the name of the symref target is invalid.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
diff --git a/fsck.h b/fsck.h
index b85072df57..5ea874916d 100644
--- a/fsck.h
+++ b/fsck.h
@@ -34,6 +34,7 @@ enum fsck_msg_type {
 	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
+	FUNC(BAD_SYMREF_TARGET, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0187b85c5f..fef32e607f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3434,11 +3434,80 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+/*
+ * Check the symref "referent" and "referent_path". For textual symref,
+ * "referent" would be the content after "refs:".
+ */
+static int files_fsck_symref_target(struct fsck_options *o,
+				    struct fsck_ref_report *report,
+				    struct strbuf *referent,
+				    struct strbuf *referent_path)
+{
+	size_t len = referent->len - 1;
+	const char *p = NULL;
+	struct stat st;
+	int ret = 0;
+
+	if (!skip_prefix(referent->buf, "refs/", &p)) {
+
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_BAD_SYMREF_TARGET,
+				      "points to ref outside the refs directory");
+		goto out;
+	}
+
+	if (referent->buf[referent->len - 1] != '\n') {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_REF_MISSING_NEWLINE,
+				      "missing newline");
+		len++;
+	}
+
+	strbuf_rtrim(referent);
+	if (check_refname_format(referent->buf, 0)) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_BAD_SYMREF_TARGET,
+				      "points to refname with invalid format");
+		goto out;
+	}
+
+	if (len != referent->len) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_TRAILING_REF_CONTENT,
+				      "trailing garbage in ref");
+	}
+
+	/*
+	 * Missing target should not be treated as any error worthy event and
+	 * not even warn. It is a common case that a symbolic ref points to a
+	 * ref that does not exist yet. If the target ref does not exist, just
+	 * skip the check for the file type.
+	 */
+	if (lstat(referent_path->buf, &st))
+		goto out;
+
+	/*
+	 * We cannot distinguish whether "refs/heads/a" is directory or nots by
+	 * using "check_refname_format(referent->buf, 0)". Instead, we need to
+	 * check the file type of the target.
+	 */
+	if (S_ISDIR(st.st_mode)) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_BAD_SYMREF_TARGET,
+				      "points to the directory");
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
+	struct strbuf referent_path = STRBUF_INIT;
 	struct strbuf ref_content = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct strbuf refname = STRBUF_INIT;
@@ -3484,12 +3553,24 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 					      "trailing garbage in ref");
 			goto cleanup;
 		}
+	} else {
+		strbuf_addf(&referent_path, "%s/%s",
+			    ref_store->gitdir, referent.buf);
+		/*
+		 * the referent may contain the spaces and the newline, need to
+		 * trim for path.
+		 */
+		strbuf_rtrim(&referent_path);
+		ret = files_fsck_symref_target(o, &report,
+					       &referent,
+					       &referent_path);
 	}
 
 cleanup:
 	strbuf_release(&refname);
 	strbuf_release(&ref_content);
 	strbuf_release(&referent);
+	strbuf_release(&referent_path);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index a06ad044f2..e0bf8c8c8b 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -209,4 +209,121 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
 	test_cmp expect sorted_err
 '
 
+test_expect_success 'textual symref content should be checked (individual)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
+	git refs verify 2>err &&
+	rm $branch_dir_prefix/branch-good &&
+	test_must_be_empty err &&
+
+	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-no-newline-1: refMissingNewline: missing newline
+	EOF
+	rm $branch_dir_prefix/branch-no-newline-1 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: missing newline
+	warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing-1 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing-2 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing-3 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-complicated: refMissingNewline: missing newline
+	warning: refs/heads/a/b/branch-complicated: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $branch_dir_prefix/a/b/branch-complicated &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-bad-1: badSymrefTarget: points to refname with invalid format
+	EOF
+	rm $branch_dir_prefix/branch-bad-1 &&
+	test_cmp expect err &&
+
+	printf "ref: reflogs/heads/main\n" >$branch_dir_prefix/branch-bad-2 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-bad-2: badSymrefTarget: points to ref outside the refs directory
+	EOF
+	rm $branch_dir_prefix/branch-bad-2 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/a\n" >$branch_dir_prefix/branch-bad-3 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-bad-3: badSymrefTarget: points to the directory
+	EOF
+	rm $branch_dir_prefix/branch-bad-3 &&
+	test_cmp expect err
+'
+
+test_expect_success 'textual symref content should be checked (aggregate)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
+	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
+	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
+	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
+	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
+	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
+	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
+	printf "ref: reflogs/heads/main\n" >$branch_dir_prefix/branch-bad-2 &&
+	printf "ref: refs/heads/a\n" >$branch_dir_prefix/branch-bad-3 &&
+
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-bad-1: badSymrefTarget: points to refname with invalid format
+	error: refs/heads/branch-bad-2: badSymrefTarget: points to ref outside the refs directory
+	error: refs/heads/branch-bad-3: badSymrefTarget: points to the directory
+	warning: refs/heads/a/b/branch-complicated: refMissingNewline: missing newline
+	warning: refs/heads/a/b/branch-complicated: trailingRefContent: trailing garbage in ref
+	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: missing newline
+	warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: trailing garbage in ref
+	warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: trailing garbage in ref
+	warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: trailing garbage in ref
+	warning: refs/heads/branch-no-newline-1: refMissingNewline: missing newline
+	EOF
+	sort err >sorted_err &&
+	test_cmp expect sorted_err
+'
+
 test_done
-- 
2.46.0

