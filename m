From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] merge: simplify code flow
Date: Thu, 23 Apr 2015 16:10:19 -0400
Message-ID: <20150423201019.GA28338@peff.net>
References: <xmqqh9s6397b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 22:10:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlNS7-0000N7-7C
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 22:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758308AbbDWUKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 16:10:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:49360 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758303AbbDWUKW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 16:10:22 -0400
Received: (qmail 3313 invoked by uid 102); 23 Apr 2015 20:10:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Apr 2015 15:10:22 -0500
Received: (qmail 8458 invoked by uid 107); 23 Apr 2015 20:10:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Apr 2015 16:10:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Apr 2015 16:10:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9s6397b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267706>

On Thu, Apr 23, 2015 at 01:01:44PM -0700, Junio C Hamano wrote:

> One of the first things cmd_merge() does is to see if the "--abort"
> option is given and run "reset --merge" and exit.  When the control
> reaches this point, we know "--abort" was not given.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Yeah, this looks obviously correct.

As an aside, the fact that the actual "if (abort_current_merge)"
conditional ends with a "goto" to a cleanup label that is 500 lines away
is...kind of gross.

-Peff
