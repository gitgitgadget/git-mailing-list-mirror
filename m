From: Junio C Hamano <junkio@cox.net>
Subject: Re: Strange merge conflicts against earlier merge.
Date: Fri, 11 Nov 2005 16:50:41 -0800
Message-ID: <7v1x1mk7tq.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com>
	<20051111075257.GA4765@c165.ib.student.liu.se>
	<20051111114511.GQ30496@pasky.or.cz>
	<7v64qzozyx.fsf@assigned-by-dhcp.cox.net>
	<20051111173239.GU16061@pasky.or.cz>
	<7v1x1nni78.fsf@assigned-by-dhcp.cox.net>
	<20051111215620.GX16061@pasky.or.cz>
	<7vy83ukdwf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511111806070.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 01:51:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eajbn-0003xi-VZ
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 01:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVKLAuq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 19:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKLAup
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 19:50:45 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:46249 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750826AbVKLAuo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 19:50:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051112004954.BZYH29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 19:49:54 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511111806070.25300@iabervon.org> (Daniel
	Barkalow's message of "Fri, 11 Nov 2005 18:33:28 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11652>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Fri, 11 Nov 2005, Junio C Hamano wrote:
>
>> Come to think of it, we should signal that we are punting by
>> either exiting non-zero, or stuffing 0{40} SHA1 in stage1, so
>> that we can distinguish the case with two sides adding things
>> differently.  Daniel, what do you think?
>
> Probably don't want to exit non-zero, since we can deal with the rest of 
> the paths sensibly. All 0 SHA1 would work, if we want to identify this 
> case. On the other hand, I think the desired behavior at present is to 
> tell the user to pick the correct version of the two, which is the same as 
> if it's new in both sides, which is why I had it like that.

Yeah, and I have an updated merge-one-file in "pu" that tries to
do a bit more interesting thing than just punting and asking the
user, when both sides added different contents.  I did not want
to trigger that logic when we are doing case #16, and that was
what my comment was about.
