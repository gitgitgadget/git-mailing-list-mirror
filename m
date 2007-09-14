From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git commit workflow question
Date: Fri, 14 Sep 2007 14:14:17 -0400
Message-ID: <20070914181417.GU3099@spearce.org>
References: <20070914103348.GA22621@bulgaria>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Swetland <swetland@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 20:26:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWFgQ-0001xS-DS
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 20:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbXINSOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 14:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbXINSOW
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 14:14:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39307 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262AbXINSOV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 14:14:21 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWFgZ-0004xQ-Qt; Fri, 14 Sep 2007 14:14:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CE77D20FBAE; Fri, 14 Sep 2007 14:14:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070914103348.GA22621@bulgaria>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58171>

Brian Swetland <swetland@google.com> wrote:
> With perforce I often have a bunch of files modified (having p4 add'd
> or p4 edit'd them) and then only commit a subset of them.  I can do
> this interactively by doing a p4 submit and just removing the files
> I don't want to check in from the list in the changelist description
> when I'm writing up the change description in $EDITOR, invoked by
> p4 submit.
> 
> It seems like my options with git are to invoke git commit with
> a specific list of things to commit, invoke git commit --interactive
> and use the interactive menu thing to shuffle stuff around, or
> manually unstage things until I have the index in a state where
> a git commit without other arguments will do what I want.

Or use git-citool/git-gui to make commits, in which case that
will help you to arrange the index with what you want to commit.
But yes, git-commit does not pay any attention to modifications
made to the template in the edit buffer.

I'm not sure how the Git community would react to being able to edit
the list of files being committed from within the commit message
buffer.  I think most Git users run at least `git diff --cached`
before they commit to make sure they are happy with the difference.
I know a lot of users who do that.  Most/all of those users also do
not stage something into the index until they are happy with the
change, which means there isn't any list of files to remove when
it comes time to make the commit as the contents of the index is
exactly what should be committed.

I used p4 for a while before Git was invented.  I found the file
editing feature useful then because there was no concept of the
index.  Now with Git I've embraced the index so much that I'm not
sure I can work without it, and I don't need to remove files from
my index during the actual commit itself.
 
-- 
Shawn.
