From: Petr Baudis <pasky@suse.cz>
Subject: Re: git pull for update of netdev fails.
Date: Sun, 24 Sep 2006 22:54:55 +0200
Message-ID: <20060924205455.GA20017@pasky.or.cz>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org> <Pine.LNX.4.63.0609202304270.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060923034407.GF8259@pasky.or.cz> <b0943d9e0609230610h46ffb995gb25ebda8332570e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 22:55:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRb0Y-0006yN-Rh
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 22:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWIXUy6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 16:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWIXUy6
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 16:54:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43141 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932089AbWIXUy5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 16:54:57 -0400
Received: (qmail 24617 invoked by uid 2001); 24 Sep 2006 22:54:55 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0609230610h46ffb995gb25ebda8332570e8@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27696>

Dear diary, on Sat, Sep 23, 2006 at 03:10:17PM CEST, I got a letter
where Catalin Marinas <catalin.marinas@gmail.com> said that...
> (I'm slow at replying and even slower at implementing anything over
> the next 2-3 weeks - paternity leave :-))

Congratulations! :-)

> I wasn't following this thread (well, any thread in the last days) but
> the current patch history implementation in StGIT is prune-safe as it
> generates additional commits to keep the history. If you undo an
> operation (push, refresh), the undo will be recorded in the patch
> history (that's really immutable)

It does not directly reference the history in the additional commits
though, it just mentions the sha1 in the log message - that is not
prune-safe:

$ cg-log -r patches/master/configchanges.log
...pick one at random...
commit 4e1ad4b1bfb9488636f1a43b3f3d4b8c3b4b2927
tree 4ba8253dff8190e75ad0f46deaef54747c4ad76d
parent 3d5f3a87134a056a52dc21bcc4b1c64a4eef9443
author pasky <pasky@rover.(none)> Tue, 19 Sep 2006 16:47:42 +0200
committer pasky <pasky@rover.(none)> Tue, 19 Sep 2006 16:47:42 +0200

    * Makefile:

    refresh     4852cc3fe638b332f4106b31a7abfafb2c6c3dfc
$ git-fsck-objects --unreachable | grep
4852cc3fe638b332f4106b31a7abfafb2c6c3dfc
unreachable commit 4852cc3fe638b332f4106b31a7abfafb2c6c3dfc

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
