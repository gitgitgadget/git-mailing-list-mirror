From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 3/4] tests: add new test for the url_normalize function
Date: Wed, 24 Jul 2013 15:03:56 -0400
Message-ID: <20130724190356.GA11444@sigill.intra.peff.net>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
 <60d85be89d27515d913ae15e10c332f@f74d39fa044aa309eaea14b9f57fe79>
 <20130724065933.GC30074@sigill.intra.peff.net>
 <D8BC48D1-195D-4F08-876C-FA592802A12C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>, Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 21:04:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V24Lz-0003OJ-Ey
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 21:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab3GXTD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 15:03:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:41259 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab3GXTD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 15:03:59 -0400
Received: (qmail 20938 invoked by uid 102); 24 Jul 2013 19:03:59 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Jul 2013 14:03:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jul 2013 15:03:56 -0400
Content-Disposition: inline
In-Reply-To: <D8BC48D1-195D-4F08-876C-FA592802A12C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231111>

On Wed, Jul 24, 2013 at 12:01:26PM -0700, Kyle J. McKay wrote:

> Right now, the values are only available as various strings, ints,
> longs etc. which have to be formatted differently for output.  The
> original string value they were converted from is gone.  The snippet
> shown above only shows some of the "%s" formatters.
> 
> Either the original value will have to be kept around or a
> reconstituted string depending on what:
> 
> git config --file=foo --url http noepsv $URL
> 
> should output.  If the original value was 0 or 1, should it output
> that or "false" or "true"?  The test-url-normalize code for "-c"
> normalizes the output to "false" or "true" for all boolean values and
> reconverts ints/longs to strings.

I think it would be the responsibility of the caller to specify what
they are looking for. I.e., add "--bool" to the git-config command line
as appropriate.

-Peff
