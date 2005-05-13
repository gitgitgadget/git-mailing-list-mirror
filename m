From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Ignore file filter
Date: Sat, 14 May 2005 01:12:29 +0200
Message-ID: <20050513231229.GI32232@pasky.ji.cz>
References: <4283CAF8.3050304@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 01:21:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWjSQ-0007Az-EO
	for gcvg-git@gmane.org; Sat, 14 May 2005 01:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVEMXPy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 19:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVEMXNa
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 19:13:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53129 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262394AbVEMXMb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 19:12:31 -0400
Received: (qmail 9634 invoked by uid 2001); 13 May 2005 23:12:29 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <4283CAF8.3050304@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 11:30:32PM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> # This doesn't allow the -h which is the [ arg for symlinks...

But so is -L. And I'd just use -l...

> #. ${COGITO_LIB}cg-Xlib
> _git=${GIT_DIR:-.git}

...but it makes no sense anyway I think to reinclude this stuff from a
cg-Xfile you are including from other scripts anyway.

> 	    if [[ $file =~ $patt ]]; then

I'm sorry but this is really nothing my bash-2.05.0(1)-release supports.
We're already bash-only, but further reducing that to bash3 really won't
work. I *might* get convinced to add some bash2+-only feature, but only
if you'll be really good at explaining that it makes sense.

Besides, I'd prefer just the shell globs in the ignore file, as it is
done in the rest of the world, and in all the real-world scenarios I've
seen, the globs were powerful enough.

Also, how does this interact with git-ls-files --exclude and
.git/exclude? We would have two ignoring mechanisms...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
