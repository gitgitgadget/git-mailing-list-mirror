From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: New to Git / Questions about single user / multiple projects
Date: Wed, 19 Aug 2009 00:00:19 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908182343210.7195@iabervon.org>
References: <a2db4dd50908181852s1e2c64fen8b883faf76b3136d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Rob (gmail)" <robvanb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 06:02:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdcNL-0007ZK-Cc
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 06:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbZHSEAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 00:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbZHSEAT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 00:00:19 -0400
Received: from iabervon.org ([66.92.72.58]:49252 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbZHSEAT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 00:00:19 -0400
Received: (qmail 16045 invoked by uid 1000); 19 Aug 2009 04:00:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Aug 2009 04:00:19 -0000
In-Reply-To: <a2db4dd50908181852s1e2c64fen8b883faf76b3136d@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126501>

On Tue, 18 Aug 2009, Rob (gmail) wrote:

> I'm new to git and have some (I think) basic questions that I have not
> been able to find answers to in the documentation.
> It's very possible that these are the result of my lack in
> understanding git / version control, so feel free to point me to
> documentation
> that might contain the answers.
> 
> I'm doing ERP development for my job and various 'hobby' development
> in my spare time.
> I'd like to track/store/ version control the code that I write for
> both work and play.
> I am (currently) working by myself, no need to have multiple
> developers working of the same code.
> 
> Q1:
> Can I create a single repository (project?) for all my code, knowing
> that there are multiple small, unrelated projects. Or should I create
> a new repository for each project ?

It's much easier to have a new repository for each project. There are two 
possible ways to put multiple projects in a single repository: (1) you 
could have each one in a subdirectory, which is bad because each commit 
records the entire tree, so each project would have commits in its history 
that are about other projects; (2) you could have separate branches for 
each project; this is fine, but you only get one working directory per 
repository, so it's awkward because you can only have one of your projects 
checked out at a time.

On the other hand, it's pretty trivial to have lots of repositories, and 
there isn't really any disadvantage to it. In fact, you may want to have 
more repositories than projects at times, if you use the same project for 
multiple purposes and want to extend it in different ways at the same 
time.

> Q2:
> After initalizing my repository, and comitting the 1st batch of code:
> When further working on the code, will the command "git add ." add all
> changed and new files ? Or do I specifically need to list the new
> files ?

You can use "git add .", but be aware that this tends to pick up random 
cruft you've left in the directory.

> Q3: Can I run 'git add x' in any subdirectory, or do I need to issue
> if from the root of the project ?

You can run almost every git command from subdirectories, and it does what 
you'd expect with filenames when you're in a subdirectory. E.g., "git add 
x" while in "a/b/" is like being in the project root and running "git add 
a/b/x"

	-Daniel
*This .sig left intentionally blank*
