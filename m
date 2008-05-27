From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] clone: make sure we support the transport type
Date: Tue, 27 May 2008 13:49:56 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805271334490.19665@iabervon.org>
References: <200805271124.50172.trast@student.ethz.ch> <20080527142842.GA7651@sigill.intra.peff.net> <20080527163027.GB11865@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue May 27 19:51:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K13K0-0007bR-QX
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 19:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbYE0Rt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 13:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755212AbYE0Rt6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 13:49:58 -0400
Received: from iabervon.org ([66.92.72.58]:40188 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755309AbYE0Rt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 13:49:58 -0400
Received: (qmail 30382 invoked by uid 1000); 27 May 2008 17:49:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 May 2008 17:49:56 -0000
In-Reply-To: <20080527163027.GB11865@glandium.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83031>

On Tue, 27 May 2008, Mike Hommey wrote:

> On Tue, May 27, 2008 at 10:28:43AM -0400, Jeff King wrote:
> > If we use an unsupported transport (e.g., http when curl
> > support is not compiled in), transport_get reports an error
> > to the user, but we still get a transport object. We need to
> > manually check and abort the clone process at that point, or
> > we end up with a segfault.
> 
> Shouldn't transport_get return NULL in such a situation, instead ?

Perhaps, but we would still want to account for the possibility of a 
transport that only supports pushing or something like that, and therefore 
is available for the URL but isn't suitable for clone.

	-Daniel
*This .sig left intentionally blank*
