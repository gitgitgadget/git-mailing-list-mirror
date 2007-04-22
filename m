From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.5.1.2
Date: Sat, 21 Apr 2007 23:16:55 -0700
Message-ID: <7v1widrl0o.fsf@assigned-by-dhcp.cox.net>
References: <7vhcrml4wx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 08:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfVNe-0001h9-3y
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 08:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbXDVGQ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 02:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbXDVGQ6
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 02:16:58 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:64462 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964778AbXDVGQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 02:16:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422061656.GSFB1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 02:16:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id q6Gw1W0081kojtg0000000; Sun, 22 Apr 2007 02:16:56 -0400
In-Reply-To: <7vhcrml4wx.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 11 Apr 2007 19:09:34 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45219>

The latest maintenance release GIT 1.5.1.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.1.2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.1.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.1.2.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.1.2-1.$arch.rpm	(RPM)

GIT v1.5.1.2 Release Notes
==========================

Fixes since v1.5.1.1
--------------------

* Bugfixes

  - "git clone" over http from a repository that has lost the
    loose refs by running "git pack-refs" were broken (a code to
    deal with this was added to "git fetch" in v1.5.0, but it
    was missing from "git clone").

  - "git diff a/ b/" incorrectly fell in "diff between two
    filesystem objects" codepath, when the user most likely
    wanted to limit the extent of output to two tracked
    directories.

  - git-quiltimport had the same bug as we fixed for
    git-applymbox in v1.5.1.1 -- it gave an alarming "did not
    have any patch" message (but did not actually fail and was
    harmless).

  - various git-svn fixes.

  - Sample update hook incorrectly always refused requests to
    delete branches through push.

  - git-blame on a very long working tree path had buffer
    overrun problem.

  - git-apply did not like to be fed two patches in a row that created
    and then modified the same file.

  - git-svn was confused when a non-project was stored directly under
    trunk/, branches/ and tags/.

  - git-svn wants the Error.pm module that was at least as new
    as what we ship as part of git; install ours in our private
    installation location if the one on the system is older.

  - An earlier update to command line integer parameter parser was
    botched and made 'update-index --cacheinfo' completely useless.


* Documentation updates

  - Various documentation updates from J. Bruce Fields, Frank
    Lichtenheld, Alex Riesen and others.  Andrew Ruder started a
    war on undocumented options.


----------------------------------------------------------------

Changes since v1.5.1.1 are as follows:

Alex Riesen (3):
      Use rev-list --reverse in git-rebase.sh
      Document -g (--walk-reflogs) option of git-log
      Fix overwriting of files when applying contextually independent diffs

Andrew Ruder (8):
      Update git-am documentation
      Update git-applymbox documentation
      Update git-apply documentation
      Update git-annotate/git-blame documentation
      Update git-archive documentation
      Update git-cherry-pick documentation
      Fix unmatched emphasis tag in git-tutorial
      Update git-config documentation

Andy Whitcroft (1):
      fix up strtoul_ui error handling

Carlos Rica (1):
      Use const qualifier for 'sha1' parameter in delete_ref function

Eric Wong (4):
      git-svn: respect lower bound of -r/--revision when following parent
      git-svn: quiet some warnings when run only with --version/--help
      git-svn: don't allow globs to match regular files
      perl: install private Error.pm if the site version is older than our own

Eygene Ryabinkin (2):
      Teach gitk to use the user-defined UI font everywhere.
      Improve look-and-feel of the gitk tool.

Frank Lichtenheld (5):
      config.txt: Document gitcvs.allbinary
      config.txt: Document core.autocrlf
      config.txt: Change pserver to server in description of gitcvs.*
      config.txt: Fix grammatical error in description of http.noEPSV
      git-shortlog: Fix two formatting errors in asciidoc documentation

Gerrit Pape (2):
      variable $projectdesc needs to be set before checking against unchanged default.
      Have sample update hook not refuse deleting a branch through push.

J. Bruce Fields (7):
      Documentation: minor edits of git-lost-found manpage
      Documentation: clarify git-checkout -f, minor editing
      Documentation: clarify track/no-track option.
      user-manual: fix discussion of default clone
      user-manual: detached HEAD
      user-manual: start revising "internals" chapter
      user-manual: use detached head when rewriting history

Jim Meyering (1):
      sscanf/strtoul: parse integers robustly

Junio C Hamano (4):
      Do not default to --no-index when given two directories.
      Start preparing for 1.5.1.2
      git-clone: fix dumb protocol transport to clone from pack-pruned ref
      GIT 1.5.1.2

Linus Torvalds (1):
      git-quiltimport complaining yet still working

Matthias Lederhofer (1):
      handle_options in git wrapper miscounts the options it handled.

Michael Spang (1):
      git-blame: Fix overrun in fake_working_tree_commit()

Sam Vilain (1):
      git-tar-tree: complete deprecation conversion message

Shawn O. Pearce (1):
      git-gui: Brown paper bag fix division by 0 in blame
