From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] log --grep: honor grep.patterntype etc.
 configuration variables
Date: Thu, 4 Oct 2012 14:01:22 -0400
Message-ID: <20121004180122.GB2623@sigill.intra.peff.net>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
 <1349314419-8397-7-git-send-email-gitster@pobox.com>
 <20121004081732.GD31305@sigill.intra.peff.net>
 <7vehle18y5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:39:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtex-00033L-29
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874Ab2JDSBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 14:01:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40833 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751Ab2JDSBY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 14:01:24 -0400
Received: (qmail 22464 invoked by uid 107); 4 Oct 2012 18:01:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 14:01:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 14:01:22 -0400
Content-Disposition: inline
In-Reply-To: <7vehle18y5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207016>

On Thu, Oct 04, 2012 at 09:46:42AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm. So I think this is a nice feature for some people, but I wonder if
> > we would run into any plumbing compatibility issues. People do tend to
> > use "log" as plumbing (since rev-list is not as capable). On the other
> > hand, I'd think most internal uses of "log --grep" would be passing
> > something along from the user, and the user would be happy to have it
> > interpreted by their chosen set of rules.
> 
> This does make "rev-list --grep" aware of the configuration but at
> the same time --basic-regexp and friends are also available to it.

Does it? I thought the patch only tweaked git_log_config. Am I
misreading?

Having --basic-regexp is a nice escape hatch, but it would be a
regression for older scripts which were written before --basic-regexp
existed (or was necessary).

-Peff
