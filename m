From: Jeff King <peff@peff.net>
Subject: Re: False positives in git diff-index
Date: Wed, 5 Jan 2011 01:15:15 -0500
Message-ID: <20110105061515.GA12163@sigill.intra.peff.net>
References: <AANLkTimLW+J_rmRsqUQJO-9Gzn7aK0ZHkd1-s=Wg4Vbi@mail.gmail.com>
 <AANLkTinDSCPz-oukxzn24hj94d9WpzZ8_64TBHeNTmoG@mail.gmail.com>
 <20110105054825.GC5884@sigill.intra.peff.net>
 <AANLkTimQCMr+emw=rXdBKKnD_W9G981zCkboKgiDWxPF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 07:15:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaMec-0007sr-Sp
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 07:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298Ab1AEGPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 01:15:22 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43573 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047Ab1AEGPV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 01:15:21 -0500
Received: (qmail 29549 invoked by uid 111); 5 Jan 2011 06:15:20 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 05 Jan 2011 06:15:20 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jan 2011 01:15:15 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimQCMr+emw=rXdBKKnD_W9G981zCkboKgiDWxPF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164549>

On Wed, Jan 05, 2011 at 06:07:35AM +0000, Alexander Gladysh wrote:

> > Basically, we generate random data which has a 20% chance of
> > being the same as what's there. When it is, we should get "not bothering
> > to commit", but in your error case, we would try to commit (and get "no
> > changes").
> 
> > But using that script, I can't replicate your problem. Can you try
> > running it on the same box you're having trouble with? That might at
> > least tell us if it's your environment or something more complex going
> > on.
> 
> Thank you. I tried it, and, unfortunately, it does not reproduce the
> problem.

Oh well, thanks for trying.

Going back to your original reproduction recipe, can you change the
"diff-index" line to actually report on what it thinks is different?
That is, drop the "--quiet" and have it actually produce a patch?

It would be interesting to see what is different, and how that compares
with the "git status" you run just prior to it (and whether it matches
the file you "git add"ed just above).

You haven't told us much about your build process. Are you absolutely
sure that there couldn't be another process on the system manipulating
the files between the various runs?

Are you running on top of any special filesystem that might not meet the
consistency guarantees we expect (though in that case, I would assume my
trivial script would have reproduced).

-Peff
