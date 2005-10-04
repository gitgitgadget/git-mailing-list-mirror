From: Junio C Hamano <junkio@cox.net>
Subject: What's new in GIT today
Date: Mon, 03 Oct 2005 19:20:21 -0700
Message-ID: <7virwehvkq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 04 04:21:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMcPs-0005OP-O9
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 04:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVJDCU0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 22:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVJDCU0
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 22:20:26 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:6295 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932273AbVJDCUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2005 22:20:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051004022018.CNQD9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Oct 2005 22:20:18 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9658>

GIT 0.99.8a is found in the usual places.  It contains the
following fixes:

 - Documentation formatting updates, by Jonas Fonseca.

 - Fredrik Kuivinen fixed git-merge to stash away the original
   tree state correctly when using more than one merge
   strategy.  The same commit also adds support for baseless
   merges.

 - 'git repack' can get confused if the tree had a funny
   filename. 

 - Specifying object name with just a short SHA1 prefix sort-of
   worked, but did not do the right thing when ambiguities
   existed between packed and unpacked objects; after thinking
   about it more, I realize that the fixed code still misses
   some ambiguities, but it is a bit better than before.

On the "master" branch front:

 - All of the above, plus the missing fix for SHA1 prefix
   uniqueness check (to be included in 0.99.8b).

 - Cygwin port by H. Peter Anvin.

 - Option parsing in 'git pull' was buggy and could not
   recognize the following sequence:

   $ git fetch http://kernel.org/pub/scm/git/git-cygwin.git/
   $ git pull -a . fixes pull

   to fetch a remote and use that head along with two other
   local heads to create a four-head Octopus.
