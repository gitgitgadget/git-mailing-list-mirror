From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Specify a precision for the length of a subject string
Date: Fri, 23 Dec 2011 05:09:58 -0500
Message-ID: <20111223100957.GA1247@sigill.intra.peff.net>
References: <20111220220754.GC21353@llunet.cs.wisc.edu>
 <20111221043843.GA20714@sigill.intra.peff.net>
 <20111221145112.GA13097@llunet.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: nathan.panike@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 23 11:10:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re24m-00070X-CT
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 11:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756524Ab1LWKKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 05:10:04 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51711
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756523Ab1LWKKC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 05:10:02 -0500
Received: (qmail 32167 invoked by uid 107); 23 Dec 2011 10:16:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Dec 2011 05:16:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Dec 2011 05:09:58 -0500
Content-Disposition: inline
In-Reply-To: <20111221145112.GA13097@llunet.cs.wisc.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187623>

On Wed, Dec 21, 2011 at 08:51:13AM -0600, Nathan Panike wrote:

> > Hmm. I think the idea of limiting is OK (though personally, I would just
> > pipe through a filter that truncates long lines). But I'm a bit negative
> > on adding a tweak like this that only affects the subject. Is there a
> > reason I couldn't do %30gs, or %30f, or even some other placeholder?
> 
> The ones that make sense to limit are all those that depend on the subject, as the
> above; it does not make sense to limit other fields that don't depend on the
> subject, as they are fixed width, or have small variance. And it does not make
> sense to me to limit the length of the body.

I agree the subject is the most likely place. I was thinking one might
want to do it with the body, too. But whether it would be "I want N
bytes of the body" or "truncate each body line at N bytes without
wrapping", I don't know.

-Peff
