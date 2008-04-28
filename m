From: Jeff King <peff@peff.net>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git
	push --mirror" update mirrors
Date: Sun, 27 Apr 2008 21:21:13 -0400
Message-ID: <20080428012113.GA15121@sigill.intra.peff.net>
References: <4812DA50.3000702@gnu.org> <20080426170126.GC29771@spearce.org> <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org> <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org> <7vabjflvlh.fsf@gitster.siamese.dyndns.org> <20080427173446.GM29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 03:22:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqI4S-0007th-V7
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 03:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbYD1BVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 21:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbYD1BVR
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 21:21:17 -0400
Received: from peff.net ([208.65.91.99]:3341 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbYD1BVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 21:21:17 -0400
Received: (qmail 6539 invoked by uid 111); 28 Apr 2008 01:21:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 27 Apr 2008 21:21:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Apr 2008 21:21:13 -0400
Content-Disposition: inline
In-Reply-To: <20080427173446.GM29771@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80494>

On Sun, Apr 27, 2008 at 01:34:46PM -0400, Shawn O. Pearce wrote:

> Just take the above as the rantings of someone who knows git a
> little too well, and has tried to teach it to people who don't,
> and they all have asked about the funny (to them) need for origin
> in git-pull/git-push command line sometimes (no refspecs) and not
> others (with refspecs).

I know git pretty well, and I find that particular distinction (that is,
needing to specify the remote if using refspecs, but not otherwise)
annoying.  And it _is_ a bit funny, but it has nothing to do with
concepts. It is purely a syntactic issue that relying on order of
arguments means you can't default earlier ones but specify later ones.

Whether you hit this particular syntactic funniness depends totally on
your workflow. If you don't tend to default that particular argument,
then you won't see it. But there are plenty of workflows where you
never need to specify a remote, and then typing "git push master:foo"
makes you stop and blink for a second when it fails.

Of course, I don't think there is a reasonable fix now, short of "git
push --ref master:foo".

-Peff
