From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Git rebase failure: .dotest overwritten
Date: Tue, 15 Jul 2008 23:22:11 +0200
Message-ID: <20080715212211.GL6244@leksak.fem-net>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Fiorini <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 23:23:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIrzS-0001hs-HY
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 23:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbYGOVWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 17:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbYGOVWS
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 17:22:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:57408 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751935AbYGOVWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 17:22:17 -0400
Received: (qmail invoked by alias); 15 Jul 2008 21:22:14 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp013) with SMTP; 15 Jul 2008 23:22:14 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/Sbt4kHW3SBryjFD3ycZpUgMb+PFFW+d8mx414ZW
	V/WCJ9T9X9hCYQ
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KIryN-0007Uw-Tb; Tue, 15 Jul 2008 23:22:11 +0200
Content-Disposition: inline
In-Reply-To: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88597>

Hi,

Joe Fiorini wrote:
> A friend of mine asked me for help with a git rebase problem.  I was
> clueless.  Here is what he was seeing:
> The main problem seems to be the following error: "fatal: Untracked
> working tree file '.dotest/0001' would be overwritten by merge."; also
> all the files that it says "already exist in working directory" did
> not exist before he ran the rebase.  Maybe it's trying to run the
> rebase more than once? His working copy was clean.  Any thoughts?  Any
> other details I can provide?

git-rebase (without -i/-m) generates a directory called ".dotest/" to
save temporary stuff like the commits you want to rebase.

And it seems that at least one commit in his repo has .dotest/* files
in the tree, so that message occurs.
Hmm, he should perhaps clean that commit up and remove the .dotest
files from it. (After figuring out that commit, he could try
	git rebase -i ...
and change the "pick" line to "edit".)

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
