From: Paul Mackerras <paulus@samba.org>
Subject: Re: Mozilla SHA1 implementation
Date: Fri, 22 Apr 2005 17:35:40 +1000
Message-ID: <17000.43340.760901.175004@cargo.ozlabs.ibm.com>
References: <87hdi5oet6.dancerj@netfort.gr.jp>
	<Pine.LNX.4.58.0504171039460.7211@ppc970.osdl.org>
	<20050418055824.42d621b8.froese@gmx.de>
	<Pine.LNX.4.58.0504211238150.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Edgar Toernig <froese@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 09:33:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOsem-0006ug-G3
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 09:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVDVHgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 03:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVDVHgy
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 03:36:54 -0400
Received: from ozlabs.org ([203.10.76.45]:57005 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262019AbVDVHf7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 03:35:59 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 5A13467A6C; Fri, 22 Apr 2005 17:35:57 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504211238150.2344@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds writes:

> Interestingly, the Mozilla SHA1 code is about twice as fast as the openssl
> code on my G5, and judging by the disassembly, it's because it's much
> simpler. I think the openssl people have unrolled all the loops totally,
> which tends to be a disaster on any half-way modern CPU. But hey, it could
> be something as simple as optimization flags too.

Which gcc version are you using?

I get the opposite result on my 2GHz G5: the Mozilla version does
45MB/s, the openssl version does 135MB/s, and my version does 218MB/s.
The time for a fsck-cache on a linux-2.6 tree (cache hot) is 8.0
seconds for the Mozilla version, 5.2 seconds for the openssl version,
and 4.4 seconds for my version.

Paul.
