From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 17:05:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511181653191.13959@g5.osdl.org>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr>
 <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr>
 <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <20051118205513.GA3168@vrfy.org>
 <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org> <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
 <437E51EB.7050100@zytor.com> <Pine.LNX.4.64.0511181520390.13959@g5.osdl.org>
 <7vek5deam6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 02:06:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdHAX-0001Bk-9Q
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 02:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVKSBF0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 20:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVKSBF0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 20:05:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9440 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932140AbVKSBF0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 20:05:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAJ15GnO008665
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 17:05:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAJ15BBf011315;
	Fri, 18 Nov 2005 17:05:15 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek5deam6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12313>



On Fri, 18 Nov 2005, Junio C Hamano wrote:
> 
> Pulls are "too late, sorry you have to live with it"; for
> patches, mailinfo and am have -u (I do not remember if I added
> it to applymbox -- I do not use applymbox anymore myself).

It's in applymbox too, although the default is not to use it (and 
applymbox only supports the short "-u" form, not the "--utf8" one).

> Maybe we should make -u the default and countermand with -U to
> encourage the use of utf8 further?

Probably. 

Although right now "-u" doesn't actually _force_ a conversion: if you have 
an email with 8-bit characters and no character set mentioned, it will 
silently just do nothing, and the end result won't be valid UTF-8 after 
all.

I think. You're the one who wrote all the conversion stuff ;)

If we want utf-8, we should probably force it, and default to the latin1 
translation (with some way to specify alternatives).

			Linus
