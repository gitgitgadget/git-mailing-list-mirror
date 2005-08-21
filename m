From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: "git reset" and newly created files.
Date: Sun, 21 Aug 2005 23:46:05 +0200
Message-ID: <20050821214605.GA4134@mars.ravnborg.org>
References: <7vbr3rccjc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 23:48:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6xep-0001Un-On
	for gcvg-git@gmane.org; Sun, 21 Aug 2005 23:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVHUVqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 17:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVHUVqK
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 17:46:10 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:35212 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751214AbVHUVpn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2005 17:45:43 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepc.post.tele.dk (Postfix) with ESMTP id 4F4C2262837;
	Sun, 21 Aug 2005 23:45:40 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 02D056AC01D; Sun, 21 Aug 2005 23:46:06 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbr3rccjc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> 
> So you would naturally be tempted to do this:
> 
>     ... Re-edit, compile, and test.  This time it is perfect.
>     $ git commit -a -C ORIG_HEAD
> 
> Well, not really.  You can lose any file newly created in
> ORIG_HEAD this way.  Instead, you need to do this:
> 
>     ... Re-edit, compile, and test.  This time it is perfect.
>     $ git add <whatever file you have changed>
>     $ git commit -a -C ORIG_HEAD
> 
> Do people find this a big problem?

I often do some maybe not that brilliant changes in my tree,
and when I then ask git to reset these I expect git to reset
everything.

After a git-reset HEAD^ I really expect git to have rewinded back till
where I started with no files added whatsoever.

>From the matter of least suprise git should not remember files added,
one have to do that by themself again if needed.

	Sam
