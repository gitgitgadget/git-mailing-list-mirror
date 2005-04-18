From: Paul Jackson <pj@sgi.com>
Subject: Re: using git directory cache code in darcs?
Date: Sun, 17 Apr 2005 19:00:01 -0700
Organization: SGI
Message-ID: <20050417190001.7e1ae3ac.pj@sgi.com>
References: <20050416132231.GJ2551@abridgegame.org>
	<Pine.LNX.4.58.0504161531470.7211@ppc970.osdl.org>
	<20050417121712.GA22772@abridgegame.org>
	<Pine.LNX.4.58.0504170916080.7211@ppc970.osdl.org>
	<4262E50C.2070006@lazy.shacknet.nu>
	<7vvf6lugw7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: lkml@lazy.shacknet.nu, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 03:57:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNLVh-0007s9-7d
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 03:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVDRCAp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVDRCAp
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:00:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:41118 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261594AbVDRCAc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 22:00:32 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3I2NpZI016342;
	Sun, 17 Apr 2005 19:23:56 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3I206lU15535652;
	Sun, 17 Apr 2005 19:00:08 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf6lugw7.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio wrote:
> What Linus is saying is that he wants you to talk with git
> plumbing by invoking the executables he have, via system(3),
> popen(3), etc.

Hopefully, Linus didn't specify system(3) or popen(3) for production
software.

They are a rich source of security holes.  Inefficient, too, since they
invoke a shell process to interpret the command.

Use execve(2), or exevl(3), execle(3), execv(3).

Or if you really enjoy the path search, use execlp or execvp, but with
your own $PATH, not trusting the one passed in via the environment any
further than you can throw it.

However, on further consideration, I think Linus is wrong to recommend
that the git executables, not a libgit library, be the 'basic user level
on which all else is based."

I will reply to a Linus post, expounding on that thought further.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
