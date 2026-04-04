Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77A432ABC0
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775322777; cv=none; b=mnUAV3CQcO0zdYx90oUP+EPEzYy8j9LU3+3MOACuEZxA1wDT0/yTBSRV29jR/DTZjKBnCG6d8u2Use7jHDLVpfOWkg5+Lt0hF7AlqAwYDbr3XvvgVQuZSgwTqSTC72CeUic9wgqLNziM8fv8sFEgZ9obLzAozQaCUpV60DbXyXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775322777; c=relaxed/simple;
	bh=jr3Kei1FwVag68XEhU13mZ3srFqoIppYYVSwpFFfcPM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=IBuoJTYUl3MWfxGhDOn42BQIrtJzsXr7HuRfN2dYQRFxr5q3jHT7DqoL1JpYNanO3FTLc8s2R33KmIuDjJ47BA0fIlxnlD4sk5Ly4uw9qVZSEm6aPyemXSyyeignoeC3MjsDj7IfDAwbp4MHcCOo5K4b2myrns1CF3y9rmwzr3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPuyFt6o; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPuyFt6o"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12732165d1eso4036502c88.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775322774; x=1775927574; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AL+w2KgReozPKO2X3jjf/FUxAK5Bs0F8Nm4PeflW4PI=;
        b=VPuyFt6ofBYZgmNHvwB+5Z9+Bl4CZeps3UfPjqDfA6ibjHEzXYiZTj6FMxhW2Zo04g
         7F33sXQpqrDFJuZB6J9TdAFokq3yIfzv2aMJQgUm6BTa2VArIEmFSENCB3okoTFmAEIz
         xOTTwvb4ypJ5iDJ4Jmu+zBUN2rI8+jsmtAwRRT+NkEHkBt5xNKAgzbK4YRf0AiJ4J6ib
         AWD3V//8TNOdxiYUkGinQdtxFb+RC6SCzC0IPO2nu3XOZL19ZKXSfdRHKfkVu5KRbZBY
         rwH9CBexVI9OTu7WA8BbQ8RapCVQpKR2GJJhHRvA5ytw017A8UddM0F/vyxD6cC3mE86
         acBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775322774; x=1775927574;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AL+w2KgReozPKO2X3jjf/FUxAK5Bs0F8Nm4PeflW4PI=;
        b=VYhUgLopRZlstFcm1Dv3Irz03kn6+792OBvU35ZiI9UaayggLsly/jTTKPDWDxh5S/
         rCnaB32r/uZcSgG8sWISNDko0fZtHa1zdrUz5zxgAVc+fzP4I9PsmfLTo5SsBmC3TmeA
         1clgWerUpKDHNbZ+lHN1mZq9na45x8cnO6NcDGpSNl0qgChjv0JlWRkcq0uCVZkMiBhA
         /wu7KuVZe8p9OMJugQqjnYtNmzwkbRMsMNB5AH+RHdXzMkoY7eudnmktoFx0A0CLWO9r
         BoMVAnE2eIHByJFBmN8kPA0rg7tzTp3ZS6ewTmzdjoioVq8b+DVM4JZ1wk7iy0pFLoIn
         0tYw==
X-Gm-Message-State: AOJu0YwzLyGVZZEiqOKPIGmpYxNg8gLLv1jX+nI9OMxtOSjnJHiz7Xmm
	zwGU3mErg2hmye1RbaEc1XzyFJEFm8q++5gb0UZmb4CF1c4AiXxNXSKClSnpSQ==
X-Gm-Gg: AeBDiev9CQzXsTgaGgf//eD4Ty2p5AIJ70g40UvPQ9mNU+99ariP5YIXjNTOzfDer4q
	LLkqlRPDA3wQniNQh6qEeUMd6lORbQ2WjEGlxz8js/VUjk/Vn9iB6nR7dUSxegfS8CKnLgrFmBc
	i75I34vWltPYZ/m7KwVGo+CkcrnO3fyJT/sRMLdHy6blp1f089ms9LLzFsfIJSw3Wu0Mbtz5pWt
	osfvvW1rHK/mvm08TW1cxvvZFmoobG3arR8I0t2FDS5T3FAwpE6iJ9bUECen1w5rBn0gVT95QAm
	jqvIX6CnxXZUj+wTByBUYGmdAQb4nYVDQCu2LetZmsMBCb59yFhhRoJil/pXZxILE4VpH+Wc1pX
	IK4H0RWjAhRiSq/SO7wlBLuWn5cYAlMmjSpOXOgi9ZAiIgxRW6tztU2pnKYr3/nSCGJ9Kco4AQ2
	rbspCey5GtgI0wd/OXnDBB+JJY2cbaTonrNsuG
X-Received: by 2002:a05:7022:418f:b0:128:d7a7:5271 with SMTP id a92af1059eb24-12bfb75ea82mr3166271c88.28.1775322774172;
        Sat, 04 Apr 2026 10:12:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.111.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedd70f18sm7224382c88.6.2026.04.04.10.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 10:12:53 -0700 (PDT)
Message-Id: <5de7aa41e652e5b75479f31926802e937cbc01f4.1775322767.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2077.git.1775322767.gitgitgadget@gmail.com>
References: <pull.2077.git.1775322767.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 17:12:47 +0000
Subject: [PATCH 4/4] doc: convert git-describe manual page to synopsis style
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

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-describe.adoc | 96 ++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/Documentation/git-describe.adoc b/Documentation/git-describe.adoc
index 08ff715709..b2cb1e47e4 100644
--- a/Documentation/git-describe.adoc
+++ b/Documentation/git-describe.adoc
@@ -7,10 +7,10 @@ git-describe - Give an object a human readable name based on an available ref
 
 SYNOPSIS
 --------
-[verse]
-'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]
-'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
-'git describe' <blob>
+[synopsis]
+git describe [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]
+git describe [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
+git describe <blob>
 
 DESCRIPTION
 -----------
@@ -22,70 +22,70 @@ abbreviated object name of the most recent commit. The result
 is a "human-readable" object name which can also be used to
 identify the commit to other git commands.
 
-By default (without --all or --tags) `git describe` only shows
+By default (without `--all` or `--tags`) `git describe` only shows
 annotated tags.  For more information about creating annotated tags
-see the -a and -s options to linkgit:git-tag[1].
+see the `-a` and `-s` options to linkgit:git-tag[1].
 
 If the given object refers to a blob, it will be described
 as `<commit-ish>:<path>`, such that the blob can be found
-at `<path>` in the `<commit-ish>`, which itself describes the
+at _<path>_ in the _<commit-ish>_, which itself describes the
 first commit in which this blob occurs in a reverse revision walk
-from HEAD.
+from `HEAD`.
 
 OPTIONS
 -------
-<commit-ish>...::
-	Commit-ish object names to describe.  Defaults to HEAD if omitted.
+`<commit-ish>...`::
+	Commit-ish object names to describe. Defaults to `HEAD` if omitted.
 
---dirty[=<mark>]::
---broken[=<mark>]::
+`--dirty[=<mark>]`::
+`--broken[=<mark>]`::
 	Describe the state of the working tree.  When the working
-	tree matches HEAD, the output is the same as "git describe
-	HEAD".  If the working tree has local modification "-dirty"
+	tree matches `HEAD`, the output is the same as `git describe HEAD`.
+	If the working tree has local modification, `-dirty`
 	is appended to it.  If a repository is corrupt and Git
 	cannot determine if there is local modification, Git will
-	error out, unless `--broken' is given, which appends
-	the suffix "-broken" instead.
+	error out, unless `--broken` is given, which appends
+	the suffix `-broken` instead.
 
---all::
+`--all`::
 	Instead of using only the annotated tags, use any ref
 	found in `refs/` namespace.  This option enables matching
 	any known branch, remote-tracking branch, or lightweight tag.
 
---tags::
+`--tags`::
 	Instead of using only the annotated tags, use any tag
 	found in `refs/tags` namespace.  This option enables matching
 	a lightweight (non-annotated) tag.
 
---contains::
+`--contains`::
 	Instead of finding the tag that predates the commit, find
 	the tag that comes after the commit, and thus contains it.
-	Automatically implies --tags.
+	Automatically implies `--tags`.
 
---abbrev=<n>::
+`--abbrev=<n>`::
 	Instead of using the default number of hexadecimal digits (which
 	will vary according to the number of objects in the repository with
-	a default of 7) of the abbreviated object name, use <n> digits, or
-	as many digits as needed to form a unique object name. An <n> of 0
+	a default of 7) of the abbreviated object name, use _<n>_ digits, or
+	as many digits as needed to form a unique object name. An _<n>_ of 0
 	will suppress long format, only showing the closest tag.
 
---candidates=<n>::
+`--candidates=<n>`::
 	Instead of considering only the 10 most recent tags as
 	candidates to describe the input commit-ish consider
-	up to <n> candidates.  Increasing <n> above 10 will take
+	up to _<n>_ candidates.  Increasing _<n>_ above 10 will take
 	slightly longer but may produce a more accurate result.
-	An <n> of 0 will cause only exact matches to be output.
+	An _<n>_ of 0 will cause only exact matches to be output.
 
---exact-match::
+`--exact-match`::
 	Only output exact matches (a tag directly references the
-	supplied commit).  This is a synonym for --candidates=0.
+	supplied commit).  This is a synonym for `--candidates=0`.
 
---debug::
+`--debug`::
 	Verbosely display information about the searching strategy
 	being employed to standard error.  The tag name will still
 	be printed to standard out.
 
---long::
+`--long`::
 	Always output the long format (the tag, the number of commits
 	and the abbreviated commit name) even when it matches a tag.
 	This is useful when you want to see parts of the commit object name
@@ -94,8 +94,8 @@ OPTIONS
 	describe such a commit as v1.2-0-gdeadbee (0th commit since tag v1.2
 	that points at object deadbee....).
 
---match <pattern>::
-	Only consider tags matching the given `glob(7)` pattern,
+`--match <pattern>`::
+	Only consider tags matching the given `glob`(7) pattern,
 	excluding the "refs/tags/" prefix. If used with `--all`, it also
 	considers local branches and remote-tracking references matching the
 	pattern, excluding respectively "refs/heads/" and "refs/remotes/"
@@ -104,22 +104,22 @@ OPTIONS
 	matching any of the patterns will be considered.  Use `--no-match` to
 	clear and reset the list of patterns.
 
---exclude <pattern>::
-	Do not consider tags matching the given `glob(7)` pattern, excluding
+`--exclude <pattern>`::
+	Do not consider tags matching the given `glob`(7) pattern, excluding
 	the "refs/tags/" prefix. If used with `--all`, it also does not consider
 	local branches and remote-tracking references matching the pattern,
-	excluding respectively "refs/heads/" and "refs/remotes/" prefix;
+	excluding respectively "`refs/heads/`" and "`refs/remotes/`" prefix;
 	references of other types are never considered. If given multiple times,
 	a list of patterns will be accumulated and tags matching any of the
-	patterns will be excluded. When combined with --match a tag will be
-	considered when it matches at least one --match pattern and does not
-	match any of the --exclude patterns. Use `--no-exclude` to clear and
+	patterns will be excluded. When combined with `--match` a tag will be
+	considered when it matches at least one `--match` pattern and does not
+	match any of the `--exclude` patterns. Use `--no-exclude` to clear and
 	reset the list of patterns.
 
---always::
+`--always`::
 	Show uniquely abbreviated commit object as fallback.
 
---first-parent::
+`--first-parent`::
 	Follow only the first parent commit upon seeing a merge commit.
 	This is useful when you wish to not match tags on branches merged
 	in the history of the target commit.
@@ -139,8 +139,8 @@ an abbreviated object name for the commit itself ("2414721")
 at the end.
 
 The number of additional commits is the number
-of commits which would be displayed by "git log v1.0.4..parent".
-The hash suffix is "-g" + an unambiguous abbreviation for the tip commit
+of commits which would be displayed by `git log v1.0.4..parent`.
+The hash suffix is "`-g`" + an unambiguous abbreviation for the tip commit
 of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`). The
 length of the abbreviation scales as the repository grows, using the
 approximate number of objects in the repository and a bit of math
@@ -149,12 +149,12 @@ The "g" prefix stands for "git" and is used to allow describing the version of
 a software depending on the SCM the software is managed with. This is useful
 in an environment where people may use different SCMs.
 
-Doing a 'git describe' on a tag-name will just show the tag name:
+Doing a `git describe` on a tag-name will just show the tag name:
 
 	[torvalds@g5 git]$ git describe v1.0.4
 	v1.0.4
 
-With --all, the command can use branch heads as references, so
+With `--all`, the command can use branch heads as references, so
 the output shows the reference path as well:
 
 	[torvalds@g5 git]$ git describe --all --abbrev=4 v1.0.5^2
@@ -163,7 +163,7 @@ the output shows the reference path as well:
 	[torvalds@g5 git]$ git describe --all --abbrev=4 HEAD^
 	heads/lt/describe-7-g975b
 
-With --abbrev set to 0, the command can be used to find the
+With `--abbrev` set to 0, the command can be used to find the
 closest tagname without any suffix:
 
 	[torvalds@g5 git]$ git describe --abbrev=0 v1.0.5^2
@@ -179,13 +179,13 @@ be sufficient to disambiguate these commits.
 SEARCH STRATEGY
 ---------------
 
-For each commit-ish supplied, 'git describe' will first look for
+For each commit-ish supplied, `git describe` will first look for
 a tag which tags exactly that commit.  Annotated tags will always
 be preferred over lightweight tags, and tags with newer dates will
 always be preferred over tags with older dates.  If an exact match
 is found, its name will be output and searching will stop.
 
-If an exact match was not found, 'git describe' will walk back
+If an exact match was not found, `git describe` will walk back
 through the commit history to locate an ancestor commit which
 has been tagged.  The ancestor's tag will be output along with an
 abbreviation of the input commit-ish's SHA-1. If `--first-parent` was
@@ -203,7 +203,7 @@ BUGS
 
 Tree objects as well as tag objects not pointing at commits, cannot be described.
 When describing blobs, the lightweight tags pointing at blobs are ignored,
-but the blob is still described as <commit-ish>:<path> despite the lightweight
+but the blob is still described as `<commit-ish>:<path>` despite the lightweight
 tag being favorable.
 
 GIT
-- 
gitgitgadget
