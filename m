From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: point git-prune users to git-gc
Date: Tue, 29 Apr 2008 19:19:17 -0400
Message-ID: <20080429231917.GB22646@sigill.intra.peff.net>
References: <32541b130804230841h32c07f3arc94cccfaf0b156a3@mail.gmail.com> <7vve28sdys.fsf@gitster.siamese.dyndns.org> <20080423221316.GE30057@sigill.intra.peff.net> <20080424012836.GA30812@sigill.intra.peff.net> <32541b130804240843k471ecfeteb1008c44a56808b@mail.gmail.com> <20080424161407.GA23737@sigill.intra.peff.net> <32541b130804240959y3b05d4b5u67ac7a7c14bf187e@mail.gmail.com> <20080429204514.GA21029@sigill.intra.peff.net> <7vskx45ncg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 01:20:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqz7H-00078J-PS
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 01:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753AbYD2XTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 19:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754751AbYD2XTS
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 19:19:18 -0400
Received: from peff.net ([208.65.91.99]:1560 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644AbYD2XTS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 19:19:18 -0400
Received: (qmail 23817 invoked by uid 111); 29 Apr 2008 23:19:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Apr 2008 19:19:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Apr 2008 19:19:17 -0400
Content-Disposition: inline
In-Reply-To: <7vskx45ncg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80769>

On Tue, Apr 29, 2008 at 03:05:03PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes, I don't think there is any reason for most people to use git-prune
> > at all, unless they are trying specifically to prune and don't want the
> > other gc effects to happen.
> >
> > Junio, please correct me if I'm wrong there.
> 
> Well, this is a hard statement to make corrections to.  If A is defined to
> be a subset of B, and A is generally useful, the only reason to do B is
> when you want the effect of B without anything else.  So your statement
> cannot be incorrect.

Heh. Sorry, I got very sloppy with my wording...there was an
11-month-old child yelling in my ear. :)

My meaning was: "people who want to clean up their repo but don't know
the right command stumble upon git-prune. They probably should be using
git-gc instead. People who know that they want to prune presumably know
enough to ignore the warning note."

> However, in order to help people decide when to run B (or, if there ever
> be a case where they might want to), there needs a discussion what other
> things that _might_ be unwanted A does in addition to B.

Fair enough.

> > --- a/Documentation/git-prune.txt
> > +++ b/Documentation/git-prune.txt
> > @@ -13,6 +13,9 @@ SYNOPSIS
> >  DESCRIPTION
> >  -----------
> >  
> > +NOTE: In most cases, users should run linkgit:git-gc[1], which calls
> > +git-prune. See the section "NOTES", below.
> > +
> 
> I think this note upfront is not helping readers very much (this is
> git-prune documentation after all -- they are interested in the command
> and not gc), but ...

I'm not so sure that they are interested in the prune command. At first
I started with just a note near the end, but the point of this is
specifically to deal with users who "stumble" upon prune, either from
reading the command list (i.e., trying to match a command to the
objective they want to perform) or from pre-gc tutorials or emails which
mention it.

> > +Notes
> > +-----
> > +
> > +In most cases, users will not need to call git-prune directly, but
> > +should instead call linkgit:git-gc[1], which handles pruning along with
> > +many other housekeeping tasks.
> 
> ... this paragraph should be made a bit fatter by mentioning what "other
> housekeeping tasks" are.

OK, I was trying to imply "go look at git-gc for those tasks" so they
didn't have to be repeated. Would you prefer it be spelled out
explicitly here, or is a more firm pointer OK?

-Peff
