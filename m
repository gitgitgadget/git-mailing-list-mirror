From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Permit refspec source side to parse as a sha1
Date: Fri, 21 Mar 2008 12:08:47 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803211148120.19665@iabervon.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org> <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803210014100.19665@iabervon.org> <7vmyosskyu.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803210134070.19665@iabervon.org>
 <7v3aqksic6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 17:10:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcjoD-0002JJ-CX
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 17:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbYCUQIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 12:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754636AbYCUQIv
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 12:08:51 -0400
Received: from iabervon.org ([66.92.72.58]:46748 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753587AbYCUQIu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 12:08:50 -0400
Received: (qmail 25193 invoked by uid 1000); 21 Mar 2008 16:08:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Mar 2008 16:08:47 -0000
In-Reply-To: <7v3aqksic6.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77746>

On Thu, 20 Mar 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Thu, 20 Mar 2008, Junio C Hamano wrote:
> > ...
> >> In any case, don't you agree that the patch you responded to is much
> >> easier to understand what we are (and we are not) checking than the
> >> original code?
> >
> > No, I think it's much more complicated. It mixes the semantics of what an 
> > empty side means for a particular use of refspecs into the parsing of the 
> > string. At the very least, the checks should be outside of _internal() in 
> > the functions for particular uses.
> 
> The thing is, the syntax is the same between fetch and push only to a
> degree.  They are both <LHS> ':' <RHS>.  What is allowed on LHS and RHS
> are quite different even at the syntactic level.

There's also the optional + at the beginning and the way of forming 
patterns, and the need to distinguish not having a colon with not having 
anything on one or the other side of the colon.

> I already know our criteria when judging if a particular code is clean or
> complex are _vastly_ different, from the experience working with you in
> other parts of the system (namely, read-tree 3-way rules and
> unpack_trees() rewrite that happened quite a long time ago).

Agreed.

And I do think that the rewrite of the part of the function before the 
semantic checks is clearer than the corresponding original (although the 
patch text made it hard to see; we really need some magic to make diff not 
bother to save 4 identifier-free lines and just show it as a complete 
replacement).

	-Daniel
*This .sig left intentionally blank*
