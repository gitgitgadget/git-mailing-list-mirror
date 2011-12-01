From: Jeff King <peff@peff.net>
Subject: Re: Status after 'git clone --no-checkout' ?
Date: Thu, 1 Dec 2011 14:00:58 -0500
Message-ID: <20111201190058.GC2873@sigill.intra.peff.net>
References: <jb59h0$p3e$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "norbert.nemec" <norbert.nemec@native-instruments.de>
X-From: git-owner@vger.kernel.org Thu Dec 01 20:01:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWBsX-0003Cv-UZ
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 20:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994Ab1LATBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 14:01:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59238
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755789Ab1LATBA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 14:01:00 -0500
Received: (qmail 18994 invoked by uid 107); 1 Dec 2011 19:07:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Dec 2011 14:07:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2011 14:00:58 -0500
Content-Disposition: inline
In-Reply-To: <jb59h0$p3e$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186187>

On Wed, Nov 30, 2011 at 02:02:22PM +0100, norbert.nemec wrote:

> what exactly is the status after 'git clone --no-checkout'? Is there
> any straightforward way how one could end up in this state starting
> from a regularly checked out repository?

You have a HEAD which points to some actual commit, but no index or
working tree. I don't think there is a particular name for this state.

You can get something similar in an existing repo by deleting all of the
working tree files and removing .git/index.

> 'git checkout' without any further options serves to move from the
> aforementioned special state to a regular checked out state.
> Otherwise it never seems to do anything. Are there any other
> situations where 'git checkout' on its own would have any effect?

By itself, I don't think so. But you can use "git checkout -f" to
discard changes in the index and working tree, setting them back to the
state in HEAD.

At one point, some people used "git checkout" as a no-op, because it
would print the "ahead/behind" information with respect to the upstream.
These days, that information is part of "git status", so I suspect
people use that instead.

-Peff
