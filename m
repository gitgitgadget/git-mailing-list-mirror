From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git "tag" objects implemented - and a re-done commit
Date: Mon, 25 Apr 2005 13:42:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251339020.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org>
 <Pine.LNX.4.58.0504251318290.11481@sam.ics.uci.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 22:37:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQAJq-0002Tp-OJ
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 22:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVDYUky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 16:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVDYUky
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 16:40:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:34978 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261187AbVDYUkW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 16:40:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3PKe9s4030014
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 13:40:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3PKe6gG004670;
	Mon, 25 Apr 2005 13:40:08 -0700
To: Andreas Gal <gal@uci.edu>
In-Reply-To: <Pine.LNX.4.58.0504251318290.11481@sam.ics.uci.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005, Andreas Gal wrote:
> 
> Are tag objects referenced by trees (and thus limited in scope) or are 
> they stand-alone entities in the repository? The latter would be bad for 
> shared object storages.

They are totally stand-alone, and I don't see why that would be bad for 
shared object storage.

In fact, the whole point of them is that since they are named by the SHA1 
hash of the content, there are no shared object issues. Two different tags 
by two different developers will have different names, exactly the same 
way two different releases will have different names.

And if two different developers tag exactly the same object with exactly 
the same tag-name and exactly the same signature, then they get the same 
tag object, and that's fine. They should.

> Also, if I delete and recreate tags, will the old tag remain in the tree
> or will the file in the object storage disapear?

Tags in no way affect the entry they name. When you remove - or add - a
tag object, nothing happens to anything else.

		Linus
