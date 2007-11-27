From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 15:34:52 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711271519450.5349@iabervon.org>
References: <200711271127.41161.gapon007@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gapon <gapon007@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 21:35:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix79R-0002u6-7u
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 21:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997AbXK0Uez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 15:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755474AbXK0Uez
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 15:34:55 -0500
Received: from iabervon.org ([66.92.72.58]:53009 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755356AbXK0Uey (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 15:34:54 -0500
Received: (qmail 6489 invoked by uid 1000); 27 Nov 2007 20:34:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Nov 2007 20:34:52 -0000
In-Reply-To: <200711271127.41161.gapon007@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66257>

On Tue, 27 Nov 2007, gapon wrote:

> hi all,
> first of all i don't know if there's a bugzilla or something similar for git - 
> i have found just this email (on http://git.or.cz/ webpage).
> 
> i have discovered "weird" behaviour of git in this scenario*:
> - user A is working in repo A
> - user B clones repo A
> - user B makes some changes, commits, pushes
> - user A makes some changes, git status (no info about new commit in his repo 
> from user B but it's probably ok i'd say - but some of my files are marked as 
> changed and already added to index  but i haven't changed them - that's 
> confusing, isn't it?)
> - user A can commit his changes => shouldn't be there any info/message/warning 
> displayed? it would be helpful to have here some info about "foreign commit" 
> in the repo or something like this

This is kind of a fundamentally crazy thing to do; it's like a CVS user 
committing to somebody else's working directory instead of to the central 
repository. As you might expect, the system is confused because the info 
of what version is checked out is changed without the checked-out files 
getting changed. This should probably be kept from happening in some 
fashion, not reported to the user after the fact.

	-Daniel
*This .sig left intentionally blank*
