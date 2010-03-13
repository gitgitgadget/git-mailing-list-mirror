From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH/RFC 09/12] docs: use <commit> instead of <commit-ish>
Date: Fri, 12 Mar 2010 23:53:01 -0500
Message-ID: <1268455984-19061-10-git-send-email-lodatom@gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 05:54:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqJMk-0007qX-N3
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 05:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933720Ab0CMExx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 23:53:53 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:41161 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757383Ab0CMExV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 23:53:21 -0500
Received: by mail-qy0-f179.google.com with SMTP id 9so1844182qyk.5
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=x970FQCOp9Rdt2n6HW1+KHPOPq+jsZg1VQwccaiowKo=;
        b=bfWS7Cs7dASo6rR6shpoT/Y/MXngOipx4ypo9rXjQHofHLjCz2ccjn6ntAiPhM2kN5
         ueIMVeTV5/AzAUcJBWf+fPImC18b+hyOi7o8wDQKo+oM6RkzeYuxf6NJGTjFOLWeO5Uh
         wQtLaVJbdHtuXKFiZHqISxL+ZU97fkeYFXw/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ns3EC1HBsBMSSjJBrW1+WR7DAIKFx5k7sJPOnptCI2nM02fm6BbML4Wnto6r1BIyDU
         KgOYvpNZITn2k5S/U0xzoh5MDtwwBE3MJrAteRtMoImVsMeIEi1/Wb+KBsflrHlkZvX4
         aR439R8xJB5R16q9A755jU02uN2O4PY7ITyk0=
Received: by 10.224.35.7 with SMTP id n7mr765184qad.279.1268456000833;
        Fri, 12 Mar 2010 20:53:20 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1694110qyk.10.2010.03.12.20.53.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:53:20 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142082>

There exist no commands that accept a <commit> but not a <commit-ish>,
so there is no reason to use the latter term anymore.  Instead, use
<commit> everywhere the term <commit-ish>, <committish>, commit-ish, or
comittish was used.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
This was a little harder than the removal of tree-ish, since commit-ish 
was used not only in the documentation but in the code.  I tried to 
replace the term without losing meaning, but the comments in particular 
should be examined to see if they are just as clear as before.

The following commands already use the term <commit>, but actually 
accept a <commit-ish>:
	bisect, branch, cherry-pick, commit, merge, tag, diff, difftool, 
	format-patch, merge-base, rebase, reset, rev-list, revert

The only commands left that do not accept a commit-ish are:
	http-fetch accepts a <commit-id>, as noted previously
	commit-tree accepts an old <commit> (no tag objects)

 Documentation/git-describe.txt               |   14 +++++++-------
 Documentation/git-fast-import.txt            |   22 +++++++++++-----------
 Documentation/git-name-rev.txt               |    2 +-
 Documentation/git-rebase.txt                 |    2 +-
 Documentation/git-shortlog.txt               |    2 +-
 Documentation/git.txt                        |   15 ++++++---------
 Documentation/gitcli.txt                     |    2 +-
 Documentation/howto/revert-branch-rebase.txt |    2 +-
 builtin/describe.c                           |    4 ++--
 builtin/merge.c                              |    2 +-
 builtin/revert.c                             |    4 ++--
 contrib/examples/git-merge.sh                |    2 +-
 contrib/examples/git-reset.sh                |    2 +-
 contrib/examples/git-revert.sh               |    4 ++--
 fast-import.c                                |   16 ++++++++--------
 remote.c                                     |    4 ++--
 16 files changed, 48 insertions(+), 51 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 6fc5323..f272fa6 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -9,7 +9,7 @@ git-describe - Show the most recent tag that is reachable from a commit
 SYNOPSIS
 --------
 [verse]
-'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] <committish>...
+'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] <commit>...
 'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
 
 DESCRIPTION
@@ -26,8 +26,8 @@ see the -a and -s options to linkgit:git-tag[1].
 
 OPTIONS
 -------
-<committish>...::
-	Committish object names to describe.
+<commit>...::
+	Commit object names to describe.
 
 --dirty[=<mark>]::
 	Describe the working tree.
@@ -57,7 +57,7 @@ OPTIONS
 
 --candidates=<n>::
 	Instead of considering only the 10 most recent tags as
-	candidates to describe the input committish consider
+	candidates to describe the input commit consider
 	up to <n> candidates.  Increasing <n> above 10 will take
 	slightly longer but may produce a more accurate result.
 	An <n> of 0 will cause only exact matches to be output.
@@ -136,7 +136,7 @@ be sufficient to disambiguate these commits.
 SEARCH STRATEGY
 ---------------
 
-For each committish supplied, 'git describe' will first look for
+For each commit supplied, 'git describe' will first look for
 a tag which tags exactly that commit.  Annotated tags will always
 be preferred over lightweight tags, and tags with newer dates will
 always be preferred over tags with older dates.  If an exact match
@@ -145,10 +145,10 @@ is found, its name will be output and searching will stop.
 If an exact match was not found, 'git describe' will walk back
 through the commit history to locate an ancestor commit which
 has been tagged.  The ancestor's tag will be output along with an
-abbreviation of the input committish's SHA1.
+abbreviation of the input commit's SHA1.
 
 If multiple tags were found during the walk then the tag which
-has the fewest commits different from the input committish will be
+has the fewest commits different from the input commit will be
 selected and output.  Here fewest commits different is defined as
 the number of commits which would be shown by `git log tag..input`
 will be the smallest number of commits possible.
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 19082b0..bdf369a 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -340,8 +340,8 @@ change to the project.
 	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
 	data
-	('from' SP <committish> LF)?
-	('merge' SP <committish> LF)?
+	('from' SP <commit> LF)?
+	('merge' SP <commit> LF)?
 	(filemodify | filedelete | filecopy | filerename | filedeleteall | notemodify)*
 	LF?
 ....
@@ -418,9 +418,9 @@ as the current commit on that branch is automatically assumed to
 be the first ancestor of the new commit.
 
 As `LF` is not valid in a Git refname or SHA-1 expression, no
-quoting or escaping syntax is supported within `<committish>`.
+quoting or escaping syntax is supported within `<commit>`.
 
-Here `<committish>` is any of the following:
+Here `<commit>` is any of the following:
 
 * The name of an existing branch already in fast-import's internal branch
   table.  If fast-import doesn't know the name, it's treated as a SHA-1
@@ -465,7 +465,7 @@ additional ancestors (forming a 16-way merge).  For this reason
 it is suggested that frontends do not use more than 15 `merge`
 commands per commit; 16, if starting a new, empty branch.
 
-Here `<committish>` is any of the commit specification expressions
+Here `<commit>` is any of the commit specification expressions
 also accepted by `from` (see above).
 
 `filemodify`
@@ -632,7 +632,7 @@ External data format::
 	commit that is to be annotated.
 +
 ....
-	'N' SP <dataref> SP <committish> LF
+	'N' SP <dataref> SP <commit> LF
 ....
 +
 Here `<dataref>` can be either a mark reference (`:<idnum>`)
@@ -645,13 +645,13 @@ Inline data format::
 	command.
 +
 ....
-	'N' SP 'inline' SP <committish> LF
+	'N' SP 'inline' SP <commit> LF
 	data
 ....
 +
 See below for a detailed description of the `data` command.
 
-In both formats `<committish>` is any of the commit specification
+In both formats `<commit>` is any of the commit specification
 expressions also accepted by `from` (see above).
 
 `mark`
@@ -682,7 +682,7 @@ lightweight (non-annotated) tags see the `reset` command below.
 
 ....
 	'tag' SP <name> LF
-	'from' SP <committish> LF
+	'from' SP <commit> LF
 	'tagger' (SP <name>)? SP LT <email> GT SP <when> LF
 	data
 ....
@@ -727,11 +727,11 @@ branch from an existing commit without creating a new commit.
 
 ....
 	'reset' SP <ref> LF
-	('from' SP <committish> LF)?
+	('from' SP <commit> LF)?
 	LF?
 ....
 
-For a detailed description of `<ref>` and `<committish>` see above
+For a detailed description of `<ref>` and `<commit>` see above
 under `commit` and `from`.
 
 The `LF` after the command is optional (it used to be required).
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 2108237..40af544 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git name-rev' [--tags] [--refs=<pattern>]
-	       ( --all | --stdin | <committish>... )
+	       ( --all | --stdin | <commit>... )
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 823f2a4..e32c393 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -168,7 +168,7 @@ would result in the removal of commits F and G:
 
 This is useful if F and G were flawed in some way, or should not be
 part of topicA.  Note that the argument to --onto and the <upstream>
-parameter can be any valid commit-ish.
+parameter can be any valid <commit>.
 
 In case of conflict, 'git rebase' will stop at the first problematic commit
 and leave conflict markers in the tree.  You can use 'git diff' to locate
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index dfd4d0c..61dc039 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 git log --pretty=short | 'git shortlog' [-h] [-n] [-s] [-e] [-w]
-'git shortlog' [-n|--numbered] [-s|--summary] [-e|--email] [-w[<width>[,<indent1>[,<indent2>]]]] [<committish>...]
+'git shortlog' [-n|--numbered] [-s|--summary] [-e|--email] [-w[<width>[,<indent1>[,<indent2>]]]] [<commit>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index eb87edb..b7c89f9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -426,8 +426,13 @@ Identifier Terminology
 	Indicates a tag-type <object>.  This is an annotated tag object, as
 	opposed to <tagname>, which can refer to any type of object.
 
+<rev>::
 <commit>::
-	Indicates a commit-type <object>.
+	Indicates a commit-type <object>, or a <tag> that points at a <commit>.
+	A command that takes a <commit> argument ultimately wants to
+	operate on a commit object but automatically dereferences objects
+	until it finds a commit.
+	A <rev> is another name for a <commit>.
 
 <tree>::
 	Indicates a tree-type <object>, or a <tag> or <commit> that points at
@@ -438,14 +443,6 @@ Identifier Terminology
 <blob>::
 	Indicates a blob-type <object>.
 
-<rev>::
-<commit-ish>::
-	Indicates a <commit>, or a <tag> that points at a <commit-ish>.
-	A command that takes a <commit-ish> argument ultimately wants to
-	operate on a commit object but automatically dereferences objects
-	until it finds a commit.
-	A <rev> is another name for a <commit-ish>.
-
 <type>::
 	Indicates that an object type is required.
 	Currently one of: `blob`, `tree`, `commit`, or `tag`.
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 6928724..de0630f 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -81,7 +81,7 @@ couple of magic command line options:
 +
 ---------------------------------------------
 $ git describe -h
-usage: git describe [options] <committish>*
+usage: git describe [options] <commit>*
 
     --contains            find the tag that comes after the commit
     --debug               debug search strategy on stderr
diff --git a/Documentation/howto/revert-branch-rebase.txt b/Documentation/howto/revert-branch-rebase.txt
index 8c32da6..5272bb0 100644
--- a/Documentation/howto/revert-branch-rebase.txt
+++ b/Documentation/howto/revert-branch-rebase.txt
@@ -160,7 +160,7 @@ $ git pull . master
 Packing 0 objects
 Unpacking 0 objects
 
-* committish: e3a693c...	refs/heads/master from .
+* commit: e3a693c...	refs/heads/master from .
 Trying to merge e3a693c... into 8c1f5f0... using 10d781b...
 Committed merge 7fb9b7262a1d1e0a47bbfdcbbcf50ce0635d3f8f
  cache.h        |    8 ++++----
diff --git a/builtin/describe.c b/builtin/describe.c
index 71be2a9..4ece73f 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -11,7 +11,7 @@
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char * const describe_usage[] = {
-	"git describe [options] <committish>*",
+	"git describe [options] <commit>*",
 	"git describe [options] --dirty",
 	NULL
 };
@@ -386,7 +386,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			dirty = NULL;
 		describe("HEAD", 1);
 	} else if (dirty) {
-		die("--dirty is incompatible with committishes");
+		die("--dirty is incompatible with commits");
 	} else {
 		while (argc-- > 0) {
 			describe(*argv++, argc == 0);
diff --git a/builtin/merge.c b/builtin/merge.c
index 3aaec7b..8d62424 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -940,7 +940,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * This could be traditional "merge <msg> HEAD <commit>..."  and
 	 * the way we can tell it is to see if the second token is HEAD,
 	 * but some people might have misused the interface and used a
-	 * committish that is the same as HEAD there instead.
+	 * <commit> that is the same as HEAD there instead.
 	 * Traditional format never would have "-m" so it is an
 	 * additional safety measure to check for it.
 	 */
diff --git a/builtin/revert.c b/builtin/revert.c
index eff5268..e06d2a0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -26,12 +26,12 @@
  */
 
 static const char * const revert_usage[] = {
-	"git revert [options] <commit-ish>",
+	"git revert [options] <commit>",
 	NULL
 };
 
 static const char * const cherry_pick_usage[] = {
-	"git cherry-pick [options] <commit-ish>",
+	"git cherry-pick [options] <commit>",
 	NULL
 };
 
diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 8f617fc..5aeee46 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -221,7 +221,7 @@ fi
 
 # This could be traditional "merge <msg> HEAD <commit>..."  and the
 # way we can tell it is to see if the second token is HEAD, but some
-# people might have misused the interface and used a committish that
+# people might have misused the interface and used a <commit> that
 # is the same as HEAD there instead.  Traditional format never would
 # have "-m" so it is an additional safety measure to check for it.
 
diff --git a/contrib/examples/git-reset.sh b/contrib/examples/git-reset.sh
index bafeb52..d287a80 100755
--- a/contrib/examples/git-reset.sh
+++ b/contrib/examples/git-reset.sh
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
 #
-USAGE='[--mixed | --soft | --hard]  [<commit-ish>] [ [--] <paths>...]'
+USAGE='[--mixed | --soft | --hard]  [<commit>] [ [--] <paths>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 set_reflog_action "reset $*"
diff --git a/contrib/examples/git-revert.sh b/contrib/examples/git-revert.sh
index 49f0032..c543add 100755
--- a/contrib/examples/git-revert.sh
+++ b/contrib/examples/git-revert.sh
@@ -9,12 +9,12 @@ case "$0" in
 	test -t 0 && edit=-e
 	replay=
 	me=revert
-	USAGE='[--edit | --no-edit] [-n] <commit-ish>' ;;
+	USAGE='[--edit | --no-edit] [-n] <commit>' ;;
 *-cherry-pick* )
 	replay=t
 	edit=
 	me=cherry-pick
-	USAGE='[--edit] [-n] [-r] [-x] <commit-ish>'  ;;
+	USAGE='[--edit] [-n] [-r] [-x] <commit>'  ;;
 * )
 	echo >&2 "What are you talking about?"
 	exit 1 ;;
diff --git a/fast-import.c b/fast-import.c
index 309f2c5..08afdc3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -22,8 +22,8 @@ Format of STDIN stream:
     ('author' (sp name)? sp '<' email '>' sp when lf)?
     'committer' (sp name)? sp '<' email '>' sp when lf
     commit_msg
-    ('from' sp committish lf)?
-    ('merge' sp committish lf)*
+    ('from' sp commit lf)?
+    ('merge' sp commit lf)*
     file_change*
     lf?;
   commit_msg ::= data;
@@ -41,18 +41,18 @@ Format of STDIN stream:
   file_obm ::= 'M' sp mode sp (hexsha1 | idnum) sp path_str lf;
   file_inm ::= 'M' sp mode sp 'inline' sp path_str lf
     data;
-  note_obm ::= 'N' sp (hexsha1 | idnum) sp committish lf;
-  note_inm ::= 'N' sp 'inline' sp committish lf
+  note_obm ::= 'N' sp (hexsha1 | idnum) sp commit lf;
+  note_inm ::= 'N' sp 'inline' sp commit lf
     data;
 
   new_tag ::= 'tag' sp tag_str lf
-    'from' sp committish lf
+    'from' sp commit lf
     ('tagger' (sp name)? sp '<' email '>' sp when lf)?
     tag_msg;
   tag_msg ::= data;
 
   reset_branch ::= 'reset' sp ref_str lf
-    ('from' sp committish lf)?
+    ('from' sp commit lf)?
     lf?;
 
   checkpoint ::= 'checkpoint' lf
@@ -91,7 +91,7 @@ Format of STDIN stream:
      # stream formatting is: \, " and LF.  Otherwise these values
      # are UTF8.
      #
-  committish  ::= (ref_str | hexsha1 | sha1exp_str | idnum);
+  commit      ::= (ref_str | hexsha1 | sha1exp_str | idnum);
   ref_str     ::= ref;
   sha1exp_str ::= sha1exp;
   tag_str     ::= tag;
@@ -2288,7 +2288,7 @@ static void note_change_n(struct branch *b, unsigned char old_fanout)
 	if (*p++ != ' ')
 		die("Missing space after SHA1: %s", command_buf.buf);
 
-	/* <committish> */
+	/* <commit> */
 	s = lookup_branch(p);
 	if (s) {
 		hashcpy(commit_sha1, s->sha1);
diff --git a/remote.c b/remote.c
index c70181c..3c5f8c6 100644
--- a/remote.c
+++ b/remote.c
@@ -1277,7 +1277,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *     to overwrite it; you would not know what you are losing
 		 *     otherwise.
 		 *
-		 * (3) if both new and old are commit-ish, and new is a
+		 * (3) if both new and old are <commit>'s, and new is a
 		 *     descendant of old, it is OK.
 		 *
 		 * (4) regardless of all of the above, removing :B is
@@ -1475,7 +1475,7 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
 	struct commit_list *list, *used;
 	int found = 0;
 
-	/* Both new and old must be commit-ish and new is descendant of
+	/* Both new and old must be <commit>'s and new is descendant of
 	 * old.  Otherwise we require --force.
 	 */
 	o = deref_tag(parse_object(old_sha1), NULL, 0);
-- 
1.7.0.2
