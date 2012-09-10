From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: restore getpeername(0,...) use
Date: Mon, 10 Sep 2012 16:15:45 -0400
Message-ID: <20120910201545.GC32437@sigill.intra.peff.net>
References: <1347124173-14460-1-git-send-email-jengelh@inai.de>
 <1347124173-14460-2-git-send-email-jengelh@inai.de>
 <7v1uicuyqi.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.01.1209082119320.18369@frira.zrqbmnf.qr>
 <20120910142100.GB7906@sigill.intra.peff.net>
 <k2ku26$jld$1@ger.gmane.org>
 <20120910155006.GA8737@sigill.intra.peff.net>
 <k2l7s5$gl9$1@ger.gmane.org>
 <20120910175846.GA16791@sigill.intra.peff.net>
 <004901cd8f81$e2bb20c0$a8316240$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Sep 10 22:16:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBAOn-0007CP-Mh
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 22:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626Ab2IJUPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 16:15:52 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40014 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758532Ab2IJUPs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 16:15:48 -0400
Received: (qmail 32735 invoked by uid 107); 10 Sep 2012 20:16:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 16:16:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 16:15:45 -0400
Content-Disposition: inline
In-Reply-To: <004901cd8f81$e2bb20c0$a8316240$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205173>

On Mon, Sep 10, 2012 at 08:27:07PM +0200, Joachim Schmitz wrote:

> > I think it is a mistake to set -std=c89 (or whatever similar option your
> > compiler supports). Like I said, we are not interested in being strictly
> > C89-compliant. We are interested in working on real-world systems.
> > 
> > If your compiler complains in the default mode (or when it is given some
> > reasonable practical settings), then that's something worth fixing. But
> > if your compiler is perfectly capable of compiling git, but you choose
> > to cripple it by telling it to be pedantic about a standard, then that
> > is not git's problem at all.
> 
> Older version of HP NonStop only have a c89 compiler, newer have a
> -Wc99lite switch to that, which enables some C99 features and the
> latest additionally have a c99 compiler. There's no switch to cripple
> something, it is just a fact that older systems don't have c99 or only
> limited support for it. A whole series of machines (which is still in
> use!) cannot get upgraded to anything better than c89.

If you are using a compiler switch to emulate a real environment, then
my comments above do not apply. I was speaking against standard pedantry
for its own sake, which I have no interest in.

However, do be careful that your emulated environment (i.e., recent
NonStop but using compiler flags to pretend you are the older version)
is accurate, and not introducing new portability annoyances that do not
truly exist on the old system. In fact, I might go so far as to say if
you cannot actually come up with an instance of the older platform to
test it, it might not even be worth our time to care about.

-Peff
