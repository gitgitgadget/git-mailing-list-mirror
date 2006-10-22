From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Commit-ish shortcut for immediate parent range
Date: Sun, 22 Oct 2006 17:11:00 +0200
Organization: At home
Message-ID: <ehg1li$mn6$1@sea.gmane.org>
References: <200610221548.42048.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Oct 22 17:11:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbeyj-00039A-F3
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 17:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWJVPLF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 11:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWJVPLF
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 11:11:05 -0400
Received: from main.gmane.org ([80.91.229.2]:36817 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750700AbWJVPLE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 11:11:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GbeyT-00036g-LP
	for git@vger.kernel.org; Sun, 22 Oct 2006 17:10:53 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 17:10:53 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 17:10:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29762>

Andy Parkins wrote:

> Git's commit-ish is very powerful.  I was wondering however, if there was a 
> shortcut for (for example)?
> 
>  git-diff 3435fdb4c^..3435fdb4c

Thats "git-diff 3435fdb4c^ 3435fdb4c" - diff need pair of things
(one or more might be implied/default), not DAG.

> That is - the short range of a particular commit's parent to that commit; like
> 
>  git-diff 3435fdb4c!
> 
> Or similar.

Or similar. You have to use git-diff-tree, not git-diff as git-diff
uses working tree as second tree if second argument is not given 
(and index as first tree if first argument is not given).

$ git diff-tree -p 3435fdb4c

(-p to show patch instead of "whatchanged" output) shows diff to parent
of commit 3435fdb4c (if commit is merge commit, show nothing; use -m
or -c or --cc then).


By the way 3435fdb4c.. means 3435fdb4c..HEAD, and ..3435fdb4c means
HEAD..3435fdb4c (where HEAD means current branch).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
