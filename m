From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: fetch_refs_via_pack() discards status?
Date: Thu, 6 Dec 2007 09:09:22 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712060907420.5349@iabervon.org>
References: <b8bf37780711211659i4d621533o6a3b97349bb75f8c@mail.gmail.com>
 <20071122160959.GA3411@steel.home> <b8bf37780711221427q5dda709dt38ce1837c0e56c1f@mail.gmail.com>
 <b8bf37780711251339y796286fbj2cd8d9225008e13@mail.gmail.com>
 <7v3aunqvha.fsf_-_@gitster.siamese.dyndns.org> <7vk5nt1v7k.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712051356040.5349@iabervon.org> <7vwsrsonqm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 15:09:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0HQD-0007al-FP
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 15:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbXLFOJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 09:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbXLFOJ1
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 09:09:27 -0500
Received: from iabervon.org ([66.92.72.58]:40987 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbXLFOJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 09:09:27 -0500
Received: (qmail 30026 invoked by uid 1000); 6 Dec 2007 14:09:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Dec 2007 14:09:22 -0000
In-Reply-To: <7vwsrsonqm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67287>

On Wed, 5 Dec 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Tue, 4 Dec 2007, Junio C Hamano wrote:
> >
> >> The code calls fetch_pack() to get the list of refs it fetched, and
> >> discards refs and always returns 0 to signal success.
> >> 
> >> But builtin-fetch-pack.c::fetch_pack() has error cases.  The function
> >> returns NULL if error is detected (shallow-support side seems to choose
> >> to die but I suspect that is easily fixable to error out as well).
> >> 
> >> Shouldn't fetch_refs_via_pack() propagate that error to the caller?
> >
> > I think that's right. I think I got as far as having the error status from 
> > fetch_pack() actually returned correctly, and then failed to look at it. 
> > I'd personally avoid testing a pointer to freed memory, but that's 
> > obviously not actually wrong.
> >
> > 	-Daniel
> 
> Hmph, is that an Ack that the patchlet is actually a bugfix?

Yes.

Acked-By: Daniel Barkalow <barkalow@iabervon.org>

	-Daniel
*This .sig left intentionally blank*
