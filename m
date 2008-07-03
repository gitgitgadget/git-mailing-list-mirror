From: David Brown <git@davidb.org>
Subject: Re: Cherry picking instead of merges.
Date: Thu, 3 Jul 2008 13:53:29 -0700
Message-ID: <20080703205329.GA17923@old.davidb.org>
References: <20080703182650.GA11166@old.davidb.org> <32541b130807031315j3d9b7d77y277e3cb994ab0964@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 22:54:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEVp1-0008VR-GN
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 22:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbYGCUxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 16:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbYGCUxc
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 16:53:32 -0400
Received: from mail.davidb.org ([66.93.32.219]:58412 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879AbYGCUxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 16:53:32 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KEVo1-0004j2-PZ; Thu, 03 Jul 2008 13:53:29 -0700
Content-Disposition: inline
In-Reply-To: <32541b130807031315j3d9b7d77y277e3cb994ab0964@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87318>

On Thu, Jul 03, 2008 at 04:15:22PM -0400, Avery Pennarun wrote:

>Unfortunately, since your mismerged branches are already published,
>rewriting history would cause a lot of pain for everyone.  It would be
>better to avoid doing that entirely.  However, I can see why you'd
>want to do that in order to make future git-bisect easier.

It's only sitting in a private developer's branch.  I want to do the merge
properly, but I'm just trying to figure out how to get the conflict
resolution out of his work.

>Basically, if you're going to try to fix the git-bisect intermediate
>versions, you're going to have to rewrite history anyway; in which
>case, why not just make your developer's cherry-picked branch the
>official one?  Then your problems are solved, other than getting all
>your developers onto the new history.

Once we start cherry picking the changes from Company B, we have a
different set of changes from them, and future merges will get harder and
harder.

>This will apply the correct conflict resolution to the tip of your
>newest branch.  All the revisions between X and HEAD will still be
>broken, but that's usually better than trying to rewrite history and
>pretend the broken revisions never existed.  You can always use "git
>bisect skip" for cases like that.

Except we already know that the broken change is inside of the broken
revisions.

It turns out that things are more messed up than I thought.  This developer
had done a 'git push' with some manual refs and pushed what was supposed to
be a merge into an unmerged branch.

I've spoken with all of the developers who use this tree, and everyone
agrees that rewinding the tree is the best way to go.  Now just time to
trudge forward and learn.

But, it makes for a good new rule: no cherry-picking other people's
changes.

David
