From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] submodule status: remove unused orig_* variables
Date: Mon, 29 Oct 2012 03:27:19 -0400
Message-ID: <20121029072719.GE5102@sigill.intra.peff.net>
References: <CABURp0op2+QUvusUmAFUxT8s8c02bB9V3=ag9gTTSiiN4t96OA@mail.gmail.com>
 <1351278834-28867-1-git-send-email-hordp@cisco.com>
 <508AE4AB.4070209@web.de>
 <508DA58C.2040504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Hord <hordp@cisco.com>,
	Git Mailing List <git@vger.kernel.org>, phil.hord@gmail.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 29 08:27:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSjl1-0007NB-JG
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 08:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab2J2H1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 03:27:23 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41887 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525Ab2J2H1W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 03:27:22 -0400
Received: (qmail 16445 invoked by uid 107); 29 Oct 2012 07:28:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 03:28:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 03:27:19 -0400
Content-Disposition: inline
In-Reply-To: <508DA58C.2040504@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208600>

On Sun, Oct 28, 2012 at 10:37:16PM +0100, Jens Lehmann wrote:

> When renaming orig_args to orig_flags in 98dbe63d (submodule: only
> preserve flags across recursive status/update invocations) the call site
> of the recursive cmd_status was forgotten. At that place orig_args is
> still passed into the recursion, which is always empty since then. This
> did not break anything because the orig_flags logic is not needed at all
> when a function from the submodule script is called with eval, as that
> inherits all the variables set by the option parsing done in the first
> level of the recursion.
> 
> Now that we know that orig_flags and orig_args aren't needed at all,
> let's just remove them from cmd_status().
> 
> Thanks-to: Phil Hord <hordp@cisco.com>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>

I'll replace your earlier fix (which just fixes the s/args/flags/ and
adds a test) with Phil's patch, and this on top.

Thanks.

-Peff
