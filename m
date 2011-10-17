From: Jeff King <peff@peff.net>
Subject: Re: What should "git fetch origin +next" should do?
Date: Mon, 17 Oct 2011 13:10:41 -0400
Message-ID: <20111017171041.GA12837@sigill.intra.peff.net>
References: <7v7h45s8rh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 19:10:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFqi8-000784-M5
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 19:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756600Ab1JQRKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 13:10:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33926
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753476Ab1JQRKn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 13:10:43 -0400
Received: (qmail 8397 invoked by uid 107); 17 Oct 2011 17:10:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Oct 2011 13:10:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Oct 2011 13:10:41 -0400
Content-Disposition: inline
In-Reply-To: <7v7h45s8rh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183799>

On Sun, Oct 16, 2011 at 12:20:02AM -0700, Junio C Hamano wrote:

> I just tried to update one of them with "git pull --ff-only", and after
> seeing that the fetch phase failed with non-ff on 'next', ran
> 
> 	$ git fetch origin +next
> 
> which happily copied the tip of updated next to FETCH_HEAD and nowhere
> else. Of course, a colon-less refspec means do not store it anywhere,
> i.e. "<colon-less-refspec>" === "<colon-less refspec>:", so prefixing it
> with '+' to force would logically be a no-op.  But it nevertheless was
> somewhat surprising and irritating.

I don't see that this has anything to do with the "+" at all. If I said:

  $ git fetch origin next

I think the exact same confusion exists. I told git to update 'next'
from origin, but it didn't touch refs/remotes/origin/next. You and I
both know what is happening, because we understand that "next" is a
refspec, and that it has no RHS.  But I suspect that is not how many git
users think of it.

We've discussed this before, of course:

  http://thread.gmane.org/gmane.comp.version-control.git/127163/focus=127215

-Peff
