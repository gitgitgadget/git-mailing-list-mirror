From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [GIT PULL] ARM updates
Date: Wed, 8 Jun 2005 17:06:17 +0100
Message-ID: <20050608170617.B28042@flint.arm.linux.org.uk>
References: <20050608143549.GA7074@dyn-67.arm.linux.org.uk> <Pine.LNX.4.58.0506080802150.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:54:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg3nY-0008Aa-KH
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 18:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVFHQ4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 12:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVFHQtf
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 12:49:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40716 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261367AbVFHQGY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2005 12:06:24 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Dg34N-0002Jf-12; Wed, 08 Jun 2005 17:06:19 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1Dg34L-0000pV-RK; Wed, 08 Jun 2005 17:06:17 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0506080802150.2286@ppc970.osdl.org>; from torvalds@osdl.org on Wed, Jun 08, 2005 at 08:15:09AM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 08, 2005 at 08:15:09AM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 8 Jun 2005, Russell King wrote:
> > 
> > Please incorporate the latest ARM changes, which can be found at:
> > 
> > 	master.kernel.org:/home/rmk/linux-2.6-arm.git
> 
> Heh, this one showed a problem with some git-apply sanity checks (I use 
> "git-apply --stat" to generate the diffstat). 
> 
> In particular:
> 
> > This will update the following files:
> > 
> >  arch/arm/mm/minicache.c                |   73 ------------------
> 
> You didn't actually delete the file, you made it be zero-sized. Which made 
> the patch header be
> 
>   diff --git a/arch/arm/mm/minicache.c b/arch/arm/mm/minicache.c
>   --- a/arch/arm/mm/minicache.c
>   +++ b/arch/arm/mm/minicache.c
>   @@ -1,73 +0,0 @@
>   ...
> 
> and git-apply complains about the fact that the patch deletes the file,
> but the file still exists (it can tell both from this: it sees that this
> is not a "delete" event, since a "diff --git" would have had a "delete"
> header line in it, but it also sees that it's a delete because the patch
> has no result lines, ie the final "+0,0" means that there was nothing
> left).

Hey, it's my first time at using git directly rather than the currently
broken cogito - I had to do everything manually.  See my last message
to the git mailing list.

> In contrast, the "copypage-xscale.S" file really _was_ deleted by your 
> changes, not just made empty.

That's because I remembered that one was deleted.  This change was
something which had been lingering for about a week while someone
tested it, so of course I'd forget what was created and removed by
it.

-- 
Russell King

