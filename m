From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Wed, 16 Sep 2015 05:48:14 -0400
Message-ID: <20150916094814.GB13966@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915153637.GO29753@sigill.intra.peff.net>
 <CAPig+cR9n=hT3F-0uDbJT_Z9REe83-kFKR5XB6pVrHRe0Z14eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 11:48:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc9KE-00062t-QZ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 11:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbbIPJsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 05:48:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:59832 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753114AbbIPJsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 05:48:22 -0400
Received: (qmail 13325 invoked by uid 102); 16 Sep 2015 09:48:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 04:48:23 -0500
Received: (qmail 16390 invoked by uid 107); 16 Sep 2015 09:48:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 05:48:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 05:48:14 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cR9n=hT3F-0uDbJT_Z9REe83-kFKR5XB6pVrHRe0Z14eA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278012>

On Tue, Sep 15, 2015 at 11:19:21PM -0400, Eric Sunshine wrote:

> >                 strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
> > -               sprintf(ownbuf[stage], "%o", ce->ce_mode);
> > +               xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
> 
> Interesting. I wonder if there are any (old/broken) compilers which
> would barf on this. If we care, perhaps sizeof(ownbuf[0]) instead?

Good point. I've changed it to sizeof(ownbuf[0]).

-Peff
