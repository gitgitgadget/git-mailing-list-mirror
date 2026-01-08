Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE469154BE2
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886265; cv=none; b=OVS5dUqwWqk+x5iFTm9Yt7HSqpfO0EQESW4Fl5z1fU4qq4QKfj8cmqXoV5l/fpvkDwIximKgzgVe5Paw6HZnqbvK02fpi7rQOpnbjBvbbcxMe7tk01SA6LnbDqX17+7TevolKovaDnzqc1SloVHrD9il8Cps80cEJles44rd/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886265; c=relaxed/simple;
	bh=3vtwUjEXZYxaNW/ajr7S/WQUG82EmT23kYZ8LFtV/qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0RoYRioR9nAQ3+sLInhP2l7m13609PI7mugHYMph3xSPAZOWIQ13JwWsshR7lA42/WMvUwhw6nQs3mOyDJKNXhu0n2+cx8Fq5pEt2/DKuC9I3XKQvr7aD6xA0LBOUlbVGPr3Kch0hZVKvpBOHT/05lhgD+MRFPTOBoC27PYDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=michael.lyo.nz; spf=pass smtp.mailfrom=michael.lyo.nz; dkim=pass (2048-bit key) header.d=michael.lyo.nz header.i=@michael.lyo.nz header.b=SC4bg+Xa; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=michael.lyo.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michael.lyo.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michael.lyo.nz header.i=@michael.lyo.nz header.b="SC4bg+Xa"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dn84Z3r5Fz9vNG;
	Thu,  8 Jan 2026 16:30:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michael.lyo.nz;
	s=MBO0001; t=1767886254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyqHa08bp79+xBp+aT1nUH9eU0y9cX64VZcW0mQHUws=;
	b=SC4bg+Xa7s86MhhbGOPC0VNJnBm+sPriRdMYAbUSsNIJ6XlCIpm7XsnuWzyQtzxeb8nnc8
	vQ+ZTGzM1JUQxoGXO8S/ATbo1YT3kLcNrpoL8VLvb034XNxic5UwVpY9NGh38nrnlojBML
	dYEn5Oi1IiDweJiV8zqOwHs4G7ZSE88GIp8TrQwYUbQz9NgZEW47CuZ38hNwbJe3fx7nq3
	jXRlhNO8qt8kg2N7PbGpFov/qSlgaXSivu4uDpfTNbHJm8sEyHtn3Ksvyevc004zPaQDfi
	w85FgaOF7GhrljQI5yYFK5Nh8TLUIL8MMzb4XQR2bzmJMlTQbfEwtZdrW9WgYQ==
From: Michael Lyons <git@michael.lyo.nz>
To: git@vger.kernel.org
Cc: Michael Lyons <git@michael.lyo.nz>
Subject: [PATCH v2 2/2] doc: git-blame: convert to new doc format
Date: Thu,  8 Jan 2026 10:30:21 -0500
Message-ID: <20260108153039.658217-3-git@michael.lyo.nz>
In-Reply-To: <20260108153039.658217-1-git@michael.lyo.nz>
References: <20260105230220.519303-1-git@michael.lyo.nz>
 <20260108153039.658217-1-git@michael.lyo.nz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Use _<placeholder>_ instead of <placeholder> in the description
- Use _underscores_ around math associated with <placeholders>
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Michael Lyons <git@michael.lyo.nz>
---
 Documentation/git-blame.adoc | 72 ++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
index adcbb6f5dc..8808009e87 100644
--- a/Documentation/git-blame.adoc
+++ b/Documentation/git-blame.adoc
@@ -7,12 +7,12 @@ git-blame - Show what revision and author last modified each line of a file
 
 SYNOPSIS
 --------
-[verse]
-'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
-	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
-	    [--ignore-rev <rev>] [--ignore-revs-file <file>]
-	    [--color-lines] [--color-by-age] [--progress] [--abbrev=<n>]
-	    [ --contents <file> ] [<rev> | --reverse <rev>..<rev>] [--] <file>
+[synopsis]
+git blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
+	  [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
+	  [--ignore-rev <rev>] [--ignore-revs-file <file>]
+	  [--color-lines] [--color-by-age] [--progress] [--abbrev=<n>]
+	  [ --contents <file> ] [<rev> | --reverse <rev>..<rev>] [--] <file>
 
 DESCRIPTION
 -----------
@@ -30,7 +30,7 @@ lines that were copied and pasted from another file, etc., see the
 `-C` and `-M` options.
 
 The report does not tell you anything about lines which have been deleted or
-replaced; you need to use a tool such as 'git diff' or the "pickaxe"
+replaced; you need to use a tool such as `git diff` or the "pickaxe"
 interface briefly mentioned in the following paragraph.
 
 Apart from supporting file annotation, Git also supports searching the
@@ -50,47 +50,47 @@ OPTIONS
 -------
 include::blame-options.adoc[]
 
--c::
+`-c`::
 	Use the same output mode as linkgit:git-annotate[1] (Default: off).
 
---score-debug::
+`--score-debug`::
 	Include debugging information related to the movement of
 	lines between files (see `-C`) and lines moved within a
 	file (see `-M`).  The first number listed is the score.
 	This is the number of alphanumeric characters detected
 	as having been moved between or within files.  This must be above
-	a certain threshold for 'git blame' to consider those lines
+	a certain threshold for `git blame` to consider those lines
 	of code to have been moved.
 
--f::
---show-name::
+`-f`::
+`--show-name`::
 	Show the filename in the original commit.  By default
 	the filename is shown if there is any line that came from a
 	file with a different name, due to rename detection.
 
--n::
---show-number::
+`-n`::
+`--show-number`::
 	Show the line number in the original commit (Default: off).
 
--s::
+`-s`::
 	Suppress the author name and timestamp from the output.
 
--e::
---show-email::
+`-e`::
+`--show-email`::
 	Show the author email instead of the author name (Default: off).
 	This can also be controlled via the `blame.showEmail` config
 	option.
 
--w::
+`-w`::
 	Ignore whitespace when comparing the parent's version and
 	the child's to find where the lines came from.
 
 include::diff-algorithm-option.adoc[]
 
---abbrev=<n>::
-	Instead of using the default 7+1 hexadecimal digits as the
-	abbreviated object name, use <m>+1 digits, where <m> is at
-	least <n> but ensures the commit object names are unique.
+`--abbrev=<n>`::
+	Instead of using the default _7+1_ hexadecimal digits as the
+	abbreviated object name, use _<m>+1_ digits, where _<m>_ is at
+	least _<n>_ but ensures the commit object names are unique.
 	Note that 1 column
 	is used for a caret to mark the boundary commit.
 
@@ -124,21 +124,21 @@ header at the minimum has the first line which has:
 This header line is followed by the following information
 at least once for each commit:
 
-- the author name ("author"), email ("author-mail"), time
-  ("author-time"), and time zone ("author-tz"); similarly
+- the author name (`author`), email (`author-mail`), time
+  (`author-time`), and time zone (`author-tz`); similarly
   for committer.
 - the filename in the commit that the line is attributed to.
-- the first line of the commit log message ("summary").
+- the first line of the commit log message (`summary`).
 
 The contents of the actual line are output after the above
-header, prefixed by a TAB. This is to allow adding more
+header, prefixed by a _TAB_. This is to allow adding more
 header elements later.
 
 The porcelain format generally suppresses commit information that has
 already been seen. For example, two lines that are blamed to the same
 commit will both be shown, but the details for that commit will be shown
 only once. Information which is specific to individual lines will not be
-grouped together, like revs to be marked 'ignored' or 'unblamable'. This
+grouped together, like revs to be marked `ignored` or `unblamable`. This
 is more efficient, but may require more state be kept by the reader. The
 `--line-porcelain` option can be used to output full commit information
 for each line, allowing simpler (but less efficient) usage like:
@@ -152,7 +152,7 @@ for each line, allowing simpler (but less efficient) usage like:
 SPECIFYING RANGES
 -----------------
 
-Unlike 'git blame' and 'git annotate' in older versions of git, the extent
+Unlike `git blame` and `git annotate` in older versions of git, the extent
 of the annotation can be limited to both line ranges and revision
 ranges. The `-L` option, which limits annotation to a range of lines, may be
 specified multiple times.
@@ -173,7 +173,7 @@ which limits the annotation to the body of the `hello` subroutine.
 
 When you are not interested in changes older than version
 v2.6.18, or changes older than 3 weeks, you can use revision
-range specifiers similar to 'git rev-list':
+range specifiers similar to `git rev-list`:
 
 	git blame v2.6.18.. -- foo
 	git blame --since=3.weeks -- foo
@@ -212,8 +212,9 @@ does not contain the actual lines from the file that is being
 annotated.
 
 . Each blame entry always starts with a line of:
-
-	<40-byte-hex-sha1> <sourceline> <resultline> <num-lines>
++
+[synopsis]
+<40-byte-hex-sha1> <sourceline> <resultline> <num-lines>
 +
 Line numbers count from 1.
 
@@ -224,16 +225,17 @@ Line numbers count from 1.
 
 . Unlike the Porcelain format, the filename information is always
   given and terminates the entry:
-
-	"filename" <whitespace-quoted-filename-goes-here>
++
+[synopsis]
+filename <whitespace-quoted-filename-goes-here>
 +
 and thus it is really quite easy to parse for some line- and word-oriented
 parser (which should be quite natural for most scripting languages).
 +
 [NOTE]
 For people who do parsing: to make it more robust, just ignore any
-lines between the first and last one ("<sha1>" and "filename" lines)
-where you do not recognize the tag words (or care about that particular
+lines between the first and last one (_<40-byte-hex-sha1>_ and `filename`
+lines) where you do not recognize the tag words (or care about that particular
 one) at the beginning of the "extended information" lines. That way, if
 there is ever added information (like the commit encoding or extended
 commit commentary), a blame viewer will not care.
-- 
2.47.3

