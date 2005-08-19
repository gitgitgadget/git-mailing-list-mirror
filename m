From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Spell __attribute__ correctly in cache.h.
Date: Fri, 19 Aug 2005 12:53:59 -0700
Message-ID: <7v64u1ya7c.fsf@assigned-by-dhcp.cox.net>
References: <7vk6ii1emh.fsf@assigned-by-dhcp.cox.net>
	<4091.1124463516@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 21:55:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6CwI-00068W-Ss
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 21:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbVHSTyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 15:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbVHSTyD
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 15:54:03 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:54461 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965127AbVHSTyB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 15:54:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050819195400.IABH7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 Aug 2005 15:54:00 -0400
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> And Junio C Hamano writes:
>  - It turns out that your patch breaks GCC build 
>
> Whoops, sorry.  Your fix works with Sun's cc.  

Thanks.

> BTW, how would people feel about replacing the 
> setenv() and unsetenv() calls with the older putenv()?
> The Solaris version I have to work on doesn't have 
> the nicer functions (and I'm not an admin).  I have 
> to check that the unsetenv() in git-fsck-cache.c works 
> correctly as a putenv before I send along a patch.  

No comment on this one at this moment until I do my own digging
a bit.

> There's also the issue that /bin/sh isn't bash, but an 
> installation-time helper script can fix that.

My personal preference is to rewrite parts that are easily
unbashified first before going that route, but I suspect that it
would end up being the best practical solution to simply admit
that we depend on bash, start our scripts with "#!/bin/bash",
and rewrite them "#!/usr/local/bin/bash" upon installation;
modulo that it may be a stupid and ugly workaround.
