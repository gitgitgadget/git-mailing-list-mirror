From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: qgit idea: interface for cherry-picking
Date: Mon, 03 Jul 2006 00:54:39 +0200
Organization: At home
Message-ID: <e89iql$42a$1@sea.gmane.org>
References: <e8954u$srh$1@sea.gmane.org> <e5bfff550607021433l1987c32apf4453b52fc2f3e63@mail.gmail.com> <e89eqj$npu$1@sea.gmane.org> <e5bfff550607021504l6e7fc8b8ja61f20f630c0f3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 03 00:54:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxApn-00036k-Tu
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 00:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWGBWyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 18:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWGBWyd
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 18:54:33 -0400
Received: from main.gmane.org ([80.91.229.2]:5321 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751041AbWGBWyc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 18:54:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FxApd-00035C-Lc
	for git@vger.kernel.org; Mon, 03 Jul 2006 00:54:25 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 00:54:25 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 00:54:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23133>

Marco Costalba wrote:

> What do you think about this:
> 
> When dropping the selected commits, instead of creating new commits,
> appears a message box with something like "Do you want to apply the
> commits on top of your current branch or on your working directory?"
> 
> Sounds good for you? Or you still prefer the context menu?
> In the latter case, if I have understood correctly, you are limited to
> cherry-pick among branches and/or working directory of the _same_
> repository.

Yes, git-cherry-pick works only between commits in the same repository,
as it use merge (first "simple", i.e. git-read-tree -m -u --aggresive, if
fails tries "automatic" i.e. git-merge-index -o git-merge-one-file -a, then
git-write-tree), as opposed to git-format-patch and git-am or git-apply,
which can work across repositories.

What I really want is "no-commit" of drag'n'dropped, or exported and applied
commits/patches (although interface to cherry-pick would be nice, even if
cherry-pick is limited), so I'd like message box with "Do you want to
commit selected patches?" when dropping commits, or something like that.
Unfortunately git-am doesn't have --no-commit flag, but one could emulate it
with git-reset after git-am a patch, I think.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
