From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit message
Date: Wed, 6 Jan 2016 03:23:42 -0500
Message-ID: <20160106082341.GB19117@sigill.intra.peff.net>
References: <xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com>
 <20151221065944.GA3550@sigill.intra.peff.net>
 <xmqqio3rhg2f.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1512301535550.14434@virtualbox>
 <xmqqfuyjczpv.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1601011604070.14434@virtualbox>
 <xmqq60z9p51f.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1601051342050.14434@virtualbox>
 <xmqq37ubke8q.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1601060916400.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 06 09:23:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGjNk-0003PZ-Od
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 09:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbcAFIXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 03:23:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:49352 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752307AbcAFIXo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 03:23:44 -0500
Received: (qmail 26290 invoked by uid 102); 6 Jan 2016 08:23:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Jan 2016 03:23:44 -0500
Received: (qmail 25321 invoked by uid 107); 6 Jan 2016 08:23:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Jan 2016 03:23:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jan 2016 03:23:42 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1601060916400.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283422>

On Wed, Jan 06, 2016 at 09:20:34AM +0100, Johannes Schindelin wrote:

> Hi Junio,
> 
> On Tue, 5 Jan 2016, Junio C Hamano wrote:
> 
> > If we want to follow the X_or_Y() pattern, fopen_or_create() may
> > describe what it does better.  I do not have strong preference either
> > way, but again I am not good at naming things (and I suspect you aren't
> > either), so...
> 
> Heh... You got that right...
> 
> Let's let it simmer for a couple more days, maybe somebody else chimes in
> with a brilliant idea... :-)

I can be the anti-brilliant and just shoot down what has been said. :)

I think fopen_or_create is confusing; it implies to me that we'll open
an existing file or create it if it's not there. But we are always about
truncating/replacing the existing file.

I think fopen_for_writing() is fine, or fopen_truncate().

-Peff
