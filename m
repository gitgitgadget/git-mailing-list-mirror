From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pager: drop "wait for output to run less" hack
Date: Tue, 5 Jun 2012 12:01:57 -0400
Message-ID: <20120605160157.GA20582@sigill.intra.peff.net>
References: <20120605085604.GA27298@sigill.intra.peff.net>
 <CABPQNSbhgan+i_Q142R8VvRdJ5T+GyYHqgEJ6KS-BBJguRu-OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 18:02:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbwCr-0002dd-Si
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 18:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786Ab2FEQCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 12:02:00 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43894
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753658Ab2FEQCA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 12:02:00 -0400
Received: (qmail 20899 invoked by uid 107); 5 Jun 2012 16:02:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 12:02:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 12:01:57 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSbhgan+i_Q142R8VvRdJ5T+GyYHqgEJ6KS-BBJguRu-OQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199255>

On Tue, Jun 05, 2012 at 05:52:24PM +0200, Erik Faye-Lund wrote:

> On Tue, Jun 5, 2012 at 10:56 AM, Jeff King <peff@peff.net> wrote:
> > I checked, and even RHEL5 is on less 436. So besides people on antique
> > "I installed less from source more than 5 years ago" systems, my only
> > concern would be that some other pager depends on this hack in a weird
> > way. But I have never heard of such a thing, so...
> 
> On my RHEL5 box at work:
> $ less --version
> less 394
> Copyright (C) 1984-2005 Mark Nudelman

Then I think you are not following the bug-fix updates, as they've
issued several updates based on 436:

  https://rhn.redhat.com/errata/RHBA-2010-0214.html

  https://rhn.redhat.com/errata/RHBA-2010-0805.html

  http://rhn.redhat.com/errata/RHBA-2011-1468.html

Looks like 394 was shipping as recently as 2009:

  https://rhn.redhat.com/errata/RHBA-2009-0413.html

Given that the buggy less is apparently still in the wild, and that the
patch is a pure cleanup, I guess we should scrap it for now. <sigh>

-Peff
