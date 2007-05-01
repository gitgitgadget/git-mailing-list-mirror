From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.5.1.3
Date: Mon, 30 Apr 2007 20:08:58 -0700
Message-ID: <7vfy6h9r5h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 05:09:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hiijl-0007lQ-C8
	for gcvg-git@gmane.org; Tue, 01 May 2007 05:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbXEADJE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 23:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946157AbXEADJE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 23:09:04 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42922 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450AbXEADJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 23:09:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501030859.GHZN24310.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Apr 2007 23:08:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tf8y1W00J1kojtg0000000; Mon, 30 Apr 2007 23:08:59 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45904>

The latest maintenance release GIT 1.5.1.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.1.3.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.1.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.1.3.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.1.3-1.$arch.rpm	(RPM)

GIT v1.5.1.3 Release Notes
==========================

Fixes since v1.5.1.2
--------------------

* Bugfixes

  - git-add tried to optimize by finding common leading
    directories across its arguments but botched, causing very
    confused behaviour.

  - unofficial rpm.spec file shipped with git was letting
    ETC_GITCONFIG set to /usr/etc/gitconfig.  Tweak the official
    Makefile to make it harder for distro people to make the
    same mistake, by setting the variable to /etc/gitconfig if
    prefix is set to /usr.

  - git-svn inconsistently stripped away username from the URL
    only when svnsync_props was in use.

  - git-svn got confused when handling symlinks on Mac OS.

  - git-send-email was not quoting recipient names that have
    period '.' in them.  Also it did not allow overriding
    envelope sender, which made it impossible to send patches to
    certain subscriber-only lists.

  - built-in write_tree() routine had a sequence that renamed a
    file that is still open, which some systems did not like.

  - when memory is very tight, sliding mmap code to read
    packfiles incorrectly closed the fd that was still being
    used to read the pack.

  - import-tars contributed front-end for fastimport was passing
    wrong directory modes without checking.

  - git-fastimport trusted its input too much and allowed to
    create corrupt tree objects with entries without a name.

  - git-fetch needlessly barfed when too long reflog action
    description was given by the caller.

Also contains various documentation updates.

----------------------------------------------------------------

Changes since v1.5.1.2 are as follows:

Adam Roben (5):
      Remove usernames from all commit messages, not just when using svmprops
      git-svn: Don't rely on $_ after making a function call
      git-svn: Ignore usernames in URLs in find_by_url
      git-svn: Added 'find-rev' command
      git-svn: Add 'find-rev' command

Alex Riesen (1):
      Fix handle leak in write_tree

Andrew Ruder (8):
      Removing -n option from git-diff-files documentation
      Document additional options for git-fetch
      Update git-fmt-merge documentation
      Update git-grep documentation
      Update -L documentation for git-blame/git-annotate
      Update git-http-push documentation
      Update git-local-fetch documentation
      Update git-http-fetch documentation

Brian Gernhardt (2):
      Reverse the order of -b and --track in the man page.
      Ignore all man sections as they are generated files.

Gerrit Pape (1):
      Documentation/git-reset.txt: suggest git commit --amend in example.

Jari Aalto (3):
      Clarify SubmittingPatches Checklist
      git.7: Mention preformatted html doc location
      send-email documentation: clarify --smtp-server

Johannes Schindelin (2):
      dir.c(common_prefix): Fix two bugs
      import-tars: be nice to wrong directory modes

Josh Triplett (3):
      Fix typo in git-am: s/Was is/Was it/
      Create a sysconfdir variable, and use it for ETC_GITCONFIG
      Add missing reference to GIT_COMMITTER_DATE in git-commit-tree documentation

Julian Phillips (1):
      http.c: Fix problem with repeated calls of http_init

Junio C Hamano (8):
      Build RPM with ETC_GITCONFIG=/etc/gitconfig
      applymbox & quiltimport: typofix.
      Start preparing for 1.5.1.3
      Do not barf on too long action description
      Update .mailmap with "Michael"
      Fix import-tars fix.
      Fix symlink handling in git-svn, related to PerlIO
      GIT v1.5.1.3

Michele Ballabio (1):
      git shortlog documentation: add long options and fix a typo

Robin H. Johnson (10):
      Document --dry-run parameter to send-email.
      Prefix Dry- to the message status to denote dry-runs.
      Debugging cleanup improvements
      Change the scope of the $cc variable as it is not needed outside of send_message.
      Perform correct quoting of recipient names.
      Validate @recipients before using it for sendmail and Net::SMTP.
      Ensure clean addresses are always used with Net::SMTP
      Allow users to optionally specify their envelope sender.
      Document --dry-run and envelope-sender for git-send-email.
      Sanitize @to recipients.

Shawn O. Pearce (3):
      Actually handle some-low memory conditions
      Don't allow empty pathnames in fast-import
      Catch empty pathnames in trees during fsck
