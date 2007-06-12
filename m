From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/3] Support config-based names
Date: Tue, 12 Jun 2007 01:56:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706120131010.5848@iabervon.org>
References: <Pine.LNX.4.64.0706112244210.5848@iabervon.org>
 <7vbqfln3mf.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 07:56:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxzMi-0002vj-DG
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 07:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbXFLF4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 01:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbXFLF4S
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 01:56:18 -0400
Received: from iabervon.org ([66.92.72.58]:2623 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbXFLF4R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 01:56:17 -0400
Received: (qmail 3715 invoked by uid 1000); 12 Jun 2007 05:56:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jun 2007 05:56:16 -0000
In-Reply-To: <7vbqfln3mf.fsf@assigned-by-dhcp.pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49923>

On Mon, 11 Jun 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > It can be useful to refer to commits in remotes based on their configured 
> > relationship to local branches. For example, "git log HEAD^[push]..HEAD" 
> > would, when pushing is set up, show what hasn't been pushed yet.
> 
> It's not like we will be adding 'push' objects and 'merge'
> objects, so I think HEAD^{push} (curly brace, not bracket) is
> good enough.

What I'm worried about is whether we'll eventually want some sort of 
function and an object with the same name, and then have to have a syntax 
problem with legacy functions being confusing.

> We need to see how useful this would be in practice; we would
> not want to add new syntax without a set of convincing use
> cases.  At this point, it still feels as if it is a feature that
> was implemented only because it could, not because there was a
> real need.

I'd be a lot more reliable at using git if git-commit reported "git log 
--pretty=oneline HEAD^{push}..HEAD" after each commit (if there is a 
HEAD^{push}). I'm forever committing things and forgetting to push them 
when I mean to. My original series actually ended with adding something to 
git-commit.sh, but I decided I didn't like the implementation of that 
actual patch.

I didn't have a particular need for ^{merge}, but I accidentally wrote it 
first because I was confused as to what I wanted. I think "git diff 
HEAD^{merge}" might be good for finding out what work you've done that 
hasn't gotten in yet.

Of course, for particular cases, it's just as easy to type the actual 
tracking branch name on the command line, but ^{push} and ^{merge} can be 
used genericly in scripts, because the same common or pattern works for 
any branch.

	-Daniel
*This .sig left intentionally blank*
