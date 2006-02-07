From: Petr Baudis <pasky@suse.cz>
Subject: Re: [Cogito] Various bugs
Date: Tue, 7 Feb 2006 03:10:06 +0100
Message-ID: <20060207021006.GM31278@pasky.or.cz>
References: <20060131041318.GC30744@diku.dk> <20060207003643.GJ31278@pasky.or.cz> <7vfymw3oym.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 03:10:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6IIr-0002Ke-8y
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 03:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWBGCJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 21:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWBGCJ6
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 21:09:58 -0500
Received: from w241.dkm.cz ([62.24.88.241]:9399 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932439AbWBGCJ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 21:09:57 -0500
Received: (qmail 10474 invoked by uid 2001); 7 Feb 2006 03:10:06 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfymw3oym.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15676>

Dear diary, on Tue, Feb 07, 2006 at 03:03:13AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > I'm puzzled. GIT should handle this fine.
> >
> > 	export GIT_AUTHOR_NAME=''
> > 	git-commit-tree $(cg-object-id -t)
> >
> > works as expected, but for some reason escaping me it does not work
> > inside of cg-commit. Insights welcomed.
> 
> They probably do not have anything to do with the problem at
> hand, but I just noticed your version of pick-author code in
> cg-commit lacks two changes I added to git-commit:
> 
>  (1) the pick_author_script you have in cg-commit lacks the
>      support for names with single-quotes in them
>      (aa66c7ec77d474b737da607d6cb2d07f56628def).
> 
>  (2) I run the sed script with LANG and LC_ALL set to C locale.
>      I think I had some trouble without them with high-bit
>      names, (e3e291fc07b49b74bb655ca854bdb19e849e044c) but the
>      detail escapes me.

Thanks, I've updated the cg-commit version. Note that the empty
GIT_AUTHOR_NAME problem seems to exist in git-commit as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
