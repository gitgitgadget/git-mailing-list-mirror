From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 17:17:32 -0400
Message-ID: <F9443EC8-A8F7-47D7-AC64-AEC476E7223F@mac.com>
References: <20050429203959.GC21897@waste.org> <20050429203959.GC21897@waste.org> <20050430025211.GP17379@opteron.random> <42764C0C.8030604@tmr.com> <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bill Davidsen <davidsen@tmr.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 23:14:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSiEl-0003ju-4k
	for gcvg-git@gmane.org; Mon, 02 May 2005 23:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVEBVSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 17:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVEBVSu
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 17:18:50 -0400
Received: from smtpout.mac.com ([17.250.248.87]:12501 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261781AbVEBVRn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 17:17:43 -0400
Received: from mac.com (smtpin07-en2 [10.13.10.152])
	by smtpout.mac.com (Xserve/8.12.11/smtpout05/MantshX 4.0) with ESMTP id j42LHVYX012382;
	Mon, 2 May 2005 14:17:31 -0700 (PDT)
Received: from [10.0.0.2] (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin07/MantshX 4.0) with ESMTP id j42LHRdZ005701
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Mon, 2 May 2005 14:17:29 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On May 2, 2005, at 12:31:06, Linus Torvalds wrote:
> That said, I think the /usr/bin/env trick is stupid too. It may be  
> more
> portable for various Linux distributions, but if you want _true_
> portability, you use /bin/sh, and you do something like
>
>     #!/bin/sh
>     exec perl perlscript.pl "$@"

Oooh, I can one-up that hack with this evil from perlrun(1):

#!/bin/sh -- # -*- perl -*- -W -T
eval 'exec perl -wS $0 ${1+"$@"}'
     if 0;
# PERL SCRIPT HERE

Description:
Perl ignores the eval($string) because of the "if 0" in the  
statement. The
shell sees the statement end at the newline, and executes it faithfully.
The end result is that the preferred Perl gets the script.  I don't know
Python, so I don't know if such a trick exists there.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



