From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sat, 17 Jun 2006 17:48:10 -0700
Message-ID: <7vpsh75lx1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: vger@kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 02:48:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrlSn-0006si-Qw
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 02:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWFRAsM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 20:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWFRAsM
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 20:48:12 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:7371 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751089AbWFRAsM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 20:48:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060618004811.HIML19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Jun 2006 20:48:11 -0400
To: git@vger.kernel.org
X-maint-at: be0c7e069738fbb697b0719f2252107261c9340e
X-master-at: ae448e3854d8b6e7e37aa88fa3917f5dd97f3210
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22044>

It's been a while since I've done v1.4.0, and I haven't fully
caught up with the list traffic yet, but here is the current
status.

I'm planning to manage the v1.4.X series a bit differently
during this round.  So far, they were supposed to be fix-only on
top of v1.4.0, but people who follow the maintenance series
(including the binary packages) missed out on too many good
stuff that happen on the "master" branch.  Also presses like
lwn.net tended to cover the maint series which gets stale pretty
quickly.

So I'll first merge only post-1.4.0 fixes and additions to the
"master" branch until we are comfortable with its shape, tag it
as 1.4.1, and continue.  Essentially, "next" and "pu" will
become the playpens (the first being "not proven but fixable"
changes, the latter being "under consideration, but will not be
missed if dropped" changes) their names originally implied, and
"master" will be what "maint" was supposed to be -- fixes and
good changes.  The old fixes-only maintenance on "maint" branch
will be halted for now -- except maybe when some urgent fixes
are needed, I might do 1.4.X.Y like the kernel folks do.

* The 'master' branch has these since v1.4.0

   Dennis Stosberg:
      Make t4101-apply-nonl bring along its patches

   Eric W. Biederman:
      Don't parse any headers in the real body of an email message.

   Eric Wong:
      git-svn: t0000: add -f flag to checkout
      git-svn: fix handling of filenames with embedded '@'
      git-svn: eol_cp corner-case fixes
      git-svn: restore original LC_ALL setting (or unset) for commit
      git-svn: don't allow commit if svn tree is not current
      git-svn: support -C<num> passing to git-diff-tree
      git-svn: --branch-all-refs / -B support
      git-svn: optimize --branch and --branch-all-ref
      git-svn: support manually placed initial trees from fetch
      git-svn: Move all git-svn-related paths into $GIT_DIR/svn
      git-svn: minor cleanups, extra error-checking
      git-svn: add --repack and --repack-flags= options
      git-svn: add --shared and --template= options to pass to init-db
      git-svn: add some functionality to better support branches in svn
      git-svn: add UTF-8 message test
      git-svn: add 'log' command, a facsimile of basic `svn log'
      git-svn: add support for Perl SVN::* libraries
      git-svn: make the $GIT_DIR/svn/*/revs directory obsolete
      git-svn: avoid creating some small files
      git-svn: fix several small bugs, enable branch optimization
      git-svn: Eliminate temp file usage in libsvn_get_file()
      git-svn: bugfix and optimize the 'log' command
      git-svn: tests no longer fail if LC_ALL is not a UTF-8 locale
      git-svn: svn (command-line) 1.0.x compatibility
      git-svn: rebuild convenience and bugfixes

   Florian Forster:
      gitweb: Adding a `blame' interface.
      gitweb: Make the `blame' interface in gitweb optional.

   Fredrik Kuivinen:
      blame: Add --time to produce raw timestamps

   Jakub Narebski:
      Update gitweb README: gitweb is now included with git

   Junio C Hamano:
      gitk: rereadrefs needs listrefs
      fix git alias
      t5100: mailinfo and mailsplit tests.
      mailinfo: ignore blanks after in-body headers.

   Linus Torvalds:
      gitweb.cgi history not shown

   Martin Langhoff:
      cvsimport: ignore CVSPS_NO_BRANCH and impossible branches
      cvsimport: complete the cvsps run before starting the import
      cvsimport: keep one index per branch during import

   Peter Eriksen:
      Implement safe_strncpy() as strlcpy() and use it more.

   Sean Estabrooks:
      Add a "--notags" option for git-p4import.

   Sven Verdoolaege:
      git-cvsexportcommit.perl: fix typo


* The 'next' branch, in addition, has these.

   Johannes Schindelin:
      diff options: add --color

   I would say this would be fine as is -- diff being quite
   important part of the system, I just wanted to cook it for a
   while.

   Junio C Hamano:
      read-tree: --prefix=<path>/ option.
      write-tree: --prefix=<path>
      read-tree: reorganize bind_merge code.

   I'll have them graduate to "master" soon, as they do not seem
   to hurt anybody.

      fetch-pack: give up after getting too many "ack continue"

   Maybe merge to "master" and see what it breaks.

      shared repository: optionally allow reading to "others".

   This should be ready.  I just want to do another round of
   check.

   Paul Eggert:
      date.c: improve guess between timezone offset and year.

   This is more for the entertainment value than for practical
   value ;-).

* The 'pu' branch, in addition, has these.

   Johannes Schindelin:
      Read configuration also from ~/.gitconfig
      repo-config: learn the flag "--no-local"

   I see Pasky has proposed another config change (this time,
   not "also from" but "alternatively from") -- I am not sure
   which one is more appropriate.  Waiting for Johannes's
   response to Pasky's message and hoping the list can agree on
   a single patch series to apply to "next".

      Teach diff about -b and -w flags

   Yakov Lerner:
      auto-detect changed prefix and/or changed build flags

   I think this is fine, except that test-prefix-change target
   is probably unneeded as Martin noticed.
