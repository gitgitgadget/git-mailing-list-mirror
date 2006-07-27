From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 12:44:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607271232090.4168@g5.osdl.org>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com> 
 <20060727114105.GZ13776@pasky.or.cz>  
 <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> 
 <20060727131127.GA13776@pasky.or.cz>  <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
 <Pine.LNX.4.64.0607270936200.4168@g5.osdl.org>
 <Pine.LNX.4.63.0607271140100.11253@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 21:44:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6BmY-0005BA-3R
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 21:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbWG0To0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 15:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbWG0To0
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 15:44:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26814 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751960AbWG0ToZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 15:44:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6RJiAnW020185
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Jul 2006 12:44:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6RJi6du014030;
	Thu, 27 Jul 2006 12:44:08 -0700
To: David Lang <dlang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.63.0607271140100.11253@qynat.qvtvafvgr.pbz>
X-Spam-Status: No, hits=-0.558 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24335>



On Thu, 27 Jul 2006, David Lang wrote:
> 
> > (*) I will, in fact, claim that the difference between a bad programmer
> > and a good one is whether he considers his code or his data structures
> > more important. Bad programmers worry about the code. Good programmers
> > worry about data structures and their relationships.
> 
> personally I'd add to this that after the data structures are defined and you
> turn to the code the API is significantly more important then the code itself.

I think people sometimes put too much emphasis on ABI's. 

Sure, if you're depending on a library, the ABI is supremely important. 
But I literally believe that one of the things that makes open source 
technically superior to most other projects is the fact that ABI's can be 
changed more easily, and sometimes at all.

If you have good data structures, the ABI's are largely irrelevant, and if 
you have a problem with an existing ABI, you can just write a new 
entrypoint instead (and leave the old ABI alone).

On the other hand, if you have bad datastructures, the ABI often reflects 
that, and having the balls to say that your ABI's are broken and need to 
be re-done in order to fix the data structures is _very_ important. 
Otherwise you'll never be able to fix anything.

So I think that ABI's are often _way_ overhyped. If they are good, 
everybody is happy. But if the interfaces are bad, you had better be 
willing to just say "screw the ABI" and just fix it.

Now, that doesn't mean that you should change ABI's on a whim, and 
regardless of any other issues, your user base is always important. But I 
don't think ABI's are, or should be, "sacred".

For example, one thing git did early on was to just admit that some ABI's 
are horribly horribly bad. For example, the CVS "annotate" ABI is just a 
mistake, and trying to support that would just have held git back from 
realizing that you can be so much more.

That may not be a "Application Binary Interface" kind of ABI, but it's an 
interface, and it's exactly the same thing - sometimes you just have to 
have the cajones to say "screw that, we'll be so much better if we can 
change the interface".

		Linus
