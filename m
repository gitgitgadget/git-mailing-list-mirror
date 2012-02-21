From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] Do attempt pretty print in ASCII-incompatible
 encodings
Date: Tue, 21 Feb 2012 13:21:18 -0500
Message-ID: <20120221182118.GA32668@sigill.intra.peff.net>
References: <1329834292-2511-1-git-send-email-pclouds@gmail.com>
 <1329834292-2511-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 19:21:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzuLA-0001xK-5o
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 19:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571Ab2BUSVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 13:21:21 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45332
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240Ab2BUSVU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 13:21:20 -0500
Received: (qmail 17734 invoked by uid 107); 21 Feb 2012 18:21:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Feb 2012 13:21:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Feb 2012 13:21:18 -0500
Content-Disposition: inline
In-Reply-To: <1329834292-2511-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191174>

On Tue, Feb 21, 2012 at 09:24:50PM +0700, Nguyen Thai Ngoc Duy wrote:

> We rely on ASCII everywhere. We print "\n" directly without conversion
> for example. The end result would be a mix of some encoding and ASCII
> if they are incompatible. Do not do that.
> 
> In theory we could convert everything to utf-8 as intermediate medium,
> process process process, then convert final output to the desired
> encoding. But that's a lot of work (unless we have a pager-like
> converter) with little real use. Users can just pipe everything to
> iconv instead.

I'm not sure why we bother checking this. Using non-ASCII-superset
encodings is broken, yes, but are people actually doing that? I assume
that the common one is utf-16, and anybody using it will experience
severe breakage immediately. So are people actually doing this? Are
there actually encodings that will cause subtle breakage that we want to
catch?

-Peff
