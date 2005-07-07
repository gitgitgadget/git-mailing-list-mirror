From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 7 Jul 2005 15:52:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
 <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 01:02:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqfNg-0001sd-Ug
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 01:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVGGW7L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 18:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVGGWyI
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 18:54:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46286 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262431AbVGGWwo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 18:52:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j67MqWjA019923
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Jul 2005 15:52:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j67MqS8w031066;
	Thu, 7 Jul 2005 15:52:31 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050707221443.GB7151@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 8 Jul 2005, Petr Baudis wrote:

> Let me join the sceptics camp. :-)
> 
> Dear diary, on Thu, Jul 07, 2005 at 09:04:58PM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> told me that...
> > Note that I just re-packed the kernel archive on kernel.org, and removed 
> > _all_ unpacked files. Once that percolates to the mirrors, the http 
> > protocol will be useless without anything like this.
> 
> *grumble*
> 
> So, what _is_ then the way to pull now, actually? If we use rsync, won't
> we end up with having the objects we previous had twice now?

Rsync works fine. You can either unpack the pack you get, or, if you 
prefer, just run

	git-prune-packed

which will remove the stand-alone object that it finds in packs. Now 
you're no longer duplicating data, and your repository is smaller than it 
used to be anyway.

Of course, that requires that you trust the packs 100%. It seems to be 
stable, and I've packed the whole kernel repo, but I actually keep my 
private tree unpacked still just in case.

> I think it would be actually simplest (for the user) to have a trivial
> CGI script on the other side which will do the git-upload-pack stuff.

Well, git-upload-pack expects the other end to follow the proper protocol, 
but yes, you can certainly expose it through a web interface and a 
specialized client that way.

		Linus
