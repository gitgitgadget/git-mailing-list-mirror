From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] http: support sending custom HTTP headers
Date: Wed, 27 Apr 2016 15:30:55 -0400
Message-ID: <20160427193055.GA6727@sigill.intra.peff.net>
References: <d087647975742a803735c838d0b970d962d75048.1461738362.git.johannes.schindelin@gmx.de>
 <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 27 21:31:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avVAv-0001Sg-4D
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 21:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbcD0TbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 15:31:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:57756 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751920AbcD0Ta7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 15:30:59 -0400
Received: (qmail 32493 invoked by uid 102); 27 Apr 2016 19:30:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Apr 2016 15:30:58 -0400
Received: (qmail 724 invoked by uid 107); 27 Apr 2016 19:30:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Apr 2016 15:30:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Apr 2016 15:30:55 -0400
Content-Disposition: inline
In-Reply-To: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292788>

On Wed, Apr 27, 2016 at 02:20:37PM +0200, Johannes Schindelin wrote:

> The only change vs v3 is that I replaced my flimsical test by Peff's (with
> *one* change: I realized that we need to group the Require statements in a
> <RequireAll> block when I tried to verify that the test fails when I
> modify the first header).

Whoops, I didn't actually test that case. Thanks for catching (as you
might guess, I wanted to make sure we handle multiple values correctly).

>  Documentation/config.txt    |  6 ++++++
>  http-push.c                 | 10 +++++-----
>  http.c                      | 35 ++++++++++++++++++++++++++++++++---
>  http.h                      |  1 +
>  remote-curl.c               |  4 ++--
>  t/lib-httpd/apache.conf     |  8 ++++++++
>  t/t5551-http-fetch-smart.sh |  7 +++++++
>  7 files changed, 61 insertions(+), 10 deletions(-)

This version looks good to me.

-Peff
