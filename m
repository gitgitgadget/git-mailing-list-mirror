From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/4] Change GIT_ALLOC_LIMIT check to use
 git_parse_ulong()
Date: Mon, 25 Aug 2014 11:12:01 -0400
Message-ID: <20140825151200.GC28176@peff.net>
References: <1408896466-23149-1-git-send-email-prohaska@zib.de>
 <1408896466-23149-3-git-send-email-prohaska@zib.de>
 <20140825113856.GA17288@peff.net>
 <7D29D002-6357-4060-90DF-3993D259C475@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 25 17:12:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLvwL-0007ka-2n
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 17:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756036AbaHYPMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 11:12:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:58462 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754586AbaHYPMD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 11:12:03 -0400
Received: (qmail 17441 invoked by uid 102); 25 Aug 2014 15:12:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 10:12:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 11:12:01 -0400
Content-Disposition: inline
In-Reply-To: <7D29D002-6357-4060-90DF-3993D259C475@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255831>

On Mon, Aug 25, 2014 at 05:06:22PM +0200, Steffen Prohaska wrote:

> I think it's reasonable that GIT_ALLOC_LIMIT=0 means "no limit", so that
> the limit can easily be disabled temporarily.

IMHO, GIT_ALLOC_LIMIT= (i.e., the empty string) would be a good way to
say that (and I guess that even works currently, due to the way atoi
works, but I suspect git_parse_ulong might complain). It is probably not
worth worrying about too much. This is not even a user-facing interface,
and the test scripts just set it to 0.

So I'd be OK going that direction, or just leaving it as-is.

-Peff
