From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Support for configurable git command aliases (v2)
Date: Mon, 5 Jun 2006 00:19:30 +0200
Message-ID: <20060604221930.GW10488@pasky.or.cz>
References: <20060604211931.10117.82695.stgit@machine.or.cz> <20060604212050.GV10488@pasky.or.cz> <mj+md-20060604.221036.15619.albireo@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 00:19:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn0wb-0007ga-76
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 00:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWFDWTd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 18:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWFDWTd
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 18:19:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23511 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932286AbWFDWTc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 18:19:32 -0400
Received: (qmail 19622 invoked by uid 2001); 5 Jun 2006 00:19:30 +0200
To: Martin Mares <mj@ucw.cz>
Content-Disposition: inline
In-Reply-To: <mj+md-20060604.221036.15619.albireo@ucw.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21289>

  Hi,

Dear diary, on Mon, Jun 05, 2006 at 12:11:14AM CEST, I got a letter
where Martin Mares <mj@ucw.cz> said that...
> > And I forgot to mention that it also adds the interactivity test
> > requested by Janek - aliases are now interpreted only when stdout is a
> > tty.
> 
> Does this really make sense? Why should an alias stop working
> if I happen to redirect its output? Or am I missing something?

  make

	[alias]
	log = log --pretty=raw

and then any script that works on git log output might get very
confused.

  Then again, as pointed out on IRC you might get very confused as well
if you do git log | less. Besides, this is not going to help you with
aliases like commit = commit -a.

  So, some other possibilities are to:

  (i) Test stdin. Even in scripts, stdin is frequently terminal, but you
might add </dev/null after each git invocation and get a serious case of
RSI.

  (ii) Add a --no-alias git argument. This way lies madness, too.

  (iii) Check a $GIT_NO_ALIAS environment variable. This might work
best, after all. Opinions? Or some other clever idea?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
