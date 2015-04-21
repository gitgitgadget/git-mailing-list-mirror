From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] strbuf_getwholeline: use getdelim if it is available
Date: Tue, 21 Apr 2015 19:09:29 -0400
Message-ID: <20150421230929.GA27773@peff.net>
References: <20150416084733.GA17811@peff.net>
 <20150416090138.GG17938@peff.net>
 <CAPig+cSKtMPQGxp1Y2GinVRh2y--QyJh_nxhDez2CGFPP6B=xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 01:09:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkhIP-0002Zp-1H
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 01:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbbDUXJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 19:09:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:48363 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964880AbbDUXJc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 19:09:32 -0400
Received: (qmail 10897 invoked by uid 102); 21 Apr 2015 23:09:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Apr 2015 18:09:31 -0500
Received: (qmail 5882 invoked by uid 107); 21 Apr 2015 23:09:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Apr 2015 19:09:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Apr 2015 19:09:29 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cSKtMPQGxp1Y2GinVRh2y--QyJh_nxhDez2CGFPP6B=xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267570>

On Fri, Apr 17, 2015 at 06:16:48AM -0400, Eric Sunshine wrote:

> > If somebody has a FreeBSD or OS X system to test on, I'd
> > love to see what is needed to compile with HAVE_GETDELIM
> > there.
> 
> Modern Mac OS X, 10.10.x Yosemite, has getdelim() and git builds fine
> with HAVE_GETDELIM. I also tested on old Snow Leopard 10.5.8 from
> 2009. It does not have getdelim(). Unfortunately, I haven't been able
> to determine when getdelim() was introduced on the Mac OS X, thus have
> been unable to craft a simple rule for config.mak.uname.

Thanks for looking into it. Since there haven't been any other takers in
the meantime, do you want to prepare a patch that checks $(uname_R) for
10.10.x?  That's likely more conservative than is necessary, but we can
loosen it later if somebody on 10.9.x shows up with test results.

-Peff
