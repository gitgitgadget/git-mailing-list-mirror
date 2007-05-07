From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Mon, 7 May 2007 18:23:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705071616310.18541@iabervon.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
 <8b65902a0705070440t40889af0p1fb8dbf7e2a072e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 00:23:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlBc7-0006RU-2o
	for gcvg-git@gmane.org; Tue, 08 May 2007 00:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966672AbXEGWXW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 18:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966682AbXEGWXW
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 18:23:22 -0400
Received: from iabervon.org ([66.92.72.58]:2686 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966672AbXEGWXV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 18:23:21 -0400
Received: (qmail 2098 invoked by uid 1000); 7 May 2007 22:23:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 May 2007 22:23:20 -0000
In-Reply-To: <8b65902a0705070440t40889af0p1fb8dbf7e2a072e4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46497>

On Mon, 7 May 2007, Guilhem Bonnefille wrote:

> Hi,
> 
> As a newbie, I'm agree with Matthieu: the Git's index is surprising
> for people coming from CVS/SVN (mindless?) world. So a good
> documentation about this, even in tutorials, is really important.

I think that the confusing thing isn't really the index, but the fact that 
git, by default, will make commits where the content in the commit is 
different from the content in the working directory. (In fact, you can use 
git-hash-object --stdin and git-update-index --cacheinfo to do a commit 
which shares no content at all with any present or past state of the 
working directory!)

In other version control systems, you have to use some option or argument 
to make that kind of non-matching commit (and you're generally limited in 
how your commits can fail to match the working directory). I think the 
confusion is that git requires an option to say that you want the commit 
to match the working directory, as opposed to creating a non-matching 
commit, which is generally the more advanced and more unusual case.

I think this is why people mostly get to understand the index by way of 
using it to resolve a conflicted merge: in that case, you have to make the 
index match the working directory before committing, and the index tracks 
your progress in reaching this state, which is the intuitive use of the 
index in normal situations.

	-Daniel
*This .sig left intentionally blank*
