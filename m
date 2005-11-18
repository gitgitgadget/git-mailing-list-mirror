From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 13:13:01 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511181301320.13959@g5.osdl.org>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182208.24248.ismail@uludag.org.tr>
 <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <200511182245.01713.ismail@uludag.org.tr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 22:13:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdDXv-0000j8-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 22:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161247AbVKRVNU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 16:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbVKRVNU
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 16:13:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39338 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161247AbVKRVNT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 16:13:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAILD7nO030362
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 13:13:08 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAILD1RN000725;
	Fri, 18 Nov 2005 13:13:04 -0800
To: Ismail Donmez <ismail@uludag.org.tr>
In-Reply-To: <200511182245.01713.ismail@uludag.org.tr>
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12262>



On Fri, 18 Nov 2005, Ismail Donmez wrote:
> 
> Maybe you could officially require all commit messages to be UTF-8 then the 
> problem would be just solved for future commits at least.

Just think about what that would mean for a second.

What do people put in commit messages? They put things like filenames, to 
indicate that they changed file so-and-so because of issue so-and-so, or 
they needed to include header file so-and-so to fix a problem.

So by virtue of forcing all commit messages to be in UTF-8, you've 
suddenly forced all filesystems to do UTF-8 too.

Take that one step further: you've also forced all the file _contents_ 
you talk about to be in UTF-8, since the commit message might quote part 
of the file ("'xyzzy' was misspelled, it should be 'abcde'").

Or alternatively, you've forced the commit message to no longer match the 
reality that it tries to explain.

See the problem?

And that's ignoring the fact that you've unilaterally forced probably 50% 
of asian users to use an environment that they don't normally use.

Remember: it's actually pretty _easy_ for most of the western world to 
move to UTF-8, because 99% of what we do doesn't really care one whit, and 
the remaining 1% isn't usually even a huge problem (ie it's such a small 
percentage that even if you show the wrong character for it, people 
understand what it said).

There's only one thing that is easier still: to force your way of working 
on others. 

This is why I'm so steadfast on it being just a stream of bytes. Because 
let's face it, no english-speaking project will ever _really_ care: we'll 
get a few peoples names wrong, but it's all going to be pretty irrelevant, 
and there's not going to be any real confusion.

In contrast, _forcing_ people to use UTF-8 results in real problems, and 
really limits what can be done. 

A data stream of 8-bit bytes is really powerful. And oh, btw, it just 
happens to be the UNIX way.

			Linus
