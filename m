From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] honor GIT_REFLOG_ACTION in git-commit
Date: Fri, 19 Jan 2007 18:22:06 -0800
Message-ID: <7vvej2a14h.fsf@assigned-by-dhcp.cox.net>
References: <7vfya6bixg.fsf@assigned-by-dhcp.cox.net>
	<20070120021557.GB11073@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 03:22:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H85s0-0007mp-T8
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 03:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932869AbXATCWJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 21:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932807AbXATCWJ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 21:22:09 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36742 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932869AbXATCWI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 21:22:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120022207.BMVC9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 21:22:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DENQ1W0181kojtg0000000; Fri, 19 Jan 2007 21:22:25 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070120021557.GB11073@spearce.org> (Shawn O. Pearce's message
	of "Fri, 19 Jan 2007 21:15:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37252>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> This allows git-cherry-pick and git-revert to properly identify
>> themselves in the resulting reflog entries.  Earlier they were
>> recorded as what git-commit has done.
>
> Not sure how I missed that one when I introduced GIT_REFLOG_ACTION,
> but thanks for finding and fixing it.  :-)

The fact that it went unnoticed for this long time shows how we
lack proper tools to read the message part of the reflog,
although we use @{N} and @{ago} notation every day and some
people might even rely on it.  I'd like to do something about
it, and my earlier "show-branch --reflog" enhancement series
(I'll park that in 'next' for now) was my attempt for that goal.

I found this out by accident while working on it.
