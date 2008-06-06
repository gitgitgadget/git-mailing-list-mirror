From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Fri, 6 Jun 2008 02:03:18 -0400
Message-ID: <20080606060318.GE18257@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200805291737.53291.trast@student.ethz.ch> <20080529185808.GA2140@sigill.intra.peff.net> <200806010241.51464.trast@student.ethz.ch> <20080605014618.GA27381@sigill.intra.peff.net> <7vprqw2t64.fsf@gitster.siamese.dyndns.org> <20080605085605.GA16624@sigill.intra.peff.net> <alpine.DEB.1.00.0806051126060.21190@racer> <20080606051026.GA18257@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 08:04:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4V49-0007P9-VU
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 08:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbYFFGDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 02:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbYFFGDW
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 02:03:22 -0400
Received: from peff.net ([208.65.91.99]:3009 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673AbYFFGDW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 02:03:22 -0400
Received: (qmail 1476 invoked by uid 111); 6 Jun 2008 06:03:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 06 Jun 2008 02:03:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jun 2008 02:03:18 -0400
Content-Disposition: inline
In-Reply-To: <20080606051026.GA18257@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84028>

On Fri, Jun 06, 2008 at 01:10:26AM -0400, Jeff King wrote:

>   2. It's not integrated into the git-add--interactive loop at all. That
>      is, I don't start out saying "I want to edit this diff." I look at
>      the diff while staging with "git add -p" and say "Oops, I need to
>      edit this hunk." So I think it is better implemented as an "e"
>      option in the hunk adding loop, with "git add -e" as a shortcut.
>      Or maybe there is simply room for both (and "git add -e", rather
>      than being a shortcut, just means "do this on the _whole_ file").

I wrote this after reading just your first patch, and it looks like
you've made much progress since. It seems like Thomas' patch could just
get rid of all the recounting entirely, and just pass off the edited
hunks to "git apply --recount". Which should make his patch much smaller
and more straightforward.

-Peff
