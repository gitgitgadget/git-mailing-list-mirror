From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-daemon server
Date: Sun, 5 Jun 2005 11:11:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506051105510.1876@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506031727400.30848-100000@iabervon.org> 
 <Pine.LNX.4.58.0506031450190.1876@ppc970.osdl.org> <1117990178.10424.15.camel@port.evillabs.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 20:07:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DezVv-0006TK-7t
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 20:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVFESJl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 14:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVFESJl
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 14:09:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:10448 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261597AbVFESJX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 14:09:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j55I9HjA008016
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Jun 2005 11:09:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j55I9Gw9016434;
	Sun, 5 Jun 2005 11:09:17 -0700
To: Jason McMullan <jason.mcmullan@timesys.com>
In-Reply-To: <1117990178.10424.15.camel@port.evillabs.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 5 Jun 2005, Jason McMullan wrote:
>
> On Fri, 2005-06-03 at 14:59 -0700, Linus Torvalds wrote:
> > Me, I want to have a fairly simple script that does the equivalent of what
> > I do now for pushing:
> > 
> > 	rsync -av --delete --exclude-from=.exclude .git/ master.kernel.org:/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> > 
> > except I'd want it to do the locking and the "only accept trivial pushes" 
> > stuff (ie no merging, just a pure update).
> 
> 
> $ GITCONNECTION="--tcp ...."

Nope. I'm not going to run untrusted deamons of my own on master.

I'm serious about the "ssh or nothing" thing. Anything but a direct ssh 
conection is simply not an option.

		Linus
