From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/8] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Wed, 20 Jun 2012 15:57:09 -0400
Message-ID: <20120620195709.GB32228@sigill.intra.peff.net>
References: <20120619232231.GA6328@sigill.intra.peff.net>
 <20120619232310.GA6496@sigill.intra.peff.net>
 <20120620035015.GA4213@burratino>
 <20120620042607.GA10414@sigill.intra.peff.net>
 <20120620102750.GB4579@burratino>
 <20120620163714.GB12856@sigill.intra.peff.net>
 <20120620182855.GA26948@sigill.intra.peff.net>
 <CAFzf2Xw3TdvZCFLvbqKY5F9b+0hTzTQEEfmqjL9u=uvyc7mZ5w@mail.gmail.com>
 <20120620193638.GA32418@sigill.intra.peff.net>
 <CAFzf2XwmZo4ErG_9w0m66k4OPtDr_4_xvATL_6sOo8QVg0DhJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:57:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShR1h-0001dM-OK
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757991Ab2FTT5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:57:14 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39192
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754452Ab2FTT5N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:57:13 -0400
Received: (qmail 28830 invoked by uid 107); 20 Jun 2012 19:57:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 15:57:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 15:57:09 -0400
Content-Disposition: inline
In-Reply-To: <CAFzf2XwmZo4ErG_9w0m66k4OPtDr_4_xvATL_6sOo8QVg0DhJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200350>

On Wed, Jun 20, 2012 at 02:45:31PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Did you read the argument in patch 2? They are almost certainly not
> > helping anyone, anyway.
> 
> Yes, I read patch 2. I hacked on git from time to time in the days
> before COMPUTE_HEADER_DEPENDENCIES, and it sometimes involved changing
> header files. When they were not in LIB_H, the experience was much
> nicer.
> 
> Is that called "not helping"? I'm afraid I don't follow this line of
> argument at all.

I just assumed that people who are actively hacking on individual header
files in git actually have a compiler that can do COMPUTE_HEADER_DEPENDENCIES.
Maybe that is not the case. If it were such a big deal, then why is
everything in LIB_H? Why don't people use these manual rules, or convert
existing LIB_H entries to use them?

For people who are not actively hacking on header files in git, the
arguments from that patch apply (namely that LIB_H is so gigantic that
you are unlikely to hit a specific change where one of the few manual
rules is triggered, but LIB_H is not).

> On the other hand, if someone were proposing adding a simple awk
> script to implement a "make dep" fallback, I would understand that.

I'd be OK with that. Do you have one in mind, or do we need to write it
from scratch? Surely somebody else has solved this problem before.

-Peff
