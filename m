From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Wed, 12 Oct 2005 15:07:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510121452030.23242@iabervon.org>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home>
 <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net> <20051008064555.GA3831@steel.home>
 <7vachks7aq.fsf@assigned-by-dhcp.cox.net> <20051008133032.GA32079@localhost>
 <7v64s7svya.fsf@assigned-by-dhcp.cox.net> <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
 <87mzlgh8xa.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
 <87ek6s0w34.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
 <87slv7zvqj.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111346220.14597@g5.osdl.org>
 <877jcjmdmq.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510120749230.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Eggert <eggert@CS.UCLA.EDU>, Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 21:04:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPlt3-0002Xz-I5
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 21:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVJLTC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 15:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVJLTC5
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 15:02:57 -0400
Received: from iabervon.org ([66.92.72.58]:59662 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932441AbVJLTCy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2005 15:02:54 -0400
Received: (qmail 14467 invoked by uid 1000); 12 Oct 2005 15:07:49 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Oct 2005 15:07:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510120749230.14597@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10044>

On Wed, 12 Oct 2005, Linus Torvalds wrote:

> So if you want to support any other locale than UTF-8, you need to escape 
> them. Assuming you want to escape control characters at all, of course (I 
> still think it's perfectly fine to just let the raw mess through and 
> depend on escaping at higher levels)

I think it's actually sufficient to escape 0x00-0x1f and 0x7f; those 
ranges are both easy and, as far as I can tell, include all of the control 
characters that do annoying things. I think escape, backspace, delete, and 
bell are the only ones we'd rather the terminal not get; beyond that, 
patches with screwy filenames look screwy, but don't screw up anything 
outside of the filename.

	-Daniel
*This .sig left intentionally blank*
