From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH 2/2] GIT: Listen on IPv6 as well, if available.
Date: Fri, 22 Jul 2005 17:35:17 -0400 (EDT)
Organization: USAGI/WIDE Project
Message-ID: <20050722.173517.73563363.yoshfuji@linux-ipv6.org>
References: <20050721.091049.46807257.yoshfuji@linux-ipv6.org>
	<20050722212151.GI11916@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Fri Jul 22 23:39:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw5EA-0008UJ-VC
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 23:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVGVVh6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 17:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVGVVh6
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 17:37:58 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:63492 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S262216AbVGVVe2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 17:34:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id A3C3833D27; Sat, 23 Jul 2005 06:35:17 +0900 (JST)
To: pasky@suse.cz
In-Reply-To: <20050722212151.GI11916@pasky.ji.cz>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In article <20050722212151.GI11916@pasky.ji.cz> (at Fri, 22 Jul 2005 23:21:51 +0200), Petr Baudis <pasky@suse.cz> says:


> this whole getaddrinfo() magic looks horribly complicated. What's wrong
> on just adding a similar code (or factoring it out to a function) for
> IPv6 as there is for IPv4, just s/INET/INET6/?

Because it is the Good Way To Go; protocol independent programming.


> > -				die("accept returned %s", strerror(errno));
> > +		struct sockaddr_storage ss;
> > +		socklen_t sslen = sizeof(ss);
> 
> Perhaps move those to the most inner block. (All right, I'm nitpicking
> too much again, sorry.)
> 

okay.

> > +             if (select(maxfd + 1, &fds, NULL, NULL, NULL) == -1) {
> > +                     /* warning? */
> 
> Certainly a warning and at least sleep(1) to avoid cpuburn-like
> behaviour in case of anything going wrong.

okay...

--yoshfuji
