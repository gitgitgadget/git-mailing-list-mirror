From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3 v3] Add support for external programs for handling
 native fetches
Date: Wed, 5 Aug 2009 16:58:23 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908051648580.2147@iabervon.org>
References: <alpine.LNX.2.00.0907310109130.2147@iabervon.org> <alpine.DEB.1.00.0908051143000.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051058130.2147@iabervon.org> <alpine.DEB.1.00.0908052231461.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:58:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnZ9-0000Po-HY
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbZHEU6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbZHEU6X
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:58:23 -0400
Received: from iabervon.org ([66.92.72.58]:50634 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbZHEU6X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:58:23 -0400
Received: (qmail 15246 invoked by uid 1000); 5 Aug 2009 20:58:23 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 20:58:23 -0000
In-Reply-To: <alpine.DEB.1.00.0908052231461.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124981>

On Wed, 5 Aug 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 5 Aug 2009, Daniel Barkalow wrote:
> 
> > On Wed, 5 Aug 2009, Johannes Schindelin wrote:
> > 
> > > On Fri, 31 Jul 2009, Daniel Barkalow wrote:
> > > 
> > > > +	}
> > > > +	strbuf_release(&buf);
> > > > +
> > > > +	for (posn = ret; posn; posn = posn->next)
> > > > +		resolve_remote_symref(posn, ret);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +int transport_native_helper_init(struct transport *transport)
> > > > +{
> > > > +	struct helper_data *data = xmalloc(sizeof(*data));
> > > > +	char *eom = strchr(transport->url, ':');
> > > 
> > > "End of message"?
> > 
> > "End of method"; that's the "method" part of a URL.
> 
> I'd have called that "protocol".  At least that's what java.net.URL 
> calls it, and I just assume that Sun is very much in love with standards, 
> so I could imagine they picked that term from the appropriate RFC.

Actually, it turns out to be officially "scheme" (although commonly called 
"protocol"). I'll just call the variable "colon" and avoid the whole 
issue, since it's not trying to really manage official URLs.

	-Daniel
*This .sig left intentionally blank*
