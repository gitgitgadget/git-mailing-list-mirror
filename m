From: Jeff King <peff@peff.net>
Subject: Re: RFH: unexpected reflog behavior with --since=
Date: Thu, 10 Nov 2011 02:59:41 -0500
Message-ID: <20111110075941.GA28148@sigill.intra.peff.net>
References: <4EB9C7D1.30201@nextest.com>
 <20111109220128.GA31535@sigill.intra.peff.net>
 <4EBB81EA.6060303@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 08:59:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPY6-0007ND-8T
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110Ab1KJH7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:59:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38937
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000Ab1KJH7o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:59:44 -0500
Received: (qmail 22714 invoked by uid 107); 10 Nov 2011 07:59:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:59:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:59:41 -0500
Content-Disposition: inline
In-Reply-To: <4EBB81EA.6060303@nextest.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185213>

On Wed, Nov 09, 2011 at 11:48:58PM -0800, Eric Raible wrote:

> > But it may also be a misfeature, because it's not clear what you're
> > actually trying to limit by. We have commit timestamps, of course, but
> > when we are walking reflogs, we also have reflog timestamps. Did you
> > actually want to say "show me all commits in the reflog, in reverse
> > reflog order, omitting commits that happened before time t"? Or did you
> > really mean "show me the reflog entries that happened before time t,
> > regardless of their commit timestamp"?
> 
> I meant "show me the reflog entries that happened *since* time t,
> regardless of their commit timestamp.

Err, yeah, sorry. Somehow in the middle of writing the email I got
turned backwards about which direction we were interested in.

But I think you get the point.

> Since -g is asking specifying for the reflog, and since the reflog has
> its own timestamps, I would expect that those timestamps be used.

Then I think my one-liner patch should do what you want. And now it's
not just anecdotal evidence that I think it's the right behavior. There
are two of us; we're _data_.

-Peff
