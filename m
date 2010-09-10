From: Jeff King <peff@peff.net>
Subject: Re: Coping with the pull-before-you-push model
Date: Fri, 10 Sep 2010 10:15:27 -0400
Message-ID: <20100910141527.GA6936@sigill.intra.peff.net>
References: <4C8866F9.1040705@workspacewhiz.com>
 <AANLkTikY55ZJvSTqyFKLqwABqnJZuODz3yrc7CFvQf0K@mail.gmail.com>
 <4C88F2A9.2080306@workspacewhiz.com>
 <AANLkTikdV3W1d7uNokKRRiT4FeznL1uM=Y9SQLDqgAic@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 16:15:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou4O0-0003iw-HO
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 16:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992Ab0IJOPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 10:15:15 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58877 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946Ab0IJOPO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 10:15:14 -0400
Received: (qmail 24679 invoked by uid 111); 10 Sep 2010 14:15:12 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 10 Sep 2010 14:15:12 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Sep 2010 10:15:27 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikdV3W1d7uNokKRRiT4FeznL1uM=Y9SQLDqgAic@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155930>

On Fri, Sep 10, 2010 at 03:35:21PM +1000, Jon Seymour wrote:

> This is probably the cultural shift that is hardest for enterprises to
> accept - why do I need a _person_ to do this _manual_ work when tools
> like {insert favourite non-DVCS here} can do this for me? To
> management, this looks like a step-backwards.

Bear in mind that you can still shift to a maintainer model, but keep
the maintainer automated. That is, you can queue up "to-pull" heads, and
then have an automated process pull them one by one and do some basic QA
(does it merge, does it build, does it pass automated tests, etc). Which
is not that different from what many shops do in the non-maintainer
model, except that when you break the build, the maintainer process
notices _before_ publishing the merged tip, so everybody won't try to
build on your broken crap.

I seem to recall that Gerrit does something like this, but I may be
mis-remembering. I haven't actually used it for real work.

I still prefer a human maintainer, because they can do things like
reorder the queue manually (or outright reject flaky topics) to get more
sensible merges, or do easy but non-trivial merges themselves to avoid
kicking code back to the developer.

-Peff
