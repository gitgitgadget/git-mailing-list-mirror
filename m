From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [BUG] Add a test to check git-prune does not throw away revs hidden by a graft.
Date: Thu, 18 May 2006 15:25:29 -0700
Message-ID: <7v64k3nf6u.fsf@assigned-by-dhcp.cox.net>
References: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth>
	<Pine.LNX.4.64.0605181435230.10823@g5.osdl.org>
	<7viro3nh07.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605181500470.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri May 19 00:25:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgqw2-0002Wz-UW
	for gcvg-git@gmane.org; Fri, 19 May 2006 00:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWERWZc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 18:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWERWZb
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 18:25:31 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:40066 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750863AbWERWZb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 18:25:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518222530.JFPG27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 18:25:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605181500470.10823@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 18 May 2006 15:01:16 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20311>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 18 May 2006, Junio C Hamano wrote:
>> 
>> I haven't looked at what the test does, but I think he is
>> talking about the opposite.  fsck by design does not honor
>> grafts, and if you grafted a history back to your true root
>> commit, that "older" history will be lost.
>
> Ahh. Ok. Gotcha.
>
> 		Linus

Is it really OK?

I said "fsck by design does not honor" as a flamebait.

And what I said was completely untrue.  Sorry.

If you have a commit chain A->B->C and graft B away by saying
C's parent is A, fsck does read graft and discards B.  But that
is what the user asked to do, so I agree with your initial
response to Yann.

And the opposite case of grafting older history back to the real
root commit was a false alarm.  You would not lose such a
history, because the ancestry traversal will go right through
the real root and traverses the older history.
