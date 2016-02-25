From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] t/lib-http/apache.conf: load mod_unixd module in
 apache 2.4
Date: Thu, 25 Feb 2016 17:00:45 -0500
Message-ID: <20160225220045.GA10267@sigill.intra.peff.net>
References: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:01:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ3xy-0006ee-Hx
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbcBYWAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 17:00:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:49423 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751623AbcBYWAx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 17:00:53 -0500
Received: (qmail 26933 invoked by uid 102); 25 Feb 2016 22:00:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 17:00:47 -0500
Received: (qmail 25579 invoked by uid 107); 25 Feb 2016 22:00:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 17:00:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Feb 2016 17:00:45 -0500
Content-Disposition: inline
In-Reply-To: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287444>

On Thu, Feb 25, 2016 at 10:57:11AM -0800, Jacob Keller wrote:

> From: Jacob Keller <jacob.keller@gmail.com>
> 
> Since 2.4, apache will fail to load unless mod_unixd is loaded in order
> to drop privileges.
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> 
> I am not sure why this wasn't there already, but I am unable to run
> httpd 2.4.18 without it, on Fedora 23.
> 
>  t/lib-httpd/apache.conf | 3 +++
>  1 file changed, 3 insertions(+)

Michael (cc'd) posted an identical patch with some more discussion back
in May:

  http://article.gmane.org/gmane.comp.version-control.git/268770

The series languished because none of the reviewers had systems that
reproduced the problem, and I think there's some additional work needed
to get all of the svn-over-http tests running[1].

I think this bit should be OK to take without the rest (though I like
the extra discussion in the original).

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/284349
