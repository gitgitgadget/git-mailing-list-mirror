Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665D4EB38
	for <git@vger.kernel.org>; Sat, 10 May 2025 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746880493; cv=none; b=nZHYiMH9z7GsiiLbKnc+pqoP6w6GpDIGWs4T3AU2aXynMmheqGJz2Oe+2qsxj0yThn0R3TTJ/pOARCuriYCTdUhMwNpqRj6SsmNGxZnLHYALJx0RVqowNQnq6TI93xkF4IOqpaU9M7qVHOI8tkln6TclLhN3AhUeJkoXIEEQUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746880493; c=relaxed/simple;
	bh=Spoz+SYin3Nyjf8insihZ1fjDua6MKK9H5R/iUPbwCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYGx9k9hfPB/Ct/5ftkS0lCE7OhjGcZV7tVNMGqdVHQCJKkquqGFUTohWOKA9P+G+IAgFgJJn8BPAvgnRbNAfkJ4RNRDZBIQIUMUA4rvJ+F1lFbL1hE903LsI5H/vyStROPcxhz7Y2BObzJEFUtguUyixfql+mec5IJyl7FBH2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from cayenne.. (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 233ED13FA3D;
	Sat, 10 May 2025 14:34:46 +0200 (CEST)
From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v3 3/4] git-verify-* doc: update mark-up of synopsis option descriptions
Date: Sat, 10 May 2025 14:33:16 +0200
Message-ID: <20250510123346.20927-4-jn.avila@free.fr>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250510123346.20927-1-jn.avila@free.fr>
References: <20250501213414.370514-1-gitster@pobox.com>
 <20250510123346.20927-1-jn.avila@free.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

To unify mark-up used in our documentation to a newer convention,
started by 22293895 (doc: apply synopsis simplification on git-clone
and git-init, 2024-09-24), update the documentation pages for 'git
verify-commit', 'git verify-tag', and 'git verify-pack' to

 * use [synopsis], not [verse] in the SYNOPSIS section
 * enclose `--option=<value>` in backquotes
 * do not describe non-option arguments in the OPTIONS section

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-verify-commit.adoc | 16 +++++++---------
 Documentation/git-verify-pack.adoc   | 28 ++++++++++++----------------
 Documentation/git-verify-tag.adoc    | 16 +++++++---------
 3 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-verify-commit.adoc b/Documentation/git-verify-commit.adoc
index aee4c40eac..ff5b8b97ef 100644
--- a/Documentation/git-verify-commit.adoc
+++ b/Documentation/git-verify-commit.adoc
@@ -7,26 +7,24 @@ git-verify-commit - Check the GPG signature of commits
 
 SYNOPSIS
 --------
-[verse]
-'git verify-commit' [-v | --verbose] [--raw] <commit>...
+[synopsis]
+git verify-commit [-v | --verbose] [--raw] <commit>...
 
 DESCRIPTION
 -----------
-Validates the GPG signature created by 'git commit -S'.
+Validates the GPG signature created by `git commit -S`
+on the commit objects given on the command line.
 
 OPTIONS
 -------
---raw::
+`--raw`::
 	Print the raw gpg status output to standard error instead of the normal
 	human-readable output.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Print the contents of the commit object before validating it.
 
-<commit>...::
-	SHA-1 identifiers of Git commit objects.
-
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-verify-pack.adoc b/Documentation/git-verify-pack.adoc
index d7e886918a..b0462d8db3 100644
--- a/Documentation/git-verify-pack.adoc
+++ b/Documentation/git-verify-pack.adoc
@@ -8,43 +8,39 @@ git-verify-pack - Validate packed Git archive files
 
 SYNOPSIS
 --------
-[verse]
-'git verify-pack' [-v | --verbose] [-s | --stat-only] [--] <pack>.idx...
+[synopsis]
+git verify-pack [-v | --verbose] [-s | --stat-only] [--] <pack>.idx...
 
 
 DESCRIPTION
 -----------
-Reads given idx file for packed Git archive created with the
-'git pack-objects' command and verifies the idx file and the
-corresponding pack file.
+Read each idx file for packed Git archive given on the command line,
+and verify the idx file and the corresponding pack file.
 
 OPTIONS
 -------
-<pack>.idx ...::
-	The idx files to verify.
-
--v::
---verbose::
+`-v`::
+`--verbose`::
 	After verifying the pack, show the list of objects contained
 	in the pack and a histogram of delta chain length.
 
--s::
---stat-only::
+`-s`::
+`--stat-only`::
 	Do not verify the pack contents; only show the histogram of delta
 	chain length.  With `--verbose`, the list of objects is also shown.
 
-\--::
+`--`::
 	Do not interpret any more arguments as options.
 
 OUTPUT FORMAT
 -------------
-When specifying the -v option the format used is:
+When specifying the `-v` option the format used is:
 
-	SHA-1 type size size-in-packfile offset-in-packfile
+	object-name type size size-in-packfile offset-in-packfile
 
 for objects that are not deltified in the pack, and
 
-	SHA-1 type size size-in-packfile offset-in-packfile depth base-SHA-1
+	object-name type size size-in-packfile offset-in-packfile depth base-object-name
 
 for objects that are deltified.
 
diff --git a/Documentation/git-verify-tag.adoc b/Documentation/git-verify-tag.adoc
index 81d50ecc4c..b3721a86f4 100644
--- a/Documentation/git-verify-tag.adoc
+++ b/Documentation/git-verify-tag.adoc
@@ -7,26 +7,24 @@ git-verify-tag - Check the GPG signature of tags
 
 SYNOPSIS
 --------
-[verse]
-'git verify-tag' [-v | --verbose] [--format=<format>] [--raw] <tag>...
+[synopsis]
+git verify-tag [-v | --verbose] [--format=<format>] [--raw] <tag>...
 
 DESCRIPTION
 -----------
-Validates the gpg signature created by 'git tag'.
+Validates the gpg signature created by `git tag` in the tag
+objects listed on the command line.
 
 OPTIONS
 -------
---raw::
+`--raw`::
 	Print the raw gpg status output to standard error instead of the normal
 	human-readable output.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Print the contents of the tag object before validating it.
 
-<tag>...::
-	SHA-1 identifiers of Git tag objects.
-
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.48.0

