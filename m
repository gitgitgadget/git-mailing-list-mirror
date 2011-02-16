From: Jeff King <peff@peff.net>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 03:51:14 -0500
Message-ID: <20110216085114.GA9413@sigill.intra.peff.net>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
 <20110216023645.GA7085@sigill.intra.peff.net>
 <20110216032047.GA2858@elie>
 <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 09:51:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppd6v-0006kK-Do
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 09:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758416Ab1BPIvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 03:51:21 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34725 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757400Ab1BPIvT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 03:51:19 -0500
Received: (qmail 5969 invoked by uid 111); 16 Feb 2011 08:51:18 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 16 Feb 2011 08:51:18 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Feb 2011 03:51:14 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166932>

On Wed, Feb 16, 2011 at 08:18:18AM +0000, Sverre Rabbelier wrote:

> On Wed, Feb 16, 2011 at 03:20, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > If I remember the discussion[1] correctly, by requiring a separate
> > add -u step (or commit -f -a) if the "I don't trust my fingers"
> > configuration is enabled.
> 
> That would definitely work for me. The question then is, should git
> consider the index precious by default, or not? That is, should that
> value default to true in 1.8?

If we do not consider the index precious, then no, it should not be the
default. If we do consider it precious, then isn't this option fixing
one small case and leaving all of the others untouched?

I can just as easily run "git add -u", or "git add -p" on top of some
changes and then realize afterwards that I actually wanted the previous
index state.

The solution for that would be an index reflog.

-Peff
