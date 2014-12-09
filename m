From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFD/PATCH] Documentation: mention category
Date: Tue,  9 Dec 2014 12:21:02 +0100
Message-ID: <538d1a10bda3793ea10ec6f7de43de371d17e709.1418123780.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 12:21:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyIqw-00068r-Hb
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 12:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756642AbaLILVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 06:21:09 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40995 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754732AbaLILVE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2014 06:21:04 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 1E28020A45
	for <git@vger.kernel.org>; Tue,  9 Dec 2014 06:21:04 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 09 Dec 2014 06:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:subject:date
	:message-id; s=smtpout; bh=srfbifdatJrWUYP0fx5KGse8m/o=; b=OeE95
	wGevxLKVBns+uJmC+DFfwA7lsGPghkUVjKKhVU5CsCjCTUI+9e1+VRAAVWrgP+Zo
	W3ANGK8reCwV2S//xy715JW88z5ai3tOQjFgTIEOWDGHw0s4oKwwUSwbI1nzniAf
	Xm5GRggtpa9DCVpQ4NIUxa5n1F065CuTZslXYs=
X-Sasl-enc: 7WylU7IzIUwRf9wtHaaQTKNd/ZbtpKVzvBIjDsVxUaMB 1418124063
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5ADE268018D;
	Tue,  9 Dec 2014 06:21:03 -0500 (EST)
X-Mailer: git-send-email 2.2.0.345.g7041aac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261119>

Quite a few users seem to get confused about which commands to use
as the main git interface. While `git --help' gives an overview,
users seem to discover commands from the man page which does not
tell them to stay away from plumbing commands first.

Introduce a category section in each man page which helps users
decide whether to read on at all.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This is just a suggestion to give new users better orientation. The naming
for the categories is up for discussion, of course. The categorization
itself is taken from command-list.txt and translated via:

--->%---
	case "$category" in
	ancillaryinterrogators*)
		out="Ancillary interrogator"
		;;
	ancillarymanipulator*)
		out="Ancillary manipulator"
		;;
	foreignscminterface*)
		out="Interface to foreign SCM"
		;;
	
	mainporcelain*)
		out="Main user interface command (porcelain)"
		;;
	plumbing*)
		out="Low level command for script writers (plumbing)"
		;;
	purehelpers*)
		out="Helper command for script writers"
		;;
	sync*)
		out="Commands used internally for synching repositories"
		;;
	*)
		out=""
		echo "What to do with $command - $category"
		;;
	esac
---<%---

Rather than changing git-foo.txt, we could do the substitution magic
from Documentation/Makefile, of course, to keep man pages and command-list
in sync. Although this would keep me from submitting the final series
with 1 patch per file :)

 Documentation/git-add.txt                | 4 ++++
 Documentation/git-am.txt                 | 4 ++++
 Documentation/git-annotate.txt           | 4 ++++
 Documentation/git-apply.txt              | 4 ++++
 Documentation/git-archimport.txt         | 4 ++++
 Documentation/git-archive.txt            | 4 ++++
 Documentation/git-bisect.txt             | 4 ++++
 Documentation/git-blame.txt              | 4 ++++
 Documentation/git-branch.txt             | 4 ++++
 Documentation/git-bundle.txt             | 4 ++++
 Documentation/git-cat-file.txt           | 4 ++++
 Documentation/git-check-attr.txt         | 4 ++++
 Documentation/git-check-ignore.txt       | 4 ++++
 Documentation/git-check-mailmap.txt      | 4 ++++
 Documentation/git-check-ref-format.txt   | 4 ++++
 Documentation/git-checkout-index.txt     | 4 ++++
 Documentation/git-checkout.txt           | 4 ++++
 Documentation/git-cherry-pick.txt        | 4 ++++
 Documentation/git-cherry.txt             | 4 ++++
 Documentation/git-citool.txt             | 4 ++++
 Documentation/git-clean.txt              | 4 ++++
 Documentation/git-clone.txt              | 4 ++++
 Documentation/git-column.txt             | 4 ++++
 Documentation/git-commit-tree.txt        | 4 ++++
 Documentation/git-commit.txt             | 4 ++++
 Documentation/git-config.txt             | 4 ++++
 Documentation/git-count-objects.txt      | 4 ++++
 Documentation/git-credential-cache.txt   | 4 ++++
 Documentation/git-credential-store.txt   | 4 ++++
 Documentation/git-credential.txt         | 4 ++++
 Documentation/git-cvsexportcommit.txt    | 4 ++++
 Documentation/git-cvsimport.txt          | 4 ++++
 Documentation/git-cvsserver.txt          | 4 ++++
 Documentation/git-daemon.txt             | 4 ++++
 Documentation/git-describe.txt           | 4 ++++
 Documentation/git-diff-files.txt         | 4 ++++
 Documentation/git-diff-index.txt         | 4 ++++
 Documentation/git-diff-tree.txt          | 4 ++++
 Documentation/git-diff.txt               | 4 ++++
 Documentation/git-difftool.txt           | 4 ++++
 Documentation/git-fast-export.txt        | 4 ++++
 Documentation/git-fast-import.txt        | 4 ++++
 Documentation/git-fetch-pack.txt         | 4 ++++
 Documentation/git-fetch.txt              | 4 ++++
 Documentation/git-filter-branch.txt      | 4 ++++
 Documentation/git-fmt-merge-msg.txt      | 4 ++++
 Documentation/git-for-each-ref.txt       | 4 ++++
 Documentation/git-format-patch.txt       | 4 ++++
 Documentation/git-fsck.txt               | 4 ++++
 Documentation/git-gc.txt                 | 4 ++++
 Documentation/git-get-tar-commit-id.txt  | 4 ++++
 Documentation/git-grep.txt               | 4 ++++
 Documentation/git-gui.txt                | 4 ++++
 Documentation/git-hash-object.txt        | 4 ++++
 Documentation/git-help.txt               | 4 ++++
 Documentation/git-http-backend.txt       | 4 ++++
 Documentation/git-http-fetch.txt         | 4 ++++
 Documentation/git-http-push.txt          | 4 ++++
 Documentation/git-imap-send.txt          | 4 ++++
 Documentation/git-index-pack.txt         | 4 ++++
 Documentation/git-init.txt               | 4 ++++
 Documentation/git-instaweb.txt           | 4 ++++
 Documentation/git-interpret-trailers.txt | 4 ++++
 Documentation/git-log.txt                | 4 ++++
 Documentation/git-ls-files.txt           | 4 ++++
 Documentation/git-ls-remote.txt          | 4 ++++
 Documentation/git-ls-tree.txt            | 4 ++++
 Documentation/git-mailinfo.txt           | 4 ++++
 Documentation/git-mailsplit.txt          | 4 ++++
 Documentation/git-merge-base.txt         | 4 ++++
 Documentation/git-merge-file.txt         | 4 ++++
 Documentation/git-merge-index.txt        | 4 ++++
 Documentation/git-merge-one-file.txt     | 4 ++++
 Documentation/git-merge-tree.txt         | 4 ++++
 Documentation/git-merge.txt              | 4 ++++
 Documentation/git-mergetool.txt          | 4 ++++
 Documentation/git-mktag.txt              | 4 ++++
 Documentation/git-mktree.txt             | 4 ++++
 Documentation/git-mv.txt                 | 4 ++++
 Documentation/git-name-rev.txt           | 4 ++++
 Documentation/git-notes.txt              | 4 ++++
 Documentation/git-p4.txt                 | 4 ++++
 Documentation/git-pack-objects.txt       | 4 ++++
 Documentation/git-pack-redundant.txt     | 4 ++++
 Documentation/git-pack-refs.txt          | 4 ++++
 Documentation/git-parse-remote.txt       | 4 ++++
 Documentation/git-patch-id.txt           | 4 ++++
 Documentation/git-prune-packed.txt       | 4 ++++
 Documentation/git-prune.txt              | 4 ++++
 Documentation/git-pull.txt               | 4 ++++
 Documentation/git-push.txt               | 4 ++++
 Documentation/git-quiltimport.txt        | 4 ++++
 Documentation/git-read-tree.txt          | 4 ++++
 Documentation/git-rebase.txt             | 4 ++++
 Documentation/git-receive-pack.txt       | 4 ++++
 Documentation/git-reflog.txt             | 4 ++++
 Documentation/git-relink.txt             | 4 ++++
 Documentation/git-remote.txt             | 4 ++++
 Documentation/git-repack.txt             | 4 ++++
 Documentation/git-replace.txt            | 4 ++++
 Documentation/git-request-pull.txt       | 4 ++++
 Documentation/git-rerere.txt             | 4 ++++
 Documentation/git-reset.txt              | 4 ++++
 Documentation/git-rev-list.txt           | 4 ++++
 Documentation/git-rev-parse.txt          | 4 ++++
 Documentation/git-revert.txt             | 4 ++++
 Documentation/git-rm.txt                 | 4 ++++
 Documentation/git-send-email.txt         | 4 ++++
 Documentation/git-send-pack.txt          | 4 ++++
 Documentation/git-sh-i18n.txt            | 4 ++++
 Documentation/git-sh-setup.txt           | 4 ++++
 Documentation/git-shell.txt              | 4 ++++
 Documentation/git-shortlog.txt           | 4 ++++
 Documentation/git-show-branch.txt        | 4 ++++
 Documentation/git-show-index.txt         | 4 ++++
 Documentation/git-show-ref.txt           | 4 ++++
 Documentation/git-show.txt               | 4 ++++
 Documentation/git-stash.txt              | 4 ++++
 Documentation/git-status.txt             | 4 ++++
 Documentation/git-stripspace.txt         | 4 ++++
 Documentation/git-submodule.txt          | 4 ++++
 Documentation/git-svn.txt                | 4 ++++
 Documentation/git-symbolic-ref.txt       | 4 ++++
 Documentation/git-tag.txt                | 4 ++++
 Documentation/git-unpack-file.txt        | 4 ++++
 Documentation/git-unpack-objects.txt     | 4 ++++
 Documentation/git-update-index.txt       | 4 ++++
 Documentation/git-update-ref.txt         | 4 ++++
 Documentation/git-update-server-info.txt | 4 ++++
 Documentation/git-upload-archive.txt     | 4 ++++
 Documentation/git-upload-pack.txt        | 4 ++++
 Documentation/git-var.txt                | 4 ++++
 Documentation/git-verify-commit.txt      | 4 ++++
 Documentation/git-verify-pack.txt        | 4 ++++
 Documentation/git-verify-tag.txt         | 4 ++++
 Documentation/git-whatchanged.txt        | 4 ++++
 Documentation/git-write-tree.txt         | 4 ++++
 Documentation/gitk.txt                   | 4 ++++
 Documentation/gitweb.txt                 | 4 ++++
 139 files changed, 556 insertions(+)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 9631526..b6a8bc6 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -13,6 +13,10 @@ SYNOPSIS
 	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
 	  [--] [<pathspec>...]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 This command updates the index using the current content found in
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 9adce37..b2bbe77 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -18,6 +18,10 @@ SYNOPSIS
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort)
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Splits mail messages in a mailbox into commit log message,
diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
index 05fd482..f787838 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git annotate' [options] file [revision]
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 Annotates each line in the given file with information from the commit
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index f605327..5eab3fa 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -18,6 +18,10 @@ SYNOPSIS
 	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
 	  [--verbose] [<patch>...]
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Reads the supplied diff output (i.e. "a patch") and applies it to files.
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index 163b9f6..604b3ff 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D depth] [-t tempdir]
                <archive/branch>[:<git-branch>] ...
 
+CATEGORY
+--------
+Interface to foreign SCM
+
 DESCRIPTION
 -----------
 Imports a project from one or more Arch repositories. It will follow branches
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index cfa1e4e..b286d3e 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -14,6 +14,10 @@ SYNOPSIS
 	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
 	      [<path>...]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Creates an archive of the specified format containing the tree
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 4cb52a7..79e4526 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git bisect' <subcommand> <options>
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 The command takes various subcommands, and different options depending
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 9f23a86..88c014f 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
 	    [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>] [--] <file>
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 311b336..f751bc9 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -19,6 +19,10 @@ SYNOPSIS
 'git branch' (-d | -D) [-r] <branchname>...
 'git branch' --edit-description [<branchname>]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 0417562..21980ae 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -14,6 +14,10 @@ SYNOPSIS
 'git bundle' list-heads <file> [<refname>...]
 'git bundle' unbundle <file> [<refname>...]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f6a16f4..9bf2c61 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git cat-file' (-t | -s | -e | -p | <type> | --textconv ) <object>
 'git cat-file' (--batch | --batch-check) < <list-of-objects>
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 In its first form, the command provides the content or the type of an object in
diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 00e2aa2..fe45715 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git check-attr' [-a | --all | attr...] [--] pathname...
 'git check-attr' --stdin [-z] [-a | --all | attr...] < <list-of-paths>
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 For every pathname, this command will list if each attribute is 'unspecified',
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index ee2e091..142560b 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git check-ignore' [options] pathname...
 'git check-ignore' [options] --stdin < <list-of-paths>
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-check-mailmap.txt b/Documentation/git-check-mailmap.txt
index 39028ee..5eb9fc7 100644
--- a/Documentation/git-check-mailmap.txt
+++ b/Documentation/git-check-mailmap.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git check-mailmap' [options] <contact>...
 
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index fc02959..4868ccb 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -13,6 +13,10 @@ SYNOPSIS
        <refname>
 'git check-ref-format' --branch <branchname-shorthand>
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 Checks if a given 'refname' is acceptable, and exits with a non-zero
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 4d33e7b..cec0677 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -15,6 +15,10 @@ SYNOPSIS
 		   [-z] [--stdin]
 		   [--] [<file>...]
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Will copy all files listed from the index to the working directory
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 33ad2ad..69ed9db 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -15,6 +15,10 @@ SYNOPSIS
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Updates files in the working tree to match the version in the index
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 1c03c79..f301edf 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -14,6 +14,10 @@ SYNOPSIS
 'git cherry-pick' --quit
 'git cherry-pick' --abort
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 0ea921a..f0751f6 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git cherry' [-v] [<upstream> [<head> [<limit>]]]
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 Determine whether there are commits in `<head>..<upstream>` that are
diff --git a/Documentation/git-citool.txt b/Documentation/git-citool.txt
index c7a11c3..bd585e9 100644
--- a/Documentation/git-citool.txt
+++ b/Documentation/git-citool.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git citool'
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 A Tcl/Tk based graphical interface to review modified files, stage
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 94b6d19..1a6e068 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f1f2a3f..7c1c496 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -17,6 +17,10 @@ SYNOPSIS
 	  [--recursive | --recurse-submodules] [--] <repository>
 	  [<directory>]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
index 03d1846..368dec9 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 'git column' [--command=<name>] [--[raw-]mode=<mode>] [--width=<width>]
 	     [--indent=<string>] [--nl=<string>] [--padding=<n>]
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 This command formats its input into multiple columns.
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index a469eab..56c8cb1 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -14,6 +14,10 @@ SYNOPSIS
 		  [(-F <file>)...] <tree>
 
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 This is usually not what an end user wants to run directly.  See
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 1e74b75..06129f8 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -15,6 +15,10 @@ SYNOPSIS
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [-S[<key-id>]] [--] [<file>...]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Stores the current contents of the index in a new commit along
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 9dfa1a5..e324c50 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -25,6 +25,10 @@ SYNOPSIS
 'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
 'git config' [<file-option>] -e | --edit
 
+CATEGORY
+--------
+Ancillary manipulator
+
 DESCRIPTION
 -----------
 You can query/set/replace/unset options with this command. The name is
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index 2ff3568..702bedc 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git count-objects' [-v] [-H | --human-readable]
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 This counts the number of unpacked object files and disk space consumed by
diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 89b7306..9fa2d4a 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 git config credential.helper 'cache [options]'
 -----------------------------
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index bc97071..a3bb7b3 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 git config credential.helper 'store [options]'
 -------------------
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index b211440..45b2e8e 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 git credential <fill|approve|reject>
 ------------------
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 00154b6..fd4ca97 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -13,6 +13,10 @@ SYNOPSIS
 	[-w cvsworkdir] [-W] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
 
 
+CATEGORY
+--------
+Interface to foreign SCM
+
 DESCRIPTION
 -----------
 Exports a commit from Git to a CVS checkout, making it easier
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 00a0679..d3791ca 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -16,6 +16,10 @@ SYNOPSIS
 	      [-r <remote>] [-R] [<CVS_module>]
 
 
+CATEGORY
+--------
+Interface to foreign SCM
+
 DESCRIPTION
 -----------
 *WARNING:* `git cvsimport` uses cvsps version 2, which is considered
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 4961f1a..12f029c 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -57,6 +57,10 @@ access still needs to be enabled by the `gitcvs.enabled` config option
 unless '--export-all' was given, too.
 
 
+CATEGORY
+--------
+Interface to foreign SCM
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index a69b361..b9780b9 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -22,6 +22,10 @@ SYNOPSIS
 	      [--user=<user> [--group=<group>]]]
 	     [<directory>...]
 
+CATEGORY
+--------
+Commands used internally for synching repositories
+
 DESCRIPTION
 -----------
 A really simple TCP Git daemon that normally listens on port "DEFAULT_GIT_PORT"
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index d20ca40..076fbb3 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] <commit-ish>...
 'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 The command finds the most recent tag that is reachable from a
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index 906774f..3e619ae 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git diff-files' [-q] [-0|-1|-2|-3|-c|--cc] [<common diff options>] [<path>...]
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Compares the files in the working tree and the index.  When paths
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index a86cf62..2699479 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git diff-index' [-m] [--cached] [<common diff options>] <tree-ish> [<path>...]
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Compares the content and mode of the blobs found in a tree object
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 1439486..13cc130 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -13,6 +13,10 @@ SYNOPSIS
 	      [-t] [-r] [-c | --cc] [--root] [<common diff options>]
 	      <tree-ish> [<tree-ish>] [<path>...]
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Compares the content and mode of the blobs found via two tree objects.
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index bbab35f..c34f697 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -15,6 +15,10 @@ SYNOPSIS
 'git diff' [options] <blob> <blob>
 'git diff' [options] [--no-index] [--] <path> <path>
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Show changes between the working tree and the index or a tree, changes
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 333cf6f..9f0e125 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git difftool' [<options>] [<commit> [<commit>]] [--] [<path>...]
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 'git difftool' is a Git command that allows you to compare and edit files
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 929e496..3db709e 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git fast-export [options]' | 'git fast-import'
 
+CATEGORY
+--------
+Ancillary manipulator
+
 DESCRIPTION
 -----------
 This program dumps the given revisions in a form suitable to be piped
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index f71fb01..ff54241 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 frontend | 'git fast-import' [options]
 
+CATEGORY
+--------
+Ancillary manipulator
+
 DESCRIPTION
 -----------
 This program is usually not what the end user wants to run directly.
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 93b5067..65b6b3f 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -14,6 +14,10 @@ SYNOPSIS
 	[--depth=<n>] [--no-progress]
 	[-v] <repository> [<refs>...]
 
+CATEGORY
+--------
+Commands used internally for synching repositories
+
 DESCRIPTION
 -----------
 Usually you would want to use 'git fetch', which is a
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 8deb614..eebdd06 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -15,6 +15,10 @@ SYNOPSIS
 'git fetch' --all [<options>]
 
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Fetch branches and/or tags (collectively, "refs") from one or more
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 73fd9e8..32cfbd0 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -16,6 +16,10 @@ SYNOPSIS
 	[--original <namespace>] [-d <directory>] [-f | --force]
 	[--] [<rev-list options>...]
 
+CATEGORY
+--------
+Ancillary manipulator
+
 DESCRIPTION
 -----------
 Lets you rewrite Git revision history by rewriting the branches mentioned
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index bb1232a..be0c92d 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] <$GIT_DIR/FETCH_HEAD
 'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] -F <file>
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 Takes the list of merged objects on stdin and produces a suitable
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 4240875..7bf43bf 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c0fd470..769d6ea 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -25,6 +25,10 @@ SYNOPSIS
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 25c431d..32ea7fb 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -13,6 +13,10 @@ SYNOPSIS
 	 [--[no-]full] [--strict] [--verbose] [--lost-found]
 	 [--[no-]dangling] [--[no-]progress] [<object>*]
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 Verifies the connectivity and validity of the objects in the database.
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 273c466..21025b6 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Runs a number of housekeeping tasks within the current repository,
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
index 1e2a20d..60ebd5e 100644
--- a/Documentation/git-get-tar-commit-id.txt
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git get-tar-commit-id' < <tarfile>
 
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 Acts as a filter, extracting the commit ID stored in archives created by
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 31811f1..d1fc9ce 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -28,6 +28,10 @@ SYNOPSIS
 	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Look for specified patterns in the tracked files in the work tree, blobs
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 8144527..84ddd2f 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git gui' [<command>] [arguments]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 A Tcl/Tk based graphical user interface to Git.  'git gui' focuses
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 02c1f12..28e59cd 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin] [--] <file>...
 'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters] < <list-of-paths>
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Computes the object ID value for an object with specified type
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 3956525..588dff1 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 'git help' [-a|--all] [-g|--guide]
 	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index d422ba4..4869057 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git http-backend'
 
+CATEGORY
+--------
+Commands used internally for synching repositories
+
 DESCRIPTION
 -----------
 A simple CGI program to serve the contents of a Git repository to Git
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 21a33d2..d8927aa 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit> <url>
 
+CATEGORY
+--------
+Commands used internally for synching repositories
+
 DESCRIPTION
 -----------
 Downloads a remote Git repository via HTTP.
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 2e67362..4ef4167 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git http-push' [--all] [--dry-run] [--force] [--verbose] <url> <ref> [<ref>...]
 
+CATEGORY
+--------
+Commands used internally for synching repositories
+
 DESCRIPTION
 -----------
 Sends missing objects to remote repository, and updates the
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 77aacf1..262e5e3 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git imap-send' [-v] [-q] [--[no-]curl]
 
 
+CATEGORY
+--------
+Interface to foreign SCM
+
 DESCRIPTION
 -----------
 This command uploads a mailbox generated with 'git format-patch'
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 7a4e055..1df3932 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -14,6 +14,10 @@ SYNOPSIS
                  [<pack-file>]
 
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Reads a packed archive (.pack) from the specified file, and
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 369f889..deb2a71 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -14,6 +14,10 @@ SYNOPSIS
 	  [--shared[=<permissions>]] [directory]
 
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index f3eef51..6dafc98 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -12,6 +12,10 @@ SYNOPSIS
                [--browser=<browser>]
 'git instaweb' [--start] [--stop] [--restart]
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 A simple script to set up `gitweb` and a web server for browsing the local
diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index d6d9231..94f3479 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git interpret-trailers' [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 Help adding 'trailers' lines, that look similar to RFC 822 e-mail
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 1f7bc67..b85d172 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git log' [<options>] [<revision range>] [[\--] <path>...]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Shows the commit logs.
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index e26f01f..c190f0c 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -19,6 +19,10 @@ SYNOPSIS
 		[--error-unmatch] [--with-tree=<tree-ish>]
 		[--full-name] [--abbrev] [--] [<file>...]
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 This merges the file listing in the directory cache index with the
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 2e22915..8b69dce 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git ls-remote' [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]
 	      [--exit-code] <repository> [<refs>...]
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Displays references available in a remote repository along with the associated
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 16e87fd..7fd6c14 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -13,6 +13,10 @@ SYNOPSIS
 	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
 	    <tree-ish> [<path>...]
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Lists the contents of a given tree object, like what "/bin/ls -a" does
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 164a3c6..2146840 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] [--[no-]scissors] <msg> <patch>
 
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 Reads a single e-mail message from the standard input, and
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index 4d1b871..36f14fa 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git mailsplit' [-b] [-f<nn>] [-d<prec>] [--keep-cr] -o<directory> [--] [(<mbox>|<Maildir>)...]
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 Splits a mbox file or a Maildir into a list of files: "0001" "0002" ..  in the
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 808426f..a0b8a90 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -15,6 +15,10 @@ SYNOPSIS
 'git merge-base' --independent <commit>...
 'git merge-base' --fork-point <ref> [<commit>]
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index d2fc12e..2d66401 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -14,6 +14,10 @@ SYNOPSIS
 	[--[no-]diff3] <current-file> <base-file> <other-file>
 
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 'git merge-file' incorporates all changes that lead from the `<base-file>`
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 02676fb..2184287 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>*)
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 This looks up the <file>(s) in the index and, if there are any merge
diff --git a/Documentation/git-merge-one-file.txt b/Documentation/git-merge-one-file.txt
index 04e803d..694fe9f 100644
--- a/Documentation/git-merge-one-file.txt
+++ b/Documentation/git-merge-one-file.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git merge-one-file'
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 This is the standard helper program to use with 'git merge-index'
diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 58731c1..5d003b5 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git merge-tree' <base-tree> <branch1> <branch2>
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 Reads three tree-ish, and output trivial merge results and
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index cf2c374..c489d3d 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -15,6 +15,10 @@ SYNOPSIS
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Incorporates changes from the named commits (since the time their
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index e846c2e..160e79e 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git mergetool' [--tool=<tool>] [-y | --[no-]prompt] [<file>...]
 
+CATEGORY
+--------
+Ancillary manipulator
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 3ca158b..87d2328 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git mktag' < signature_file
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Reads a tag contents on standard input and creates a tag object
diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 5c6ebdf..8f9ad4e 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git mktree' [-z] [--missing] [--batch]
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Reads standard input in non-recursive `ls-tree` output format, and creates
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index e453132..4e6778f 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git mv' <options>... <args>...
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Move or rename a file, directory or symlink.
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index ca28fb8..802fbfb 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git name-rev' [--tags] [--refs=<pattern>]
 	       ( --all | --stdin | <commit-ish>... )
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Finds symbolic names suitable for human digestion for revisions given in any
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 851518d..84a5b4a 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -22,6 +22,10 @@ SYNOPSIS
 'git notes' get-ref
 
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Adds, removes, or reads notes attached to objects, without touching
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 6ab5f94..ae93e5d 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -15,6 +15,10 @@ SYNOPSIS
 'git p4 submit' [<submit options>] [<master branch name>]
 
 
+CATEGORY
+--------
+Interface to foreign SCM
+
 DESCRIPTION
 -----------
 This command provides a way to interact with p4 repositories
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index d2d8f47..b538f6f 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -16,6 +16,10 @@ SYNOPSIS
 	[--keep-true-parents] < object-list
 
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Reads list of objects from the standard input, and writes a packed
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
index f2869da..b5c3e92 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git pack-redundant' [ --verbose ] [ --alt-odb ] < --all | .pack filename ... >
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 This program computes which packs in your repository
diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index 154081f..c7eb11c 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git pack-refs' [--all] [--no-prune]
 
+CATEGORY
+--------
+Ancillary manipulator
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
index a45ea1e..b9ca527 100644
--- a/Documentation/git-parse-remote.txt
+++ b/Documentation/git-parse-remote.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 '. "$(git --exec-path)/git-parse-remote"'
 
+CATEGORY
+--------
+Commands used internally for synching repositories
+
 DESCRIPTION
 -----------
 This script is included in various scripts to supply
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 31efc58..79cf162 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git patch-id' [--stable | --unstable] < <patch>
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 A "patch ID" is nothing but a sum of SHA-1 of the file diffs associated with a
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 9fed59a..2c2b602 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git prune-packed' [-n|--dry-run] [-q|--quiet]
 
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 This program searches the `$GIT_OBJECT_DIRECTORY` for all objects that currently
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 7a493c8..11d0733 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git prune' [-n] [-v] [--expire <expire>] [--] [<head>...]
 
+CATEGORY
+--------
+Ancillary manipulator
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 200eb22..e3a4086 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git pull' [options] [<repository> [<refspec>...]]
 
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index b17283a..56b4a72 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -15,6 +15,10 @@ SYNOPSIS
 	   [--force-with-lease[=<refname>[:<expect>]]]
 	   [--no-verify] [<repository> [<refspec>...]]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index d64388c..a1a56da 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git quiltimport' [--dry-run | -n] [--author <author>] [--patches <dir>]
 
 
+CATEGORY
+--------
+Interface to foreign SCM
+
 DESCRIPTION
 -----------
 Applies a quilt patchset onto the current Git branch, preserving
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index fa1d557..b8c93d5 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -15,6 +15,10 @@ SYNOPSIS
 		(--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])
 
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Reads the tree information given by <tree-ish> into the index,
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 924827d..a965eaf 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -14,6 +14,10 @@ SYNOPSIS
 	--root [<branch>]
 'git rebase' --continue | --skip | --abort | --edit-todo
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 If <branch> is specified, 'git rebase' will perform an automatic
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 9016960..8c0ee58 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git-receive-pack' <directory>
 
+CATEGORY
+--------
+Commands used internally for synching repositories
+
 DESCRIPTION
 -----------
 Invoked by 'git send-pack' and updates the repository with the
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 70791b9..87eddeb 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git reflog' <subcommand> <options>
 
+CATEGORY
+--------
+Ancillary manipulator
+
 DESCRIPTION
 -----------
 The command takes various subcommands, and different options
diff --git a/Documentation/git-relink.txt b/Documentation/git-relink.txt
index 3b33c99..3ade32f 100644
--- a/Documentation/git-relink.txt
+++ b/Documentation/git-relink.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git relink' [--safe] <dir>... <master_dir>
 
+CATEGORY
+--------
+Ancillary manipulator
+
 DESCRIPTION
 -----------
 This will scan 1 or more object repositories and look for objects in common
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index cb103c8..5e76d5c 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -22,6 +22,10 @@ SYNOPSIS
 'git remote prune' [-n | --dry-run] <name>...
 'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
 
+CATEGORY
+--------
+Ancillary manipulator
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 4786a78..2ac89fd 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [--window=<n>] [--depth=<n>]
 
+CATEGORY
+--------
+Ancillary manipulator
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 8fff598..9d08d70 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -14,6 +14,10 @@ SYNOPSIS
 'git replace' -d <object>...
 'git replace' [--format=<format>] [-l [<pattern>]]
 
+CATEGORY
+--------
+Ancillary manipulator
+
 DESCRIPTION
 -----------
 Adds a 'replace' reference in `refs/replace/` namespace.
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index 283577b..ddd77bc 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git request-pull' [-p] <start> <url> [<end>]
 
+CATEGORY
+--------
+Interface to foreign SCM
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index a62227f..a27db48 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git rerere' ['clear'|'forget' <pathspec>|'diff'|'remaining'|'status'|'gc']
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 25432d9..7e520eb 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]
 'git reset' [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 In the first and second form, copy entries from <tree-ish> to the index.
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index fd7f8b5..3629841 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -58,6 +58,10 @@ SYNOPSIS
 	     [ \--use-bitmap-index ]
 	     <commit>... [ \-- <paths>... ]
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index d6de42f..7675ce2 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git rev-parse' [ --option ] <args>...
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index cceb5f2..0da41fa 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -13,6 +13,10 @@ SYNOPSIS
 'git revert' --quit
 'git revert' --abort
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index f1efc11..a200089 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <file>...
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Remove files from the index, or from the working tree and the index.
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index a60776e..3b091dc 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git send-email' [options] <file|directory|rev-list options>...
 
 
+CATEGORY
+--------
+Interface to foreign SCM
+
 DESCRIPTION
 -----------
 Takes the patches given on the command line and emails them out.
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 2a0de42..23aaff6 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]
 
+CATEGORY
+--------
+Commands used internally for synching repositories
+
 DESCRIPTION
 -----------
 Usually you would want to use 'git push', which is a
diff --git a/Documentation/git-sh-i18n.txt b/Documentation/git-sh-i18n.txt
index 60cf49c..c72a123 100644
--- a/Documentation/git-sh-i18n.txt
+++ b/Documentation/git-sh-i18n.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 '. "$(git --exec-path)/git-sh-i18n"'
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 4f67c4c..1cf7d63 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 '. "$(git --exec-path)/git-sh-setup"'
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index e4bdd22..76b8ce7 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -13,6 +13,10 @@ SYNOPSIS
 'git clone' <user>`@localhost:/path/to/repo.git`
 'ssh' <user>`@localhost`
 
+CATEGORY
+--------
+Commands used internally for synching repositories
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 31af7f2..bdbd984 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 git log --pretty=short | 'git shortlog' [<options>]
 'git shortlog' [<options>] [<revision range>] [[\--] <path>...]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Summarizes 'git log' output in a format suitable for inclusion
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index b91d4e5..0df8f12 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -15,6 +15,10 @@ SYNOPSIS
 		[(<rev> | <glob>)...]
 'git show-branch' (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index fbdc8ad..6abcca7 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git show-index' < idx-file
 
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Reads given idx file for packed Git archive created with
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2a6f89b..bbfc496 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -13,6 +13,10 @@ SYNOPSIS
 	     [--heads] [--] [<pattern>...]
 'git show-ref' --exclude-existing[=<pattern>] < ref-list
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 4e617e6..e1fe73c 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git show' [options] <object>...
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Shows one or more objects (blobs, trees, tags and commits).
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 375213f..35eb032 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -19,6 +19,10 @@ SYNOPSIS
 'git stash' create [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 4d8d530..0af1b84 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git status' [<options>...] [--] [<pathspec>...]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Displays paths that have differences between the index file and the
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 6c6e989..a7b147e 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git stripspace' [-s | --strip-comments] < input
 'git stripspace' [-c | --comment-lines] < input
 
+CATEGORY
+--------
+Helper command for script writers
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 8e6af65..57804e8 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -23,6 +23,10 @@ SYNOPSIS
 'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
 
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Submodules allow foreign repositories to be embedded within
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 39e9a18..1639842 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git svn' <command> [options] [arguments]
 
+CATEGORY
+--------
+Interface to foreign SCM
+
 DESCRIPTION
 -----------
 'git svn' is a simple conduit for changesets between Subversion and Git.
diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index ef68ad2..05db29e 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git symbolic-ref' [-q] [--short] <name>
 'git symbolic-ref' --delete [-q] <name>
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Given one argument, reads which branch head the given symbolic
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index e953ba4..76f8741 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -17,6 +17,10 @@ SYNOPSIS
 	[<pattern>...]
 'git tag' -v <tagname>...
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
index e9f148a..df1188c 100644
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 [verse]
 'git unpack-file' <blob>
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Creates a file holding the contents of the blob specified by sha1. It
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index 12cb108..0c25839 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git unpack-objects' [-n] [-q] [-r] [--strict] < <pack-file>
 
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Read a packed archive (.pack) from the standard input, expanding
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 929869b..8b846b7 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -23,6 +23,10 @@ SYNOPSIS
 	     [--verbose]
 	     [--] [<file>...]
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Modifies the index or directory cache. Each file mentioned is updated
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index c8f5ae5..3b03e8c 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>] | --stdin [-z])
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Given two arguments, stores the <newvalue> in the <ref>, possibly
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index bd0e364..c9d47cc 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git update-server-info' [--force]
 
+CATEGORY
+--------
+Commands used internally for synching repositories
+
 DESCRIPTION
 -----------
 A dumb server that does not do on-the-fly pack generations must
diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.txt
index cbef61b..63834e5 100644
--- a/Documentation/git-upload-archive.txt
+++ b/Documentation/git-upload-archive.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git upload-archive' <directory>
 
+CATEGORY
+--------
+Commands used internally for synching repositories
+
 DESCRIPTION
 -----------
 Invoked by 'git archive --remote' and sends a generated archive to the
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 0abc806..1d621ef 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git-upload-pack' [--strict] [--timeout=<n>] <directory>
 
+CATEGORY
+--------
+Commands used internally for synching repositories
+
 DESCRIPTION
 -----------
 Invoked by 'git fetch-pack', learns what
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 44ff954..3a407b9 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git var' ( -l | <variable> )
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Prints a Git logical variable.
diff --git a/Documentation/git-verify-commit.txt b/Documentation/git-verify-commit.txt
index 9413e28..7d5e73e 100644
--- a/Documentation/git-verify-commit.txt
+++ b/Documentation/git-verify-commit.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git verify-commit' <commit>...
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 Validates the gpg signature created by 'git commit -S'.
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index 526ba7b..2fa3e20 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -12,6 +12,10 @@ SYNOPSIS
 'git verify-pack' [-v|--verbose] [-s|--stat-only] [--] <pack>.idx ...
 
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Reads given idx file for packed Git archive created with the
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index f88ba96..7da9f2b 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'git verify-tag' <tag>...
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 Validates the gpg signature created by 'git tag'.
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index 8b63ceb..637e94e 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git whatchanged' <option>...
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
index f22041a..cbc33be 100644
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -11,6 +11,10 @@ SYNOPSIS
 [verse]
 'git write-tree' [--missing-ok] [--prefix=<prefix>/]
 
+CATEGORY
+--------
+Low level command for script writers (plumbing)
+
 DESCRIPTION
 -----------
 Creates a tree object using the current index. The name of the new
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 7ae50aa..c7b0f51 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -10,6 +10,10 @@ SYNOPSIS
 [verse]
 'gitk' [<options>] [<revision range>] [\--] [<path>...]
 
+CATEGORY
+--------
+Main user interface command (porcelain)
+
 DESCRIPTION
 -----------
 Displays changes in a repository or a selected set of commits. This includes
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index cd9c895..42b0cde 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -12,6 +12,10 @@ This would configure and start your web server, and run web browser pointing to
 gitweb.
 
 
+CATEGORY
+--------
+Ancillary interrogator
+
 DESCRIPTION
 -----------
 Gitweb provides a web interface to Git repositories.  Its features include:
-- 
2.2.0.345.g7041aac
