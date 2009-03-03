From: Jeff King <peff@peff.net>
Subject: Re: remote branches, and branch names in general
Date: Tue, 3 Mar 2009 11:11:17 -0500
Message-ID: <20090303161117.GB32079@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E709F07398@EXCHANGE.trad.tradestation.com> <m3vdqrtp84.fsf@localhost.localdomain> <20090303041631.GB18136@coredump.intra.peff.net> <450196A1AAAE4B42A00A8B27A59278E709F075DF@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:12:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXEe-0007Gt-Mj
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbZCCQLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 11:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbZCCQLX
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:11:23 -0500
Received: from peff.net ([208.65.91.99]:34261 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210AbZCCQLW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 11:11:22 -0500
Received: (qmail 17594 invoked by uid 107); 3 Mar 2009 16:11:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 11:11:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 11:11:17 -0500
Content-Disposition: inline
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709F075DF@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112101>

On Tue, Mar 03, 2009 at 10:52:21AM -0500, John Dlugosz wrote:

> But I wonder if some commands work differently or specifically don't
> look in remotes.  I "learned" to qualify everything when I accidently
> created a local branch named pub/xxx instead of using remotes/pub/xxx
> like I intended.  I don't remember what that was, but I'm guessing
> that maybe refs that are a destination are different, as you are only
> supposed to change your local stuff.  I think that was a "pull"
> command, before I had the automatic argument in the config file.

Yes, the "branch" command deals only with creating things in refs/heads,
which are your local branches (similarly, "git tag" will only deal with
stuff in refs/tags). So "git branch origin/foo" will make a ref
"refs/heads/origin/foo", and "git branch -d origin/foo" will delete
"refs/heads/origin/foo", not "refs/remotes/origin/foo".

But when looking up a ref, the rules are used. So you can say:

  git branch master origin/master

which will make "refs/heads/master" from "refs/remotes/origin/master".

-Peff
