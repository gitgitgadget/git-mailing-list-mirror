From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 12:21:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702021214260.15057@woody.linux-foundation.org>
References: <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org>
 <200702021055.49428.jnareb@gmail.com> <slrnes6mmr.3l6.mdw@metalzone.distorted.org.uk>
 <epvnln$fmn$1@sea.gmane.org> <Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
 <20070202175923.GA6304@xanadu.kublai.com> <Pine.LNX.4.64.0702021027450.15057@woody.linux-foundation.org>
 <20070202192640.GA7963@ventoux.cs.ubc.ca> <Pine.LNX.4.64.0702021130020.15057@woody.linux-foundation.org>
 <20070202195504.GC7963@ventoux.cs.ubc.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, mercurial@selenic.com,
	git@vger.kernel.org
To: Brendan Cully <brendan@kublai.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 21:21:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD4ue-0000SF-1g
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 21:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946050AbXBBUVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 15:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946051AbXBBUVd
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 15:21:33 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38565 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946050AbXBBUVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 15:21:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l12KLP43016173
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Feb 2007 12:21:25 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l12KLOCh016737;
	Fri, 2 Feb 2007 12:21:24 -0800
In-Reply-To: <20070202195504.GC7963@ventoux.cs.ubc.ca>
X-Spam-Status: No, hits=-0.412 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38534>



On Fri, 2 Feb 2007, Brendan Cully wrote:
> 
> The public tags on the public history get pushed. This still sounds to
> me like the right thing.

And what happens if you have two public tags?

Ok, now you have answered the "how is this tying them together" question 
yourself.

Notice? You tied them together, by tying them to something else.

And that is what I say is WRONG. Tags are independent, because different 
people have different needs for them.

Yes, you can say that the tags that the "main developer" does are "magic", 
and should always follow the history. But EVEN THAT is wrong. Because it 
makes a supposition that should not be one. You shouldn't start out with 
the assumption that there is one centralized place that makes the 
decisions. It may be how most open source projects work, but it's not what 
the tool should enforce. Especially when projects break/fork/whatever, the 
tool should _support_ that. It shouldn't say "ok, those people are 
special, what they do is special".

> > So tags are *events*. But if you think they are events "within" the 
> > history of a tree, you're missing a big issue.
> 
> Your distinction between "history" and "events" is unclear to
> me. What's history if not a series of events?

A lot of events are *independent*.

You seem to think that there is a dependency between tags that simply 
isn't there! You think it's ok to push them all out, because they are all 
"related". THAT IS NOT TRUE.

> Mercurial supports local tags too. As far as I can tell, these
> unversioned tags are about equivalent to git tags. They could
> certainly be used for your bisection scenario.

Can you push out your local tags? 

A tag isn't "globally local" or "globally global". *MY* local tags make 
sense on my machines. It's just that they don't make sense on the public 
tree. They're not "local to a repository". They are LOCAL TO MY NETWORK.

See? That's the kind of behaviour that git supports. You can publish one 
set of tags, and not publish another. They're not "different tags", and 
not publishing them in one place does NOT mean that you can't publish them 
somewhere else.

		Linus
