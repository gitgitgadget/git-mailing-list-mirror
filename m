From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.16.2
Date: Thu, 15 Dec 2005 00:10:19 +0100
Message-ID: <20051214231019.GK22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 00:12:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmflR-00089u-55
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 00:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbVLNXKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 18:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbVLNXKW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 18:10:22 -0500
Received: from w241.dkm.cz ([62.24.88.241]:59578 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965052AbVLNXKV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 18:10:21 -0500
Received: (qmail 6843 invoked by uid 2001); 15 Dec 2005 00:10:19 +0100
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13654>

  Hello,

  this is Cogito version 0.16.2, the next stable release of the
human-friendly version control UI for the Linus' GIT tool. Share
and enjoy at:

	http://www.kernel.org/pub/software/scm/cogito/

  Very few changes since the last release - one testcase, trivial fix,
documentation improvements. And one important bugfix! If you are a
cg-clean user, certainly upgrade - cg-clean in 0.16.1 had a serious bug
which would cause it remove all subdirectories when running from the
source root with the -d option - which is rather nasty if you have any
uncommitted local changes there.

  Now we finally have a testcase for cg-clean, and the cg-clean code was
further tweaked to reduce potential for any more code mistakes. The
major reason for both 0.16.1 and 0.16.2 were cg-clean bugs, but
hopefully no more problems are waiting for us in this realm, and the
rest of Cogito seems to be thankfully pretty stable throughout the 0.16
line, so I expect things to finally calm down a bit here.

  I spent the last two hours making a large patch fixing all potentially
whitespace-unsafe Cogito code, but I've decided to keep it for 0.17 only
- Cogito meeting with whitespaces is a very rare occasion, and such
a large patch is bound to contain some new bugs coming from trivial
mistakes and such.

  Also, Cogito is now very ineffective when cloning big-packed
repositories over the git protocol or over ssh, since git-fetch-pack
unpacks the objects on the local side, which bogs things down a lot and
makes the repository grow into enormous proportions - I'm not yet sure
if I will backport the fix to 0.16 since I want to be maximally careful
not to gravely break anything again and keep 0.16 as stable as possible.
(Hm. Call this "the Debian dilemma". ;-)

  The new stuff since 0.16.1 is:

Pavel Roskin:
      cg-clean test
      cg-clean: be safer by running everything from relpath

Petr Baudis:
      cg-clean testcase: Minor tidyup
      cg-clean testcase: Clarify description
      Fixed cg-clean removing ALL subdirs when invoked from root
            (Discovered and originally fixed by Pavel Roskin.)
      Fix cg-status reporting every merge as a squash-merge
      Improve cg-admin-setuprepo documentation
      In the cg-commit text, give the user hint on how to abort
      cogito-0.16.2

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
