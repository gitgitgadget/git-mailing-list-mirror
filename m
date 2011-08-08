From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/2] test_when_finished and returning early
Date: Sun, 7 Aug 2011 19:26:37 -0600
Message-ID: <20110808012637.GA2352@sigill.intra.peff.net>
References: <20110321105628.GC16334@sigill.intra.peff.net>
 <cover.1300872923.git.git@drmicha.warpmail.net>
 <20110324082108.GA30196@elie>
 <20110808011341.GA19551@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 03:26:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqEcA-0006OC-JP
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 03:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425Ab1HHB0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 21:26:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43650
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab1HHB0l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 21:26:41 -0400
Received: (qmail 18073 invoked by uid 107); 8 Aug 2011 01:27:16 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Aug 2011 21:27:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Aug 2011 19:26:37 -0600
Content-Disposition: inline
In-Reply-To: <20110808011341.GA19551@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178934>

On Mon, Aug 08, 2011 at 03:13:41AM +0200, Jonathan Nieder wrote:

> Jonathan Nieder wrote:
> 
> > The use of "return" was surprising.  It seems this style has been
> > intended to work ever since v0.99.5~24^2~4 (Trapping exit in tests,
> > using return for errors, 2005-08-10).
> >
> > It interacts poorly with test_when_finished but since these tests do
> > not use that function, they should be safe.  test_when_finished could
> > use some fixes to avoid future surprises but that's another story.
> 
> The above was about some code that looks like this:
> 
> |	for i in 1 2 3 4 5 6 7 8 9 10 11
> | 	do
> |		git checkout -b root$i five || return
> 
> The fixes alluded to might go something like this.  Thoughts?
> 
> Jonathan Nieder (2):
>   test: simplify return value of test_run_
>   test: cope better with use of return for errors

Both look sane to me. Thanks for a nicely written set of commit messages
explaining the rather subtle issue.

-Peff
