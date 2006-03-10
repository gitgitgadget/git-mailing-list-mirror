From: Mike McCormack <mike@codeweavers.com>
Subject: Re: [PATCH] Add git-imap-send.
Date: Fri, 10 Mar 2006 13:58:10 +0900
Organization: CodeWeavers
Message-ID: <44110762.106@codeweavers.com>
References: <440C3499.9080000@codeweavers.com> <7vacbz7vod.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 06:02:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHZls-0004Oi-I5
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 06:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWCJFCd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 00:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWCJFCd
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 00:02:33 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:56521 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751499AbWCJFCd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 00:02:33 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1FHZll-0004p3-63; Thu, 09 Mar 2006 23:02:32 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacbz7vod.fsf@assigned-by-dhcp.cox.net>
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17452>


Junio C Hamano wrote:

>>[imap]
>>	Host = imap.server.com
>>	User = bob
>>	Password = pwd
>>	Port = 143
> 
> These I am not so sure.  It _might_ make sense to have something
> like this under $HOME/.  Isn't there an established convention
> for storing something like this for existing MUAs?

It seems better to keep all the configuration in the same place.  It's 
possible (although unlikely) that somebody uses two different IMAP 
servers to send mail... maybe one for work and one for play?

I think it would also be good to be able to specify these as command 
line options, as some people might be uncomfortable with having their 
password in a file (though it would be better to use an ssh tunnel).

>>+ * As a special exception, mbsync may be linked with the OpenSSL library,
>>+ * despite that library's more restrictive license.

> Hmmm.

I'll remove this, and all the SSL specific code, as it also complicates 
the Makefile and adds an extra dependency.

I've fixed all the other issues you pointed out, and will resend the patch.

Mike
