From: Petr Baudis <pasky@suse.cz>
Subject: Re: rsync deprecated but promoted?
Date: Mon, 26 Sep 2005 22:43:04 +0200
Message-ID: <20050926204304.GE26340@pasky.or.cz>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org> <20050926133204.GB21019@pasky.or.cz> <Pine.LNX.4.58.0509260801430.3308@g5.osdl.org> <dh98gk$6rp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 22:45:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJzob-0007Ve-Vc
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 22:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVIZUnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 16:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVIZUnG
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 16:43:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63723 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750711AbVIZUnF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 16:43:05 -0400
Received: (qmail 8325 invoked by uid 2001); 26 Sep 2005 22:43:04 +0200
To: walt <wa1ter@myrealbox.com>
Content-Disposition: inline
In-Reply-To: <dh98gk$6rp$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9331>

Dear diary, on Mon, Sep 26, 2005 at 06:44:04PM CEST, I got a letter
where walt <wa1ter@myrealbox.com> told me that...
> Linus Torvalds wrote:
> [...]
> >You basically have to run fsck on your repository after an rsync. And if 
> >it returns errors, you're screwed unless you remember what your old heads 
> >were.
> 
> Just because you mentioned it, I did a git-fsck-objects on my local
> copies of your kernel tree and Junio's git tree.
> 
> From git I got this:
> $git-fsck-objects
> missing commit 00d8bbd3c4bba72a6dfd48c2c0c9cbaa000f13c2
> broken link from     tag 02b2acff8bafb6d73c6513469cdda0c6c18c4138
>               to  commit d5bc7eecbbb0b9f6122708bf5cd62f78ebdaafd8
> <similar lines snipped>

This isn't too harmful. It just means that you have a tag ref and the
corresponding tag object, but not the commit tagged by that object.
This is nothing harmful as long as you don't try to reference the tag,
and if you don't have the commit object already, it's actually not quite
likely that you would, since you don't have the branch the bug belongs
to anyway. I'll hopefully fix this bug during the weekend.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
