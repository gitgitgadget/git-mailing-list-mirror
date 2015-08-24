From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] "am" state file fix with write_file() clean-up
Date: Mon, 24 Aug 2015 13:41:43 -0400
Message-ID: <20150824174142.GA4794@sigill.intra.peff.net>
References: <20150824065033.GA4124@sigill.intra.peff.net>
 <1440436186-7894-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 19:41:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTvkm-00042U-Cj
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 19:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbbHXRlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 13:41:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:49149 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753971AbbHXRlp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 13:41:45 -0400
Received: (qmail 6105 invoked by uid 102); 24 Aug 2015 17:41:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 12:41:45 -0500
Received: (qmail 25718 invoked by uid 107); 24 Aug 2015 17:41:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 13:41:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2015 13:41:43 -0400
Content-Disposition: inline
In-Reply-To: <1440436186-7894-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276469>

On Mon, Aug 24, 2015 at 10:09:41AM -0700, Junio C Hamano wrote:

> So here is an solution based on the "write_file() is primarily to
> produce text, so it should be able to correct the incomplete line
> at the end" approach.

This all looks good to me. The topics-in-flight compatibility stuff in
patches 3 and 5	 is neatly done. Usually I would just cheat and change
the order of arguments to make the compiler notice such problems, but
that's hard to do here because of the varargs (you cannot just bump
"flags" to the end).

-Peff
