From: Petr Baudis <pasky@suse.cz>
Subject: Re: [BUG] make test (t3600-rm.sh) fails
Date: Fri, 24 Mar 2006 14:51:02 +0100
Message-ID: <20060324135102.GX18185@pasky.or.cz>
References: <4423C681.3000302@issaris.org> <7v7j6k16g2.fsf@assigned-by-dhcp.cox.net> <df33fe7c0603240245o516095b5m@mail.gmail.com> <7vy7z0yuav.fsf@assigned-by-dhcp.cox.net> <4423E06E.9090004@issaris.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 14:52:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMmh6-0005a7-4B
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 14:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422810AbWCXNvF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 08:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWCXNvF
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 08:51:05 -0500
Received: from w241.dkm.cz ([62.24.88.241]:50375 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932619AbWCXNvB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 08:51:01 -0500
Received: (qmail 31268 invoked by uid 2001); 24 Mar 2006 14:51:02 +0100
To: Panagiotis Issaris <takis@issaris.org>
Content-Disposition: inline
In-Reply-To: <4423E06E.9090004@issaris.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17918>

Dear diary, on Fri, Mar 24, 2006 at 01:05:02PM CET, I got a letter
where Panagiotis Issaris <takis@issaris.org> said that...
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index d1947e1..52a1e99 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -56,6 +56,7 @@ test "$test_tabs" = y && test_expect_suc
>     "git-rm -f 'space embedded' 'tab   embedded' 'newline
> embedded'"
> 
> +if test `whoami` != "root"; then

Root is not the only condition when this will not fail, it can happen
on broken filesystems as well, specifically AFS. (Avoid avoid avoid that
horrid thing!)

So, perhaps rather

> if test "$test_tabs" = y; then
> chmod u-w .
+ touch xyzzy || \
> test_expect_failure \

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
