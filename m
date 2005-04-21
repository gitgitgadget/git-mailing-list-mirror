From: Edgar Toernig <froese@gmx.de>
Subject: Re: Mozilla SHA1 implementation
Date: Fri, 22 Apr 2005 00:59:28 +0200
Message-ID: <20050422005928.218a753a.froese@gmx.de>
References: <87hdi5oet6.dancerj@netfort.gr.jp>
	<Pine.LNX.4.58.0504171039460.7211@ppc970.osdl.org>
	<20050418055824.42d621b8.froese@gmx.de>
	<Pine.LNX.4.58.0504211238150.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 00:56:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOkZz-0002ZP-K2
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 00:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVDUW7u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 18:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVDUW7t
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 18:59:49 -0400
Received: from mail.gmx.de ([213.165.64.20]:21177 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261568AbVDUW7b (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 18:59:31 -0400
Received: (qmail invoked by alias); 21 Apr 2005 22:59:30 -0000
Received: from p50907452.dip.t-dialin.net (EHLO dialup) [80.144.116.82]
  by mail.gmx.net (mp004) with SMTP; 22 Apr 2005 00:59:30 +0200
X-Authenticated: #271361
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504211238150.2344@ppc970.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
>
> I've just integrated the Mozilla SHA1 library implementation into the
> standard git archive

Thanks.

In the mood for another compatibility hack?  My zlib doesn't have
deflateBound and browsing through the git-ml archive it seems I'm
not the only one.  How about putting this snippet into some header
file?

#if ZLIB_VERNUM < 0x1200
#define deflateBound(c,s) ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
#endif

The formula is the conservative upper bound from zlib-1.2.2.

Ciao, ET.
