From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking
 pickier
Date: Sun, 10 Feb 2008 17:34:17 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802101724170.13593@iabervon.org>
References: <20080209162234.GA25533@fieldses.org> <alpine.LNX.1.00.0802091251430.13593@iabervon.org> <20080209185038.GB25533@fieldses.org> <7vr6fletkl.fsf@gitster.siamese.dyndns.org> <7vabm9gk1p.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802101502320.13593@iabervon.org>
 <7v8x1sfprd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:34:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOKlE-0003iC-Hy
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 23:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbYBJWeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 17:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbYBJWeW
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 17:34:22 -0500
Received: from iabervon.org ([66.92.72.58]:49982 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbYBJWeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 17:34:21 -0500
Received: (qmail 14583 invoked by uid 1000); 10 Feb 2008 22:34:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Feb 2008 22:34:17 -0000
In-Reply-To: <7v8x1sfprd.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73428>

On Sun, 10 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Sun, 10 Feb 2008, Junio C Hamano wrote:
> >
> >> I've tried "unexpand | expand" to Documentation/*.txt and
> >> compared the formatted documentation before and after the
> >> change, and as we suspected everything seems to match.
> >> 
> >> So I am considering applying this patch.  We may want to tighten
> >> it later but as the initial set of rules this should do.
> >
> > I think it's worthwhile to note that some of the files under t/ have 
> > whitespace that doesn't conform to the rest of the project.
> 
> Yes.  I tried to be careful with the set of attribute files I
> sent out not to corrupt them.  Was I unsuccessful?

Your patch wouldn't corrupt them, but also didn't explicitly protect them. 
A later change to regularize git shell scripts would look reasonable but 
risk messing with them, for example.

> > On the other hand, I think this patch is an odd combination of stuff; 
> > aren't the contrib exceptions not exceptional, since only *.[ch] and *.txt 
> > gets declared as "whitespace"?
> 
> True, how about this instead?

That makes things more clear, although I'd still like a t/.gitattributes 
that meant that, regardless of the project's policies in general, t/ files 
may care about whitespace, so we don't have to worry about that in future 
changes to the top level .gitattributes. And I'm actually curious as to 
whether t/ should have some protection against crlf conversion. (I haven't 
tried checking git out with different crlf-conversion settings and seeing 
whether the tests still work as intended)

	-Daniel
*This .sig left intentionally blank*
