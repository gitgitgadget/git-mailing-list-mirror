Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE45B357A40
	for <git@vger.kernel.org>; Mon, 25 May 2026 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704919; cv=none; b=f9rdykCDvZT6dAtHvHkqgv1VBTDbklyEIpZtBdi/eF1p29wJw4TAGJu8MlB+urcDeJHTbPNTVmAd8hYpZrVNpoEwhI2QD0h+KQD9sEdjgT5kdmJK0JlooN1dKHaV3GZMdroCIzWZYFG9xTu+ibwS3YKAuDoJN9ctvH3RcdeZJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704919; c=relaxed/simple;
	bh=dRe6K9mV9jspPaAst6ui636oOXst3EV6frFmG7gdh8o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=kjfLoSA7hwiWoMdEkBLpK5a8LHgoxBmYI/l49/JYuinnpLeZ4f5+i4YL+UdJGbfPkY0oQIpOAnbfLkz7hoYRq0Lzxu6c4Kiezvn+pjh8w0xE4Jx2fSlh3svbfp2CrTDDKz2Ik5r1/tL9VcFWXhZ8e+tuHqPi+VfuDL8mx7+9Er8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0GiOYl1; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0GiOYl1"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-914bb8e95c2so143624285a.1
        for <git@vger.kernel.org>; Mon, 25 May 2026 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779704914; x=1780309714; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBN4G3qaA0TQ0vZ9Le2h2xZV8j2YczWN4iU99Z8ftlc=;
        b=X0GiOYl1zx2Gjr+0z8W3MK4/kVHn6E5UEyq/wONyF5p2WfVP7ApEUA5tU0cyBnvnH5
         t91pm6FXkmpok4lteWJVAl1HwX4EpF2GKzoM791sMFGJ6o6YJ9CZwDDtxy+y3gzzPkPo
         xdy4+VmJNhyRhZlZtY9JzJQpa51Y1evKmmW46naPrF4+h+Y0jqUxtdFaI6tY6lwrx4la
         Z4uUtLLXe66rQNN2+PrYR9QeiASd2L8MpJxXH9vRYaqiOqvqGpC3OlZ2elJB6YC6LxXa
         RYKRFyKoYjUVmMzvdpMlkf4BLZTlDsCE1F2P0F9X63H3H1H5miKMUjw1JYm7eNh6mg+M
         DdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779704914; x=1780309714;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eBN4G3qaA0TQ0vZ9Le2h2xZV8j2YczWN4iU99Z8ftlc=;
        b=RpnvAysundcKrW+Ia4oKTDfFMw8sXHDWzuqvOfxOZ4G7634gRpIaLpcbT4nhC2BnVO
         mH3egu3/KJCxEgPBd7oeADdsnSulbaM1NskITFlf9bbYQaOXiAJX4y2oTEVaf6/8Bfo9
         u7d7uI1AygV+rogiTiknx9UVeW3Nxek2x3wvsbrAXLq5xBdriPHelAcS1slFmzMrm7+9
         1g/mb6XS0mNvvX+28/nMKlYulg4azYlg88TS9OGByUlm7U/9iTheSuC3AgnhJ2DdYycg
         WGHAOZRfRTW+YmccltRxKBpkPe0/ULqJvSFUKdQ5KqHRI+e9tT6YUdHvvDwBLRTG9O9O
         OmDQ==
X-Gm-Message-State: AOJu0YwyqKwMHSR7IVLHnZlx0N6KvQFVi6U3touZgASahsdbf5/wiu8I
	u1FA+e/H0WoUOqRwVF8Zf0psVMZ76jaCz4XNx9lECmtids7Iaq8WFw4PrqxAfQ==
X-Gm-Gg: Acq92OFRbsGNP38E4+Bp6gYMS/yBzdDZAqsyQKEtg4BKTLiU3DGe2Kx+FzHVHKK8DQ0
	UMVA+JR6EWSE3yHy08vCsbZsbBaxLP+bO8HPvzJv5EnYagrAwoGdTw4EX1T/7yfUXP6Tms54WMy
	AlwmRjTx45Cd21G4+0FbofKIMcrGZwYb2g49chLGMS3fPmyvVugs8jEHzyI7TmlzFPEKyyTLpTH
	T0hQkd7RH31R1QZ146dIZIET341E/1bm7yYnan/uN2fqzmmYvu+XkwXBfR5DQIXmCTtHRLmqlfN
	SaK4lpUUGZhwgPEeW8iBLJ+v3CznLxCS98TbhN9hLMBoSAL2fbkLzN8oBde7SCbjcTjYcAxaQ02
	Ea+O4TisR2T6IKKGYa1zQiIAnbzI0w9E4c/m1pPpbaWxG23BCp1BZpUhUeeQI98fvZE1vMtMyVr
	aWcBRcEQAxRplWKQZMyEV1QIsl0w==
X-Received: by 2002:a05:620a:2a08:b0:914:acfb:117f with SMTP id af79cd13be357-914b48d5cf2mr1864383685a.8.1779704913637;
        Mon, 25 May 2026 03:28:33 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.15.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb90376csm1047042585a.16.2026.05.25.03.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:28:32 -0700 (PDT)
Message-Id: <fceaf195e8d2ddcb593f1b9cfacd88e996c48b75.1779704908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>
References: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
	<pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 10:28:24 +0000
Subject: [PATCH v2 3/6] doc: convert git-grep synopsis and options to new
 style
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

Convert git-grep.adoc from [verse]/single-quote style to the modern
synopsis-block style:

- Replace [verse] with [synopsis] in SYNOPSIS block
- Change 'git grep' to git grep (no single quotes)
- Backtick-quote all OPTIONS terms
- Convert inline man page refs: grep(1) -> `grep`(1)
- Convert inline command refs: 'git diff' -> `git diff`
- Convert prose placeholders: <file> -> _<file>_

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/grep.adoc |  36 +++---
 Documentation/git-grep.adoc    | 196 ++++++++++++++++-----------------
 2 files changed, 116 insertions(+), 116 deletions(-)

diff --git a/Documentation/config/grep.adoc b/Documentation/config/grep.adoc
index 10041f27b0..83d4b76dd3 100644
--- a/Documentation/config/grep.adoc
+++ b/Documentation/config/grep.adoc
@@ -1,28 +1,28 @@
-grep.lineNumber::
-	If set to true, enable `-n` option by default.
+`grep.lineNumber`::
+	If set to `true`, enable `-n` option by default.
 
-grep.column::
-	If set to true, enable the `--column` option by default.
+`grep.column`::
+	If set to `true`, enable the `--column` option by default.
 
-grep.patternType::
-	Set the default matching behavior. Using a value of 'basic', 'extended',
-	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
+`grep.patternType`::
+	Set the default matching behavior. Using a value of `basic`, `extended`,
+	`fixed`, or `perl` will enable the `--basic-regexp`, `--extended-regexp`,
 	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
-	value 'default' will use the `grep.extendedRegexp` option to choose
-	between 'basic' and 'extended'.
+	value `default` will use the `grep.extendedRegexp` option to choose
+	between `basic` and `extended`.
 
-grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
+`grep.extendedRegexp`::
+	If set to `true`, enable `--extended-regexp` option by default. This
 	option is ignored when the `grep.patternType` option is set to a value
-	other than 'default'.
+	other than `default`.
 
-grep.threads::
+`grep.threads`::
 	Number of grep worker threads to use. If unset (or set to 0), Git will
 	use as many threads as the number of logical cores available.
 
-grep.fullName::
-	If set to true, enable `--full-name` option by default.
+`grep.fullName`::
+	If set to `true`, enable `--full-name` option by default.
 
-grep.fallbackToNoIndex::
-	If set to true, fall back to `git grep --no-index` if `git grep`
-	is executed outside of a git repository.  Defaults to false.
+`grep.fallbackToNoIndex`::
+	If set to `true`, fall back to `git grep --no-index` if `git grep`
+	is executed outside of a git repository.  Defaults to `false`.
diff --git a/Documentation/git-grep.adoc b/Documentation/git-grep.adoc
index a548585d4c..19b3ade16d 100644
--- a/Documentation/git-grep.adoc
+++ b/Documentation/git-grep.adoc
@@ -8,8 +8,8 @@ git-grep - Print lines matching a pattern
 
 SYNOPSIS
 --------
-[verse]
-'git grep' [-a | --text] [-I] [--textconv] [-i | --ignore-case] [-w | --word-regexp]
+[synopsis]
+git grep [-a | --text] [-I] [--textconv] [-i | --ignore-case] [-w | --word-regexp]
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-P | --perl-regexp]
@@ -41,139 +41,139 @@ characters.  An empty string as search expression matches all lines.
 
 OPTIONS
 -------
---cached::
+`--cached`::
 	Instead of searching tracked files in the working tree, search
 	blobs registered in the index file.
 
---untracked::
+`--untracked`::
 	In addition to searching in the tracked files in the working
 	tree, search also in untracked files.
 
---no-index::
+`--no-index`::
 	Search files in the current directory that is not managed by Git,
 	or by ignoring that the current directory is managed by Git.  This
-	is rather similar to running the regular `grep(1)` utility with its
+	is rather similar to running the regular `grep`(1) utility with its
 	`-r` option specified, but with some additional benefits, such as
-	using pathspec patterns to limit paths;  see the 'pathspec' entry
+	using pathspec patterns to limit paths;  see the `pathspec` entry
 	in linkgit:gitglossary[7] for more information.
 +
 This option cannot be used together with `--cached` or `--untracked`.
 See also `grep.fallbackToNoIndex` in 'CONFIGURATION' below.
 
---no-exclude-standard::
+`--no-exclude-standard`::
 	Also search in ignored files by not honoring the `.gitignore`
 	mechanism. Only useful with `--untracked`.
 
---exclude-standard::
+`--exclude-standard`::
 	Do not pay attention to ignored files specified via the `.gitignore`
 	mechanism.  Only useful when searching files in the current directory
 	with `--no-index`.
 
---recurse-submodules::
+`--recurse-submodules`::
 	Recursively search in each submodule that is active and
 	checked out in the repository.  When used in combination with the
 	_<tree>_ option the prefix of all submodule output will be the name of
 	the parent project's _<tree>_ object.  This option cannot be used together
 	with `--untracked`, and it has no effect if `--no-index` is specified.
 
--a::
---text::
+`-a`::
+`--text`::
 	Process binary files as if they were text.
 
---textconv::
+`--textconv`::
 	Honor textconv filter settings.
 
---no-textconv::
+`--no-textconv`::
 	Do not honor textconv filter settings.
 	This is the default.
 
--i::
---ignore-case::
+`-i`::
+`--ignore-case`::
 	Ignore case differences between the patterns and the
 	files.
 
--I::
+`-I`::
 	Don't match the pattern in binary files.
 
---max-depth <depth>::
-	For each <pathspec> given on command line, descend at most <depth>
+`--max-depth <depth>`::
+	For each _<pathspec>_ given on command line, descend at most _<depth>_
 	levels of directories. A value of -1 means no limit.
-	This option is ignored if <pathspec> contains active wildcards.
+	This option is ignored if _<pathspec>_ contains active wildcards.
 	In other words if "a*" matches a directory named "a*",
-	"*" is matched literally so --max-depth is still effective.
+	"*" is matched literally so `--max-depth` is still effective.
 
--r::
---recursive::
+`-r`::
+`--recursive`::
 	Same as `--max-depth=-1`; this is the default.
 
---no-recursive::
+`--no-recursive`::
 	Same as `--max-depth=0`.
 
--w::
---word-regexp::
+`-w`::
+`--word-regexp`::
 	Match the pattern only at word boundary (either begin at the
 	beginning of a line, or preceded by a non-word character; end at
 	the end of a line or followed by a non-word character).
 
--v::
---invert-match::
+`-v`::
+`--invert-match`::
 	Select non-matching lines.
 
--h::
--H::
+`-h`::
+`-H`::
 	By default, the command shows the filename for each
 	match.  `-h` option is used to suppress this output.
 	`-H` is there for completeness and does not do anything
 	except it overrides `-h` given earlier on the command
 	line.
 
---full-name::
+`--full-name`::
 	When run from a subdirectory, the command usually
 	outputs paths relative to the current directory.  This
 	option forces paths to be output relative to the project
 	top directory.
 
--E::
---extended-regexp::
--G::
---basic-regexp::
+`-E`::
+`--extended-regexp`::
+`-G`::
+`--basic-regexp`::
 	Use POSIX extended/basic regexp for patterns.  Default
 	is to use basic regexp.
 
--P::
---perl-regexp::
+`-P`::
+`--perl-regexp`::
 	Use Perl-compatible regular expressions for patterns.
 +
 Support for these types of regular expressions is an optional
 compile-time dependency. If Git wasn't compiled with support for them
 providing this option will cause it to die.
 
--F::
---fixed-strings::
+`-F`::
+`--fixed-strings`::
 	Use fixed strings for patterns (don't interpret pattern
 	as a regex).
 
--n::
---line-number::
+`-n`::
+`--line-number`::
 	Prefix the line number to matching lines.
 
---column::
+`--column`::
 	Prefix the 1-indexed byte-offset of the first match from the start of the
 	matching line.
 
--l::
---files-with-matches::
---name-only::
--L::
---files-without-match::
+`-l`::
+`--files-with-matches`::
+`--name-only`::
+`-L`::
+`--files-without-match`::
 	Instead of showing every matched line, show only the
 	names of files that contain (or do not contain) matches.
-	For better compatibility with 'git diff', `--name-only` is a
+	For better compatibility with `git diff`, `--name-only` is a
 	synonym for `--files-with-matches`.
 
--O[<pager>]::
---open-files-in-pager[=<pager>]::
-	Open the matching files in the pager (not the output of 'grep').
+`-O[<pager>]`::
+`--open-files-in-pager[=<pager>]`::
+	Open the matching files in the pager (not the output of `grep`).
 	If the pager happens to be "less" or "vi", and the user
 	specified only one pattern, the first file is positioned at
 	the first match automatically. The `pager` argument is
@@ -181,65 +181,65 @@ providing this option will cause it to die.
 	without a space. If `pager` is unspecified, the default pager
 	will be used (see `core.pager` in linkgit:git-config[1]).
 
--z::
---null::
+`-z`::
+`--null`::
 	Use \0 as the delimiter for pathnames in the output, and print
 	them verbatim. Without this option, pathnames with "unusual"
 	characters are quoted as explained for the configuration
 	variable `core.quotePath` (see linkgit:git-config[1]).
 
--o::
---only-matching::
+`-o`::
+`--only-matching`::
 	Print only the matched (non-empty) parts of a matching line, with each such
 	part on a separate output line.
 
--c::
---count::
+`-c`::
+`--count`::
 	Instead of showing every matched line, show the number of
 	lines that match.
 
---color[=<when>]::
+`--color[=<when>]`::
 	Show colored matches.
-	The value must be always (the default), never, or auto.
+	The value must be `always` (the default), `never`, or `auto`.
 
---no-color::
+`--no-color`::
 	Turn off match highlighting, even when the configuration file
 	gives the default to color output.
 	Same as `--color=never`.
 
---break::
+`--break`::
 	Print an empty line between matches from different files.
 
---heading::
+`--heading`::
 	Show the filename above the matches in that file instead of
 	at the start of each shown line.
 
--p::
---show-function::
+`-p`::
+`--show-function`::
 	Show the preceding line that contains the function name of
 	the match, unless the matching line is a function name itself.
 	The name is determined in the same way as `git diff` works out
 	patch hunk headers (see 'Defining a custom hunk-header' in
 	linkgit:gitattributes[5]).
 
--<num>::
--C <num>::
---context <num>::
-	Show <num> leading and trailing lines, and place a line
+`-<num>`::
+`-C <num>`::
+`--context <num>`::
+	Show _<num>_ leading and trailing lines, and place a line
 	containing `--` between contiguous groups of matches.
 
--A <num>::
---after-context <num>::
-	Show <num> trailing lines, and place a line containing
+`-A <num>`::
+`--after-context <num>`::
+	Show _<num>_ trailing lines, and place a line containing
 	`--` between contiguous groups of matches.
 
--B <num>::
---before-context <num>::
-	Show <num> leading lines, and place a line containing
+`-B <num>`::
+`--before-context <num>`::
+	Show _<num>_ leading lines, and place a line containing
 	`--` between contiguous groups of matches.
 
--W::
---function-context::
+`-W`::
+`--function-context`::
 	Show the surrounding text from the previous line containing a
 	function name up to the one before the next function name,
 	effectively showing the whole function in which the match was
@@ -247,22 +247,22 @@ providing this option will cause it to die.
 	`git diff` works out patch hunk headers (see 'Defining a
 	custom hunk-header' in linkgit:gitattributes[5]).
 
--m <num>::
---max-count <num>::
+`-m <num>`::
+`--max-count <num>`::
 	Limit the amount of matches per file. When using the `-v` or
 	`--invert-match` option, the search stops after the specified
 	number of non-matches. A value of -1 will return unlimited
 	results (the default). A value of 0 will exit immediately with
 	a non-zero status.
 
---threads <num>::
-	Number of `grep` worker threads to use.  See 'NOTES ON THREADS'
+`--threads <num>`::
+	Number of `grep` worker threads to use.  See `NOTES ON THREADS`
 	and `grep.threads` in 'CONFIGURATION' for more information.
 
--f <file>::
-	Read patterns from <file>, one per line.
+`-f <file>`::
+	Read patterns from _<file>_, one per line.
 +
-Passing the pattern via <file> allows for providing a search pattern
+Passing the pattern via _<file>_ allows for providing a search pattern
 containing a \0.
 +
 Not all pattern types support patterns containing \0. Git will error
@@ -279,44 +279,44 @@ In future versions we may learn to support patterns containing \0 for
 more search backends, until then we'll die when the pattern type in
 question doesn't support them.
 
--e::
+`-e`::
 	The next parameter is the pattern. This option has to be
 	used for patterns starting with `-` and should be used in
 	scripts passing user input to grep.  Multiple patterns are
-	combined by 'or'.
+	combined by `or`.
 
---and::
---or::
---not::
-( ... )::
+`--and`::
+`--or`::
+`--not`::
+`( ... )`::
 	Specify how multiple patterns are combined using Boolean
 	expressions.  `--or` is the default operator.  `--and` has
 	higher precedence than `--or`.  `-e` has to be used for all
 	patterns.
 
---all-match::
+`--all-match`::
 	When giving multiple pattern expressions combined with `--or`,
 	this flag is specified to limit the match to files that
 	have lines to match all of them.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Do not output matched lines; instead, exit with status 0 when
 	there is a match and with non-zero status when there isn't.
 
-<tree>...::
+`<tree>...`::
 	Instead of searching tracked files in the working tree, search
 	blobs in the given trees.
 
-\--::
+`--`::
 	Signals the end of options; the rest of the parameters
-	are <pathspec> limiters.
+	are _<pathspec>_ limiters.
 
-<pathspec>...::
+`<pathspec>...`::
 	If given, limit the search to paths matching at least one pattern.
-	Both leading paths match and glob(7) patterns are supported.
+	Both leading paths match and `glob`(7) patterns are supported.
 +
-For more details about the <pathspec> syntax, see the 'pathspec' entry
+For more details about the _<pathspec>_ syntax, see the `pathspec` entry
 in linkgit:gitglossary[7].
 
 EXAMPLES
-- 
gitgitgadget

