From: Jeff King <peff@peff.net>
Subject: Re: sh -x -i -v with continuous integration, was Re: [PATCH 1/4]
 t7601: test for pull.ff=true overrides merge.ff=false
Date: Mon, 18 May 2015 16:50:08 -0400
Message-ID: <20150518205008.GB30217@peff.net>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
 <1431510740-9710-2-git-send-email-pyokagan@gmail.com>
 <2a5e49ff1cc3a0275e09328a3ad07866@www.dscho.org>
 <xmqqy4kr85wg.fsf@gitster.dls.corp.google.com>
 <81926313e0a131cd7224f0f6f8984dd2@www.dscho.org>
 <xmqqh9rf84we.fsf@gitster.dls.corp.google.com>
 <20150516152858.GA19269@peff.net>
 <xmqq1tigfij8.fsf@gitster.dls.corp.google.com>
 <20150518184528.GA11463@peff.net>
 <xmqq8uclbouc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 18 22:50:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuRzN-00067h-JB
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 22:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbbERUuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 16:50:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:60395 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932331AbbERUuL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 16:50:11 -0400
Received: (qmail 7918 invoked by uid 102); 18 May 2015 20:50:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 May 2015 15:50:11 -0500
Received: (qmail 28067 invoked by uid 107); 18 May 2015 20:50:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 May 2015 16:50:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 May 2015 16:50:08 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8uclbouc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269316>

On Mon, May 18, 2015 at 01:41:31PM -0700, Junio C Hamano wrote:

> So, I suspect we want more or less the same thing.
> 
> We agree that we need shorter, easier to use, and less error prone
> idioms, like test_cmp (comparing two files and show the differences
> as diagnosis), test_cmp_rev (comparing two extended SHA-1
> expressions as object names), and test_line_count (checking the
> number of lines in a file).  I just do not think "verbose" that can
> apply to any command will help us move in that direction very much,
> and I find that "verbose" applied to something overly versatile like
> "test" is a prime example that it does not help us much.

I'd agree with that if you replace "need" with "it would be nice, but it
clearly isn't high enough priority for people to actually write the
helpers, so...". :)

I dunno. Maybe there are only a few helpers needed, and we can just add
them and start using them. But if we start having to grow a lot of them,
it can be annoying.

What do you want to do with the "verbose" calls I have been sprinkling
through the test suite (and the function itself)? Leave them or remove
them? A grep for "verbose " (with the trailing space) shows some
examples.

-Peff
