From: Jeff King <peff@peff.net>
Subject: Re: Querying Git for the path to the system config file
Date: Wed, 20 May 2015 17:01:43 -0400
Message-ID: <20150520210143.GC8421@peff.net>
References: <CAHGBnuPCZCBsBXqGo26E-pcuZXZBxL8GwAehW4UziDpB2V8Npw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 23:02:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvB7u-0006OI-QU
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 23:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742AbbETVBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 17:01:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:33446 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755732AbbETVBr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 17:01:47 -0400
Received: (qmail 32189 invoked by uid 102); 20 May 2015 21:01:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 16:01:46 -0500
Received: (qmail 27691 invoked by uid 107); 20 May 2015 21:01:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 17:01:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2015 17:01:43 -0400
Content-Disposition: inline
In-Reply-To: <CAHGBnuPCZCBsBXqGo26E-pcuZXZBxL8GwAehW4UziDpB2V8Npw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269523>

On Wed, May 20, 2015 at 10:23:55PM +0200, Sebastian Schuberth wrote:

> I was in need to find out the path to the system-wide config file that
> Git is using. I need to do this in a platform-independent way (Linux,
> Mac OS X, Windows). What I came up with is
> 
> $ GIT_EDITOR=echo git config --system --edit
> 
> to trick Git into printing the path instead of opening the file in an editor.
> 
> Just wondering, is there a less hacky way to do that?

No, there isn't. It's baked in at compile-time, so something similar to
"git --exec-path" might make sense (but if we are going to start
exposing a lot of build flags, it might be nice to come up with some
organized system rather than haphazardly adding options).

Of course adding a new option probably won't help you, as it will take
some time before it can be used reliably. I think the hack you came up
with is pretty reasonable in the meantime.

-Peff
