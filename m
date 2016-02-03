From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Trick to force setup of a specific configured E-Mail per
 repo
Date: Wed, 3 Feb 2016 00:53:38 -0500
Message-ID: <20160203055338.GA22818@sigill.intra.peff.net>
References: <1454442861-4879-1-git-send-email-alonid@gmail.com>
 <20160203035648.GA20732@sigill.intra.peff.net>
 <CACsJy8BHem_8OcnT9KYhKZVhNcQbK91VDOJPLm9awfWJtpsi=g@mail.gmail.com>
 <20160203052209.GA22336@sigill.intra.peff.net>
 <CACsJy8CbnPGz40Bb+u-_QJCRT0r2p1FUQo1Ywu5F9cz+szUGtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dan Aloni <alonid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 06:53:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQqNu-0001mD-9d
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 06:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbcBCFxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 00:53:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:36564 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751341AbcBCFxm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 00:53:42 -0500
Received: (qmail 3637 invoked by uid 102); 3 Feb 2016 05:53:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Feb 2016 00:53:42 -0500
Received: (qmail 21476 invoked by uid 107); 3 Feb 2016 05:53:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Feb 2016 00:53:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Feb 2016 00:53:38 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CbnPGz40Bb+u-_QJCRT0r2p1FUQo1Ywu5F9cz+szUGtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285333>

On Wed, Feb 03, 2016 at 12:26:36PM +0700, Duy Nguyen wrote:

> >> Should we generalize this use case, i.e. define a list of
> >> configuration variables that must be (re-)defined per-repo? Maybe not
> >> worth it, I don't know. I can't think of any other variable that
> >> should behave this way off the top of my head.
> >
> > That's an interesting thought, but I'm not sure how it would work. The
> > ident variables are special in that people are often unhappy with the
> > fallback. What would it mean for somebody to say "do not proceed if
> > diff.renameLimit is not set", and where would we enforce that?
> 
> Enforcing it at git-init and git-clone, interactively asking the
> values of these variables,  may be too much. If only we can catch if a
> variable is used, then we probably can catch it there. But that may
> require some more changes in config api.

Yeah, maybe. I do not want to say "definitely not", but I do think this
is sufficiently more complicated than something like user.guessIdent
that we should not make it a dependency.

-Peff
