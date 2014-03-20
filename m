From: Jeff King <peff@peff.net>
Subject: Re: Configuring a third-party git hook
Date: Thu, 20 Mar 2014 19:38:16 -0400
Message-ID: <20140320233816.GC7774@sigill.intra.peff.net>
References: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
 <CAO54GHC1B6hj-OvibHn2=-B25Xd5EmfWsphJ1S7vE4bgUUX3Bw@mail.gmail.com>
 <CAPTjJmpAcmVGgJK8iUvFuXJq_ZukisRZ6OD9TM=feuxDYm5iPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin <ikke@ikke.info>, git <git@vger.kernel.org>
To: Chris Angelico <rosuav@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:38:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmXX-0008PQ-0W
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759997AbaCTXiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:38:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:43623 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759652AbaCTXiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:38:18 -0400
Received: (qmail 29084 invoked by uid 102); 20 Mar 2014 23:38:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 18:38:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 19:38:16 -0400
Content-Disposition: inline
In-Reply-To: <CAPTjJmpAcmVGgJK8iUvFuXJq_ZukisRZ6OD9TM=feuxDYm5iPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244618>

On Fri, Mar 21, 2014 at 03:51:16AM +1100, Chris Angelico wrote:

> > 1. I would say yes. git config is made to be extended and doesn't
> > require a config item to be known.
> > 2. Namespacing the config items like you did is a good thing to do so
> > it won't interfere with other options.
> 
> Excellent! Thank you.
> 
> Is this documented anywhere? The git config man page says to look to
> other git man pages:
> 
> https://www.kernel.org/pub/software/scm/git/docs/git-config.html#_variables
> 
> A comment there to the effect that "Third party tools may also define
> their own variables" or something would make it clear that this is the
> intention.

I think this sentence from the section you linked is meant to express
that:

  You will find a description of non-core porcelain configuration
  variables in the respective porcelain documentation.

but it is rather opaque, isn't it? You did not know it, but your hook is
a non-core porcelain. :)

I think it could probably be re-worded, and possibly even indicate to
authors of other programs that they are free to make up their own
variables (but should take care with namespacing them appropriately).

Would you like to try your hand at writing a patch?

-Peff
