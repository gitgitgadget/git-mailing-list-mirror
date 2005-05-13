From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Fri, 13 May 2005 19:14:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505131853020.30848-100000@iabervon.org>
References: <20050513221935.GC32232@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat May 14 01:18:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWjQ4-0006xv-Cl
	for gcvg-git@gmane.org; Sat, 14 May 2005 01:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVEMXRX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 19:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVEMXQL
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 19:16:11 -0400
Received: from iabervon.org ([66.92.72.58]:37894 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262483AbVEMXOw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 19:14:52 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DWjMM-0003RL-00; Fri, 13 May 2005 19:14:22 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050513221935.GC32232@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 14 May 2005, Petr Baudis wrote:

> Hmm, I've honestly expected something different - a generic way to
> specify any file in the repository to be pulled along, instead of a
> introducing refs awareness at this level of git. What would be the
> advantages of that approach against just specifying list of other files
> to pull along?

The point is to specify the commit to pull by fetching a file from the
other side, not just to move a file. So you need to be specifying that the
file is a hex encoding of the sha1 hash of the starting point of the pull,
and the refs/ area is where these are expected to be. (Note that it still
doesn't have any knowledge about the meanings of files in refs/; you tell
it which one you want to use, and optionally which one you want to write
to, and it will use the names you provide).

It wouldn't help much to download the head file if you had to know the
contents of that file already in order to do everything as a single
transfer.

	-Daniel
*This .sig left intentionally blank*

