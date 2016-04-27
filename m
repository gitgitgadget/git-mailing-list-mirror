From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: Support sending custom HTTP headers
Date: Wed, 27 Apr 2016 03:52:19 -0400
Message-ID: <20160427075219.GA32535@sigill.intra.peff.net>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
 <xmqq7fflleau.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1604260851390.2896@virtualbox>
 <20160426173853.GB7609@sigill.intra.peff.net>
 <alpine.DEB.2.20.1604270830220.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 27 09:52:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avKGp-0007ap-7E
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 09:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbcD0HwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 03:52:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:57092 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751988AbcD0HwX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 03:52:23 -0400
Received: (qmail 21513 invoked by uid 102); 27 Apr 2016 07:52:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Apr 2016 03:52:22 -0400
Received: (qmail 23537 invoked by uid 107); 27 Apr 2016 07:52:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Apr 2016 03:52:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Apr 2016 03:52:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1604270830220.2896@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292713>

On Wed, Apr 27, 2016 at 08:31:50AM +0200, Johannes Schindelin wrote:

> > +test_expect_success 'custom http headers' '
> > +	test_must_fail git fetch "$HTTPD_URL/smart_headers/repo.git" &&
> > +	git -c http.extraheader="x-magic-one: abra" \
> > +	    -c http.extraheader="x-magic-two: cadabra" \
> > +	    fetch "$HTTPD_URL/smart_headers/repo.git"
> > +'
> > +
> >  stop_httpd
> >  test_done
> 
> That's pretty easy.
> 
> After sleeping over the issue, I realized, though, that the test can use
> the very same method *I* used to verify that the headers are sent: using
> GIT_CURL_VERBOSE.
> 
> I hope you do not mind that I used this method instead.

TBH, I think mine is a little more robust, but I don't overly care
either way.

-Peff
