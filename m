From: Jeff King <peff@peff.net>
Subject: Re: I don't want the .git directory next to my code.
Date: Thu, 17 Jan 2008 10:17:25 -0500
Message-ID: <20080117151725.GC2816@coredump.intra.peff.net>
References: <478D79BD.7060006@talkingspider.com> <86hcheig3n.fsf@blue.stonehenge.com> <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org> <478E3D8E.1090300@talkingspider.com> <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801161019250.2806@woody.linux-foundation.org> <478EEAC4.2010006@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 16:18:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFWVB-00080z-Uh
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 16:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbYAQPR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 10:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbYAQPR2
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 10:17:28 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3034 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbYAQPR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 10:17:27 -0500
Received: (qmail 3990 invoked by uid 111); 17 Jan 2008 15:17:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 17 Jan 2008 10:17:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jan 2008 10:17:25 -0500
Content-Disposition: inline
In-Reply-To: <478EEAC4.2010006@talkingspider.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70867>

On Thu, Jan 17, 2008 at 12:42:28AM -0500, Mike wrote:

> If we end up having to write a special "publisher" app to move files from 
> dev to live, then it will only be because of those damn .git directories.  
> More likely we'd add some exclusions into an rsync wrapper, I guess. And 
> then still worry about tarring up the docroot (not all of which is 
> gitted).  And then worry that some young developer on the team might SCP a 
> directory's contents and he didn't notice that .git dir because it doesn't 
> show up under "ls" or the "ll" alias.

What is it that you want? You're worried about .git directories. Fine.
There have been _many_ responses suggesting solutions, including:

  - having a deployment step which does the right thing
  - moving .git away, and using --git-dir or GIT_DIR to specify it
    manually
  - moving .git away, using core.worktree, and doing git operations from
    the repo directory
  - moving .git away, and having your shell automagically update GIT_DIR
    based on your current directory
  - moving .git away, wrapping 'git' with a script that sets GIT_DIR
    according to some mapping (I think somebody mentioning just mapping
    /path/to/tree to /var/git/path/to/tree or similar, but obviously you
    could make a custom mapping in a hard-coded file).

You don't seem happy with any of those. But the fact remains that the
git repo has to be stored _somewhere_, and when you run git, there needs
to be some mapping telling it which git repo matches your working
directory. So how _do_ you want to specify that mapping? 

-Peff
