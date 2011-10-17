From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Mon, 17 Oct 2011 16:08:09 -0400
Message-ID: <20111017200809.GA23964@sigill.intra.peff.net>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
 <20111017020103.GA18536@sigill.intra.peff.net>
 <20111017200528.GA19054@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Oct 17 22:08:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFtTs-0003Af-RZ
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 22:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012Ab1JQUIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 16:08:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34039
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102Ab1JQUIL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 16:08:11 -0400
Received: (qmail 10832 invoked by uid 107); 17 Oct 2011 20:08:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Oct 2011 16:08:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Oct 2011 16:08:09 -0400
Content-Disposition: inline
In-Reply-To: <20111017200528.GA19054@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183818>

On Mon, Oct 17, 2011 at 10:05:28PM +0200, Clemens Buchacher wrote:

> On Sun, Oct 16, 2011 at 10:01:03PM -0400, Jeff King wrote:
> > 
> > Thanks, it's nice to have some tests. Overall, some of the tests feel a
> > little silly, because the results should be exactly the same as fetching
> > or pushing a local repository (so the "set-head" thing, for example,
> > really has little to do with git-daemon).
> 
> Hmm, yes. Actually, I thought I had found a bug with the failure of
> "set-head -a". But now I see that in t5505 this treated like a
> feature.

It's not a feature, exactly. It's just documenting that we fail in the
face of ambiguous HEADs. Arguably, the test should be switched to use
text_expect_failure to document that we would prefer it the other way,
but it doesn't work now.

> Would it be difficult to support this over the git protocol? Maybe
> I will have a look.

It needs a protocol extension to communicate symbolic ref destinations.
The topic has come up a few times, and I think Junio even had patches at
one point.

-Peff
