From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: checkout-cache -f: a better way?
Date: Fri, 20 May 2005 19:33:13 -0400
Message-ID: <428E73B9.1080907@pobox.com>
References: <428E5102.60003@pobox.com> <7vacmpsetb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 01:33:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZGyc-0004RT-DH
	for gcvg-git@gmane.org; Sat, 21 May 2005 01:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVETXdW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 19:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVETXdW
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 19:33:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:26554 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261467AbVETXdQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 19:33:16 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DZGzT-0000Km-Cp; Fri, 20 May 2005 23:33:15 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacmpsetb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
>>>>>>"JG" == Jeff Garzik <jgarzik@pobox.com> writes:
> 
> 
> JG> Being a weirdo, I don't use cogito for kernel development, just git
> JG> itself.
> 
> My customer, in other words ;-).
> 
> JG> git-read-tree $(cat .git/HEAD) && \
> JG> 	git-checkout-cache -q -f -a && \
> JG> 	git-update-cache --refresh
> 
> I have to check checkout-cache.c, but assuming that you start
> from an already populated work tree with a valid cache when you
> do the git-read-tree at the third line from the last, using
> "git-read-tree -m HEAD" (you do not need to say $(cat .git/HEAD)
> in the modern git anymore) would be a good place to start.
> 
> Also the modern git-checkout-cache has a '-u' option and with it
> you should not need 'git-update-cache --refresh' after that.
> 
> Let me know if you have any problems.  Single tree '-m' is what
> Linus did and '-u' option to git-checkout-cache is mine.

Pardon my ignorance (I'm slow :)), but how do those changes address the 
fact that git-checkout-cache appears to checkout the entire kernel tree 
(over 100MB of writes) when using '-f' ?

git-checkout-cache -f writes out every file, even if it exists, correct?

	Jeff


