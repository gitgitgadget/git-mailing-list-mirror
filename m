Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCFB30FC1F
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775322775; cv=none; b=DHL9uItkyd2NxEGLJbYJuiONIFVuVsgdqON2c0v4xZfHzP/bj/5tgJQMZQMYU4Hrz+XWLoBrm1bPmQYSVzhYp4Q+1yVqf2XkSA4i/164ELxL2C47it5AwQVDpMS90mpLdsC1vZV/7jhgrKHF2BxQQmBnIOrv/lhTgNY9PATEPKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775322775; c=relaxed/simple;
	bh=o8QcNx4BZP/Zhaa/Gfy4voTq3+FPEs3WhGWGae+0K1M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=SwluEo8TqAL4kYs1jmeGLriTX7rB30kIRK1LseiXraL5OZZqNfz8MPesOpcvNf/js6+KC3cmANnwq22iuH2UhbMaW/+7bRVU2jWePJX1ZWiCSF8OFSos29cFzQ2zWv6BIfeZmUpY0Uu9cuBvwI6tRIOeYQ0vLWBrPgg+W4LIIMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEv/Y6O8; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEv/Y6O8"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so6799573eec.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775322773; x=1775927573; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3Mc13WpW0TGt06CiypciTjbZIk7nD89uoazN3c5BFM=;
        b=ZEv/Y6O8yWPboh/Iux1BlkT2SP7S9z/8FpBsQj1GfEgFyYX4KmAzcBiwVNzSfcr3f7
         zgds0syYrGIDHOuNjqiH71M7gxjr5I6Q8yfb5BwR6ecCAHDhFZ4GLBcDc9hxLslrjD2w
         OsDiVx5YlS5DbcqOAuUaxt6U2QbSZ/1stGXVC0lh6MtipFQRZbvxFkVmH6HO0HbZ5Prh
         SPN2WXA9C7GKzH4M5DlJl+t9H7y5wxd0TwAB+rEyB3N/XExL6YAEvHXj9vxK/fubwfeT
         Gr+3ORfSPXs1NnUS/v8gt1zFP2GjavOJPYfb5SjhGCY/JjKp7q0TfbVaEC8/hFPUE23X
         TXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775322773; x=1775927573;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z3Mc13WpW0TGt06CiypciTjbZIk7nD89uoazN3c5BFM=;
        b=p51NfptZYoI5b59gD1hpNM1gSBu3kx7Ozdv/OXBcJVnIcwtQWZ8xU3rsM5tKTxym3I
         JGt+5Ki/jsWunqSscuxKSJiq259Nv0ycZXnjFKlUjyZrDV0ZHt09np8HvJrMzcXxEaO1
         303E9L1H4rqLh/LkYm5rO8bDQNFnCp0aTgDkmhZ73t5z6gLJbSzQMVQH42bK+3Q1EH9Q
         O7XackL6b4iWlcCj49MvphK7nTKqAxtqzsRpKZ1/CABa4djY9P28uRB5d1bca/LzT33j
         mPbR34dYntwpROIpQHq7jqqhuNV3rstiqueHDwCwlHwh6gAqRB+z0hUSk3tuUY71w9r6
         LZoQ==
X-Gm-Message-State: AOJu0YzVa0n7sJ88DChmmW+kRNeYtp/cKgI+a4Hb1xJqK8hrT76gB3KN
	//XqIbYVFuPckox13HAXaj/sUphkTz/I90ZpTL9urD8OSJxrTUNzaOdEooKHog==
X-Gm-Gg: AeBDiesc9d8D+HGBlep5Lh7nKfGqxcVXQnsCKfE1CsA4WrDsEtM1ytYXKcCZM6MuBvD
	l6KC04VamXVGvklPRop/azDcmNKsec06IzABsosYYhfTusjo45nPumSJb1SI5bn33aWAnB8vGCT
	WFuTT/m81x3KsC2SSVIUyUuO+fFGoIMNXhpvCf4hcq62YRwSGG1xGbDF6bbPGlqU2MsCiFOfr7i
	d+ZZgweUdggqW0ry1uuXxOiAKZS9CSY4aAYRAFBjFi3RMpeLFis2tWyA6rDmYkyBSuUgqjxBmrm
	BhJPwZWMoCjCybRCyG7Kg8BSzDyD9s9bE8GYFtv5Qz27O+NT/DxTGYDYyywx7Aka4TRBrTeSDyX
	5RhxSaKZTZIz7t0ka2t4p87K+5jMkcwP3BX80ln4bquHMdPix0d3prR2uIDVDEjPqAF71PVnnFa
	nS123EZ+B2HYBWCFxm0vn0Pi9Wjg==
X-Received: by 2002:a05:7300:ac83:b0:2be:a2d8:e9e3 with SMTP id 5a478bee46e88-2cbfc6586bamr3742030eec.29.1775322772947;
        Sat, 04 Apr 2026 10:12:52 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.111.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c3010e9sm11259433eec.14.2026.04.04.10.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 10:12:52 -0700 (PDT)
Message-Id: <5c20164270ab0971b7f4e429d4ec5cffbde16c55.1775322767.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2077.git.1775322767.gitgitgadget@gmail.com>
References: <pull.2077.git.1775322767.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 17:12:46 +0000
Subject: [PATCH 3/4] doc: convert git-shortlog manual page to synopsis style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

     * convert commands and options to synopsis style
     * use _<placeholder>_ for arguments
     * small style fixes

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-shortlog.adoc | 60 ++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-shortlog.adoc b/Documentation/git-shortlog.adoc
index a11b57c1cd..e067d39b38 100644
--- a/Documentation/git-shortlog.adoc
+++ b/Documentation/git-shortlog.adoc
@@ -3,63 +3,63 @@ git-shortlog(1)
 
 NAME
 ----
-git-shortlog - Summarize 'git log' output
+git-shortlog - Summarize `git log` output
 
 SYNOPSIS
 --------
-[verse]
-'git shortlog' [<options>] [<revision-range>] [[--] <path>...]
-git log --pretty=short | 'git shortlog' [<options>]
+[synopsis]
+git shortlog [<options>] [<revision-range>] [[--] <path>...]
+git log --pretty=short | git shortlog [<options>]
 
 DESCRIPTION
 -----------
-Summarizes 'git log' output in a format suitable for inclusion
+Summarizes `git log` output in a format suitable for inclusion
 in release announcements. Each commit will be grouped by author and title.
 
 Additionally, "[PATCH]" will be stripped from the commit description.
 
 If no revisions are passed on the command line and either standard input
-is not a terminal or there is no current branch, 'git shortlog' will
+is not a terminal or there is no current branch, `git shortlog` will
 output a summary of the log read from standard input, without
 reference to the current repository.
 
 OPTIONS
 -------
 
--n::
---numbered::
+`-n`::
+`--numbered`::
 	Sort output according to the number of commits per author instead
 	of author alphabetic order.
 
--s::
---summary::
+`-s`::
+`--summary`::
 	Suppress commit description and provide a commit count summary only.
 
--e::
---email::
+`-e`::
+`--email`::
 	Show the email address of each author.
 
---format[=<format>]::
+`--format[=<format>]`::
 	Instead of the commit subject, use some other information to
-	describe each commit.  '<format>' can be any string accepted
-	by the `--format` option of 'git log', such as '* [%h] %s'.
-	(See the "PRETTY FORMATS" section of linkgit:git-log[1].)
+	describe each commit. _<format>_ can be any string accepted
+	by the `--format` option of `git log`, such as '* [%h] %s'.
+	(See the 'PRETTY FORMATS' section of linkgit:git-log[1].)
 +
 Each pretty-printed commit will be rewrapped before it is shown.
 
---date=<format>::
+`--date=<format>`::
 	Show dates formatted according to the given date string. (See
-	the `--date` option in the "Commit Formatting" section of
+	the `--date` option in the 'Commit Formatting' section of
 	linkgit:git-log[1]). Useful with `--group=format:<format>`.
 
---group=<type>::
-	Group commits based on `<type>`. If no `--group` option is
-	specified, the default is `author`. `<type>` is one of:
+`--group=<type>`::
+	Group commits based on _<type>_. If no `--group` option is
+	specified, the default is `author`. _<type>_ is one of:
 +
 --
  - `author`, commits are grouped by author
  - `committer`, commits are grouped by committer (the same as `-c`)
- - `trailer:<field>`, the `<field>` is interpreted as a case-insensitive
+ - `trailer:<field>`, the _<field>_ is interpreted as a case-insensitive
    commit message trailer (see linkgit:git-interpret-trailers[1]). For
    example, if your project uses `Reviewed-by` trailers, you might want
    to see who has been reviewing with
@@ -76,7 +76,7 @@ unless the `--email` option is specified. If the value cannot be parsed
 as an identity, it will be taken literally and completely.
 
  - `format:<format>`, any string accepted by the `--format` option of
-   'git log'. (See the "PRETTY FORMATS" section of
+   `git log`. (See the 'PRETTY FORMATS' section of
    linkgit:git-log[1].)
 --
 +
@@ -85,11 +85,11 @@ value (but again, only once per unique value in that commit). For
 example, `git shortlog --group=author --group=trailer:co-authored-by`
 counts both authors and co-authors.
 
--c::
---committer::
+`-c`::
+`--committer`::
 	This is an alias for `--group=committer`.
 
--w[<width>[,<indent1>[,<indent2>]]]::
+`-w[<width>[,<indent1>[,<indent2>]]]`::
 	Linewrap the output by wrapping each line at `width`.  The first
 	line of each entry is indented by `indent1` spaces, and the second
 	and subsequent lines are indented by `indent2` spaces. `width`,
@@ -98,16 +98,16 @@ counts both authors and co-authors.
 If width is `0` (zero) then indent the lines of the output without wrapping
 them.
 
-<revision-range>::
+`<revision-range>`::
 	Show only commits in the specified revision range.  When no
-	<revision-range> is specified, it defaults to `HEAD` (i.e. the
+	_<revision-range>_ is specified, it defaults to `HEAD` (i.e. the
 	whole history leading to the current commit).  `origin..HEAD`
 	specifies all the commits reachable from the current commit
 	(i.e. `HEAD`), but not from `origin`. For a complete list of
-	ways to spell <revision-range>, see the "Specifying Ranges"
+	ways to spell _<revision-range>_, see the 'Specifying Ranges'
 	section of linkgit:gitrevisions[7].
 
-[--] <path>...::
+`[--] <path>...`::
 	Consider only commits that are enough to explain how the files
 	that match the specified paths came to be.
 +
-- 
gitgitgadget

