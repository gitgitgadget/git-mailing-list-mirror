From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] remove delta-against-self bit
Date: Thu, 09 Feb 2006 15:53:59 -0800
Message-ID: <7v7j846qco.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602091736500.5397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 00:54:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Lby-0001sf-If
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 00:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWBIXyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 18:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbWBIXyD
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 18:54:03 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57058 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750845AbWBIXyB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 18:54:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209235225.CXBI20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 18:52:25 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602091736500.5397@localhost.localdomain> (Nicolas
	Pitre's message of "Thu, 09 Feb 2006 17:50:04 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15844>

Nicolas Pitre <nico@cam.org> writes:

> Said bit would in fact be more useful to allow for encoding the copying 
> of chunks larger than 64KB providing more savings with large files.  
> This will correspond to packs version 3.
>
> While the current code still produces packs version 2, it is made future 
> proof so pack versions 2 and 3 are accepted.  Any pack version 2 are 
> compatible with version 3 since the redefined bit was never used before.  
> When enough time has passed, code to use that bit to produce version 3 
> packs could be added.

I agree with the general direction and this futureproofing is a
good thing to have before 1.2.0, I think.

The bit is however _already_ looked at by the count_delta(),
to assess the extent of damage, IIRC.  Should we be
futureproofing that bit as well?
