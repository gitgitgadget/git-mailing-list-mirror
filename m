From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] usage: refactor die-recursion checks
Date: Mon, 15 Apr 2013 19:47:25 -0400
Message-ID: <20130415234725.GA8031@sigill.intra.peff.net>
References: <20130415230651.GA16670@sigill.intra.peff.net>
 <20130415230802.GA11267@sigill.intra.peff.net>
 <CAPig+cQtXO_jvymrT1Y69W+bhJ908o3HNABj1eVLN5zdJtpT+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 01:47:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URt7Y-0001m8-Qw
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 01:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933000Ab3DOXrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 19:47:32 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47244 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753599Ab3DOXrc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 19:47:32 -0400
Received: (qmail 30792 invoked by uid 107); 15 Apr 2013 23:49:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Apr 2013 19:49:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2013 19:47:25 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQtXO_jvymrT1Y69W+bhJ908o3HNABj1eVLN5zdJtpT+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221333>

On Mon, Apr 15, 2013 at 07:45:03PM -0400, Eric Sunshine wrote:

> On Mon, Apr 15, 2013 at 7:08 PM, Jeff King <peff@peff.net> wrote:
> > This patch teaches die() to print the original die message
> > to stderr before reporting the recursion. The custom
> > die_routine may or may not have put it the message to
> 
> s/put it the/emitted/ perhaps?

I meant s/ it//, but I think "sent the message to..." is probably more
clear.

> > stderr, but this is the best we can do (it is what most
> > handlers will do anyway, and it is where our recursion error
> > will go).
> >
> > While we're at it, let's mark the "recursion detected"
> > message as a "BUG:", since it should never happen in
> > practice. And let's factor out the repeated code in die and
> > die_errno. This loses the information of which function was
> > called to cause the recursion, but it's important; knowing
> 
> Was this supposed to be s/important/unimportant/?

Urgh, yes, it was originally "not important" but I lost the "not" while
trying to clarify the wording.

Thanks.

-Peff
