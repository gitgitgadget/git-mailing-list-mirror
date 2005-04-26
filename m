From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Tue, 26 Apr 2005 13:58:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261347520.18901@ppc970.osdl.org>
References: <Pine.LNX.4.44.0504261301520.4678-100000@wax.eds.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 22:53:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQX1t-0005xG-MS
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 22:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVDZU4w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 16:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVDZU4w
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 16:56:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:65475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261558AbVDZU4s (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 16:56:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QKujs4025611
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 13:56:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QKuiAJ008420;
	Tue, 26 Apr 2005 13:56:45 -0700
To: Bram Cohen <bram@bitconjurer.org>
In-Reply-To: <Pine.LNX.4.44.0504261301520.4678-100000@wax.eds.org>
X-Spam-Status: No, hits=1.537 required=5 tests=NO_STRINGS
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Bram Cohen wrote:
> 
> Now that you're done being dismissive, could you either (a) rebut my quite
> detailed explanation of exactly why that functionality is both a dubious
> idea and difficult to implement, or (b) admit that you have no plans
> whatsoever for supporting any of this stuff? You can't have it both ways.

I'm absolutely not going to do it myself, you're right about that.

I just don't like your notion that you should support the 5% problem with
ugly hacks, and then you dismiss the 95% problem with "nothing else does 
it either".

In other words, we're already merging manually for the 95%. Why do you 
think the 5% is so important?

> What I'd really like to hear is some explanation of why git is
> reimplementing all of this stuff from scratch.

Git does in ~5000 lines and two weeks of work what _I_ think is the right 
thing to do. You're welcome to disagree, but the fact is, people have 
whined and moaned about my use of BK FOR THREE YEARS without showing me 
any better alternatives.

So why are you complaining now, when I implement my own version in two
weeks?

> If someone offers you a dollar, no strings attached, do you turn them down
> because they didn't offer you ten?

"no strings attached"?

There are lots of strings attached to the "follow renames" thing. There's 
30 _years_ of strings attached, and they result in people not looking at 
the _interesting_ problem.

Exactly because people follow renames, they think that they have the 
history of the code, but then they ignore the fact that they don't - 
because it doesn't follow merging of code or splitting of code.

In other words, it's sometimes better to know that you don't know the
answer, than it is to _think_ that you know the answer.

> In case these concepts got conflated, I'd like to point out that Codeville
> merge both supports renames *and* does better than three-way merge can do
> at merging a single, non-renamed file.

And I'd like to point out (again) that git doesn't actually care what 
merge strategy the user uses. 

Me _personally_, I want to have something that is very repeatable and
non-clever. Something I understand _or_ tells me that it can't do it. And
quite frankly, merging single-file history _without_ taking all the other
files' history into account makes me go "ugh".

That's why I like the "we do _not_ look for 'nearer' parents on a per-file
basis", which is what this discussion started with, afaik. I think the 
only original source that makes sense is the least common parent for the 
whole _project_, exactly because other files have done things that may or 
may not depend on the history of the file you're merging.

I (and thus git) really takes a "whole project" approach. 

			Linus
