From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Question on GIT usage.
Date: Mon, 31 Oct 2005 18:37:48 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0510311821410.25300@iabervon.org>
References: <4362C700.6020901@candelatech.com> <Pine.LNX.4.64.0510311749080.25300@iabervon.org>
 <Pine.LNX.4.64.0510311520190.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ben Greear <greearb@candelatech.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 00:38:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWjED-0000P4-3w
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 00:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVJaXiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 18:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVJaXiK
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 18:38:10 -0500
Received: from iabervon.org ([66.92.72.58]:39686 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964782AbVJaXiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 18:38:09 -0500
Received: (qmail 23432 invoked by uid 1000); 31 Oct 2005 18:37:48 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Oct 2005 18:37:48 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510311520190.27915@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10899>

On Mon, 31 Oct 2005, Linus Torvalds wrote:

> On Mon, 31 Oct 2005, Daniel Barkalow wrote:
> > 
> > The system will be unhappy if you commit to a branch that is checked out 
> > elsewhere (because the head of that branch will change out from under the 
> > checked out version), like having someone push to a repository with the 
> > branch checked out.
> 
> Well, the good news is that a "git checkout -f" in the other trees will do 
> the right thing (and only check out the files that have changed).
> 
> The bad news is that you need to remember to do that ;)

If we wanted to make this work reliably, we could have a 
"LAST_CHECKED_OUT" which has an actual hash (rather than being a link like 
HEAD is), and gets set by the checkout. Then it would always know what 
commit you have checked out, even if something causes HEAD to not match.

I personally just never have the same branch checked out twice, so the 
situation doesn't happen to me. It's easy enough to add additional 
branches.

Oh, that reminds me: is there a simple way to merge a branch with another 
local branch or remote branch that's already up-to-date? E.g., I've 
already fetched the latest git from kernel.org, built it, and installed 
it. Now I want to merge my development branch with that. Last time I was 
looking, I had to write the message for the merge myself, unlike "pull", 
which takes care of that.

Also, I have a repository on my server for one of my projects. I push from 
my workstation to the "mainline" branch, and I have "deploy" checked out 
(with some configuration changes that shouldn't propagate back). Then I 
merge "mainline" into "deploy", build, and install. Same thing; I have to 
write the "merge with mainline" argument myself.

	-Daniel
*This .sig left intentionally blank*
