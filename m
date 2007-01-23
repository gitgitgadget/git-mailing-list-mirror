From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Deleting remote branches with git-branch and reflog questions
Date: Tue, 23 Jan 2007 14:12:33 +0100
Organization: At home
Message-ID: <ep51ie$i23$1@sea.gmane.org>
References: <200701231259.27719.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jan 23 14:12:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9LRa-0004YY-0W
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 14:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbXAWNMG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 08:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbXAWNMG
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 08:12:06 -0500
Received: from main.gmane.org ([80.91.229.2]:59166 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964999AbXAWNMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 08:12:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H9LRK-00039H-4P
	for git@vger.kernel.org; Tue, 23 Jan 2007 14:11:54 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 14:11:54 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 14:11:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37510>

Andy Parkins wrote:

> reflogs
> -------
> 
> Why does the reflog directory .git/logs need to store the refs/ directory?  
> Aren't /all/ the refs under "refs/" these days?

HEAD is not under refs/. Although IIRC we don't reflog HEAD, with detached
HEAD we could reflog at least detached state.

> Is it right that the reflog for a branch is deleted when the branch is 
> deleted?  Doesn't this kill one of the advantages of reflogs?  In particular, 
> if I accidentally deleted a branch, I would have no way of getting it back 
> because the reflog has been deleted too?  Personally I'd prefer that a reflog 
> line was added saying
>   XXXXXXXXXXXXXXX 00000000000000 Deleted
> Or similar.  After all; it's only disk space.  If the ref was later created 
> again, then the log can continue to be added to, but it will have a "Created 
> from" in the middle instead of at the end.

The problem is when you delete branch 'foo', and then create branch
'foo/bar'. You can't have both 'foo' and 'foo/bar' reflog.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
