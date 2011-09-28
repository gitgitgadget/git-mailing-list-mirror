From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] parse-options: deprecate OPT_BOOLEAN
Date: Tue, 27 Sep 2011 23:58:09 -0400
Message-ID: <20110928035809.GC10662@sigill.intra.peff.net>
References: <7v39fhv8se.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 05:58:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8lHl-0000AN-77
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 05:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab1I1D6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 23:58:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45754
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904Ab1I1D6M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 23:58:12 -0400
Received: (qmail 31467 invoked by uid 107); 28 Sep 2011 04:03:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Sep 2011 00:03:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2011 23:58:09 -0400
Content-Disposition: inline
In-Reply-To: <7v39fhv8se.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182287>

On Tue, Sep 27, 2011 at 04:56:49PM -0700, Junio C Hamano wrote:

> It is natural to expect that an option defined with OPT_BOOLEAN() could be
> used in this way:
> [...]
> to easily tell three cases apart:
> 
>  - There is no mention of the `--option` on the command line;
>  - The variable is positively set with `--option`; or
>  - The variable is explicitly negated with `--no-option`.
> 
> Unfortunately, this is not the case. OPT_BOOLEAN() increments the variable
> every time `--option` is given, and resets it to zero when `--no-option`
> is given.

Yes, please. I remember being bitten by this at one point. Your
transition plan makes sense to me.

Can OPT_UYN be folded into this, as well?

-Peff
