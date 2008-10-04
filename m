From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Broken index file - any hope?
Date: Fri, 3 Oct 2008 20:08:48 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810032002240.3208@nehalem.linux-foundation.org>
References: <48E693E9.708@gmx.de> <20081003215319.GX21310@spearce.org> <48E696CB.6040405@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonas Schneider <JonasSchneider@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 04 05:12:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlxZG-0007hT-TI
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 05:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbYJDDIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 23:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbYJDDIz
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 23:08:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39673 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752025AbYJDDIy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Oct 2008 23:08:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9438nLx027861
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Oct 2008 20:08:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9438mgE028747;
	Fri, 3 Oct 2008 20:08:48 -0700
In-Reply-To: <48E696CB.6040405@gmx.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.435 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97463>



On Sat, 4 Oct 2008, Jonas Schneider wrote:

> Shawn O. Pearce schrieb:
> >   git read-tree --reset HEAD
> Sadly, this doesnt help. I still get the same error.
> But, if I remove the corrupt index file, I get this:
> 
> fatal: just how do you expect me to merge 0 trees?

Sounds like you didn't recreate the whole .git directory - not only was 
your index file corrupt, but apparently your .git/HEAD file is too.

The index is just a cache (apart from when you stage things into it 
and/or do merges), and the git read-tree should have recreated it for you. 
The fact that it doesn't work implies that HEAD is corrupt or missing too.

Does "git branch" work for you? And what does .git/HEAD contain (normally 
it would just contain a single line saying "ref: refs/heads/master", but 
it obviously depends on which branch you were on, and it could just be a 
detached head that just points directly to a SHA1).

		Linus
