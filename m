Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B229B20D50B
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749373799; cv=none; b=D2jgNLsz8QsQgXvZgKQM4njj/+YjaCrNQaLLNXbQDiejsHg0Q0FEo6IlLabw3pFIB/6zpMrDTE/IN9HY04BGP/mUU26xUtcXLVbpvQ6cEYpcMCfujUG1ybqY+lFPYN7e1H+qu00cTMfI3mG6xb0tFa/olVBqbPii8iKAYMVxi0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749373799; c=relaxed/simple;
	bh=PDHnHkSSUgBxUBvmwnrqgC0LjmQqFdXdaj/UZQZjn9A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Nd0W5a7pn9BBYQzNGQdUwnpSF6fL6waFTZzBKPDaOjlCL5nOoy7ogLnDE9PAsjw8X1S7sLv4JKC9OD5oM2kLrm05gRQpyeJOycLgc7Cg5fZuqqS8W0MAtwvLX71MXM0j7nH1iDlEhUO+ZnTlcJz0ynPEzT4JtnoDyAPyOAavQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBCgJH3e; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBCgJH3e"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a5257748e1so2269952f8f.2
        for <git@vger.kernel.org>; Sun, 08 Jun 2025 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749373795; x=1749978595; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNd/4CRkSjgK5ac5Hfb3cR3Ox5u0b7mkCjQVZuSRMQs=;
        b=hBCgJH3eMaJK0KvcUofI27LZlwghI5n1kzZZZhU4EoTB3wYnLHhn9ajfCZCYats2J0
         o1Kt4tws/HiWobbKkPmt+RNoSyk1zqxNt1B2kRz3h24yueqr3vVcJGbWskO6aAq21Bg9
         EQocLQmCtJS8yT/a9r6qLaRuV7bfDiYOH7BW+wZ5TcsfVV9coY7x2CCZrjbiRES4NQr5
         E/gS+nSLt9q0SK4aL0BxFofWZwO8m3jmcq1zTZaP7S7pFeGeqFVz82yVfCW1mfx6k9NE
         b79tJhye/swCbp6ITsDPTBW4XDkB+aVKSdyjPYn5lTNeKZC3M5e0vBoSxqaqAeYJ8oNI
         kHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749373795; x=1749978595;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNd/4CRkSjgK5ac5Hfb3cR3Ox5u0b7mkCjQVZuSRMQs=;
        b=Grn+YxYrQW/m30BI/uPuaRkuEloKiDQ8Y3z/7VjzXn6QKNT2zrirDISIU+bpSOf0Dd
         HbKmrK0adkAzL/GY/mMk+AqbT1wnQWM3gSjABGliZOnyRBc5G94VBMnv26Lqw0H5yq/w
         49DDqzo1qOFNi9y6S1eIiZj73XTs74oa+J8X0L1xXKVm6nsmft5AMbiqiL4xFhApWKcY
         aKCVHTGmNq47nhGN7soSX41gkh3pG5cZl9BrntB89QmTF1wfqdB7HxANJjBHzhsKNB8L
         ocfNg42t19dUuqOZOpMW+SDYpR4dL46Tu38ttidAWCaQIt4hUMW6nrlzBp4Fm3ccLDuS
         /TFA==
X-Gm-Message-State: AOJu0YzGN/X4Eyj2CkFaoEGQgxXewZA3FKh2FjJu8tmiw5he25MCnKml
	q68mVmbKM8/hYNLPnbOadjYG4msbECtaDB1B2mdILLNZo50ebbHEfdHElXaIXQ==
X-Gm-Gg: ASbGncvg3fp1xcLcpyyZBxLxLb1o1hzkYcftJs33xPD2H11RidRhIoN4BGau9uWZYIL
	L7bPik3UQxKnIy2wWIN07I173lonz1BCaBEenkdnnk7Yk01Ytm3ggEOfGHI+N6x+L0edRvAc676
	DkpxIYTc6nz/UiAnJpg+f49S7B/uFys3D9hboAR24LfqdnAd8hy+aAguSOLD461wxoAgjzrUtFi
	KGu/vYnVEOQU7zwjHpAW16OEnSCQouFYETBTjOXwuBzUkmPqKMkEFwXDxtBAnrLU38HhVh74+5w
	Cpo1iF1A3vwy3+2CLvex9b2liWRvGhCmKt0VugpDOITM9KJEcd9K
X-Google-Smtp-Source: AGHT+IEkKXwd5k1wBTuGzOsncyKV2myPpNXZ72UrS71wP+rjOFC6hPf/cfz/9TGipXzuLXDlo5oX3g==
X-Received: by 2002:a5d:584c:0:b0:3a4:d4e5:498a with SMTP id ffacd0b85a97d-3a5319a7908mr7588376f8f.42.1749373794210;
        Sun, 08 Jun 2025 02:09:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323b33c3sm6794501f8f.34.2025.06.08.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 02:09:53 -0700 (PDT)
Message-Id: <d54e297567ac8f3009daa8fdf3de158338b2b700.1749373787.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 08 Jun 2025 09:09:44 +0000
Subject: [PATCH 7/9] doc: git-log: convert pretty formats to new doc format
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

- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

For all the formats in the form of %(foo), the formatting needs to be
heavier because we not want the parentheses to be rendered as syntax
elements,but as keywords, i.e. we need to circumvent the syntax highlighting
of synopsis.  In this particular case, this requires the heavy escaping of
the parts that contain parentheses with ++.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/pretty-formats.adoc | 283 +++++++++++++++---------------
 1 file changed, 143 insertions(+), 140 deletions(-)

diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
index 07475de8c337..9ed0417fc811 100644
--- a/Documentation/pretty-formats.adoc
+++ b/Documentation/pretty-formats.adoc
@@ -2,11 +2,11 @@ PRETTY FORMATS
 --------------
 
 If the commit is a merge, and if the pretty-format
-is not 'oneline', 'email' or 'raw', an additional line is
-inserted before the 'Author:' line.  This line begins with
+is not `oneline`, `email` or `raw`, an additional line is
+inserted before the `Author:` line.  This line begins with
 "Merge: " and the hashes of ancestral commits are printed,
 separated by spaces.  Note that the listed commits may not
-necessarily be the list of the *direct* parent commits if you
+necessarily be the list of the 'direct' parent commits if you
 have limited your view of history: for example, if you are
 only interested in changes related to a certain directory or
 file.
@@ -14,24 +14,24 @@ file.
 There are several built-in formats, and you can define
 additional formats by setting a pretty.<name>
 config option to either another format name, or a
-'format:' string, as described below (see
+`format:` string, as described below (see
 linkgit:git-config[1]). Here are the details of the
 built-in formats:
 
-* 'oneline'
+* `oneline`
 
 	  <hash> <title-line>
 +
 This is designed to be as compact as possible.
 
-* 'short'
+* `short`
 
 	  commit <hash>
 	  Author: <author>
 
 	      <title-line>
 
-* 'medium'
+* `medium`
 
 	  commit <hash>
 	  Author: <author>
@@ -41,7 +41,7 @@ This is designed to be as compact as possible.
 
 	      <full-commit-message>
 
-* 'full'
+* `full`
 
 	  commit <hash>
 	  Author: <author>
@@ -51,7 +51,7 @@ This is designed to be as compact as possible.
 
 	      <full-commit-message>
 
-* 'fuller'
+* `fuller`
 
 	  commit <hash>
 	  Author:     <author>
@@ -63,18 +63,18 @@ This is designed to be as compact as possible.
 
 	       <full-commit-message>
 
-* 'reference'
+* `reference`
 
 	  <abbrev-hash> (<title-line>, <short-author-date>)
 +
 This format is used to refer to another commit in a commit message and
-is the same as `--pretty='format:%C(auto)%h (%s, %ad)'`.  By default,
+is the same as ++--pretty=\'format:%C(auto)%h (%s, %ad)'++.  By default,
 the date is formatted with `--date=short` unless another `--date` option
 is explicitly specified.  As with any `format:` with format
 placeholders, its output is not affected by other options like
 `--decorate` and `--walk-reflogs`.
 
-* 'email'
+* `email`
 
 	  From <hash> <date>
 	  From: <author>
@@ -83,30 +83,30 @@ placeholders, its output is not affected by other options like
 
 	  <full-commit-message>
 
-* 'mboxrd'
+* `mboxrd`
 +
-Like 'email', but lines in the commit message starting with "From "
+Like `email`, but lines in the commit message starting with "From "
 (preceded by zero or more ">") are quoted with ">" so they aren't
 confused as starting a new commit.
 
-* 'raw'
+* `raw`
 +
-The 'raw' format shows the entire commit exactly as
+The `raw` format shows the entire commit exactly as
 stored in the commit object.  Notably, the hashes are
-displayed in full, regardless of whether --abbrev or
---no-abbrev are used, and 'parents' information show the
+displayed in full, regardless of whether `--abbrev` or
+`--no-abbrev` are used, and 'parents' information show the
 true parent commits, without taking grafts or history
 simplification into account. Note that this format affects the way
 commits are displayed, but not the way the diff is shown e.g. with
 `git log --raw`. To get full object names in a raw diff format,
 use `--no-abbrev`.
 
-* 'format:<format-string>'
+* `format:<format-string>`
 +
-The 'format:<format-string>' format allows you to specify which information
+The `format:<format-string>` format allows you to specify which information
 you want to show. It works a little bit like printf format,
-with the notable exception that you get a newline with '%n'
-instead of '\n'.
+with the notable exception that you get a newline with `%n`
+instead of `\n`.
 +
 E.g, 'format:"The author of %h was %an, %ar%nThe title was >>%s<<%n"'
 would show something like this:
@@ -120,158 +120,161 @@ The title was >>t4119: test autocomputing -p<n> for traditional diff input.<<
 The placeholders are:
 
 - Placeholders that expand to a single literal character:
-'%n':: newline
-'%%':: a raw '%'
-'%x00':: '%x' followed by two hexadecimal digits is replaced with a
+++%n++:: newline
+++%%++:: a raw ++%++
+++%x00++:: ++%x++ followed by two hexadecimal digits is replaced with a
 	 byte with the hexadecimal digits' value (we will call this
 	 "literal formatting code" in the rest of this document).
 
 - Placeholders that affect formatting of later placeholders:
-'%Cred':: switch color to red
-'%Cgreen':: switch color to green
-'%Cblue':: switch color to blue
-'%Creset':: reset color
-'%C(...)':: color specification, as described under Values in the
+++%Cred++:: switch color to red
+++%Cgreen++:: switch color to green
+++%Cblue++:: switch color to blue
+++%Creset++:: reset color
+++%C(++_<spec>_++)++:: color specification, as described under Values in the
 	    "CONFIGURATION FILE" section of linkgit:git-config[1].  By
 	    default, colors are shown only when enabled for log output
 	    (by `color.diff`, `color.ui`, or `--color`, and respecting
 	    the `auto` settings of the former if we are going to a
-	    terminal). `%C(auto,...)` is accepted as a historical
-	    synonym for the default (e.g., `%C(auto,red)`). Specifying
-	    `%C(always,...)` will show the colors even when color is
+	    terminal). ++%C(auto,++_<spec>_++)++ is accepted as a historical
+	    synonym for the default (e.g., ++%C(auto,red)++). Specifying
+	    ++%C(always,++_<spec>_++)++ will show the colors even when color is
 	    not otherwise enabled (though consider just using
-	    `--color=always` to enable color for the whole output,
+	    `--color=always` to enable color for the  whole output,
 	    including this format and anything else git might color).
-	    `auto` alone (i.e. `%C(auto)`) will turn on auto coloring
+	    `auto` alone (i.e. ++%C(auto)++) will turn on auto coloring
 	    on the next placeholders until the color is switched
 	    again.
-'%m':: left (`<`), right (`>`) or boundary (`-`) mark
-'%w([<w>[,<i1>[,<i2>]]])':: switch line wrapping, like the -w option of
+++%m++:: left (`<`), right (`>`) or boundary (`-`) mark
+++%w(++`[<w>[,<i1>[,<i2>]]]`++)++:: switch line wrapping, like the `-w` option of
 			    linkgit:git-shortlog[1].
-'%<( <N> [,trunc|ltrunc|mtrunc])':: make the next placeholder take at
+++%<(++`<n>[,(trunc|ltrunc|mtrunc)]`++)++:: make the next placeholder take at
 				  least N column widths, padding spaces on
 				  the right if necessary.  Optionally
-				  truncate (with ellipsis '..') at the left (ltrunc) `..ft`,
+				  truncate (with ellipsis `..`) at the left (ltrunc) `..ft`,
 				  the middle (mtrunc) `mi..le`, or the end
 				  (trunc) `rig..`, if the output is longer than
-				  N columns.
+				  _<n>_ columns.
 				  Note 1: that truncating
-				  only works correctly with N >= 2.
-				  Note 2: spaces around the N and M (see below)
+				  only works correctly with _<n>_ >= 2.
+				  Note 2: spaces around the _<n>_ and _<m>_ (see below)
 				  values are optional.
 				  Note 3: Emojis and other wide characters
 				  will take two display columns, which may
 				  over-run column boundaries.
 				  Note 4: decomposed character combining marks
 				  may be misplaced at padding boundaries.
-'%<|( <M> )':: make the next placeholder take at least until Mth
+++%<|(++_<m>_ ++)++:: make the next placeholder take at least until _<m>_ th
 	     display column, padding spaces on the right if necessary.
-	     Use negative M values for column positions measured
+	     Use negative _<m>_ values for column positions measured
 	     from the right hand edge of the terminal window.
-'%>( <N> )', '%>|( <M> )':: similar to '%<( <N> )', '%<|( <M> )' respectively,
+++%>(++_<n>_++)++::
+++%>|(++_<m>_++)++:: similar to ++%<(++_<n>_++)++, ++%<|(++_<m>_++)++ respectively,
 			but padding spaces on the left
-'%>>( <N> )', '%>>|( <M> )':: similar to '%>( <N> )', '%>|( <M> )'
+++%>>(++_<n>_++)++::
+++%>>|(++_<m>_++)++:: similar to ++%>(++_<n>_++)++, ++%>|(++_<m>_++)++
 			  respectively, except that if the next
 			  placeholder takes more spaces than given and
 			  there are spaces on its left, use those
 			  spaces
-'%><( <N> )', '%><|( <M> )':: similar to '%<( <N> )', '%<|( <M> )'
+++%><(++_<n>_++)++::
+++%><|(++_<m>_++)++:: similar to ++%<(++_<n>_++)++, ++%<|(++_<m>_++)++
 			  respectively, but padding both sides
 			  (i.e. the text is centered)
 
 - Placeholders that expand to information extracted from the commit:
-'%H':: commit hash
-'%h':: abbreviated commit hash
-'%T':: tree hash
-'%t':: abbreviated tree hash
-'%P':: parent hashes
-'%p':: abbreviated parent hashes
-'%an':: author name
-'%aN':: author name (respecting .mailmap, see linkgit:git-shortlog[1]
++%H+:: commit hash
++%h+:: abbreviated commit hash
++%T+:: tree hash
++%t+:: abbreviated tree hash
++%P+:: parent hashes
++%p+:: abbreviated parent hashes
++%an+:: author name
++%aN+:: author name (respecting .mailmap, see linkgit:git-shortlog[1]
 	or linkgit:git-blame[1])
-'%ae':: author email
-'%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
++%ae+:: author email
++%aE+:: author email (respecting .mailmap, see linkgit:git-shortlog[1]
 	or linkgit:git-blame[1])
-'%al':: author email local-part (the part before the '@' sign)
-'%aL':: author local-part (see '%al') respecting .mailmap, see
++%al+:: author email local-part (the part before the `@` sign)
++%aL+:: author local-part (see +%al+) respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%ad':: author date (format respects --date= option)
-'%aD':: author date, RFC2822 style
-'%ar':: author date, relative
-'%at':: author date, UNIX timestamp
-'%ai':: author date, ISO 8601-like format
-'%aI':: author date, strict ISO 8601 format
-'%as':: author date, short format (`YYYY-MM-DD`)
-'%ah':: author date, human style (like the `--date=human` option of
++%ad+:: author date (format respects --date= option)
++%aD+:: author date, RFC2822 style
++%ar+:: author date, relative
++%at+:: author date, UNIX timestamp
++%ai+:: author date, ISO 8601-like format
++%aI+:: author date, strict ISO 8601 format
++%as+:: author date, short format (`YYYY-MM-DD`)
++%ah+:: author date, human style (like the `--date=human` option of
 	linkgit:git-rev-list[1])
-'%cn':: committer name
-'%cN':: committer name (respecting .mailmap, see
++%cn+:: committer name
++%cN+:: committer name (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%ce':: committer email
-'%cE':: committer email (respecting .mailmap, see
++%ce+:: committer email
++%cE+:: committer email (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%cl':: committer email local-part (the part before the '@' sign)
-'%cL':: committer local-part (see '%cl') respecting .mailmap, see
++%cl+:: committer email local-part (the part before the `@` sign)
++%cL+:: committer local-part (see +%cl+) respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%cd':: committer date (format respects --date= option)
-'%cD':: committer date, RFC2822 style
-'%cr':: committer date, relative
-'%ct':: committer date, UNIX timestamp
-'%ci':: committer date, ISO 8601-like format
-'%cI':: committer date, strict ISO 8601 format
-'%cs':: committer date, short format (`YYYY-MM-DD`)
-'%ch':: committer date, human style (like the `--date=human` option of
++%cd+:: committer date (format respects --date= option)
++%cD+:: committer date, RFC2822 style
++%cr+:: committer date, relative
++%ct+:: committer date, UNIX timestamp
++%ci+:: committer date, ISO 8601-like format
++%cI+:: committer date, strict ISO 8601 format
++%cs+:: committer date, short format (`YYYY-MM-DD`)
++%ch+:: committer date, human style (like the `--date=human` option of
 	linkgit:git-rev-list[1])
-'%d':: ref names, like the --decorate option of linkgit:git-log[1]
-'%D':: ref names without the " (", ")" wrapping.
-'%(decorate[:<options>])'::
++%d+:: ref names, like the --decorate option of linkgit:git-log[1]
++%D+:: ref names without the " (", ")" wrapping.
+++%(decorate++`[:<option>,...]`++)++::
 ref names with custom decorations. The `decorate` string may be followed by a
 colon and zero or more comma-separated options. Option values may contain
 literal formatting codes. These must be used for commas (`%x2C`) and closing
 parentheses (`%x29`), due to their role in the option syntax.
 +
-** 'prefix=<value>': Shown before the list of ref names.  Defaults to "{nbsp}`(`".
-** 'suffix=<value>': Shown after the list of ref names.  Defaults to "`)`".
-** 'separator=<value>': Shown between ref names.  Defaults to "`,`{nbsp}".
-** 'pointer=<value>': Shown between HEAD and the branch it points to, if any.
-		      Defaults to "{nbsp}`->`{nbsp}".
-** 'tag=<value>': Shown before tag names. Defaults to "`tag:`{nbsp}".
+** `prefix=<value>`: Shown before the list of ref names.  Defaults to "{nbsp}+(+".
+** `suffix=<value>`: Shown after the list of ref names.  Defaults to "+)+".
+** `separator=<value>`: Shown between ref names.  Defaults to "+,+{nbsp}".
+** `pointer=<value>`: Shown between HEAD and the branch it points to, if any.
+		      Defaults to "{nbsp}+->+{nbsp}".
+** `tag=<value>`: Shown before tag names. Defaults to "`tag:`{nbsp}".
 
 +
 For example, to produce decorations with no wrapping
 or tag annotations, and spaces as separators:
 +
-`%(decorate:prefix=,suffix=,tag=,separator= )`
+++%(decorate:prefix=,suffix=,tag=,separator= )++
 
-'%(describe[:<options>])'::
+++%(describe++`[:<option>,...]`++)++::
 human-readable name, like linkgit:git-describe[1]; empty string for
 undescribable commits.  The `describe` string may be followed by a colon and
 zero or more comma-separated options.  Descriptions can be inconsistent when
 tags are added or removed at the same time.
 +
-** 'tags[=<bool-value>]': Instead of only considering annotated tags,
+** `tags[=<bool-value>]`: Instead of only considering annotated tags,
    consider lightweight tags as well.
-** 'abbrev=<number>': Instead of using the default number of hexadecimal digits
+** `abbrev=<number>`: Instead of using the default number of hexadecimal digits
    (which will vary according to the number of objects in the repository with a
    default of 7) of the abbreviated object name, use <number> digits, or as many
    digits as needed to form a unique object name.
-** 'match=<pattern>': Only consider tags matching the given
-   `glob(7)` pattern, excluding the "refs/tags/" prefix.
-** 'exclude=<pattern>': Do not consider tags matching the given
-   `glob(7)` pattern, excluding the "refs/tags/" prefix.
+** `match=<pattern>`: Only consider tags matching the given
+   `glob(7)` _<pattern>_, excluding the `refs/tags/` prefix.
+** `exclude=<pattern>`: Do not consider tags matching the given
+   `glob(7)` _<pattern>_, excluding the `refs/tags/` prefix.
 
-'%S':: ref name given on the command line by which the commit was reached
++%S+:: ref name given on the command line by which the commit was reached
        (like `git log --source`), only works with `git log`
-'%e':: encoding
-'%s':: subject
-'%f':: sanitized subject line, suitable for a filename
-'%b':: body
-'%B':: raw body (unwrapped subject and body)
++%e+:: encoding
++%s+:: subject
++%f+:: sanitized subject line, suitable for a filename
++%b+:: body
++%B+:: raw body (unwrapped subject and body)
 ifndef::git-rev-list[]
-'%N':: commit notes
++%N+:: commit notes
 endif::git-rev-list[]
-'%GG':: raw verification message from GPG for a signed commit
-'%G?':: show "G" for a good (valid) signature,
++%GG+:: raw verification message from GPG for a signed commit
++%G?+:: show "G" for a good (valid) signature,
 	"B" for a bad signature,
 	"U" for a good signature with unknown validity,
 	"X" for a good signature that has expired,
@@ -279,86 +282,86 @@ endif::git-rev-list[]
 	"R" for a good signature made by a revoked key,
 	"E" if the signature cannot be checked (e.g. missing key)
 	and "N" for no signature
-'%GS':: show the name of the signer for a signed commit
-'%GK':: show the key used to sign a signed commit
-'%GF':: show the fingerprint of the key used to sign a signed commit
-'%GP':: show the fingerprint of the primary key whose subkey was used
++%GS+:: show the name of the signer for a signed commit
++%GK+:: show the key used to sign a signed commit
++%GF+:: show the fingerprint of the key used to sign a signed commit
++%GP+:: show the fingerprint of the primary key whose subkey was used
 	to sign a signed commit
-'%GT':: show the trust level for the key used to sign a signed commit
-'%gD':: reflog selector, e.g., `refs/stash@{1}` or `refs/stash@{2
++%GT+:: show the trust level for the key used to sign a signed commit
++%gD+:: reflog selector, e.g., `refs/stash@{1}` or `refs/stash@{2
 	minutes ago}`; the format follows the rules described for the
 	`-g` option. The portion before the `@` is the refname as
 	given on the command line (so `git log -g refs/heads/master`
 	would yield `refs/heads/master@{0}`).
-'%gd':: shortened reflog selector; same as `%gD`, but the refname
++%gd+:: shortened reflog selector; same as `%gD`, but the refname
 	portion is shortened for human readability (so
 	`refs/heads/master` becomes just `master`).
-'%gn':: reflog identity name
-'%gN':: reflog identity name (respecting .mailmap, see
++%gn+:: reflog identity name
++%gN+:: reflog identity name (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%ge':: reflog identity email
-'%gE':: reflog identity email (respecting .mailmap, see
++%ge+:: reflog identity email
++%gE+:: reflog identity email (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
-'%gs':: reflog subject
-'%(trailers[:<options>])'::
++%gs+:: reflog subject
+++%(trailers++`[:<option>,...]`++)++::
 display the trailers of the body as interpreted by
 linkgit:git-interpret-trailers[1]. The `trailers` string may be followed by
 a colon and zero or more comma-separated options. If any option is provided
 multiple times, the last occurrence wins.
 +
-** 'key=<key>': only show trailers with specified <key>. Matching is done
+** `key=<key>`: only show trailers with specified <key>. Matching is done
    case-insensitively and trailing colon is optional. If option is
    given multiple times trailer lines matching any of the keys are
    shown. This option automatically enables the `only` option so that
    non-trailer lines in the trailer block are hidden. If that is not
    desired it can be disabled with `only=false`.  E.g.,
-   `%(trailers:key=Reviewed-by)` shows trailer lines with key
+   +%(trailers:key=Reviewed-by)+ shows trailer lines with key
    `Reviewed-by`.
-** 'only[=<bool>]': select whether non-trailer lines from the trailer
+** `only[=<bool>]`: select whether non-trailer lines from the trailer
    block should be included.
-** 'separator=<sep>': specify the separator inserted between trailer
+** `separator=<sep>`: specify the separator inserted between trailer
    lines. Defaults to a line feed character. The string <sep> may contain
    the literal formatting codes described above. To use comma as
    separator one must use `%x2C` as it would otherwise be parsed as
-   next option. E.g., `%(trailers:key=Ticket,separator=%x2C )`
+   next option. E.g., +%(trailers:key=Ticket,separator=%x2C )+
    shows all trailer lines whose key is "Ticket" separated by a comma
    and a space.
-** 'unfold[=<bool>]': make it behave as if interpret-trailer's `--unfold`
+** `unfold[=<bool>]`: make it behave as if interpret-trailer's `--unfold`
    option was given. E.g.,
-   `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
-** 'keyonly[=<bool>]': only show the key part of the trailer.
-** 'valueonly[=<bool>]': only show the value part of the trailer.
-** 'key_value_separator=<sep>': specify the separator inserted between
+   +%(trailers:only,unfold=true)+ unfolds and shows all trailer lines.
+** `keyonly[=<bool>]`: only show the key part of the trailer.
+** `valueonly[=<bool>]`: only show the value part of the trailer.
+** `key_value_separator=<sep>`: specify the separator inserted between
    the key and value of each trailer. Defaults to ": ". Otherwise it
-   shares the same semantics as 'separator=<sep>' above.
+   shares the same semantics as `separator=<sep>` above.
 
 NOTE: Some placeholders may depend on other options given to the
-revision traversal engine. For example, the `%g*` reflog options will
+revision traversal engine. For example, the +%g*+ reflog options will
 insert an empty string unless we are traversing reflog entries (e.g., by
-`git log -g`). The `%d` and `%D` placeholders will use the "short"
+`git log -g`). The +%d+ and +%D+ placeholders will use the "short"
 decoration format if `--decorate` was not already provided on the command
 line.
 
 The boolean options accept an optional value `[=<bool-value>]`. The
-values taken by `--type=bool` git-config[1], like `yes` and `off`,
+values taken by `--type=bool` linkgit:git-config[1], like `yes` and `off`,
 are all accepted.  Giving a boolean option without `=<value>` is
 equivalent to giving it with `=true`.
 
-If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
+If you add a `+` (plus sign) after +%+ of a placeholder, a line-feed
 is inserted immediately before the expansion if and only if the
 placeholder expands to a non-empty string.
 
-If you add a `-` (minus sign) after '%' of a placeholder, all consecutive
+If you add a `-` (minus sign) after +%+ of a placeholder, all consecutive
 line-feeds immediately preceding the expansion are deleted if and only if the
 placeholder expands to an empty string.
 
-If you add a ` ` (space) after '%' of a placeholder, a space
+If you add a `' '` (space) after +%+ of a placeholder, a space
 is inserted immediately before the expansion if and only if the
 placeholder expands to a non-empty string.
 
-* 'tformat:'
+* `tformat:`
 +
-The 'tformat:' format works exactly like 'format:', except that it
+The `tformat:` format works exactly like `format:`, except that it
 provides "terminator" semantics instead of "separator" semantics. In
 other words, each commit has the message terminator character (usually a
 newline) appended, rather than a separator placed between entries.
@@ -378,7 +381,7 @@ $ git log -2 --pretty=tformat:%h 4da45bef \
 7134973
 ---------------------
 +
-In addition, any unrecognized string that has a `%` in it is interpreted
+In addition, any unrecognized string that has a +%+ in it is interpreted
 as if it has `tformat:` in front of it.  For example, these two are
 equivalent:
 +
-- 
gitgitgadget

