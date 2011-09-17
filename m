From: Steinar Bang <sb@dod.no>
Subject: Merging back from master but keeping a subtree
Date: Sat, 17 Sep 2011 09:49:40 +0200
Organization: Probably a good idea
Message-ID: <87y5xn8v6z.fsf@dod.no>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 09:55:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4pkJ-0004il-OP
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 09:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab1IQHzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 03:55:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:34903 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751657Ab1IQHzK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 03:55:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R4pju-0004bi-PC
	for git@vger.kernel.org; Sat, 17 Sep 2011 09:55:06 +0200
Received: from cm-84.208.226.30.getinternet.no ([84.208.226.30])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Sep 2011 09:55:06 +0200
Received: from sb by cm-84.208.226.30.getinternet.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Sep 2011 09:55:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: cm-84.208.226.30.getinternet.no
Mail-Copies-To: never
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/23.3 (gnu/linux)
Cancel-Lock: sha1:4I1mqetjmmU7HucAF7rvicnBXic=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181572>

I have a long lived branch that changes a directory and its
subdirectory, ie. 
 top/middle/mydirectory

Now I want to merge in an updated remoterepo/master and keep everything
from that master, except for mydirectory and its subdirectory, where I
would like to keep everything from my branch.

I tried a regular merge, and used
 git checkout --ours
 git add
and 
 git checkout --theirs
 git add
as appropriate on all conflicts.

But the result didn't build, and the build errors don't make much sense,
so I think they are caused by "successful" merges giving bad results.

Is there a better way to do this?

Would it be possible to unstage the already staged files and apply the
"checkout --ours" and "checkout --theirs", and then git add on the
checked out files?

Even that would be clumsy... I would have preferred something like
 git checkout --theirs top
 git checkout --ours top/middle/mydirectory
 git add-only-those-modified-wrt-my-branch


Thanks!

- Steinar
