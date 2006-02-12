X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.17rc1
Date: Sun, 12 Feb 2006 18:11:54 +0100
Message-ID: <20060212171154.GW31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 12 Feb 2006 17:11:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1F8Kkr-0006dh-Ot for gcvg-git@gmane.org; Sun, 12 Feb
 2006 18:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750783AbWBLRLS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Feb 2006
 12:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWBLRLS
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 12:11:18 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56284 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1750783AbWBLRLS (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 12:11:18 -0500
Received: (qmail 13032 invoked by uid 2001); 12 Feb 2006 18:11:54 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

  Hello,

  I'm announcing the release of Cogito version 0.17rc1, the human-friendly
version control UI for Linus' GIT tool. Share and enjoy at:

	http://www.kernel.org/pub/software/scm/cogito/

  This isn't as heavy on bugfixes as 0.16rc1 was, since most of the
bugfixes already went to 0.16 minor releases. This worked out pretty
well and 0.16.4 is really quite stable; so I will do the same thing for
0.17 as well.

  Still, there is a huge amount of new features and cool stuff. The
highlight is cg-switch for switching between local branches and massive
cg-patch improvements, but there is plenty of other stuff as well. Read
on for more details.

  Note that there is a lot of new stuff inside and some of it went in
quite lately so it didn't have a lot of time to get tested by the
bleeding edge users. Therefore take care, bugs might be lurking around.

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

  * Significant merges speedup (but still quite some potential for
    improvement)
  * cg-* --help now by default shows only short help; use --long-help
    to see the full manual
  * cg-commit --signoff
  * cg-commit --review to review and even modify the patch you are
    committing
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

  * Incompatible change - the post-commit hook won't be ran for all the
    merged commits anymore when you commit a merge; you can reenable
    that in .git/config, see the cg-commit documentation for details


P.S.: See us at #git @ FreeNode!

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
