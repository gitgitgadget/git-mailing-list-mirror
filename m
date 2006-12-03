X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface to
 the index
Date: Sat, 02 Dec 2006 23:22:11 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612022305100.2630@xanadu.home>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home>
 <7vpsb36yem.fsf@assigned-by-dhcp.cox.net> <87veku3i0j.wl%cworth@cworth.org>
 <200612020828.57989.alan@chandlerfamily.org.uk>
 <87psb22qgu.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 3 Dec 2006 04:22:28 +0000 (UTC)
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <87psb22qgu.wl%cworth@cworth.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33093>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqirw-0002oV-Mi for gcvg-git@gmane.org; Sun, 03 Dec
 2006 05:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936659AbWLCEWN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 23:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936660AbWLCEWN
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 23:22:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41305 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S936659AbWLCEWN (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 23:22:13 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9O004PUK4ZQIG0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Sat,
 02 Dec 2006 23:22:12 -0500 (EST)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

On Sat, 2 Dec 2006, Carl Worth wrote:

> If git's model imposes the requirement, "we should first teach one
> thing, then move on to teach a subsequent thing", it would be just
> that much nicer if the commands themselves could help us do that,
> (because the default would do the thing they would need first, and
> then the user has to explicitly do _something_ else to get the
> subsequent thing).

Since I've been thinking about this issue I've come to the conclusion 
that making commit -a the default for commit is not a good thing.

Why? Because we really want newbies to be tricked into using the index.

And teaching about the different ways to update the index in the 
tutorial right after the first commit example is IMHO the best thing to 
do.

Making commit -a the default would make it possible for newbies to 
get along for a long while ignoring the usage model of git and that is 
bad.

I think the idea is really to make "git commit" with a clean index more 
clueful to the user.  Right now it only says "use git-update-index to 
mark for commit" which is really not that helpful, and actually the 
point of failure with the example newbie problem you pointed out.

There is a compromise to reach.  Sure the _user_ needs a proper model to 
use the tool without being bothered with technical implementation or 
architecture details.  But we still need newbies to get into the git 
model nevertheless, and having a default for git-commit geared towards 
making it bump free for new users is not the way to go I think.  The 
"nothing to commit" message needs to be way more helpful with better 
guidance and the git-commit default behavior should be overcome.


