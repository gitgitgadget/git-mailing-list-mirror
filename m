From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 19:45:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601101938420.26999@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
 <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org> <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
 <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
 <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com> <Pine.LNX.4.64.0601101015260.4939@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kyle Moffett <mrmacman_g4-ee4meeAH724@public.gmane.org>,
	Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Luben Tuikov <ltuikov-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>,
	"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Junio C Hamano <junkio-j9pdmedNgrk@public.gmane.org>,
	"David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	LKML Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>,
	Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Tue Jan 10 19:45:44 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwOUl-0000C4-F5
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Tue, 10 Jan 2006 19:45:23 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S1751131AbWAJSpW (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Tue, 10 Jan 2006 13:45:22 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S1751174AbWAJSpW
	(ORCPT <rfc822;linux-acpi-outgoing>);
	Tue, 10 Jan 2006 13:45:22 -0500
Received: from mail.gmx.net ([213.165.64.21]:5298 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751131AbWAJSpU (ORCPT
	<rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Tue, 10 Jan 2006 13:45:20 -0500
Received: (qmail invoked by alias); 10 Jan 2006 18:45:18 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp028) with SMTP; 10 Jan 2006 19:45:18 +0100
X-Authenticated: #1490710
X-X-Sender: gene099-0FSg3roeNkip/NMfPcZd5MorA1QR8sqKCSifqQdEqSIb1SvskN2V4Q@public.gmane.org
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0601101015260.4939-hNm40g4Ew95AfugRpC6u6w@public.gmane.org>
X-Y-GMX-Trusted: 0
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

On Tue, 10 Jan 2006, Linus Torvalds wrote:

> 
> On Tue, 10 Jan 2006, Kyle Moffett wrote:
> >
> > On Jan 10, 2006, at 01:38, Martin Langhoff wrote:
> > > 
> > > The more complex your tree structure is, the more the interactions are
> > > likely to be part of the problem. Is git-bisect not useful in this scenario?
> > 
> > IIRC git-bisect just does an outright linearization of the whole tree anyways,
> > which makes git-bisect work everywhere, even in the presence of difficult
> > cross-merges.
> 
> It's not really a linearization - at no time does git-bisect _order_ the 
> commits. After all, no linear order actually exists. 
> 
> Instead, it really cuts the tree up into successively smaller parts. 
> 
> Think of it as doing a binary search in a 2-dimensional surface - you 
> can't linearize the plane, but you can decide to test first one half of 
> the surface, and then depending on whether it was there, you can halve 
> that surface etc.. 

How?

If you bisect, you test a commit. If the commit is bad, you assume *all* 
commits before that as bad. If it is good, you assume *all* commits after 
that as good.

Now, if you have a 2-dimensional surface, you don't have a *point*, but 
typically a *line* separating good from bad.

Further, the comparison with 2 dimensions is particularly bad. You 
*have* partially linear development lines, it got *nothing* to do with 
an area. The commits still make up a *list*, and it depends how you 
*order* that list for bisect. (And don't tell me they are not ordered: 
they are.)

If you order the commits by date, you don't get anything meaningful point 
before which it is bad, and after which it is good.

So, how is bisect supposed to work if you don't have one straight 
development line from bad to good?

Ciao,
Dscho


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
