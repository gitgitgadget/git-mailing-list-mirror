Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C0C332EDE
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775322774; cv=none; b=I5z4NTWNzsj6sv4E1KCLWFsrssgR/C+p+std+LdNE/G5UMdI5sheYPzAOi11rEJbcjC0/fnNwTAUyAJUVx4dYn4kFnYTbj7FN3uphCxxoTY9wBNhz7xe9MSFV7SQ4nArH4RrhnnZ7df2w9sLnxwx+KnF01c0/2rNea82NTbv2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775322774; c=relaxed/simple;
	bh=EL94E//iI3nqB4zzwdsi8oFJpyhyBUBYmzwIKY/InBI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=tNvQ3c0dpzFusZDKUM55b7hpEC7HuJEREc0pDZ8LkoR7uM/jYd2jWtBOZbyh9Ox0FqN4owQWAtr8wLyF2DK3zOuja7a+W9DSKHk4hc2ZY3tvlKEZgpHc5QKPyv/s7V0DkXoYZpYcXIrzWbFRDjWQZ5aupXZ42tqjsMg3fOl5NSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qc7dR9fH; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qc7dR9fH"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ce22328930so419209eec.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 10:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775322772; x=1775927572; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAz78+Qzyufjc/IUe0Xw3fqHvutTAv3L1o5GtEyhL44=;
        b=qc7dR9fHM03i+5MzBuKmoldjmy9yBDmPa+9LCj5462iQKc4rX/BXyW1zgR/aZIaA6Q
         Eejz4yIjGA6M4uL9eE3gCyPiIEmas2i3ubOj56D6wqbIFc2xK68/Nmwibh8VEGKMvxGH
         fhv9WasRUWuM2t9cIurvcIK6NllUHb7tiu5KOORU+5D05GLEQD8J2aRQUdsVww+D907p
         Rmp/+hIBZwCwt/iTZbbhsKdv9Z8RXRM/sZcHSfaWCOsSKB4bpbETGtMdrhnKjaEr+8/m
         UrsY1zJnmS2OXaZ0pxm3hSWsNTYjWVY//31qnDwnXUC2lWY1iMdaJP7cqSFyTWg2Ym1q
         xmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775322772; x=1775927572;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RAz78+Qzyufjc/IUe0Xw3fqHvutTAv3L1o5GtEyhL44=;
        b=sKFHQssUa9RLdK9fA0I3jG1yvHRR1HAkeTmkWi0N7uIHscaWY9B4+EZ1hLVCDvW552
         EjTPidMwu/v5IRYMuQOXpvQeNJBSsPQwYqkPKCNjLxhOrYh3YNEOiuDq+War/m42MqDP
         +pZN7UVKLhgBjAo2TDN+F/ItfJHh8WmPq4GSr9NH304/5MgQXqO7LnSRZSxVRvmRkpM3
         sFQJabUWFB421FrmUCh/y5gvWm53Z3aMWPV8Uu/pnF0u6x7XQ9JoHVk0V+XNtMAg251n
         bXAuOgfemg6vjp9sLDqOo+2BTVtLgoQpDttVTjeU7RncOKX8CGPrCzfM7z1FJcTEzzbc
         X+0g==
X-Gm-Message-State: AOJu0YwUa7jRxiWtmDn0yYopTCMzntXnMqf9GAu/kGoYXRxeDU15Wk+w
	ryD5x4b1vdeildUwG8nDe1zVTsVZxcvfJeDzYjhLeUxaTE7J7sjlbm4GLTpdPg==
X-Gm-Gg: AeBDiesf6k8bJWIdq3eYZB3Plx9V3zsn4sITQczkjmycSa/9kMfRFKMba8itobj6Bx6
	4ADBpp9ChIurJIp3M20vjx5I2AOZObjjOX5bPKEhMhSxX+TynwqiTklMCTnpTumJqh2lvEAkBnj
	RFEX23XrbCMk5LeuO9JgtJdkyoGWRj/E0XtVDjOwvK9X5UnVS1Dl7AV1ABfpcdFoJSgqTZNx9Fq
	CNilqMAM3tXRYQF0doDrfmkucz4jtKQEd7V5WASp9i3AvohBWdv7sY6vbOalZqWa/yc2Aj0JD7t
	e12un8AaLZsZ69EXKVliai7Ws+RgI9QIaqFJNpr+uh7g7+tZ22LjCS//pfDb9Y11OjizIghNZ3p
	77MZf65UWoByo9V4e0A0NZ2SWeIjoDp6HnWKodxvEvuflZvc/3z2QCv3sObFSA9srHz1MB4fMqI
	E8kdUHyfsO4ZbSeHfaO7Xa1SXZ0g==
X-Received: by 2002:a05:7300:80d6:b0:2c6:7f49:a876 with SMTP id 5a478bee46e88-2cbfc85e1d5mr3870423eec.31.1775322771712;
        Sat, 04 Apr 2026 10:12:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.111.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cb92ea0ef1sm6185629eec.21.2026.04.04.10.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 10:12:51 -0700 (PDT)
Message-Id: <4e14058f96e7ab49741fd77a5549b8730d046e1e.1775322767.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2077.git.1775322767.gitgitgadget@gmail.com>
References: <pull.2077.git.1775322767.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 17:12:45 +0000
Subject: [PATCH 2/4] doc: convert git-range-diff manual page to synopsis style
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
 Documentation/git-range-diff.adoc | 50 +++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-range-diff.adoc b/Documentation/git-range-diff.adoc
index b5e85d37f1..8805570845 100644
--- a/Documentation/git-range-diff.adoc
+++ b/Documentation/git-range-diff.adoc
@@ -7,8 +7,8 @@ git-range-diff - Compare two commit ranges (e.g. two versions of a branch)
 
 SYNOPSIS
 --------
-[verse]
-'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
+[synopsis]
+git range-diff [--color=[<when>]] [--no-color] [<diff-options>]
 	[--no-dual-color] [--creation-factor=<factor>]
 	[--left-only | --right-only] [--diff-merges=<format>]
 	[--remerge-diff]
@@ -21,14 +21,14 @@ DESCRIPTION
 This command shows the differences between two versions of a patch
 series, or more generally, two commit ranges (ignoring merge commits).
 
-In the presence of `<path>` arguments, these commit ranges are limited
+In the presence of _<path>_ arguments, these commit ranges are limited
 accordingly.
 
 To that end, it first finds pairs of commits from both commit ranges
 that correspond with each other. Two commits are said to correspond when
 the diff between their patches (i.e. the author information, the commit
 message and the commit diff) is reasonably small compared to the
-patches' size. See ``Algorithm`` below for details.
+patches' size. See 'Algorithm' below for details.
 
 Finally, the list of matching commits is shown in the order of the
 second commit range, with unmatched commits being inserted just after
@@ -37,7 +37,7 @@ all of their ancestors have been shown.
 There are three ways to specify the commit ranges:
 
 - `<range1> <range2>`: Either commit range can be of the form
-  `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
+  `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See 'SPECIFYING RANGES'
   in linkgit:gitrevisions[7] for more details.
 
 - `<rev1>...<rev2>`. This is equivalent to
@@ -48,7 +48,7 @@ There are three ways to specify the commit ranges:
 
 OPTIONS
 -------
---no-dual-color::
+`--no-dual-color`::
 	When the commit diffs differ, `git range-diff` recreates the
 	original diffs' coloring, and adds outer -/+ diff markers with
 	the *background* being red/green to make it easier to see e.g.
@@ -56,33 +56,33 @@ OPTIONS
 +
 Additionally, the commit diff lines that are only present in the first commit
 range are shown "dimmed" (this can be overridden using the `color.diff.<slot>`
-config setting where `<slot>` is one of `contextDimmed`, `oldDimmed` and
+config setting where _<slot>_ is one of `contextDimmed`, `oldDimmed` and
 `newDimmed`), and the commit diff lines that are only present in the second
 commit range are shown in bold (which can be overridden using the config
-settings `color.diff.<slot>` with `<slot>` being one of `contextBold`,
+settings `color.diff.<slot>` with _<slot>_ being one of `contextBold`,
 `oldBold` or `newBold`).
 +
 This is known to `range-diff` as "dual coloring". Use `--no-dual-color`
 to revert to color all lines according to the outer diff markers
 (and completely ignore the inner diff when it comes to color).
 
---creation-factor=<percent>::
-	Set the creation/deletion cost fudge factor to `<percent>`.
+`--creation-factor=<percent>`::
+	Set the creation/deletion cost fudge factor to _<percent>_.
 	Defaults to 60. Try a larger value if `git range-diff` erroneously
 	considers a large change a total rewrite (deletion of one commit
 	and addition of another), and a smaller one in the reverse case.
-	See the ``Algorithm`` section below for an explanation of why this is
+	See the 'Algorithm' section below for an explanation of why this is
 	needed.
 
---left-only::
+`--left-only`::
 	Suppress commits that are missing from the first specified range
-	(or the "left range" when using the `<rev1>...<rev2>` format).
+	(or the "left range" when using the `<rev1>...<rev2>` form).
 
---right-only::
+`--right-only`::
 	Suppress commits that are missing from the second specified range
-	(or the "right range" when using the `<rev1>...<rev2>` format).
+	(or the "right range" when using the `<rev1>...<rev2>` form).
 
---diff-merges=<format>::
+`--diff-merges=<format>`::
 	Instead of ignoring merge commits, generate diffs for them using the
 	corresponding `--diff-merges=<format>` option of linkgit:git-log[1],
 	and include them in the comparison.
@@ -93,30 +93,30 @@ have produced. In other words, if a merge commit is the result of a
 non-conflicting `git merge`, the `remerge` mode will represent it with an empty
 diff.
 
---remerge-diff::
+`--remerge-diff`::
 	Convenience option, equivalent to `--diff-merges=remerge`.
 
---notes[=<ref>]::
---no-notes::
+`--notes[=<ref>]`::
+`--no-notes`::
 	This flag is passed to the `git log` program
 	(see linkgit:git-log[1]) that generates the patches.
 
-<range1> <range2>::
+`<range1> <range2>`::
 	Compare the commits specified by the two ranges, where
-	`<range1>` is considered an older version of `<range2>`.
+	_<range1>_ is considered an older version of _<range2>_.
 
-<rev1>...<rev2>::
+`<rev1>...<rev2>`::
 	Equivalent to passing `<rev2>..<rev1>` and `<rev1>..<rev2>`.
 
-<base> <rev1> <rev2>::
+`<base> <rev1> <rev2>`::
 	Equivalent to passing `<base>..<rev1>` and `<base>..<rev2>`.
-	Note that `<base>` does not need to be the exact branch point
+	Note that _<base>_ does not need to be the exact branch point
 	of the branches. Example: after rebasing a branch `my-topic`,
 	`git range-diff my-topic@{u} my-topic@{1} my-topic` would
 	show the differences introduced by the rebase.
 
 `git range-diff` also accepts the regular diff options (see
-linkgit:git-diff[1]), most notably the `--color=[<when>]` and
+linkgit:git-diff[1]), most notably the `--color[=<when>]` and
 `--no-color` options. These options are used when generating the "diff
 between patches", i.e. to compare the author, commit message and diff of
 corresponding old/new commits. There is currently no means to tweak most of the
-- 
gitgitgadget

