From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] Makefile: implement help target
Date: Wed, 29 Sep 2010 03:34:01 -0400
Message-ID: <20100929073400.GA28010@sigill.intra.peff.net>
References: <AANLkTikx2tL73gJQnqjG7yp3btcZJprKLf0z9QwcAUC1@mail.gmail.com>
 <4fd8b490b4badd13c0ea46408e44dc7b317dc0ed.1285706151.git.git@drmicha.warpmail.net>
 <20100929051640.GA26324@sigill.intra.peff.net>
 <4CA2E4C7.305@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 09:34:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0rBD-00051T-FP
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 09:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380Ab0I2Hd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 03:33:59 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59389 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348Ab0I2Hd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 03:33:58 -0400
Received: (qmail 6959 invoked by uid 111); 29 Sep 2010 07:33:57 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 29 Sep 2010 07:33:57 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Sep 2010 03:34:01 -0400
Content-Disposition: inline
In-Reply-To: <4CA2E4C7.305@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157540>

On Wed, Sep 29, 2010 at 09:03:35AM +0200, Michael J Gruber wrote:

> > Surely this is why we have perl?
> 
> I don't speak perl.
> 
> Honestly, this is slowly going on my nerves. Maybe it's because I'm
> reading too many "can't we do it this way" responses in one go and
> without being coffeinated, and without seeing how "different" is better.
> [I've been heeding all advise on portability and readability, as you can
> see.]

I should have been more clear about my motivations. It was mainly "I
wonder how short I can make this in perl?" The alternate sorting was
something that happened incidentally, though it did make more sense to
me.

So you can just ignore me if you like. :)

> > 	  -e 'for (sort keys(%h)) {' \
> > 	  -e '  print "$$_:\n";' \
> > 	  -e '  printf("    %-20s%s\n", @$$_) for (@{$$h{$$_}});' \
> > 	  -e '}' Makefile
> > 
> 
> How portable are the regexps and the array/dictionary push?

AFAIK, it should work with any perl5. I don't have any ancient versions
handy to test these days, though.

> > Note that mine will actually print the targets in a heading in the order
> > in which they appear in the Makefile, which I consider slightly more
> > useful (especially in that we can tweak the order easily).
> 
> I don't think Makefile order would be useful. If you know exactly what
> you're looking for you need no sorting, you can just search for that
> term. (I would do a 'grep -A20 "^target:" Makefile' or hit "/^target" in
> my vim but I'm sure there's a different way of doing it in perl...)

What I was trying to say was more that alphabetical is not necessarily
the most useful order to present things in the help screen. Probably
there is some hand-selected order that presents the entries in the least
confusing way. And one way of representing that is to have the topics in
that order in the Makefile, which in theory probably makes reading the
Makefile itself simpler.

But yeah, this is way over-thinking the issue. It's a fricking list of
Makefile targets. I am happy with your original patch.

-Peff
