Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D716D9AF
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741549519; cv=none; b=IStn8fTprg1re257Utn8FQUroJLp6uoD92EKhw1279aKKP+rpPyQE2yinl/75B5BmA/SreFmdDYOF1u1olUssbyoFqd7bKifpGPgTpKb/U/+2z/8wS/rbC9ubK6Cn5tOz6OLcR9FvveYuaxmquvCy2tFXEWi9AGfAHBLjwexisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741549519; c=relaxed/simple;
	bh=YF7ffQ6TWJmPsk5rr3ivKdBkRW99bPrHrwPVsaA30Lw=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=eZkiTe2erYdHSgTu2NX1OhdmboBP/dnfVDVAFXMBNnfNygTeU08nhjFZOtawgfruPORxMT3B5shtvu+1/KhO/89t4El3uJCb76jdcD2clNsK1zlsNHSVegLQFd88Ecv+vWcZMdQrLX4Osw6JxPX2u+UWI6rO135RN2opkIjAwO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcX1RcZu; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcX1RcZu"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab78e6edb99so540196666b.2
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741549513; x=1742154313; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PZYuASWDp4opOUVRe2eK71+mnzNTSo+OV3HOqwem3JA=;
        b=EcX1RcZuu0ewUqlam6y71tfIjMDEoZ8w1PKKtQOpztYEKGERASQn9HuRYOILuSEGvp
         xiMuXA6vksJ6IHXHXKhUJgSb/PHIXTVwS7IoH8iVBztCC3HQRdUpbHhjoEXjWDE/CL1r
         XJ/h0oWUwEqWCQXD/YNvHcU0ZAuzI4irG/H2QsOaJkF4tLU3nU9ht9p7kJV+H0aLusFi
         bayMT6+aTX6FRlQOxe0CsUpoeWVoDr8IdmSmpz8DRziZSQV8JVI5ynh8c42tLQJAYGeu
         S6VsOSKQDqkWceE96/TCDCVgmk2YumTP84R5D8EtUokocAmeRdj3PFvfORnPoLgLNTrn
         9vYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741549513; x=1742154313;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZYuASWDp4opOUVRe2eK71+mnzNTSo+OV3HOqwem3JA=;
        b=gBORiqKnQZsvBW5HgUsR379unVX+4lbYDAD/fS+ypaFsFhautwoi9v14xsDJWRWDbG
         WgvzkuxT+quPkKcVNaQdOfWoF78VANp91bleMIah9LcRIoT5iTffoPUJWUo2lNBDo2Jg
         ndxqvtGsubinPo/BlxklAAvoZbA7ch1G2x2Gdk3a+knGE/zLbjtyfMOYdbekHwwpF1od
         ryhqIsqm+5WHP3HaIHkOBGWfR8Y2TUTy/gCVkDdOXZWk1pW3d3rEgt9RjqUIm9Mebzbz
         jE7GZWC4Z0pZ0mLLgoO2xNz5JKQLAY8vDW2HMZEQPDR7H/0kxkt/0XW45KQz/Sd5OkBI
         1+4w==
X-Gm-Message-State: AOJu0YxHMxiQYlG4tpzum+ff7yFV8XPB1JZvBB+y3Vu0JTGCSmLf13mJ
	fP1BT/Lw8UbE0JCRPxf76+SkFkN56kWuR2qS2YLKvahjghP1yFmY0cAmTA==
X-Gm-Gg: ASbGnct3GreUXcWHbhLSvYArR128lusYVIeqVKS71/nxIZMGcZILbu9N3lQax+BPXnn
	yWq/rFJ34il/qi1anC0cj4hxtvxH2fMM/8Sf6Pvz+SySHjACJhytmMKynhEDPwUdOK+U9w6X6op
	225FXUF6dEwgv2opzJO7WrqFZtph22nn1zs4KyzcEY642IuXkXPUrqw7xkSSrAqIZz00JYFuqbO
	qJNY/6LERbmGJf5Ur/RKZwwFVoBhNlojnyYcJa0jGqfvZ8emyidfpxtX7g3V2x+1s7QWDoqANRW
	xJtsyjB/9Msqn2Fkf4SjK94tWA5O6ZVlQwmxpF/sXknFxw==
X-Google-Smtp-Source: AGHT+IGXYdmzulbDyjc4vjl53ebxtudLQ8vf9pwta7DfX8CzAq+PHI+oghbMpjkMaQat1R+gOONhwQ==
X-Received: by 2002:a17:907:d9e:b0:abf:6cc9:7ef5 with SMTP id a640c23a62f3a-ac25300a440mr1184879366b.47.1741549512865;
        Sun, 09 Mar 2025 12:45:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943878csm635378866b.23.2025.03.09.12.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 12:45:12 -0700 (PDT)
Message-Id: <pull.1878.git.1741549511665.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 09 Mar 2025 19:45:11 +0000
Subject: [PATCH] doc: add a blank line around block delimiters
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

The documentation is using the historical mode for titles, which is a
setext-style (i.e., two-line) section title.

The issue with this mode is that starting block delimiters (e.g.,
`----`) can be confused with a section title when they are exactly the
same length as the preceding line. In the original documentation, this
is taken care of for English by the writer, but it is not the case for
translations where these delimiters are hidden. A translator can
generate a line that is exactly the same length as the following block
delimiter, which leads to this line being considered as a title.

To safeguard against this issue, add a blank line before and after
block delimiters where block is at root level, else add a "+" line
before block delimiters to link it to the preceding paragraph.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
    doc: add a blank line around block delimiters
    
    This patch is basically a mass-replace of occurrences of paragraphs
    followed by a block delimiter.
    
    The issue arose with a Chinese translation where the length of the
    paragraph turned out to be smaller than the original English and to just
    fit the number of hyphens of the following block starter.
    
    An a longer term, I'm wondering how converting all the asciidoc files to
    the modern style (i.e. atx-style, with variable "=" characters in front
    of the line) would be perceived by the community.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1878%2Fjnavila%2Ffix_empty_line_before_block-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1878/jnavila/fix_empty_line_before_block-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1878

 Documentation/MyFirstContribution.adoc |  1 +
 Documentation/MyFirstObjectWalk.adoc   |  2 ++
 Documentation/ToolsForGit.adoc         |  1 +
 Documentation/git-bisect.adoc          |  1 +
 Documentation/git-cat-file.adoc        |  4 ++--
 Documentation/git-check-attr.adoc      |  6 ++++++
 Documentation/git-column.adoc          |  3 +++
 Documentation/git-cvsserver.adoc       |  4 ++++
 Documentation/git-for-each-ref.adoc    |  2 ++
 Documentation/git-p4.adoc              | 14 ++++++++++++++
 Documentation/git-rebase.adoc          |  3 +++
 Documentation/gitattributes.adoc       | 24 ++++++++++++++++--------
 Documentation/gitcli.adoc              |  2 +-
 Documentation/gitprotocol-common.adoc  |  2 ++
 Documentation/gitweb.adoc              | 11 +++++++++++
 Documentation/gitweb.conf.adoc         |  2 ++
 Documentation/rev-list-options.adoc    |  2 ++
 17 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index e41654c00a6..71dd8557192 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -367,6 +367,7 @@ But as we drill down, we can find that `status_init_config()` wraps a call
 to `git_config()`. Let's modify the code we wrote in the previous commit.
 
 Be sure to include the header to allow you to use `struct wt_status`:
+
 ----
 #include "wt-status.h"
 ----
diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
index dec8afe5b10..e165d34d208 100644
--- a/Documentation/MyFirstObjectWalk.adoc
+++ b/Documentation/MyFirstObjectWalk.adoc
@@ -287,6 +287,7 @@ static void final_rev_info_setup(struct rev_info *rev)
 ====
 Instead of using the shorthand `add_head_to_pending()`, you could do
 something like this:
+
 ----
 	struct setup_revision_opt opt;
 
@@ -295,6 +296,7 @@ something like this:
 	opt.revarg_opt = REVARG_COMMITTISH;
 	setup_revisions(argc, argv, rev, &opt);
 ----
+
 Using a `setup_revision_opt` gives you finer control over your walk's starting
 point.
 ====
diff --git a/Documentation/ToolsForGit.adoc b/Documentation/ToolsForGit.adoc
index ae7690b45d0..a842c133279 100644
--- a/Documentation/ToolsForGit.adoc
+++ b/Documentation/ToolsForGit.adoc
@@ -34,6 +34,7 @@ This is adapted from Linux's suggestion in its CodingStyle document:
 
 - To follow the rules in CodingGuidelines, it's useful to put the following in
 GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:
+
 ----
 ;; note the first part is useful for C editing, too
 ((nil . ((indent-tabs-mode . t)
diff --git a/Documentation/git-bisect.adoc b/Documentation/git-bisect.adoc
index 82f944dc03d..58dbb74a157 100644
--- a/Documentation/git-bisect.adoc
+++ b/Documentation/git-bisect.adoc
@@ -495,6 +495,7 @@ $ git bisect old HEAD~10 # the tenth commit from now is marked as old
 ------------
 +
 or:
++
 ------------
 $ git bisect start --term-old broken --term-new fixed
 $ git bisect fixed
diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index d5890ae3686..30359f5dbdb 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -322,10 +322,10 @@ of `%(objectsize)` bytes), followed by a newline.
 
 For example, `--batch` without a custom format would produce:
 
-------------
+-----------
 <oid> SP <type> SP <size> LF
 <contents> LF
-------------
+-----------
 
 Whereas `--batch-check='%(objectname) %(objecttype)'` would produce:
 
diff --git a/Documentation/git-check-attr.adoc b/Documentation/git-check-attr.adoc
index cb5a6c8f335..503b6446574 100644
--- a/Documentation/git-check-attr.adoc
+++ b/Documentation/git-check-attr.adoc
@@ -76,6 +76,7 @@ EXAMPLES
 --------
 
 In the examples, the following '.gitattributes' file is used:
+
 ---------------
 *.java diff=java -crlf myAttr
 NoMyAttr.java !myAttr
@@ -83,12 +84,14 @@ README caveat=unspecified
 ---------------
 
 * Listing a single attribute:
++
 ---------------
 $ git check-attr diff org/example/MyClass.java
 org/example/MyClass.java: diff: java
 ---------------
 
 * Listing multiple attributes for a file:
++
 ---------------
 $ git check-attr crlf diff myAttr -- org/example/MyClass.java
 org/example/MyClass.java: crlf: unset
@@ -97,6 +100,7 @@ org/example/MyClass.java: myAttr: set
 ---------------
 
 * Listing all attributes for a file:
++
 ---------------
 $ git check-attr --all -- org/example/MyClass.java
 org/example/MyClass.java: diff: java
@@ -104,6 +108,7 @@ org/example/MyClass.java: myAttr: set
 ---------------
 
 * Listing an attribute for multiple files:
++
 ---------------
 $ git check-attr myAttr -- org/example/MyClass.java org/example/NoMyAttr.java
 org/example/MyClass.java: myAttr: set
@@ -111,6 +116,7 @@ org/example/NoMyAttr.java: myAttr: unspecified
 ---------------
 
 * Not all values are equally unambiguous:
++
 ---------------
 $ git check-attr caveat README
 README: caveat: unspecified
diff --git a/Documentation/git-column.adoc b/Documentation/git-column.adoc
index 85fb87c94a4..5a4f2b6fde9 100644
--- a/Documentation/git-column.adoc
+++ b/Documentation/git-column.adoc
@@ -50,6 +50,7 @@ EXAMPLES
 --------
 
 Format data by columns:
++
 ------------
 $ seq 1 24 | git column --mode=column --padding=5
 1      4      7      10     13     16     19     22
@@ -58,6 +59,7 @@ $ seq 1 24 | git column --mode=column --padding=5
 ------------
 
 Format data by rows:
++
 ------------
 $ seq 1 21 | git column --mode=row --padding=5
 1      2      3      4      5      6      7
@@ -66,6 +68,7 @@ $ seq 1 21 | git column --mode=row --padding=5
 ------------
 
 List some tags in a table with unequal column widths:
++
 ------------
 $ git tag --list 'v2.4.*' --column=row,dense
 v2.4.0  v2.4.0-rc0  v2.4.0-rc1  v2.4.0-rc2  v2.4.0-rc3
diff --git a/Documentation/git-cvsserver.adoc b/Documentation/git-cvsserver.adoc
index 4c475efeab9..fe822f571d0 100644
--- a/Documentation/git-cvsserver.adoc
+++ b/Documentation/git-cvsserver.adoc
@@ -125,9 +125,11 @@ creation in your platform (e.g. mkpasswd in Linux, encrypt in OpenBSD or
 pwhash in NetBSD) and paste it in the right location.
 
 Then provide your password via the pserver method, for example:
+
 ------
    cvs -d:pserver:someuser:somepassword@server:/path/repo.git co <HEAD_name>
 ------
+
 No special setup is needed for SSH access, other than having Git tools
 in the PATH. If you have clients that do not accept the CVS_SERVER
 environment variable, you can rename 'git-cvsserver' to `cvs`.
@@ -138,6 +140,7 @@ CVS_SERVER directly in CVSROOT like
 ------
    cvs -d ":ext;CVS_SERVER=git cvsserver:user@server/path/repo.git" co <HEAD_name>
 ------
+
 This has the advantage that it will be saved in your 'CVS/Root' files and
 you don't need to worry about always setting the correct environment
 variable.  SSH users restricted to 'git-shell' don't need to override the default
@@ -168,6 +171,7 @@ All configuration variables can also be overridden for a specific method of
 access. Valid method names are "ext" (for SSH access) and "pserver". The
 following example configuration would disable pserver access while still
 allowing access over SSH.
+
 ------
    [gitcvs]
         enabled=0
diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index ffb97e62c2d..5ef89fc0fe3 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -441,6 +441,7 @@ Ref: %(*refname)
 
 A simple example showing the use of shell eval on the output,
 demonstrating the use of --shell.  List the prefixes of all heads:
+
 ------------
 #!/bin/sh
 
@@ -455,6 +456,7 @@ done
 
 A bit more elaborate report on tags, demonstrating that the format
 may be an entire script:
+
 ------------
 #!/bin/sh
 
diff --git a/Documentation/git-p4.adoc b/Documentation/git-p4.adoc
index de5ee6748e3..f97b786bf98 100644
--- a/Documentation/git-p4.adoc
+++ b/Documentation/git-p4.adoc
@@ -80,6 +80,7 @@ This:
 
 To reproduce the entire p4 history in Git, use the '@all' modifier on
 the depot path:
+
 ------------
 $ git p4 clone //depot/path/project@all
 ------------
@@ -89,19 +90,23 @@ Sync
 ~~~~
 As development continues in the p4 repository, those changes can
 be included in the Git repository using:
+
 ------------
 $ git p4 sync
 ------------
+
 This command finds new changes in p4 and imports them as Git commits.
 
 P4 repositories can be added to an existing Git repository using
 'git p4 sync' too:
+
 ------------
 $ mkdir repo-git
 $ cd repo-git
 $ git init
 $ git p4 sync //path/in/your/perforce/depot
 ------------
+
 This imports the specified depot into
 'refs/remotes/p4/master' in an existing Git repository.  The
 `--branch` option can be used to specify a different branch to
@@ -125,6 +130,7 @@ and merge them with local uncommitted changes.  Often, the p4 repository
 is the ultimate location for all code, thus a rebase workflow makes
 sense.  This command does 'git p4 sync' followed by 'git rebase' to move
 local commits on top of updated p4 changes.
+
 ------------
 $ git p4 rebase
 ------------
@@ -140,16 +146,19 @@ will be created and populated if it does not already exist.
 
 To submit all changes that are in the current Git branch but not in
 the 'p4/master' branch, use:
+
 ------------
 $ git p4 submit
 ------------
 
 To specify a branch other than the current one, use:
+
 ------------
 $ git p4 submit topicbranch
 ------------
 
 To specify a single commit or a range of commits, use:
+
 ------------
 $ git p4 submit --commit <sha1>
 $ git p4 submit --commit <sha1..sha1>
@@ -510,20 +519,24 @@ when cloning or syncing to have 'git p4' automatically find
 subdirectories in p4, and to generate these as branches in Git.
 
 For example, if the P4 repository structure is:
+
 ----
 //depot/main/...
 //depot/branch1/...
 ----
 
 And "p4 branch -o branch1" shows a View line that looks like:
+
 ----
 //depot/main/... //depot/branch1/...
 ----
 
 Then this 'git p4 clone' command:
+
 ----
 git p4 clone --detect-branches //depot@all
 ----
+
 produces a separate branch in 'refs/remotes/p4/' for //depot/main,
 called 'master', and one for //depot/branch1 called 'depot/branch1'.
 
@@ -536,6 +549,7 @@ simple p4 branch specification, where the "source" and "destination" are
 the path elements in the p4 repository.  The example above relied on the
 presence of the p4 branch.  Without p4 branches, the same result will
 occur with:
+
 ----
 git init depot
 cd depot
diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 153cb69a4f8..956d3048f5a 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -1107,10 +1107,12 @@ In that case, the fix is easy because 'git rebase' knows to skip
 changes that are already present in the new upstream (unless
 `--reapply-cherry-picks` is given). So if you say
 (assuming you're on 'topic')
+
 ------------
     $ git rebase subsystem
 ------------
 you will end up with the fixed history
+
 ------------
     o---o---o---o---o---o---o---o  master
 				 \
@@ -1145,6 +1147,7 @@ of the old 'subsystem', for example:
 
 You can then transplant the old `subsystem..topic` to the new tip by
 saying (for the reflog case, and assuming you are on 'topic' already):
+
 ------------
     $ git rebase --onto subsystem subsystem@{1}
 ------------
diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index 7eaca899725..ba8aa111b12 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -531,13 +531,14 @@ must not send any response before it received the content and the
 final flush packet. Also note that the "value" of a "key=value" pair
 can contain the "=" character whereas the key would never contain
 that character.
-------------------------
+
+-----------------------
 packet:          git> command=smudge
 packet:          git> pathname=path/testfile.dat
 packet:          git> 0000
 packet:          git> CONTENT
 packet:          git> 0000
-------------------------
+-----------------------
 
 The filter is expected to respond with a list of "key=value" pairs
 terminated with a flush packet. If the filter does not experience
@@ -559,6 +560,7 @@ packet:          git< 0000  # empty list, keep "status=success" unchanged!
 
 If the result content is empty then the filter is expected to respond
 with a "success" status and a flush packet to signal the empty content.
+
 ------------------------
 packet:          git< status=success
 packet:          git< 0000
@@ -568,14 +570,16 @@ packet:          git< 0000  # empty list, keep "status=success" unchanged!
 
 In case the filter cannot or does not want to process the content,
 it is expected to respond with an "error" status.
-------------------------
+
+-----------------------
 packet:          git< status=error
 packet:          git< 0000
-------------------------
+-----------------------
 
 If the filter experiences an error during processing, then it can
 send the status "error" after the content was (partially or
 completely) sent.
+
 ------------------------
 packet:          git< status=success
 packet:          git< 0000
@@ -589,10 +593,11 @@ In case the filter cannot or does not want to process the content
 as well as any future content for the lifetime of the Git process,
 then it is expected to respond with an "abort" status at any point
 in the protocol.
-------------------------
+
+-----------------------
 packet:          git< status=abort
 packet:          git< 0000
-------------------------
+-----------------------
 
 Git neither stops nor restarts the filter process in case the
 "error"/"abort" status is set. However, Git sets its exit code
@@ -613,7 +618,8 @@ flag "can-delay" after the filter command and pathname. This flag
 denotes that the filter can delay filtering the current blob (e.g. to
 compensate network latencies) by responding with no content but with
 the status "delayed" and a flush packet.
-------------------------
+
+-----------------------
 packet:          git> command=smudge
 packet:          git> pathname=path/testfile.dat
 packet:          git> can-delay=1
@@ -622,7 +628,7 @@ packet:          git> CONTENT
 packet:          git> 0000
 packet:          git< status=delayed
 packet:          git< 0000
-------------------------
+-----------------------
 
 If the filter supports the "delay" capability then it must support the
 "list_available_blobs" command. If Git sends this command, then the
@@ -647,10 +653,12 @@ packet:          git< status=success
 packet:          git< 0000
 ------------------------
 
+
 After Git received the pathnames, it will request the corresponding
 blobs again. These requests contain a pathname and an empty content
 section. The filter is expected to respond with the smudged content
 in the usual way as explained above.
+
 ------------------------
 packet:          git> command=smudge
 packet:          git> pathname=path/testfile.dat
diff --git a/Documentation/gitcli.adoc b/Documentation/gitcli.adoc
index 04193ec9078..1ea681b59da 100644
--- a/Documentation/gitcli.adoc
+++ b/Documentation/gitcli.adoc
@@ -209,13 +209,13 @@ $ git foo -o Arg
 
 However, this is *NOT* allowed for switches with an optional value, where the
 'stuck' form must be used:
+
 ----------------------------
 $ git describe --abbrev HEAD     # correct
 $ git describe --abbrev=10 HEAD  # correct
 $ git describe --abbrev 10 HEAD  # NOT WHAT YOU MEANT
 ----------------------------
 
-
 NOTES ON FREQUENTLY CONFUSED OPTIONS
 ------------------------------------
 
diff --git a/Documentation/gitprotocol-common.adoc b/Documentation/gitprotocol-common.adoc
index cdc9d6e7075..b4a5316ca4b 100644
--- a/Documentation/gitprotocol-common.adoc
+++ b/Documentation/gitprotocol-common.adoc
@@ -21,11 +21,13 @@ ABNF Notation
 
 ABNF notation as described by RFC 5234 is used within the protocol documents,
 except the following replacement core rules are used:
+
 ----
   HEXDIG    =  DIGIT / "a" / "b" / "c" / "d" / "e" / "f"
 ----
 
 We also define the following common rules:
+
 ----
   NUL       =  %x00
   zero-id   =  40*"0"
diff --git a/Documentation/gitweb.adoc b/Documentation/gitweb.adoc
index 5e2b491ec22..4261f9e235d 100644
--- a/Documentation/gitweb.adoc
+++ b/Documentation/gitweb.adoc
@@ -103,6 +103,7 @@ You can generate the projects list index file using the project_index action
 "Generating projects list using gitweb" section below.
 
 Example contents:
+
 -----------------------------------------------------------------------
 foo.git       Joe+R+Hacker+<joe@example.com>
 foo/bar.git   O+W+Ner+<owner@example.org>
@@ -124,6 +125,7 @@ Generating projects list using gitweb
 
 We assume that GITWEB_CONFIG has its default Makefile value, namely
 'gitweb_config.perl'. Put the following in 'gitweb_make_index.perl' file:
+
 ----------------------------------------------------------------------------
 read_config_file("gitweb_config.perl");
 $projects_list = $projectroot;
@@ -518,12 +520,14 @@ rules.
 If you use the rewrite rules from the example you *might* also need
 something like the following in your gitweb configuration file
 (`/etc/gitweb.conf` following example):
+
 ----------------------------------------------------------------------------
 @stylesheets = ("/some/absolute/path/gitweb.css");
 $my_uri    = "/";
 $home_link = "/";
 $per_request_config = 1;
 ----------------------------------------------------------------------------
+
 Nowadays though gitweb should create HTML base tag when needed (to set base
 URI for relative links), so it should work automatically.
 
@@ -535,6 +539,7 @@ Apache virtual host and gitweb configuration files in the following way.
 
 The virtual host configuration (in Apache configuration file) should look
 like this:
+
 --------------------------------------------------------------------------
 <VirtualHost *:80>
     ServerName    git.example.org
@@ -575,9 +580,11 @@ like this:
 Here actual project root is passed to gitweb via `GITWEB_PROJECT_ROOT`
 environment variable from a web server, so you need to put the following
 line in gitweb configuration file (`/etc/gitweb.conf` in above example):
+
 --------------------------------------------------------------------------
 $projectroot = $ENV{'GITWEB_PROJECTROOT'} || "/pub/git";
 --------------------------------------------------------------------------
+
 *Note* that this requires to be set for each request, so either
 `$per_request_config` must be false, or the above must be put in code
 referenced by `$per_request_config`;
@@ -604,9 +611,11 @@ the third and the fourth.
 PATH_INFO usage
 ~~~~~~~~~~~~~~~
 If you enable PATH_INFO usage in gitweb by putting
+
 ----------------------------------------------------------------------------
 $feature{'pathinfo'}{'default'} = [1];
 ----------------------------------------------------------------------------
+
 in your gitweb configuration file, it is possible to set up your server so
 that it consumes and produces URLs in the form
 
@@ -636,6 +645,7 @@ complementary static files (stylesheet, favicon, JavaScript):
 	</Directory>
 </VirtualHost>
 ----------------------------------------------------------------------------
+
 The rewrite rule guarantees that existing static files will be properly
 served, whereas any other URL will be passed to gitweb as PATH_INFO
 parameter.
@@ -647,6 +657,7 @@ for fetching" section).  A possible workaround for the latter is the
 following: in your project root dir (e.g. `/pub/git`) have the projects
 named *without* a .git extension (e.g. `/pub/git/project` instead of
 `/pub/git/project.git`) and configure Apache as follows:
+
 ----------------------------------------------------------------------------
 <VirtualHost *:80>
 	ServerAlias git.example.com
diff --git a/Documentation/gitweb.conf.adoc b/Documentation/gitweb.conf.adoc
index 85983587fcf..1348e9b1250 100644
--- a/Documentation/gitweb.conf.adoc
+++ b/Documentation/gitweb.conf.adoc
@@ -603,6 +603,7 @@ Many gitweb features can be enabled (or disabled) and configured using the
 
 Each `%feature` hash element is a hash reference and has the following
 structure:
+
 ----------------------------------------------------------------------
 "<feature-name>" => {
 	"sub" => <feature-sub-(subroutine)>,
@@ -613,6 +614,7 @@ structure:
 Some features cannot be overridden per project.  For those
 features the structure of appropriate `%feature` hash element has a simpler
 form:
+
 ----------------------------------------------------------------------
 "<feature-name>" => {
 	"override" => 0,
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 785c0786e0c..9d020e305a7 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -429,6 +429,7 @@ filtered for `foo`, they look different and equal, respectively.)
 In the following, we will always refer to the same example history to
 illustrate the differences between simplification settings.  We assume
 that you are filtering for a file `foo` in this commit graph:
+
 -----------------------------------------------------------------------
 	  .-A---M---N---O---P---Q
 	 /     /   /   /   /   /
@@ -436,6 +437,7 @@ that you are filtering for a file `foo` in this commit graph:
 	 \   /   /   /   /   /
 	  `-------------'   X
 -----------------------------------------------------------------------
+
 The horizontal line of history A---Q is taken to be the first parent of
 each merge.  The commits are:
 

base-commit: e969bc875963a10890d61ba84eab3a460bd9e535
-- 
gitgitgadget
