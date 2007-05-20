From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.5.1.6
Date: Sun, 20 May 2007 02:08:39 -0700
Message-ID: <7vtzu7q2ug.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 11:08:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HphPD-00048b-4n
	for gcvg-git@gmane.org; Sun, 20 May 2007 11:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbXETJIl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 05:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754361AbXETJIl
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 05:08:41 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:48230 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338AbXETJIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 05:08:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520090840.LASE19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 20 May 2007 05:08:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1M8f1X0031kojtg0000000; Sun, 20 May 2007 05:08:39 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47800>

The latest maintenance release GIT 1.5.1.6 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.1.6.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.1.6.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.1.6.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.1.6-1.$arch.rpm	(RPM)

The release notes are relative to 1.5.1.4, as 1.5.1.5 was very
short-lived.

GIT v1.5.1.6 Release Notes
==========================

Fixes since v1.5.1.4
--------------------

* Bugfixes

  - git-send-email did not understand aliases file for mutt, which
    allows leading whitespaces.

  - git-format-patch emitted Content-Type and Content-Transfer-Encoding
    headers for non ASCII contents, but failed to add MIME-Version.

  - git-name-rev had a buffer overrun with a deep history.

  - contributed script import-tars did not get the directory in
    tar archives interpreted correctly.

  - git-svn was reported to segfault for many people on list and
    #git; hopefully this has been fixed.

  - git-svn also had a bug to crash svnserve by sending a bad
    sequence of requests.

  - "git-svn clone" does not try to minimize the URL
    (i.e. connect to higher level hierarchy) by default, as this
    can prevent clone to fail if only part of the repository
    (e.g. 'trunk') is open to public.

  - "git checkout branch^0" did not detach the head when you are
    already on 'branch'; backported the fix from the 'master'.

  - "git-config section.var" did not correctly work when
    existing configuration file had both [section] and [section "name"]
    next to each other.

  - "git clone ../other-directory" was fooled if the current
    directory $PWD points at is a symbolic link.

  - (build) tree_entry_extract() function was both static inline
    and extern, which caused trouble compiling with Forte12
    compilers on Sun.

  - Many many documentation fixes and updates.


----------------------------------------------------------------

Changes since v1.5.1.4 are as follows:

Alex Riesen (1):
      Allow fetching references from any namespace

Andy Whitcroft (1):
      git name-rev writes beyond the end of malloc() with large generations

Eric Wong (6):
      git-svn: don't drop the username from URLs when dcommit is run
      git-svn: clean up caching of SVN::Ra functions
      git-svn: fix segfaults due to initial SVN pool being cleared
      git-svn: don't attempt to minimize URLs by default
      git-svn: avoid crashing svnserve when creating new directories
      git-svn: don't minimize-url when doing an init that tracks multiple paths

Frank Lichtenheld (3):
      builtin-log.c: Fix typo in comment
      Documentation: format-patch has no --mbox option
      git-am: Clean up the asciidoc documentation

J. Bruce Fields (14):
      user-manual: revise birdseye-view chapter
      glossary: expand and clarify some definitions, prune cross-references
      user-manual: move quick-start to an appendix
      Documentation: remove howto's now incorporated into manual
      user-manual: move howto/make-dist.txt into user manual
      user-manual: move howto/using-topic-branches into manual
      user-manual: add a "counting commits" example
      user-manual: introduce git
      user-manual: listing commits reachable from some refs not others
      user-manual: reorganize public git repo discussion
      tutorials: add user-manual links
      tutorial: revise index introduction
      user-manual: discourage shared repository
      user-manual: finding commits referencing given file content

Jakub Narebski (1):
      gitweb: Add a few comments about %feature hash

Jan Hudec (1):
      Updated documentation of hooks in git-receive-pack.

Jari Aalto (1):
      SPECIFYING RANGES typo fix: it it => it is

Jeff King (1):
      format-patch: add MIME-Version header when we add content-type.

Johan Herland (1):
      user-manual: Add section on ignoring files

Johannes Schindelin (2):
      import-tars: Use the "Link indicator" to identify directories
      Add a birdview-on-the-source-code section to the user manual

Junio C Hamano (8):
      git-clone: don't get fooled by $PWD
      .mailmap: add some aliases
      checkout: allow detaching to HEAD even when switching to the tip of a branch
      git-config: do not forget seeing "a.b.var" means we are out of "a.var" section.
      Fix git-clone buglet for remote case.
      Prepare for 1.5.1.5 Release Notes
      GIT v1.5.1.5
      GIT 1.5.1.6

Marco Costalba (1):
      Fix an unmatched comment end in arm/sha1_arm.S

Matthias Kestenholz (2):
      Documentation: Added [verse] to SYNOPSIS where necessary
      Documentation: Reformatted SYNOPSIS for several commands

Matthieu Castet (1):
      Remove stale non-static-inline prototype for tree_entry_extract()

Michael Hendricks (2):
      git-send-email: allow leading white space on mutt aliases
      Document core.excludesfile for git-add

Petr Baudis (1):
      Documentation: git-rev-list's "patterns"

Quy Tonthat (2):
      RPM spec: include files in technical/ to package.
      Documentation/branch: fix small typo in -D example

Richard P. Curnow (2):
      Fix documentation of tag in git-fast-import.txt
      Fix documentation of tag in git-fast-import.txt

Shawn O. Pearce (1):
      Properly handle '0' filenames in import-tars

Steffen Prohaska (3):
      tiny fix in documentation of git-clone
      git-config: test for 'do not forget "a.b.var" ends "a.var" section'.
      Fixed link in user-manual
