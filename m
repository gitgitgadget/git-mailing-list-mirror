From: Jeff King <peff@peff.net>
Subject: Re: git-branch, older repos and more confusion
Date: Thu, 12 Apr 2007 00:23:08 -0400
Message-ID: <20070412042308.GA22539@coredump.intra.peff.net>
References: <46a038f90704112114t520374b2qea4f860575c21bce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 06:23:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbqq3-0007gw-Pu
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 06:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbXDLEXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 00:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbXDLEXM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 00:23:12 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3831 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422642AbXDLEXL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 00:23:11 -0400
Received: (qmail 3279 invoked from network); 12 Apr 2007 04:23:49 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 12 Apr 2007 04:23:49 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2007 00:23:08 -0400
Content-Disposition: inline
In-Reply-To: <46a038f90704112114t520374b2qea4f860575c21bce@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44318>

On Thu, Apr 12, 2007 at 04:14:06PM +1200, Martin Langhoff wrote:

> My git tracking repo is still using the .git/remotes/origin
> infrastructure, and now it turns out I can't seem to do a git-pull and
> then a git-format-patch of my local 'master' for patches to go on top
> of junio's master. I am using 1.5.1.106.ga32037

What doesn't work? IIRC, you might have some problems with doing a
'pull' with no parameters, since you don't have the right magic in
.git/config. Have you tried an explicit "git-pull origin master"?

> Alas - I think support for it seems to be going the away... what I am
> missing is a clear way to say git-clone <repo>#branch that has the
> same properties that `cg-clone <repo>#branch` has. Namely, once you
> are done, there are clear names for your "local tip" and "remote tip",
> and push and pull do the right thing without extra params.

I don't think there is a way to clone _just_ that branch, but if you're
OK with fetching all of the branches, then you should be able to do
just:

git-clone <repo>
git-branch --track branch origin/branch
git-checkout branch

Yours is 'branch' and remote is 'origin/branch'. If that branch is
master, then I believe git-clone should set you up already (and you can
even still refer to 'origin', which is a synonym for origin/HEAD).

Or am I not understanding your problem?

-Peff
