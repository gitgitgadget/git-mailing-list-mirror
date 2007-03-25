From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sun, 25 Mar 2007 01:32:16 -0700
Message-ID: <7v648p7mgf.fsf@assigned-by-dhcp.cox.net>
References: <7vbqjp1dyx.fsf@assigned-by-dhcp.cox.net>
	<7v3b4x9sst.fsf@assigned-by-dhcp.cox.net>
	<7v8xed5mex.fsf@assigned-by-dhcp.cox.net>
	<7vr6rtle8o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 10:32:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVO9G-0003AM-71
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 10:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933226AbXCYIcT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 25 Mar 2007 04:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933222AbXCYIcT
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 04:32:19 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:56840 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933226AbXCYIcR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Mar 2007 04:32:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070325083216.ETIL748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Mar 2007 04:32:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ewYG1W0041kojtg0000000; Sun, 25 Mar 2007 04:32:16 -0400
X-maint-at: cd67c8e0bc6f61ffccc12d1775bc1a200df5fe85
X-master-at: 12d6697f3a9f07db0c437438804aec994fc34035
In-Reply-To: <7vr6rtle8o.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 13 Mar 2007 01:49:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43039>

On the 'maint' front, there are a handful gitweb fixes, but
there is nothing major.  I'll perhaps do a v1.5.0.6 if I have
time when I do the v1.5.1-rc2.

I allowed a handful new features to the 'master' side, contrary
to the promise of -rc1 which is supposed to be 'no new features,
only fixes'.  They should be safe changes, though.

 - 'git-diff --quiet' optimizes tree-level comparison by exiting
   early when it finds one difference.  This speeds up path-limited
   form of git-rev-list and git-log significantly.

 - 'git-bisect run <script>' can be used to automate simple
   bisection.=20

Notable fixes since -rc1 includes:

 - 'git-clone -q' supresses the "walk" and "got" noises while
   fetching over http.

 - 'git-revert' does not add duplicated abbreviated commit
   object name on the title line anymore.

 - With core.legacyheaders turned off, zero-length loose object
   was incorrectly judged corrupt.

 - 'git-apply' with core.autocrlf generated bogus results.

 - path-limited 'git-bisect' terminated too early before finding
   the guilty commit.

 - the sample update hook does not generate change notification
   e-mails anymore.=20

----------------------------------------------------------------
* The 'maint' branch has these fixes since v1.5.0.5.

 Jakub Narebski (4):
  gitweb: Fix "next" link in commit view
  gitweb: Don't escape attributes in CGI.pm HTML methods
  gitweb: Fix not marking signoff lines in "log" view
  gitweb: Add some installation notes in gitweb/INSTALL

 Li Yang (1):
  gitweb: Change to use explicitly function call cgi->escapHTML()

 Michael S. Tsirkin (1):
  fix typo in git-am manpage

 Peter Eriksen (1):
  Documentation/pack-format.txt: Clear up description of types.


* The 'master' branch has these since v1.5.1-rc1.

 Alex Riesen (2):
  Document --quiet option to git-diff
  Use diff* with --exit-code in git-am, git-rebase and git-merge-ours

 Andy Parkins (2):
  update-hook: abort early if the project description is unset
  update-hook: remove e-mail sending hook.

 Brandon Casey (1):
  prefer "git COMMAND" over "git-COMMAND" in gitk

 Chris Wright (1):
  make git clone -q suppress the noise with http fetch

 Christian Couder (6):
  Bisect: implement "git bisect run <cmd>..." to automatically bisect.
  Documentation: bisect: reformat some paragraphs.
  Documentation: bisect: reword one paragraph.
  Documentation: bisect: reformat more paragraphs.
  Documentation: bisect: add some titles to some paragraphs.
  Documentation: bisect: make a comment fit better in the man page.

 Eric Wong (1):
  gitk: bind <F5> key to Update (reread commits)

 James Bowes (1):
  Replace remaining instances of strdup with xstrdup.

 Johannes Schindelin (5):
  xdiff/xutils.c(xdl_hash_record): factor out whitespace handling
  Add a HOWTO for setting up a standalone git daemon
  Provide some technical documentation for shallow clones
  t4118: be nice to non-GNU sed
  git-revert: Revert revert message to old behaviour

 Junio C Hamano (12):
  blame: micro-optimize cmp_suspect()
  blame: cmp_suspect is not "cmp" anymore.
  Teach tree_entry_interesting() that the tree entries are sorted.
  tree-diff: avoid strncmp()
  tree_entry_interesting(): allow it to say "everything is interesting"
  git-rebase: make 'rebase HEAD branch' work as expected.
  git-apply: Do not free the wrong buffer when we convert the data for =
writeout
  checkout: report where the new HEAD is upon detaching HEAD
  git-bisect: typofix
  git-bisect.sh: properly dq $GIT_DIR
  Fix path-limited "rev-list --bisect" termination condition.
  git-am documentation: describe what is taken from where.

 Linus Torvalds (6):
  Fix loose object uncompression check.
  Don't ever return corrupt objects from "parse_object()"
  Be more careful about zlib return values
  Remove "pathlen" from "struct name_entry"
  Initialize tree descriptors with a helper function rather than by han=
d.
  Switch over tree descriptors to contain a pre-parsed entry

 Michael S. Tsirkin (1):
  git-merge: Put FETCH_HEAD data in merge commit message

 Nicolas Pitre (10):
  clean up the delta base cache size a bit
  use a LRU eviction policy for the delta base cache
  don't ever allow SHA1 collisions to exist by fetching a pack
  index-pack: use hash_sha1_file()
  index-pack: more validation checks and cleanups
  improve checkout message when asking for same branch
  minor git-prune optimization
  update HEAD reflog when branch pointed to by HEAD is directly modifie=
d
  make it more obvious that temporary files are temporary files
  write_sha1_from_fd() should make new objects read-only

 Santi B=C3=A9jar (1):
  git-fetch: Fix single_force in append_fetch_head

 Shawn O. Pearce (1):
  contrib/continuous: a continuous integration build manager

 Uwe Kleine-K=C3=B6nig (1):
  Bisect: convert revs given to good and bad to commits
