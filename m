From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 08:39:20 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org>
 <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 17:41:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdoI8-0005jb-EZ
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 17:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbYIKPjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 11:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbYIKPjv
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 11:39:51 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47659 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752481AbYIKPjv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2008 11:39:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8BFdL9D005999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Sep 2008 08:39:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8BFdKjI003386;
	Thu, 11 Sep 2008 08:39:20 -0700
In-Reply-To: <20080911062242.GA23070@cuci.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.937 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95615>



On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:
> 
> >delete of the origin branch will basically make them unreachable.
> 
> False.

Stephen, here's a f*cking clue:

 - I know how git works.

> If you fetch just branches A, B and C, but not D, the origin link from A
> to D is dangling.  Once you have fetched D as well [..]

So I just said we deleted beanch 'D', so there's no way to ever fetch it 
again.

Get it?

The fact is, a big part of git is temporary branches. It's one of the 
*best* features of git. Throw-away stuff. Those throw-away branches are 
often done for initial development, and then the final result is often a 
cleaned-up version. Often using rebase or cherry-picking or any number of 
things.

And this is why "git cherry-pick" DOES NOT PUT THE ORIGINAL SHA1 IN THE 
COMMENT FIELD BY DEFAULT.

(Although you can use "-x" to make it do so for when you actually _want_ 
to say "cherry-picked from xyzzy")

Can you not understand that? The "origin" field is _garbage_. It's garbage 
for all normal cases. The original commit will not ever even EXIST in the 
result, because it has long since been thrown away and will never exist 
anywhere else.

Garbage should be _avoided_, not added.

			Linus
