From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7501: always use test_cmp instead of diff
Date: Tue, 9 Sep 2008 19:54:14 -0400
Message-ID: <20080909235414.GA4768@coredump.intra.peff.net>
References: <1221003666-17115-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 01:55:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdD3U-0001HD-Tp
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 01:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbYIIXyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 19:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752887AbYIIXyR
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 19:54:17 -0400
Received: from peff.net ([208.65.91.99]:4095 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842AbYIIXyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 19:54:16 -0400
Received: (qmail 22178 invoked by uid 111); 9 Sep 2008 23:54:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 09 Sep 2008 19:54:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Sep 2008 19:54:14 -0400
Content-Disposition: inline
In-Reply-To: <1221003666-17115-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95467>

On Wed, Sep 10, 2008 at 01:41:06AM +0200, Miklos Vajna wrote:

>  test_expect_success \
>      'validate git-rev-list output.' \
> -    'diff current expected'
> +    'test_cmp current expected'

We seem to use the convention of

  test_cmp <expected> <actual>

elsewhere, rather than

  test_cmp <actual> <expected>

as you have here.  Most noticeably, that means the diff will show
deviations from expected, rather "what should be done to make this as
expected".  But it is also possible that in the future test_cmp could be
enhanced to do something more interesting.

I don't think it is worth it to go fix all such instances, but while you
are here...

-Peff
