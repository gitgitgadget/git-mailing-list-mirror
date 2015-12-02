From: Jeff King <peff@peff.net>
Subject: Re: Bug: Incorrect stripping of the [PATCH] prefix in git-am
Date: Tue, 1 Dec 2015 19:58:27 -0500
Message-ID: <20151202005826.GE28197@sigill.intra.peff.net>
References: <5655D3DA.1050403@informatik.uni-hamburg.de>
 <5655D755.8060503@atlas-elektronik.com>
 <5655DAE7.2000008@informatik.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
To: huebbe <nathanael.huebbe@informatik.uni-hamburg.de>
X-From: git-owner@vger.kernel.org Wed Dec 02 01:58:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3vkf-0003jA-SS
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 01:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757368AbbLBA6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 19:58:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:36061 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757188AbbLBA63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 19:58:29 -0500
Received: (qmail 26923 invoked by uid 102); 2 Dec 2015 00:58:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 18:58:29 -0600
Received: (qmail 25027 invoked by uid 107); 2 Dec 2015 00:58:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 19:58:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Dec 2015 19:58:27 -0500
Content-Disposition: inline
In-Reply-To: <5655DAE7.2000008@informatik.uni-hamburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281872>

On Wed, Nov 25, 2015 at 04:59:35PM +0100, huebbe wrote:

> Yes, it looks like the `--keep-non-patch` option works around this.
> 
> However, shouldn't that be the default behaviour?
> I mean, what is the point in stripping stuff that is not proven to be inserted by `git` itself?
> That's not what I expect a tool to do which I trust.

The "[]" convention is a microformat used by Linux kernel folks. So it's
not "whoops, we are stripping stuff not added by git". It is respecting
a microformat used by the tool's authors.

That being said, if we were choosing a default from scratch today, it
might go the other way. But we aren't, and we have to deal with the
burden of breaking existing scripts by flipping it.

-Peff
