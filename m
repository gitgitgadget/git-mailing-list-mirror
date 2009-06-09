From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 15:40:35 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906091535410.6847@localhost.localdomain>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>  <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain> <51419b2c0906091530t3dfa5267s2262f979f1e9982a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 00:44:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEA3h-0004LP-1h
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 00:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbZFIWog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 18:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbZFIWof
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 18:44:35 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50350 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750990AbZFIWof (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 18:44:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n59MiXkb002122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2009 15:44:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n59MeZ1K009758;
	Tue, 9 Jun 2009 15:40:35 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <51419b2c0906091530t3dfa5267s2262f979f1e9982a@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.468 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121233>



On Tue, 9 Jun 2009, Elijah Newren wrote:
> 
> Do you object to using 'revert' in the name of the new command or just
> to having the new command take over the exact name 'revert'?

I object to changing existing meaning.

> I'd like to propose making the reverting of edits functionality 
> available under the command name 'revert-edits'

That's fine.

I also don't mind per se having the "git checkout" kind of semantics, 
where different kinds of arguments result in different kinds of behavior. 
I'm not convinced it's a wonderful design, but I would not object to

 - old behavior: revert the commit by creating an "anti-commit":

	git revert <cmit-name>

 - new extension: revert the state of the working tree to the HEAD:

	git revert [--] pathspec

which would kind of match the semantics of "git checkout" does.

So it's not that I object to "git revert" as a name. I just object to 
changing existing (and sane) semantics just for some silly person who 
thinks that git is just "SVN done right". 

Git is _soo_ much more than just that. People need to live with the fact 
that it's not just a SVN clone.

		Linus
