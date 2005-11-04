From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Trying to Update All Heads of a Repository
Date: Fri, 4 Nov 2005 18:47:21 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511041745480.25300@iabervon.org>
References: <E1EXpN9-00034x-7g@jdl.com> <7vy8453zhu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 00:48:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYBHX-0003XR-7l
	for gcvg-git@gmane.org; Sat, 05 Nov 2005 00:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVKDXrg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 18:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVKDXrg
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 18:47:36 -0500
Received: from iabervon.org ([66.92.72.58]:24593 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751091AbVKDXrf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 18:47:35 -0500
Received: (qmail 11508 invoked by uid 1000); 4 Nov 2005 18:47:21 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2005 18:47:21 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy8453zhu.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11172>

On Thu, 3 Nov 2005, Junio C Hamano wrote:

> Jon Loeliger <jdl@freescale.com> writes:
> 
> > First, I have this, because it came with a git-clone:
> >
> >     % cat .git/remotes/origin
> >     URL: rsync://rsync.kernel.org/pub/scm/git/git.git
> >     Pull: master:origin
> >
> > I don't know how to say "Grab all the updates for
> > all the heads for which I have heads in my .git/refs".
> 
> My "guinea pig" repository has this in $GIT_DIR/remotes/origin:
> 
>         URL: git://git.kernel.org/pub/scm/git/git.git
>         Pull: master:origin
>         Pull: +pu:pu
>         Pull: maint:maint

Shouldn't approximately this be what git-clone sets up for you? If it's 
getting those heads initially, it should keep the information for future 
use. The only thing it wouldn't know would be the "+" on pu.

On the "pu" issue, maybe "pu" shouldn't be a branch, but should be 
something different, like a tag. I think, actually, that a tag would 
describe "pu" pretty well: no development happens on its line; rather, 
development happens elsewhere (topic branches), and a merge of some of 
them is then released as being interesting. What is interesting as "pu" 
today isn't necessarily related to yesterday or tomorrow. Then you 
wouldn't exactly be rebasing things all the time, but you'd instead be 
marking different and unrelated commits in the same way at different 
times. (Probably need to do more to handle the case where a tag ref 
changes and define the semantics properly)

	-Daniel
*This .sig left intentionally blank*
