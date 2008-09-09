From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 9 Sep 2008 16:35:52 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 01:37:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdClr-0005dq-A3
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 01:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbYIIXgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 19:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbYIIXgH
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 19:36:07 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59488 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752044AbYIIXgE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Sep 2008 19:36:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m89NZqFs003903
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Sep 2008 16:35:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m89NZqRI009271;
	Tue, 9 Sep 2008 16:35:52 -0700
In-Reply-To: <20080909194354.GA13634@cuci.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.937 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95463>



On Tue, 9 Sep 2008, Stephen R. van den Berg wrote:

> Jakub Narebski wrote:
> >"Stephen R. van den Berg" <srb@cuci.nl> writes:
> >> The definition of the origin field reads as follows:
> 
> >> - There can be an arbitrary number of origin fields per commit.
> >>   Typically there is going to be at most one origin field per commit.
> 
> >I understand that multiple origin fields occur if you do a squash
> >merge, or if you cherry-pick multiple commits into single commit.
> >For example:
> > $ git cherry-pick -n <a1>
> > $ git cherry-pick    <a2>
> > $ git commit --amend        #; to correct commit message
> 
> Correct.

Quite frankly, recording the origins for _any_ of the above sounds like a 
horribly mistake.

All those operations are commonly used (along with "git rebase -i") to 
clean up history in order to show a nicer version.

The whole point of "origin" seems to be to _destroy_ that.

I would refuse to ever touch anything that had an "origin" pointer, so if 
git were to add that feature, it would be a huge disappointment to me. I'd 
have to have a version that makes sure that anything it pulls hasn't been 
crapped on by somebody who added a stupid link to some dirty history that 
I'm not at all interested in seeing.

IOW, I'm seeing a _lot_ of downsides, and not any actual upsides. What are 
the upsides again? 

			Linus
