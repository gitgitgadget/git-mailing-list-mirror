From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach applymbox to keep the Subject: line.
Date: Wed, 17 Aug 2005 13:42:57 -0700
Message-ID: <7vfyt8thv2.fsf@assigned-by-dhcp.cox.net>
References: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com>
	<7vek8t7bva.fsf@assigned-by-dhcp.cox.net>
	<7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net>
	<430375B3.3050307@pobox.com>
	<Pine.LNX.4.58.0508171253190.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 22:43:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5UkY-00031y-37
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 22:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVHQUm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 16:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVHQUm7
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 16:42:59 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:18367 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751238AbVHQUm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 16:42:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817204257.OWED8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 16:42:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> The fact is, anybody who doesn't edit the emails that come in is BROKEN. 
> There are two kinds of emails:
>
>  - the nicely formatted ones where the author follows all the rules
>
>    This kind of email doesn't need MIME decoding anyway.

That depends on what the rules are, but I consider detecting B
encodings in the header fields and transliterating it into UTF-8
a good idea (although that sometimes is a lossy conversion
depending on the original charset).

Remember this one that prompted me to do the header folding?

    From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
            <yoshfuji@linux-ipv6.org>

>  - the others

>    ..., trying to handle it 
>    automatically is WRONG WRONG WRONG.
>    And if it's mime-encoded you often have trouble editing it anyway.
>
> Ergo: if somebody sends you mime-encoded patches, hit them with a baseball 
> bat (politely) and teach them not to do that. "Fixing" the tools really 
> will just make things worse if it means that you apply raw emails without 
> having edited them.

I agree with you in principle and that is why I always run
applymbox with the -q flag.  Maybe I should start trying the
baseball bat approach to see what happens.
