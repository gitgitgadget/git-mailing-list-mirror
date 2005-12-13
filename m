From: Petr Baudis <pasky@suse.cz>
Subject: ([ANNOUNCE] Cogito-0.16)
Date: Tue, 13 Dec 2005 02:07:42 +0100
Message-ID: <20051213010742.GD12373@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Dec 13 02:08:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elydw-0004KM-Ci
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 02:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVLMBHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 20:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVLMBHq
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 20:07:46 -0500
Received: from w241.dkm.cz ([62.24.88.241]:64706 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932317AbVLMBHp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 20:07:45 -0500
Received: (qmail 15144 invoked by uid 2001); 13 Dec 2005 02:07:42 +0100
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13554>

  It seems the actual announcement has never really hit the list, for
some reason. I'm posting this only so that the history can record this
and people can look it up later. And so that I don't feel silly wasting
time putting it together. ;-) But the current version is 0.16.1 right
now, and another release will be coming up soon.

  ============


  Hello,

  here goes Cogito version 0.16, the human-friendly version control UI
for the Linus' GIT tool. Share and enjoy at:

	http://www.kernel.org/pub/software/scm/cogito/

  Plenty of new features and bugfixes. There are only few minor bugfixes
since rc2, and one major bugfix concerning possible weirdness after
cg-merge failing with the git-read-tree error - for this reason, it's
recommended to upgrade.

  I changed my tactics wrt. the minor versions; 0.16 has now dedicated
branch and I will try to accumulate at least non-trivial bugfixes there,
so 0.16.1 will be probably purely bugfix release. The "stable" 0.16
branch is available in the Cogito repository as "v0.16".

  The notable new stuff since 0.15.1 includes:


  * Significant fetching surgery:
    - host:path location now means git+ssh instead of rsync (but it
      is deprecated in favour of explicit protocol name - safer and
      less confusing for you)
    - git+ssh uses packed transport instead of the dated git-ssh-fetch
    - Tags fetching is now much more reliable, saner and faster
    - More robust rsync fetching (for anyone actually still using it)
    - Local fetching should work even without GNU cp now
    - curl is used instead of wget for fetching over HTTP
    - Non-symlink HEADs are now fetched from properly
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
  * Handle multiple merge bases (leaving the decision on the user)

  * Fix another bug related to dirty merges - files containing local
    changes would be left marked as ignored for committing ('m' in
    cg-status) until after the next commit in case cg-merge failed
    with git-read-tree error - please upgrade!
  * Fix a long-standing bug with some stale files not being removed
    during large fast-forwards
  * Heaps of other both major and minor bugfixes; I won't name them,
    you can look at "cg-log -s -r cogito-0.15.1.." - but you should
    certainly upgrade

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
  * cg-init -m'msg' support
  * Deprecated .git/branch-name
  * First draft of the VCS-neutral interface implemented as
    contrib/neutral.sh

  * Speedups all around (e.g. per-file cg-log SIXTY times)
  * Reorganized cg-help output
  * More new tests in the testsuite
  * Documentation stuff - the "scripted tutorial", README expanded,
    tiny stuff all around


  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
