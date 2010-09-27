From: Jeff King <peff@peff.net>
Subject: Re: git push on tracking branches
Date: Mon, 27 Sep 2010 12:05:48 -0400
Message-ID: <20100927160548.GA10256@sigill.intra.peff.net>
References: <6958088.371432.1285602164529.JavaMail.root@mail.hq.genarts.com>
 <15793457.371451.1285603241207.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 18:06:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0GDP-00044A-8e
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 18:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933180Ab0I0QFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 12:05:53 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:42557 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933161Ab0I0QFw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 12:05:52 -0400
Received: (qmail 17490 invoked by uid 111); 27 Sep 2010 16:05:51 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 27 Sep 2010 16:05:51 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Sep 2010 12:05:48 -0400
Content-Disposition: inline
In-Reply-To: <15793457.371451.1285603241207.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157345>

On Mon, Sep 27, 2010 at 12:00:41PM -0400, Stephen Bash wrote:

> A coworker alerted me to some strange behavior with git push on tracking branches (maybe a documentation error?).  Pro Git (http://progit.org/book/ch3-5.html) says:
> 
> "To set up a local branch with a different name than the remote branch, you can easily use the first version with a different local branch name:
>    $ git checkout -b sf origin/serverfix
>    Branch sf set up to track remote branch refs/remotes/origin/serverfix.
>    Switched to a new branch "sf"
> Now, your local branch sf will automatically push to and pull from origin/serverfix."

That has never been the case by default. Push has always defaulted to
pushing all matching branches (so of course if you use the same name, it
will end up pushing to the tracking branch).  However, you can do:

  git config --global push.default tracking

to explicitly change the default to push the current branch to its
upstream. See the entry for "push.default" in "git help config".

It may be that Pro Git suggested setting up that config earlier. If not,
you should probably submit a bug report for the book.

-Peff
