Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6244217F2E
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886265; cv=none; b=WP+wTYET6H/c2D2RVNVmao82EjgZG80FsJfwxtjJTFMl/vN6it+FNRG08y5sqyhF2c5pSKBlNmzG4jq5MzkwyFgOYTHOz2U1p9MKZIdxtavcPmC2S5Q2pRvoK7tTP2o0xm2zR3n6Riw3Cw1C6jYmTIenl+6eefnOOv0IL0LKHfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886265; c=relaxed/simple;
	bh=A9fiNzVnvctePt2vH1SW7gaDxtlFTI0PzTFb2NXNpfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7K6dRobe32VLqRh3KPO/j65gBQyItAau8LVsKaRl/IeD0rRZOvULWyEW5V4lkLE7rVzx02JiagOGupIjmsCwEeEVMSB5Bo73Wsfcy/+9xeJFu8Pa9PWBk4+WnnKO3JJ/NMCbA8J4WN0l1EczdyTjgQnJpfYZQWdw0J3XRMuZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=michael.lyo.nz; spf=pass smtp.mailfrom=michael.lyo.nz; dkim=pass (2048-bit key) header.d=michael.lyo.nz header.i=@michael.lyo.nz header.b=PwQMzIXc; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=michael.lyo.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michael.lyo.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michael.lyo.nz header.i=@michael.lyo.nz header.b="PwQMzIXc"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dn84X6ZsCz9tQt;
	Thu,  8 Jan 2026 16:30:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michael.lyo.nz;
	s=MBO0001; t=1767886253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNlpooFLFDCj4AxnrF45eJe1mjGBfdMqNeNZEaoCEDU=;
	b=PwQMzIXckkSICNWTGbHOwrG3kaSnd0XAp0xTqxOaAKihjJCI0Kw/uuehiLHwn6Sh39m1cn
	ONCi5UQyEHAlBmbrkWZHIdsNCvmoUUzDkWDPdzs69XVQ8gKs3cxRZ1GRs7HR7ZHSjRPAr3
	8mBQ5KHRxSlstMBWnqshLMyfpgd3wJicwnBbqYKoeocp4rKgkNp25WLWnyRQGnbITApode
	32QGYS+lfXSTFegwUhuRh9JNBKPRnd5ZRrGeSqeflInrjKUgz+d2QLjznB0sEoxJE9RVJp
	rZACfntAdBOGQNnFuaTjJB7X1EM1Vlngspr0iOedn9/uVsf04jj4/3iaAVQPvw==
From: Michael Lyons <git@michael.lyo.nz>
To: git@vger.kernel.org
Cc: Michael Lyons <git@michael.lyo.nz>
Subject: [PATCH v2 1/2] doc: blame-options: convert to new doc format
Date: Thu,  8 Jan 2026 10:30:20 -0500
Message-ID: <20260108153039.658217-2-git@michael.lyo.nz>
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
- Modify some samples to use <placeholders>
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Michael Lyons <git@michael.lyo.nz>
---
 Documentation/blame-options.adoc | 120 +++++++++++++++----------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/Documentation/blame-options.adoc b/Documentation/blame-options.adoc
index 1fb948fc76..1ae1222b6b 100644
--- a/Documentation/blame-options.adoc
+++ b/Documentation/blame-options.adoc
@@ -1,105 +1,105 @@
--b::
+`-b`::
 	Show blank SHA-1 for boundary commits.  This can also
 	be controlled via the `blame.blankBoundary` config option.
 
---root::
+`--root`::
 	Do not treat root commits as boundaries.  This can also be
 	controlled via the `blame.showRoot` config option.
 
---show-stats::
+`--show-stats`::
 	Include additional statistics at the end of blame output.
 
--L <start>,<end>::
--L :<funcname>::
-	Annotate only the line range given by '<start>,<end>',
-	or by the function name regex '<funcname>'.
+`-L <start>,<end>`::
+`-L :<funcname>`::
+	Annotate only the line range given by `<start>,<end>`,
+	or by the function name regex _<funcname>_.
 	May be specified multiple times. Overlapping ranges are allowed.
 +
-'<start>' and '<end>' are optional. `-L <start>` or `-L <start>,` spans from
-'<start>' to end of file. `-L ,<end>` spans from start of file to '<end>'.
+_<start>_ and _<end>_ are optional. `-L <start>` or `-L <start>,` spans from
+_<start>_ to end of file. `-L ,<end>` spans from start of file to _<end>_.
 +
 include::line-range-format.adoc[]
 
--l::
+`-l`::
 	Show long rev (Default: off).
 
--t::
+`-t`::
 	Show raw timestamp (Default: off).
 
--S <revs-file>::
-	Use revisions from revs-file instead of calling linkgit:git-rev-list[1].
+`-S <revs-file>`::
+	Use revisions from _<revs-file>_ instead of calling
+	linkgit:git-rev-list[1].
 
---reverse <rev>..<rev>::
+`--reverse <start>..<end>`::
 	Walk history forward instead of backward. Instead of showing
 	the revision in which a line appeared, this shows the last
 	revision in which a line has existed. This requires a range of
-	revision like START..END where the path to blame exists in
-	START.  `git blame --reverse START` is taken as `git blame
-	--reverse START..HEAD` for convenience.
+	revision like `<start>..<end>` where the path to blame exists in
+	_<start>_.  `git blame --reverse <start>` is taken as `git blame
+	--reverse <start>..HEAD` for convenience.
 
---first-parent::
+`--first-parent`::
 	Follow only the first parent commit upon seeing a merge
 	commit. This option can be used to determine when a line
 	was introduced to a particular integration branch, rather
 	than when it was introduced to the history overall.
 
--p::
---porcelain::
+`-p`::
+`--porcelain`::
 	Show in a format designed for machine consumption.
 
---line-porcelain::
+`--line-porcelain`::
 	Show the porcelain format, but output commit information for
 	each line, not just the first time a commit is referenced.
-	Implies --porcelain.
+	Implies `--porcelain`.
 
---incremental::
+`--incremental`::
 	Show the result incrementally in a format designed for
 	machine consumption.
 
---encoding=<encoding>::
-	Specifies the encoding used to output author names
+`--encoding=<encoding>`::
+	Specify the encoding used to output author names
 	and commit summaries. Setting it to `none` makes blame
 	output unconverted data. For more information see the
 	discussion about encoding in the linkgit:git-log[1]
 	manual page.
 
---contents <file>::
-	Annotate using the contents from the named file, starting from <rev>
-	if it is specified, and HEAD otherwise. You may specify '-' to make
+`--contents <file>`::
+	Annotate using the contents from _<file>_, starting from _<rev>_
+	if it is specified, and `HEAD` otherwise. You may specify `-` to make
 	the command read from the standard input for the file contents.
 
---date <format>::
-	Specifies the format used to output dates. If --date is not
-	provided, the value of the blame.date config variable is
-	used. If the blame.date config variable is also not set, the
+`--date <format>`::
+	Specify the format used to output dates. If `--date` is not
+	provided, the value of the `blame.date` config variable is
+	used. If the `blame.date` config variable is also not set, the
 	iso format is used. For supported values, see the discussion
-	of the --date option at linkgit:git-log[1].
+	of the `--date` option at linkgit:git-log[1].
 
---progress::
---no-progress::
-	Progress status is reported on the standard error stream
-	by default when it is attached to a terminal. This flag
-	enables progress reporting even if not attached to a
-	terminal. Can't use `--progress` together with `--porcelain`
-	or `--incremental`.
+`--progress`::
+`--no-progress`::
+	Enable progress reporting on the standard error stream even if
+	not attached to a terminal. By default, progress status is
+	reported only when it is attached. You can't use `--progress`
+	together with `--porcelain` or `--incremental`.
 
--M[<num>]::
+`-M[<num>]`::
 	Detect moved or copied lines within a file. When a commit
 	moves or copies a block of lines (e.g. the original file
-	has A and then B, and the commit changes it to B and then
-	A), the traditional 'blame' algorithm notices only half of
+	has _A_ and then _B_, and the commit changes it to _B_ and then
+	_A_), the traditional `blame` algorithm notices only half of
 	the movement and typically blames the lines that were moved
-	up (i.e. B) to the parent and assigns blame to the lines that
-	were moved down (i.e. A) to the child commit.  With this
+	up (i.e. _B_) to the parent and assigns blame to the lines that
+	were moved down (i.e. _A_) to the child commit.  With this
 	option, both groups of lines are blamed on the parent by
 	running extra passes of inspection.
 +
-<num> is optional but it is the lower bound on the number of
+_<num>_ is optional, but it is the lower bound on the number of
 alphanumeric characters that Git must detect as moving/copying
 within a file for it to associate those lines with the parent
 commit. The default value is 20.
 
--C[<num>]::
+`-C[<num>]`::
 	In addition to `-M`, detect lines moved or copied from other
 	files that were modified in the same commit.  This is
 	useful when you reorganize your program and move code
@@ -109,14 +109,14 @@ commit. The default value is 20.
 	option is given three times, the command additionally
 	looks for copies from other files in any commit.
 +
-<num> is optional but it is the lower bound on the number of
+_<num>_ is optional, but it is the lower bound on the number of
 alphanumeric characters that Git must detect as moving/copying
 between files for it to associate those lines with the parent
 commit. And the default value is 40. If there are more than one
-`-C` options given, the <num> argument of the last `-C` will
+`-C` options given, the _<num>_ argument of the last `-C` will
 take effect.
 
---ignore-rev <rev>::
+`--ignore-rev <rev>`::
 	Ignore changes made by the revision when assigning blame, as if the
 	change never happened.  Lines that were changed or added by an ignored
 	commit will be blamed on the previous commit that changed that line or
@@ -126,26 +126,26 @@ take effect.
 	another commit will be marked with a `?` in the blame output.  If the
 	`blame.markUnblamableLines` config option is set, then those lines touched
 	by an ignored commit that we could not attribute to another revision are
-	marked with a '*'. In the porcelain modes, we print 'ignored' and
-	'unblamable' on a newline respectively.
+	marked with a `*`. In the porcelain modes, we print `ignored` and
+	`unblamable` on a newline respectively.
 
---ignore-revs-file <file>::
-	Ignore revisions listed in `file`, which must be in the same format as an
+`--ignore-revs-file <file>`::
+	Ignore revisions listed in _<file>_, which must be in the same format as an
 	`fsck.skipList`.  This option may be repeated, and these files will be
 	processed after any files specified with the `blame.ignoreRevsFile` config
 	option.  An empty file name, `""`, will clear the list of revs from
 	previously processed files.
 
---color-lines::
+`--color-lines`::
 	Color line annotations in the default format differently if they come from
 	the same commit as the preceding line. This makes it easier to distinguish
 	code blocks introduced by different commits. The color defaults to cyan and
 	can be adjusted using the `color.blame.repeatedLines` config option.
 
---color-by-age::
-	Color line annotations depending on the age of the line in the default format.
-	The `color.blame.highlightRecent` config option controls what color is used for
-	each range of age.
+`--color-by-age`::
+	Color line annotations depending on the age of the line in
+	the default format.  The `color.blame.highlightRecent` config
+	option controls what color is used for each range of age.
 
--h::
+`-h`::
 	Show help message.
-- 
2.47.3

