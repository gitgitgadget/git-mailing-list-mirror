From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add a few more values for
 receive.denyCurrentBranch
Date: Wed, 12 Nov 2014 12:13:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411121209330.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <f82aedcb632571d0b756d62c58479c0aab35b026.1415368490.git.johannes.schindelin@gmx.de> <xmqqvbmqg81g.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411101305510.13845@s15462909.onlinehome-server.info>
 <xmqqwq739hau.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 12:13:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoVri-0001rg-4x
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 12:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbaKLLNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 06:13:30 -0500
Received: from mout.gmx.net ([212.227.17.21]:53154 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbaKLLN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 06:13:29 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0Lxu7U-1Y2w5O1BS8-015Gqs;
 Wed, 12 Nov 2014 12:13:22 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqwq739hau.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:7ElL99+reuaHKGbXqXpF7SLi89pTKLDVuqD6P4jizcZLtP9d1Xx
 y9JwaWRCKZ1psFh1mUALj3eNKRaBiT7b0tJUybPgwBvXr3f16zaPRUrmLGEy4tEiGx6HdN0
 NqI5V+fKyQ1EolpnMzcI+Cms17UjdwiI9E0JCmQMdK4SwPHB5d14RHq5Fm8o6PYi3ASysAy
 9Tf0kDa6KacKgDoGE/RyA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 10 Nov 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I do not think of a good justification of detachInstead offhand, but
> >> you must have thought things through a lot more than I did, so you
> >> can come up with a work flow description that is more usable by mere
> >> mortals to justify that mode.
> >
> > The main justification is that it is safer than updateInstead because
> > it is guaranteed not to modify the working directory. I intended it
> > for use by developers who are uncomfortable with updating the working
> > directory through a push, and as uncomfortable with forgetting about
> > temporary branches pushed, say, via "git push other-computer
> > HEAD:refs/heads/tmp".
> >
> > However, I have to admit that I never used this myself after the first
> > few weeks of playing with this patch series.
> >
> >> Without such a description to justify why detachInstead makes sense,
> >> for example, I cannot even answer this simple question:
> >> 
> >>     Would it make sense to have a third mode, "check out if the
> >>     working tree is clean, detach otherwise"?
> >
> > I imagine that some developer might find that useful. If you insist, I
> > will implement it, even if I personally deem this mode way too
> > complicated a concept for myself to be used safely.
> 
> You have been around long enough to know that adding a feature of an
> unknown value is the last thing I would ask, don't you?

Given that you actually did ask me to add such a feature when I simply
wanted to get a bug fix for fast-export into Git to support Sverre's
remote-hg (that he abandoned because of my failure to get the bug fix in),
I have to respectfully declare that I do not know that, no, sorry!

> I am essentially saying this:
> 
>     I do not see why and the patch and its documentation do not
>     explain why it is useful, but Dscho wouldn't have added the
>     feature without a reason better than "just because we can do
>     so", so let's assume the mode is useful for some unknown reason.
>     Would people find "updateInstead if able otherwise
>     detachInstead" even more useful for that same unknown reason?

Okay, here is my explanation: at the time I wanted to disprove that
updateInstead could make sense, I wanted to offer a milder version of
updating the current branch that left the working directory alone:
detachInstead.

Now, I never used it myself, but I use updateInstead extensively.

So now I offer you two choices:

- help me come up with a good scenario where it makes sense to
  detachInstead, or

- tell me to drop it.

I have no preference.

Ciao,
Johannes
