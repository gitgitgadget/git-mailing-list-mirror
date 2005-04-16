From: Ingo Molnar <mingo@elte.hu>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 21:41:26 +0200
Message-ID: <20050416194126.GA28429@elte.hu>
References: <20050416131528.GB19908@elte.hu> <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 21:38:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMt7Q-0000jU-Vo
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 21:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVDPTl6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 15:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVDPTl5
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 15:41:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41172 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262742AbVDPTly (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 15:41:54 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 1565F3195F3;
	Sat, 16 Apr 2005 21:40:35 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 3B1CB1FC2; Sat, 16 Apr 2005 21:41:29 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > the history data starts at 2.4.0 and ends at 2.6.12-rc2. I've included a 
> > script that will apply all the patches in order and will create a 
> > pristine 2.6.12-rc2 tree.
> 
> Hey, that's great. I got the CVS repo too, and I was looking at it, 
> but the more I looked at it, the more I felt that the main reason I 
> want to import it into git ends up being to validate that my size 
> estimates are at all realistic.
> 
> I see that Thomas Gleixner seems to have done that already, and come 
> to a figure of 3.2GB for the last three years, which I'm very happy 
> with, mainly because it seems to match my estimates to a tee. [...]

(yeah, we apparently worked in parallel - i only learned about his 
efforts after i sent my mail. He was using BK to extract info, i was 
using the CVS tree alone and no BK code whatsoever. (I dont think there 
will be any argument about who owns what, but i wanted to be on the safe 
side, and i also wanted to see how complete and usable the CVS metadata 
is - it's close to perfect i'd say, for the purposes i care about.))

> But I wonder if we actually want to actually populate the whole 
> history..

yeah, it definitely feels a bit brave to import 28,000 changesets into a 
source-code database project that will be a whopping 2 weeks old in 2 
days ;) Even if we felt 100% confident about all the basics (which we do 
of course ;), it's just simply too young to tie things down via a 3.2GB 
database. It feels much more natural to grow it gradually, 28,000 
changesets i'm afraid would just suffocate the 'project growth 
dynamics'. Not going too fast is just as important as not going too 
slow.

I didnt generate the patchset to get it added into some central 
repository right now, i generated it to check that we _do_ have all the 
revision history in an easy to understand format which does generate 
today's kernel tree, so that we can lean back and worry about the full 
database once things get a bit more settled down (in a couple of months 
or so). It's also an easy testbed for GIT itself.

but the revision history was one of the main reasons i used BK myself, 
so we'll need a merged database eventually. Occasionally i needed to 
check who was the one who touched a particular piece of code - was that 
fantastic new line of code written by me, or was that buggy piece of 
crap written by someone else? ;) Also, looking at a change and then 
going to the changeset that did it, and then looking at the full picture 
was pretty useful too. So that sort of annotation, and generally 
navigating around _quickly_ and looking at the 'flow' of changes going 
into a particular file was really useful (for me).

	Ingo
