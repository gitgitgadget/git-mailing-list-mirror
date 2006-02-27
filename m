From: Petr Baudis <pasky@suse.cz>
Subject: Re: Recoding of {git,cg}-log output
Date: Mon, 27 Feb 2006 02:26:56 +0100
Message-ID: <20060227012656.GX31278@pasky.or.cz>
References: <44024384.4060406@people.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 02:26:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDX9Z-00038G-4P
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 02:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWB0B0O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 20:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWB0B0N
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 20:26:13 -0500
Received: from w241.dkm.cz ([62.24.88.241]:32962 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750712AbWB0B0N (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 20:26:13 -0500
Received: (qmail 14688 invoked by uid 2001); 27 Feb 2006 02:26:56 +0100
To: Krzysiek Pawlik <krzysiek.pawlik@people.pl>
Content-Disposition: inline
In-Reply-To: <44024384.4060406@people.pl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16818>

Dear diary, on Mon, Feb 27, 2006 at 01:10:44AM CET, I got a letter
where Krzysiek Pawlik <krzysiek.pawlik@people.pl> said that...
> 
> First: a little "why": having /usr/bin/vim as PAGER allows to enter
> UTF-8 commit messages quite easily, the problem is when git-log (or
> cg-log) is run in terminal that's not UTF-8. In my case: terminal is
> ISO-8859-2 and:
> 
> nelchael@nelchael ~$ cat ~/.vimrc | grep gitci
> au BufRead /tmp/gitci* setlocal textwidth=75 fileencoding=utf-8
> encoding=utf-8 fileencodings=utf-8,default

Wouldn't it be enough to also set termencoding?

> So... having {git,cg}-log recode the log entires when displaying is
> quite useful. Two patches attached:
> 
>  a. git-log-recode.patch - uses iconv to recode the log output to
> GIT_LOG_RECODE encoding
>  b. cg-log-recode.patch - the same, but for cogito
> 
> With this patches it's possible to write UTF-8 commit messages and see
> them ok in non-UTF-8 terminal in log by having GIT_LOG_RECODE=iso-8859-2.
> 
> Comments?

Not opposed in principle. But it would be much more sensible to have
something like $GIT_META_ENCODING (defaulting probably to utf8), recode
to whatever is your current locale, have the appropriate setting in the
configfile, ...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
