From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [BUG] ProgramError: merge ... .merge_file_4CPoEQ: No such file
Date: Tue, 06 Dec 2005 10:47:50 -0600
Message-ID: <E1Ejfyo-0003ae-2K@jdl.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 17:52:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejfyz-0006RP-9X
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 17:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVLFQr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 11:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVLFQr5
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 11:47:57 -0500
Received: from jdl.com ([66.118.10.122]:2280 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932319AbVLFQr4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 11:47:56 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1Ejfyo-0003ae-2K
	for git@vger.kernel.org; Tue, 06 Dec 2005 10:47:51 -0600
To: git@vger.kernel.org
In-Reply-To: 20051206163314.GA6112@c165.ib.student.liu.se
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13277>

> It seems that changes has been committed to
> Documentation/git-read-tree.txt in both the jdl branch and in
> origin.

Yes.

> This shouldn't cause any problems but git-merge-recursive
> (which currently is the default merge strategy) uses merge(1) to do
> the file-level merging and it seems like merge(1) can't be found on
> your system.
> 
> Do you have merge(1) installed? More appropriately, is merge in your
> path? If it isn't installed it can usually be found in the rcs package
> in your distribution.

Oh wow.  Exactly correct.

Here's Jon building up the new Ubuntu box, and thinking, "I'll
be using git, so I don't need to install RCS or CVS anymore." :-)

After installing RCS, here's what we get:

    jdl@ubuntu:/usr/src/git-core$ git reset --hard jdl
    jdl@ubuntu:/usr/src/git-core$ git pull . origin
    Trying really trivial in-index merge...
    fatal: Merge requires file-level merging
    Nope.
    Merging HEAD with be61db922a230ae2638c27c071ee4b8c98f01f72
    Merging:
    4baf91676c2462796137e93917c75f2e14ebb877 Added documentation for few missing options.
    be61db922a230ae2638c27c071ee4b8c98f01f72 git-merge-one-file: resurrect leading path creation.
    found 1 common ancestor(s):
    23c99d84601316c1e51ebc1f0b9bec5cddd011fb git-mv to work with Perl 5.6
    Auto-merging Documentation/git-read-tree.txt
    CONFLICT (content): Merge conflict in Documentation/git-read-tree.txt

    Automatic merge failed/prevented; fix up by hand


Thanks!
jdl
