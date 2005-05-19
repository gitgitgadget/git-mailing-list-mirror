From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 14:58:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505191456040.20274@localhost.localdomain>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
 <7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.62.0505191426000.20274@localhost.localdomain>
 <7vsm0jyryf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 20:58:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYqDS-0002rJ-Jc
	for gcvg-git@gmane.org; Thu, 19 May 2005 20:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVESS6n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 14:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVESS6n
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 14:58:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:6043 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261218AbVESS6l
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 14:58:41 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGR00BDA3CTO4@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 May 2005 14:58:06 -0400 (EDT)
In-reply-to: <7vsm0jyryf.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 19 May 2005, Junio C Hamano wrote:

> >>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:
> 
> NP> On Thu, 19 May 2005, Junio C Hamano wrote:
> >> - the command line interface "-M" to read "-M" or "-M[0-9]"
> >> (one digit); -M defaults to -M5 and give the cut-off point at
> >> similarity score 5000, -M9 at 9000, etc.
> 
> NP> Why not a fractional value instead?  -M1 is 100% the same while -M.95 
> NP> allows for some 5% changes.
> 
> We are essentially saying the same thing.  Internally diff core
> uses score between 0 and 10000 but single digit proposed above
> or fractional both hides that from the user by normalizing the
> scale to something less arbitrary (in my case 0-9 in your case
> 0-1.0).

Yes, but 0-9 is putting a bound on the accuracy.  What if someone wants 
not more than 2% difference?


Nicolas
