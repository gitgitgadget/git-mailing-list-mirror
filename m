From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clean: new option --exclude-from
Date: Tue, 1 Dec 2015 21:44:03 -0500
Message-ID: <20151202024403.GA29329@sigill.intra.peff.net>
References: <1448549065-16337-1-git-send-email-rouzier@gmail.com>
 <20151202005338.GD28197@sigill.intra.peff.net>
 <xmqq37vl7fux.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James <rouzier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 03:44:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3xOu-0004os-EV
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 03:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473AbbLBCoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 21:44:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:36104 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754820AbbLBCoH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 21:44:07 -0500
Received: (qmail 31665 invoked by uid 102); 2 Dec 2015 02:44:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 20:44:06 -0600
Received: (qmail 25855 invoked by uid 107); 2 Dec 2015 02:44:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 21:44:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Dec 2015 21:44:03 -0500
Content-Disposition: inline
In-Reply-To: <xmqq37vl7fux.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281878>

On Tue, Dec 01, 2015 at 06:18:30PM -0800, Junio C Hamano wrote:

> > Should this perhaps be an option to the main "git" to append to the set
> > of excludes?
> >
> > You can kind-of do this already with:
> >
> >   git -c core.excludesfile=/path/to/whatever clean ...
> >
> > but of course you might be using core.excludesfile already. I wonder if
> > that config option should take multiple values and respect all of them,
> > rather than last-one-wins.
> 
> It is likely that existing users are already using $HOME/.gitconfig
> that sets core.excludesfile=$HOME/.gitconfig as the personal
> fallback, that is overriden, not tweaked, by project specific
> settings of the same variable in .git/config, so that would not fly
> very well, I suspect.

Maybe. I would think the more common setup is:

  1. Personal exclude files (e.g., your editor's backup files) come from
     ~/.gitconfig.

  2. Per-project personal excludes go directly into .git/info/exclude.

But you're right that it would be a backwards-incompatible change.

-Peff
