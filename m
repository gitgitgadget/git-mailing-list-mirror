From: linux@horizon.com
Subject: Re: More merge questions (why doesn't this work?)
Date: 2 Dec 2005 16:32:14 -0500
Message-ID: <20051202213214.27282.qmail@science.horizon.com>
References: <7vbqzz2qc8.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 22:34:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiIVv-0007lw-2G
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 22:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVLBVcQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 16:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVLBVcQ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 16:32:16 -0500
Received: from science.horizon.com ([192.35.100.1]:28729 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750732AbVLBVcP
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 16:32:15 -0500
Received: (qmail 27283 invoked by uid 1000); 2 Dec 2005 16:32:14 -0500
To: junkio@cox.net, linux@horizon.com
In-Reply-To: <7vbqzz2qc8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13127>

> We earlier agreed that the table in t/t1000 test should go and
> superseded by trivial-merge.txt, so what the table says right
> now is a non-issue, but we _might_ want to revisit the issue of
> what should happen in case #8 and #10 sometime in the future, as
> the last three lines of trivial-merge.txt mentions.  I'd say we
> should leave things as they are for now, though.

But back to my original problem... I don't much care whether it's
done as a trivial merge or a non-trivial merge, but why the #%@#$ can't
it be done as an automatic merge?

As I said, I'm trying to build (and write down) a mental model, so the
behaviour of git can be predicted.  My mental model says this should
work.  It doesn't.  Therefore my mental model is incorrect, and I
don't actually understand what it's doing.

#!/bin/bash -xe
rm -rf .git
git-init-db
echo "File A" > a
echo "File B" > b
echo "File C" > c
git-add a b c
git-commit -a -m "Octopus test repository"

git-checkout -b a
echo "Modifications to a" >> a
git-commit -a -m "Modified file a"

git-checkout -b b master
echo "Modifications to b" >> b
git-commit -a -m "Modified file b"

git-checkout -b c master
rm c
git-commit -a -m "Deleted file c"

git-checkout master
git merge "Merge a, b, c" master a b c

produces...

+ git merge 'Merge a, b, c' master a b c
Trying simple merge with a
Trying simple merge with b
Trying simple merge with c
Simple merge did not work, trying automatic merge.
Removing c
fatal: merge program failed
No merge strategy handled the merge.


> *3* I did that, and it renders HTML side nicer, but it breaks
> manpages X-<.  Inputs from asciidoc gurus are appreciated.

I tried adding " +" at end-of-line, which is supposed to force a
line break, but that didn't have any effect.
