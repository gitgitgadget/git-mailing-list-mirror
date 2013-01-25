From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9902: protect test from stray build artifacts
Date: Thu, 24 Jan 2013 23:13:26 -0500
Message-ID: <20130125041326.GA30928@sigill.intra.peff.net>
References: <201301212330.10824.jn.avila@free.fr>
 <7v7gn6f6ya.fsf@alter.siamese.dyndns.org>
 <20130122003954.GA23297@sigill.intra.peff.net>
 <7vehha89j5.fsf_-_@alter.siamese.dyndns.org>
 <20130125011349.GB27657@sigill.intra.peff.net>
 <7vvcal7vhg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:13:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyafl-0002cV-No
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 05:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284Ab3AYEN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 23:13:29 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48836 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657Ab3AYEN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 23:13:28 -0500
Received: (qmail 7046 invoked by uid 107); 25 Jan 2013 04:14:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Jan 2013 23:14:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2013 23:13:26 -0500
Content-Disposition: inline
In-Reply-To: <7vvcal7vhg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214488>

On Thu, Jan 24, 2013 at 08:11:07PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This looks good to me.
> >
> > The only thing I might add is a test just to double-check that "git help
> > -a" is parsed correctly. Like:
> >
> >   test_expect_success 'command completion works without test harness' '
> >            GIT_TESTING_COMMAND_COMPLETION= run_completion "git bun" &&
> >            grep "^bundle\$" out
> >   '
> >
> > (we know we are running bash here, so the one-shot variable is OK to be
> > used with a function).
> 
> I think you meant "^bundle $" there, but don't we have the same
> problem when there is an end-user subcommand "git bunny"?
> 
> Ahh, ok, we show one element per line and just make sure "bundle"
> is there, and we do not care what other buns appear in the output.

Exactly. At least that was the intent; I typed it straight into my MUA. :)

-Peff
