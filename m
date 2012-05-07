From: Jeff King <peff@peff.net>
Subject: Re: Arguments to git hooks
Date: Mon, 7 May 2012 03:15:41 -0400
Message-ID: <20120507071541.GA19874@sigill.intra.peff.net>
References: <CAH-tXsB4PBS_YjW4DCjT6ORmNPomQ8XMPbKx3hxVNH=FyB2u3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 09:15:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRIAf-0003os-RL
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 09:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394Ab2EGHPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 03:15:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60419
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755387Ab2EGHPq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 03:15:46 -0400
Received: (qmail 17585 invoked by uid 107); 7 May 2012 07:16:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 03:16:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 03:15:41 -0400
Content-Disposition: inline
In-Reply-To: <CAH-tXsB4PBS_YjW4DCjT6ORmNPomQ8XMPbKx3hxVNH=FyB2u3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197236>

On Mon, May 07, 2012 at 12:05:51AM +0530, jaseem abid wrote:

> I am trying to write a hook '.git/hooks/commit-msg' to be run before
> every commit.
> 
> How can I pass arguments to the script? Now by default the only arg I
> am getting is `.git/COMMIT_EDITMSG'`. I would love to get the list of
> files I tried to commit also into the script so that I can run a lint
> program on it before committing it. How can I get this done?

It sounds like you want the "pre-commit" hook rather than "commit-msg".

But that aside, the solution is to use plumbing commands to examine the
state. You probably want "git diff-index --cached --name-only" to get
the list of files that are being committed.

-Peff
