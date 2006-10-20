From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Remove unused index tracking code.
Date: Thu, 19 Oct 2006 18:35:13 -0700
Message-ID: <7vhcxzrcq6.fsf@assigned-by-dhcp.cox.net>
References: <1168a0313ac1152d43731965fbbb6d4ccfd865a1.1161301889.git.jaharkes@cs.cmu.edu>
	<20061020002048.GC7162@delft.aura.cs.cmu.edu>
	<Pine.LNX.4.64.0610192058130.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 03:35:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GajI8-00062T-BU
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 03:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbWJTBfQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 21:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWJTBfQ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 21:35:16 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49140 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751663AbWJTBfO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 21:35:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061020013514.JKXB16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Thu, 19 Oct 2006 21:35:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cRbH1V00o1kojtg0000000
	Thu, 19 Oct 2006 21:35:18 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610192058130.1971@xanadu.home> (Nicolas Pitre's
	message of "Thu, 19 Oct 2006 21:11:10 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29399>

Nicolas Pitre <nico@cam.org> writes:

> This patch in particular creates additional restrictions on pack 
> files that were not present before.  And I don't think this is a good 
> thing.
>
> This patch impose an ordering on REF_DELTA objects that doesn't need to 
> exist.  Say for example that an OFS_DELTA depends on an object which is 
> a REF_DELTA object.  With this patch any pack with the base for that 
> REF_DELTA stored after the OFS_DELTA object will be broken.
>
> And to really do thin pack fixing properly we really want to just append 
> missing base objects at the end of the pack which falls in the broken 
> case above.
>
> So this is a NAK from me.

I agree.

By the way, it is rather rare for us to see a NAK on this list.
I'd welcome to see more of them ;-).
