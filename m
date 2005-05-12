From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Support projects including other projects
Date: Thu, 12 May 2005 02:04:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505120147100.30848-100000@iabervon.org>
References: <7v8y2lknsp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 07:58:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW6hu-0000fJ-8q
	for gcvg-git@gmane.org; Thu, 12 May 2005 07:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVELGFQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 02:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVELGFQ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 02:05:16 -0400
Received: from iabervon.org ([66.92.72.58]:54277 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261173AbVELGFI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 02:05:08 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DW6oN-0001w6-00; Thu, 12 May 2005 02:04:43 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8y2lknsp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 11 May 2005, Junio C Hamano wrote:

> I do not think the issues you are raising are solved by having
> that "include {hash}" thing in the commit like you propose here,
> instead of keeping it outside of the commit like I suggested.
> 
> What I meant to say was just I do not think having this "version
> dependency" in the core or outside of the core would make any
> difference.

I was primarily responding to your idea of it being outside the scope of
cogito as well as outside the core.

My reasons for having it in the core are as follows:

 - All of the porcelain layers have to, at least, agree as to how this is
   represented in order for repositories to be portable; since the
   representation is common, it might as well be core.

 - There are currently no special files which are tracked for cogito (et 
   al) to put the information in.

 - Ideally, the dependancy would only be per-commit, not per-tree; if Petr
   releases a new cogito which only merges a new mainline with the git-pb,
   the cogito tree object should be the same (since the cogito content
   didn't change). This means that it can't be anywhere other than the
   commit.

 - If the solution to the issue of finding the necessary git-pb is to
   store it with cogito, then the programs that pull from this repository
   need to know that they need to pull the git-pb portion, and fsck-cache
   needs to know that the cogito references the git-pb.

	-Daniel
*This .sig left intentionally blank*

