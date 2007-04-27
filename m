From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: FEATURE REQUEST: git-format-path: Add option to encode patch
 content
Date: Fri, 27 Apr 2007 14:40:33 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704271430490.9964@woody.linux-foundation.org>
References: <ps5qyry4.fsf@cante.net> <7vslalmwcx.fsf@assigned-by-dhcp.cox.net>
 <87y7kdo6pn.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Jari Aalto <jari.aalto@cante.net>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri Apr 27 23:41:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhYCK-0008Eu-3R
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 23:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355AbXD0VlT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 17:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757357AbXD0VlT
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 17:41:19 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:49875 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757355AbXD0VlQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2007 17:41:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3RLeYd9020549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Apr 2007 14:40:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3RLeXsv008502;
	Fri, 27 Apr 2007 14:40:34 -0700
In-Reply-To: <87y7kdo6pn.wl%cworth@cworth.org>
X-Spam-Status: No, hits=-3.007 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45757>



On Fri, 27 Apr 2007, Carl Worth wrote:
> 
> My MUA doesn't have support (that I know of) for piping a sequence of
> messages to a command. Do your MUAs? If not, how do people generally
> handle long sequences of [n/N] patch emails?

Well, in pine you *can* actually select a long sequence of messages, and 
then "a|" to "apply a pipe" to them, and ask for them to be sent as-is, 
and thus push them directly to git-am if you wanted to.

But quite frankly, I've never done it. It's _much_ easier to just select 
the messages, do "as" to "apply save", and just save them to a new mbox, 
and them apply that mbox in another xterm.

One reason I do that is that while I've trained my cadre of killer kernel 
development monkeys to send me emails in the proper format, I quite often 
end up editing away things like "Hi, please apply" and "thanks" etc. And I 
actually add my sign-offs manually.

(Of course, my "manual" sign-off is often a "search-and-replace" of the 
previous sign-off, so that I not only don't have to type that much, but 
also so that my workflow automatically guarantees that I only sign off on 
stuff that was signed off by the sender, and I notice if my 
search-and-replace says that it replaced 213 entries, even though I 
expected to have 214 emails there..)

I'm sure there are mail clients that don't support even that kind of basic 
automation ("Please save each email individually! Because mousing around 
is good for you! It's the only exercise you get!"), but I can't imagine 
that anybody uses them. So the "save to a file, go through it there, fix 
up, and apply" sequence is a pretty good one. And it scales really well.

(By "scales really well", I mean that I usually end up doing series of 
just a few emails. But occasionally I have batches either from a single 
user, or multiple different people who I batch up in one go, and I do tens 
and even hundreds of patches in one "go" - I do *not* want to switch 
back-and-forth between the email client and another xterm, but at the same 
time, email clients really aren't generally set up to doing things like 
search-and-replace etc on hundreds of messages at a time).

I'm sure if you use GNU emacs to read email, you could do it all within 
that emacs client, but I couldn't help you with that anyway.

		Linus
