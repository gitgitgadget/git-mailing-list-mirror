From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use git-update-ref in scripts.
Date: Wed, 28 Sep 2005 10:13:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509281007200.3308@g5.osdl.org>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
 <Pine.LNX.4.58.0509251153090.3308@g5.osdl.org> <7vpsqtykor.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509280819000.3308@g5.osdl.org> <7vek79w2ps.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 28 19:15:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKfUt-0001Fg-31
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 19:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbVI1RNZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 13:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbVI1RNY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 13:13:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39379 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751436AbVI1RNX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2005 13:13:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8SHDI4s020881
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Sep 2005 10:13:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8SHDH3C007460;
	Wed, 28 Sep 2005 10:13:17 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek79w2ps.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9439>



On Wed, 28 Sep 2005, Junio C Hamano wrote:
> 
> Have you had a chance to look at the git-merge change to remove
> the stupid clean-tree requirements?  I have been planning to
> inflict the 'use git-merge instead of git-resolve' change on you
> sometime soonish (like today ;-).

I don't like doing the diff before-hand, but it looked like the default 
was to try just one strategy, and avoid the diff in that case.

Actually, my preference would be to have a unconditional simple case
first. If there's only one possible base, and the trivial merge succeeds
(ie no three-way merges needed at all, just a single git-read-tree), do
that part unconditionally.

That actually matches 90% of all merges I do, and I'd be much happier with 
git-merge if it did that first and if it then does something more complex 
(including diffs etc) afterwards, I'm much less likely to worry.

> Could I have a copy of .git/{branches,remotes,refs}/* from the
> primary repository you do your kernel work please?

Heh. My kernel has none of that. Well, it obviously has refs, but even 
there it literally has just one head: "master". The rest are the standard 
tags you see in public.

So if you clone the public kernel,. you'll actually have a superset of 
what I have, since you'll have the "origin" thing ;)

			Linus
