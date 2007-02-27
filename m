From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.5.0.2
Date: Tue, 27 Feb 2007 00:58:22 -0800
Message-ID: <7vabz0j7td.fsf@assigned-by-dhcp.cox.net>
References: <7vwt2ec32p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751600AbXB0I6Z@vger.kernel.org Tue Feb 27 09:59:12 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751600AbXB0I6Z@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLyAx-00076L-Bl
	for glk-linux-kernel-3@gmane.org; Tue, 27 Feb 2007 09:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbXB0I6Z (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 27 Feb 2007 03:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbXB0I6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Feb 2007 03:58:25 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:33423 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbXB0I6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Feb 2007 03:58:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227085822.LAWB3767.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 03:58:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UYyN1W00A1kojtg0000000; Tue, 27 Feb 2007 03:58:22 -0500
In-Reply-To: <7vwt2ec32p.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 18 Feb 2007 18:07:42 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40701>

The latest maintenance release GIT 1.5.0.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.0.2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.0.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.0.2.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.0.2-1.$arch.rpm	(RPM)


GIT v1.5.0.2 Release Notes
==========================

Fixes since v1.5.0.1
--------------------

* Bugfixes

  - Automated merge conflict handling when changes to symbolic
    links conflicted were completely broken.  The merge-resolve
    strategy created a regular file with conflict markers in it
    in place of the symbolic link.  The default strategy,
    merge-recursive was even more broken.  It removed the path
    that was pointed at by the symbolic link.  Both of these
    problems have been fixed.

  - 'git diff maint master next' did not correctly give combined
    diff across three trees.

  - 'git fast-import' portability fix for Solaris.

  - 'git show-ref --verify' without arguments did not error out
    but segfaulted.

  - 'git diff :tracked-file `pwd`/an-untracked-file' gave an extra
    slashes after a/ and b/.

  - 'git format-patch' produced too long filenames if the commit
    message had too long line at the beginning.

  - Running 'make all' and then without changing anything
    running 'make install' still rebuilt some files.  This
    was inconvenient when building as yourself and then
    installing as root (especially problematic when the source
    directory is on NFS and root is mapped to nobody).

  - 'git-rerere' failed to deal with two unconflicted paths that
    sorted next to each other.

  - 'git-rerere' attempted to open(2) a symlink and failed if
    there was a conflict.  Since a conflicting change to a
    symlink would not benefit from rerere anyway, the command
    now ignores conflicting changes to symlinks.

  - 'git-repack' did not like to pass more than 64 arguments
    internally to underlying 'rev-list' logic, which made it
    impossible to repack after accumulating many (small) packs
    in the repository.

  - 'git-diff' to review the combined diff during a conflicted
    merge were not reading the working tree version correctly
    when changes to a symbolic link conflicted.  It should have
    read the data using readlink(2) but read from the regular
    file the symbolic link pointed at.

  - 'git-remote' did not like period in a remote's name.

* Documentation updates

  - added and clarified core.bare, core.legacyheaders configurations.

  - updated "git-clone --depth" documentation.


* Assorted git-gui fixes.
