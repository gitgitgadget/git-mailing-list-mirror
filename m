From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase -p: avoid grep on potentailly non-ASCII data
Date: Tue, 8 Mar 2016 09:35:56 -0500
Message-ID: <20160308143556.GA10153@sigill.intra.peff.net>
References: <alpine.DEB.2.10.1603080255030.2674@buzzword-bingo.mit.edu>
 <56DEC4B4.2000902@web.de>
 <56DED770.4050603@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Anders Kaseorg <andersk@mit.edu>, gitster@pobox.com,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 15:36:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adIk1-00073m-Bn
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 15:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240AbcCHOgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 09:36:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:56292 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752440AbcCHOf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 09:35:59 -0500
Received: (qmail 11595 invoked by uid 102); 8 Mar 2016 14:35:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 09:35:58 -0500
Received: (qmail 2789 invoked by uid 107); 8 Mar 2016 14:36:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 09:36:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2016 09:35:56 -0500
Content-Disposition: inline
In-Reply-To: <56DED770.4050603@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288436>

On Tue, Mar 08, 2016 at 02:45:20PM +0100, Michael J Gruber wrote:

> It may be worth noting whether other occurrences of "sane_grep" are safe
> from binary input.
> 
> After all, one my question the degree of sanity of our sane_grep, or
> whether we need asane_grep and bisane_grep in our shell library - "make
> our grep sane again".

I actually wonder if we should have a build-time knob to put "grep -a"
into sane_grep(). We do not ever plan to feed it binary data, so that
will do what, provided the system grep handles "-a". And on those that
do not know about "-a", one imagines that they do not suffer from this
problem in the first place (which is really limited to recent versions
of GNU grep).

-Peff
