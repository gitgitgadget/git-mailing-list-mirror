From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Mon, 08 Jan 2007 16:19:28 -0800
Message-ID: <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<87ps9xgkjo.wl%cworth@cworth.org>
	<7virfprquo.fsf@assigned-by-dhcp.cox.net>
	<87odphgfzz.wl%cworth@cworth.org>
	<7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
	<20070108131735.GA2647@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 01:19:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H44iE-0000Mg-U7
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 01:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbXAIATb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 19:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbXAIATb
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 19:19:31 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:45956 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbXAIATa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 19:19:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109001929.JFMI2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jan 2007 19:19:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8oJf1W00R1kojtg0000000; Mon, 08 Jan 2007 19:18:39 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20070108131735.GA2647@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 8 Jan 2007 08:17:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36288>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 08, 2007 at 03:19:48AM -0800, Junio C Hamano wrote:
>
>> I decided to fast-track this one.  With a handful fix-ups, this
>> is now at the tip of 'next'.
>
> I haven't seen the code, waiting for kernel.org to mirror, but I have a
> question...
>
>> The primary difference from the one we discussed, and then has
>> been sitting in 'pu', is that coming back from the detached HEAD
>> state is allowed only with '-f' or to a branch that is a
>> fast-forward of HEAD.
>
> Hrm. So does that mean this doesn't work (without -f):
>
>   git checkout v1.4.0
>   ... look around ...
>   git checkout v1.2.0

That should work.

The first checkout, because there is no branch v1.4.0, makes the
HEAD detached.  You are no longer on any branch at that point,
and "git checkout v1.2.0" that follows do not trigger the check
which is about "coming back from the detached HEAD state".

But I would probably do the second v1.2.0 "checkout" with "git
reset --hard", if what I am doing is "wandering, looking around
to see different commits".
