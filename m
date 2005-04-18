From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: fix mktemp (remove mktemp ;)
Date: Mon, 18 Apr 2005 13:01:07 +1000
Organization: Core
Message-ID: <E1DNMVX-00013d-00@gondolin.me.apana.org.au>
References: <20050416170221.38b3e66c.pj@sgi.com>
Cc: pasky@ucw.cz, git@vger.kernel.org, mj@ucw.cz
X-From: git-owner@vger.kernel.org Mon Apr 18 04:57:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNMSR-0003wS-2p
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVDRDBs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 23:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVDRDBs
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 23:01:48 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:54030 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261626AbVDRDBr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 23:01:47 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.35 #1 (Debian))
	id 1DNMVt-0000CT-00; Mon, 18 Apr 2005 13:01:29 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1DNMVX-00013d-00; Mon, 18 Apr 2005 13:01:07 +1000
To: pj@sgi.com (Paul Jackson)
In-Reply-To: <20050416170221.38b3e66c.pj@sgi.com>
X-Newsgroups: apana.lists.os.linux.git
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
> 
> Even mktemp(1) can collide, in theory, since there is no practical way
> in shell scripts to hold open and locked the file from the instant of it
> is determined to be a unique name.

mktemp(1) creates the file before exiting.  Other instances of mktemp(1)
cannot successfully create the same file (they all use O_EXCL).
Therefore this race does not exist, even in theory :)
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
