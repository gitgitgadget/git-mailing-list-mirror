From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Mon, 08 Jan 2007 17:05:26 -0800
Message-ID: <7v7ivxt3ft.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<87ps9xgkjo.wl%cworth@cworth.org>
	<7virfprquo.fsf@assigned-by-dhcp.cox.net>
	<87odphgfzz.wl%cworth@cworth.org>
	<7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
	<20070108131735.GA2647@coredump.intra.peff.net>
	<7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
	<87fyalyqqz.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 02:05:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H45Qk-0002WQ-JK
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 02:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbXAIBF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 20:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbXAIBF2
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 20:05:28 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39404 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbXAIBF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 20:05:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109010527.ZVSE7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jan 2007 20:05:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8p4d1W00E1kojtg0000000; Mon, 08 Jan 2007 20:04:37 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87fyalyqqz.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	08 Jan 2007 16:43:00 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36292>

Carl Worth <cworth@cworth.org> writes:

> On Mon, 08 Jan 2007 16:19:28 -0800, Junio C Hamano wrote:
>> The first checkout, because there is no branch v1.4.0, makes the
>> HEAD detached.  You are no longer on any branch at that point,
>> and "git checkout v1.2.0" that follows do not trigger the check
>> which is about "coming back from the detached HEAD state".
>
> So what's the final check? Is it "can come from detached HEAD to a
> branch only if the detached HEAD is reachable from the target branch"?
>
> If so, that's still a trap for people who are just exploring with "git
> checkout" and never make any commits while detached.

An obvious alternative is not to allow building on top of a HEAD
that is detached at all, which I suggested initially.

A non-alternative is to silently lose commits, which you seem to
be suggesting, but I would rather play it safe.

The wording used for current warning that says "use checkout -f"
is horrible, and it needs to be reworded much better, but other
than that, I think playing safer is much better than making a
worse trap of silently losing the commits they may make before
they come to understand how "a branch" works.
