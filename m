From: Jeff King <peff@peff.net>
Subject: Re: [RFC] sending errors to stdout under $PAGER
Date: Sun, 17 Feb 2008 13:15:23 -0500
Message-ID: <20080217181523.GA4818@coredump.intra.peff.net>
References: <7vbq6g90gy.fsf@gitster.siamese.dyndns.org> <20080217144854.56fcb98d.froese@gmx.de> <7vd4qv1n78.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Edgar Toernig <froese@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 19:16:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQo3a-0007bx-Mn
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 19:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbYBQSP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 13:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbYBQSP1
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:15:27 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2549 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314AbYBQSPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 13:15:25 -0500
Received: (qmail 3093 invoked by uid 111); 17 Feb 2008 18:15:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 17 Feb 2008 13:15:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Feb 2008 13:15:23 -0500
Content-Disposition: inline
In-Reply-To: <7vd4qv1n78.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74151>

On Sun, Feb 17, 2008 at 09:56:27AM -0800, Junio C Hamano wrote:

> > Wouldn't it be better/safer to redirect stderr to the pager
> > in the first place?
> >
> > So, instead of the current
> >
> > 	foo | less
> > use
> > 	foo 2>&1 | less
> 
> I like it.  Much nicer.  Thanks.

This will also put the stderr of any sub-programs into the pager, which
is probably worse if you have, e.g., a chatty external diff program. I
don't know if we care enough about that.

-Peff
