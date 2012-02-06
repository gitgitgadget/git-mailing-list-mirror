From: Jeff King <peff@peff.net>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 6 Feb 2012 00:18:34 -0500
Message-ID: <20120206051834.GA5062@sigill.intra.peff.net>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
 <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
 <20120130215043.GB16149@sigill.intra.peff.net>
 <7vobtcbtqa.fsf@alter.siamese.dyndns.org>
 <20120206043012.GD29365@sigill.intra.peff.net>
 <7vty34a6fd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 06:18:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuGyP-0002Kn-9a
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 06:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752Ab2BFFSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 00:18:37 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58567
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708Ab2BFFSg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 00:18:36 -0500
Received: (qmail 23155 invoked by uid 107); 6 Feb 2012 05:25:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 00:25:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 00:18:34 -0500
Content-Disposition: inline
In-Reply-To: <7vty34a6fd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190013>

On Sun, Feb 05, 2012 at 09:15:34PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I thought the concern wasn't confusion at the error message, but rather
> > "how do I start a new repository with a branch named something besides
> > 'master'?"
> >
> > You would expect:
> >
> >   git init
> >   git checkout -b foo
> >
> > to work, but it doesn't. And there's no easy way to do what you want
> > (you have to resort to plumbing to put the value in HEAD). So the issue
> > is not a bad error message or a confusing situation, but that the user
> > wants to accomplish X, and we don't provide a reasonable way to do it.
> 
> I think the right interface for "I want to use 'foo' instead of 'master'
> like everybody else" would be:
> 
> 	$ git init --some-option foo
> 
> I wouldn't have any issue with that.

Sure, that's one way to do it. But I don't see any point in not allowing
"git checkout -b" to be another way of doing it. Is there some other use
case for "git checkout -b" from an unborn branch? Or is there some
harmful outcome that can come from doing so that we need to be
protecting against? Am I missing something?

-Peff
