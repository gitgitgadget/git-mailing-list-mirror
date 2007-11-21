From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] avoid "defined but not used" warning for fetch_objs_via_walker
Date: Wed, 21 Nov 2007 13:05:01 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711211303460.32410@iabervon.org>
References: <20071118081722.GA31563@sigill.intra.peff.net>
 <7v63zwhy4i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 19:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IutxJ-0000Pv-Pf
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 19:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbXKUSFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 13:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbXKUSFG
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 13:05:06 -0500
Received: from iabervon.org ([66.92.72.58]:50505 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbXKUSFE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 13:05:04 -0500
Received: (qmail 14884 invoked by uid 1000); 21 Nov 2007 18:05:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Nov 2007 18:05:02 -0000
In-Reply-To: <7v63zwhy4i.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65689>

On Tue, 20 Nov 2007, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Because this function is static and used only by the
> > http-walker, when NO_CURL is defined, gcc emits a "defined
> > but not used" warning.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > On master. I like to compile with -Werror to make sure I don't miss
> > warnings as the compile scrolls by.
> >
> > This fix feels a little wrong, since the function isn't specific to http
> > support, but hopefully the comment should be obvious if we ever add
> > another similar commit walker that needs it.
> 
> Yeah, while I share your -Werror desire it sure feels a bit
> dirty.  As it does not look like we will be taking any new
> walkers, I think your patch is reasonable, though.

I think we're likely to do sftp someday, but everything is likely to get 
reorganized before that anyway.

	-Daniel
*This .sig left intentionally blank*
