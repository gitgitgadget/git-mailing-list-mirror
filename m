From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5813: avoid creating urls that break on cygwin
Date: Mon, 9 Nov 2015 12:50:26 -0500
Message-ID: <20151109175025.GC29468@sigill.intra.peff.net>
References: <20151109154501.GA27224@sigill.intra.peff.net>
 <20151109174932.GA14146@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, adam@dinwoodie.org,
	ramsay@ramsayjones.plus.com
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:50:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvqaO-0000pl-Qx
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 18:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbbKIRu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 12:50:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:55083 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751845AbbKIRu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 12:50:28 -0500
Received: (qmail 10327 invoked by uid 102); 9 Nov 2015 17:50:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 11:50:28 -0600
Received: (qmail 18226 invoked by uid 107); 9 Nov 2015 17:50:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 12:50:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Nov 2015 12:50:26 -0500
Content-Disposition: inline
In-Reply-To: <20151109174932.GA14146@spirit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281071>

On Mon, Nov 09, 2015 at 06:49:35PM +0100, Dennis Kaarsemaker wrote:

> When passed an ssh:// url, git strips ssh://host from the url but does
> not remove leading slashes from the path. So when this test used
> ssh://remote//path/to/pwd, the path accessed by our fake SSH is
> //path/to/pwd, which cygwin interprets as a UNC path, causing the test
> to fail.
> 
> We may want to actually fix this in git itself, making it remove extra
> slashes from urls before feeding them to transports or helpers, but
> that's for another topic as it could cause regressions.
> 
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
> 
> You're right of course. Somehow I remembered that the fake ssh was doing the
> stripping, but didn't check that when writing the commit message. How about
> this version?

Looks good. Thanks.

-Peff
