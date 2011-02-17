From: "Yann Droneaud" <yann@droneaud.fr>
Subject: Re: inode problem when using git on a sshfs filesystem
Date: Thu, 17 Feb 2011 13:05:58 +0100
Message-ID: <f0f23bdf3aedabac3a596ef6081009fb.squirrel@webmail.ocsa-data.net>
References: <1297893854.4097.43.camel@dworkin.quest-ce.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: fuse-sshfs@lists.sourceforge.net, fuse-devel@lists.sourceforge.net,
	git@vger.kernel.org, yann@droneaud.fr
To: "Yann Droneaud" <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Thu Feb 17 13:05:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq2cL-00055r-Pa
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 13:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445Ab1BQMFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 07:05:49 -0500
Received: from mx-out.ocsa-data.net ([194.36.166.37]:53185 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab1BQMFr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 07:05:47 -0500
Received: from [192.168.111.12] (helo=webmail.ocsa-data.net)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1Pq2cE-0005FR-8v; Thu, 17 Feb 2011 13:05:46 +0100
Received: from 80.12.80.40
        (SquirrelMail authenticated user meuh@meuh.org)
        by webmail.ocsa-data.net with HTTP;
        Thu, 17 Feb 2011 13:05:58 +0100
In-Reply-To: <1297893854.4097.43.camel@dworkin.quest-ce.net>
User-Agent: SquirrelMail/1.4.21
X-Priority: 1 (Highest)
Importance: High
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167070>

> Hi,
>
> For some days, my usage of git is not as seamless as before.
>
> I'm using git along sshfs/fuse (don't blame me for that), and
> each time I try to rebase one of my branch, I have a conflict when
> applying
> the third commit. Doing the same operation on a local filesystem works
> without any problem.
>
> ===== Part one: git =====
>
> When I try to rebase one specific branch, git rebase failed when applying
> the third commit,
> telling me about uncommited
>

For the record, here's the exact message for a rebase:

$ git rebase origin
First, rewinding head to replay your work on top of it...
Applying: patch1
Applying: patch2
Applying: patch3
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
error: Your local changes to '<path>/<filename>' would be overwritten by
merge.  Aborting.
Please, commit your changes or stash them before you can merge.
Failed to merge in the changes.
Patch failed at 0003 patch3


> As a workaround: running git diff / git diff --cached / git status between
> each
> git apply --index command seems to update the cache and allows me to apply
> all the patches
> without problem. But it's not an easy path to follow when rebasing
> branches.
>

The exact command to update the index is "git diff".

Regards.

-- 
Yann Droneaud
