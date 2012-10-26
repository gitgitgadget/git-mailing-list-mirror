From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] submodule status: properly pass options with --recursive
Date: Fri, 26 Oct 2012 09:15:07 -0400
Message-ID: <20121026131507.GA2747@sigill.intra.peff.net>
References: <5089BB2D.90400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 15:15:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRjl1-0002p8-KA
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 15:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837Ab2JZNPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 09:15:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37849 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932766Ab2JZNPK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 09:15:10 -0400
Received: (qmail 22487 invoked by uid 107); 26 Oct 2012 13:15:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Oct 2012 09:15:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2012 09:15:07 -0400
Content-Disposition: inline
In-Reply-To: <5089BB2D.90400@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208439>

On Fri, Oct 26, 2012 at 12:20:29AM +0200, Jens Lehmann wrote:

> When renaming orig_args to orig_flags in 98dbe63d (submodule: only
> preserve flags across recursive status/update invocations) the call site
> of the recursive cmd_status was forgotten. At that place orig_args is
> still passed into the recursion, which is always empty now. This clears
> all options when recursing, as that variable is never set.
> 
> Fix that by renaming orig_args to orig_flags there too and add a test to
> catch that bug.

Thanks. I back-ported your patch on top of 98dbe63d so it can go to
'maint'. I'm curious, though: why didn't the test right before (which
checks recursion for --cached) catch this?

-Peff
