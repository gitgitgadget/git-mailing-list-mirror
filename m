Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27F13A88A
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594184; cv=none; b=A+NhT2pW0T2ODY35FJkK5brSbQU6mqlPsjZC1AIdiqaFOgPJt/oNzx9WHYPygyf62DlAeOwTPTADanxdnKZbCUaHyRWaz/hIICkBF/t9OQhkQpnwfHl2dqjBhlQeI2/9aNpc8K53aSPllBfm6avm0JsloD8/YfTKajbUmcmVEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594184; c=relaxed/simple;
	bh=i5WeibbUQfZTyz6ZjfOYSnDJjnxVLNav0adtmjFg7o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lz7v4cV26EcPdioRQ8Iyqi2xJGYXQ/C2G54jo+1HKSxJxzKlVckGan0u/6D5imzuwdDwPejvyynJDBzmlBWu1l3UHlpGBKpU3u+A79Cqr9OsPXKW8f3hMOzdGdCwY+3jP9/7ASee82KpUsh4rKG5rLOdnQvJhVqwqDCcp2uRIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKjGb+iw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKjGb+iw"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b7259be6fso2338365ad.0
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 00:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727594182; x=1728198982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4/GUTGVkhy9V/5Z584JAAPEXUSNAFGcpnh37F59zOQ=;
        b=BKjGb+iwQ/EKPcX/t24uJjEjSSc1Dq0dlhuZgQQ9YjK/ZqXKDLzc/qTKZrMOSXR2zq
         4ka8oOf8oqP3gaZ22a2J/scjyMnB9Yq3Io4TblfyfW34Gw4ykhgMqSN57EhR+VE6IfkQ
         UirwoEyzzPPHVkK48pPPxjiTAMcPdFE7BIAUKiNx4Rm7nYuHqtG0aiDEtg/G7pBNyRrJ
         WmNMD9Xh/G7b1BfOZ0RhHbYIXkSolzoO139XeML+QASXWit2UUI4tfRAcd9OWzK4yjfC
         A+qNu+6ChZgpQQ7BhsiuQClh45ePn6mxpQiLFPt71IwhR27+EXcumiyyo/ieIqEUmfZb
         3Vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727594182; x=1728198982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4/GUTGVkhy9V/5Z584JAAPEXUSNAFGcpnh37F59zOQ=;
        b=ja0/NYgy9XFvt8p5n50ixc6AjABcNQXeLXHsG6J2Qj+mYXx8devcHfF7nRhytYDz78
         xblnOsTZGJlccgs9TIUgbK6mPR5tBAEi8MqbyzzzzQwuI5g3DGeGcwzW2NY2P0iyYb9X
         cBSJv78/qUg4XBei1aAt50qQxL9zwooDz9RF1ExCy+JlaIUqa84klwyvqUKE8JBX9H71
         /kCBgVTGYvJDxJPlMjc4hTl8t75LbR73scNd/9SPRQ0XdXNtoEDCyM0+xUvEQ2iNnAJ2
         y/W9gaKYdahLQ08XWKYiTzPoiw+rs7ocTMCVy3ZzsUjGpen2L17a1ktpTIdhLwWdyWFi
         uJtQ==
X-Gm-Message-State: AOJu0YyCd+B8uN/5VWXrX/NAj+qjLhSbmrV5SLvo+YI6cLddn/hOaVhE
	rb5mnr6A1qlwkdbwNKixT18rVeKq20eCDlyGoaK6Wrt1qtYIaingZ1owng==
X-Google-Smtp-Source: AGHT+IFHzcyboVI8CEolzlNZtvv1TiK/TTVSqUMCkmtSnbZ+MTVCNnj2QnzO/c97JHzm7Pw6ZyIQTg==
X-Received: by 2002:a17:902:dad2:b0:207:45f1:d1fe with SMTP id d9443c01a7336-20b37c120ccmr132649965ad.61.1727594181836;
        Sun, 29 Sep 2024 00:16:21 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d60dfesm35914525ad.52.2024.09.29.00.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 00:16:21 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:16:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 6/9] ref: add escape check for the referent of symref
Message-ID: <Zvj-xaa_j26Auig7@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-DgHqtC30KjJe@ArchLinux>

Ideally, we want to the users use "git symbolic-ref" to create symrefs
instead of writing raw contents into the filesystem. However, "git
symbolic-ref" is strict with the refname but not strict with the
referent. For example, we can make the "referent" located at the
"$(gitdir)/logs/aaa" and manually write the content into this where we
can still successfully parse this symref by using "git rev-parse".

  $ git init repo && cd repo && git commit --allow-empty -mx
  $ git symbolic-ref refs/heads/test logs/aaa
  $ echo $(git rev-parse HEAD) > .git/logs/aaa
  $ git rev-parse test

We may need to add some restrictions for "referent" parameter when using
"git symbolic-ref" to create symrefs because ideally all the
nonpeudo-refs should be located under the "refs" directory and we may
tighten this in the future.

In order to tell the user we may tighten the "escape" situation, create
a new fsck message "escapeReferent" to notify the user that this may
become an error in the future.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  8 ++++++++
 fsck.h                        |  1 +
 refs/files-backend.c          |  7 +++++++
 t/t0602-reffiles-fsck.sh      | 18 ++++++++++++++++++
 4 files changed, 34 insertions(+)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index e0e4519334..223974057d 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -52,6 +52,14 @@
 `emptyName`::
 	(WARN) A path contains an empty name.
 
+`escapeReferent`::
+	(INFO) The referent of a symref is outside the "ref" directory.
+	Although we allow create a symref pointing to the referent which
+	is outside the "ref" by using `git symbolic-ref`, we may tighten
+	the rule in the future. Report to the git@vger.kernel.org
+	mailing list if you see this error, as we need to know what tools
+	created such a file.
+
 `extraHeaderEntry`::
 	(IGNORE) Extra headers found after `tagger`.
 
diff --git a/fsck.h b/fsck.h
index 979d75cb53..5ecee0fda5 100644
--- a/fsck.h
+++ b/fsck.h
@@ -80,6 +80,7 @@ enum fsck_msg_type {
 	FUNC(LARGE_PATHNAME, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(BAD_FILEMODE, INFO) \
+	FUNC(ESCAPE_REFERENT, INFO) \
 	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(GITIGNORE_SYMLINK, INFO) \
 	FUNC(GITATTRIBUTES_SYMLINK, INFO) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 57ac466b64..bd215c8d08 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3520,6 +3520,13 @@ static int files_fsck_symref_target(struct fsck_options *o,
 	orig_last_byte = referent->buf[orig_len - 1];
 	strbuf_rtrim(referent);
 
+	if (!starts_with(referent->buf, "refs/")) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_ESCAPE_REFERENT,
+				      "referent '%s' is outside of refs/",
+				      referent->buf);
+	}
+
 	if (check_refname_format(referent->buf, 0)) {
 		ret = fsck_report_ref(o, report,
 				      FSCK_MSG_BAD_REFERENT,
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 718f6abb71..585f562245 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -370,4 +370,22 @@ test_expect_success 'textual symref content should be checked (aggregate)' '
 	test_cmp expect sorted_err
 '
 
+test_expect_success 'textual symref should be checked whether it is escaped' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	printf "ref: refs-back/heads/main\n" >$branch_dir_prefix/branch-bad-1 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-bad-1: escapeReferent: referent '\''refs-back/heads/main'\'' is outside of refs/
+	EOF
+	rm $branch_dir_prefix/branch-bad-1 &&
+	test_cmp expect err
+'
+
 test_done
-- 
2.46.2

