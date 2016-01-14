From: Jeff King <peff@peff.net>
Subject: Re: [PREVIEW v3 0/9] Preview of "Peace with CRLF" rerolled
Date: Thu, 14 Jan 2016 05:23:27 -0500
Message-ID: <20160114102326.GE30772@sigill.intra.peff.net>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 11:23:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJf49-0001KO-BY
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 11:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbcANKXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 05:23:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:53570 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753519AbcANKX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 05:23:29 -0500
Received: (qmail 14940 invoked by uid 102); 14 Jan 2016 10:23:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 05:23:29 -0500
Received: (qmail 5558 invoked by uid 107); 14 Jan 2016 10:23:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 05:23:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2016 05:23:27 -0500
Content-Disposition: inline
In-Reply-To: <1452740590-16827-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284030>

On Wed, Jan 13, 2016 at 07:03:00PM -0800, Junio C Hamano wrote:

> Continued from
> 
>  http://thread.gmane.org/gmane.comp.version-control.git/282614
> 
> Here is only the preparatory part that
> 
>  - introduces strbuf_getline_lf() and strbuf_getine_nul() and
>    converts existing callers to strbut_getline() to use them;
> 
>  - retires strbuf_getline() that takes an arbitrary line terminator
>    and demotes it to strbuf_getdelim() that is merely an
>    implementation detail inside strbuf.c; and
> 
>  - gives the short-and-sweet name strbuf_getline() to the most
>    "text friendly" strbuf_getline_crlf().

With the exception of a few minor nits (some of which are even just
cleanups we _could_ do while in the area), this looks like a good
approach to me.

I'm happy that the more-immediate endgame will keep many callers with
the short "strbuf_getline" (and that its invocation is now even shorter
and more readable than before, with the '\n' noise gone).

-Peff
