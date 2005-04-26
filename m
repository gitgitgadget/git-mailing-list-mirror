From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Cogito chicken-and-egg problem
Date: Tue, 26 Apr 2005 13:48:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504261322490.30848-100000@iabervon.org>
References: <1114534942.26856.10.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:56:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUHa-0002ze-4N
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 19:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVDZRwJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 13:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVDZRuU
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 13:50:20 -0400
Received: from iabervon.org ([66.92.72.58]:43783 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261608AbVDZRsl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 13:48:41 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DQUAi-0008A3-00; Tue, 26 Apr 2005 13:48:32 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1114534942.26856.10.camel@dv>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Apr 2005, Pavel Roskin wrote:

> > (Also, .git/HEAD is a dependancy, since you want to redo the version
> > script if you commit; but if you don't have it, that's okay and just means
> > you're building from a tarball, which is described completely by VERSION)
> 
> It should be a conditional dependency, i.e. it should be a dependency
> if .git exists.

True.

> It seems to me that the whole idea of including SHA1 in cg-version is
> broken.  SHA1 is not human readable.  But if the maintainers insist on
> having SHA1 in cg-version, I want it to be done without causing build
> warnings for new users.

The idea is that it should appear if you're building a version that has
changes in its .git; in this case, VERSION is insufficient to tell you
which revision you have installed. If I've got cogito-0.8 + three untagged
commits from the remote repository + two local patches, I'd like to be
able to tell if the installed version is cogito-0.8 + two of the remote
patches. Possibly, it should also suppress the SHA1 if you've got a tagged
head, but identifying this situation is tricky, currently. Eventually, it
should be able to use a cg program to update VERSION from .git/HEAD and
include SHA1 for cases which aren't directly tagged.

> Here's an alternative patch.

I like your version.

	-Daniel
*This .sig left intentionally blank*

