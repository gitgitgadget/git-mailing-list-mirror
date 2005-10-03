From: Junio C Hamano <junkio@cox.net>
Subject: GIT 0.99.8
Date: Sun, 02 Oct 2005 17:12:13 -0700
Message-ID: <7vfyrjxxuq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 03 02:13:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMDwN-0007f5-6D
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 02:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVJCAMR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 20:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVJCAMQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 20:12:16 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:17568 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751159AbVJCAMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2005 20:12:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051003001212.BYUX9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Oct 2005 20:12:12 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9625>

Here is 0.99.8.  GIT has been doing everything I personally
wanted it to do since mid 0.99.7, and now it has almost
everything I want it to contain, except for a couple of minor
points.  I feel that we are ready to finish the last mile for
1.0.  Many thanks to everybody who contributed the comments,
eyeballs, and code.


Done in 0.99.8
==============

New Features, Commands, and Enhancements
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* 'git pull' now uses 'git-merge' instead of 'git-resolve', so you can
  specify alternative merge strategy to use on its command line.

* 'git pull -s recursive' has been taught about renaming merges,
  which may deal with HPA's klibc vs klibc-kbuild situation better.

* Symbolic refs -- instead of using symlinks to express .git/HEAD,
  you can have a regular file that stores a single line
  'ref: refs/heads/master' in it.

  git-update-ref is the preferred way to write into .git/HEAD,
  not "echo >.git/HEAD".  git-symbolic-ref is the preferred way
  to check which underlying ref a symbolic ref .git/HEAD refers
  to, not "readlink .git/HEAD".

* A couple of new diff options (-l<num> and --name-status).

* Commit walker over http acquired more SSL options.

* 'git clone' checks out the working tree by default.


Fixes
~~~~~

* Removed unused commands (diff-helper, rev-tree, and export).

* Platforms with only Python 2.3 installed can use recursive merge
  strategy.

* Octopus documented.

* Merge is more careful noticing potentially ambiguous situation. 

* Git pull does not blindly do Octopus when Pull: lines in remotes
  file specifies more than one remote branches.

* Commit walker got safer to use after interrupted downloads.

* Commit walker over http can resume partial downloads.

* More portability fixes for BSD and Solaris.
