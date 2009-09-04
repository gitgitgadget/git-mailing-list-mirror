From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/8] Allow fetch to modify refs
Date: Fri, 4 Sep 2009 12:29:53 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909041225080.28290@iabervon.org>
References: <alpine.LNX.2.00.0909032213260.28290@iabervon.org> <alpine.DEB.1.00.0909041243420.4605@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 04 18:30:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjbfm-0000qO-22
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 18:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933686AbZIDQ3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 12:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932870AbZIDQ3v
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 12:29:51 -0400
Received: from iabervon.org ([66.92.72.58]:37948 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933646AbZIDQ3v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 12:29:51 -0400
Received: (qmail 32483 invoked by uid 1000); 4 Sep 2009 16:29:53 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2009 16:29:53 -0000
In-Reply-To: <alpine.DEB.1.00.0909041243420.4605@intel-tinevez-2-302>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127746>

On Fri, 4 Sep 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 3 Sep 2009, Daniel Barkalow wrote:
> 
> > +	/**
> > +	 * Fetch the objects for the given refs. Note that this gets
> > +	 * an array, and should ignore the list structure.
> 
> This is not clear at all.  You should rather say "[...] and should not 
> look at, or set, the 'next' member of the refs".

That is a better wording, yes.

> > +	 *
> > +	 * If the transport did not get hashes for refs in
> > +	 * get_refs_list(), it should set the old_sha1 fields in the
> > +	 * provided refs now.
> 
> Not the "new_sha1"?

No, because get_refs_list() sets the old_sha1, and this isn't indicating 
anything different. The old/new thing is to indicate that the ref is 
changing value. What's happening here is that the ref isn't changing value 
but we didn't know what value it always (effectively) had until now.

> > +	 **/
> > +	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
> > +
> > [...]
> > +	/** get_refs_list(), fetch(), and push_refs() can keep
> 
> The "/**" wants to have a line to itself.

Good point, thanks.

	-Daniel
*This .sig left intentionally blank*
