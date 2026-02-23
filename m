Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149BA34FF47
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771844135; cv=none; b=IX229Xmb2AUROXT2LR39tVqm9I1BsRP3XFCOzSY3vjl9QnwcpRFn3oJdYtzsSNl8IXLiePGkTvHoeitGaYbO8divcO0Q7n+K7WnqsV6KTno/em5b/Wqs8xwM+Up/5sLavlpWEIwacz48ymixokn7/TQss62eKQ9rCmjh5/8NA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771844135; c=relaxed/simple;
	bh=PcUqZeP1sw9B/8zB02FXWgJ6eSoP9FgQ8lKYvU4tVA0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=LQDlQPoNz7Ur9GZQoAAO03eLNnWYlmwRPa8pjibefMsudKVuwV8q8Bq3Ayx6GtaN8ul3ssarY1W2DA++9cIwr/8I9uxgyDgGs7+6JM0wQDvINyEaBc+PjInaBnnHGkZDOiWFqQ7hoPO14+px07m8Meog/ihpAkNOy8liOmvW/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXNGEC3X; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXNGEC3X"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb38e6d164so510595185a.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 02:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771844132; x=1772448932; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BHNboSUDlFcGgcctH+DTlf7R7L/4WGZu3D7TTVwpmsQ=;
        b=UXNGEC3XJVa4UpkoNYBDcquizVBEmxiqej1R+uAPYcWZ+Xv9zTh3/08UkbVu7mE2TJ
         6p9TWbrczXRMPaWksVIeDR3Kv0f/c9l1spB5lKOv/cRqiZhkYzEaisHErZmxdqt4EHCj
         5M9Pljnpliw1qHSlrkeAAFCg9Uq77JIMVYzOD+In+jxTeyE+SQQqOm4qvR311T7EnBEp
         9zKFv42ZYV2AGCeX1JfWK1ItFKiDoeR0IALWzvEYA0fn46DoP2MgY5kQvGRDjkiYx8wg
         jmNcEbOO3mo3u00IHcYo+TGEO4jZfDX1xBrivbXhE0xeavAmncA+dl6yxhTZEpRaXemk
         fr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771844132; x=1772448932;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHNboSUDlFcGgcctH+DTlf7R7L/4WGZu3D7TTVwpmsQ=;
        b=L64Q8XlN3kTvVkuanyLrgjXtp7Ab2GHHvZgwLtnSHkEenezBOdER4NXJGlXVcgNmBI
         L/fxBilM0er7nj36zBHKc1rMmcvh/E4ex7d/rAjRlrpzjbXxvC8ENomEnv44xxOR5Iq0
         yGmDpRXNEowmef+rEmrD6LYGqlOIW5RpAdklvP2DTeki7Z6uU95wrwXGuqKRoEFZ64ea
         hcl4ubDG6HvluXJB35AUu0T78sSt1TPprxTzzvsmNiwCbgcPFXQyq8QnHEo4iLtVD7nk
         myu/ifccTIUY5Iu92JSpmsdI+isHS9PUFGZTmK+8gKi+rXs/1nFvVMddsD4M0BbNujgo
         emjQ==
X-Gm-Message-State: AOJu0Yzvasw7YPOFPneEDwSY7MfV1wulZ+nC6gukgjpM2mYTfBtZ7cwe
	EZ08wvMuP33hZkIM7qyHjcCxg2iwlH1U80SBAQbbvD0cObe4sx9b4ZpSlwYzFA==
X-Gm-Gg: AZuq6aIZDyoA9FOFpSUOs1/r87E7+5Y5lKcexWmK/ILIP5/Hz13bK8Bs/6SVCnKMd03
	XgSz1gNRizs2toaQAUF2PZGHopVSCa3dell41Dfb9dci+Sw5AU4FaIsc2dJtbSUe8GZPV+FJDyw
	2gHnVpclityO67zrPmf08D9ZGvVtx+35Y76zEVUeQTfd8xROgNpT9BrrZPO/fnxYAYvDapbCHAl
	qzcErzBaAZ8sY9otRc7aGAUOhlvkejScxglm9mlZrjcMIPz+RFJWxUgYnlixdW4taH270b1hOAP
	XUNa/qIe21XNtJY2ceXEJvPcDuVqgpNBhdiAA8nUw6kSkipdHIaCmXNKk3wmQJjV5RltOvAE1N3
	nazwRfgbVfnkca5pKnDagA6iFAv9Yk57Ky1o7JRoWuc7jd+f7U1Qm+dGL7nw6jF8Dr9EnKgycrX
	tK3bGezKdzIDvgX97S+NDrLV3dsbM=
X-Received: by 2002:a05:620a:d8d:b0:8c9:ea1c:f218 with SMTP id af79cd13be357-8cb8c9e009cmr782693685a.15.1771844132385;
        Mon, 23 Feb 2026 02:55:32 -0800 (PST)
Received: from [127.0.0.1] ([135.232.224.122])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0ebcd0sm789685185a.28.2026.02.23.02.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 02:55:31 -0800 (PST)
Message-Id: <pull.2055.git.1771844130973.gitgitgadget@gmail.com>
From: "Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 10:55:30 +0000
Subject: [PATCH] doc: format config values with backticks
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Md Ferdous Alam <mdferdousalam1989@yahoo.com>,
    mdferdousalam <mdferdousalam1989@yahoo.com>

From: mdferdousalam <mdferdousalam1989@yahoo.com>

Add backtick formatting to bare true/false values in configuration
documentation so they render in monospace as config literals, matching
the style used throughout most of the existing documentation.

Signed-off-by: Md Ferdous Alam <mdferdousalam@gmail.com>
---
    doc: format config values with backticks
    
    Add backtick formatting to bare true/false values in configuration
    documentation so they render in monospace as config literals, matching
    the style used throughout most of the existing documentation.
    
    Files updated:
    
     * am.adoc, blame.adoc, clean.adoc, commitgraph.adoc
     * credential.adoc, fmt-merge-msg.adoc, format.adoc
     * grep.adoc, rebase.adoc, rerere.adoc, stash.adoc, status.adoc
    
    This addresses https://github.com/gitgitgadget/git/issues/244

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2055%2Fmdferdousalam%2Ffix-config-doc-formatting-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2055/mdferdousalam/fix-config-doc-formatting-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2055

 Documentation/config/am.adoc            |  4 ++--
 Documentation/config/blame.adoc         |  2 +-
 Documentation/config/clean.adoc         |  2 +-
 Documentation/config/commitgraph.adoc   |  8 ++++----
 Documentation/config/credential.adoc    |  2 +-
 Documentation/config/fmt-merge-msg.adoc |  6 +++---
 Documentation/config/format.adoc        | 22 +++++++++++-----------
 Documentation/config/grep.adoc          | 12 ++++++------
 Documentation/config/rebase.adoc        | 18 +++++++++---------
 Documentation/config/rerere.adoc        |  4 ++--
 Documentation/config/stash.adoc         | 16 ++++++++--------
 Documentation/config/status.adoc        | 20 ++++++++++----------
 12 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/Documentation/config/am.adoc b/Documentation/config/am.adoc
index 5bcad2efb1..d072613400 100644
--- a/Documentation/config/am.adoc
+++ b/Documentation/config/am.adoc
@@ -1,5 +1,5 @@
 am.keepcr::
-	If true, git-am will call git-mailsplit for patches in mbox format
+	If `true`, git-am will call git-mailsplit for patches in mbox format
 	with parameter `--keep-cr`. In this case git-mailsplit will
 	not remove `\r` from lines ending with `\r\n`. Can be overridden
 	by giving `--no-keep-cr` from the command line.
@@ -7,7 +7,7 @@ am.keepcr::
 
 am.threeWay::
 	By default, `git am` will fail if the patch does not apply cleanly. When
-	set to true, this setting tells `git am` to fall back on 3-way merge if
+	set to `true`, this setting tells `git am` to fall back on 3-way merge if
 	the patch records the identity of blobs it is supposed to apply to and
 	we have those blobs available locally (equivalent to giving the `--3way`
 	option from the command line). Defaults to `false`.
diff --git a/Documentation/config/blame.adoc b/Documentation/config/blame.adoc
index 4d047c1790..3ca7ea6ccd 100644
--- a/Documentation/config/blame.adoc
+++ b/Documentation/config/blame.adoc
@@ -1,6 +1,6 @@
 blame.blankBoundary::
 	Show blank commit object name for boundary commits in
-	linkgit:git-blame[1]. This option defaults to false.
+	linkgit:git-blame[1]. This option defaults to `false`.
 
 blame.coloring::
 	This determines the coloring scheme to be applied to blame
diff --git a/Documentation/config/clean.adoc b/Documentation/config/clean.adoc
index c0188ead4e..095945d508 100644
--- a/Documentation/config/clean.adoc
+++ b/Documentation/config/clean.adoc
@@ -1,3 +1,3 @@
 clean.requireForce::
 	A boolean to make git-clean refuse to delete files unless -f
-	is given. Defaults to true.
+	is given. Defaults to `true`.
diff --git a/Documentation/config/commitgraph.adoc b/Documentation/config/commitgraph.adoc
index 70a56c53d2..1c33e08141 100644
--- a/Documentation/config/commitgraph.adoc
+++ b/Documentation/config/commitgraph.adoc
@@ -9,9 +9,9 @@ commitGraph.maxNewFilters::
 	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
 
 commitGraph.changedPaths::
-	If true, then `git commit-graph write` will compute and write
+	If `true`, then `git commit-graph write` will compute and write
 	changed-path Bloom filters by default, equivalent to passing
-	`--changed-paths`. If false or unset, changed-paths Bloom filters will
+	`--changed-paths`. If `false` or unset, changed-paths Bloom filters will
 	be written during `git commit-graph write` only if the filters already
 	exist in the current commit-graph file. This matches the default
 	behavior of `git commit-graph write` without any `--[no-]changed-paths`
@@ -20,8 +20,8 @@ commitGraph.changedPaths::
 	always takes precedence over this configuration. Defaults to unset.
 
 commitGraph.readChangedPaths::
-	Deprecated. Equivalent to commitGraph.changedPathsVersion=-1 if true, and
-	commitGraph.changedPathsVersion=0 if false. (If commitGraph.changedPathVersion
+	Deprecated. Equivalent to commitGraph.changedPathsVersion=-1 if `true`, and
+	commitGraph.changedPathsVersion=0 if `false`. (If commitGraph.changedPathVersion
 	is also set, commitGraph.changedPathsVersion takes precedence.)
 
 commitGraph.changedPathsVersion::
diff --git a/Documentation/config/credential.adoc b/Documentation/config/credential.adoc
index 80a7c77772..0e88c4c7f2 100644
--- a/Documentation/config/credential.adoc
+++ b/Documentation/config/credential.adoc
@@ -19,7 +19,7 @@ credential.interactive::
 
 credential.useHttpPath::
 	When acquiring credentials, consider the "path" component of an http
-	or https URL to be important. Defaults to false. See
+	or https URL to be important. Defaults to `false`. See
 	linkgit:gitcredentials[7] for more information.
 
 credential.sanitizePrompt::
diff --git a/Documentation/config/fmt-merge-msg.adoc b/Documentation/config/fmt-merge-msg.adoc
index 696ba0531a..4bcf5b2688 100644
--- a/Documentation/config/fmt-merge-msg.adoc
+++ b/Documentation/config/fmt-merge-msg.adoc
@@ -1,13 +1,13 @@
 `merge.branchdesc`::
 	In addition to branch names, populate the log message with
 	the branch description text associated with them.  Defaults
-	to false.
+	to `false`.
 
 `merge.log`::
 	In addition to branch names, populate the log message with at
 	most the specified number of one-line descriptions from the
-	actual commits that are being merged.  Defaults to false, and
-	true is a synonym for 20.
+	actual commits that are being merged.  Defaults to `false`, and
+	`true` is a synonym for 20.
 
 `merge.suppressDest`::
 	By adding a glob that matches the names of integration
diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
index ab0710e86a..a9736b196a 100644
--- a/Documentation/config/format.adoc
+++ b/Documentation/config/format.adoc
@@ -8,23 +8,23 @@ format.attach::
 
 format.from::
 	Provides the default value for the `--from` option to format-patch.
-	Accepts a boolean value, or a name and email address.  If false,
+	Accepts a boolean value, or a name and email address.  If `false`,
 	format-patch defaults to `--no-from`, using commit authors directly in
-	the "From:" field of patch mails.  If true, format-patch defaults to
+	the "From:" field of patch mails.  If `true`, format-patch defaults to
 	`--from`, using your committer identity in the "From:" field of patch
 	mails and including a "From:" field in the body of the patch mail if
 	different.  If set to a non-boolean value, format-patch uses that
-	value instead of your committer identity.  Defaults to false.
+	value instead of your committer identity.  Defaults to `false`.
 
 format.forceInBodyFrom::
 	Provides the default value for the `--[no-]force-in-body-from`
-	option to format-patch.  Defaults to false.
+	option to format-patch.  Defaults to `false`.
 
 format.numbered::
 	A boolean which can enable or disable sequence numbers in patch
 	subjects.  It defaults to "auto" which enables it only if there
 	is more than one patch.  It can be enabled or disabled for all
-	messages by setting it to "true" or "false".  See --numbered
+	messages by setting it to `true` or `false`.  See --numbered
 	option in linkgit:git-format-patch[1].
 
 format.headers::
@@ -65,7 +65,7 @@ format.suffix::
 format.encodeEmailHeaders::
 	Encode email headers that have non-ASCII characters with
 	"Q-encoding" (described in RFC 2047) for email transmission.
-	Defaults to true.
+	Defaults to `true`.
 
 format.pretty::
 ifndef::with-breaking-changes[]
@@ -85,7 +85,7 @@ format.thread::
 	where the head is chosen from the cover letter, the
 	`--in-reply-to`, and the first patch mail, in this order.
 	`deep` threading makes every mail a reply to the previous one.
-	A true boolean value is the same as `shallow`, and a false
+	A `true` boolean value is the same as `shallow`, and a `false`
 	value disables threading.
 
 format.signOff::
@@ -99,7 +99,7 @@ format.coverLetter::
 	A boolean that controls whether to generate a cover-letter when
 	format-patch is invoked, but in addition can be set to "auto", to
 	generate a cover-letter only when there's more than one patch.
-	Default is false.
+	Default is `false`.
 
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
@@ -119,11 +119,11 @@ format.useAutoBase::
 format.notes::
 	Provides the default value for the `--notes` option to
 	format-patch. Accepts a boolean value, or a ref which specifies
-	where to get notes. If false, format-patch defaults to
-	`--no-notes`. If true, format-patch defaults to `--notes`. If
+	where to get notes. If `false`, format-patch defaults to
+	`--no-notes`. If `true`, format-patch defaults to `--notes`. If
 	set to a non-boolean value, format-patch defaults to
 	`--notes=<ref>`, where `ref` is the non-boolean value. Defaults
-	to false.
+	to `false`.
 +
 If one wishes to use the ref `refs/notes/true`, please use that literal
 instead.
diff --git a/Documentation/config/grep.adoc b/Documentation/config/grep.adoc
index 10041f27b0..a446830a5c 100644
--- a/Documentation/config/grep.adoc
+++ b/Documentation/config/grep.adoc
@@ -1,8 +1,8 @@
 grep.lineNumber::
-	If set to true, enable `-n` option by default.
+	If set to `true`, enable `-n` option by default.
 
 grep.column::
-	If set to true, enable the `--column` option by default.
+	If set to `true`, enable the `--column` option by default.
 
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
@@ -12,7 +12,7 @@ grep.patternType::
 	between 'basic' and 'extended'.
 
 grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
+	If set to `true`, enable `--extended-regexp` option by default. This
 	option is ignored when the `grep.patternType` option is set to a value
 	other than 'default'.
 
@@ -21,8 +21,8 @@ grep.threads::
 	use as many threads as the number of logical cores available.
 
 grep.fullName::
-	If set to true, enable `--full-name` option by default.
+	If set to `true`, enable `--full-name` option by default.
 
 grep.fallbackToNoIndex::
-	If set to true, fall back to `git grep --no-index` if `git grep`
-	is executed outside of a git repository.  Defaults to false.
+	If set to `true`, fall back to `git grep --no-index` if `git grep`
+	is executed outside of a git repository.  Defaults to `false`.
diff --git a/Documentation/config/rebase.adoc b/Documentation/config/rebase.adoc
index c6187ab28b..307688f306 100644
--- a/Documentation/config/rebase.adoc
+++ b/Documentation/config/rebase.adoc
@@ -9,22 +9,22 @@ rebase.stat::
 	rebase. False by default.
 
 rebase.autoSquash::
-	If set to true, enable the `--autosquash` option of
+	If set to `true`, enable the `--autosquash` option of
 	linkgit:git-rebase[1] by default for interactive mode.
 	This can be overridden with the `--no-autosquash` option.
 
 rebase.autoStash::
-	When set to true, automatically create a temporary stash entry
+	When set to `true`, automatically create a temporary stash entry
 	before the operation begins, and apply it after the operation
 	ends.  This means that you can run rebase on a dirty worktree.
 	However, use with care: the final stash application after a
 	successful rebase might result in non-trivial conflicts.
 	This option can be overridden by the `--no-autostash` and
 	`--autostash` options of linkgit:git-rebase[1].
-	Defaults to false.
+	Defaults to `false`.
 
 rebase.updateRefs::
-	If set to true enable `--update-refs` option by default.
+	If set to `true` enable `--update-refs` option by default.
 
 rebase.missingCommitsCheck::
 	If set to "warn", git rebase -i will print a warning if some
@@ -43,7 +43,7 @@ rebase.instructionFormat::
 	automatically have the commit hash prepended to the format.
 
 rebase.abbreviateCommands::
-	If set to true, `git rebase` will use abbreviated command names in the
+	If set to `true`, `git rebase` will use abbreviated command names in the
 	todo list resulting in something like this:
 +
 -------------------------------------------
@@ -60,7 +60,7 @@ instead of:
 	...
 -------------------------------------------
 +
-Defaults to false.
+Defaults to `false`.
 
 rebase.rescheduleFailedExec::
 	Automatically reschedule `exec` commands that failed. This only makes
@@ -68,14 +68,14 @@ rebase.rescheduleFailedExec::
 	This is the same as specifying the `--reschedule-failed-exec` option.
 
 rebase.forkPoint::
-	If set to false set `--no-fork-point` option by default.
+	If set to `false` set `--no-fork-point` option by default.
 
 rebase.rebaseMerges::
 	Whether and how to set the `--rebase-merges` option by default. Can
 	be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
-	true or to `no-rebase-cousins` is equivalent to
+	`true` or to `no-rebase-cousins` is equivalent to
 	`--rebase-merges=no-rebase-cousins`, setting to `rebase-cousins` is
-	equivalent to `--rebase-merges=rebase-cousins`, and setting to false is
+	equivalent to `--rebase-merges=rebase-cousins`, and setting to `false` is
 	equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
 	command line, with or without an argument, overrides any
 	`rebase.rebaseMerges` configuration.
diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index 3a78b5ebb1..20eb3ba870 100644
--- a/Documentation/config/rerere.adoc
+++ b/Documentation/config/rerere.adoc
@@ -1,7 +1,7 @@
 rerere.autoUpdate::
-	When set to true, `git-rerere` updates the index with the
+	When set to `true`, `git-rerere` updates the index with the
 	resulting contents after it cleanly resolves conflicts using
-	previously recorded resolutions.  Defaults to false.
+	previously recorded resolutions.  Defaults to `false`.
 
 rerere.enabled::
 	Activate recording of resolved conflicts, so that identical
diff --git a/Documentation/config/stash.adoc b/Documentation/config/stash.adoc
index a1197ffd7d..c4c998d575 100644
--- a/Documentation/config/stash.adoc
+++ b/Documentation/config/stash.adoc
@@ -7,8 +7,8 @@ ifdef::git-stash[]
 endif::git-stash[]
 
 `stash.index`::
-	If this is set to true, `git stash apply` and `git stash pop` will
-	behave as if `--index` was supplied. Defaults to false.
+	If this is set to `true`, `git stash apply` and `git stash pop` will
+	behave as if `--index` was supplied. Defaults to `false`.
 ifndef::git-stash[]
 See the descriptions in linkgit:git-stash[1].
 +
@@ -18,15 +18,15 @@ linkgit:git-pull[1].
 endif::git-stash[]
 
 `stash.showIncludeUntracked`::
-	If this is set to true, the `git stash show` command will show
-	the untracked files of a stash entry. Defaults to false. {see-show}
+	If this is set to `true`, the `git stash show` command will show
+	the untracked files of a stash entry. Defaults to `false`. {see-show}
 
 `stash.showPatch`::
-	If this is set to true, the `git stash show` command without an
-	option will show the stash entry in patch form.  Defaults to false.
+	If this is set to `true`, the `git stash show` command without an
+	option will show the stash entry in patch form.  Defaults to `false`.
 	{see-show}
 
 `stash.showStat`::
-	If this is set to true, the `git stash show` command without an
-	option will show a diffstat of the stash entry.  Defaults to true.
+	If this is set to `true`, the `git stash show` command without an
+	option will show a diffstat of the stash entry.  Defaults to `true`.
 	{see-show}
diff --git a/Documentation/config/status.adoc b/Documentation/config/status.adoc
index 8caf90f51c..fe0d44e617 100644
--- a/Documentation/config/status.adoc
+++ b/Documentation/config/status.adoc
@@ -5,24 +5,24 @@ status.relativePaths::
 	prior to v1.5.4).
 
 status.short::
-	Set to true to enable --short by default in linkgit:git-status[1].
+	Set to `true` to enable --short by default in linkgit:git-status[1].
 	The option --no-short takes precedence over this variable.
 
 status.branch::
-	Set to true to enable --branch by default in linkgit:git-status[1].
+	Set to `true` to enable --branch by default in linkgit:git-status[1].
 	The option --no-branch takes precedence over this variable.
 
 status.aheadBehind::
-	Set to true to enable `--ahead-behind` and false to enable
+	Set to `true` to enable `--ahead-behind` and `false` to enable
 	`--no-ahead-behind` by default in linkgit:git-status[1] for
-	non-porcelain status formats.  Defaults to true.
+	non-porcelain status formats.  Defaults to `true`.
 
 status.displayCommentPrefix::
-	If set to true, linkgit:git-status[1] will insert a comment
+	If set to `true`, linkgit:git-status[1] will insert a comment
 	prefix before each output line (starting with
 	`core.commentChar`, i.e. `#` by default). This was the
 	behavior of linkgit:git-status[1] in Git 1.8.4 and previous.
-	Defaults to false.
+	Defaults to `false`.
 
 status.renameLimit::
 	The number of files to consider when performing rename detection
@@ -37,9 +37,9 @@ status.renames::
 	Defaults to the value of diff.renames.
 
 status.showStash::
-	If set to true, linkgit:git-status[1] will display the number of
+	If set to `true`, linkgit:git-status[1] will display the number of
 	entries currently stashed away.
-	Defaults to false.
+	Defaults to `false`.
 
 status.showUntrackedFiles::
 	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
@@ -63,8 +63,8 @@ This variable can be overridden with the -u|--untracked-files option
 of linkgit:git-status[1] and linkgit:git-commit[1].
 
 status.submoduleSummary::
-	Defaults to false.
-	If this is set to a non-zero number or true (identical to -1 or an
+	Defaults to `false`.
+	If this is set to a non-zero number or `true` (identical to -1 or an
 	unlimited number), the submodule summary will be enabled and a
 	summary of commits for modified submodules will be shown (see
 	--summary-limit option of linkgit:git-submodule[1]). Please note

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
gitgitgadget
