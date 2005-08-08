From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git revert" (Re: pci_update_resource() getting called on sparc64)
Date: Mon, 8 Aug 2005 14:58:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508081444040.3258@g5.osdl.org>
References: <20050808.103304.55507512.davem@davemloft.net>
 <Pine.LNX.4.58.0508081131540.3258@g5.osdl.org> <20050808160846.GA7710@kroah.com>
 <20050808.123209.59463259.davem@davemloft.net> <20050808194249.GA6729@kroah.com>
 <Pine.LNX.4.58.0508081249110.3258@g5.osdl.org> <Pine.LNX.4.58.0508081257190.3258@g5.osdl.org>
 <7vd5oo40mq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508081357020.3258@g5.osdl.org>
 <7voe882kds.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 00:00:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Fdx-0007z3-KH
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 23:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVHHV6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 17:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVHHV6r
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 17:58:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37854 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932281AbVHHV6q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 17:58:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j78LwdjA014317
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 Aug 2005 14:58:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j78LwZcV028916;
	Mon, 8 Aug 2005 14:58:36 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe882kds.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 8 Aug 2005, Junio C Hamano wrote:
> 
>  * git commit does not take commit message from stdin.  I think
>    we should do something like this:

Yes. Alteratively (or additionally), we should add a command line option 
to set the commit message.

CVS uses "-m", but you already took that. I forget what BK used, but I 
think it was "-Y" (with lowercase "-y" being "take message from file". Or 
maybe the other way around).

Or if you want to be more CVS-like, use "-F", and accept "-" for stdin?

But I like "test -t 0" regardless. Very few editors are ok with non-tty
stdin, although I could imagine some disturbed individual having "ed" as
their editor and expecting to be able to pipe commands into it or
something.

		Linus
