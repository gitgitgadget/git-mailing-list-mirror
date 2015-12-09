From: Jeff King <peff@peff.net>
Subject: Re: publish from certain commit onward, keeping earlier history
 private, but provable
Date: Wed, 9 Dec 2015 17:24:12 -0500
Message-ID: <20151209222412.GC21751@sigill.intra.peff.net>
References: <35583CFA-3BEE-4844-9F85-ED73A412A97F@joernhees.de>
 <20151209222041.GB21751@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?SsO2cm4=?= Hees <dev@joernhees.de>
X-From: git-owner@vger.kernel.org Wed Dec 09 23:24:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6n9o-00055K-7h
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 23:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbbLIWYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 17:24:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:39519 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751324AbbLIWYP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 17:24:15 -0500
Received: (qmail 2862 invoked by uid 102); 9 Dec 2015 22:24:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Dec 2015 16:24:15 -0600
Received: (qmail 14053 invoked by uid 107); 9 Dec 2015 22:24:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Dec 2015 17:24:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Dec 2015 17:24:12 -0500
Content-Disposition: inline
In-Reply-To: <20151209222041.GB21751@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282201>

On Wed, Dec 09, 2015 at 05:20:41PM -0500, Jeff King wrote:

> Of course that is a bitter pill to swallow if you have reasons for
> wanting to use the old sha1s. E.g., you have internal development
> proceeding against the old tree and want to share a truncated version
> with the public.

After re-reading your email, it looks like your use case is just to be
able to later prove the existence of the original history. You could
that by mentioning the original "C" in your truncated "D", but in a way
that git does not traverse reachability. For instance, amend D's commit
message to say:

  This is based on earlier, unpublished work going up to commit C.

Then retain C for yourself, and show it only to those you want to prove
its contents to.

-Peff
