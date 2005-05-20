From: Junio C Hamano <junkio@cox.net>
Subject: Re: checkout-cache -f: a better way?
Date: Fri, 20 May 2005 15:38:56 -0700
Message-ID: <7vacmpsetb.fsf@assigned-by-dhcp.cox.net>
References: <428E5102.60003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 00:39:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZG8C-0008TV-VG
	for gcvg-git@gmane.org; Sat, 21 May 2005 00:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVETWjC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 18:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVETWjC
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 18:39:02 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:43225 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261427AbVETWi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 18:38:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050520223857.TFZW22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 May 2005 18:38:57 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <428E5102.60003@pobox.com> (Jeff Garzik's message of "Fri, 20
 May 2005 17:05:06 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JG" == Jeff Garzik <jgarzik@pobox.com> writes:

JG> Being a weirdo, I don't use cogito for kernel development, just git
JG> itself.

My customer, in other words ;-).

JG> git-read-tree $(cat .git/HEAD) && \
JG> 	git-checkout-cache -q -f -a && \
JG> 	git-update-cache --refresh

I have to check checkout-cache.c, but assuming that you start
from an already populated work tree with a valid cache when you
do the git-read-tree at the third line from the last, using
"git-read-tree -m HEAD" (you do not need to say $(cat .git/HEAD)
in the modern git anymore) would be a good place to start.

Also the modern git-checkout-cache has a '-u' option and with it
you should not need 'git-update-cache --refresh' after that.

Let me know if you have any problems.  Single tree '-m' is what
Linus did and '-u' option to git-checkout-cache is mine.



