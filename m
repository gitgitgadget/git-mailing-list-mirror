From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.17
Date: Mon, 27 Feb 2006 02:16:15 +0100
Message-ID: <20060227011615.GW31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 02:15:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDWzK-0000lo-Qz
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 02:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWB0BPk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 20:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWB0BPk
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 20:15:40 -0500
Received: from w241.dkm.cz ([62.24.88.241]:32910 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750745AbWB0BPj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 20:15:39 -0500
Received: (qmail 13475 invoked by uid 2001); 27 Feb 2006 02:16:15 +0100
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16816>


		The last winter snow
		leaves but Cogito comes in
		its place, snow-white 0.17
				(*)


  After some random bugfixes I got no more bugreports so this feels
stable enough for a release. The rest of this mail will mostly be
a rehash of the 0.17rc1 announcement; the rc2-to-0.17 bugfixes were
rather dull.

  Huge amount of new features and cool stuff. The highlight is cg-switch
for switching between local branches and massive cg-patch improvements,
but there is plenty of other stuff as well. Read on for more details.

  The notable new stuff includes:

  * cg-switch - Cogito finally gives you the full convenience of
    multiple local branches in a single repository ;)
  * cg-patch -c, -C, -d - Cogito now supports cherrypicking, easy commit
    reverts and automatic committing of applied patches
  * Resumable cg-clone - if cg-clone fails in the middle of the initial
    fetch, the directory is not deleted and you do not have to start all
    over again - just cd inside and run cg-fetch and it will DTRT

  * Support for tracking rebasing branches; as long as you use cg-update
    (NOT cg-fetch + cg-merge) and won't commit local changes, Cogito
    will correctly update the branch even if it got rebased in the
    meanwhile
  * Quoting fixes - this means that Cogito should be now theoretically
    100% resilient to whitespaces and metacharacters in filenames etc.
    Note that filenames containing newlines still aren't supported and
    aren't likely to ever be. You are a loonie. Go away.
  * Radically improved cg-fetch progressbar; it still doesn't quite work
    with rsync (use cg-fetch -v -v), but I don't think that can be
    helped. The main advantage is that it will show HTTP fetch progress
    even when fetching large files (especially packs).
  * Much more sensible behaviour for cg-clean wrt. untracked directories
    (do not erase their content).

  * Significant merges speedup (but still quite some potential for
    improvement)
  * cg-* --help now by default shows only short help; use --long-help
    to see the full manual
  * cg-commit --signoff
  * cg-commit --review to review and even modify the patch you are
    committing
  * cg-commit -M to take the commit message from a file
  * bash commandline autocompletion files in contrib/
  * cg-fetch -v, cg-fetch -v -v, cg-merge -v, cg-update -v
  * cg-push -r to push a different branch (or even a specific commit)
    instead of your current branch
  * cg-rm -r for recursive directories removal
  * cg-mv trivial wrapper for git-mv
  * cg-push over HTTP
  * cg-patch -u for applying non-git patches while autoadding/removing
    files, cg-patch -pN with obvious meaning
  * cg-object-id -d for short human-readable commit string id
    (just wraps git-describe)

  * Too many minor new features to list here

  * Incompatible change - cg-log -d renamed to cg-log -D
  * Incompatible change - the post-commit hook won't be ran for all the
    merged commits anymore when you commit a merge; you can reenable
    that in .git/config, see the cg-commit documentation for details


P.S.: See us at #git @ FreeNode!
P.P.S.: (*) That means bug-free, if it wasn't obvious!
P.P.P.S.: Yes, it just occurred to me that I've forgot about the
pre-built documentation, but it's too late in the night by now. Sorry,
the next time.

  Happy hacking,

-- 
				Petr "Pasky the lousy poet" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
