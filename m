From: "George Spelvin" <linux@horizon.com>
Subject: Git feature request: --amend older commit
Date: 17 Aug 2012 11:47:49 -0400
Message-ID: <20120817154749.11762.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 17:55:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2OtQ-0004Xg-Qv
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 17:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675Ab2HQPzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 11:55:15 -0400
Received: from science.horizon.com ([71.41.210.146]:25571 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752843Ab2HQPzN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 11:55:13 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Aug 2012 11:55:12 EDT
Received: (qmail 11763 invoked by uid 1000); 17 Aug 2012 11:47:49 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203618>

With git's "commit frequently" style, I often find that I end up with a
commit that includes a typo in a comment or I forgot one call site when
updating functions or something.

And it's a few commits later before I notice the simple oops.

This is of course fixable by making a commit, rebase -i HEAD~4 (or whatever),
and marking the fixup for squashing into the previous commit.

But it would be really handy if there were a one-step command for doing this.

Something like "git commit --fixup HEAD~3", where "git commit --fixup HEAD"
would be equivalent to "git commit --amend".

It would be fine if it were implemented using rebase -i and you had to
use "git rebase --continue" to recover from a conflict.  And history had
to be linear from the fixup point to HEAD.

The only thing I'd wish for, that rebase -i doesn't support, is a commit
with a dirty tree.  (Because often the typo is noticed in the middle of further
development.)  But if I have to manually stash & pop, that would be good enough.


Talking with some friends, they all say "yeah, I would really use that
feature".  So I figured I'd mention it here.
