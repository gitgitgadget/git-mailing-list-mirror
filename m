From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] grep with textconv
Date: Sat, 20 Apr 2013 00:26:29 -0400
Message-ID: <20130420042629.GE24970@sigill.intra.peff.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
 <7vhaj21ir3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 06:26:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTPNk-0006ff-Rb
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 06:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793Ab3DTE0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 00:26:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:44591 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601Ab3DTE0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 00:26:32 -0400
Received: (qmail 8011 invoked by uid 102); 20 Apr 2013 04:26:38 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Apr 2013 23:26:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Apr 2013 00:26:29 -0400
Content-Disposition: inline
In-Reply-To: <7vhaj21ir3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221836>

On Fri, Apr 19, 2013 at 11:24:16AM -0700, Junio C Hamano wrote:

> >   grep: allow to use textconv filters
> 
> This looked mostly sensible except for one minor "eh, do we really
> need to assume textconv output is text, or wouldn't using the same
> codepath for raw blob and textconv result to make them consistently
> honor opt->binary easier to explain?".

I don't mind re-checking the textconv output for binary-ness. But I did
it that way for consistency with the diff code-path, which also assumes
that textconv output is not binary.

> By the way, "git log --no-merges | grep obey | wc -l" shows that we
> say "honor an option" a lot more than "obey an option".  We may want
> to be consistent here.

Yeah, it is a pretty minor thing, but I agree that "honor" sounds
better.

-Peff
