From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 5 Apr 2006 21:23:21 +0200
Message-ID: <20060405192321.GA20854@fiberbit.xs4all.nl>
References: <7v3bgs4exz.fsf@assigned-by-dhcp.cox.net> <20060405131834.60888.qmail@web25804.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 21:23:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRDbF-0001M2-8V
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 21:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWDETX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 15:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWDETX0
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 15:23:26 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:31176 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751339AbWDETX0
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 15:23:26 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1FRDb7-0005Qi-2r; Wed, 05 Apr 2006 21:23:21 +0200
To: moreau francis <francis_moreau2000@yahoo.fr>
Content-Disposition: inline
In-Reply-To: <20060405131834.60888.qmail@web25804.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18447>

On Wednesday April 5th 2006 moreau francis wrote:

> BTW, what does "--amend" option do ? It doesn't seem to be documented anywhere.

This is the original commit text that introduced it:

diff-tree b4019f045646b1770a80394da876b8a7c6b8ca7b (from d320a5437f8304cf9ea3ee1898e49d643e005738)
Author: Junio C Hamano <junkio@cox.net>
Date:   Thu Mar 2 21:04:05 2006 -0800

    git-commit --amend
    
    The new flag is used to amend the tip of the current branch.  Prepare
    the tree object you would want to replace the latest commit as usual
    (this includes the usual -i/-o and explicit paths), and the commit log
    editor is seeded with the commit message from the tip of the current
    branch.  The commit you create replaces the current tip -- if it was a
    merge, it will have the parents of the current tip as parents -- so the
    current top commit is discarded.
    
    It is a rough equivalent for:
    
    	$ git reset --soft HEAD^
    	$ ... do something else to come up with the right tree ...
    	$ git commit -c ORIG_HEAD
    
    but can be used to amend a merge commit.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>

So in the original context you can add separate binaries to a commit
of only text files that you just rescued from CVS or something and then
change the commit to include these binaries as well.

I've sent a separate patch for the documentation for git-commit using
Junio's clear explanation.
-- 
Marco Roeland
