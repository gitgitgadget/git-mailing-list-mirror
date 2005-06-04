From: Petr Baudis <pasky@ucw.cz>
Subject: Re: How stop tracking a file?
Date: Sat, 4 Jun 2005 03:24:11 +0200
Message-ID: <20050604012411.GH13093@pasky.ji.cz>
References: <4290B7FB.5070708@adelphia.net> <7vacmnfapv.fsf@assigned-by-dhcp.cox.net> <4290CF85.5060105@adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 03:21:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeNM4-0001gX-V4
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 03:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVFDBYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 21:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVFDBYe
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 21:24:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48256 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261208AbVFDBYP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 21:24:15 -0400
Received: (qmail 15622 invoked by uid 2001); 4 Jun 2005 01:24:11 -0000
To: jeff millar <wa1hco@adelphia.net>
Content-Disposition: inline
In-Reply-To: <4290CF85.5060105@adelphia.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 22, 2005 at 08:29:25PM CEST, I got a letter
where jeff millar <wa1hco@adelphia.net> told me that...
> Junio C Hamano wrote:
> 
> >   jm> cg-rm does two things
> >   jm>    rm -f "$@"
> >   jm>    git-update-cache --remove -- "$@"
> >
> >I do not do Porcelain, but something along the following lines
> >should work:
> >
> >   for path
> >   do
> >       git-update-cache --force-remove "$path"
> >   done
> >
> Seems a bit more difficult...
> [jeff@Desk gsmc-1.1]$ git-update-cache --force-remove main.o
> [jeff@Desk gsmc-1.1]$ cg-diff
> Index: main.o
> ===================================================================
> Binary files a5d1a55e0818ab11b71fee01bcd9053c4ecc65a6/main.o 
> (mode:100644) and /dev/null (tree:uncommitted) differ
> [jeff@Desk gsmc-1.1]$ cg-commit
> Refusing to make an empty commit - the tree was not modified
> since the previous commit. If you really want to make the
> commit, do: commit-tree `tree-id` -p `parent-id`
> A picky porcelain problem?

Ok, it took some non-trivial changes to cg-commit (this part was a quick
hack before, now it looks a lot better), but cg-rm -n should now do what
you want.

Thanks for the suggestion,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
