X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 23:20:08 +0100
Message-ID: <20061116222008.GA7201@pasky.or.cz>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net> <20061116051240.GV7201@pasky.or.cz> <7vr6w33vv3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 22:20:46 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vr6w33vv3.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31627>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkpak-0004IX-MH for gcvg-git@gmane.org; Thu, 16 Nov
 2006 23:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424740AbWKPWUM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 17:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424741AbWKPWUM
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 17:20:12 -0500
Received: from w241.dkm.cz ([62.24.88.241]:40919 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1424740AbWKPWUK (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 17:20:10 -0500
Received: (qmail 9826 invoked by uid 2001); 16 Nov 2006 23:20:08 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, Nov 16, 2006 at 10:49:36PM CET, Junio C Hamano wrote:
> I would like to keep it that way.

I agree - I certainly don't want to infect Git with bash dependency.

> And "POSIX says shell should behave that way" is _not_ what I want to
> hear about.

Actually, which sane platforms we care about have /bin/sh that is NOT
POSIX compatible?

> Things I would want to change:

What about [ instead of test? And

	if foo; then

instead of

	if foo
	then

?


Am I the only one who hates

case "$log_given" in
tt*)
        die "Only one of -c/-C/-F can be used." ;;
*tm*|*mt*)
        die "Option -m cannot be combined with -c/-C/-F." ;;
esac

instead of having this stuff in explicit variables and writing out some
explicit boolean expressions? (There _are_ few cases where the case is
cool, but they are rare.)


It would be really great if Git would have something alike the Cogito's
optparse infrastructure. I'm not sure if you can implement it in Bourne
sh with reasonable performance, though...


I think addressing these three particular points would make the scripts
hugely more coder-friendly. (And well, I usually say that coding style
is not *that* important and is frequently overemphasised. But that holds
only to a certain point. ;-)


> Things I do not want to change:
..snip all those I agree with..
>  - Do not use locals.

It's a pity. :-( Which shell doesn't support them?

It's not that huge a deal, though.

>  - Do not use shell arrays.

This is quite a larger deal, I think; but the portability concerns are
very real, I guess. :|

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
