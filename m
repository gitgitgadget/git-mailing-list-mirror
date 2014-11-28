From: Jeff King <peff@peff.net>
Subject: Re: 'simple' push check that branch name matches does not work if
 push.default is unset (and hence implicitly simple)
Date: Thu, 27 Nov 2014 23:55:18 -0500
Message-ID: <20141128045518.GB19456@peff.net>
References: <1417040968.12457.78.camel@redhat.com>
 <20141127034306.GA5341@peff.net>
 <1417108347.18654.4.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Adam Williamson <awilliam@redhat.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 05:55:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuDaZ-0004cX-Em
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 05:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbaK1EzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 23:55:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:45814 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750870AbaK1EzS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 23:55:18 -0500
Received: (qmail 20519 invoked by uid 102); 28 Nov 2014 04:55:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Nov 2014 22:55:18 -0600
Received: (qmail 20350 invoked by uid 107); 28 Nov 2014 04:55:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Nov 2014 23:55:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Nov 2014 23:55:18 -0500
Content-Disposition: inline
In-Reply-To: <1417108347.18654.4.camel@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260357>

On Thu, Nov 27, 2014 at 09:12:27AM -0800, Adam Williamson wrote:

> It might also be worth improving the warn_unspecified_push_default_msg[]
> text to mention the name matching behaviour? At present it doesn't
> clearly explain this (you could argue it's *sort of* implied, but I
> doubt many people will read it that way - I didn't), you have to follow
> the chain into 'git help config' to find the description. Something
> like:
> 
>    "Since Git 2.0, Git defaults to the more conservative 'simple'\n"
>    "behavior, which only pushes the current branch to the corresponding\n"
>    "remote branch that 'git pull' uses to update the current branch, \n"
>    "if the names of those two branches match.\n"

Yeah, I agree that is more clear.

There is some other magic with "simple", too, around triangular
workflows. Describing it in detail would probably be too verbose in this
message, but we do refer to the description of push.default, which is
probably enough.  Technically this new bit you are adding here is
covered there, too. But since we can improve the description by adding
such a small amount of text in this case, it seems like a reasonable
tradeoff.

I suppose we could also customize the message based on the triangular
and non-triangular cases. I dunno.

-Peff
