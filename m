From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clean: new option --exclude-from
Date: Tue, 1 Dec 2015 19:53:38 -0500
Message-ID: <20151202005338.GD28197@sigill.intra.peff.net>
References: <1448549065-16337-1-git-send-email-rouzier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: James <rouzier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 01:53:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3vg1-0004Kg-Cv
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 01:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbbLBAxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 19:53:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:36054 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755329AbbLBAxk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 19:53:40 -0500
Received: (qmail 26696 invoked by uid 102); 2 Dec 2015 00:53:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 18:53:40 -0600
Received: (qmail 24941 invoked by uid 107); 2 Dec 2015 00:53:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 19:53:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Dec 2015 19:53:38 -0500
Content-Disposition: inline
In-Reply-To: <1448549065-16337-1-git-send-email-rouzier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281870>

On Thu, Nov 26, 2015 at 09:44:25AM -0500, James wrote:

> From: James Rouzier <rouzier@gmail.com>
> 
> Specify a file to read for exclude patterns.
> ---

Lots of commands care about excludes (e.g., "add", "status").

Should this perhaps be an option to the main "git" to append to the set
of excludes?

You can kind-of do this already with:

  git -c core.excludesfile=/path/to/whatever clean ...

but of course you might be using core.excludesfile already. I wonder if
that config option should take multiple values and respect all of them,
rather than last-one-wins.

-Peff
