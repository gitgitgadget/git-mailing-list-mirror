From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Mon, 27 Jun 2005 19:13:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506271910390.19755@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
 <7vwtofi6jk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 04:04:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn5Sh-0006bb-Q0
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 04:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVF1CLZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 22:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVF1CLZ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 22:11:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5343 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262240AbVF1CLP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 22:11:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5S2B5jA004493
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Jun 2005 19:11:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5S2B2Ce006292;
	Mon, 27 Jun 2005 19:11:04 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtofi6jk.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.667 required=5 tests=MANY_EXCLAMATIONS
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 27 Jun 2005, Junio C Hamano wrote:
> 
> LT> ... Also, please note that the pack-file _only_ packs the commits
> LT> and the things reachable from them ...
> 
> Shouldn't feeding "git-rev-list --object" output plus
> handcrafted list of objects in 2.6.11 tree object to
> git-pack-objects just work???

You could do that. And yes, we can add support for "tag" objects too 
(which the packing doesn't do at all right now. So this is not a 
"fundamental" problem, it's just a practical one right now.

> > [..  git-ssh-pull hopefully working ..]
>
> No.  The pull protocol Dan did expects to throw compressed
> representation around on the wire (which is valid if you assume
> uncompressed transfer) and does not use read-sha1-file --
> write-sha1-file pair, so all three do not work.

Fair enough. I'd prefer for the pull/push to push object packs around 
anyway, so there's some more work there..

		Linus
