From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Cogito: Use git-rev-parse instead of cg-Xnormid.
Date: Mon, 4 Jul 2005 01:03:51 +0200
Message-ID: <20050703230351.GE13848@pasky.ji.cz>
References: <42C77ECE.2080903@didntduck.org> <20050703065920.GA11765@pasky.ji.cz> <42C7D925.2070007@didntduck.org> <20050703154127.GA31848@pasky.ji.cz> <Pine.LNX.4.58.0507031535420.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 01:04:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpDVH-0006vZ-ND
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 01:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVGCXDz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 19:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVGCXDz
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 19:03:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26782 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261561AbVGCXDx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 19:03:53 -0400
Received: (qmail 30522 invoked by uid 2001); 3 Jul 2005 23:03:51 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507031535420.3570@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Jul 04, 2005 at 12:40:52AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Sun, 3 Jul 2005, Petr Baudis wrote:
> > 
> > That's right. Well, for everything but the short id matching we could
> > just check the ID validity by git-rev-parse instead of peeking into
> > the object store - I just did that.
> 
> What's the format of the short ID? Minimum 6 characters of the SHA1 or
> something?
> 
> Pack-files in many ways should be even easier to look up the ID in, since
> the pack-file index has all the SHA1's for that pack file listed in sorted
> order, so it should be fairly easy to just look it up based on the first
> few bytes.. If somebody sends me a patch, that should be fine.

Actually, the minimum is 4 characters, but that shouldn't be much of an
issue. Cogito's behaviour is to raise an error in case of multiple
matches; but that could be controlled by a switch too...

	bash$ complete -C git-rev-parse git* cg*


I will cook up a patch in a day or two if noone outruns me.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
