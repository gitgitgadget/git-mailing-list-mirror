From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Merge conflicts as .rej .orig files
Date: Fri, 19 Aug 2005 11:30:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508191115200.23242@iabervon.org>
References: <46a038f9050818200625d64a12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 17:28:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E68m1-0001gR-Td
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 17:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVHSP1L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 11:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVHSP1L
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 11:27:11 -0400
Received: from iabervon.org ([66.92.72.58]:45321 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751145AbVHSP1L (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2005 11:27:11 -0400
Received: (qmail 13264 invoked by uid 1000); 19 Aug 2005 11:30:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Aug 2005 11:30:36 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f9050818200625d64a12@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 19 Aug 2005, Martin Langhoff wrote:

> After using arch for a while, I've gotten used to getting .rej and
> .orig files instead of big ugly conflict markers inside the file.
> Emacs has a nice 'diff' mode that is a boon when dealing with
> conflicts this way.
>
> Is there a way to convince cogito/git to leave reject files around?
> What utility is git using to do the merges? Or at least: where should
> I look?

I believe you should be able to get that effect by having a version
of "git-merge-one-script" that does "diff -c $2 $3 | patch $1" or "diff -c
$2 $1 | patch $3", depending on which you want as the orig. (Or something
like that. I'm not sure exactly how to get the conflict files out of the
script and into the right place, or the arguments it gets.)

Of course, you'll probably have more conflicts to deal with, because the
merging code gets less information that way. (In particular, you'll lose
the "already contains changes" behavior, so you'll be unhappy if you have
patches merged upstream.)

	-Daniel
*This .sig left intentionally blank*
