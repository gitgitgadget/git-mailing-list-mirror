From: Junio C Hamano <junkio@cox.net>
Subject: 0.99.9 on Saturday next week.
Date: Sat, 22 Oct 2005 03:23:08 -0700
Message-ID: <7vvezpetpv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 22 12:24:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETGWw-0000Rr-6X
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 12:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVJVKXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 06:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVJVKXL
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 06:23:11 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41211 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932213AbVJVKXK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2005 06:23:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051022102234.NAQL2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Oct 2005 06:22:34 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10469>

We have been at version "0.99.8.GIT" for too long, and
maintenance branch is now up to 0.99.8f.

When git-daemon was deployed on kernel.org machines, I wanted to
stabilize things a bit so that we can feature freeze and do a
real 1.0.  Recently we have changed things quite a bit, but
having them only in the "master" branch without having an
official release for some time kept Porcelains in limbo.  I am
sure both Pasky and Catalin want to start updating Cogito and
StGIT to take advantage of what the new core offers, but they
cannot just randomly use new features only available in the
"master" branch and expect people to use 0.99.8.GIT version of
unknown vintage.

So here is a heads-up to list what to expect in 0.99.9.  I am
not promising that 0.99.9 will be followed by 1.0 -- it could
well be 0.99.10.

The "master" branch, not counting barebone Porcelainish scripts
that real Porcelains would not utilize, contains the following
additions and enhancements.  Many of them have been forward
ported to 0.99.8 maintenance branch already:

 - Cygwin (HPA).
 - Configuration files (Linus).
 - core.filemode to tell not to trust working tree mode bits.
 - git-daemon (HPA).
 - git-symbolic-ref for platforms with/without symlinks (Linus).
 - sparse .git/object/??/ directory (Linus).
 - git-update-ref.
 - funny pathnames quoted in C-style.
 - sha1^{} and sha1^{type} notation.
 - git-ls-remote reports object names tags point to.
 - git-apply operates in a sparse tree.
 - git-diff records which blob each patch applies to.
 - git-format-patch; --stdout and rev ranges.
 - git-update-index --index-info.
 - git-read-tree -m -u removes empty directories.
 - git-http-fetch drives multiple connections (Nick Hengeveld).
 - git-http-fetch is safer with funny-characters.
 - the name of packfile is more stable.
 - clone-pack keeps the pack unpacked.
 - git-check-ref-format; ref names are stricter than before.
 - git-pack-files --local (Linus).
 - fetch-pack git+ssh:// and ssh+git:// (Linus).
 - svn import (Matthias).
 - ls-tree filename listing bugfix (Robert Fitzsimons).
 - git-index-pack (Sergey).

In addition, we have handful things cooking in the proposed
updates branch.  I expect these to come to some conclusion by
the end of next week, and 0.99.9 will contain what's ready by
then:

 - rev-list --dense (Linus).
 - fetch-pack further improvements (Johannes).
 - pack-objects using cached results.

Although we had a good proposal for protocol rewrite from HPA
and discussions that followed, it appeared to me that the change
might be a bit too backward incompatible while the advantage was
not obvious enough -- I do not think we have a consensus on it.
0.99.9 will not wait for this discussion to conclude.

One last request.  If you have sent bugfixes in the C-part of
the code (i.e. really core) that I have not applied without a
good reason, please remind me.  I do not think I have dropped or
postponed-then-forgot anything, but I just want to be sure.  I
am really in stabilization mood this week.
