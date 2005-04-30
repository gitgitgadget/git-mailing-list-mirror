From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] GIT: Create tar archives of tree on the fly
Date: Sat, 30 Apr 2005 02:13:02 +0200
Message-ID: <4272CD8E.8040706@lsrfire.ath.cx>
References: <20050426144222.GA12035@lsrfire.ath.cx> <Pine.LNX.4.58.0504291522250.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 02:08:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRfWE-0002rL-QW
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 02:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbVD3ANL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 20:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbVD3ANL
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 20:13:11 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:30623 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S263077AbVD3ANI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 20:13:08 -0400
Received: from [10.0.1.3] (p508E539A.dip.t-dialin.net [80.142.83.154])
	by neapel230.server4you.de (Postfix) with ESMTP id 927C32F7;
	Sat, 30 Apr 2005 02:13:06 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504291522250.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds schrieb:
> 
> Having just done the git-0.7.tar.gz file with git-tar-tree, I started
>  wondering if there is some nice way to encode the commit version
> that got tarred up into the tar archive itself.

The pax archive format allows for comments; you can store the commit ID
in a (archive-)global comment.  Archivers are supposed to ignore it and
GNU tar at least does so.  You can extract the ID with

   $ dd bs=1 skip=523 count=41 2>/dev/null < TARFILE

because it would always end up at that position at the start of the archive.

Rene
