From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] Feeding an annotated but unsigned tag to "git merge"
Date: Thu, 7 Jun 2012 05:09:33 -0400
Message-ID: <20120607090933.GB6087@sigill.intra.peff.net>
References: <1338926312-4239-1-git-send-email-gitster@pobox.com>
 <20120606134207.GB2597@sigill.intra.peff.net>
 <7vzk8gmm5b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 11:09:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScYiq-0000tX-JT
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 11:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760237Ab2FGJJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 05:09:36 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:46324
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760216Ab2FGJJf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 05:09:35 -0400
Received: (qmail 12878 invoked by uid 107); 7 Jun 2012 09:09:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Jun 2012 05:09:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jun 2012 05:09:33 -0400
Content-Disposition: inline
In-Reply-To: <7vzk8gmm5b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199384>

On Wed, Jun 06, 2012 at 09:37:52AM -0700, Junio C Hamano wrote:

> > This just doesn't make sense to me. Why would we treat annotated but
> > unsigned tags differently from signed tags? In both cases, the new
> > behavior is keeping more information about what happened, which is
> > generally a good thing.
> >
> > I haven't seen any good argument against creating these merges[1].
> 
> It is in line with --ff-only special casing, though.

Is it?  My impression from reading b5c9f1c is that --ff-only trumps both
annotated _and_ signed tags. Which makes sense to me. What I was
objecting to is that "some tag objects are more equal than others". It's
OK to treat unannotated tags differently from tag objects, but treating
annotated but unsigned objects differently from signed objects seems
unnecessary and complex.

> This was triggered by
> http://thread.gmane.org/gmane.comp.version-control.git/198828

The complaint in that thread mentions git's v1.7.10.2, which is signed,
and therefore would not be impacted by change. But perhaps that was
purely for illustrative purposes.

-Peff
