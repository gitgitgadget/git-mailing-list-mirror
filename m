From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 16:34:57 -0800
Message-ID: <7vslei764u.fsf@assigned-by-dhcp.cox.net>
References: <7virfprquo.fsf@assigned-by-dhcp.cox.net>
	<87odphgfzz.wl%cworth@cworth.org>
	<7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
	<20070108131735.GA2647@coredump.intra.peff.net>
	<7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
	<20070109142130.GA10633@coredump.intra.peff.net>
	<7virffkick.fsf@assigned-by-dhcp.cox.net>
	<20070109213117.GB25012@fieldses.org>
	<7vy7obj07k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701091539050.3594@woody.osdl.org>
	<20070110140432.GA20868@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 01:35:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4nuZ-0002N3-Qh
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 01:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbXAKAfQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 19:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbXAKAfP
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 19:35:15 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:43310 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965245AbXAKAfO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 19:35:14 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111003513.BCXI7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 19:35:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9caM1W0101kojtg0000000; Wed, 10 Jan 2007 19:34:22 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20070110140432.GA20868@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 10 Jan 2007 09:04:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36544>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 09, 2007 at 03:46:32PM -0800, Linus Torvalds wrote:
>
>> I would suggest a solution:
>> 
>>  - git checkout will refuse to switch AWAY from a detached head unless the 
>>    SHA1 of the detached head exactly matches some other branch.
>
> What about
>
>   git checkout HEAD~20
>
> I agree that checking out tags will be more common, but it feels like we
> are discouraging this usage by presenting spurious warning messages.

Once the user knows what HEAD~20 means, I think it is safe to
assume that the user knows what the branches are.

"git checkout master" will barf and suggests the user possible
common exits; "checkout -f" if there is nothing of value,
"checkout -b <branch>" or if they want to build on the current
state.

And once the user who knows what the branches are sees such, and
especially with the help from $PS1 hack of bash-completion in
contrib/ section, the user will learn to do "checkout -f" after
wandering around for sightseeing on a detached HEAD, and at that
point the annoying error message will not be even seen.
