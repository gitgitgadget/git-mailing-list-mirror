From: Jeff King <peff@peff.net>
Subject: Re: Possible feature request for merge and pull
Date: Wed, 28 Jul 2010 21:03:41 -0400
Message-ID: <20100729010341.GA25732@coredump.intra.peff.net>
References: <AANLkTim6JAPrSVaSaGZ72xtfFnUUcYeWT8vpL3rYuwki@mail.gmail.com>
 <AANLkTinRvq71GS5WVdWs9zP5QSJ=TjCWBgTfRGn2Qub0@mail.gmail.com>
 <AANLkTikA2jWu76aPUNG+B7Nwc9eDzoU93VcGvUFWR0Ri@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Bradley Wagner <bradley.wagner@hannonhill.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 03:03:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeHXL-0003VO-S7
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 03:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707Ab0G2BDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 21:03:47 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45303 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194Ab0G2BDq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 21:03:46 -0400
Received: (qmail 25952 invoked by uid 111); 29 Jul 2010 01:03:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Thu, 29 Jul 2010 01:03:44 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jul 2010 21:03:41 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikA2jWu76aPUNG+B7Nwc9eDzoU93VcGvUFWR0Ri@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152137>

On Wed, Jul 28, 2010 at 04:49:11PM -0400, Avery Pennarun wrote:

> It sounds like --log and -m are currently incompatible, in that -m
> overrides --log, and that's not the desired behaviour.  Bradley: this
> is probably a relatively easy fix to make, in case you're looking to
> get into some git hacking. :)

Really? I get:

  $ mkdir repo && cd repo && git init &&
    echo content >file && git add file && git commit -m one &&
    echo content >>file && git commit -a -m two &&
    git checkout -b other HEAD^ &&
    echo content >file2 && git add file2 && git commit -m three &&
    git merge --log -m "custom message" master &&
    git show

  commit fa21035ea5f5437e8664a5d249e7ab88ee3f0e75
  Merge: d12be4a 4dc5cba
  Author: Jeff King <peff@peff.net>
  Date:   Wed Jul 28 20:50:39 2010 -0400

      custom message

      * master:
        two

which seems to be what was asked for. So is the problem just that
git-pull does not take "-m"?

-Peff
