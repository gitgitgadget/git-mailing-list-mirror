From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] cg-pull to stop treating "master" specially, fix fetch_local for .git/HEAD
Date: Fri, 11 Nov 2005 02:13:54 +0100
Message-ID: <200511110213.54846.Josef.Weidendorfer@gmx.de>
References: <1124832796.23795.9.camel@dv> <20051110234029.GE30496@pasky.or.cz> <1131668075.3987.5.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 02:16:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaNWO-0005u1-Ao
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 02:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVKKBQA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 20:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVKKBQA
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 20:16:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:2520 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932338AbVKKBP7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 20:15:59 -0500
Received: (qmail invoked by alias); 11 Nov 2005 01:15:58 -0000
Received: from p5496BEC1.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.150.190.193]
  by mail.gmx.net (mp013) with SMTP; 11 Nov 2005 02:15:58 +0100
X-Authenticated: #352111
To: Pavel Roskin <proski@gnu.org>
User-Agent: KMail/1.8.2
In-Reply-To: <1131668075.3987.5.camel@dv>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11548>

On Friday 11 November 2005 01:14, Pavel Roskin wrote:
> On Fri, 2005-11-11 at 00:40 +0100, Petr Baudis wrote: 
> > Dear diary, on Fri, Nov 11, 2005 at 12:26:18AM CET, I got a letter
> > where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> said that...
> > > Why would anybody want to fetch the current upstream HEAD at cg-pull
> > > time?
> ...
> Correct.  But if it's a concern, I think we could make some
> improvements.  Following approaches could be tried (starting from top,
> using following steps as a fallback):
> 
> 1) Use recorded branch, i.e. the branch name that was used in cg-clone.

This is the "#..." part in .git/branches/origin, and it is already used.

I have nothing against using HEAD for cloning, but the branch name should
be recorded, such that cg-pull always fetches from the same branch.

I think 1) is enough if we add the detected branch name in the #... part
in .git/branches/origin at cg-clone time.

And "detectable" covers the local case, which was my concern here [*1*]

Josef

[*1*] after being told about the "stable HEAD" property of public repositories,
which is correct. I am not even sure that a HEAD makes sense
in public repositories: in my opinion HEAD has something to do with checked out
files, and a public repository usually does not have these. But perhaps
that's only me...
