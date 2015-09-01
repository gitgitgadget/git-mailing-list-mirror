From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/6] date: make "local" orthogonal to date format
Date: Tue, 1 Sep 2015 18:39:59 -0400
Message-ID: <20150901223959.GG7862@sigill.intra.peff.net>
References: <20150901083731.GE30659@serenity.lan>
 <cover.1441144343.git.john@keeping.me.uk>
 <35b1313d4eb084ddc2bd70510d56e11a1d84e993.1441144343.git.john@keeping.me.uk>
 <xmqqwpw9pyy5.fsf@gitster.mtv.corp.google.com>
 <20150901223308.GI30659@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:40:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWuDo-0000n1-D1
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbbIAWkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:40:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:53413 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750717AbbIAWkC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:40:02 -0400
Received: (qmail 31865 invoked by uid 102); 1 Sep 2015 22:40:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 17:40:01 -0500
Received: (qmail 6837 invoked by uid 107); 1 Sep 2015 22:40:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 18:40:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 18:39:59 -0400
Content-Disposition: inline
In-Reply-To: <20150901223308.GI30659@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277065>

On Tue, Sep 01, 2015 at 11:33:08PM +0100, John Keeping wrote:

> > Even in --date=raw, we do show the timezone offset, so I do not
> > necessarily agree that raw-local is nonsensical.  That's the only
> > difference between the one I queued yesterday and this one.
> 
> I suspect it depends on the interpretation of "raw"; the code currently
> interprets raw to mean "exactly what exists in the commit/tag", in which
> case converting it to the local timezone is wrong.  But the
> documentation describes "raw" as "the raw Git %s %z format", and if we
> interpret it to mean "Git's internal date format" then "raw-local" makes
> sense.
> 
> The alternative would be the patch below as a preparatory step.

Ah, right, I forgot that we need to refactor show_date() to actually do
the right thing.

I think I'd be in favor of just disallowing "raw-local", then.

-Peff
