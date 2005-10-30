From: Junio C Hamano <junkio@cox.net>
Subject: rev-list --sparse?
Date: Sun, 30 Oct 2005 01:37:30 -0700
Message-ID: <7v64rfxuwl.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510292204520.3348@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 30 09:38:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EW8hd-0004Xy-7W
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 09:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVJ3Ihf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 03:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932842AbVJ3Ihf
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 03:37:35 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8689 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932089AbVJ3Ihe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 03:37:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051030083716.OBNM16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Oct 2005 03:37:16 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510292204520.3348@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 29 Oct 2005 22:05:46 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10816>

I was reviewing the rev-list documentation and it struck me that
dense/sparse command line flag do not make much sense.

Since dense is by default in effect, --dense is a no-op.  One
possible use of it would be to hardcode --dense on a rev-list
command line in a script, like:

	git-rev-list $some_opts --dense $some_paths

to defeat user-supplied --sparse that can be in $some_opts, but
for this to work the script needs to have parsed out user input
into some_opts and some_paths in the first place anyway, so it
can just detect and remove --sparse just as easily.

The --sparse flag does not seem to have much use either; not
giving pathspec has the same effect.
