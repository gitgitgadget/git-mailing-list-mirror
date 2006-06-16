From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Why so much time in the kernel?
Date: Fri, 16 Jun 2006 09:09:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606160906250.5498@g5.osdl.org>
References: <9e4733910606160749t4d7a541ev72a67383e96d86da@mail.gmail.com> 
 <Pine.LNX.4.64.0606160755170.5498@g5.osdl.org>
 <9e4733910606160825hb538d6fo4c9f1d7d9768e100@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 16 18:09:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrGss-0003rC-I7
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 18:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWFPQJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 12:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWFPQJT
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 12:09:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56509 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751474AbWFPQJT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 12:09:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5GG9Fgt010859
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Jun 2006 09:09:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5GG9EJe021979;
	Fri, 16 Jun 2006 09:09:15 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606160825hb538d6fo4c9f1d7d9768e100@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21946>



On Fri, 16 Jun 2006, Jon Smirl wrote:
>
> I am using cvs-1.11.21-3.2
> I can try running their development tree.

No, don't. We already know that 1.12 leaks memory and makes the cvsimport 
not work at all.

> > 
> > AND it's git-cvsimport forking and exec'ing git helper processes.
> 
> Is it worthwhile to make a library version of these? Svn has lib
> versions and they barely show up in oprofile. cvsimport is only using
> 4-5 low level git funtions.

Eventually, I think that's where we'll get. We're already at the stage 
where most of the core could just be written as a library.

> > I guess mozilla really does use a fair number of branches?
> 
> Is 1,800 a lot?

Yeah. Although even just two is enough, if you just alternate committing 
on them ;)

So it's actually not number of branches, it's more about frequency of 
the branch changing in the cvsps output. And yes, you could probably 
improve performance by sorting the changesets differently, but Martin's 
change to use separate index files should make it all pretty moot.

		Linus
