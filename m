From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 13:25:57 -0800
Message-ID: <7v7jb5hcm2.fsf@assigned-by-dhcp.cox.net>
References: <200511181833.40048.ismail@uludag.org.tr>
	<200511182208.24248.ismail@uludag.org.tr>
	<Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>
	<200511182245.01713.ismail@uludag.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 22:26:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdDkC-0001jn-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 22:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbVKRV0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 16:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVKRV0A
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 16:26:00 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:1741 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750985AbVKRVZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 16:25:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118212452.YMEE17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 16:24:52 -0500
To: Ismail Donmez <ismail@uludag.org.tr>
In-Reply-To: <200511182245.01713.ismail@uludag.org.tr> (Ismail Donmez's
	message of "Fri, 18 Nov 2005 22:45:00 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12265>

Ismail Donmez <ismail@uludag.org.tr> writes:

>> I agree that UTF-8 is a good idea, but that's a totally different
>> argument.
>
> Maybe you could officially require all commit messages to be UTF-8 then the 
> problem would be just solved for future commits at least. Until then it 
> should be workarounded in gitweb I guess.

No, that's something I will *not* do.

Linus is right --- he is always right but he is slightly more
right than he usually is in this particular case ;-).

We allow any 8-bit data in commit log messages.  We even make it
easier to use utf-8 than other encodings, and we encourage use
of utf-8 for obvious reasons.  But we do not go further than
that.  Any patch to change commit-tree.c to reject binary data
in a commit log message that utf-8 validator chokes at *will* be
rejected.

Go back to the list archive.  Dig out messages on this topic.
Summarize the ones that say why we encourage utf-8 in textual
commit log messages, submit a patch to add that to
Documentation/howto/ or perhaps Documentation/tutorial.txt, to
further encourage people to use utf-8.  Just do not forbid non
utf-8 text nor binary data in general.
