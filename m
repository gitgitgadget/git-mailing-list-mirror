From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Sun, 01 May 2005 22:07:31 +1000
Organization: Core
Message-ID: <E1DSDER-0000kS-00@gondolin.me.apana.org.au>
References: <20050428202739.GE30308@mythryan2.michonline.com>
Cc: torvalds@osdl.org, rene.scharfe@lsrfire.ath.cx,
	git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Sun May 01 14:03:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSD9a-0003u6-C0
	for gcvg-git@gmane.org; Sun, 01 May 2005 14:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVEAMIQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 08:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVEAMIQ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 08:08:16 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:783 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261602AbVEAMIM
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 1 May 2005 08:08:12 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.35 #1 (Debian))
	id 1DSDEY-0006Ar-00; Sun, 01 May 2005 22:07:38 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1DSDER-0000kS-00; Sun, 01 May 2005 22:07:31 +1000
To: ryan@michonline.com (Ryan Anderson)
In-Reply-To: <20050428202739.GE30308@mythryan2.michonline.com>
X-Newsgroups: apana.lists.os.linux.git
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> wrote:
> On Thu, Apr 28, 2005 at 12:21:26PM -0700, Linus Torvalds wrote:
> 
>> Defining "DONT_REPORT_SIGPIPE" in config-top.h when building bash gets rid 
>> of it, but I really don't want to rebuild bash just because of this ;)
> 
> Debian's bash seems to have that set, so it's a bit hard for me to test

This issue has been around for years.  The discussion that led to
Debian setting this option may be helpful in understanding it:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=10494

A brief time line:

11 Jun 1997 The issue was reported to Debian.
20 Nov 1999 Chet Ramey remarks that bash's default will not change.
 4 Sep 2004 Debian sets DONT_REPORT_SIGPIPE.

Chet Ramey claims that setting DONT_REPORT_SIGPIPE by default
would make bash incompatible with every other shell out there.
Interestingly, all the non-bash shells that I've tried disagree
with him.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
