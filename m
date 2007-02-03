From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Sat, 3 Feb 2007 13:41:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702031334400.8424@woody.linux-foundation.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
 <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org>
 <200702021055.49428.jnareb@gmail.com> <slrnes6mmr.3l6.mdw@metalzone.distorted.org.uk>
 <epvnln$fmn$1@sea.gmane.org> <Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
 <20070202175923.GA6304@xanadu.kublai.com> <20070202182709.GA3861@kobe.laptop>
 <Pine.LNX.4.64.0702021050350.15057@woody.linux-foundation.org>
 <20070203212030.GA91453@kobe.laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jnareb@gmail.com, mercurial@selenic.com, git@vger.kernel.org
To: Giorgos Keramidas <keramida@ceid.upatras.gr>
X-From: git-owner@vger.kernel.org Sat Feb 03 22:42:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDSe7-0001TO-Ix
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 22:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbXBCVl6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 16:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbXBCVl6
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 16:41:58 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50991 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbXBCVl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 16:41:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l13LflQ5001637
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 3 Feb 2007 13:41:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l13LfkTm016417;
	Sat, 3 Feb 2007 13:41:47 -0800
In-Reply-To: <20070203212030.GA91453@kobe.laptop>
X-Spam-Status: No, hits=-0.395 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.173 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38609>



On Sat, 3 Feb 2007, Giorgos Keramidas wrote:
> 
> Sure it is.  Maybe not in the context of all projects or all teams, but
> properly versioning tag names and knowing who installed the tag, and
> when is quite often an issue with unversioned tags in some of the teams
> I have worked with.

I don't understand why you argue. Everybody agrees. This is not what I've 
been arguing against.

Git tags too (unless you are lazyor just don't _want_ to version them) are 
versioned. It's the whole reason why git has a whole separate "tag space". 
Not only that, but they are evencryptographically signed (again, this is 
not forced on you, but it's part of standard practice in git projects) 
with an author key, so that the tag actually says a lot more than just the 
version - it also gives you authenticity guarantees.

In the gitk history viewer, when you click on the tag, it will show you 
that. It will show you who tagged it, and when, and if two people tag with 
the same tag-name (or the same person renames a tag), you can use that to 
see which one you have.

So nobody disputes at all that it's good to see that kind of detail.

What I claim is simple: tags are independent of history. The fact that you 
have the history, doesn't necessarily mean that you should have the tag. 
Because some tags make sense for some people.

And it's *not* about being private to a repository. The relevance simply 
isn't a black-and-white "one repo or all repos" kind of choice. For 
example, you might have private tags within a company, and not choose to 
export those outside of the company. 

		Linus
