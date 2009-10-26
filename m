From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Mon, 26 Oct 2009 18:14:24 -0400
Message-ID: <20091026221424.GA28184@sigio.peff.net>
References: <7v7huspjg0.fsf@alter.siamese.dyndns.org> <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com> <20091022062145.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0910220226270.4985@pacific.mpi-cbg.de> <7vzl7h8fjp.fsf@alter.siamese.dyndns.org> <117f2cc80910240759oa9f57e7h67f06816d37e328c@mail.gmail.com> <alpine.DEB.1.00.0910262111340.4985@pacific.mpi-cbg.de> <32541b130910261340g1988caednc17f3d159ec00d26@mail.gmail.com> <20091026212628.GC27744@sigio.peff.net> <32541b130910261501n32046cc5s12283a8e3981d04e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 23:10:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Xm7-0006hw-KE
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 23:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412AbZJZWKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 18:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbZJZWKm
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 18:10:42 -0400
Received: from peff.net ([208.65.91.99]:54117 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754405AbZJZWKl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 18:10:41 -0400
Received: (qmail 28194 invoked by uid 1000); 26 Oct 2009 22:14:24 -0000
Content-Disposition: inline
In-Reply-To: <32541b130910261501n32046cc5s12283a8e3981d04e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131276>

On Mon, Oct 26, 2009 at 06:01:29PM -0400, Avery Pennarun wrote:

> > It's git-update-ref.
> 
> That would be similar to git commit, not git checkout, right?  Oh
> wait, I see the confusion: git checkout does two things.  It switches
> branches, and it checks out files from the index into the work tree.
> I meant the latter meaning.

Er, sorry, yes. It should be "git symbolic-ref", of course, to change
HEAD, and then probably read-tree and checkout-index. I was just not
thinking when I wrote the other message (hopefully I am doing so now).

> > Consider "git commit", for example. Does anyone
> > actually script around "write-tree" and "commit-tree" these days, or do
> > they just script around "git commit"?
> 
> Oh, I use those all the time.  They're awesome!  It allows you to
> create commits without having a working tree, which lets me do very
> interesting tricks.  git-subtree uses this heavily.
> 
> I'm probably a weirdo, though.

OK, I should have phrased my statement differently (see, I told you I
wasn't thinking). Yes, there are reasons to script around low-level
building blocks, when you don't want the assumptions associated with the
higher level. But I'm sure there are tons of scripts that munge some
files in a worktree, followed by "git add -A; git commit -m 'automagic
update'". And in that case, nobody would script around "commit-tree"
because it's a lot more work.

-Peff
