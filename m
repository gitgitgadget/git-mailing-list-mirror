From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 54/68] drop strcpy in favor of raw sha1_to_hex
Date: Thu, 24 Sep 2015 21:36:35 -0400
Message-ID: <20150925013635.GB7522@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
 <20150924210805.GY30946@sigill.intra.peff.net>
 <CAPig+cQSOoYwG7EKDWPWoB+vHvYWv6ZHg9Zhd8bvH6XKfmG_1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 03:36:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfHwI-0003JM-Bo
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 03:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbbIYBgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 21:36:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:36261 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752954AbbIYBgi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 21:36:38 -0400
Received: (qmail 28603 invoked by uid 102); 25 Sep 2015 01:36:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 20:36:37 -0500
Received: (qmail 466 invoked by uid 107); 25 Sep 2015 01:36:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 21:36:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 21:36:35 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQSOoYwG7EKDWPWoB+vHvYWv6ZHg9Zhd8bvH6XKfmG_1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278646>

On Thu, Sep 24, 2015 at 07:42:05PM -0400, Eric Sunshine wrote:

> On Thu, Sep 24, 2015 at 5:08 PM, Jeff King <peff@peff.net> wrote:
> > In some cases where we strcpy() the result of sha1_to_hex(),
> > there's no need; the result goes directly into a printf
> > statement, and we can simply pass the return value from
> > sha1_to_hex() directly.
> >
> > When this code was originally written, sha1_to_hex used a
> > single buffer, and it was not safe to use it twice within a
> > single expression. That changed as of dcb3450 (sha1_to_hex()
> > usage cleanup, 2006-05-03), but this code ewas never
> 
> s/ewas/was/

Whoops. New content, new errors. :)

-Peff
