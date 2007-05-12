From: Yann Dirson <ydirson@altern.org>
Subject: Transactions for git (and stgit) ?
Date: Sat, 12 May 2007 11:53:12 +0200
Message-ID: <20070512095312.GK19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat May 12 11:54:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmoJ0-0002bG-4d
	for gcvg-git@gmane.org; Sat, 12 May 2007 11:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbXELJyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 05:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755272AbXELJyT
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 05:54:19 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:54624 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754265AbXELJyS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 05:54:18 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E8D105E1AA;
	Sat, 12 May 2007 11:54:17 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id CC1791F161; Sat, 12 May 2007 11:53:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87wszg39cp.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47030>

On Thu, May 10, 2007 at 09:57:10AM -0700, Carl Worth wrote:
> What I find myself wanting to type is just:
> 
> 	git cherry-pick A..B
> 
> But there is the whole problem of how to deal with any conflict that
> appears during the process.

Indeed this is a problem we also have in StGIT, when pushing multiple
patches after rebasing.  Currently we have to deal with the conflict
and forge a new command-line to finish the job, which is quite awkward.

In this respect, the --continue/--skip/--abort set of flags that
git-rebase has are really useful.

In fact, I have plans to deal with such behaviours with stgit
transactions: in this case, we have the need of user interaction in
the middle of a transaction, and the rebase flags mentionned above are
just a way for the user of continuing or aborting the transaction.

However, currently I'm not sure that git-rebase would be very robust
if the user would mess with HEAD before issuing one of these commands.
Maybe git would also benefit from a generic transaction mechanism of
some sort, so "cherry-pick A..B" and possibly others can behave in a
consistent way with rebase ?

It could even be more sensible to implement transactions at the git
level rather than at the stgit one...

Best regards,
-- 
Yann.
