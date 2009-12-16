From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] ignore unknown color configuration
Date: Tue, 15 Dec 2009 22:45:29 -0500
Message-ID: <20091216034529.GA9742@sigill.intra.peff.net>
References: <20091212122524.GA17547@coredump.intra.peff.net>
 <7vzl5nn9x2.fsf@alter.siamese.dyndns.org>
 <20091212222046.GA25973@coredump.intra.peff.net>
 <7vzl5mjndi.fsf@alter.siamese.dyndns.org>
 <7v3a3bwvzj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 04:45:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKkpW-0004zu-UB
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 04:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbZLPDpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 22:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbZLPDpe
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 22:45:34 -0500
Received: from peff.net ([208.65.91.99]:58944 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbZLPDpd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 22:45:33 -0500
Received: (qmail 1424 invoked by uid 107); 16 Dec 2009 03:50:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 15 Dec 2009 22:50:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Dec 2009 22:45:29 -0500
Content-Disposition: inline
In-Reply-To: <7v3a3bwvzj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135320>

On Tue, Dec 15, 2009 at 05:25:36PM -0800, Junio C Hamano wrote:

> >> I would be more sympathetic to that user if this weren't the _only_ set
> >> of variables with this property. They don't get warned for diff.externel
> >> or color.show-branch.
> >
> > True and fair enough.  Let's have this in 1.6.6 then.
> 
> Actually I think we should have this in 1.6.5.X as well for it to be
> useful.  Am I mistaken?

The earlier the better for making it useful, but it is still somewhat of
a lost cause for color.diff.func. The problem comes from using git
v1.6.6, setting the variable, and then going to back to some older
version (either because you are testing multiple versions, or because
your config is shared across multiple machines).

So yes, putting it in v1.6.5.x means switching back there will not be as
painful. But switching back to existing versions will still be broken
until all older versions you might want to switch to have this patch.

So we are not so much fixing this color.diff.func problem as
future-proofing against this happening again.

-Peff
