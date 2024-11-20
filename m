Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054CC19E971
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103470; cv=none; b=Ei2pbdi3WMyYo3FA3PVY3ZGU2TDIIZ33yjjF4EmncZhoHRcZBiSO12ftAY2tkoXyzDxS3J9d/xfphvqMYTT/KOgJPC7zFKVmnW7ZnOu5ZXCSAaHRLrE0Cz8Qjf3OUldXU7qAkEGv9iLKej9zsppGPinHRfGNEw7V+tjHF6CsCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103470; c=relaxed/simple;
	bh=4iAJA46zpl/v6qmBKcIfVl8MSuXSf8PZ1daMDFkHi9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/CRvoGwTj3t0d6fOHfjeiwIEOOsffizlYRdGly83SCRpIz9TR6Y1u5kVasuAizqVhDtoAcgD2bNHmkc3Sik7zHjpvVNgQFru6PPsmzw8lMws7uGewnr3/7tG/kWJlgMZR2LMZWcnuHKylFMEdZiuUdAu7PJzJMs3AtXlvd+TFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eanxGAC3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eanxGAC3"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c805a0753so19912975ad.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 03:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103468; x=1732708268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ML4KPi4wQjf1qC2Qte9G4jPx11iLAGGFB8tIl6WAl74=;
        b=eanxGAC39J83WanP1dqxSEDq8mhbHucLxmvpfaBpXA3UYO9IwSfVJdUT8inWh3C5eN
         Lq86XregXmSlqWZn1XmegNOsjPghDk/9pKadGlEXoVhBQ36UYtjErA9SV2c680eI+GNQ
         fNm0Iea7LZxD4RTVWSGBqp4PyN2vf2xGrFMGGcQfcZCcFiDCc0W4HXoDwqo9iE/dzfXD
         rDpK0iFBh40KtAoRddESji0nrCP9dLy9bKuuYVZw1gEQ6oVjv6XLN7+3ejNQvQEm+r8a
         5PHIArGrdYgipKeE2q/bJiRttEBmJ4CHGMJuyoEUs8LrroyYWdkVJgmj5pOtehVsEF/z
         UZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103468; x=1732708268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML4KPi4wQjf1qC2Qte9G4jPx11iLAGGFB8tIl6WAl74=;
        b=bJau0NfDhaypICpX4yeKBFgoYJp0FVbhIYX12TPewP5UDabWVMDgdxTC6IOR41eXzu
         Vg45Wa64yiXC/RZZGR9U1PmrkSD8XE2/xiJ144Vt+PxEyyjRtjAwnLqbEwHlZnE9pdOC
         ttqJZDtgz6W6gfCGHdhyiyj2Rs/Kep1kGMX8ORTo8KbuMJZ4+pgPC7GWoy9665osmfdh
         LbyAlaHRZPF1WMjr1b/VqqQMjyUusT+XXmtFOC9AZEkkbRrCEExGSZ9DCfBgVWcvoDLi
         ym2LubXoagE5h+4yse5q4Z3WNiW2giOC1OQPqfIppbXxyTPOHyBX/165dSv/I7ssoXWG
         +iaw==
X-Gm-Message-State: AOJu0Yxx/bi8H1uGIzJqdc2whtiPBre9gPNDIrENFnudwiTg9lMvoEKR
	eZoGCMV9sRNZySZ9HbakL0PDSDzQIqdBWi9eQCe22fa8Lhjlcht0Zr5Stg==
X-Gm-Gg: ASbGncterVqB7AnTo+3iiveGbQ482XYVeeJn8W4WEQ9F1rxQcR0XNWNutJ/iX/prvm+
	ROFeJhyFZKXaX00rVx5mgiM+hi5sotZmcpGLTAFM1zqeh/uTWQ96HrLpXFM6aXRfD2mV44IkyQa
	cmdug/60ATLGU7rMd3aw8QquohphuYFLep4ia9vQl3DGAeLDgKejTXvCbqSmK3vivMzZwN1KIEH
	rOgVuNcIbXlapYajTOKEG+Fpkft1aUd0y08k0aCQnaA+w==
X-Google-Smtp-Source: AGHT+IFSFa3q3ex1gM+fk4TihTd9rJp//FNPJXGvmWYcfsmagJeUTmD0sGUwKCmTyGShnqq4CBDKwg==
X-Received: by 2002:a17:903:32c8:b0:20b:a10c:9bdf with SMTP id d9443c01a7336-2126a3f4199mr29128795ad.32.1732103467905;
        Wed, 20 Nov 2024 03:51:07 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead04d2b9dsm1114905a91.33.2024.11.20.03.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:51:07 -0800 (PST)
Date: Wed, 20 Nov 2024 19:51:16 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v9 2/9] ref: check the full refname instead of basename
Message-ID: <Zz3NNLYmCKNyF06i@ArchLinux>
References: <Zz3MON9_9DGD6nsy@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz3MON9_9DGD6nsy@ArchLinux>

In "files-backend.c::files_fsck_refs_name", we validate the refname
format by using "check_refname_format" to check the basename of the
iterator with "REFNAME_ALLOW_ONELEVEL" flag.

However, this is a bad implementation. Although we doesn't allow a
single "@" in ".git" directory, we do allow "refs/heads/@". So, we will
report an error wrongly when there is a "refs/heads/@" ref by using one
level refname "@".

Because we just check one level refname, we either cannot check the
other parts of the full refname. And we will ignore the following
errors:

  "refs/heads/ new-feature/test"
  "refs/heads/~new-feature/test"

In order to fix the above problem, enhance "files_fsck_refs_name" to use
the full name for "check_refname_format". Then, replace the tests which
are related to "@" and add tests to exercise the above situations using
for loop to avoid repetition.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c     |  7 ++-
 t/t0602-reffiles-fsck.sh | 92 ++++++++++++++++++++++++----------------
 2 files changed, 60 insertions(+), 39 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 03d2503276..b055edc061 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3519,10 +3519,13 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 	if (iter->basename[0] != '.' && ends_with(iter->basename, ".lock"))
 		goto cleanup;
 
-	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
+	/*
+	 * This works right now because we never check the root refs.
+	 */
+	strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
+	if (check_refname_format(sb.buf, 0)) {
 		struct fsck_ref_report report = { 0 };
 
-		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
 		report.path = sb.buf;
 		ret = fsck_report_ref(o, &report,
 				      FSCK_MSG_BAD_REF_NAME,
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 71a4d1a5ae..2a172c913d 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -18,63 +18,81 @@ test_expect_success 'ref name should be checked' '
 	cd repo &&
 
 	git commit --allow-empty -m initial &&
-	git checkout -b branch-1 &&
-	git tag tag-1 &&
-	git commit --allow-empty -m second &&
-	git checkout -b branch-2 &&
-	git tag tag-2 &&
-	git tag multi_hierarchy/tag-2 &&
+	git checkout -b default-branch &&
+	git tag default-tag &&
+	git tag multi_hierarchy/default-tag &&
 
-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	error: refs/heads/.branch-1: badRefName: invalid refname format
-	EOF
-	rm $branch_dir_prefix/.branch-1 &&
-	test_cmp expect err &&
-
-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	error: refs/heads/@: badRefName: invalid refname format
-	EOF
+	cp $branch_dir_prefix/default-branch $branch_dir_prefix/@ &&
+	git refs verify 2>err &&
+	test_must_be_empty err &&
 	rm $branch_dir_prefix/@ &&
-	test_cmp expect err &&
 
-	cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/@ &&
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	error: refs/tags/multi_hierarchy/@: badRefName: invalid refname format
-	EOF
-	rm $tag_dir_prefix/multi_hierarchy/@ &&
-	test_cmp expect err &&
-
-	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
+	cp $tag_dir_prefix/default-tag $tag_dir_prefix/tag-1.lock &&
 	git refs verify 2>err &&
 	rm $tag_dir_prefix/tag-1.lock &&
 	test_must_be_empty err &&
 
-	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/.lock &&
+	cp $tag_dir_prefix/default-tag $tag_dir_prefix/.lock &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	error: refs/tags/.lock: badRefName: invalid refname format
 	EOF
 	rm $tag_dir_prefix/.lock &&
-	test_cmp expect err
+	test_cmp expect err &&
+
+	for refname in ".refname-starts-with-dot" "~refname-has-stride"
+	do
+		cp $branch_dir_prefix/default-branch "$branch_dir_prefix/$refname" &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/$refname: badRefName: invalid refname format
+		EOF
+		rm "$branch_dir_prefix/$refname" &&
+		test_cmp expect err || return 1
+	done &&
+
+	for refname in ".refname-starts-with-dot" "~refname-has-stride"
+	do
+		cp $tag_dir_prefix/default-tag "$tag_dir_prefix/$refname" &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/$refname: badRefName: invalid refname format
+		EOF
+		rm "$tag_dir_prefix/$refname" &&
+		test_cmp expect err || return 1
+	done &&
+
+	for refname in ".refname-starts-with-dot" "~refname-has-stride"
+	do
+		cp $tag_dir_prefix/multi_hierarchy/default-tag "$tag_dir_prefix/multi_hierarchy/$refname" &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/multi_hierarchy/$refname: badRefName: invalid refname format
+		EOF
+		rm "$tag_dir_prefix/multi_hierarchy/$refname" &&
+		test_cmp expect err || return 1
+	done &&
+
+	for refname in ".refname-starts-with-dot" "~refname-has-stride"
+	do
+		mkdir "$branch_dir_prefix/$refname" &&
+		cp $branch_dir_prefix/default-branch "$branch_dir_prefix/$refname/default-branch" &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/$refname/default-branch: badRefName: invalid refname format
+		EOF
+		rm -r "$branch_dir_prefix/$refname" &&
+		test_cmp expect err || return 1
+	done
 '
 
 test_expect_success 'ref name check should be adapted into fsck messages' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
-	tag_dir_prefix=.git/refs/tags &&
 	cd repo &&
 	git commit --allow-empty -m initial &&
 	git checkout -b branch-1 &&
-	git tag tag-1 &&
-	git commit --allow-empty -m second &&
-	git checkout -b branch-2 &&
-	git tag tag-2 &&
 
 	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
 	git -c fsck.badRefName=warn refs verify 2>err &&
@@ -84,7 +102,7 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	rm $branch_dir_prefix/.branch-1 &&
 	test_cmp expect err &&
 
-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
 	git -c fsck.badRefName=ignore refs verify 2>err &&
 	test_must_be_empty err
 '
-- 
2.47.0

