From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 12:15:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504161208410.7211@ppc970.osdl.org>
References: <20050416131528.GB19908@elte.hu>  <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
  <1113679421.28612.16.camel@tglx.tec.linutronix.de> 
 <Pine.LNX.4.58.0504161135480.7211@ppc970.osdl.org>
 <1113681021.28612.29.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 21:10:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMsgC-0006B9-Rk
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 21:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVDPTNu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 15:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVDPTNu
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 15:13:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:9122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262733AbVDPTNr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 15:13:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3GJDcs4004154
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Apr 2005 12:13:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3GJDbwD024297;
	Sat, 16 Apr 2005 12:13:38 -0700
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1113681021.28612.29.camel@tglx.tec.linutronix.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, Thomas Gleixner wrote:
> 
> For the export stuff its terrible slow. :(

I don't really see your point.

If you already know what the tree is like you say, you don't care about
the tree object. And if you don't know what the tree is, what _are_ you
doing?

In other words, show us what you're complaining about. If you're looking
into the trees yourself, then the binary representation of the sha1 is
already what you want. That _is_ the hash. So why do you want it in ASCII?  
And if you're not looking into the tree directly, but using "cat-file
tree" and you were hoping to see ASCII data, then that's certainly not
going to be any faster than just doing "ls-tree" instead.

In other words, I don't see your point. Either you want ascii output for 
scripting, or you don't. First you claimed that you did, and that you 
would want the tree object to change in order to do so. Now you claim that 
you can't use "ls-tree" because it's too slow. 

That just isn't making any sense. You're mixing two totally different
levels, and complaining about performance when scripting things. Yet
you're talking about a 20-byte data structure that is trivial to convert
to any format you want.

What kind of _strange_ scripting architecture is so fast that there's a
difference between "cat-file" and "ls-tree" and can handle 17,000 files in
60,000 revisions, yet so slow that you can't trivially convert 20 bytes of 
data?

		Linus
