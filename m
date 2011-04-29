From: Jeff King <peff@github.com>
Subject: Re: [PATCH] blame: Improve parsing for emails with spaces
Date: Fri, 29 Apr 2011 15:13:55 -0400
Message-ID: <20110429191355.GC27268@sigill.intra.peff.net>
References: <1303423656-32002-1-git-send-email-jistone@redhat.com>
 <20110429131103.GB4540@sigill.intra.peff.net>
 <7vvcxxvsz4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Josh Stone <jistone@redhat.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 21:14:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFt8e-0002E8-0k
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 21:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760752Ab1D2TN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 15:13:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34170
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567Ab1D2TN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 15:13:58 -0400
Received: (qmail 15603 invoked by uid 107); 29 Apr 2011 19:15:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Apr 2011 15:15:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2011 15:13:55 -0400
Content-Disposition: inline
In-Reply-To: <7vvcxxvsz4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172491>

On Fri, Apr 29, 2011 at 10:59:43AM -0700, Junio C Hamano wrote:

> > Hmm. That address seems bogus, and I wonder if we should be rejecting it
> > at commit time. Still, it is something we may run across in existing
> > repositories, so handling it more gracefully makes sense.
> 
> Perhaps but within reason.  
> 
> What new types of breakages are we proposing to tolerate, what breakages
> are we declaring not worth fixing, and what is the price of not loosening
> this?  Without this patch, such a broken commit will result in the author
> email shown somewhat broken, but the original is already broken to begin
> with, and also the entry for the blamed line will come with its commit
> object name anyway, so I do not think it is such a big deal.

I'm pretty sure such an address would make a non-rfc822-compliant "from"
header when used with format-patch. But given that it is obviously a
bogus address, I don't think there's much we can do anyway, and anyone
looking at will say "Oh, that's wrong". So it's probably not a big deal.

-Peff
