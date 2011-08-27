From: Jeff King <peff@peff.net>
Subject: Re: Files that cannot be added to the index
Date: Sat, 27 Aug 2011 02:07:18 -0400
Message-ID: <20110827060718.GA28136@sigill.intra.peff.net>
References: <CAMvu5bLuRWinMYNc4NoRKQKiLCWLcwkpowEFT4GQ0mcJYj6eOg@mail.gmail.com>
 <4E57A93A.6090405@drmicha.warpmail.net>
 <20110826205919.GB8107@sooty-2.local>
 <20110826211233.GB3093@digium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	seanh <snhmnd@gmail.com>, git@vger.kernel.org
To: Shaun Ruffell <sruffell@digium.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 08:07:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxC3C-0002GI-OO
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 08:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926Ab1H0GHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 02:07:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49914
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834Ab1H0GHV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 02:07:21 -0400
Received: (qmail 1844 invoked by uid 107); 27 Aug 2011 06:08:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 27 Aug 2011 02:08:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Aug 2011 02:07:18 -0400
Content-Disposition: inline
In-Reply-To: <20110826211233.GB3093@digium.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180223>

On Fri, Aug 26, 2011 at 04:12:33PM -0500, Shaun Ruffell wrote:

> On Fri, Aug 26, 2011 at 10:59:19PM +0200, seanh wrote:
> > I'm using git version 1.7.4.4 on OSX Lion, from macports. (I was
> > having the problem on Snow Leopard too.)
> 
> Not sure if this is your problem exactly but awhile back I ran into
> something similar to what you describe and tracked it down to the
> fact that my filesystem was case insensitive. i.e.
> [...]
>   $ git commit
>   # On branch master
>   # Changes not staged for commit:
>   #   (use "git add <file>..." to update what will be committed)
>   #   (use "git checkout -- <file>..." to discard changes in working directory)
>   #
>   #	modified:   Makefile
>   #
>   no changes added to commit (use "git add" and/or "git commit -a")
> 
>   $ git add makefile 
>   $ git commit
>   # On branch master
>   # Changes not staged for commit:
>   #   (use "git add <file>..." to update what will be committed)
>   #   (use "git checkout -- <file>..." to discard changes in working directory)
>   #
>   #	modified:   Makefile
>   #
>   no changes added to commit (use "git add" and/or "git commit -a")

I think both of you may be seeing the same bug I tracked down here:

  http://thread.gmane.org/gmane.comp.version-control.git/173612/focus=174634

Does the patch from the very end of the thread solve the problem for
you? I should probably clean it up for inclusion in git.

-Peff
