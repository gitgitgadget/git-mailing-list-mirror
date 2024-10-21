Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90951F8F04
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517662; cv=none; b=KATgX9xtw8WnZW08JaEVT4GGBJP9nej72fxFTAXc6AxO/OZIuvgIUQdDv4li+lTIM+pKjCsW5xUPwaRHzXNM7eHXew7h8fqxDRQDcYuac4HUr8i0VmI1DFSr5PZd10JKZaomqvT4iy58UEmhNJ6IidCy1ElwxufgR+0ZaoqoaME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517662; c=relaxed/simple;
	bh=1KOcCGoj/mE52PBsfVdWF/eoGNTmQzd4/kD5fYxFbhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcGXUzVePcIrGnPpu+JwxKiFvkOGouO1l5FNnXq55aj+PzVfs3W69em/sjY1PEFHzUWDAlY8hLI7aGFBzubqR+UpB0L5yJXnka2DaEfEADu8V+84j60tGW6+6a5xKYP7oN/JCwoyMZ8QSh3D3rmNlfIIi9EryrjB/AYQzJZIEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxpciIW+; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxpciIW+"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so3654291a12.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517659; x=1730122459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cOeiroyRx3P8gRdL/jdaG+9kuj82WbmB1b9QRImAsF8=;
        b=kxpciIW+BXMBy4cC9SB0ckeZgxRRGmZg8cx/Aml1PDxvnQ+NO9i2/SjdgZXAiSqY2p
         GknYdxYum27ZhJzfXLrlt56W0QYjB8JQC8PSP9xqgqoPBU8XzMtNDXVKFlsGFQqZrXlm
         OgzCmkk7REKe+E2Q+v8jDHyYH26MRun3v1tUjnfdHqxEHgG3evT0xijcoyQzqOyJ9wOu
         KyxUwYVy6zinZrVk0LehR7bAPm6Fw132h0pMn3cLeol9i5NcF02hjp0sigpcosFL9O6w
         XQMM5X/7jN8szjv8uZXv7XphURhkXlX1B6HHyamsN1R0Yc+l39xplV6h8ANSVKstEGpH
         /djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517659; x=1730122459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOeiroyRx3P8gRdL/jdaG+9kuj82WbmB1b9QRImAsF8=;
        b=CR0KtP9MMpcqus+aHspxi0EgKdGII/s+3Nzfhh66FtvaxA7pfB+bCG4qwQpBNcdBh0
         BCPBHXKYNW274uxdHAtMnVua3Ewwrx+rEOxBbAv6GtCAkMSoiytGkh2IXTEtBDzbm7ms
         GMEP4AOBVvdbJro01KRj2W6Es9843NqGnuVWJOQ8A5uRO9GtSSefigBu9iCMFsSpWjUW
         mUH8AK0jhUHTjw1W3+S7dfbmoxdCI9jasc5/F/X5eWcHLuiv8CcFNuZia9NuSoBahpRA
         9OGVC2laO8q+xvRlpZg3gEIJA52MH6u52Uzuri9UbWJDMyfHNIhuEEia+1ko2fXKqwRk
         ZSuA==
X-Gm-Message-State: AOJu0YySAzQFvOVmRVAqXuFZ+ywKVATmhmobw/kZVjV9byR8+fjVfk00
	m7o66PUYQ/OhETXBHXqf0z9HLX7nLZ/g9Esm162tYoUFzmyCutCSc9zOSmLp
X-Google-Smtp-Source: AGHT+IF4wMiNMNKALOckbbrzG1MLa32ipKGFZ670rG/PTp+NGOg5K18woLNYR21EozlQyvVUIu586w==
X-Received: by 2002:a05:6a21:3a94:b0:1d9:2335:a891 with SMTP id adf61e73a8af0-1d92c5755a0mr15449637637.36.1729517659391;
        Mon, 21 Oct 2024 06:34:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec135663asm2847770b3a.86.2024.10.21.06.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:34:18 -0700 (PDT)
Date: Mon, 21 Oct 2024 21:34:22 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 2/9] ref: check the full refname instead of basename
Message-ID: <ZxZYXpuCD2I_3bNh@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZX5HDdq_R0C77b@ArchLinux>

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
are related to "@" and add tests to exercise the above situations.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c     |  4 ++--
 t/t0602-reffiles-fsck.sh | 30 +++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 03d2503276..f246c92684 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3519,10 +3519,10 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 	if (iter->basename[0] != '.' && ends_with(iter->basename, ".lock"))
 		goto cleanup;
 
-	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
+	strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
+	if (check_refname_format(sb.buf, 0)) {
 		struct fsck_ref_report report = { 0 };
 
-		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
 		report.path = sb.buf;
 		ret = fsck_report_ref(o, &report,
 				      FSCK_MSG_BAD_REF_NAME,
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 71a4d1a5ae..0aee377439 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -25,6 +25,13 @@ test_expect_success 'ref name should be checked' '
 	git tag tag-2 &&
 	git tag multi_hierarchy/tag-2 &&
 
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	EOF
+	test_must_be_empty err &&
+	rm $branch_dir_prefix/@ &&
+
 	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
@@ -33,20 +40,20 @@ test_expect_success 'ref name should be checked' '
 	rm $branch_dir_prefix/.branch-1 &&
 	test_cmp expect err &&
 
-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/'\'' branch-1'\'' &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/heads/@: badRefName: invalid refname format
+	error: refs/heads/ branch-1: badRefName: invalid refname format
 	EOF
-	rm $branch_dir_prefix/@ &&
+	rm $branch_dir_prefix/'\'' branch-1'\'' &&
 	test_cmp expect err &&
 
-	cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/@ &&
+	cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/'\''~tag-2'\'' &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/tags/multi_hierarchy/@: badRefName: invalid refname format
+	error: refs/tags/multi_hierarchy/~tag-2: badRefName: invalid refname format
 	EOF
-	rm $tag_dir_prefix/multi_hierarchy/@ &&
+	rm $tag_dir_prefix/multi_hierarchy/'\''~tag-2'\'' &&
 	test_cmp expect err &&
 
 	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
@@ -60,6 +67,15 @@ test_expect_success 'ref name should be checked' '
 	error: refs/tags/.lock: badRefName: invalid refname format
 	EOF
 	rm $tag_dir_prefix/.lock &&
+	test_cmp expect err &&
+
+	mkdir $tag_dir_prefix/'\''~new-feature'\'' &&
+	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/'\''~new-feature'\''/tag-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/~new-feature/tag-1: badRefName: invalid refname format
+	EOF
+	rm -rf $tag_dir_prefix/'\''~new-feature'\'' &&
 	test_cmp expect err
 '
 
@@ -84,7 +100,7 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	rm $branch_dir_prefix/.branch-1 &&
 	test_cmp expect err &&
 
-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/'\''~branch-1'\'' &&
 	git -c fsck.badRefName=ignore refs verify 2>err &&
 	test_must_be_empty err
 '
-- 
2.47.0

