From: Bram Cohen <bram@bitconjurer.org>
Subject: Re: Merge with git-pasky II.
Date: Tue, 26 Apr 2005 13:31:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504261301520.4678-100000@wax.eds.org>
References: <Pine.LNX.4.58.0504261256150.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 22:29:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQWe6-0001mB-9f
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 22:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVDZUcB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 16:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVDZUcA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 16:32:00 -0400
Received: from wax.eds.org ([64.147.163.246]:10937 "EHLO wax.eds.org")
	by vger.kernel.org with ESMTP id S261620AbVDZUbb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 16:31:31 -0400
Received: by wax.eds.org (Postfix, from userid 1044)
	id 2E6EA324028; Tue, 26 Apr 2005 13:31:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by wax.eds.org (Postfix) with ESMTP
	id 2C22EB401A; Tue, 26 Apr 2005 13:31:31 -0700 (PDT)
X-X-Sender: bram@wax.eds.org
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261256150.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:

> On Tue, 26 Apr 2005, Bram Cohen wrote:
> >
> > If one person renames a file and another person modifies it then the
> > changes should be applied to the moved file.
>
> Bzzt. Wrong answer.

I'm trying to be polite. You're not making that easy.

> The _right_ answer is "if one person moves a function, and another person
> modifies the function, the changes should be applied to the moved
> function".

Now that you're done being dismissive, could you either (a) rebut my quite
detailed explanation of exactly why that functionality is both a dubious
idea and difficult to implement, or (b) admit that you have no plans
whatsoever for supporting any of this stuff? You can't have it both ways.

What I'd really like to hear is some explanation of why git is
reimplementing all of this stuff from scratch. Your implicit claims that
git will do more things than the other systems without having to reinvent
all of their functionality first are, honestly, naive, ill-informed
arrogance.

I'd like to reiterate that *nothing* out there supports moving lines
between files, and further predict, with total confidence, that if git
tries to support such functionality it will simply fail, either by giving
up or creating a system which can behave horribly. Before you get all
dismissive about this claim, please remember that I've spent years
thinking about merge algorithms, and have actually designed and
implemented them, and have spoken at length with other people who have
done the same, while you've merely thought about them for a few weeks.

> Which is clearly a _much_ more common case than file renames.

Even if we pretend that these are comparable features, that's far from
clearly true. Function moves within a file occur more frequently, but a
file rename moves *all* the functions within that file.

> In other words, if your algorithm doesn't handle the latter, then there is
> no point in handling the former either.

If someone offers you a dollar, no strings attached, do you turn them down
because they didn't offer you ten?

> And _if_ your algorithm handles the latter, then there's no point in
> handling file renames specially, since the algorithm will have done that
> too, as a small part of it.

In case these concepts got conflated, I'd like to point out that Codeville
merge both supports renames *and* does better than three-way merge can do
at merging a single, non-renamed file. In most cases three-way and
codeville merge give the same answer, but there are some cases where there
isn't a single appropriate LCA available, and in those cases codeville
will do the right thing while three-way can't.

-Bram

