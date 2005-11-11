From: Junio C Hamano <junkio@cox.net>
Subject: Re: Strange merge conflicts against earlier merge.
Date: Fri, 11 Nov 2005 14:39:28 -0800
Message-ID: <7vy83ukdwf.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com>
	<20051111075257.GA4765@c165.ib.student.liu.se>
	<20051111114511.GQ30496@pasky.or.cz>
	<7v64qzozyx.fsf@assigned-by-dhcp.cox.net>
	<20051111173239.GU16061@pasky.or.cz>
	<7v1x1nni78.fsf@assigned-by-dhcp.cox.net>
	<20051111215620.GX16061@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 23:42:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eahas-0005aE-7R
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 23:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVKKWlr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 17:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVKKWjj
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 17:39:39 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:918 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751286AbVKKWjb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 17:39:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111223823.GSLK24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 17:38:23 -0500
To: Petr Baudis <pasky@ucw.cz>, Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <20051111215620.GX16061@pasky.or.cz> (Petr Baudis's message of
	"Fri, 11 Nov 2005 22:56:20 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11640>

Petr Baudis <pasky@ucw.cz> writes:

> 	16    anc1/anc2 anc1    anc2      no merge
>
> What ends up in the index at this moment as "stage 1"? anc1? anc2?
> Two stage 1 entries? And what does git-merge-index do about this?

I think we decided there is no single sensible resolution, and
we leave stage 1 empty.

Come to think of it, we should signal that we are punting by
either exiting non-zero, or stuffing 0{40} SHA1 in stage1, so
that we can distinguish the case with two sides adding things
differently.  Daniel, what do you think?
