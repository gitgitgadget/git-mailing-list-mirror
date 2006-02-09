From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Thu, 09 Feb 2006 02:32:15 -0800
Message-ID: <7vfymsddqo.fsf@assigned-by-dhcp.cox.net>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0602091055540.24701@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 11:32:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7964-0001uV-9o
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 11:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030595AbWBIKcR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 05:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbWBIKcR
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 05:32:17 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:36841 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030595AbWBIKcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 05:32:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209103042.QUZA20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 05:30:42 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602091055540.24701@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 9 Feb 2006 10:58:13 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15803>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> IMHO what you intend to put into "next" should be put into "master" 
> anyway: everyone interested in git development should try the new features 
> as early as possible.

Yes, but I've been trying to be _very_ conservative to keep
"master" clean and stable, as I said in my inauguration speech.

Since git is still young and we are building features that are
needed in the field every day, it is very beneficial for users
to keep up-to-date with "master", and I would really like to
encourage that.  It saddens me to see git patches posted to the
kernel list marked with 0.99.9.GIT by prominent kernel people.

However, I do not want to see their time wasted on getting
bitten by stupid bugs I carelessly place on the "master" branch.
So I'd like to keep "master" conservative, stable and boring, at
least for now.

Instead of introducing "next", I could treat "pu" the way I said
I would do "next".  But even if I rid of its constant rewinding
nature, "pu" tends to have intrusive stuff near its tip and is
very hard to build on top of it.  Patches against the tip of
"pu" to fix things unrelated to the whacky ones often would be
inapplicable to "master".  This is especially true with what are
currently pending near the tip of "pu" (bind commits and shallow
clones).  I do not forsee them to graduate to "master" any time
soon.  Not in their current shape.

The promised "next" should be much easier to build on top of,
without disecting it into component topic branches, and it would
be the branch to track for people interested in git development
if you want to stay closer to the edge without touching bleeding
or even broken edge.  Making it easier to participate in git
development by people interested is what I am aiming at here.

I've considered publishing the topic branches individually.
Branches are cheap from the storage point of view (not really,
one inode and a filesystem block wasted to store only 41-bytes
;-)), but it needs management time and care (I will need to
remember to go to the repository and remove stale ones once they
are merged up).  Since branches in "next" are meant to be
short-lived, I am hoping it is easier for me to bundle them up
like I am planning.

On the other hand, long-lived whacky intrusive ones might be
better published as individual branches.  
