From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.3.5
Date: Wed, 31 Oct 2007 15:40:01 -0700
Message-ID: <7vpryugb7i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 23:40:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InMEd-00082O-Kx
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 23:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbXJaWkM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 18:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754076AbXJaWkM
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 18:40:12 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:41943 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbXJaWkJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2007 18:40:09 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E84F52EF;
	Wed, 31 Oct 2007 18:40:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E2EBE90786;
	Wed, 31 Oct 2007 18:40:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62894>

The latest maintenance release GIT 1.5.3.5 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.3.5.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.3.5.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.3.5.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.3.5-1.$arch.rpm	(RPM)

There are many fixes including a handful bugs that led to
segfaults.

----------------------------------------------------------------
GIT v1.5.3.5 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.5.3.4
--------------------

 * Comes with git-gui 0.8.4.

 * "git-config" silently ignored options after --list; now it will
   error out with a usage message.

 * "git-config --file" failed if the argument used a relative path
   as it changed directories before opening the file.

 * "git-config --file" now displays a proper error message if it
   cannot read the file specified on the command line.

 * "git-config", "git-diff", "git-apply" failed if run from a
   subdirectory with relative GIT_DIR and GIT_WORK_TREE set.

 * "git-blame" crashed if run during a merge conflict.

 * "git-add -i" did not handle single line hunks correctly.

 * "git-rebase -i" and "git-stash apply" failed if external diff
   drivers were used for one or more files in a commit.  They now
   avoid calling the external diff drivers.

 * "git-log --follow" did not work unless diff generation (e.g. -p)
   was also requested.

 * "git-log --follow -B" did not work at all.  Fixed.

 * "git-log -M -B" did not correctly handle cases of very large files
   being renamed and replaced by very small files in the same commit.

 * "git-log" printed extra newlines between commits when a diff
   was generated internally (e.g. -S or --follow) but not displayed.

 * "git-push" error message is more helpful when pushing to a
   repository with no matching refs and none specified.

 * "git-push" now respects + (force push) on wildcard refspecs,
   matching the behavior of git-fetch.

 * "git-filter-branch" now updates the working directory when it
   has finished filtering the current branch.

 * "git-instaweb" no longer fails on Mac OS X.

 * "git-cvsexportcommit" didn't always create new parent directories
   before trying to create new child directories.  Fixed.

 * "git-fetch" printed a scary (but bogus) error message while
   fetching a tag that pointed to a tree or blob.  The error did
   not impact correctness, only user perception.  The bogus error
   is no longer printed.

 * "git-ls-files --ignored" did not properly descend into non-ignored
   directories that themselves contained ignored files if d_type
   was not supported by the filesystem.  This bug impacted systems
   such as AFS.  Fixed.

 * Git segfaulted when reading an invalid .gitattributes file.  Fixed.

 * post-receive-email example hook fixed was fixed for
   non-fast-forward updates.

 * Documentation updates for supported (but previously undocumented)
   options of "git-archive" and "git-reflog".

 * "make clean" no longer deletes the configure script that ships
   with the git tarball, making multiple architecture builds easier.

 * "git-remote show origin" spewed a warning message from Perl
   when no remote is defined for the current branch via
   branch.<name>.remote configuration settings.

 * Building with NO_PERL_MAKEMAKER excessively rebuilt contents
   of perl/ subdirectory by rewriting perl.mak.

 * http.sslVerify configuration settings were not used in scripted
   Porcelains.

 * "git-add" leaked a bit of memory while scanning for files to add.

 * A few workarounds to squelch false warnings from recent gcc have
   been added.

 * "git-send-pack $remote frotz" segfaulted when there is nothing
   named 'frotz' on the local end.

 * "git-rebase -interactive" did not handle its "--strategy" option
   properly.


----------------------------------------------------------------

Changes since v1.5.3.4 are as follows:

Alex Bennee (1):
      Ensure we add directories in the correct order

Alex Riesen (1):
      Fix generation of perl/perl.mak

Andrew Clausen (1):
      helpful error message when send-pack finds no refs in common.

Aurelien Bompard (1):
      honor the http.sslVerify option in shell scripts

Benoit Sigoure (1):
      Fix a small memory leak in builtin-add

Bj=E6=97=A6rn Steinbrink (3):
      Fix --strategy parsing in git-rebase--interactive.sh
      git-rebase--interactive.sh: Don't pass a strategy to git-cherry-p=
ick.
      git-rebase--interactive.sh: Make 3-way merge strategies work for =
-p.

Brian Gernhardt (1):
      cvsserver: Use exit 1 instead of die when req_Root fails.

=46rank Lichtenheld (1):
      git-config: don't silently ignore options after --list

Gerrit Pape (2):
      git-config: handle --file option with relative pathname properly
      git-config: print error message if the config file cannot be read

Jean-Luc Herren (2):
      git add -i: Fix parsing of abbreviated hunk headers
      git add -i: Remove unused variables

Jeff King (1):
      send-pack: respect '+' on wildcard refspecs

Joakim Tjernlund (1):
      Improve receive-pack error message about funny ref creation

Johannes Schindelin (5):
      clear_commit_marks(): avoid deep recursion
      rebase -i: use diff plumbing instead of porcelain
      Fix setup_git_directory_gently() with relative GIT_DIR & GIT_WORK=
_TREE
      fix filter-branch documentation
      filter-branch: update current branch when rewritten

Julian Phillips (1):
      fast-import: Fix argument order to die in file_change_m

Junio C Hamano (8):
      git-remote: fix "Use of uninitialized value in string ne"
      sha1_file.c: avoid gcc signed overflow warnings
      merge-recursive.c: mrtree in merge() is not used before set
      RelNotes-1.5.3.5: describe recent fixes
      Prevent send-pack from segfaulting (backport from 'master')
      git-merge: document but discourage the historical syntax
      Update GIT 1.5.3.5 Release Notes
      GIT 1.5.3.5

Lars Hjemli (1):
      Make merge-recursive honor diff.renamelimit

Linus Torvalds (6):
      Fix embarrassing "git log --follow" bug
      Clean up "git log" format with DIFF_FORMAT_NO_OUTPUT
      git-blame shouldn't crash if run in an unmerged tree
      Avoid scary errors about tagged trees/blobs during git-fetch
      Fix directory scanner to correctly ignore files without d_type
      Fix diffcore-break total breakage

Mathias Megyei (1):
      Do not remove distributed configure script

Michael W. Olson (1):
      Documentation/git-cvsexportcommit.txt: s/mgs/msg/ in example

Michele Ballabio (2):
      git-reflog: document --verbose
      git-archive: document --exec

Nicolas Pitre (1):
      cherry-pick/revert: more compact user direction message

Patrick Welche (1):
      Define NI_MAXSERV if not defined by operating system

Ralf Wildenhues (1):
      gitk.txt: Fix markup.

Robert Schiele (1):
      fixing output of non-fast-forward output of post-receive-email

Sergei Organov (1):
      core-tutorial: Use new syntax for git-merge.

Shawn O. Pearce (17):
      git-gui: Display message box when we cannot find git in $PATH
      git-gui: Handle starting on mapped shares under Cygwin
      git-gui: Ensure .git/info/exclude is honored in Cygwin workdirs
      git-gui: Allow gitk to be started on Cygwin with native Tcl/Tk
      git-gui: Don't crash when starting gitk from a browser session
      Whip post 1.5.3.4 maintenance series into shape.
      Correct typos in release notes for 1.5.3.5
      Avoid 'expr index' on Mac OS X as it isn't supported
      Document additional 1.5.3.5 fixes in release notes
      Yet more 1.5.3.5 fixes mentioned in release notes
      Avoid invoking diff drivers during git-stash
      Further 1.5.3.5 fixes described in release notes
      Paper bag fix diff invocation in 'git stash show'
      git-gui: Correctly report failures from git-write-tree
      git-gui: Handle progress bars from newer gits
      git-gui: Don't display CR within console windows
      Describe more 1.5.3.5 fixes in release notes

Simon Sasburg (1):
      git-gui: Avoid using bold text in entire gui for some fonts

Steffen Prohaska (2):
      git-gui: accept versions containing text annotations, like 1.5.3.=
mingw.1
      attr: fix segfault in gitattributes parsing code
