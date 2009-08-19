From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] stash: reject stash name starting with a dash.
Date: Wed, 19 Aug 2009 05:57:16 -0400
Message-ID: <20090819095716.GA28920@sigill.intra.peff.net>
References: <7vbpmcc1sc.fsf@alter.siamese.dyndns.org>
 <1250631523-10524-1-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-2-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-3-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-4-git-send-email-Matthieu.Moy@imag.fr>
 <20090818233535.GB6304@sigill.intra.peff.net>
 <vpq8whg1ebi.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 11:57:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdhv9-0006q9-5K
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 11:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbZHSJ5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 05:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbZHSJ5T
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 05:57:19 -0400
Received: from peff.net ([208.65.91.99]:60251 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbZHSJ5R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 05:57:17 -0400
Received: (qmail 18557 invoked by uid 107); 19 Aug 2009 09:57:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 19 Aug 2009 05:57:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Aug 2009 05:57:16 -0400
Content-Disposition: inline
In-Reply-To: <vpq8whg1ebi.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126528>

On Wed, Aug 19, 2009 at 08:57:05AM +0200, Matthieu Moy wrote:

> >> +test_expect_success 'stash --invalid-option' '
> >> +       echo bar5 > file &&
> >> +       echo bar6 > file2 &&
> >> +       git add file2 &&
> >> +       ! git stash --invalid-option &&
> >> +       test bar5,bar6 = $(cat file),$(cat file2) &&
> >> +       git stash -- -message-starting-with-dash &&
> >> +       test bar,bar2 = $(cat file),$(cat file2)
> >> +'
> >
> > Should this actually be "git stash save --invalid-option", since it is
> > really testing the actual save option parsing, and not the behavior to
> > automatically push options to "git stash save"?
> 
> It could be, but the most annoying DWIM would be the "implicit save"
> case, so that's the one I'm testing. One could test both, but that'd
> probably be a bit overkill.

But if your proposal to accept any "-*' is not accepted, then it is not
testing your added code at all, is it? Even without the rest of the
patch, the test would pass.

-Peff
