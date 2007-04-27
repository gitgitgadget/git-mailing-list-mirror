From: Christian <crich-ml@beronet.com>
Subject: Re: http push  Lock
Date: Fri, 27 Apr 2007 11:19:22 +0200
Message-ID: <4631C01A.4020808@beronet.com>
References: <4631BD4B.8040507@beronet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 11:20:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhMcr-0006YQ-Al
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 11:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbXD0JUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 05:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755512AbXD0JUW
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 05:20:22 -0400
Received: from beronet.com ([80.244.243.34]:1717 "EHLO mail.beronet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755511AbXD0JUV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 05:20:21 -0400
Received: from mail.beronet.com (localhost [127.0.0.1])
	by mail.beronet.com (Postfix) with ESMTP id 202F7510C2C
	for <git@vger.kernel.org>; Fri, 27 Apr 2007 11:29:20 +0200 (CEST)
Received: from [172.20.5.5] (pd956852e.dip0.t-ipconnect.de [217.86.133.46])
	by mail.beronet.com (Postfix) with ESMTP id D5FBD510C29
	for <git@vger.kernel.org>; Fri, 27 Apr 2007 11:29:19 +0200 (CEST)
User-Agent: Icedove 1.5.0.7 (X11/20061013)
In-Reply-To: <4631BD4B.8040507@beronet.com>
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on m24s12.beronet.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45710>

A simple /etc/init.d/apache restart did the job.



Christian wrote:
> Hi ,
>
>
> after another git-http-push segfault i have a funny lock in the 
> central repository left, that was not released unfortunately, my 
> apache  error log says something like:
>
>
> [Fri Apr 27 11:11:08 2007] [error] [client 217.86.133.46] Could not 
> LOCK /git/mISDN.git/info/refs due to a failed precondition (e.g. other 
> locks).  [423, #0]
> [Fri Apr 27 11:11:08 2007] [error] [client 217.86.133.46] Existing 
> lock(s) on the requested resource prevent an exclusive lock.  [423, #0]
> [Fri Apr 27 11:11:17 2007] [error] [client 217.86.133.46] Could not 
> LOCK /git/mISDN.git/refs/heads/master due to a failed precondition 
> (e.g. other locks).  [423, #0]
> [Fri Apr 27 11:11:17 2007] [error] [client 217.86.133.46] Existing 
> lock(s) on the requested resource prevent an exclusive lock.  [423, #0]
>
>
>
> how can i resolve this locked situation? pushes are currently not 
> possible anymore...
>
>
>
>
> The segfault is the same like last time i think:
>
>
> Loaded symbols for /lib/tls/libnss_dns.so.2
> #0  decode_tree_entry (desc=0xbfaed7bc, buf=0x0, size=503) at 
> tree-walk.c:10
> 10              while ((c = *str++) != ' ') {
> (gdb) bt
> #0  decode_tree_entry (desc=0xbfaed7bc, buf=0x0, size=503) at 
> tree-walk.c:10
> #1  0x0804b9a8 in mark_tree_uninteresting (tree=0x80d0240) at 
> revision.c:65
> #2  0x080534cd in main (argc=2, argv=Cannot access memory at address 
> 0x1fb
> ) at http-push.c:1998
> (gdb)
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
