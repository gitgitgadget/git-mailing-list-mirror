Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556949;
	b=v40IrVPQLefnkhx0qm6YWWvkYoRYebEERivfApMTQB/0cXLyErP37ghzpq+TxrxAYb7t
	 5ckkwfo0He/+wxj1ETek1cakNihMrYJNmyLZxHzq8ls9c5hrIDwTxbRHSTFRIYyLHRFOP
	 PDtpEQvZcUh0feund5lNELyhUSqBROpT5Xb1DuMopFWZMF6TD1FVHcBMNPIcf7S81U8Lo
	 wiKO5ES06fwsJviLQoAPe6qBGjrC+vHNVCaXDveGqDZ4rP6/DIncWnEfw73AwUHwvi9Pj
	 07pBc1CJQqb0o2M56y0wFmlaYkL/g8SL8OSbBzoAJM75ZcRgNWT8TB5yGasVv1eYyEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Fcc:To:Cc;
	bh=jf9wHrCdVGWJJKM7bvX7ahX+KfUb93t0ymtf6eyeK9Q=;
	b=qzVCSrVhUvkmvBlaYHAwphpwhxXdZjLKoaYgdU5OokXSMRO9WCH9qVqBM92kj3ir3ACH
	 4Y0StlsCXRCbBAEJ6P0u0iXRk5+djtqCbxbv50/n+jvKsw3p0wXXNKxCMamRzlCgKZbnJ
	 +09shXIQrQ1uAPuRWY84HT5u+esei4xB5+JQrNA0X2AqMntwyixFjTJTI3FyN+a5VkdVR
	 7U5YnaAMtW9v5kGU+65hDJxQ0Ix1sI2oJo4bwAn24HwCGKBeYnXX6Aqbx33yMfpb7oO/n
	 nfgRyNCe7reUDzXz2Mm3tzcc5JIUICdI1g0k6GzKmQW1vdiiDXJuDeR2dr+2SpeMFsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rxMENARW;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BA5606A330
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 21:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2BA5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rxMENARW
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8629ef48703so2769357a34.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 13:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556947; x=1796161747; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jf9wHrCdVGWJJKM7bvX7ahX+KfUb93t0ymtf6eyeK9Q=;
        b=rxMENARWwdJMpOSKkPb3vRvXfgMrlLLJMPxvUlQUtk6myvHJVJy+Q1rCEtcdnY/nhM
         LVUFJ2jDByvwn1zEn+SknQW+AdKLMO5747uZ1eOlePbPfXMBTyBF78Acm6MAfxaTAwiF
         dhllplT8B6Gmrce+sNbxF/bN2rOaJgPlL+K2bb7dwD8qNfMXnTdX2U81Xq1nlC1JOMcN
         5zPt5/MjycMyAW/8d/7KchSkTB02pxNkAK6CTTvrlLH/EP8YvmOdEU0C+WLzbxvW+oV/
         /Vzx6jS2aoyo6BjHs0qRT6tYXAHF3NrSoz8qIM87yjSjvHYFDWZxN2JSdoeEx9PwBsoM
         VFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556947; x=1796161747;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jf9wHrCdVGWJJKM7bvX7ahX+KfUb93t0ymtf6eyeK9Q=;
        b=1Xam7bOdim6z6Bqim4t3QsTMtcIxUVAFoMTOeI3F+dkIx/dX7zoibF/bNih3W5g/0q
         mZaU8rjarVlcwzLZxxhx/WBIHnsxpJjSqlBBE2255dA4S23+17AtAyMKoHZTLxQZxJjY
         RfmIV3H2Stiz32cVfTi3lQzwcsiBfXorskza8HPXCPDD7+pWY05dtvg1cVkM0ZzBm+gM
         3CHRtsC6GGnfz4QwrzkE7++WFeQvZxsZ0biYDBKyWjSRsyuihCLOBpzSUB5SQeAaLYkz
         aNNZG4ZghAYpCgCKi+H2N3hddFmF+93qMUhreWKXhGffNLonazOQic4whkuxTUOaZ/Cq
         WEfw==
X-Gm-Message-State: APuU4Z+BPSnVofQIXwf+qMBlflyqc+g8OGtR/2ov9WQJnZ3tI6mxfafF
	aLdAMz8TY1gqkUI4LMC+OqsraAtW+GPe7GJRS+poaeUyGVVfh37G/RUGjuzCiQ==
X-Gm-Gg: AZFdTZdfVh+u73ddxbtu54lXyl5MatN5t2mv+ffPJJiq/NzcrCo1w9cfp0HJCTlXzYz
	xUtDhtyH6BIPa1i+JSAb5bBBacq80lLois3TsLt7cIkDc2eVDxx0vhUii93vJUkXlIkNZPADnAW
	VTtN7uAQ8L3B8Je11ihtt5k5pLfCRQCpNippM3C2zPKqWQyh/A0Eq6YyiJjPvJ8wPXsJCO8uUD3
	55XC83J1Gc9u7/PccqytNgJk3fz/W+6iarE/EBYQnLEPO2PM+X4QMQx1KZEC2TbRjw5Zm4nB6Os
	ejk5w10BE5cYmlXfACmjrAqgKS5J4zh9XNZc+kaZJjo3XRV5Y8mIYW+Tw/s/XKG/CiRsftcc6xX
	kIchR7uqTosXYqDfjuM7QjhS/3HWzoEmTfhUgtwtlJlxklCE6Z6BkjVdWas2sY0JsdymG+zt7R3
	x4QpUliQ+pXcQ2R5hwqLbr9QFiDO667lFcwmhJxtrsEuBnztUp8p8tzAtZnmxL8+Jn2SBIMUUq7
	vX5cpiDcuIg/xGwJBoazg8w1XFBDxApBgj9dZ6W88GdA57O203kMJwqkjvt7jyNpkM+1ZNINRsb
	NHH56/nkZnNAlYzmMJQzZEBxo2WJ0r0ReSXpbCADfluMYEjTpbV5fp4=
X-Received: by 2002:a05:6820:807:b0:716:e9e0:5440 with SMTP id 006d021491bc7-71b47fe68b6mr11023985eaf.63.1795556946769;
        Tue, 24 Nov 2026 13:49:06 -0800 (PST)
Received: from [127.0.0.1] ([40.80.212.165])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38058102sm9783238eaf.6.2026.11.24.13.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:49:05 -0800 (PST)
Message-Id: <a50bc32d0bebc7d5f7a8969e412ebd9d197370b6.1795556940.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2324.git.1795556940.gitgitgadget@gmail.com>
References: <pull.2324.git.1795556940.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 21:48:59 +0000
Subject: [PATCH 3/4] doc: convert git-fast-import.adoc to synopsis style
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

 * convert synopsis section
 * convert options to `` style
 * convert _<placeholder>_ style

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/fastimport.adoc |   2 +-
 Documentation/git-fast-import.adoc   | 381 ++++++++++++++-------------
 2 files changed, 194 insertions(+), 189 deletions(-)

diff --git a/Documentation/config/fastimport.adoc b/Documentation/config/fastimport.adoc
index 903677d7ef..7b721fa0e9 100644
--- a/Documentation/config/fastimport.adoc
+++ b/Documentation/config/fastimport.adoc
@@ -1,4 +1,4 @@
-fastimport.unpackLimit::
+`fastimport.unpackLimit`::
 	If the number of objects imported by linkgit:git-fast-import[1]
 	is below this limit, then the objects will be unpacked into
 	loose object files.  However, if the number of imported objects
diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 5201e49334..9a3f83b2b9 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -8,15 +8,15 @@ git-fast-import - Backend for fast Git data importers
 
 SYNOPSIS
 --------
-[verse]
-'git fast-import' [<options>]
+[synopsis]
+git fast-import [<options>]
 
 DESCRIPTION
 -----------
 This program is usually not what the end user wants to run directly.
 Most end users want to use one of the existing frontend programs,
 which parses a specific type of foreign source and feeds the contents
-stored there to 'git fast-import'.
+stored there to `git fast-import`.
 
 fast-import reads a mixed command/data stream from standard input and
 writes one or more packfiles directly into the current repository.
@@ -25,7 +25,7 @@ updated branch and tag refs, fully updating the current repository
 with the newly imported data.
 
 The fast-import backend itself can import into an empty repository (one that
-has already been initialized by 'git init') or incrementally
+has already been initialized by `git init`) or incrementally
 update an existing populated repository.  Whether or not incremental
 imports are supported from a particular foreign source depends on
 the frontend program in use.
@@ -35,24 +35,24 @@ the frontend program in use.
 OPTIONS
 -------
 
---force::
+`--force`::
 	Force updating modified existing branches, even if doing
 	so would cause commits to be lost (as the new commit does
 	not contain the old commit).
 
---quiet::
-	Disable the output shown by --stats, making fast-import usually
+`--quiet`::
+	Disable the output shown by `--stats`, making fast-import usually
 	be silent when it is successful.  However, if the import stream
 	has directives intended to show user output (e.g. `progress`
 	directives), the corresponding messages will still be shown.
 
---stats::
+`--stats`::
 	Display some basic statistics about the objects fast-import has
 	created, the packfiles they were stored into, and the
 	memory used by fast-import during this run.  Showing this output
-	is currently the default, but can be disabled with --quiet.
+	is currently the default, but can be disabled with `--quiet`.
 
---allow-unsafe-features::
+`--allow-unsafe-features`::
 	Many command-line options can be provided as part of the
 	fast-import stream itself by using the `feature` or `option`
 	commands. However, some of these options are unsafe (e.g.,
@@ -85,43 +85,41 @@ already trusted to run their own code.
 	the default mode is `verbatim`.
 
 `--signed-commits=<mode>`::
-	Specify how to handle signed commits. The following <mode>s
+	Specify how to handle signed commits. The following _<mode>_s
 	are supported:
 +
-* `verbatim`, which is the default, will silently import commit
-  signatures.
-* `warn-verbatim` will import them, but will display a warning.
-* `abort` will make this program die when encountering a signed
-  commit.
-* `strip` will silently make the commits unsigned.
-* `warn-strip` will make them unsigned, but will display a warning.
-* `strip-if-invalid` will check signatures and, if they are invalid,
-  will strip them and display a warning. The validation is performed
-  in the same way as linkgit:git-verify-commit[1] does it.
-* `sign-if-invalid[=<keyid>]`, similar to `strip-if-invalid`, verifies
-  commit signatures and replaces invalid signatures with newly created ones.
-  Valid signatures are left unchanged. If `<keyid>` is provided, that key is
-  used for signing; otherwise the configured default signing key is used.
-* `abort-if-invalid` will make this program die when encountering a signed
-  commit that is unable to be verified.
+`verbatim`;; Silently import commit signatures. This is the default.
+`warn-verbatim`;; Import commit signatures, but display a warning.
+`abort`;; Die when encountering a signed commit.
+`strip`;; Silently make the commits unsigned.
+`warn-strip`;; Make the commits unsigned, but display a warning.
+`strip-if-invalid`;; Check signatures and, if they are invalid, strip them
+and display a warning. Perform the validation in the same way as
+linkgit:git-verify-commit[1].
+`sign-if-invalid[=<keyid>]`;; Verify commit signatures and replace invalid
+signatures with newly created ones. Leave valid signatures unchanged. If
+_<keyid>_ is provided, use that key for signing; otherwise use the configured
+default signing key.
+`abort-if-invalid`;; Die when encountering a signed commit that cannot be
+verified.
 
 Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~
 
---cat-blob-fd=<fd>::
+`--cat-blob-fd=<fd>`::
 	Write responses to `get-mark`, `cat-blob`, and `ls` queries to the
-	file descriptor <fd> instead of `stdout`.  Allows `progress`
+	file descriptor _<fd>_ instead of `stdout`.  Allows `progress`
 	output intended for the end-user to be separated from other
 	output.
 
---date-format=<fmt>::
+`--date-format=<fmt>`::
 	Specify the type of dates the frontend will supply to
 	fast-import within `author`, `committer` and `tagger` commands.
-	See ``Date Formats'' below for details about which formats
+	See the 'Date Formats' section below for details about which formats
 	are supported, and their syntax.
 
---done::
-	Terminate with error if there is no `done` command at the end of
+`--done`::
+	Terminate with an error if there is no `done` command at the end of
 	the stream.  This option might be useful for detecting errors
 	that cause the frontend to terminate before it has started to
 	write a stream.
@@ -129,52 +127,52 @@ Options for Frontends
 Locations of Marks Files
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
---export-marks=<file>::
-	Dumps the internal marks table to <file> when complete.
+`--export-marks=<file>`::
+	Dump the internal marks table to _<file>_ when complete.
 	Marks are written one per line as `:markid SHA-1`.
 	Frontends can use this file to validate imports after they
 	have been completed, or to save the marks table across
-	incremental runs.  As <file> is only opened and truncated
+	incremental runs.  As _<file>_ is only opened and truncated
 	at checkpoint (or completion) the same path can also be
-	safely given to --import-marks.
+	safely given to `--import-marks`.
 
---import-marks=<file>::
-	Before processing any input, load the marks specified in
-	<file>.  The input file must exist, must be readable, and
-	must use the same format as produced by --export-marks.
+`--import-marks=<file>`::
+	Load the marks specified in _<file>_ before processing any input.
+	The input file must exist, must be readable, and
+	must use the same format as produced by `--export-marks`.
 	Multiple options may be supplied to import more than one
 	set of marks.  If a mark is defined to different values,
 	the last file wins.
 
---import-marks-if-exists=<file>::
-	Like --import-marks but instead of erroring out, silently
+`--import-marks-if-exists=<file>`::
+	Load marks like `--import-marks` but, instead of erroring out, silently
 	skips the file if it does not exist.
 
---relative-marks::
---no-relative-marks::
-	After specifying --relative-marks the paths specified
-	with --import-marks= and --export-marks= are relative
+`--relative-marks`::
+`--no-relative-marks`::
+	Make the paths specified with `--import-marks=` and `--export-marks=` relative
 	to an internal directory in the current repository.
-	In git-fast-import this means that the paths are relative
-	to the .git/info/fast-import directory. However, other
+	In `git-fast-import` this means that the paths are relative
+	to the `.git/info/fast-import` directory. However, other
 	importers may use a different location.
 +
-Relative and non-relative marks may be combined by interweaving
---(no-)-relative-marks with the --(import|export)-marks= options.
+Combine relative and non-relative marks by interweaving
+`--(no-)-relative-marks` with the `--(import|export)-marks=` options.
 
 Submodule Rewriting
 ~~~~~~~~~~~~~~~~~~~
 
---rewrite-submodules-from=<name>:<file>::
---rewrite-submodules-to=<name>:<file>::
-  Rewrite the object IDs for the submodule specified by <name> from the values
-	used in the from <file> to those used in the to <file>. The from marks should
+
+`--rewrite-submodules-from=<name>:<file>`::
+`--rewrite-submodules-to=<name>:<file>`::
+	Rewrite the object IDs for the submodule specified by _<name>_ from the values
+	used in the from _<file>_ to those used in the to _<file>_. The from marks should
 	have been created by `git fast-export`, and the to marks should have been
 	created by `git fast-import` when importing that same submodule.
 +
-<name> may be any arbitrary string not containing a colon character, but the
+_<name>_ may be any arbitrary string not containing a colon character, but the
 same value must be used with both options when specifying corresponding marks.
-Multiple submodules may be specified with different values for <name>. It is an
+Multiple submodules may be specified with different values for _<name>_. It is an
 error not to use these options in corresponding pairs.
 +
 These options are primarily useful when converting a repository from one hash
@@ -185,34 +183,34 @@ algorithm.
 Performance and Compression Tuning
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
---active-branches=<n>::
-	Maximum number of branches to maintain active at once.
-	See ``Memory Utilization'' below for details.  Default is 5.
+`--active-branches=<n>`::
+	Maintain at most _<n>_ branches as active at once.
+	See the 'Memory Utilization' section below for details.  The default is 5.
 
---big-file-threshold=<n>::
-	Maximum size of a blob that fast-import will attempt to
+`--big-file-threshold=<n>`::
+	Set the maximum size of a blob that fast-import will attempt to
 	create a delta for, expressed in bytes.  The default is 512m
 	(512 MiB).  Some importers may wish to lower this on systems
 	with constrained memory.
 
---depth=<n>::
-	Maximum delta depth, for blob and tree deltification.
+`--depth=<n>`::
+	Set the maximum delta depth for blob and tree deltification.
 	Default is 50.
 
---export-pack-edges=<file>::
-	After creating a packfile, print a line of data to
-	<file> listing the filename of the packfile and the last
+`--export-pack-edges=<file>`::
+	Print a line of data to
+	_<file>_ listing the filename of the packfile and the last
 	commit on each branch that was written to that packfile.
 	This information may be useful after importing projects
 	whose total object set exceeds the 4 GiB packfile limit,
 	as these commits can be used as edge points during calls
-	to 'git pack-objects'.
+	to `git pack-objects`.
 
---max-pack-size=<n>::
-	Maximum size of each output packfile.
+`--max-pack-size=<n>`::
+	Set the maximum size of each output packfile.
 	The default is unlimited.
 
-fastimport.unpackLimit::
+`fastimport.unpackLimit`::
 	See linkgit:git-config[1]
 
 PERFORMANCE
@@ -243,9 +241,9 @@ an ideal situation, given that most conversion tools are throw-away
 
 PARALLEL OPERATION
 ------------------
-Like 'git push' or 'git fetch', imports handled by fast-import are safe to
+Like `git push` or `git fetch`, imports handled by fast-import are safe to
 run alongside parallel `git repack -a -d` or `git gc` invocations,
-or any other Git operation (including 'git prune', as loose objects
+or any other Git operation (including `git prune`, as loose objects
 are never used by fast-import).
 
 fast-import does not lock the branch or tag refs it is actively importing.
@@ -257,8 +255,8 @@ fast-forward update, fast-import will skip updating that ref and instead
 prints a warning message.  fast-import will always attempt to update all
 branch refs, and does not stop on the first failure.
 
-Branch updates can be forced with --force, but it's recommended that
-this only be used on an otherwise quiet repository.  Using --force
+Branch updates can be forced with `--force`, but it's recommended that
+this only be used on an otherwise quiet repository.  Using `--force`
 is not necessary for an initial import into an empty repository.
 
 
@@ -309,11 +307,11 @@ Date Formats
 ~~~~~~~~~~~~
 The following date formats are supported.  A frontend should select
 the format it will use for this import by passing the format name
-in the --date-format=<fmt> command-line option.
+in the `--date-format=<fmt>` command-line option.
 
 `raw`::
 	This is the Git native format and is `<time> SP <offutc>`.
-	It is also fast-import's default format, if --date-format was
+	It is also fast-import's default format, if `--date-format` was
 	not specified.
 +
 The time of the event is specified by `<time>` as the number of
@@ -322,12 +320,12 @@ written as an ASCII decimal integer.
 +
 The local offset is specified by `<offutc>` as a positive or negative
 offset from UTC.  For example EST (which is 5 hours behind UTC)
-would be expressed in `<tz>` by ``-0500'' while UTC is ``+0000''.
+would be expressed in `<tz>` by `-0500` while UTC is `+0000`.
 The local offset does not affect `<time>`; it is used only as an
 advisement to help formatting routines display the timestamp.
 +
 If the local offset is not available in the source material, use
-``+0000'', or the most common local offset.  For example many
+`+0000`, or the most common local offset.  For example many
 organizations have a CVS repository which has only ever been accessed
 by users who are located in the same location and time zone.  In this
 case a reasonable offset from UTC could be assumed.
@@ -345,9 +343,9 @@ and some sanity checks on the numeric values may also be performed.
 `rfc2822`::
 	This is the standard date format as described by RFC 2822.
 +
-An example value is ``Tue Feb 6 11:22:18 2007 -0500''.  The Git
+An example value is `Tue Feb 6 11:22:18 2007 -0500`.  The Git
 parser is accurate, but a little on the lenient side.  It is the
-same parser used by 'git am' when applying patches
+same parser used by `git am` when applying patches
 received from email.
 +
 Some malformed strings may be accepted as valid dates.  In some of
@@ -383,7 +381,7 @@ time zone.
 This particular format is supplied as it's short to implement and
 may be useful to a process that wants to create a new commit
 right now, without needing to use a working directory or
-'git update-index'.
+`git update-index`.
 +
 If separate `author` and `committer` commands are used in a `commit`
 the timestamps may not match, as the system clock will be polled
@@ -421,7 +419,7 @@ and control the current import process.  More detailed discussion
 
 `alias`::
 	Record that a mark refers to a given object without first
-	creating any new object.  Using --import-marks and referring
+	creating any new object.  Using `--import-marks` and referring
 	to missing marks will cause fast-import to fail, so aliases
 	can provide a way to set otherwise pruned commits to a valid
 	value (e.g. the nearest non-pruned ancestor).
@@ -448,13 +446,13 @@ and control the current import process.  More detailed discussion
 	unspecified.
 
 `cat-blob`::
-	Causes fast-import to print a blob in 'cat-file --batch'
+	Print a blob in `git cat-file --batch`
 	format to the file descriptor set with `--cat-blob-fd` or
 	`stdout` if unspecified.
 
 `ls`::
-	Causes fast-import to print a line describing a directory
-	entry in 'ls-tree' format to the file descriptor set with
+	Print a line describing a directory
+	entry in `git ls-tree` format to the file descriptor set with
 	`--cat-blob-fd` or `stdout` if unspecified.
 
 `feature`::
@@ -472,13 +470,14 @@ Create or update a branch with a new commit, recording one logical
 change to the project.
 
 ////
-Yes, it's intentional that the 'gpgsig' line doesn't have a trailing
+Yes, it's intentional that the `gpgsig` line doesn't have a trailing
 `LF`; the definition of `data` has a byte-count prefix, so it
 doesn't need an `LF` to act as a terminator (and `data` also already
 includes an optional trailing `LF?` just in case you want to include
 one).
 ////
 
+
 ....
 	'commit' SP <ref> LF
 	mark?
@@ -494,11 +493,11 @@ one).
 	LF?
 ....
 
-where `<ref>` is the name of the branch to make the commit on.
+where _<ref>_ is the name of the branch to make the commit on.
 Typically branch names are prefixed with `refs/heads/` in
 Git, so importing the CVS branch symbol `RELENG-1_0` would use
-`refs/heads/RELENG-1_0` for the value of `<ref>`.  The value of
-`<ref>` must be a valid refname in Git.  As `LF` is not valid in
+`refs/heads/RELENG-1_0` for the value of _<ref>_.  The value of
+_<ref>_ must be a valid refname in Git.  As `LF` is not valid in
 a Git refname, no quoting or escaping syntax is supported here.
 
 A `mark` command may optionally appear, requesting fast-import to save a
@@ -541,17 +540,17 @@ the fields in `author`, as they are identical to `committer`.
 The `committer` command indicates who made this commit, and when
 they made it.
 
-Here `<name>` is the person's display name (for example
-``Com M Itter'') and `<email>` is the person's email address
-(``\cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
+Here _<name>_ is the person's display name (for example
+`Com M Itter`) and _<email>_ is the person's email address
+(`\cm@example.com`).  `LT` and `GT` are the literal less-than (\x3c)
 and greater-than (\x3e) symbols.  These are required to delimit
 the email address from the other fields in the line.  Note that
-`<name>` and `<email>` are free-form and may contain any sequence
-of bytes, except `LT`, `GT` and `LF`.  `<name>` is typically UTF-8 encoded.
+_<name>_ and _<email>_ are free-form and may contain any sequence
+of bytes, except `LT`, `GT` and `LF`.  _<name>_ is typically UTF-8 encoded.
 
-The time of the change is specified by `<when>` using the date format
-that was selected by the --date-format=<fmt> command-line option.
-See ``Date Formats'' above for the set of supported formats, and
+The time of the change is specified by _<when>_ using the date format
+that was selected by the `--date-format=<fmt>` command-line option.
+See the 'Date Formats' section above for the set of supported formats, and
 their syntax.
 
 `gpgsig`
@@ -617,9 +616,9 @@ as the current commit on that branch is automatically assumed to
 be the first ancestor of the new commit.
 
 As `LF` is not valid in a Git refname or SHA-1 expression, no
-quoting or escaping syntax is supported within `<commit-ish>`.
+quoting or escaping syntax is supported within _<commit-ish>_.
 
-Here `<commit-ish>` is any of the following:
+Here _<commit-ish>_ is any of the following:
 
 * The name of an existing branch already in fast-import's internal branch
   table.  If fast-import doesn't know the name, it's treated as a SHA-1
@@ -638,7 +637,7 @@ Marks must be declared (via `mark`) before they can be used.
 * A complete 40 byte or abbreviated commit SHA-1 in hex.
 
 * Any valid Git SHA-1 expression that resolves to a commit.  See
-  ``SPECIFYING REVISIONS'' in linkgit:gitrevisions[7] for details.
+  'SPECIFYING REVISIONS' in linkgit:gitrevisions[7] for details.
 
 * The special null SHA-1 (40 zeros) specifies that the branch is to be
   removed.
@@ -667,7 +666,7 @@ the first ancestor of the current commit, and the branch will start
 out with no files.  An unlimited number of `merge` commands per
 commit are permitted by fast-import, thereby establishing an n-way merge.
 
-Here `<commit-ish>` is any of the commit specification expressions
+Here _<commit-ish>_ is any of the commit specification expressions
 also accepted by `from` (see above).
 
 `filemodify`
@@ -684,10 +683,10 @@ External data format::
 	'M' SP <mode> SP <dataref> SP <path> LF
 ....
 +
-Here usually `<dataref>` must be either a mark reference (`:<idnum>`)
+Here usually _<dataref>_ must be either a mark reference (`:<idnum>`)
 set by a prior `blob` command, or a full 40-byte SHA-1 of an
-existing Git blob object.  If `<mode>` is `040000` then
-`<dataref>` must be the full 40-byte SHA-1 of an existing
+existing Git blob object.  If _<mode>_ is `040000` then
+_<dataref>_ must be the full 40-byte SHA-1 of an existing
 Git tree object or a mark reference set with `--import-marks`.
 
 Inline data format::
@@ -702,7 +701,7 @@ Inline data format::
 +
 See below for a detailed description of the `data` command.
 
-In both formats `<mode>` is the type of file entry, specified
+In both formats _<mode>_ is the type of file entry, specified
 in octal.  Git only supports the following modes:
 
 * `100644` or `644`: A normal (not-executable) file.  The majority
@@ -716,19 +715,19 @@ in octal.  Git only supports the following modes:
 * `040000`: A subdirectory.  Subdirectories can only be specified by
   SHA or through a tree mark set with `--import-marks`.
 
-In both formats `<path>` is the complete path of the file to be added
+In both formats _<path>_ is the complete path of the file to be added
 (if not already existing) or modified (if already existing).
 
-A `<path>` can be written as unquoted bytes or a C-style quoted string.
+A _<path>_ can be written as unquoted bytes or a C-style quoted string.
 
-When a `<path>` does not start with a double quote (`"`), it is an
+When a _<path>_ does not start with a double quote (`"`), it is an
 unquoted string and is parsed as literal bytes without any escape
 sequences. However, if the filename contains `LF` or starts with double
 quote, it cannot be represented as an unquoted string and must be
-quoted. Additionally, the source `<path>` in `filecopy` or `filerename`
+quoted. Additionally, the source _<path>_ in `filecopy` or `filerename`
 must be quoted if it contains SP.
 
-When a `<path>` starts with a double quote (`"`), it is a C-style quoted
+When a _<path>_ starts with a double quote (`"`), it is a C-style quoted
 string, where the complete filename is enclosed in a pair of double
 quotes and escape sequences are used. Certain characters must be escaped
 by preceding them with a backslash: `LF` is written as `\n`, backslash
@@ -739,7 +738,7 @@ horizontal tab, and `\v` for vertical tab. Any byte can be written with
 3-digit octal codes (e.g., `\033`). All filenames can be represented as
 quoted strings.
 
-A `<path>` must use UNIX-style directory separators (forward slash `/`)
+A _<path>_ must use UNIX-style directory separators (forward slash `/`)
 and its value must be in canonical form. That is it must not:
 
 * contain an empty directory component (e.g. `foo//bar` is invalid),
@@ -748,10 +747,10 @@ and its value must be in canonical form. That is it must not:
 * contain the special component `.` or `..` (e.g. `foo/./bar` and
   `foo/../bar` are invalid).
 
-The root of the tree can be represented by an empty string as `<path>`.
+The root of the tree can be represented by an empty string as _<path>_.
 
-`<path>` cannot contain NUL, either literally or escaped as `\000`.
-It is recommended that `<path>` always be encoded using UTF-8.
+_<path>_ cannot contain NUL, either literally or escaped as `\000`.
+It is recommended that _<path>_ always be encoded using UTF-8.
 
 `filedelete`
 ^^^^^^^^^^^^
@@ -765,9 +764,9 @@ first non-empty directory or the root is reached.
 	'D' SP <path> LF
 ....
 
-here `<path>` is the complete path of the file or subdirectory to
+here _<path>_ is the complete path of the file or subdirectory to
 be removed from the branch.
-See `filemodify` above for a detailed description of `<path>`.
+See `filemodify` above for a detailed description of _<path>_.
 
 `filecopy`
 ^^^^^^^^^^
@@ -780,9 +779,9 @@ by the content copied from the source.
 	'C' SP <path> SP <path> LF
 ....
 
-here the first `<path>` is the source location and the second
-`<path>` is the destination.  See `filemodify` above for a detailed
-description of what `<path>` may look like.  To use a source path
+here the first _<path>_ is the source location and the second
+_<path>_ is the destination.  See `filemodify` above for a detailed
+description of what _<path>_ may look like.  To use a source path
 that contains SP the path must be quoted.
 
 A `filecopy` command takes effect immediately.  Once the source
@@ -800,9 +799,9 @@ the destination exists it will be replaced by the source directory.
 	'R' SP <path> SP <path> LF
 ....
 
-here the first `<path>` is the source location and the second
-`<path>` is the destination.  See `filemodify` above for a detailed
-description of what `<path>` may look like.  To use a source path
+here the first _<path>_ is the source location and the second
+_<path>_ is the destination.  See `filemodify` above for a detailed
+description of what _<path>_ may look like.  To use a source path
 that contains SP the path must be quoted.
 
 A `filerename` command takes effect immediately.  Once the source
@@ -845,11 +844,11 @@ paths for a commit are encouraged to do so.
 
 `notemodify`
 ^^^^^^^^^^^^
-Included in a `commit` `<notes-ref>` command to add a new note
-annotating a `<commit-ish>` or change this annotation contents.
-Internally it is similar to filemodify 100644 on `<commit-ish>`
+Included in a `commit` _<notes-ref>_ command to add a new note
+annotating a _<commit-ish>_ or change this annotation contents.
+Internally it is similar to filemodify 100644 on _<commit-ish>_
 path (maybe split into subdirectories). It's not advised to
-use any other commands to write to the `<notes-ref>` tree except
+use any other commands to write to the _<notes-ref>_ tree except
 `filedeleteall` to delete all existing notes in this tree.
 This command has two different means of specifying the content
 of the note.
@@ -863,7 +862,7 @@ External data format::
 	'N' SP <dataref> SP <commit-ish> LF
 ....
 +
-Here `<dataref>` can be either a mark reference (`:<idnum>`)
+Here _<dataref>_ can be either a mark reference (`:<idnum>`)
 set by a prior `blob` command, or a full 40-byte SHA-1 of an
 existing Git blob object.
 
@@ -879,7 +878,7 @@ Inline data format::
 +
 See below for a detailed description of the `data` command.
 
-In both formats `<commit-ish>` is any of the commit specification
+In both formats _<commit-ish>_ is any of the commit specification
 expressions also accepted by `from` (see above).
 
 `mark`
@@ -921,6 +920,7 @@ where `<object-identifier>` is any string not containing LF.
 Creates an annotated tag referring to a specific commit.  To create
 lightweight (non-annotated) tags see the `reset` command below.
 
+
 ....
 	'tag' SP <name> LF
 	mark?
@@ -930,14 +930,14 @@ lightweight (non-annotated) tags see the `reset` command below.
 	data
 ....
 
-where `<name>` is the name of the tag to create.
+where _<name>_ is the name of the tag to create.
 
 Tag names are automatically prefixed with `refs/tags/` when stored
 in Git, so importing the CVS branch symbol `RELENG-1_0-FINAL` would
-use just `RELENG-1_0-FINAL` for `<name>`, and fast-import will write the
+use just `RELENG-1_0-FINAL` for _<name>_, and fast-import will write the
 corresponding ref as `refs/tags/RELENG-1_0-FINAL`.
 
-The value of `<name>` must be a valid refname in Git and therefore
+The value of _<name>_ must be a valid refname in Git and therefore
 may contain forward slashes.  As `LF` is not valid in a Git refname,
 no quoting or escaping syntax is supported here.
 
@@ -959,7 +959,7 @@ recommended, as the frontend does not (easily) have access to the
 complete set of bytes which normally goes into such a signature.
 If signing is required, create lightweight tags from within fast-import with
 `reset`, then create the annotated versions of those tags offline
-with the standard 'git tag' process.
+with the standard `git tag` process.
 
 `reset`
 ~~~~~~~
@@ -974,7 +974,7 @@ branch from an existing commit without creating a new commit.
 	LF?
 ....
 
-For a detailed description of `<ref>` and `<commit-ish>` see above
+For a detailed description of _<ref>_ and _<commit-ish>_, see above
 under `commit` and `from`.
 
 The `LF` after the command is optional (it used to be required).
@@ -1018,7 +1018,7 @@ intended for production-quality conversions should always use the
 exact byte count format, as it is more robust and performs better.
 The delimited format is intended primarily for testing fast-import.
 
-Comment lines appearing within the `<raw>` part of `data` commands
+Comment lines appearing within the _<raw>_ part of `data` commands
 are always taken to be part of the body of the data and are therefore
 never ignored by fast-import.  This makes it safe to import any
 file/message content whose lines might start with `#`.
@@ -1031,15 +1031,15 @@ Exact byte count format::
 	<raw> LF?
 ....
 +
-where `<count>` is the exact number of bytes appearing within
-`<raw>`.  The value of `<count>` is expressed as an ASCII decimal
-integer.  The `LF` on either side of `<raw>` is not
+where _<count>_ is the exact number of bytes appearing within
+_<raw>_.  The value of _<count>_ is expressed as an ASCII decimal
+integer.  The `LF` on either side of _<raw>_ is not
 included in `<count>` and will not be included in the imported data.
 +
-The `LF` after `<raw>` is optional (it used to be required) but
+The `LF` after _<raw>_ is optional (it used to be required) but
 recommended.  Always including it makes debugging a fast-import
 stream easier as the next command always starts in column 0
-of the next line, even if `<raw>` did not end with an `LF`.
+of the next line, even if _<raw>_ did not end with an `LF`.
 
 Delimited format::
 	A delimiter string is used to mark the end of the data.
@@ -1054,14 +1054,14 @@ Delimited format::
 	LF?
 ....
 +
-where `<delim>` is the chosen delimiter string.  The string `<delim>`
-must not appear on a line by itself within `<raw>`, as otherwise
+where _<delim>_ is the chosen delimiter string.  The string _<delim>_
+must not appear on a line by itself within _<raw>_, as otherwise
 fast-import will think the data ends earlier than it really does.  The `LF`
-immediately trailing `<raw>` is part of `<raw>`.  This is one of
+immediately trailing _<raw>_ is part of _<raw>_.  This is one of
 the limitations of the delimited format, it is impossible to supply
 a data chunk which does not have an LF as its last byte.
 +
-The `LF` after `<delim> LF` is optional (it used to be required).
+The `LF` after _<delim>_ `LF` is optional (it used to be required).
 
 `alias`
 ~~~~~~~
@@ -1075,7 +1075,7 @@ new object.
 	LF?
 ....
 
-For a detailed description of `<commit-ish>` see above under `from`.
+For a detailed description of _<commit-ish>_, see above under `from`.
 
 
 `checkpoint`
@@ -1089,7 +1089,7 @@ save out all current branch refs, tags and marks.
 ....
 
 Note that fast-import automatically switches packfiles when the current
-packfile reaches --max-pack-size, or 4 GiB, whichever limit is
+packfile reaches `--max-pack-size`, or 4 GiB, whichever limit is
 smaller.  During an automatic packfile switch fast-import does not update
 the branch refs, tags or marks.
 
@@ -1118,7 +1118,7 @@ on the current import, or on any of fast-import's internal state.
 	LF?
 ....
 
-The `<any>` part of the command may contain any sequence of bytes
+The _<any>_ part of the command may contain any sequence of bytes
 that does not contain `LF`.  The `LF` after the command is optional.
 Callers may wish to process the output through a tool such as sed to
 remove the leading part of the line, for example:
@@ -1158,7 +1158,7 @@ accessible from the target repository.
 	'cat-blob' SP <dataref> LF
 ....
 
-The `<dataref>` can be either a mark reference (`:<idnum>`)
+The _<dataref>_ can be either a mark reference (`:<idnum>`)
 set previously or a full 40-byte SHA-1 of a Git blob, preexisting or
 ready to be written.
 
@@ -1198,17 +1198,17 @@ Reading from the active commit::
 ....
 
 Reading from a named tree::
-	The `<dataref>` can be a mark reference (`:<idnum>`) or the
+	The _<dataref>_ can be a mark reference (`:<idnum>`) or the
 	full 40-byte SHA-1 of a Git tag, commit, or tree object,
 	preexisting or waiting to be written.
 	The path is relative to the top level of the tree
-	named by `<dataref>`.
+	named by _<dataref>_.
 +
 ....
 	'ls' SP <dataref> SP <path> LF
 ....
 
-See `filemodify` above for a detailed description of `<path>`.
+See `filemodify` above for a detailed description of _<path>_.
 
 Output uses the same format as `git ls-tree <tree> -- <path>`:
 
@@ -1216,11 +1216,11 @@ Output uses the same format as `git ls-tree <tree> -- <path>`:
 	<mode> SP ('blob' | 'tree' | 'commit') SP <dataref> HT <path> LF
 ====
 
-The <dataref> represents the blob, tree, or commit object at <path>
-and can be used in later 'get-mark', 'cat-blob', 'filemodify', or
-'ls' commands.
+The _<dataref>_ represents the blob, tree, or commit object at _<path>_
+and can be used in later `get-mark`, `cat-blob`, `filemodify`, or
+`ls` commands.
 
-If there is no file or subtree at that path, 'git fast-import' will
+If there is no file or subtree at that path, `git fast-import` will
 instead report
 
 ====
@@ -1239,46 +1239,51 @@ it does not.
 	'feature' SP <feature> ('=' <argument>)? LF
 ....
 
-The <feature> part of the command may be any one of the following:
+The _<feature>_ part of the command may be any one of the following:
 
-date-format::
-export-marks::
-relative-marks::
-no-relative-marks::
-force::
+
+`date-format`::
+`export-marks`::
+`relative-marks`::
+`no-relative-marks`::
+`force`::
 	Act as though the corresponding command-line option with
 	a leading `--` was passed on the command line
 	(see <<OPTIONS,OPTIONS>>, above).
 
-import-marks::
-import-marks-if-exists::
-	Like --import-marks except in two respects: first, only one
-	"feature import-marks" or "feature import-marks-if-exists"
+
+`import-marks`::
+`import-marks-if-exists`::
+	Use the corresponding marks option with two differences: first, only one
+  `feature import-marks` or `feature import-marks-if-exists`
 	command is allowed per stream; second, an --import-marks=
-	or --import-marks-if-exists command-line option overrides
-	any of these "feature" commands in the stream; third,
-	"feature import-marks-if-exists" like a corresponding
+  or the `--import-marks-if-exists` command-line option overrides
+  any of these `feature` commands in the stream; third,
+  `feature import-marks-if-exists` like a corresponding
 	command-line option silently skips a nonexistent file.
 
-get-mark::
-cat-blob::
-ls::
-	Require that the backend support the 'get-mark', 'cat-blob',
-	or 'ls' command respectively.
+
+`get-mark`::
+`cat-blob`::
+`ls`::
+	Require that the backend support the `get-mark`, `cat-blob`,
+	or `ls` command respectively.
 	Versions of fast-import not supporting the specified command
 	will exit with a message indicating so.
 	This lets the import error out early with a clear message,
 	rather than wasting time on the early part of an import
 	before the unsupported command is detected.
 
-notes::
-	Require that the backend support the 'notemodify' (N)
-	subcommand to the 'commit' command.
+
+`notes`::
+	Require that the backend support the `notemodify` (`N`)
+	subcommand to the `commit` command.
 	Versions of fast-import not supporting notes will exit
 	with a message indicating so.
 
-done::
-	Error out if the stream ends without a 'done' command.
+
+`done`::
+	Error out if the stream ends without a `done` command.
 	Without this feature, errors causing the frontend to end
 	abruptly at a convenient point in the stream can go
 	undetected.  This may occur, for example, if an import
@@ -1296,7 +1301,7 @@ options the user may specify to git fast-import itself.
     'option' SP <option> LF
 ....
 
-The `<option>` part of the command may contain any of the options
+The _<option>_ part of the command may contain any of the options
 listed in the <<OPTIONS,OPTIONS>> section that do not change import semantics,
 without the leading `--` and is treated in the same way.
 
@@ -1446,7 +1451,7 @@ users of fast-import, and are offered here as suggestions.
 Use One Mark Per Commit
 ~~~~~~~~~~~~~~~~~~~~~~~
 When doing a repository conversion, use a unique mark per commit
-(`mark :<n>`) and supply the --export-marks option on the command
+(`mark :<n>`) and supply the `--export-marks` option on the command
 line.  fast-import will dump a file which lists every mark and the Git
 object SHA-1 that corresponds to it.  If the frontend can tie
 the marks back to the source repository, it is easy to verify the
@@ -1496,7 +1501,7 @@ is not `refs/heads/TAG_FIXUP`).
 
 When committing fixups, consider using `merge` to connect the
 commit(s) which are supplying file revisions to the fixup branch.
-Doing so will allow tools such as 'git blame' to track
+Doing so will allow tools such as `git blame` to track
 through the real commit history and properly annotate the source
 files.
 
@@ -1511,7 +1516,7 @@ even for considerably large projects (100,000+ commits).
 
 However repacking the repository is necessary to improve data
 locality and access performance.  It can also take hours on extremely
-large projects (especially if -f and a large --window parameter is
+large projects (especially if `-f` and a large `--window` parameter is
 used).  Since repacking is safe to run alongside readers and writers,
 run the repack in the background and let it finish when it finishes.
 There is no reason to wait to explore your new Git project!
@@ -1525,7 +1530,7 @@ Repacking Historical Data
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 If you are repacking very old imported data (e.g. older than the
 last year), consider expending some extra CPU time and supplying
---window=50 (or higher) when you run 'git repack'.
+`--window=50` (or higher) when you run `git repack`.
 This will take longer, but will also produce a smaller packfile.
 You only need to expend the effort once, and everyone using your
 project will benefit from the smaller repository.
@@ -1570,8 +1575,8 @@ deltas are suboptimal (see above) then also adding the `-f` option
 to force recomputation of all deltas can significantly reduce the
 final packfile size (30-50% smaller can be quite typical).
 
-Instead of running `git repack` you can also run `git gc
---aggressive`, which will also optimize other things after an import
+Instead of running `git repack` you can also run `git gc --aggressive`,
+which will also optimize other things after an import
 (e.g. pack loose refs). As noted in the "AGGRESSIVE" section in
 linkgit:git-gc[1] the `--aggressive` option will find new deltas with
 the `-f` option to linkgit:git-repack[1]. For the reasons elaborated
@@ -1634,7 +1639,7 @@ branch, their in-memory storage size can grow to a considerable size
 fast-import automatically moves active branches to inactive status based on
 a simple least-recently-used algorithm.  The LRU chain is updated on
 each `commit` command.  The maximum number of active branches can be
-increased or decreased on the command line with --active-branches=.
+increased or decreased on the command line with `--active-branches=`.
 
 per active tree
 ~~~~~~~~~~~~~~~
@@ -1648,7 +1653,7 @@ per active file entry
 Files (and pointers to subtrees) within active trees require 52 or 64
 bytes (32/64 bit platforms) per entry.  To conserve space, file and
 tree names are pooled in a common string table, allowing the filename
-``Makefile'' to use just 16 bytes (after including the string header
+`Makefile` to use just 16 bytes (after including the string header
 overhead) no matter how many times it occurs within the project.
 
 The active branch LRU, when coupled with the filename string pool
@@ -1658,7 +1663,7 @@ memory footprint (less than 2.7 MiB per active branch).
 
 SIGNALS
 -------
-Sending *SIGUSR1* to the 'git fast-import' process ends the current
+Sending `SIGUSR1` to the `git fast-import` process ends the current
 packfile early, simulating a `checkpoint` command.  The impatient
 operator can use this facility to peek at the objects and refs from an
 import in progress, at the cost of some added running time and worse
-- 
gitgitgadget

