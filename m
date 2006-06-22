From: Junio C Hamano <junkio@cox.net>
Subject: libxdiff patches
Date: Thu, 22 Jun 2006 11:57:57 -0700
Message-ID: <7vejxhm30q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 20:58:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtUNQ-0004FA-Be
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 20:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbWFVS6A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 14:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbWFVS6A
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 14:58:00 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:40941 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161188AbWFVS57 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 14:57:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622185758.PNGZ24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 14:57:58 -0400
To: Davide Libenzi <davidel@xmailserver.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22353>

I'm sending three patches that should apply cleanly on top of
libxdiff 0.21; we use the first two with the copy of
libxdiff/xdiff as built-in difff generator in git.

The first patch is to add an option to emit function names in
the hunk headers, by Mark Wooding.  I think this is a good
addition to the upstream libxdiff itself.

The second one is to squelch compilation warnings on (seemingly)
uninitialized variables, by Marco Roeland.  You have already
explained on the git list that these warnings are harmless (IOW
the compiler is being stupid), but squelching these warnings
would help spot other real problems.

The primary reason I am sending these to you is to keep the
changes between your version and the copy git uses to the
minimum, so we can keep up with your future updates.  Right
now, the differences are mostly that the copy git uses is
stripped down (generalization like s_memallocator and s_mmblock
are not used in our copy, for example), and these two patches
are the only real additions we have.

The third patch, by Johannes Schindelin, teaches whitespaces to
xdiff: -b (--ignore-space-change) and -w (--ignore-all-space).
I haven't merged this into the mainline of git yet.  If you are
interested in adding this to upstream (I think it would be a
good addition -- sanity checking is appreciated, though), and if
you are going to do that slightly or majorly differently, I
would prefer to use the change from upstream in order to avoid
carrying git-only local changes in my tree.
