From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Seeing differences at origin/branch?
Date: Tue, 17 Jul 2007 12:23:27 -0400
Message-ID: <20070717162327.GC19102@fieldses.org>
References: <18071eea0707170853r41962edfge603ccec7b2e72cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 18:23:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAppm-0006fa-0z
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 18:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762447AbXGQQXa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 12:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762097AbXGQQXa
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 12:23:30 -0400
Received: from mail.fieldses.org ([66.93.2.214]:35874 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755655AbXGQQX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 12:23:29 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IAppf-0006pS-QG; Tue, 17 Jul 2007 12:23:27 -0400
Content-Disposition: inline
In-Reply-To: <18071eea0707170853r41962edfge603ccec7b2e72cb@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52771>

On Tue, Jul 17, 2007 at 04:53:03PM +0100, Thomas Adam wrote:
> This is perhaps going to seem like a very CVS/SVN type of question,
> but is there a way to see a list of differences between one's local
> copy and the origin branch?  I'm after something analogous to "svn
> status -u" really (yes, I know I could get my hands scorched for such
> things.  :P).  Is this possible?
>
> I've tried:
>
> git-diff-tree -p origin/master
>
> But that won't list changes waiting for me that I would get when I
> issue a "git pull".

After first doing a "git fetch", to update your local view of those
remote branches:

Commits on your current branch, not in origin:

	git diff origin..HEAD

Commits in the origin branch, not in your current branch (so this is
what you'd probably get if you pulled):

	git diff HEAD..origin

Commits in either one, not in the other (the union of the above two):

	git diff HEAD...origin

The "HEAD" is actually optional in all the above.

And, finally, I think

	gitk HEAD...origin

gives the clearest picture of what's actually going on.

--b.
