From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Combining/merging commits
Date: Tue, 15 Apr 2008 08:37:09 +0200
Message-ID: <48044D15.6040801@viscovery.net>
References: <8e0b7b96-aee8-45a4-a160-023e92845434@n1g2000prb.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: xpr1010 <volition1980@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 08:38:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jleno-00019Y-8e
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 08:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbYDOGhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 02:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752204AbYDOGhP
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 02:37:15 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21824 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbYDOGhN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 02:37:13 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jlen1-00010f-68; Tue, 15 Apr 2008 08:37:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2040D546; Tue, 15 Apr 2008 08:37:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <8e0b7b96-aee8-45a4-a160-023e92845434@n1g2000prb.googlegroups.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79570>

xpr1010 schrieb:
> I have made several commits that should really have only been one, but
> there was a lot of back and forth because of my inherent clumsiness.
> Is there any way to combine or merge these commits to one?

Say, you have this commit series:

 ...--A--B--C--D

and you want to combine all of them, i.e. the last 4 commits, into a new
one, then you can do:

    # undo commits, but leave working directory unchanged
    $ git reset HEAD~4
    # make a new commit
    $ git commit

But if you want to combine only A,B,C because D should remain a separate
commit (i.e. what you want to combine are *not* the last commits), then
use git rebase --interactive, in particular, the 'squash' instruction. You
would use this todo list:

    pick A
    squash B
    squash C
    pick D

-- Hannes
