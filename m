From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: git bug?
Date: Thu, 09 Jun 2005 04:01:45 -0400
Message-ID: <42A7F769.2050800@pobox.com>
References: <42A7E7AD.5030108@pobox.com>	<7vy89kq96o.fsf@assigned-by-dhcp.cox.net> <7vzmu0otg8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 12:14:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgHv8-0004hC-7o
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 09:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVFIIBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 04:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVFIIBv
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 04:01:51 -0400
Received: from mail.dvmed.net ([216.237.124.58]:65492 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262318AbVFIIBt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 04:01:49 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DgHz2-0004bG-Ba; Thu, 09 Jun 2005 08:01:48 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmu0otg8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jeff, I assume you are talking about this part:
> 
> 
>>>diff --git a/arch/arm/mm/minicache.c b/arch/arm/mm/minicache.c
>>>deleted file mode 100644
>>>diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> 
> 
> that does not have anything between "deleted file..." and the
> next diff about libata-core.c.
> 
> In short, this is not really a "bug", but I am open to
> suggestions for improvements (but you need to talk Linus into
> accepting the changes, because changing this would also affect
> his "git-apply" program as well).

It's a bug and a new behavior.

'git-diff-cache -p HEAD' should not show files that I have not modified.

This screws up
	git-diff-cache -p HEAD | diffstat -p1 | awk '{print $1}'
for example.

	Jeff


