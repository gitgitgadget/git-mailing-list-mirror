From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: dangling trees
Date: Thu, 5 May 2005 07:41:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505050738150.2328@ppc970.osdl.org>
References: <20050505141224.A8323@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 16:34:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DThQC-0001KI-I4
	for gcvg-git@gmane.org; Thu, 05 May 2005 16:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVEEOkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 10:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVEEOkT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 10:40:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:31455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262110AbVEEOkL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2005 10:40:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j45EdtU3020487
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 May 2005 07:39:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j45Edskd019939;
	Thu, 5 May 2005 07:39:54 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050505141224.A8323@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 5 May 2005, Russell King wrote:
>
> In todays 2.6 git repo, I see the following:
> 
> $ fsck-cache
> expect dangling commits - potential heads - due to lack of head information
> dangling commit 897f5ab2cd733a77a2279268262919caa8154b9d
> dangling tree c39ae07f393806ccf406ef966e9a15afc43cc36a
> 
> The dangling commit is the current head - that's fine.  However,
> what's this dangling tree?

That's the 2.6.11 tree, which I added to have a previous real release to 
diff against.

> It appears to have come in from Linus' tree on kernel.org this morning.

Yes. You can make (my) fsck shut up with something like

	refs=.git/refs/*/*
	git-fsck-cache $refs

but that assumes that cogito has been updated to the newer fsck that 
understands to follow tags (not just parse them, but also add the "tag 
refers to object xxx" info to its internal tree of trust). I don't think 
that has happened yet.

In the meantime, just ignore it. 

		Linus
