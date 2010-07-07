From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/t0006: specify timezone as EST5 not EST to comply
 with POSIX
Date: Wed, 7 Jul 2010 14:12:21 -0400
Message-ID: <20100707181221.GA5299@coredump.intra.peff.net>
References: <20100704110017.GA23121@sigill.intra.peff.net>
 <upBu73z-yHJSTQ58c-Br0BxGwDzKGa1fPzZXA71AfI3kG3dMsRRPOX76JRJVhEOcDGoNaf1z9Lg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jul 07 20:12:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWZ6k-0001vC-TP
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 20:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756503Ab0GGSMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 14:12:24 -0400
Received: from peff.net ([208.65.91.99]:51863 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756199Ab0GGSMX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 14:12:23 -0400
Received: (qmail 20642 invoked by uid 107); 7 Jul 2010 18:13:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 07 Jul 2010 14:13:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Jul 2010 14:12:21 -0400
Content-Disposition: inline
In-Reply-To: <upBu73z-yHJSTQ58c-Br0BxGwDzKGa1fPzZXA71AfI3kG3dMsRRPOX76JRJVhEOcDGoNaf1z9Lg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150490>

On Tue, Jul 06, 2010 at 06:34:20PM -0500, Brandon Casey wrote:

> From: Brandon Casey <drafnel@gmail.com>
> 
> POSIX requires that both the timezone "standard" and "offset" be specified
> in the TZ environment variable.  This causes a problem on IRIX which does
> not understand the timezone 'EST'.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
> 
> I guess 'EST' is an alias? for EST5EDT?  Linux and Solaris both grok EST
> just fine.  POSIX says the offset is required.  I don't see any mention of
> aliases.

Yeah, I believe it is the same as EST5EDT. Which time zone isn't really
important. The main thing is that it be a negative offset from UTC, and
that we be able to convert the zone name into a numeric offset for the
date specified in the test (which is totally arbitrary and can be
tweaked if need be to avoid daylight saving issues).

So I think your patch is fine, but we can look harder if somebody finds
a platform that doesn't understand EST5.

-Peff
