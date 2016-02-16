From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the
 origin of a config value
Date: Tue, 16 Feb 2016 12:38:54 -0500
Message-ID: <20160216173853.GA15026@sigill.intra.peff.net>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
 <1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
 <56C244D7.1030503@ramsayjones.plus.com>
 <20160215214049.GA10094@sigill.intra.peff.net>
 <56C253B8.1070702@ramsayjones.plus.com>
 <51832840-B879-4650-9DC5-E15EAA9919B9@gmail.com>
 <56C3524F.3000504@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
	sschuberth@gmail.com, sunshine@sunshineco.com, hvoigt@hvoigt.net,
	sbeller@google.com, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 18:39:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVjaa-0007M2-8l
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 18:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755639AbcBPRi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 12:38:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:43378 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754993AbcBPRi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 12:38:57 -0500
Received: (qmail 25704 invoked by uid 102); 16 Feb 2016 17:38:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 12:38:56 -0500
Received: (qmail 26823 invoked by uid 107); 16 Feb 2016 17:39:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 12:39:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 12:38:54 -0500
Content-Disposition: inline
In-Reply-To: <56C3524F.3000504@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286409>

On Tue, Feb 16, 2016 at 04:46:07PM +0000, Ramsay Jones wrote:

> > OK, I am happy to add the extra code. 
> 
> Unless I've missed something (quite possible), this patch does not
> need to change. (you have (both) convinced me that your current
> solution is the best).
> 
> The only change that I would suggest is the one-liner I already
> suggested to the previous patch (plus the one-liner in the test,
> of course. err ... so the two-liner!). Having said that, I didn't
> try it out - I was just typing into my email client, so ...

I think it's more than that one-liner. This patch shows "type:name"
verbatim from what is passed into do_config_from_file, as does the error
message. If they are going to have different output formats (e.g.,
"<stdin>" versus "stdin"), there needs to be logic transforming them in
at least one of the spots.

-Peff
