From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: checkout-cache -f: a better way?
Date: Fri, 20 May 2005 19:58:12 -0400
Message-ID: <428E7994.1090402@pobox.com>
References: <428E5102.60003@pobox.com>	<7vacmpsetb.fsf@assigned-by-dhcp.cox.net> <428E73B9.1080907@pobox.com> <7vvf5dqxfq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 01:58:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZHMo-0006KT-6h
	for gcvg-git@gmane.org; Sat, 21 May 2005 01:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVETX6V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 19:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVETX6V
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 19:58:21 -0400
Received: from mail.dvmed.net ([216.237.124.58]:40378 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261597AbVETX6Q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 19:58:16 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DZHNe-0000Lq-6Y; Fri, 20 May 2005 23:58:15 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf5dqxfq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
>>>>>>"JG" == Jeff Garzik <jgarzik@pobox.com> writes:
> 
> 
> JG> git-checkout-cache -f writes out every file, even if it exists, correct?
> 
> No, that's not correct.  To translate my prose, you would want
> this:

Thanks, I stand corrected :)


>     git-read-tree -m HEAD && git-checkout-cache -q -f -u -a
> 
> (notice that I do not have git-update-cache --refresh after
> that).

Yep, thanks.  Script does seem faster now.  Numbers for hot cache (first 
is pre-modification, post is your mod):

[jgarzik@pretzel libata-dev]$ time git-switch-tree adma-mwi

real    0m7.069s
user    0m4.183s
sys     0m2.817s
[jgarzik@pretzel libata-dev]$ time git-switch-tree adma

real    0m0.389s
user    0m0.294s
sys     0m0.094s

