Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153311E481;
	Tue, 14 May 2024 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706374; cv=none; b=khsPx7Z09prcdeVuAdNd17uVu1a9vezoV/WEnJ4gSmDim5NDyz+KDwcJvBCPqI7A4j9hzR/V1B77rww58qIeaNxMb8f/T6uVHupa8Yz4Us6oyXegMX/CxkRsZX6NEqnhKZsnxCbNwd1RwXHFH17QSXFxtN1WXyp7jlao8fRSxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706374; c=relaxed/simple;
	bh=OlcChcA2au/wBXzMTkA1+TK5Grh+/q6FUIeZZ8fVvvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r3Bct62O9tmYPqmUXeNRa7JPiwZzu9q3/CKmByHT7YlUDeN44tEbBRICirhgo0SuVzwQjO21e3jrpshA7D4XznYF+ZKlQx3Mt1jpr/RLh7vUaJjdjTXbcFJYkrf1zH0Vj3gFg6ktJFcnqcfGqo6W96aZnXBHivpq67ugE6oFaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RG6JTOPZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RG6JTOPZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B7352F749;
	Tue, 14 May 2024 13:06:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=O
	lcChcA2au/wBXzMTkA1+TK5Grh+/q6FUIeZZ8fVvvw=; b=RG6JTOPZJRyMhJfz7
	eQx2wzenifCmJaEfYB2i64kmkWumHJRsiD3Y4PxTWWJ0isw6yT9GlaFzzYnyPUop
	WfUFXzqDcivJ3FrxJa+BPG0+oTlNGS7FRdHLt1bf+ww7oFwNg1+rFYP0vTWMdIxj
	GEFxLRTG3PnuENpTJ5hPcIgq6g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 507732F748;
	Tue, 14 May 2024 13:06:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D8242F747;
	Tue, 14 May 2024 13:06:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.45.1 and friends
Date: Tue, 14 May 2024 10:06:04 -0700
Message-ID: <xmqqv83g4937.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4025AFF6-1214-11EF-80E0-25B3960A682E-77302942!pb-smtp2.pobox.com

A maintenance release Git v2.45.1, together with releases for older
maintenance tracks v2.44.1, v2.43.4, v2.42.2, v2.41.1, v2.40.2, and
v2.39.4, are now available at the usual places.  These are to address
a handful of security issues.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.45.1'
tag, as well as the tags for older maintenance tracks listed above.

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

The addressed issues are all listed in the release notes for Git
2.39.4, attached below.

Note: There is a regression for Git LFS users.  The defense-in-depth
protection this update contains is at odds with the way Git LFS
currently works when cloning a new repository that wants to use the
post-checkout hook during the initial cloning.  The users can fix it
after the fact by running `git lfs pull`, if the checkout stage is
stopped, as a workaround.  The error message given after a failed
clone also gives an alternative workaround to disable the added
safety with the use of the GIT_CLONE_PROTECTION_ACTIVE environment
variable that the users and the scripts can use.

--------------------------------------------------
Git v2.39.4 Release Notes
=========================

This addresses the security issues CVE-2024-32002, CVE-2024-32004,
CVE-2024-32020 and CVE-2024-32021.

This release also backports fixes necessary to let the CI builds pass
successfully.

Fixes since v2.39.3
-------------------

 * CVE-2024-32002:

   Recursive clones on case-insensitive filesystems that support symbolic
   links are susceptible to case confusion that can be exploited to
   execute just-cloned code during the clone operation.

 * CVE-2024-32004:

   Repositories can be configured to execute arbitrary code during local
   clones. To address this, the ownership checks introduced in v2.30.3
   are now extended to cover cloning local repositories.

 * CVE-2024-32020:

   Local clones may end up hardlinking files into the target repository's
   object database when source and target repository reside on the same
   disk. If the source repository is owned by a different user, then
   those hardlinked files may be rewritten at any point in time by the
   untrusted user.

 * CVE-2024-32021:

   When cloning a local source repository that contains symlinks via the
   filesystem, Git may create hardlinks to arbitrary user-readable files
   on the same filesystem as the target repository in the objects/
   directory.

 * CVE-2024-32465:

   It is supposed to be safe to clone untrusted repositories, even those
   unpacked from zip archives or tarballs originating from untrusted
   sources, but Git can be tricked to run arbitrary code as part of the
   clone.

 * Defense-in-depth: submodule: require the submodule path to contain
   directories only.

 * Defense-in-depth: clone: when symbolic links collide with directories, keep
   the latter.

 * Defense-in-depth: clone: prevent hooks from running during a clone.

 * Defense-in-depth: core.hooksPath: add some protection while cloning.

 * Defense-in-depth: fsck: warn about symlink pointing inside a gitdir.

 * Various fix-ups on HTTP tests.

 * Test update.

 * HTTP Header redaction code has been adjusted for a newer version of
   cURL library that shows its traces differently from earlier
   versions.

 * Fix was added to work around a regression in libcURL 8.7.0 (which has
   already been fixed in their tip of the tree).

 * Replace macos-12 used at GitHub CI with macos-13.

 * ci(linux-asan/linux-ubsan): let's save some time

 * Tests with LSan from time to time seem to emit harmless message that makes
   our tests unnecessarily flakey; we work it around by filtering the
   uninteresting output.

 * Update GitHub Actions jobs to avoid warnings against using deprecated
   version of Node.js.


