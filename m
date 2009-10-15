From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD was
Date: Fri, 16 Oct 2009 00:56:31 +0200
Message-ID: <200910160056.33217.trast@student.ethz.ch>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <alpine.LFD.2.00.0910151504510.20122@xanadu.home> <alpine.LNX.2.00.0910151517070.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Oct 16 01:07:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyZPP-0007QQ-Cp
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 01:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763279AbZJOW6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 18:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763120AbZJOW6Q
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 18:58:16 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:56999 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758757AbZJOW6P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 18:58:15 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 00:57:28 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 00:57:07 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <alpine.LNX.2.00.0910151517070.32515@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130437>

Daniel Barkalow wrote:
> On Thu, 15 Oct 2009, Nicolas Pitre wrote:
> 
> > On Thu, 15 Oct 2009, Daniel Barkalow wrote:
> > 
> > > I think the description used in CVS and SVN (and, I think, others) is that 
> > > you're not at the HEAD revision.
[...]
> > > * origin/master (not at head)
> > > $ git checkout 123cafe^5; git branch
> > > * 123cafe^5 (not at head)
> > 
> > I think this is wrong.  Git has multiple heads, and insisting on "not at 
> > head" would be extremely confusing.
> 
> Maybe "(not at a head)"? Git does have multiple heads, but what's checked 
> out isn't one of them, and that's actually the point.

Please don't reuse 'head' (even lowercase) in this context/meaning.  I
see enough people coming to IRC who are confused about the fact that
they checked out some old commit, hence HEAD is just that, but they
refer to the *newest* commit on whatever branch they like most as HEAD
because that's what it means in SVN.

Now imagine having to explain to them that their (SVN) 'HEAD' is not
the same as git's 'HEAD', but can rightly be considered the equivalent
of master's 'head'; and that furthermore, you are always at 'HEAD' but
not always at 'head'.

I think in this case '(detached)' would be more consistent with
current terminology, though we may of course try to change it.

(I've tried to consistently use 'tip' in the branch tip meaning,
admittedly without knowing exactly how this intersects with
mercurial's definition of the term.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
