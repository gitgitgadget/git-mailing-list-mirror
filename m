From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/2] implement test_might_fail using a refactored
 test_must_fail
Date: Sat, 28 Nov 2015 12:03:55 -0500
Message-ID: <20151128170355.GB27264@sigill.intra.peff.net>
References: <1448615714-43768-1-git-send-email-larsxschneider@gmail.com>
 <1448615714-43768-2-git-send-email-larsxschneider@gmail.com>
 <56584E92.1030103@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 18:03:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2iuj-0000Ax-U6
	for gcvg-git-2@plane.gmane.org; Sat, 28 Nov 2015 18:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbbK1RD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2015 12:03:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:34677 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752327AbbK1RD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2015 12:03:57 -0500
Received: (qmail 19033 invoked by uid 102); 28 Nov 2015 17:03:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Nov 2015 11:03:57 -0600
Received: (qmail 23451 invoked by uid 107); 28 Nov 2015 17:03:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Nov 2015 12:03:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Nov 2015 12:03:55 -0500
Content-Disposition: inline
In-Reply-To: <56584E92.1030103@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281789>

On Fri, Nov 27, 2015 at 12:37:38PM +0000, Ramsay Jones wrote:

> > -	if test $exit_code = 0; then
> > +	if ! list_contains "$_test_ok" success && test "$exit_code" -eq 0
> > +	then
> 
> minor nit:
> 
> I would prefer this was 'if test $exit_code -eq 0 && ! list_contains ...'
> 
> ie. the test on exit code comes first (and no need for the double quotes).
> The whole if..elif.. chain is about testing the exit code, with a couple
> of exceptions ...

I agree, it makes the logic a bit easier to follow. I've tweaked it
while applying; no need to re-send.

> The same comment applies to the second patch with exit code 141/SIGPIPE.

Got that one, too.

-Peff
