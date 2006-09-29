From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.18
Date: Fri, 29 Sep 2006 14:06:39 +0200
Message-ID: <20060929120639.GK20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 14:07:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTH8z-0001S7-Oa
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 14:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWI2MGn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 08:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWI2MGn
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 08:06:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37587 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030197AbWI2MGl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 08:06:41 -0400
Received: (qmail 7647 invoked by uid 2001); 29 Sep 2006 14:06:39 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28108>

  Hello,

  I just released cogito-0.18 - new feature release of the Cogito
user-friendly Git user interface.  The biggest highlights are
super-duper cg-log, tagging interface and cg-patch -m. Contrary to my
plan, this unfortunately does NOT contain three big things yet that are
missing but will be in cogito-0.19 (which should be already quite near
the ever-approaching version 1.0):

	- Rigorous three-way merging of uncommitted local changes
	  instead of stashing local changes in patches
	  (stashing produces harder-to-resolve conflicts and can
	   in some extreme circumstances lead to loss or almost-loss
	   of your local changes which is highly evil; this is my
	   priority now; if you want to be absolutely safe, do not
	   update/merge/switch your tree while having uncommitted
	   changes in it)
	- Support for cg-clone -a (clone all remote branches)
	- Support for auto-pushing tags

  So, now for things that ARE part of 0.18: :-)

First, a simple README update is the only difference from 0.18rc2.

* INCOMPATIBLE: $COGITO_COLORS is renamed to $CG_COLORS
* INCOMPATIBLE: cg-log now by default hides merges, -M behaviour is
reversed
* All kinds of very stale command aliases that were deprecated for eons
were removed
* .git/author is deprecated (use .git/config to set it up)
* We now officially depend on 1.4.2 (we use git-*-fetch --stdin which makes
fetching tags _MUCH_ faster)

* cg-log was reworked to support cg-log -d (show diffs inline),
  cg-log -S (pickaxe) and renames following (does not quite work, though;
  I decided not to fix it and wait for revisions.c in Git to support it
  since the perl script which takes care of this is quite a hack)
* cg-switch -l to stash your local changes when switching branches
* cg-commit --amend
* Tagging interface (cg-tag, cg-tag-ls, cg-tag-show) was greatly enhanced
* cg-patch -m for applying mailboxes
* cg-clone -l now sets up an alternate instead of symlinking the object db
* Support for cg-clone --reference
* cg-admin-setuprepo supports setting up repositories over SSH
* Support fetching over FTP
* Other cool stuff!

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
