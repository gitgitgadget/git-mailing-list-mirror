From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.2.0
Date: Sun, 12 Feb 2006 14:14:43 -0800
Message-ID: <7vaccw8bsc.fsf@assigned-by-dhcp.cox.net>
References: <7vzmkw8d5b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 23:15:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8PUj-0003v4-NY
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 23:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWBLWOp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 17:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWBLWOp
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 17:14:45 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:12470 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751030AbWBLWOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 17:14:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212221323.IWRQ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 17:13:23 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16024>

A resend.  I am suspecting vger does not want two lists hosted
there both named on To: line...

-- >8 --
The latest feature release GIT 1.2.0 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.2.0.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.2.0-1.$arch.rpm	(RPM)

Right now binary RPM is available only for x86_64, because I do
not have an access to RPM capable i386 box.


What's new in 1.2.0

The new release 1.2.0 took about one month since 1.1.0 was released.
It has literally _tons_ of updates since the last maintenance release
1.1.6.  While people who have been following the master branch are
probably familiar with most of them, I expect others would be quite
surprised by the amount of changes.  Hopefully the surprise is of a
pleasant kind.

Here is the list of all the good stuff (not counting what are
already in the 1.1.X maintenance series).

* Major features

 - Checkout -m option.  This allows you to switch branches when
   you have local changes to paths that are different in the
   current branch and new branch.  The local changes are merged to
   the version from the branch you are switching to and the merge
   result is left in your working tree (you may see conflicts).

 - Add -c and --cc to diff-tree and diff-files.  They give the
   "combined diff" output that shows merges more human readably,
   and the "git diff" wrapper uses --cc by default.  This release
   also comes with updated gitk (Paul Mackerras) that takes advantage
   of this feature.

 - git-commit updates.

   - Allow git-commit from a subdirectory.

   - Aborted "git-commit -a" leaves the index as it was.

   - "git commit --only paths..." checks in changes to only
     named paths.

     This will become the default, instead of the traditional
     --include semantics, during development track towards
     1.3.0, so if you are used to the --include semantics,
     please start training your fingers to explicitly say
     "git commit --include paths...".

   - Add --author='A U Thor <author@example.com>' command
     line option.

   - "git commit -v" seeds the end of the commit log message editor
     with the patch to be committed.

 - git-status updates.  Now it takes the exactly same set of parameters
   as git-commit takes, and serves as a way to preview what you would
   be committing.  The -v option to get diff output is also available.

* Portability

  FreeBSD support in the main Makefile (Alecs King, Alex Riesen)
  Run GIT-VERSION-GEN with $(SHELL), not sh (Jason Riedy)
  compat/unsetenv.c (Jason Riedy)
  stat() to work around nonportable EEXIST (Jason Riedy)
  Asciidoc futureproofing (Pavel)
  Disable USE_SYMLINK_HEAD by default (Pavel)
  Various fixes for Cygwin around dirent and sockaddr_storage.

* Foreign SCM interface

  cvs-import updates (Andreas Ericsson and Martin)
  cvs-exportcommit fixes and docs (Martin)
  send-email various cleanups (Ryan)
  svnimport internal arglist fix (Sasha Khapyorsky)
  svnimport relative path fix (Christian Biesinger)

* Samples and Docs

  New tutorial (J. Bruce Fields)
  Update hook example (Andreas Ericsson)
  Topic-branch howto updates (Tony Luck)
  Other misc. cleanups (Florian Weimer, J. Bruce Fields, Petr Baudis, Jon Loeliger)
  Document git-diff-tree --always (Petr Baudis)
  Basic documentation for git-show (Petr Baudis)

* Cleanups

  Use tree_desc tree parser in tar-tree (Daniel, Linus)
  Use sha1_file.c's mkdir-like routine in apply.c (Jason Riedy)
  Use adler32() from zlib instead of defining our own (Peter Eriksen)
  Assorted cleanups (Uwe Zeisberger)
  Make --abbrev more consistent with diff-tree
  Omit duplicated parents from rev-list --parents output
  Clean up rev-parse error checking (Linus)

* Usability improvements

  git-apply -pN (Daniel)
  git-rev-list -n1 and -1 (Eric Wong)
  diff-tree --always flag (Linus)
  git-fetch -k (Tom Prince)
  git-describe: default to HEAD (Andreas Ericsson and me)
  git-clone --bare
  git-show and git-whatchanged (Linus and me)
  git-daemon user-relative paths updates (Mark Wooding and me)
  git-rerere reuse recorded resolve.
  git-fmt-merge-msg updates.
  git-format-patch: always --mbox and show sane Date (Eric W. Biederman et al)
  git-show-branch assorted updates
  git-commit seeds the message with list of conflicted files (Linus)
  git-clone and git-fetch shows progress information (Linus and me)
  git-repo-config allows type specifiers, does not dump core if bool (Pasky)

* Fixes

  git-format-patch -s (Eric W. Biederman)
  git-whatchanged: exit out early on errors (Linus)
  Various http-fetch fixes (Mark Wooding, Nick Hengeveld)
  Local push/pull env cleanup (Matt Draisey)
  Exec git programs without using PATH (Michal Ostrowski)
  Pass --upload-pack to fetch-pack and friends (Michal Ostrowski)
  Allow diff and index commands to be interrupted (Petr Baudis)
  Fix "git-push --tags".
  Parse sha1^12 for 12th parent correctly.
  git-diff-tree --stdin uses given parents by git-rev-list --parents.
  Show grafted parents in rev-list --parents.
  git-ls-files -o reads from --exclude-per-dir from upper directories.
  do not allow empty author/committer name/email.
  call setup_git_directory() before git_config().
  futureproof and optimize delta unpacker (Nicolas Pitre)

* Performance

  merge-recursive (Fredrik)
  git-read-tree --aggressive
  optimize objects bookkeeping for 5x speedup (Johannes)

For the full list of changes above, see:

	$ git log ^v1.1.6 v1.1.0..v1.2.0
