From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] send-email: die if CA path doesn't exist
Date: Fri, 20 Nov 2015 06:18:48 -0500
Message-ID: <20151120111848.GC11198@sigill.intra.peff.net>
References: <27f354a4edb166e42006b0c1f778827a3dfd58ac.1447798206.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Nov 20 12:19:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzjib-0000nK-0g
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 12:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759821AbbKTLSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 06:18:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:60058 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753161AbbKTLSv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 06:18:51 -0500
Received: (qmail 17947 invoked by uid 102); 20 Nov 2015 11:18:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 05:18:51 -0600
Received: (qmail 26435 invoked by uid 107); 20 Nov 2015 11:19:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 06:19:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Nov 2015 06:18:48 -0500
Content-Disposition: inline
In-Reply-To: <27f354a4edb166e42006b0c1f778827a3dfd58ac.1447798206.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281506>

On Tue, Nov 17, 2015 at 10:12:07PM +0000, John Keeping wrote:

> If the CA path isn't found it's most likely to indicate a
> misconfiguration, in which case accepting any certificate is unlikely to
> be the correct thing to do.

Yeah, this seems like a crazy default for security-sensitive code.

I suspect some people will see breakage from applying this (because
their systems are broken and they did not know it), but that is a good
thing.

For people who know their systems are broken and want to proceed anyway,
what is the appropriate work-around? Obviously it involves disabling
peer verification, but would we want to include instructions for doing
so (either in the error message, or perhaps mentioning it in the commit
message)?

-Peff
