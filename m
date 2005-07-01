From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: emit base before delta.
Date: Fri, 01 Jul 2005 08:40:12 -0700
Message-ID: <7v1x6iilgj.fsf@assigned-by-dhcp.cox.net>
References: <7vbr5nxe38.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507010821140.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 17:34:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoNVg-0003eZ-SD
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 17:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbVGAPkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 11:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbVGAPkR
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 11:40:17 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:27520 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S263372AbVGAPkO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 11:40:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050701154013.YPAX8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 1 Jul 2005 11:40:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507010821140.14331@ppc970.osdl.org> (Linus Torvalds's message of "Fri, 1 Jul 2005 08:28:07 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> So I like this from an unpacking standpoint, but at the same
LT> time I don't actually think it's correct from an access
LT> pattern standpoint.

My faulty logic, when I did the patch, was "we would jump around
on random access anyway, so forcing the runtime to go backwards
even when we know that these 40 objects are followed in this
exact order to resolve delta is also OK."  It is not.

Please drop the patch.
