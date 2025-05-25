Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F61B87E9
	for <git@vger.kernel.org>; Sun, 25 May 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748204840; cv=none; b=OBbCrxPdeUpank2Rce5gOtCOECq0xdcIDD9l9PRqHECy9UTJk7Ysq5+xlK+JJpzTa3Tts1P1sXo8gIHHg8VMA8Ozxk5iiqW5baDULGRQ6uV4z2jV65txVig47VfFZBBMZrs52F3IXLMpG8YVDkjzEpOG7P0m/0e0M1mdUe0+tDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748204840; c=relaxed/simple;
	bh=cqfUmlxzecDLsNy/SJuJY+VDorHiPWf7VmR5ovYWYDY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=V11PGqjT31Siec6j//nPcGaFO1o5kFofhd2J1E8ywDEQJIeoCnLK0dFAY6l0pI4qDRuiEJhI4teJ3bh9dewBU1ZYUNEMxN46GudKPN11vj0dRjOGopdauNnHP7auOqL+KQv3i9zg1/GiPG36YG4cZ5N5oi7iLBdPpXWWkH4JBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1IOWCID; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1IOWCID"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-442d146a1aaso20181185e9.1
        for <git@vger.kernel.org>; Sun, 25 May 2025 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748204836; x=1748809636; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AF47piTaJnxAAuZea0KBXVSlEVEhLF7SztOiF2JkKR4=;
        b=P1IOWCID3UpQCIYeTox03riYRjlAgH2JK5CiRcwFFr68V+Ctc+U2oXJo76l1rAXwNu
         Cn6BR0D8BLEVrds/w+rWuF0ny7XyepJjAtGVoUT8g3LzDa0D9ew3h08a1RoccHKLWI7l
         T/PMuXcaPt9nSs0KBLhBefIxNqxZi2bup/fno63YQqszuoUJ2xDM7Md0HM6JwdEIB5Rq
         h4aiDNLV5pHmXPUEvUIko48WFn2P2aue2P+n8hwrhcyqY52iWPpl/I75rNLRClW5VEBM
         LbtQeTEpmLT6O+Ykf0qvcC2U3ImzPhaP1QGBft8TDtiHe6nhHLEOHZ5SFTS9vYLbUhPD
         4wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748204836; x=1748809636;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF47piTaJnxAAuZea0KBXVSlEVEhLF7SztOiF2JkKR4=;
        b=pf38LJdI6Wdh5AMEcCmuSLkWhOGy5oeQINje4t2aqa8e+d5yuD+zK67nI+q2KKQ2cs
         Aaq+SPozfUkKlJo6FAzzp3K5t30tNBOnH9E+zDrJImg7K3Z3geDRcssNU6ZqwYijO8Ea
         UJw9Kg1RHcoh11ZmVeeIK7bWUHMadDj4HHjJ3Ci23GxkC/3CUGcaM/fbXrdkAyiiXY1j
         V1p6gNZ9hltJp8nnYadhWi/5klCe6m/JArYeVHWWPvd582I0MB2e/MXTqQ80EQeCp8vL
         gTJXtrRPBnR0MVY1E6SH2nlwCEsZbEevvGHAZZXvzBKvmlQOdo6qCLxoGiP8Yieo/It9
         0kWQ==
X-Gm-Message-State: AOJu0YybOgc8ckrmffWn/0eKsvdGhfOYH35O/YfDBFwlwKzH/sTI+hOF
	pC9Qt7o/++mLf3y0EDwAsccbWEWMntrlSGx6PiYX4qAdl2fl8LSyJPtr93dQzA==
X-Gm-Gg: ASbGnctmOvKZBYYHDWJxxYTCkM/MttBD/7nuiMCJ9L8CUFC+gYYNiKFhinYN4pssTfz
	Ww/emg5w4lfUcxFk2O/Sz/3P16E5HwLZq1vfdytrulXnx3mb7fw4zNwPzSXJGt/AFCurXevIZ86
	Deee/Z2GRZlJotO0B2yY5APlosAMAivecjyoPPxaHu8Kp+CmJa13gPg6p2lWUN/P+nT3mF21Jou
	w8qxs2kRZX6hT0uHJymDEA2jbeVNq1t8foVArDGx9SHNUjjZtCjn5l8BQffWSjQ5Z1JMUYRKP93
	9saUj1XdcVJKxGprpFIIN2CwQr8ci8qa1ADvdGaItCRtB2AsQeh6
X-Google-Smtp-Source: AGHT+IGUMAoS05CohUk1sX625BPPEqEtnIZ/QZSYJKHGK9gqew47rhJpNHTkzfnxlGbBbLhy6zQ3wQ==
X-Received: by 2002:a05:600c:4ecc:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-44c941880cbmr73104625e9.10.1748204835784;
        Sun, 25 May 2025 13:27:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f24b6471sm216623905e9.24.2025.05.25.13.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 13:27:15 -0700 (PDT)
Message-Id: <12b5868216e6f6f9cb5356c82f2e143af9fe4a6a.1748204829.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
References: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 20:27:06 +0000
Subject: [PATCH 6/9] doc: switch merge config description to new synopsis
 format
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

Additionally, a list of option possible values has been reformatted as a
standalone definition list.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/fmt-merge-msg.adoc |  8 +--
 Documentation/config/merge.adoc         | 84 +++++++++++++------------
 2 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/Documentation/config/fmt-merge-msg.adoc b/Documentation/config/fmt-merge-msg.adoc
index 3fbf40e24f62..696ba0531ae1 100644
--- a/Documentation/config/fmt-merge-msg.adoc
+++ b/Documentation/config/fmt-merge-msg.adoc
@@ -1,19 +1,19 @@
-merge.branchdesc::
+`merge.branchdesc`::
 	In addition to branch names, populate the log message with
 	the branch description text associated with them.  Defaults
 	to false.
 
-merge.log::
+`merge.log`::
 	In addition to branch names, populate the log message with at
 	most the specified number of one-line descriptions from the
 	actual commits that are being merged.  Defaults to false, and
 	true is a synonym for 20.
 
-merge.suppressDest::
+`merge.suppressDest`::
 	By adding a glob that matches the names of integration
 	branches to this multi-valued configuration variable, the
 	default merge message computed for merges into these
-	integration branches will omit "into <branch name>" from
+	integration branches will omit "into _<branch-name>_" from
 	its title.
 +
 An element with an empty value can be used to clear the list
diff --git a/Documentation/config/merge.adoc b/Documentation/config/merge.adoc
index d2d0f21a712d..86359f6dd2d9 100644
--- a/Documentation/config/merge.adoc
+++ b/Documentation/config/merge.adoc
@@ -1,9 +1,9 @@
-merge.conflictStyle::
+`merge.conflictStyle`::
 	Specify the style in which conflicted hunks are written out to
 	working tree files upon merge.  The default is "merge", which
-	shows a `<<<<<<<` conflict marker, changes made by one side,
+	shows a +<<<<<<<+ conflict marker, changes made by one side,
 	a `=======` marker, changes made by the other side, and then
-	a `>>>>>>>` marker.  An alternate style, "diff3", adds a `|||||||`
+	a +>>>>>>>+ marker.  An alternate style, "diff3", adds a +|||||||+
 	marker and the original text before the `=======` marker.  The
 	"merge" style tends to produce smaller conflict regions than diff3,
 	both because of the exclusion of the original text, and because
@@ -13,17 +13,17 @@ merge.conflictStyle::
 	the conflict region when those matching lines appear near either
 	the beginning or end of a conflict region.
 
-merge.defaultToUpstream::
+`merge.defaultToUpstream`::
 	If merge is called without any commit argument, merge the upstream
 	branches configured for the current branch by using their last
 	observed values stored in their remote-tracking branches.
 	The values of the `branch.<current branch>.merge` that name the
-	branches at the remote named by `branch.<current branch>.remote`
+	branches at the remote named by `branch.<current-branch>.remote`
 	are consulted, and then they are mapped via `remote.<remote>.fetch`
 	to their corresponding remote-tracking branches, and the tips of
 	these tracking branches are merged. Defaults to true.
 
-merge.ff::
+`merge.ff`::
 	By default, Git does not create an extra merge commit when merging
 	a commit that is a descendant of the current commit. Instead, the
 	tip of the current branch is fast-forwarded. When set to `false`,
@@ -33,42 +33,46 @@ merge.ff::
 	allowed (equivalent to giving the `--ff-only` option from the
 	command line).
 
-merge.verifySignatures::
-	If true, this is equivalent to the --verify-signatures command
+`merge.verifySignatures`::
+	If true, this is equivalent to the `--verify-signatures` command
 	line option. See linkgit:git-merge[1] for details.
 
 include::fmt-merge-msg.adoc[]
 
-merge.renameLimit::
+`merge.renameLimit`::
 	The number of files to consider in the exhaustive portion of
 	rename detection during a merge.  If not specified, defaults
-	to the value of diff.renameLimit.  If neither
-	merge.renameLimit nor diff.renameLimit are specified,
+	to the value of `diff.renameLimit`.  If neither
+	`merge.renameLimit` nor `diff.renameLimit` are specified,
 	currently defaults to 7000.  This setting has no effect if
 	rename detection is turned off.
 
-merge.renames::
-	Whether Git detects renames.  If set to "false", rename detection
-	is disabled. If set to "true", basic rename detection is enabled.
+`merge.renames`::
+	Whether Git detects renames.  If set to `false`, rename detection
+	is disabled. If set to `true`, basic rename detection is enabled.
 	Defaults to the value of diff.renames.
 
-merge.directoryRenames::
+`merge.directoryRenames`::
 	Whether Git detects directory renames, affecting what happens at
 	merge time to new files added to a directory on one side of
 	history when that directory was renamed on the other side of
-	history.  If merge.directoryRenames is set to "false", directory
-	rename detection is disabled, meaning that such new files will be
-	left behind in the old directory.  If set to "true", directory
-	rename detection is enabled, meaning that such new files will be
-	moved into the new directory.  If set to "conflict", a conflict
-	will be reported for such paths.  If merge.renames is false,
-	merge.directoryRenames is ignored and treated as false.  Defaults
-	to "conflict".
-
-merge.renormalize::
+	history. Possible values are:
++
+--
+`false`;; Directory rename detection is disabled, meaning that such new files will be
+	left behind in the old directory.
+`true`;; Directory rename detection is enabled, meaning that such new files will be
+	moved into the new directory.
+`conflict`;; A conflict will be reported for such paths.
+--
++
+If `merge.renames` is `false`, `merge.directoryRenames` is ignored and treated
+as `false`. Defaults to `conflict`.
+
+`merge.renormalize`::
 	Tell Git that canonical representation of files in the
 	repository has changed over time (e.g. earlier commits record
-	text files with CRLF line endings, but recent ones use LF line
+	text files with _CRLF_ line endings, but recent ones use _LF_ line
 	endings).  In such a repository, for each file where a
 	three-way content merge is needed, Git can convert the data
 	recorded in commits to a canonical form before performing a
@@ -76,35 +80,35 @@ merge.renormalize::
 	see section "Merging branches with differing checkin/checkout
 	attributes" in linkgit:gitattributes[5].
 
-merge.stat::
-	Whether to print the diffstat between ORIG_HEAD and the merge result
+`merge.stat`::
+	Whether to print the diffstat between `ORIG_HEAD` and the merge result
 	at the end of the merge.  True by default.
 
-merge.autoStash::
-	When set to true, automatically create a temporary stash entry
+`merge.autoStash`::
+	When set to `true`, automatically create a temporary stash entry
 	before the operation begins, and apply it after the operation
 	ends.  This means that you can run merge on a dirty worktree.
 	However, use with care: the final stash application after a
 	successful merge might result in non-trivial conflicts.
 	This option can be overridden by the `--no-autostash` and
 	`--autostash` options of linkgit:git-merge[1].
-	Defaults to false.
+	Defaults to `false`.
 
-merge.tool::
+`merge.tool`::
 	Controls which merge tool is used by linkgit:git-mergetool[1].
 	The list below shows the valid built-in values.
 	Any other value is treated as a custom merge tool and requires
-	that a corresponding mergetool.<tool>.cmd variable is defined.
+	that a corresponding `mergetool.<tool>.cmd` variable is defined.
 
-merge.guitool::
+`merge.guitool`::
 	Controls which merge tool is used by linkgit:git-mergetool[1] when the
-	-g/--gui flag is specified. The list below shows the valid built-in values.
+	`-g`/`--gui` flag is specified. The list below shows the valid built-in values.
 	Any other value is treated as a custom merge tool and requires that a
-	corresponding mergetool.<guitool>.cmd variable is defined.
+	corresponding `mergetool.<guitool>.cmd` variable is defined.
 
 include::{build_dir}/mergetools-merge.adoc[]
 
-merge.verbosity::
+`merge.verbosity`::
 	Controls the amount of output shown by the recursive merge
 	strategy.  Level 0 outputs nothing except a final error
 	message if conflicts were detected. Level 1 outputs only
@@ -112,15 +116,15 @@ merge.verbosity::
 	above outputs debugging information.  The default is level 2.
 	Can be overridden by the `GIT_MERGE_VERBOSITY` environment variable.
 
-merge.<driver>.name::
+`merge.<driver>.name`::
 	Defines a human-readable name for a custom low-level
 	merge driver.  See linkgit:gitattributes[5] for details.
 
-merge.<driver>.driver::
+`merge.<driver>.driver`::
 	Defines the command that implements a custom low-level
 	merge driver.  See linkgit:gitattributes[5] for details.
 
-merge.<driver>.recursive::
+`merge.<driver>.recursive`::
 	Names a low-level merge driver to be used when
 	performing an internal merge between common ancestors.
 	See linkgit:gitattributes[5] for details.
-- 
gitgitgadget

