From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3] Add support for external programs for handling native
 fetches
Date: Sat, 25 Jul 2009 15:09:13 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907251446460.2147@iabervon.org>
References: <alpine.LNX.2.00.0907251330240.2147@iabervon.org> <20090725184526.GB11191@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 21:09:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmcT-0007Pi-Gn
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 21:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbZGYTJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 15:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbZGYTJO
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 15:09:14 -0400
Received: from iabervon.org ([66.92.72.58]:37386 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbZGYTJO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 15:09:14 -0400
Received: (qmail 7021 invoked by uid 1000); 25 Jul 2009 19:09:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jul 2009 19:09:13 -0000
In-Reply-To: <20090725184526.GB11191@spearce.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124057>

On Sat, 25 Jul 2009, Shawn O. Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > +Commands are given by the caller on the helper's standard input, one per line.
> > +
> > +'list'::
> > +	Outputs the names of refs followed by the hex of their values
> > +	or "@<name>" for symrefs, one per line. After the complete
> > +	list, outputs a blank line.
> 
> I hate to be a nit, but why this format and not the one that is
> produced by `git ls-remote` and the native protocol?  I know its
> pretty arbitrary either way, but since we already have a history
> of using "SHA1 ref\n" why not continue that tradition here?

In the VCS protocol, the SHA1 is generally not known when simply listing 
refs, so I didn't have a useless initial field in that protocol; I just 
inherited having the line start with the name for this protocol.

In any case, I want to be able to support symrefs, so an extension to the 
tradition is required, but putting @<dest> before the name instead of 
after is easy enough.

	-Daniel
*This .sig left intentionally blank*
