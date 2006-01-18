From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 10:03:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601180957460.3240@g5.osdl.org>
References: <200601181325.59832.Mathias.Waack@rantzau.de>
 <20060118125158.GN28365@pasky.or.cz> <20060118140917.GA15438@mythryan2.michonline.com>
 <Pine.LNX.4.64.0601180813170.3240@g5.osdl.org> <20060118170536.GS28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ryan Anderson <ryan@michonline.com>,
	Mathias Waack <Mathias.Waack@rantzau.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 19:04:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzHev-0006Gw-LE
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 19:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWARSDi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 13:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWARSDi
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 13:03:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964798AbWARSDh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 13:03:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0II3NDZ016790
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Jan 2006 10:03:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0II3M0H013531;
	Wed, 18 Jan 2006 10:03:23 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060118170536.GS28365@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14848>



On Wed, 18 Jan 2006, Petr Baudis wrote:
> 
> Well, the recursive merge strategy is at least advertised to be able to
> merge across renames (as long as they are autodetected).

Yes. It can. However, the git merge approach fundamentally expects that 
the merged trees _converge_. 

So what happens is that if two trees continue to be developed as separate 
trees, and the merges never converge (ie they happen just one way, with 
the other way seldom or never merging back), the merge strategy will get 
increasingly bad.

That's pretty unavoidable, btw. I can pretty much guarantee that nobody 
else will really do it any better, although any particular strategy will 
always handle one particular case perfectly (*).

			Linus

(*) I think merging is like scheduling: you can always find a perfect 
scheduling algorithm _after_the_fact_ when you know the load, but finding 
one that works for all loads inevitably means that some cases won't work 
well. You also find scheduling getting an inordinate amount of time in CS 
literature, while in real life it's one of the least important problems of 
a kernel.
