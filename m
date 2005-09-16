From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix fetch completeness assumptions
Date: Thu, 15 Sep 2005 23:04:36 -0700
Message-ID: <7vslw5tuob.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509142120020.23242@iabervon.org>
	<20050915150205.65378a65.vsu@altlinux.ru>
	<Pine.LNX.4.63.0509151243020.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Vlasov <vsu@altlinux.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 08:05:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG9L1-0007hc-OJ
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 08:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030600AbVIPGEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 02:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030603AbVIPGEl
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 02:04:41 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:63681 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030600AbVIPGEk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 02:04:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916060437.ZOGW3414.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 02:04:37 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509151243020.23242@iabervon.org> (Daniel
	Barkalow's message of "Thu, 15 Sep 2005 12:54:44 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8663>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Yup. I think I want to untangle some of the functions in commit.c, though, 
> because it wasn't sufficiently clear to me how those functions worked for 
> me to actually use the right one.

Sorry, *_gently was my fault.  The version without _gently was
there first, which issued its own complaints when it was fed a
non commit -- I presume that was OK for the purpose of whoever
wrote it first, but was not very useful when the caller wanted
to do its own "oh, if it is not a commit then I'll do this other
thing then" decision.
