From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 02:40:31 -0400 (EDT)
Message-ID: <3817.10.10.10.24.1114756831.squirrel@linux1>
References: <20050426004111.GI21897@waste.org>
    <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
    <20050429060157.GS21897@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 08:35:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRP5t-0003zL-MI
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 08:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVD2Gkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 02:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVD2Gkt
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 02:40:49 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:32946 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262441AbVD2Gkc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 02:40:32 -0400
Received: from linux1 ([67.71.124.169]) by simmts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050429064031.IKTF1614.simmts5-srv.bellnexxia.net@linux1>;
          Fri, 29 Apr 2005 02:40:31 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j3T6eVIs025220;
	Fri, 29 Apr 2005 02:40:31 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Fri, 29 Apr 2005 02:40:31 -0400 (EDT)
In-Reply-To: <20050429060157.GS21897@waste.org>
To: "Matt Mackall" <mpm@selenic.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, April 29, 2005 2:01 am, Matt Mackall said:

> What I'd like to highlight here is that git's repo is growing more
> than 10 times faster. 52 megs is twice the size of a full kernel
> tarball. And that's going to be the bottleneck for network pull
> operations.

There isn't anything preventing optomized transfer protocols for git. 
Give it time.


> The fundamental problem I see with git is that the back-end has no
> concept of the relation between files. This data is only present in
> change nodes so you've got to potentially traverse all the commits to
> reconstruct a file's history. That's gonna be O(top-level changes)
> seeks. This introduces a number of problems:
>
> - no way to easily find previous revisions of a file
>   (being able to see when a particular change was introduced is a
>   pretty critical feature)

Scanning back through the history is a linear operation and will quite
likely be just fine for many uses.   As others have pointed out, you can
cache the result to improve subsequent lookups.


> - no way to do bandwidth-efficient delta transfer

There's nothing preventing this in the longer term.  And you know, we're
only talking about a few megabytes per release.  We're not talking about
video here.


> - no way to do efficient delta storage

This has been discussed.  It is a recognized and accepted design
trade-off.  Disk is cheap.


> - no way to do merges based on the file's history[1]

What is preventing merges from looking back through the git history?



The fundamental design of git is essentially done, it is what it is.

Your concearns are about performance rather than real limitations and it's
just too damn early in the development process for that.  Frankly it's
amazing how good git is considering its age; it's already _way_ faster and
easier to use than bk ever was for my use.


> Mathematics is the supreme nostalgia of our time.

I've been tying to figure out what this means for a while now <g>


Sean


