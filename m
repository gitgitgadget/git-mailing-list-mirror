From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] mergetool: clarify local/remote terminology
Date: Mon, 25 Feb 2008 13:46:48 -0500
Message-ID: <20080225184648.GC15131@sigill.intra.peff.net>
References: <1203570776-62019-1-git-send-email-jaysoffian@gmail.com> <76718490802250631p262baf1bw23873e5fdbbb7180@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:47:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTiMJ-0006pP-Qi
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 19:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbYBYSqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 13:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbYBYSqv
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 13:46:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1526 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753814AbYBYSqv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 13:46:51 -0500
Received: (qmail 11729 invoked by uid 111); 25 Feb 2008 18:46:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 25 Feb 2008 13:46:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2008 13:46:48 -0500
Content-Disposition: inline
In-Reply-To: <76718490802250631p262baf1bw23873e5fdbbb7180@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75043>

On Mon, Feb 25, 2008 at 09:31:03AM -0500, Jay Soffian wrote:

> Anyone?
> 
> On Thu, Feb 21, 2008 at 12:12 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> > Always calling the thing on the left-side of a merge "local" and on the
> >  right side "remote" isn't correct. You could be rebasing, in which case
> >  the left side is the new base/upstream and the right side is the saved
> >  commits which are being re-applied. So,

I have been annoyed by this in the past, too. And I think your change is
probably an improvement (though I haven't tried it yet). As a user, what
I would _really_ like to see, though, is simply the branch names:
"origin/next" versus "next". I looked at using the GITHEAD_* mechanism
in the past, but that relies on the environment, which can't get
directly to mergetool. See this thread:

http://mid.gmane.org/20070820075318.GA12478@coredump.intra.peff.net

I think the right thing to do is the oft-discussed-but-never-implemented
"what's happening right now" file/command that would say:

  1. there's a rebase happening now
  2. the upstream branch is X
  3. the rebased branch is Y

but that could also of course say

  1. there's a merge happening now
  2. the first parent is X
  3. the second parent is Y

and so on (including "we're in a git-am, git-cherry-pick, etc").

I'll try out your patch and comment next time I use it.

-Peff
