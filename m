From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: I don't want the .git directory next to my code.
Date: Tue, 15 Jan 2008 23:13:58 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801152305050.13593@iabervon.org>
References: <478D79BD.7060006@talkingspider.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:14:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzfw-00025v-PP
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757478AbYAPEOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbYAPEOL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:14:11 -0500
Received: from iabervon.org ([66.92.72.58]:59708 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757655AbYAPEOK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 23:14:10 -0500
Received: (qmail 17976 invoked by uid 1000); 16 Jan 2008 04:13:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jan 2008 04:13:58 -0000
In-Reply-To: <478D79BD.7060006@talkingspider.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70619>

On Tue, 15 Jan 2008, Mike wrote:

> I'm learning git and I'm really annoyed that the .git directory lives in the
> same directory as my code.  I don't want it there for three reasons:
> 
> 1. My code lives on a development web server docroot, and I don't want the
> .git repository to end up getting published to the live site by accident. (I
> would imagine this would be a common need.)
> 
> 2. If I tar/gz my code and deliver it to a client, I don't want the .git dir
> slipping into the tarball, allowing my client to be able to peruse the history
> of what we did and when.

Generate your tarballs with "git archive", which will also make sure that 
you don't accidentally include anything else that's not committed. 
Likewise for sending to the live site, probably.

> 3. The .git respository will get big, especially with binary files in it, and
> I want it someplace with a lot of disk space. And I don't want it to get
> tarred up when we migrate the site to a different server. (And tar isn't aware
> of hard links is it? wonderful.)

You'll probably want to keep your history, which is what's in .git, when 
you migrate to a different server; that's kind of the point of using 
version control...

> How do I make the repository dir live somewhere else, the hell away from my
> code? Thanks

export GIT_DIR=/somewhere-else.git

Note that this only really works if you've only got one repository; 
there's no good way to have the repository information outside of the 
working directory and still have which repository you're using depend on 
which directory you're working in.

	-Daniel
*This .sig left intentionally blank*
