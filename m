From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: A usage question
Date: Mon, 1 Jun 2009 12:32:00 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0906011215140.2147@iabervon.org>
References: <20090531033431.GB25869@darkbox>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeremy O'Brien <obrien654j@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 18:32:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBAQn-0008Up-Hd
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 18:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbZFAQcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 12:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755792AbZFAQcA
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 12:32:00 -0400
Received: from iabervon.org ([66.92.72.58]:54724 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755218AbZFAQb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 12:31:59 -0400
Received: (qmail 10753 invoked by uid 1000); 1 Jun 2009 16:32:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Jun 2009 16:32:00 -0000
In-Reply-To: <20090531033431.GB25869@darkbox>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120476>

On Sat, 30 May 2009, Jeremy O'Brien wrote:

> Hello,
> 
> I have a git usage question. I'm working on three separate branches in a
> foreign SCM called Surround. One branch is the mainline, and two others
> are a v1 branch based off the mainline and the other is a v2 branch
> based off the mainline with many new features that we hope to release
> soon. Some components of the v1 branch are similar, but not identical to
> the v2 branch, and other parts are completely different. I am primarily
> working on the v2 branch, but some things that I change can/should be
> backported to the v1 and mainline branches.
> 
> The foreign SCM requires one working directory for each branch, so I
> currently have three separate git repos with the contents of what is on
> Surround for each, and then I have one "local" git repo that I'm using
> to do my development. I have three branches on this local repo: one to
> track each git repo set up for Surround. I've been using topic branches
> in my local dev repo to do my work, and then merging my changes into the
> branch I branched my topic branch from, and cherry-picking ones into the
> other two branches that could be used there. I then push these branches
> to the repos and check then into Surround when I am ready to. This
> doesn't seem efficient to me at all, and I was wondering if there is a
> better setup someone could suggest that would make development easier.

It sounds to me like all of the steps are required, since Surround want 
those directories to exist and contain your work. You may be able to 
automate them, though, depending on how amenable Surround is to being part 
of scripts (and how comfortable you are writing scripts). Of course, in 
the limit, a script could be called from "git fetch" and "git push", and 
it would essentially act like native git interaction with an upstream 
maintainer who rewrites commits.

If Surround has an API like Perforce does, and it extends to allowing the 
developer to implement a different view of the filesystem, you might not 
even need to have those directories on disk, unless you want to be able to 
show your coworkers something in an environment they recognize.

	-Daniel
*This .sig left intentionally blank*
