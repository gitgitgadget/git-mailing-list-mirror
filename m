From: Junio C Hamano <junkio@cox.net>
Subject: blame not working well?
Date: Wed, 05 Apr 2006 17:11:47 -0700
Message-ID: <7vacazy33w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 06 02:12:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRI6T-0004Jq-9B
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 02:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWDFALt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 20:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWDFALt
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 20:11:49 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39357 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932115AbWDFALt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 20:11:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060406001148.MLZR15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Apr 2006 20:11:48 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18461>

I was having fun updating blame.c to use the built-in xdiff
instead of spawning and reading from external GNU diff (it is
currently in "next" branch).  It seems to pass the trivial
testsuite case but I noticed for example annotating Makefile,
sha1_name.c, or blame.c in git.git repository seems to show
quite bogus annotation.  One extreme case is the Makefile; for
all but one line is blamed for the very initial commit made by
Linus X-<.  One good news for me is that the version before this
change has the same breakage.  One bad news is this seems to
have been broken for some time.

Bisecting indicates 2a0925be3512451834ec9a3e023f4cff23c1cfb7 is
the first bad commit, but I do not see how the change can break
it.  I'll continue digging it, but if you have a chance, could
you take a look, too?
