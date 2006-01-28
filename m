From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sat, 28 Jan 2006 13:08:50 -0800
Message-ID: <7v64o4ukkd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 28 22:08:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2xJY-0007o7-Oz
	for gcvg-git@gmane.org; Sat, 28 Jan 2006 22:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWA1VIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jan 2006 16:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWA1VIy
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jan 2006 16:08:54 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:44730 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750731AbWA1VIy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2006 16:08:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060128210856.VPZA25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 Jan 2006 16:08:56 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15199>

Now the Kiwi thing is over, I have merged up most of the topic
branches I've been holding back to the master branch.

Here are the highlights:

 * "rev-list --remove-empty" by Linus, a step to help "annotate".

 * "diff -c/--cc" combined diff format.  When used with diff-tree,
   they make a merge commit a bit more readable.  They can also be
   used with diff-files with an unmerged index to see the difference
   to the working tree files from ours and theirs.

 * Fix "diff-tree" to honour info/grafts file while showing parents.
   When "rev-list --parents" output is piped to "diff-tree --stdin", I
   think it also should show a fake header, but that is not currently
   fixed.

 * "rev-parse v2.6.14..v2.6.16" fix by Linus, with a follow up fix to
   make "git whatchanged -- git-fetch-script" work again.

 * Various 'abbreviation' fixes.

I'd like to do a 1.2 release with these sometime next week, but I
would like to encourage people to upgrade to 1.1.5 (or tonight's
"master") sooner rather than waiting for 1.2, since previous versions
have a little problem that can lead to a core dump or worse.

The "bind commit" thing is still in "pu"; since the discussion somehow
stalled, it may stay there for a while.  I have not been exercising it
more than just using it in my regular workflow (meaning, I have not
seen any regression but no tests on the additional features) and have
not started playing with Porcelainish layer, primarily because I am
not in urgent need for subprojects myself.
