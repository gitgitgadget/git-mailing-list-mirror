From: Jeff King <peff@peff.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Wed, 7 Jul 2010 13:50:37 -0400
Message-ID: <20100707175037.GB4979@coredump.intra.peff.net>
References: <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
 <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705141012.GA25518@thunk.org>
 <20100706115826.GA15413@sigill.intra.peff.net>
 <1278430303.32094.15.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tytso@mit.edu, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 19:50:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWYli-0003Ml-E9
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 19:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892Ab0GGRuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 13:50:39 -0400
Received: from peff.net ([208.65.91.99]:57057 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755347Ab0GGRuj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 13:50:39 -0400
Received: (qmail 20413 invoked by uid 107); 7 Jul 2010 17:51:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 07 Jul 2010 13:51:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Jul 2010 13:50:37 -0400
Content-Disposition: inline
In-Reply-To: <1278430303.32094.15.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150486>

On Tue, Jul 06, 2010 at 04:31:43PM +0100, Will Palmer wrote:

> Clearly, marking already-traversed histories was the right thing to do,
> and if I read correctly, made a good improvement on its own. But you
> seem to have crossed a line at some point between "optimization" and
> "potentially giving the wrong answer because it's faster"

As a side-note to what I said in my other email, the sinful thing here
is not this optimization (my patch 2/4). It's _defaulting_ the
optimization to on (my patch 3/4). With just 2/4, it's something that a
user can enable to get better speed if they feel confident there is no
large skew in their repo.

-Peff
