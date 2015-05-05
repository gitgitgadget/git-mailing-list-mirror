From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/12] remote.c: provide per-branch pushremote name
Date: Tue, 5 May 2015 15:33:39 -0400
Message-ID: <20150505193339.GF10463@peff.net>
References: <20150501224414.GA25551@peff.net>
 <20150501224644.GD1534@peff.net>
 <CAPig+cT7pSxZahd1hmcwCW8ifZfvQ4YW6L7xXUrD7dTJt76srQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 05 21:33:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpibJ-00058r-Da
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 21:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbbEETdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 15:33:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:54429 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757466AbbEETdm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 15:33:42 -0400
Received: (qmail 23973 invoked by uid 102); 5 May 2015 19:33:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 14:33:41 -0500
Received: (qmail 9816 invoked by uid 107); 5 May 2015 19:34:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 15:34:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 May 2015 15:33:39 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cT7pSxZahd1hmcwCW8ifZfvQ4YW6L7xXUrD7dTJt76srQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268419>

On Sun, May 03, 2015 at 12:51:13AM -0400, Eric Sunshine wrote:

> > Versus v1, I did something a little clever by passing a function pointer
> > around (versus a flag and letting the caller do a conditional based on
> > the flag). Too clever?
> 
> FWIW: I found this "clever" version easy enough to follow.
> 
> However, if you push a tiny bit of the work into the callers of
> remote_get_1(), then you can do away with the "cleverness" altogether,
> can't you? Something like this:

Yeah, it's just that it goes in the opposite direction I was trying for,
which is to have as little code as possible in the wrapper functions (in
fact, I think after my changes you could even bump the read_config()
call into remote_get_1; before my changes, it depended on the pushremote
config being set before the call).

I agree it is not so much code, though, and maybe it makes the flow a
little clearer. I'll play with it for the re-roll.

-Peff
