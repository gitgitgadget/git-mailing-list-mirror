From: Jeff King <peff@peff.net>
Subject: Re: git push [rejected] question
Date: Tue, 19 Feb 2008 10:08:27 -0500
Message-ID: <20080219150826.GA24499@sigill.intra.peff.net>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com> <20080219043353.GA23239@sigill.intra.peff.net> <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jason Garber <jgarber@ionzoft.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 16:09:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRU5f-0000Zf-VP
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 16:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676AbYBSPIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 10:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755664AbYBSPIb
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 10:08:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2965 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280AbYBSPIa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 10:08:30 -0500
Received: (qmail 21613 invoked by uid 111); 19 Feb 2008 15:08:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 19 Feb 2008 10:08:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Feb 2008 10:08:27 -0500
Content-Disposition: inline
In-Reply-To: <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74413>

On Tue, Feb 19, 2008 at 08:09:36AM -0500, Jay Soffian wrote:

> git-push(1) is a bit confusing I think:
> 
>   "Note: If no explicit refspec is found, (that is neither on the command line
>   nor in any Push line of the corresponding remotes file---see below), then all
>   the heads that exist both on the local side and on the remote side are
>   updated."
> 
> is clear enough, but then:
> 
>   "--all Instead of naming each ref to push, specifies that all refs under
>   $GIT_DIR/refs/heads/ be pushed."
> 
> So what is '--all' needed for then?

In the first case we push "matching" refs: any head which already exists
on both sides. In the second case, we push all heads which exist on the
sending send, whether or not a matching ref already exists on the remote
side.

I think the first statement could be made to emphasize the matching
aspect a little more, since a quick read makes it seem like it's pushing
the union of the two sets, not the intersection of the two sets.

> It seems like the default should be to push just the current branch
> ... this would correspond to what a user of git pull expects (even
> though the converse of git-push is really git-fetch, for a new user,
> that might not be entirely clear).

I agree with you, but others do not; this has come up several times in
the past (there was some discussion a week or two ago in the thread
"Minor annoyance with git push").

-Peff
