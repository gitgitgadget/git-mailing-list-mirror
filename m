From: Jeff King <peff@peff.net>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Tue, 25 Aug 2015 22:15:17 -0400
Message-ID: <20150826021517.GA20292@sigill.intra.peff.net>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
 <20150825171238.GB9674@sigill.intra.peff.net>
 <xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
 <20150825185210.GA10032@sigill.intra.peff.net>
 <20150825185414.GA10895@sigill.intra.peff.net>
 <CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Gabor Bernat <bernat@primeranks.net>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 04:15:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUQFR-0006E2-TE
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 04:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095AbbHZCPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 22:15:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:50152 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756059AbbHZCPU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 22:15:20 -0400
Received: (qmail 9972 invoked by uid 102); 26 Aug 2015 02:15:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Aug 2015 21:15:19 -0500
Received: (qmail 9987 invoked by uid 107); 26 Aug 2015 02:15:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Aug 2015 22:15:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2015 22:15:17 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276590>

On Tue, Aug 25, 2015 at 04:12:54PM -0400, Eric Sunshine wrote:

> > A little googling came up with:
> >
> >     awk 'END { print systime() }' </dev/null
> >
> > which probably (?) works everywhere.
> 
> On Mac OS X and FreeBSD:
> 
>     $ awk 'END { print systime() }' </dev/null
>     awk: calling undefined function systime
>     source line number 1
>     $

Oh, well. The reference I saw was that the old Kernighan nawk had it,
but that seems not to be the case:

  http://www.cs.princeton.edu/~bwk/btl.mirror/

"date +%s" seems to work on OS X, and so presumably on other BSDs. No
clue what would work on stuff like SunOS, AIX, etc.

-Peff
