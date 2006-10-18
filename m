From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 23:09:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610172242430.17253@alien.or.mcafeemobile.com>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home> <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home> <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home> <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home> <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home> <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171959070.1971@xanadu.home> <Pine.LNX.4.64.0610171754040.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610172140270.1971@xanadu.home> <Pine.LNX.4.64.0610171959180.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Sergey Vlasov <vsu@altlinux.ru>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 08:11:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga4co-0004QA-6x
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 08:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWJRGJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 02:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWJRGJz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 02:09:55 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:26086 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751081AbWJRGJy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 02:09:54 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F58CF> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Tue, 17 Oct 2006 23:09:50 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610171959180.3962@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29193>

On Tue, 17 Oct 2006, Linus Torvalds wrote:

> > Does this mean that, with your own change to xdiff that has just been 
> > committed, you actually created a "problem"?  Because this is a change 
> > that creates different behaviors whether a 32-bit or 64-bit architecture 
> > is used, Right?
> 
> If you go back to that discussion, I actually pointed out several times 
> that the whole bug _was_ actually introduced exactly because the xdiff 
> code used things that behave differently depending on word-size.

Ehm, I think there's a little bit of confusion. The incorrect golden ratio 
prime selection for 64 bits machines was coalescing hash indexes into a 
very limited number of buckets, hence creating very bad performance on diff 
operations. The result of the diff would have been exacly the same, just 
coming out after the time for a cup of coffee and a croissant ;)


> So the bug in xdiff was _exactly_ that somebody - totally incorrectly - 
> thought it should work "better" on 64-bits. 

Haha, not exactly. I had just forgot about the incoming 64 bits world at 
the time.



- Davide
