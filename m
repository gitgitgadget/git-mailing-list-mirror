From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Fix use of wc in t0000-basic
Date: Sat, 21 May 2005 20:37:56 +1000
Organization: Core
Message-ID: <E1DZRMi-00021X-00@gondolin.me.apana.org.au>
References: <Pine.LNX.4.21.0505202045580.30848-100000@iabervon.org>
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 12:37:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZRME-0008T5-S8
	for gcvg-git@gmane.org; Sat, 21 May 2005 12:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVEUKi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 06:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVEUKi2
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 06:38:28 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:43532 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261725AbVEUKi0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 06:38:26 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.35 #1 (Debian))
	id 1DZRMl-0004g9-00; Sat, 21 May 2005 20:37:59 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1DZRMi-00021X-00; Sat, 21 May 2005 20:37:56 +1000
To: barkalow@iabervon.org (Daniel Barkalow)
In-Reply-To: <Pine.LNX.4.21.0505202045580.30848-100000@iabervon.org>
X-Newsgroups: apana.lists.os.linux.git
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> wrote:
>
> -    'test "$(wc -l full-of-directories | sed -e "s/ .*//")" = 257'
> +    'test $(cat full-of-directories | wc -l) = 257'

You don't need the cat:

wc -l < full-of-directories

will do the same thing.

It's also better to use -eq instead of = since you are comparing
numbers, not strings.  If you do that you can keep the double
quotes since the spaces will be removed automatically.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
