From: Jeff King <peff@peff.net>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Sun, 7 Oct 2012 17:49:58 -0400
Message-ID: <20121007214958.GC1743@sigill.intra.peff.net>
References: <op.wlp1lws70aolir@keputer>
 <7vsj9ssgcp.fsf@alter.siamese.dyndns.org>
 <20121005225758.GA1202@sigill.intra.peff.net>
 <7v8vbkru8o.fsf@alter.siamese.dyndns.org>
 <20121006131200.GB11712@sigill.intra.peff.net>
 <7vvcenqx39.fsf@alter.siamese.dyndns.org>
 <20121006183026.GA3644@sigill.intra.peff.net>
 <CAOTq_pu=xWF7q3QobxSerkkbV56n5o+CPQSyHg8onwv73v25+A@mail.gmail.com>
 <20121006190753.GA5648@sigill.intra.peff.net>
 <7vr4paovjq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Conrad Irwin <conrad.irwin@gmail.com>,
	Frans Klaver <fransklaver@gmail.com>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 23:50:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKyjw-0000co-Lw
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 23:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149Ab2JGVuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 17:50:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43995 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680Ab2JGVuB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 17:50:01 -0400
Received: (qmail 18385 invoked by uid 107); 7 Oct 2012 21:50:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Oct 2012 17:50:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Oct 2012 17:49:58 -0400
Content-Disposition: inline
In-Reply-To: <7vr4paovjq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207202>

On Sun, Oct 07, 2012 at 01:51:21PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes. The more we talk about it, the more turned off I am by the idea.
> > Above I posed my questions as "what _should_ we do when...". And I still
> > think we _should_ default to --only with interactive, if we can find
> > sane semantics. But until we can find them, it obviously does not make
> > sense to enable it, and the whole discussion is stalled. And we must
> > come up with an interim solution that is the least bad.
> >
> > Which is obviously one of:
> >
> >   1. Keep defaulting to "--include", as that is what we have been doing.
> >
> >   2. Forbid the cases where it would matter (i.e., when the index and
> >      HEAD differ).
> >
> > The former is more convenient, but the latter is safer against
> > future breakage. I'm OK either way, but option (1) clearly needs a
> > documentation update.
> 
> Yeah, I agree with the reasoning.  This is an unessential feature
> that is with the problem for a long time, so let's go the route #1
> first before we do anything else.

OK. I think Conrad's patch takes us most of the way there. I had a few
minor comments, but I think another round should do it. Conrad?

-Peff
