From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Mon, 09 Apr 2007 01:17:42 -0700
Message-ID: <7vtzvq0xnd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 10:18:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hap4o-0008Ir-71
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 10:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbXDIIRu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 9 Apr 2007 04:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbXDIIRu
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 04:17:50 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56413 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbXDIIRs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2007 04:17:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409081748.OBCG25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Apr 2007 04:17:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kwHn1W0061kojtg0000000; Mon, 09 Apr 2007 04:17:48 -0400
X-maint-at: 24c64d6add05f1f4d2e277af2d44c961910c98d3
X-master-at: 5bcbc7ff1014c58e7296713926206bf6a69e0f4c
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44047>

Maybe will do 1.5.1.1 on Wednesday with the accumulated fixes on
'maint'.

The 'master' has a few topics merged from 'next':

 - Christian Couder's "git bisect" improvements.
 - Fernando J Perada's parallel make fix.
 - Andy Parkins's "git diff --stat" for binary files.
 - Shawn Pearce's "git lost-found" that ignores reflog.
 - Switching between two branches that have D/F conflicts.
 - "git merge -s subtree".

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

 Arjen Laarhoven (4):
  usermanual.txt: some capitalization nits
  t3200-branch.sh: small language nit
  t5300-pack-object.sh: portability issue using /usr/bin/stat
  Makefile: iconv() on Darwin has the old interface

 Brian Gernhardt (2):
  Document --left-right option to rev-list.
  Distinguish branches by more than case in tests.

 Dana How (1):
  Fix lseek(2) calls with args 2 and 3 swapped

 Eric Wong (3):
  git-svn: bail out on incorrect command-line options
  git-svn: dcommit/rebase confused by patches with git-svn-id: lines
  git-svn: fix log command to avoid infinite loop on long commit messag=
es

 Frank Lichtenheld (6):
  cvsimport: sync usage lines with existing options
  cvsimport: Improve documentation of CVSROOT and CVS module determinat=
ion
  cvsimport: Improve usage error reporting
  cvsimport: Reorder options in documentation for better understanding
  cvsimport: Improve formating consistency
  cvsserver: small corrections to asciidoc documentation

 Geert Bosch (1):
  Fix renaming branch without config file

 Jakub Narebski (1):
  gitweb: Fix bug in "blobdiff" view for split (e.g. file to symlink) p=
atches

 Junio C Hamano (3):
  Fix dependency of common-cmds.h
  Documentation: tighten dependency for git.{html,txt}
  Add Documentation/cmd-list.made to .gitignore

 Lars Hjemli (2):
  rename_ref(): only print a warning when config-file update fails
  Make builtin-branch.c handle the git config file

 Ren=C3=A9 Scharfe (1):
  Revert "builtin-archive: use RUN_SETUP"

 Shawn O. Pearce (1):
  Honor -p<n> when applying git diffs

 Ville Skytt=C3=A4 (1):
  DESTDIR support for git/contrib/emacs

 YOSHIFUJI Hideaki (1):
  Avoid composing too long "References" header.


* The 'master' branch has these since the last announcement
  in addition to the above.

 Alex Riesen (1):
  Fix passing of TCLTK_PATH to git-gui

 Andy Parkins (1):
  Show binary file size change in diff --stat

 Christian Couder (2):
  Bisect: teach "bisect start" to optionally use one bad and many good =
revs.
  Documentation: bisect: "start" accepts one bad and many good commits

 Fernando J. Pereda (1):
  Makefile: Add '+' to QUIET_SUBDIR0 to fix parallel make.

 Junio C Hamano (21):
  git-fetch: add --quiet
  checkout: allow detaching to HEAD even when switching to the tip of a=
 branch
  _GIT_INDEX_OUTPUT: allow plumbing to output to an alternative index f=
ile.
  git-read-tree --index-output=3D<file>
  add_cache_entry(): removal of file foo does not conflict with foo/bar
  unpack_trees.c: pass unpack_trees_options structure to keep_entry() a=
s well.
  unpack-trees: get rid of *indpos parameter.
  Fix read-tree --prefix=3Ddir/.
  Fix twoway_merge that passed d/f conflict marker to merged_entry().
  Fix switching to a branch with D/F when current branch has file D.
  Fix bogus error message from merge-recursive error path
  Propagate cache error internal to refresh_cache() via parameter.
  Rename internal function "add_file_to_cache" in builtin-update-index.=
c
  Rename static variable write_index to update_index in builtin-apply.c
  Rename add_file_to_index() to add_file_to_cache()
  git-bisect: modernization
  t6030: add a bit more tests to git-bisect
  git-bisect: allow bisecting with only one bad commit.
  git-push reports the URL after failing.
  git-push to multiple locations does not stop at the first failure
  A new merge stragety 'subtree'.

 Nicolas Pitre (1):
  clean up and optimize nth_packed_object_sha1() usage

 Shawn O. Pearce (1):
  Fix lost-found to show commits only referenced by reflogs
