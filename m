Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC34F314D14
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138231; cv=none; b=Cfhz4hrMNzh8hh4O6HQChrUqZCZbR4dLnAjZIaz9/ZtqxdvWwgZ6LmWy0P4kL4RIDr4iZhhtGMrvSHzQIPO2QDm8nu1oOBqxlBCTnhlv3f+CXq8MWSzUJ8/QL40v9McyTxiaovQ7L/AM+8+Pfnwx+jWzjP6gtX8mAkrkQJUjvAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138231; c=relaxed/simple;
	bh=u3d2KwUjvL+LepAXy/b2Seg1D1PcDtKAqJQOxpnAq28=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=edAaIdVS7RWdlLwgjIywFOB5DTjUwD3sPVDUSf3UosRUY1YMHkjpwinrbB1Rml8IEANobizWNr1VygI5CevZgeHteo5DyGoj7fx3cHoJzWTOYX7rb9bvAMjZ3yRNWitekf2p0nUx3xUSgyESzbdooCFAacLdEvrhd/ymikjA7is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5it0V7w; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5it0V7w"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b82c605dbdso629784eec.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 09:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770138225; x=1770743025; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHak0funCF6mdYfg1zC8cCDJWgVvrmgTSbImASzT9ws=;
        b=f5it0V7wV3dUW/QGuf7/Lr//20FxuCtTh5IHTt7bovrLkaJKG7npQXQqz7Ez6xNYyF
         Z4EYufuMdUosTrrNXBux/Ly5u+ZQee4zMoxx7JsnqBb8qIQ9Ocej/7/KUzfB4BCnCvAx
         TTbSMf6LoA3tCihJIdUnxfxcRQqIBmFutyr6Og9FHJ4bbTqynTFBcuKzbLY3BelYHi0H
         5jXHYttENU5/1DtvfwSVq2+LqiwxJJ8RW6Q1wl/7HxgMJ4wavbe4jANFmiIQfd9RRs0i
         WkeMVq76Ry0/9ii1xZqmErMEG+Fnp3aJ7/27aR4zZtRp1zFQo8MWpR075EhRKTrBsH3b
         zlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770138225; x=1770743025;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BHak0funCF6mdYfg1zC8cCDJWgVvrmgTSbImASzT9ws=;
        b=XgrCTkby9xV7jLue2sA+QZ5Su8oxIg7q8Wvgi0PdzgeMD7e6oS7OwJfTiabWV/GSH8
         n0qP5x5tWs9bJBM14hYn6u9WVL//tJMRRKdrcDfegayDng3snyjeYvs+OvnlM/5Nk4pX
         xXQDJMeRKzHp+Fvojps2Ujv89yTTaBeA4dmr2hLYUW95wg0ivH+wpcZedO7T8Yq6uXmk
         AvuvbnnwfRIgR7mWKQ/QvcfnP2ERCYMhggTa4LSoJL0PIqj9eIoGOcRU2FmChqLaRKAV
         7KSI7TXiPYsw2xyIpX/WgPMn/CK3TGm4474DpBvBD3qHONDU+MNAEO1E7vwtib3ezA0+
         qNGA==
X-Gm-Message-State: AOJu0Yy4cu0275KWB5h3nmevpeZTTZ7kG3ghuYPVDyRN7+2DVsWR4WLx
	2HpUEIla4OgDRJ4ewjWnpgaS6Oy5QCL1RaMfyiyuoZaaGhJVW5fhzHpkW2mu9q2l
X-Gm-Gg: AZuq6aIUbfewAdVBwr3ZoJvdJAY1q1zEJbffVOCswsg+vYo92ISQYmRCeEkajMGjZ0F
	t3DgJOVHJa7CRnMa+MaTuHjQbtAfbI2V23huz3loadD279TRKIXiQeUV/LEMTISW7COBA/zr09g
	iBJl4xQhqajR9Wryt0zOQjYU5lgNM2kayHuvtG4duPn+SKTkDFGAuXZXzaIkctrVhkuYK/363xv
	Dpwuc6CtLWWFRR0Qc5VMZO02zvqfJzcXO7+0kvhSkOAuP0gYcP9n2FRvS4tGnc2sMhyaAKL/ntG
	LyvVHNwMI77QxC2laJXWP4f1dGhuErZ4vNdMZcqg7EQIj10Xs5pPfl0LNbBFO5wfzRgq/fV8ATW
	ulaFnai+0WjJICgG0bJtIJBnhybio+6Bd/6ICXMXpThLU1qqxUdHFcgZpJBNsf5FnB0LxXr2Q2H
	VRK3OwiX7mMCyn
X-Received: by 2002:a05:7300:a54c:b0:2ae:5b01:bfa5 with SMTP id 5a478bee46e88-2b8329d9434mr81969eec.32.1770138224897;
        Tue, 03 Feb 2026 09:03:44 -0800 (PST)
Received: from [127.0.0.1] ([20.169.75.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832faea55sm27996eec.23.2026.02.03.09.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:03:44 -0800 (PST)
Message-Id: <d179137d8122d152d96c7f5cd91255093c535821.1770138215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
References: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
	<pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Feb 2026 17:03:35 +0000
Subject: [PATCH v3 4/4] doc: convert git-show to synopsis style
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

 * add synopsis block definition in asciidoc.conf.in
 * convert commands to synopsis style
 * use _<placeholder>_ for arguments
 * minor formatting fixes

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
---
 Documentation/asciidoc.conf.in    |   6 ++
 Documentation/git-show.adoc       |  16 +--
 Documentation/pretty-formats.adoc | 169 +++++++++++++++++-------------
 3 files changed, 111 insertions(+), 80 deletions(-)

diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
index ff9ea0a294..31b883a72c 100644
--- a/Documentation/asciidoc.conf.in
+++ b/Documentation/asciidoc.conf.in
@@ -81,12 +81,18 @@ endif::backend-xhtml11[]
 
 ifdef::backend-docbook[]
 ifdef::doctype-manpage[]
+[blockdef-open]
+synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<phrase>\\0</phrase>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<emphasis>\\0</emphasis>!g'"
+
 [paradef-default]
 synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<phrase>\\0</phrase>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<emphasis>\\0</emphasis>!g'"
 endif::doctype-manpage[]
 endif::backend-docbook[]
 
 ifdef::backend-xhtml11[]
+[blockdef-open]
+synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<span>\\0</span>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<em>\\0</em>!g'"
+
 [paradef-default]
 synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<span>\\0</span>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<em>\\0</em>!g'"
 endif::backend-xhtml11[]
diff --git a/Documentation/git-show.adoc b/Documentation/git-show.adoc
index 51044c814f..3b180e8c7a 100644
--- a/Documentation/git-show.adoc
+++ b/Documentation/git-show.adoc
@@ -8,8 +8,8 @@ git-show - Show various types of objects
 
 SYNOPSIS
 --------
-[verse]
-'git show' [<options>] [<object>...]
+[synopsis]
+git show [<options>] [<object>...]
 
 DESCRIPTION
 -----------
@@ -17,16 +17,16 @@ Shows one or more objects (blobs, trees, tags and commits).
 
 For commits it shows the log message and textual diff. It also
 presents the merge commit in a special format as produced by
-'git diff-tree --cc'.
+`git diff-tree --cc`.
 
 For tags, it shows the tag message and the referenced objects.
 
-For trees, it shows the names (equivalent to 'git ls-tree'
-with --name-only).
+For trees, it shows the names (equivalent to `git ls-tree`
+with `--name-only`).
 
 For plain blobs, it shows the plain contents.
 
-Some options that 'git log' command understands can be used to
+Some options that `git log` command understands can be used to
 control how the changes the commit introduces are shown.
 
 This manual page describes only the most frequently used options.
@@ -34,8 +34,8 @@ This manual page describes only the most frequently used options.
 
 OPTIONS
 -------
-<object>...::
-	The names of objects to show (defaults to 'HEAD').
+`<object>...`::
+	The names of objects to show (defaults to `HEAD`).
 	For a more complete list of ways to spell object names, see
 	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
 
diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
index 2121e8e1df..5405e57a60 100644
--- a/Documentation/pretty-formats.adoc
+++ b/Documentation/pretty-formats.adoc
@@ -18,54 +18,72 @@ config option to either another format name, or a
 linkgit:git-config[1]). Here are the details of the
 built-in formats:
 
-* `oneline`
-
-	  <hash> <title-line>
+`oneline`::
++
+[synopsis]
+--
+<hash> <title-line>
+--
 +
 This is designed to be as compact as possible.
 
-* `short`
-
-	  commit <hash>
-	  Author: <author>
-
-	      <title-line>
-
-* `medium`
-
-	  commit <hash>
-	  Author: <author>
-	  Date:   <author-date>
-
-	      <title-line>
+`short`::
++
+[synopsis]
+--
+commit <hash>
+Author: <author>
 
-	      <full-commit-message>
+    <title-line>
+--
 
-* `full`
+`medium`::
++
+[synopsis]
+--
+commit <hash>
+Author: <author>
+Date:   <author-date>
 
-	  commit <hash>
-	  Author: <author>
-	  Commit: <committer>
+    <title-line>
 
-	      <title-line>
+    <full-commit-message>
+--
 
-	      <full-commit-message>
+`full`::
++
+[synopsis]
+--
+commit <hash>
+Author: <author>
+Commit: <committer>
 
-* `fuller`
+    <title-line>
 
-	  commit <hash>
-	  Author:     <author>
-	  AuthorDate: <author-date>
-	  Commit:     <committer>
-	  CommitDate: <committer-date>
+    <full-commit-message>
+--
 
-	       <title-line>
+`fuller`::
++
+[synopsis]
+--
+commit <hash>
+Author:     <author>
+AuthorDate: <author-date>
+Commit:     <committer>
+CommitDate: <committer-date>
 
-	       <full-commit-message>
+     <title-line>
 
-* `reference`
+     <full-commit-message>
+--
 
-	  <abbrev-hash> (<title-line>, <short-author-date>)
+`reference`::
++
+[synopsis]
+--
+<abbrev-hash> (<title-line>, <short-author-date>)
+--
 +
 This format is used to refer to another commit in a commit message and
 is the same as ++--pretty=\'format:%C(auto)%h (%s, %ad)'++.  By default,
@@ -74,23 +92,24 @@ is explicitly specified.  As with any `format:` with format
 placeholders, its output is not affected by other options like
 `--decorate` and `--walk-reflogs`.
 
-* `email`
-
-	  From <hash> <date>
-	  From: <author>
-	  Date: <author-date>
-	  Subject: [PATCH] <title-line>
+`email`::
++
+[synopsis]
+--
+From <hash> <date>
+From: <author>
+Date: <author-date>
+Subject: [PATCH] <title-line>
 
-	  <full-commit-message>
+<full-commit-message>
+--
 
-* `mboxrd`
-+
+`mboxrd`::
 Like `email`, but lines in the commit message starting with "From "
 (preceded by zero or more ">") are quoted with ">" so they aren't
 confused as starting a new commit.
 
-* `raw`
-+
+`raw`::
 The `raw` format shows the entire commit exactly as
 stored in the commit object.  Notably, the hashes are
 displayed in full, regardless of whether `--abbrev` or
@@ -101,8 +120,7 @@ commits are displayed, but not the way the diff is shown e.g. with
 `git log --raw`. To get full object names in a raw diff format,
 use `--no-abbrev`.
 
-* `format:<format-string>`
-+
+`format:<format-string>`::
 The `format:<format-string>` format allows you to specify which information
 you want to show. It works a little bit like printf format,
 with the notable exception that you get a newline with `%n`
@@ -120,13 +138,18 @@ The title was >>t4119: test autocomputing -p<n> for traditional diff input.<<
 The placeholders are:
 
 - Placeholders that expand to a single literal character:
++
+--
 ++%n++:: newline
 ++%%++:: a raw ++%++
 ++%x00++:: ++%x++ followed by two hexadecimal digits is replaced with a
 	 byte with the hexadecimal digits' value (we will call this
 	 "literal formatting code" in the rest of this document).
+--
 
 - Placeholders that affect formatting of later placeholders:
++
+--
 ++%Cred++:: switch color to red
 ++%Cgreen++:: switch color to green
 ++%Cblue++:: switch color to blue
@@ -181,8 +204,11 @@ The placeholders are:
 ++%><|(++_<m>_++)++:: similar to ++%<(++_<n>_++)++, ++%<|(++_<m>_++)++
 			  respectively, but padding both sides
 			  (i.e. the text is centered)
+--
 
 - Placeholders that expand to information extracted from the commit:
++
+--
 +%H+:: commit hash
 +%h+:: abbreviated commit hash
 +%T+:: tree hash
@@ -233,20 +259,19 @@ colon and zero or more comma-separated options. Option values may contain
 literal formatting codes. These must be used for commas (`%x2C`) and closing
 parentheses (`%x29`), due to their role in the option syntax.
 
-** `prefix=<value>`: Shown before the list of ref names.  Defaults to "{nbsp}++(++".
-** `suffix=<value>`: Shown after the list of ref names.  Defaults to "+)+".
-** `separator=<value>`: Shown between ref names.  Defaults to "+,+{nbsp}".
-** `pointer=<value>`: Shown between HEAD and the branch it points to, if any.
-		      Defaults to "{nbsp}++->++{nbsp}".
-** `tag=<value>`: Shown before tag names. Defaults to "`tag:`{nbsp}".
+`prefix=<value>`;; Shown before the list of ref names.  Defaults to "{nbsp}++(++".
+`suffix=<value>`;; Shown after the list of ref names.  Defaults to "+)+".
+`separator=<value>`;; Shown between ref names.  Defaults to "+,+{nbsp}".
+`pointer=<value>`;; Shown between HEAD and the branch it points to, if any.
+	      Defaults to "{nbsp}->{nbsp}".
+`tag=<value>`;; Shown before tag names. Defaults to "`tag:`{nbsp}".
 
 +
---
 For example, to produce decorations with no wrapping
 or tag annotations, and spaces as separators:
-
-++%(decorate:prefix=,suffix=,tag=,separator= )++
---
+---------------------
+    %(decorate:prefix=,suffix=,tag=,separator= )
+---------------------
 
 ++%(describe++`[:<option>,...]`++)++::
 human-readable name, like linkgit:git-describe[1]; empty string for
@@ -254,15 +279,15 @@ undescribable commits.  The `describe` string may be followed by a colon and
 zero or more comma-separated options.  Descriptions can be inconsistent when
 tags are added or removed at the same time.
 +
-** `tags[=<bool-value>]`: Instead of only considering annotated tags,
+`tags[=<bool-value>]`;; Instead of only considering annotated tags,
    consider lightweight tags as well.
-** `abbrev=<number>`: Instead of using the default number of hexadecimal digits
+`abbrev=<number>`;; Instead of using the default number of hexadecimal digits
    (which will vary according to the number of objects in the repository with a
-   default of 7) of the abbreviated object name, use <number> digits, or as many
+   default of 7) of the abbreviated object name, use _<number>_ digits, or as many
    digits as needed to form a unique object name.
-** `match=<pattern>`: Only consider tags matching the given
+`match=<pattern>`;; Only consider tags matching the given
    `glob(7)` _<pattern>_, excluding the `refs/tags/` prefix.
-** `exclude=<pattern>`: Do not consider tags matching the given
+`exclude=<pattern>`;; Do not consider tags matching the given
    `glob(7)` _<pattern>_, excluding the `refs/tags/` prefix.
 
 +%S+:: ref name given on the command line by which the commit was reached
@@ -311,7 +336,7 @@ linkgit:git-interpret-trailers[1]. The `trailers` string may be followed by
 a colon and zero or more comma-separated options. If any option is provided
 multiple times, the last occurrence wins.
 +
-** `key=<key>`: only show trailers with specified <key>. Matching is done
+`key=<key>`;; only show trailers with specified <key>. Matching is done
    case-insensitively and trailing colon is optional. If option is
    given multiple times trailer lines matching any of the keys are
    shown. This option automatically enables the `only` option so that
@@ -319,21 +344,21 @@ multiple times, the last occurrence wins.
    desired it can be disabled with `only=false`.  E.g.,
    +%(trailers:key=Reviewed-by)+ shows trailer lines with key
    `Reviewed-by`.
-** `only[=<bool>]`: select whether non-trailer lines from the trailer
+`only[=<bool>]`;; select whether non-trailer lines from the trailer
    block should be included.
-** `separator=<sep>`: specify the separator inserted between trailer
+ `separator=<sep>`;; specify the separator inserted between trailer
    lines. Defaults to a line feed character. The string <sep> may contain
    the literal formatting codes described above. To use comma as
    separator one must use `%x2C` as it would otherwise be parsed as
    next option. E.g., +%(trailers:key=Ticket,separator=%x2C )+
-   shows all trailer lines whose key is "Ticket" separated by a comma
+   shows all trailer lines whose key is `Ticket` separated by a comma
    and a space.
-** `unfold[=<bool>]`: make it behave as if interpret-trailer's `--unfold`
+`unfold[=<bool>]`;; make it behave as if interpret-trailer's `--unfold`
    option was given. E.g.,
    +%(trailers:only,unfold=true)+ unfolds and shows all trailer lines.
-** `keyonly[=<bool>]`: only show the key part of the trailer.
-** `valueonly[=<bool>]`: only show the value part of the trailer.
-** `key_value_separator=<sep>`: specify the separator inserted between
+`keyonly[=<bool>]`;; only show the key part of the trailer.
+`valueonly[=<bool>]`;; only show the value part of the trailer.
+`key_value_separator=<sep>`;; specify the separator inserted between
    the key and value of each trailer. Defaults to ": ". Otherwise it
    shares the same semantics as `separator=<sep>` above.
 
@@ -360,9 +385,9 @@ placeholder expands to an empty string.
 If you add a `' '` (space) after +%+ of a placeholder, a space
 is inserted immediately before the expansion if and only if the
 placeholder expands to a non-empty string.
+--
 
-* `tformat:`
-+
+`tformat:`::
 The `tformat:` format works exactly like `format:`, except that it
 provides "terminator" semantics instead of "separator" semantics. In
 other words, each commit has the message terminator character (usually a
-- 
gitgitgadget
