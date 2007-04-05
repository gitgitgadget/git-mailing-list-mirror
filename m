From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Wed, 04 Apr 2007 23:44:32 -0700
Message-ID: <7vejmzuxpr.fsf@assigned-by-dhcp.cox.net>
References: <7v1wj5ycx5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 08:44:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZLi1-0008EL-Jw
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 08:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945945AbXDEGof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 02:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945956AbXDEGoe
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 02:44:34 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41693 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945945AbXDEGod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 02:44:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405064433.UZI25613.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 02:44:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jJkY1W00W1kojtg0000000; Thu, 05 Apr 2007 02:44:33 -0400
X-maint-at: 5850cb645d3ca44c3bc014f92672dae6394c0315
X-master-at: 1ddb47acbdfae4ee43b54b3b96d108b814a9c751
In-Reply-To: <7v1wj5ycx5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 31 Mar 2007 02:34:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43800>

So here is the status for tonight.

* There is no biggie in 'maint' yet.

* On 'master', as I promised, the following topics are merged:

  - An option to install p4import, and make it part of the RPM
    binary package suite.

  - An option to exclude git-gui and gitk.

  - Build tweak to include GIT_VERSION string in the documentation.

  - Optimize "add single-path" in a huge directory whose
    contents are mostly ignored.

  - Optimize "rev-list --bisect".

  - A handful gitweb, git-svn and git-blame.el cleanups.

  In addition, a few patches are also in:

  - "diff --stat" to show bytesize changes for binary files.

  - "lost-found" to ignore objects only reachable from the reflog.

  - "patch -p<n>" is honored even for "diff --git" patches.

  - A handful internal clean-ups.

----------------------------------------------------------------

* The 'maint' branch has these fixes since v1.5.1

 Brian Gernhardt (1):
  Fix t4200-rerere for white-space from "wc -l"

 Gerrit Pape (1):
  rename contrib/hooks/post-receieve-email to contrib/hooks/post-receive-email.

 Junio C Hamano (1):
  rerere: make sorting really stable.


* The 'master' branch has these since v1.5.1 in addition to the above.

 Andy Parkins (1):
  Show binary file size change in diff --stat

 Brian Gernhardt (1):
  Remove unused WITH_OWN_SUBPROCESS_PY from RPM spec

 Eric Wong (1):
  git-svn: bail out on incorrect command-line options

 Eygene Ryabinkin (7):
  Add the WITH_P4IMPORT knob to the Makefile.
  Added git-p4 package to the list of git RPMs.
  Added correct Python path to the RPM specfile.
  NO_TCLTK
  Add --with-tcltk and --without-tcltk to configure.
  Rewrite Tcl/Tk interpreter path for the GUI tools.
  Eliminate checks of user-specified Tcl/Tk interpreter.

 Frank Lichtenheld (2):
  Documentation: Replace @@GIT_VERSION@@ in documentation
  Documentation: Add version information to man pages

 Jakub Narebski (2):
  gitweb: Whitespace cleanup - tabs are for indent, spaces are for align (3)
  gitweb: Quote hash keys, and do not use barewords keys

 Junio C Hamano (14):
  t6002: minor spelling fix.
  git-rev-list: add --bisect-vars option.
  git-rev-list --bisect: optimization
  t6004: add a bit more path optimization test.
  rev-list --bisect: Fix "halfway" optimization.
  make the previous optimization work also on path-limited rev-list --bisect
  Documentation: unbreak user-manual.
  Optional Tck/Tk: ignore generated files.
  RPM spec: include git-p4 in the list of all packages.
  Fix bogus error message from merge-recursive error path
  Propagate cache error internal to refresh_cache() via parameter.
  Rename internal function "add_file_to_cache" in builtin-update-index.c
  Rename static variable write_index to update_index in builtin-apply.c
  Rename add_file_to_index() to add_file_to_cache()

 Linus Torvalds (1):
  Optimize directory listing with pathspec limiter.

 Nicolas Pitre (1):
  clean up and optimize nth_packed_object_sha1() usage

 Shawn O. Pearce (2):
  Fix lost-found to show commits only referenced by reflogs
  Honor -p<n> when applying git diffs

 Xavier Maillard (2):
  git-blame.el: separate git-blame-mode to ease maintenance
  git-blame.el: pick a set of random colors for each git-blame turn
