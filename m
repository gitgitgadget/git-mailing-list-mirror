From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Sun, 15 May 2005 04:52:50 -0700
Message-ID: <200505151152.j4FBqoW01239@adam.yggdrasil.com>
Cc: git@vger.kernel.org, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, mercurial@selenic.com,
	mpm@selenic.com, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun May 15 15:04:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXImV-0007PY-Oe
	for gcvg-git@gmane.org; Sun, 15 May 2005 15:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVEONDw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 09:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVEONDw
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 09:03:52 -0400
Received: from [61.48.53.251] ([61.48.53.251]:31719 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261165AbVEONDs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 09:03:48 -0400
Received: (from adam@localhost)
	by adam.yggdrasil.com (8.11.7/8.11.7) id j4FBqoW01239;
	Sun, 15 May 2005 04:52:50 -0700
To: pasky@ucw.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 15 May 2005 14:40:42 +0200, Petr Baudis wrote:
>Dear diary, on Sun, May 15, 2005 at 01:22:19PM CEST, I got a letter
>where "Adam J. Richter" <adam@yggdrasil.com> told me that...
[...]
>> 	I don't understand what was wrong with Jeff Garzik's previous
>> suggestion of using http/1.1 pipelining to coalesce the round trips.
>> If you're worried about queuing too many http/1.1 requests, the client
>> could adopt a policy of not having more than a certain number of
>> requests outstanding or perhaps even making a new http connection
>> after a certain number of requests to avoid starving other clients
>> when the number of clients doing one of these transfers exceeds the
>> number of threads that the http server uses.

>The problem is that to fetch a revision tree, you have to

>	send request for commit A
>	receive commit A
>	look at commit A for list of its parents
>	send request for the parents
>	receive the parents
>	look inside for list of its parents
>	...

>(and same for the trees).

	Don't you usually have a list of many files for which you
want to retrieve this information?  I'd imagine that would usually
suffice to fill the pipeline.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
