From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.16rc1
Date: Fri, 11 Nov 2005 21:24:24 +0100
Message-ID: <20051111202424.GW30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 11 21:25:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EafRm-0005i1-Tf
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 21:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVKKUY2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 15:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVKKUY2
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 15:24:28 -0500
Received: from w241.dkm.cz ([62.24.88.241]:50881 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751164AbVKKUY1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 15:24:27 -0500
Received: (qmail 2032 invoked by uid 2001); 11 Nov 2005 21:24:24 +0100
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11633>

  Hello,

  I'm announcing the release of Cogito version 0.16rc1, the human-friendly
version control UI for Linus' GIT tool. Share and enjoy at:

	http://www.kernel.org/pub/software/scm/cogito/

  Tons of new features are balanced by other tons of bugfixes, but since
there was a lot of stuff, I would like to give it a while to stabilize,
so that 0.16 itself is really stable. Therefore, I will run this through
the rc process. (Note that 0.16rc1 was tagged the last night, and few
more stuff already landed into git since then, but nothing critical.)

  I'm not sure if many people will actually use the rc releases (I guess
they are either following stable releases or the latest version from
git), but at least it's an anchor point for me - from now on, I will
keep a stable branch in parallel with the development branch (or rather,
I will fork out the development branch when I'm about to do any major
change), so the bugfixes will get back to the latest stable version,
and I won't feel that bad about not releasing for so long.

  The notable new stuff includes:

  * Significant fetching surgery:
    - host:path location now means git+ssh instead of rsync (but it
      is deprecated in favour of explicit protocol name - safer and
      less confusing for you)
    - git+ssh uses packed transport instead of the dated git-ssh-fetch
    - Tags fetching is now much more reliable, saner and faster
    - More robust rsync fetching (for anyone actually still using it)
    - Speedup of the whole thing (the progressbar was actually slowing
      the process down so much that I'm almost afraid to say it)
  * The one-file merging autoresolver covers much more cases now;
    it still probably doesn't handle file-symlink and file-directory
    conflicts (actually, I didn't even test anything related to that
    yet), but otherwise it should handle pretty much any conflict now
    (except that it yet won't make sure that you resolved the conflict
    before committing)
  * New command cg-admin-setuprepo for creating public repositories
  * Major cg-restore surgery - more pleasant to use, more powerful,
    more robust

  * cg-push -t will push tags
  * cg-merge -j will join projects with disjoint histories
  * cg-merge --squash will do the "squash merge" (see docs for details)
  * cg-log --summary will show the shortlog output
  * cg-diff -s will show diffstat
  * cg-reset --adds-removes will reset only index (cancel the
    adds/removes recorded, from the user perspective)
  * cg-status DIRNAME will show the status relative to that directory
  * cg-status -s will filter for only the given status flags
  * cg-tag always creates the tag object
  * First draft of the VCS-neutral interface implemented as
    contrib/neutral.sh

  * Speedups all around (e.g. per-file cg-log SIXTY times)
  * Reorganized cg-help output
  * More new tests in the testsuite
  * Documentation stuff - the "scripted tutorial", README expanded,
    tiny stuff all around

  * Heaps of both major and minor bugfixes; I won't name them, you can
    look at "cg-log -s -r cogito-0.15.1.." - but you should definitely
    upgrade, at last when the stable 0.16 comes out


P.S.: See us at #git @ FreeNode!

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
