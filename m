Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556949;
	b=PwrAbzbgooNa1V6Hn5pyrkWy88vCYU+8gtYohr3+jGWDGyhFCeUV71TxtnzfuiKBik/z
	 b9i7Ls5SUx3uhlnRG5mcDh16Qbaaf+sfNvS0gZrbudK0Yu9cbR0anhQaFXCn4iBJ4MvMv
	 ALcrX+l3uQuq9L7PoXQ/CeBrVhSNhLNZzyXRL/ySYJzCyic59xOW5ftz7m4Qv3269poGE
	 icoZOSqnm3sxTdHpMn/W84x6ZxeLPw4eOTSk0TW7siRHzWTn/a7gwl1JTd1Z8r4yxfWX1
	 Sg9ANmpq6cl3yh0AHV3lti8E3CzzuqVPo01lbCFiwfyLTR2MhyGWt4DmwM2uL72C1FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Fcc:To:Cc;
	bh=DtLqITN4I2IObFsQsVch/RlaZS3nW2fgy3dT5qo1Okg=;
	b=MhGJS1Cm5iD3wohIZE7QJLqlkpxPoOZiFryg4b4zvoDzCnL8OnN5CGnEnNE5zORg4Vdy
	 YCCEKaQquiPFDBAY1QFoVjVK7/K4BMrH5yQIoIVQ2n2sNrBgfif4TDzESteSjMSw6s++u
	 R/k44Lft2ihv+fKguaKwFSzBCk+oNaunAerUh9re8fk893j8Dk417xlst+Am+DI7ywG2a
	 S8kf9b5a/ItM78mxu4GaIaxqPeiP26n68v071vkeTKd6j+mFG1OYBZH+Lh9XfwE7jRPtI
	 pXVmCqJWkTXA7ThRb+f26dtko8j43ZPkcydgulf9/GNB32e1fNAA9d7npDWzXuNSeag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="V/cHX4G7";
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B1E606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 21:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17B1E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V/cHX4G7
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-862df509d48so3953695a34.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 13:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556948; x=1796161748; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DtLqITN4I2IObFsQsVch/RlaZS3nW2fgy3dT5qo1Okg=;
        b=V/cHX4G7m8sX9eTmKvWwn5FYiMEk6OsyGxI4zXKsXMXCaHKwwalqZHN5Xy1Q5qPP2e
         p2NQd8/bZAiyfz2kTGDgSNXpnMLIZp4ffsauETdyJG3ul+XYYAwp+22DR2dIRA1R+xCZ
         fVUsLkNVc+M7mOVqK2e0eJWaXCOiWIhRlviYrnpjV10kyehgocZEZKTc3KAxfEq4+ZTz
         Ndh/TQn4F4mhNOqBnV4ftR78Y4xxeqB6ZKNH66zhqj/T+2RpvAKXJ8gQDnqg29Pw+y0S
         a+Yriv/cgD2xOZoymRZDL/KSprFmc+A5YXxsx67ApQpRYPlK4N8wL43ye1WWt7hUBjSq
         OwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556948; x=1796161748;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DtLqITN4I2IObFsQsVch/RlaZS3nW2fgy3dT5qo1Okg=;
        b=e7BsJ7mwC29a3QD3PXnOFTs3wSyALYVrljswPJGhpM0EZilfn4oyG1cMT3AOREs/v9
         0zHMXq+CYGF3wvwohsOJtgXRuFaEcN/c6GvJylsLqCueCoFE22gvoHdp6uew/6j/cExY
         2Z5T/2IklDvbIBfjTIMviGCkTYupNOISXMmjKCG2HUVRaropymEA3+X/t693RFZlmFDb
         fZ/7q1AFVhvgObapTqQqGree2qojaITaWntrjWlddU4vrTKPVUiJpvLsJzDrLsWdtnZY
         AooFfcgymdP7RQwcY9bfuSun27niZdFj7mrDC9Mqn/A2+tRZ68MxBtAwZBK9jauPlbsZ
         n0Jw==
X-Gm-Message-State: APuU4Z+oIrFoyQDHM/SRbs0kK+VHxkgF+2hHLVLHL572XHI8kqKqC/Pz
	kymdxgvOfZoLEgP5x7ltM4XyZXR/EqdV+DQoeKaH2YUeJQpx2Q8+f0w0kPSugQ==
X-Gm-Gg: AZFdTZeDKcbFP3I6kUxj/wZEuzQ/mduD6H5oD5/++B6E7cUHeFxqqIACdGvjJ0vC6WH
	C81sTEGrz5C3M6uz2TdL2De3fMPmaTB2xf9P+yI8wb6maHV40GQ9ru0sZV9SGE+DV6K7VterZMR
	uMA7aukfRKKPzXqD1XjXPqurV4PTtFlPiUJgxi5YiUK6AZdoWzxYpkcGBFhO/PFcDBgJFHVd0YI
	SujUqV3lKELUwSmI0w/6l2iFqCffQC2UieS2Fvz47Z0r/98yfDn0ixX9Km2ti0yCr7Lvt6yV3DR
	P6g38PXn57KE2I3+IIP1zXbUDj5LkO+GGT1cuZ/i3CfFtDpgE3r3YO4KLFfXuRZtRXgrftp5NmX
	TLE2vItZjuZZ7Cirk5tS7G4WfCtCEUy6wQEKh56moNHjlqSW/nBZ8qHHtUSJOl8SCCOV4uN6YiX
	Bm3lRjHTNflbH+e9Lg7dPWNKCd0NLLMhNYiLpfixKkNrkWaWZ64kCXhbuJGL5guLlGHX9zTxUiM
	+R51t7LFwuIeuV5/1KZivxmf5Cpazq/goiAKD779A1l8BjsgiT37VHT8YBSuuYFTyaSqSFEVz0X
	MzR2lj5/t8To+RMQbd8AfvK5V73xqaYJ9DWoGud9YUtmAfrPUAs3Aw==
X-Received: by 2002:a05:6830:4118:b0:862:b2eb:c6a2 with SMTP id 46e09a7af769-863090653a5mr13854787a34.5.1795556947835;
        Tue, 24 Nov 2026 13:49:07 -0800 (PST)
Received: from [127.0.0.1] ([40.80.212.165])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631690fd36sm11682118a34.20.2026.11.24.13.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:49:07 -0800 (PST)
Message-Id: <814dfdddf691445cc2d982854cd4e7ddcfbd8875.1795556940.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2324.git.1795556940.gitgitgadget@gmail.com>
References: <pull.2324.git.1795556940.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 21:49:00 +0000
Subject: [PATCH 4/4] doc: convert git-fast-export.adoc to synopsis style
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
 * convert inline list of values to sub definition lists

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-fast-export.adoc | 193 +++++++++++++++--------------
 1 file changed, 98 insertions(+), 95 deletions(-)

diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
index 0c2ce385c4..76b9b807d1 100644
--- a/Documentation/git-fast-export.adoc
+++ b/Documentation/git-fast-export.adoc
@@ -8,55 +8,57 @@ git-fast-export - Git data exporter
 
 SYNOPSIS
 --------
-[verse]
-'git fast-export' [<options>] [<revision-range>] [[--] <path>...]
+[synopsis]
+git fast-export [<options>] [<revision-range>] [[--] <path>...]
 
 DESCRIPTION
 -----------
 This program dumps the given revisions in a form suitable to be piped
-into 'git fast-import'.
+into `git fast-import`.
 
 You can use it as a human-readable bundle replacement (see
 linkgit:git-bundle[1]), or as a format that can be edited before being
-fed to 'git fast-import' in order to do history rewrites (an ability
-relied on by tools like 'git filter-repo').
+fed to `git fast-import` in order to do history rewrites (an ability
+relied on by tools like `git filter-repo`).
 
 OPTIONS
 -------
---progress=<n>::
-	Insert 'progress' statements every <n> objects, to be shown by
-	'git fast-import' during import.
+`--progress=<n>`::
+	Insert `progress` statements every _<n>_ objects, to be shown by
+	`git fast-import` during import.
 
---signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
+`--signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)`::
 	Specify how to handle signed tags.  Since any transformation
 	after the export (or during the export, such as excluding
 	revisions) can change the hashes being signed, the signatures
 	may become invalid.
 +
-When asking to 'abort' (which is the default), this program will die
-when encountering a signed tag.  With 'strip', the tags will silently
-be made unsigned, with 'warn-strip' they will be made unsigned but a
-warning will be displayed, with 'verbatim', they will be silently
-exported and with 'warn-verbatim' (or 'warn', a deprecated synonym),
-they will be exported, but you will see a warning.  'verbatim' and
-'warn-verbatim' should only be used if you know that no transformation
+`abort`;; Die when encountering a signed tag. This is the default.
+`strip`;; Silently make signed tags unsigned.
+`warn-strip`;; Make signed tags unsigned and display a warning.
+`verbatim`;; Silently export signed tags.
+`warn-verbatim` (or `warn`, a deprecated synonym);; Export signed tags and
+display a warning.
++
+Use `verbatim` and `warn-verbatim` only if you know that no transformation
 affecting tags or any commit in their history will be performed by you
-or by fast-export or fast-import, or if you do not care that the
+or by `git fast-export` or `git fast-import`, or if you do not care that the
 resulting tag will have an invalid signature.
 
---signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
+`--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)`::
 	Specify how to handle signed commits.  Behaves exactly as
-	'--signed-tags', but for commits.  Default is 'strip', which
+	`--signed-tags`, but for commits.  Default is `strip`, which
 	is the same as how earlier versions of this command without
 	this option behaved.
 +
 When exported, a signature starts with:
 +
+[synopsis]
 gpgsig <git-hash-algo> <signature-format>
 +
-where <git-hash-algo> is the Git object hash so either "sha1" or
-"sha256", and <signature-format> is the signature type, so "openpgp",
-"x509", "ssh" or "unknown".
+where _<git-hash-algo>_ is the Git object hash so either `sha1` or
+`sha256`, and _<signature-format>_ is the signature type, so `openpgp`,
+`x509`, `ssh` or `unknown`.
 +
 For example, an OpenPGP signature on a SHA-1 commit starts with
 `gpgsig sha1 openpgp`, while an SSH signature on a SHA-256 commit
@@ -70,19 +72,19 @@ Git hash algorithm in each commit.
 NOTE: This is highly experimental and the format of the data stream may
 change in the future without compatibility guarantees.
 
---tag-of-filtered-object=(abort|drop|rewrite)::
+`--tag-of-filtered-object=(abort|drop|rewrite)`::
 	Specify how to handle tags whose tagged object is filtered out.
 	Since revisions and files to export can be limited by path,
 	tagged objects may be filtered completely.
 +
-When asking to 'abort' (which is the default), this program will die
-when encountering such a tag.  With 'drop' it will omit such tags from
-the output.  With 'rewrite', if the tagged object is a commit, it will
-rewrite the tag to tag an ancestor commit (via parent rewriting; see
-linkgit:git-rev-list[1]).
-
--M::
--C::
+`abort`;; Die when encountering a tag whose tagged object is filtered out.
+This is the default.
+`drop`;; Omit filtered tags from the output.
+`rewrite`;; Rewrite a tag to tag an ancestor commit if the tagged object is a
+commit (via parent rewriting; see linkgit:git-rev-list[1]).
+
+`-M`::
+`-C`::
 	Perform move and/or copy detection, as described in the
 	linkgit:git-diff[1] manual page, and use it to generate
 	rename and copy commands in the output dump.
@@ -90,26 +92,26 @@ linkgit:git-rev-list[1]).
 Note that earlier versions of this command did not complain and
 produced incorrect results if you gave these options.
 
---export-marks=<file>::
-	Dumps the internal marks table to <file> when complete.
+`--export-marks=<file>`::
+	Dump the internal marks table to _<file>_ when complete.
 	Marks are written one per line as `:markid SHA-1`. Only marks
 	for revisions are dumped; marks for blobs are ignored.
 	Backends can use this file to validate imports after they
 	have been completed, or to save the marks table across
-	incremental runs.  As <file> is only opened and truncated
+	incremental runs.  As _<file>_ is only opened and truncated
 	at completion, the same path can also be safely given to
-	--import-marks.
+	`--import-marks`.
 	The file will not be written if no new object has been
 	marked/exported.
 
---import-marks=<file>::
-	Before processing any input, load the marks specified in
-	<file>.  The input file must exist, must be readable, and
-	must use the same format as produced by --export-marks.
+`--import-marks=<file>`::
+	Load the marks specified in _<file>_ before processing any input.
+	The input file must exist, must be readable, and
+	must use the same format as produced by `--export-marks`.
 
---mark-tags::
-	In addition to labelling blobs and commits with mark ids, also
-	label tags.  This is useful in conjunction with
+`--mark-tags`::
+	Label tags  with mark ids in addition of blobs and commits.
+	This is useful in conjunction with
 	`--export-marks` and `--import-marks`, and is also useful (and
 	necessary) for exporting of nested tags.  It does not hurt
 	other cases and would be the default, but many fast-import
@@ -117,21 +119,21 @@ produced incorrect results if you gave these options.
 	identifiers.
 +
 Any commits (or tags) that have already been marked will not be
-exported again.  If the backend uses a similar --import-marks file,
+exported again.  If the backend uses a similar `--import-marks` file,
 this allows for incremental bidirectional exporting of the repository
 by keeping the marks the same across runs.
 
---fake-missing-tagger::
-	Some old repositories have tags without a tagger.  The
+`--fake-missing-tagger`::
+	Fake a tagger for tags from old repositories that do not have one.  The
 	fast-import protocol was pretty strict about that, and did not
-	allow that.  So fake a tagger to be able to fast-import the
+	allow that.  This allows `git fast-import` to import the
 	output.
 
---use-done-feature::
-	Start the stream with a 'feature done' stanza, and terminate
-	it with a 'done' command.
+`--use-done-feature`::
+	Start the stream with a `feature done` stanza, and terminate
+	it with a `done` command.
 
---no-data::
+`--no-data`::
 	Skip output of blob objects and instead refer to blobs via
 	their original SHA-1 hash.  This is useful when rewriting the
 	directory structure or history of a repository without
@@ -139,53 +141,54 @@ by keeping the marks the same across runs.
 	resulting stream can only be used by a repository which
 	already contains the necessary objects.
 
---full-tree::
-	This option will cause fast-export to issue a "deleteall"
+`--full-tree`::
+	Issue a `deleteall`
 	directive for each commit followed by a full list of all files
 	in the commit (as opposed to just listing the files which are
 	different from the commit's first parent).
 
---anonymize::
+`--anonymize`::
 	Anonymize the contents of the repository while still retaining
 	the shape of the history and stored tree.  See the section on
-	<<ANONYMIZING,`ANONYMIZING`>> below.
-
---anonymize-map=<from>[:<to>]::
-	Convert token `<from>` to `<to>` in the anonymized output. If
-	`<to>` is omitted, map `<from>` to itself (i.e., do not
-	anonymize it). See the section on <<ANONYMIZING,`ANONYMIZING`>> below.
-
---reference-excluded-parents::
-	By default, running a command such as `git fast-export
-	master~5..master` will not include the commit master{tilde}5
-	and will make master{tilde}4 no longer have master{tilde}5 as
-	a parent (though both the old master{tilde}4 and new
-	master{tilde}4 will have all the same files).  Use
-	--reference-excluded-parents to instead have the stream
-	refer to commits in the excluded range of history by their
-	sha1sum.  Note that the resulting stream can only be used by a
-	repository which already contains the necessary parent
+	<<ANONYMIZING,'ANONYMIZING'>> below.
+
+`--anonymize-map=<from>[:<to>]`::
+	Convert token _<from>_ to _<to>_ in the anonymized output. If
+	_<to>_ is omitted, map _<from>_ to itself (i.e., do not
+	anonymize it). See the section on <<ANONYMIZING,'ANONYMIZING'>> below.
+
+`--reference-excluded-parents`::
+	Have the stream refer to commits in the excluded range of history by their SHA-1 object
+	name instead of rewriting their parent references. By default, running
+	a command such as `git fast-export master~5..master` will not include the
+	commit `master~5`
+	and will make `master~4` no longer have `master~5` as
+	a parent (though both the old `master~4` and new
+	`master~4` will have all the same files). Note that the resulting stream
+	can only be used by a repository which 	  already contains the necessary parent
 	commits.
 
---show-original-ids::
+`--show-original-ids`::
 	Add an extra directive to the output for commits and blobs,
 	`original-oid <SHA1SUM>`.  While such directives will likely be
-	ignored by importers such as git-fast-import, it may be useful
+	ignored by importers such as `git fast-import`, it may be useful
 	for intermediary filters (e.g. for rewriting commit messages
 	which refer to older commits, or for stripping blobs by id).
 
---reencode=(yes|no|abort)::
+`--reencode=(yes|no|abort)`::
 	Specify how to handle `encoding` header in commit objects.  When
-	asking to 'abort' (which is the default), this program will die
-	when encountering such a commit object.  With 'yes', the commit
-	message will be re-encoded into UTF-8.  With 'no', the original
-	encoding will be preserved.
+	asking to one of the following values:
++
+`abort`;; Die when encountering a commit object with an `encoding` header.
+This is the default.
+`yes`;; Re-encode the commit message into UTF-8.
+`no`;; Preserve the original encoding.
 
---refspec::
+`--refspec`::
 	Apply the specified refspec to each ref exported. Multiple of them can
 	be specified.
 
-[<git-rev-list-args>...]::
+`<git-rev-list-args>...`::
 	A list of arguments, acceptable to 'git rev-parse' and
 	'git rev-list', that specifies the specific objects and references
 	to export.  For example, `master~10..master` causes the
@@ -197,26 +200,26 @@ by keeping the marks the same across runs.
 EXAMPLES
 --------
 
--------------------------------------------------------------------
+----
 $ git fast-export --all | (cd /empty/repository && git fast-import)
--------------------------------------------------------------------
+----
 
 This will export the whole repository and import it into the existing
 empty repository.  Except for reencoding commits that are not in
 UTF-8, it would be a one-to-one mirror.
 
------------------------------------------------------
+----
 $ git fast-export master~5..master |
 	sed "s|refs/heads/master|refs/heads/other|" |
 	git fast-import
------------------------------------------------------
+----
 
-This makes a new branch called 'other' from 'master~5..master'
-(i.e. if 'master' has linear history, it will take the last 5 commits).
+This makes a new branch called `other` from `master~5..master`
+(i.e. if `master` has linear history, it will take the last 5 commits).
 
 Note that this assumes that none of the blobs and commit messages
 referenced by that revision range contains the string
-'refs/heads/master'.
+`refs/heads/master`.
 
 
 [[ANONYMIZING]]
@@ -245,20 +248,20 @@ files will be replaced.
 If you think you have found a git bug, you can start by exporting an
 anonymized stream of the whole repository:
 
----------------------------------------------------
+----
 $ git fast-export --anonymize --all >anon-stream
----------------------------------------------------
+----
 
 Then confirm that the bug persists in a repository created from that
 stream (many bugs will not, as they really do depend on the exact
 repository contents):
 
----------------------------------------------------
+----
 $ git init anon-repo
 $ cd anon-repo
 $ git fast-import <../anon-stream
 $ ... test your bug ...
----------------------------------------------------
+----
 
 If the anonymized repository shows the bug, it may be worth sharing
 `anon-stream` along with a regular bug report. Note that the anonymized
@@ -266,9 +269,9 @@ stream compresses very well, so gzipping it is encouraged. If you want
 to examine the stream to see that it does not contain any private data,
 you can peruse it directly before sending. You may also want to try:
 
----------------------------------------------------
+----
 $ perl -pe 's/\d+/X/g' <anon-stream | sort -u | less
----------------------------------------------------
+----
 
 which shows all of the unique lines (with numbers converted to "X", to
 collapse "User 0", "User 1", etc into "User X"). This produces a much
@@ -281,12 +284,12 @@ anonymized. You can ask for a particular token to be left as-is or
 mapped to a new value. For example, if you have a bug which reproduces
 with `git rev-list sensitive -- secret.c`, you can run:
 
----------------------------------------------------
+----
 $ git fast-export --anonymize --all \
       --anonymize-map=sensitive:foo \
       --anonymize-map=secret.c:bar.c \
       >stream
----------------------------------------------------
+----
 
 After importing the stream, you can then run `git rev-list foo -- bar.c`
 in the anonymized repository.
@@ -303,7 +306,7 @@ final pathname would be `publicdir/bar.c`.
 LIMITATIONS
 -----------
 
-Since 'git fast-import' cannot tag trees, you will not be
+Since `git fast-import` cannot tag trees, you will not be
 able to export the linux.git repository completely, as it contains
 a tag referencing a tree instead of a commit.
 
-- 
gitgitgadget
