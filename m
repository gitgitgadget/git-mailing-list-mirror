From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Wed, 1 Feb 2006 11:29:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602011124090.21884@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <1138529385.9919.185.camel@evo.keithp.com> <43DCA495.9040301@gorzow.mm.pl>
 <20060130225107.GA3857@limbo.home> <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
 <20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
 <Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
 <Pine.LNX.4.64.0602011909330.6498@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ray Lehtiniemi <rayl@mail.com>, Alex Riesen <raa.lkml@gmail.com>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>,
	Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 20:33:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Nj0-0006RV-SB
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 20:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422890AbWBATdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 14:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422892AbWBATdE
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 14:33:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422890AbWBATdC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 14:33:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k11JT8DZ020675
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Feb 2006 11:29:09 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k11JT7gn022748;
	Wed, 1 Feb 2006 11:29:07 -0800
To: Julian Phillips <julian@quantumfyre.co.uk>
In-Reply-To: <Pine.LNX.4.64.0602011909330.6498@beast.quantumfyre.co.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15434>



On Wed, 1 Feb 2006, Julian Phillips wrote:
> 
> As it happens, yes ... I can't say that I've noticed git being particularly
> slow, but then - I've not tried running git with a local repos ... ;)

Well, NFS seems to be ok. Which is not that surprising: NFS has gotten a 
_lot_ of attention in the caching area (I worked on it myself a couple of 
years back when the page cache transition happened during 2.3.x, but 
happily we've had very good NFS maintainership since, so I don't get 
involved any more).

Your numbers show that NFS is fine (my "benchmark" is that I refuse to see 
the kinds of commit times that "cvs commit" does - easily several minutes 
for a big project. If it goes over 2 seconds, it's painful, and over ten 
seconds is totally unacceptable).

Your numbers seem to say that at least with a good network/server, NFS on 
Linux is not a problem at all.

CIFS is likely a very different animal. I suspect the cifs people have 
spent a whole lot more effort on strange Windows interaction issues than 
on trying to make sure that cached performance is top-notch.

			Linus
