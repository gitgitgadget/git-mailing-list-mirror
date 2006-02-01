From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Wed, 1 Feb 2006 08:25:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602010815480.21884@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> 
 <1138446030.9919.112.camel@evo.keithp.com>  <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
  <1138529385.9919.185.camel@evo.keithp.com>  <43DCA495.9040301@gorzow.mm.pl>
 <20060130225107.GA3857@limbo.home>  <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
  <20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com> 
 <46a038f90601311852ie8cfac0rbe92779edea4da1b@mail.gmail.com>
 <81b0412b0602010655i7b538bdck2baa216203279bce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Ray Lehtiniemi <rayl@mail.com>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>,
	Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 17:27:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Koa-0005SA-Av
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 17:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWBAQ0h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 11:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWBAQ0h
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 11:26:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50154 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932434AbWBAQ0g (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 11:26:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k11GPbDZ009311
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Feb 2006 08:25:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k11GPaMh013065;
	Wed, 1 Feb 2006 08:25:36 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0602010655i7b538bdck2baa216203279bce@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15427>



On Wed, 1 Feb 2006, Alex Riesen wrote:
> 
> $ time git update-index --refresh
> 
> real    0m21.500s
> user    0m0.358s
> sys     0m1.406s
> 
> WinNT, NTFS, 13k files, hot cache.

That's 25% less files than the Linux kernel, and I can do that operation 
in 0m0.062s (0.012s user, 0.048s system).

So WinNT/cygwin is about 2.5 _orders_of_maginitude_ slower here, or 340 
times slower.

Now, I'm tempted to say that NT is a piece of sh*t, but the fact is, your 
CPU-times seem to indicate that most of it is IO (and the "real" cost is 
just 1.7 seconds, much of which is system time, which in turn itself is 
probably due to the IO costs too - so even that isn't comparable with 
the ).

Which may mean that you simply don't have enough memory to cache the whole 
thing. Which may be NT sucking, of course ("we don't like to use more than 
10% of memory for caches"), but it might also be a tunable (which is sucky 
in itself, of course), but finally, it might just be that you just don't 
have a ton of memory. I've got 2GB in my machines, although 1GB is plenty 
to cache the kernel.

			Linus
