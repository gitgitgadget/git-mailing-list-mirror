From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/6] date: make "local" orthogonal to date format
Date: Tue, 1 Sep 2015 18:25:29 -0400
Message-ID: <20150901222529.GC7862@sigill.intra.peff.net>
References: <20150901083731.GE30659@serenity.lan>
 <cover.1441144343.git.john@keeping.me.uk>
 <35b1313d4eb084ddc2bd70510d56e11a1d84e993.1441144343.git.john@keeping.me.uk>
 <xmqqwpw9pyy5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:25:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWtzj-00083U-Sh
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbbIAWZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:25:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:53381 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751147AbbIAWZc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:25:32 -0400
Received: (qmail 30671 invoked by uid 102); 1 Sep 2015 22:25:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 17:25:32 -0500
Received: (qmail 6586 invoked by uid 107); 1 Sep 2015 22:25:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 18:25:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 18:25:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwpw9pyy5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277058>

On Tue, Sep 01, 2015 at 03:16:50PM -0700, Junio C Hamano wrote:

> John Keeping <john@keeping.me.uk> writes:
> 
> > This is Jeff's original patch with my fixup for DATE_STRFTIME squashed
> > in and a new change to reject "raw-local" (in both Documentation/ and
> > date.c).
> 
> Even in --date=raw, we do show the timezone offset, so I do not
> necessarily agree that raw-local is nonsensical.  That's the only
> difference between the one I queued yesterday and this one.

Yeah, that's why I didn't change it in the original. But to be honest, I
cannot imagine any case where that is _useful_, so I do not mind at all
to declare it off-limits, even though it is not nonsensical (though it
is a little strange to ask for "raw" data and then ask for it to be
munged).

IOW, I do not mind either way, but the fact that we have to _add_ code
to disallow it makes me slightly in favor of allowing it. :)

-Peff
