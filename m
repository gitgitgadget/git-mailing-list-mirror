From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] Add some functions for commit lists
Date: Sat, 23 Apr 2005 19:20:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231916300.2344@ppc970.osdl.org>
References: <Pine.LNX.4.21.0504232003490.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0504231906110.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 04:14:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPWdV-0007EH-6j
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 04:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVDXCTD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 22:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVDXCTD
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 22:19:03 -0400
Received: from fire.osdl.org ([65.172.181.4]:19841 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262231AbVDXCTB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 22:19:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3O2Ius4025894
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 19:18:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3O2Itt8026017;
	Sat, 23 Apr 2005 19:18:55 -0700
To: Daniel Barkalow <barkalow@iabervon.org>, Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.58.0504231906110.2344@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, Linus Torvalds wrote:
> 
> Ok. This is more in like with what I was hoping for, looks good.

Oh, Daniel, I notice that you have the same old bug: it will happily add 
the same parent to the list several times. You need to prune them out, and 
ignore things you've seen.

I pushed out the fix (don't parse and add parents to the list that were 
already parsed).

		Linus
