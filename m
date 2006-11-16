X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 20:21:36 -0800
Message-ID: <7vd57of2cv.fsf@assigned-by-dhcp.cox.net>
References: <87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<20061116011411.GB10512@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 04:22:00 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061116011411.GB10512@thunk.org> (Theodore Tso's message of
	"Wed, 15 Nov 2006 20:14:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31557>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkYlB-0003dk-An for gcvg-git@gmane.org; Thu, 16 Nov
 2006 05:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161722AbWKPEVl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 23:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162255AbWKPEVl
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 23:21:41 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:39372 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1161722AbWKPEVj
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 23:21:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116042139.IUMD18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 23:21:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nGMj1V0191kojtg0000000; Wed, 15 Nov 2006
 23:21:45 -0500
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org

Theodore Tso <tytso@mit.edu> writes:

> So with Bitkeeper, with "bk pull" there was never any question about
> which branch ("line of development") you would be merging into after
> doing a "bk pull", since there was only one LOD, and given that BK had
> the rule that a within a LOD only one tip was allowed, a "bk pull"
> _had_ to do do a merge operation.   

I've never used Bk and I really appreciate your comments here.

> If you are operating on your local development branch, the reality is
> that merging is probably not the right answer in the general case,

I agree, but I wonder why you are pulling/fetching (with or
without merge) if you are operating on your local development
branch (implying that you are in the middle of something else).

> ...  And by
> telling people, use "git fetch" instead, that's also an implicit
> admission that merging onto the current branch is often not the Right
> Thing.
>
> The problem is that "pull" is a very evocative word, especially given
> the existence "push", and so in the git world we are reduced to
> telling people, "you really don't want to use pull, trust me".  

I would rather say "use 'git branch' to make sure if you are
ready to merge".  Who teaches not to use "git pull"?

> If people are looking for a simple way out, maybe it would be enough
> to have an option where if "git pull" is called from an interactive
> terminal, and the "novice user" option is enabled, "git pull" returns
> a warning message,

I have to disagree with this.  In the simplest CVS-like central
repository with single branch setup in which many "novice users"
start out with, there is almost no need for "git fetch" nor
tracking branch.  You pull, resolve conflicts, attempt to push
back, perhaps gets "oh, no fast forward somebody pushed first",
pull again, then push back.  So I am not sure where "you really
do not want to use pull.  trust me" comes from.

It is a different story for people who _know_ git enough to know
what is going on.  They may be using multiple branches and
interacting with multiple remote branches, and there are times
you would want fetch and there are other times you would want
pull.  But for them, I do think the suggestion would never end
with "trust me" -- they would understand what the differences
are.



