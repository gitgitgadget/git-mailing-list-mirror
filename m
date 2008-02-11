From: Jeff King <peff@peff.net>
Subject: Re: limiting rename detection during merge is a really bad idea
Date: Mon, 11 Feb 2008 02:48:17 -0500
Message-ID: <20080211074817.GA18898@sigill.intra.peff.net>
References: <CF28A4AE-62F0-4E41-9794-2CF85C2C7855@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:49:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOTPP-00007e-4c
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 08:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbYBKHsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 02:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYBKHsX
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 02:48:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3462 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbYBKHsX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 02:48:23 -0500
Received: (qmail 5336 invoked by uid 111); 11 Feb 2008 07:48:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 11 Feb 2008 02:48:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2008 02:48:17 -0500
Content-Disposition: inline
In-Reply-To: <CF28A4AE-62F0-4E41-9794-2CF85C2C7855@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73477>

On Mon, Feb 11, 2008 at 07:19:32AM +0100, Steffen Prohaska wrote:

> I think that limiting rename detection during merge is a really
> bad idea.  Either we should set it to unlimited, or at least we
> should print a BIG WARNING that rename detection is limited
> during the merge.  I'd propose to override diff.renamelimit
> to unlimited for a merge, even if diff.renamelimit is explicitly
> configured by the user.  It doesn't make sense not to detect
> renames during a merge.
>
> Opinions?

The point of diff.renamelimit was that some rename detection is
literally so time-consuming that we might as well not bother starting
it. The number '100' was pulled out of Linus', er, hat. Perhaps a better
argument is that the renamelimit should be set much higher to accomplish
that goal?

It may also be that multiple rename limits are appropriate. I don't mind
waiting 30 seconds for rename detection during a particularly tricky
merge. I probably do when running 'git-log -p'.

-Peff
