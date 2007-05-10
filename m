From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user manual
Date: Thu, 10 May 2007 13:42:38 -0700
Message-ID: <7vtzukif5t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
	<20070509031803.GA27980@fieldses.org>
	<Pine.LNX.4.64.0705091414280.4167@racer.site>
	<20070509131801.GD14969@fieldses.org>
	<7vk5vhnwl1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705101233580.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, kha@treskal.com,
	barkalow@iabervon.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 10 22:42:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmFTS-0003pC-EE
	for gcvg-git@gmane.org; Thu, 10 May 2007 22:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657AbXEJUml (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 16:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756658AbXEJUmk
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 16:42:40 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:59112 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657AbXEJUmk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 16:42:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510204239.JAEJ24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 16:42:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xYie1W00L1kojtg0000000; Thu, 10 May 2007 16:42:39 -0400
In-Reply-To: <Pine.LNX.4.64.0705101233580.4167@racer.site> (Johannes
	Schindelin's message of "Thu, 10 May 2007 12:36:15 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46898>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 13db969..3c3f1b4 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3160,6 +3160,225 @@ confusing and scary messages, but it won't actually do anything bad. In
>  contrast, running "git prune" while somebody is actively changing the 
>  repository is a *BAD* idea).
>  
> +[[birdview-on-the-source-code]]
> +A birdview on Git's source code
> +-----------------------------

Perhaps two dashes too short here...

> +
> +While Git's source code is quite elegant, it is not always easy for 
> +new  developers to find their way through it.  A good idea is to look 
> +at the contents of the initial commit: 
> +_e83c5163316f89bfbde7d9ab23ca2e25604af290_ (also known as _v0.99~954_).

I am not sure we would need to say "is quite elegant".  Why
don't we be blunt and say "It is not always easy for ...".  That
holds true for any project of nontrivial size.  I would rewrite
the first part like this.

	It is not always easy for new developers to find their
	way through Git's source code.  This section gives you a
	gentle guidance to show where to start.

	A good place to start is to look at the contents of the
	initial commit, with this command:

	----------------------------------------------------------------
        $ git checkout e83c516
        ----------------------------------------------------------------

and would not bore users with v0.99~954 or "git show" details.
"git show" to inspect one file at a time is not a good way to
get the feel of unknown set of source files, even though it is
very handy once you know where things were.  And then continue
on to this part...

> +Be sure to read the README in that revision _after_ you are familiar with 
> +the terminology (<<glossary>>), since the terminology has changed a little 
> +since then.  For example, we call the things "commits" now, which are 
> +described in that README as "changesets".
> +
> +Actually a lot of the structure as it is now can be explained by that 
> +initial commit.

It is also worth to point out that the initial revision, while
laying the foundation of almost every important factor of git we
have today, is small enough for reading everything in one
sitting, probably upfront, instead of making it a parenthesized
comment in a later paragraph.  If somebody wants to dive into
git development to take a source-code tour, it is not really "it
will help you", but is a small enough required investment of
time.

> +For example, we do not call it "cache" any more, but "index", however, the 
> +file is still called `cache.h`.  Remark: Not much reason to change it now, 
> +especially since there is no good single name for it anyway, because it is 
> +basically _the_ header file which is included by _all_ of Git's C sources.
> +
> +If you grasp the ideas in that initial commit (it is really small and you 
> +can get into it really fast, and it will help you recognize things in the 
> +much larger code base we have now), you should go on skimming `cache.h`, 
> +`object.h` and `commit.h` in the current version.

Other than that, I think this is well written, and if everybody
thinks it should be in the user's manual, I am fine with it.

By the way, when I sent the outline of hacker's manual as a
follow-up to the discussion, I think I forgot to properly say
this, so here it is: Thanks for starting the bird's eye view.
