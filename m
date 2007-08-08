From: Matthias Kleine <matthias_kleine@gmx.de>
Subject: Re: git-svn: Finding the svn-URL of the current branch in git
Date: Wed, 08 Aug 2007 10:54:55 +0200
Message-ID: <f9c0d1$7md$1@sea.gmane.org>
References: <46B8BA03.1030809@gmx.de> <20070807205543.GB27703@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 11:00:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIhOm-0000qE-Ij
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 11:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209AbXHHJAI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 05:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754536AbXHHJAI
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 05:00:08 -0400
Received: from main.gmane.org ([80.91.229.2]:60600 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436AbXHHJAH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 05:00:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IIhOb-0004Kj-Uf
	for git@vger.kernel.org; Wed, 08 Aug 2007 11:00:01 +0200
Received: from e178070063.adsl.alicedsl.de ([85.178.70.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 11:00:01 +0200
Received: from matthias_kleine by e178070063.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 11:00:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: e178070063.adsl.alicedsl.de
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070807205543.GB27703@xp.machine.xx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55308>

Peter Baumann wrote:
> 
> I had this situation, too.
> 
> 
> 			a = svn branch 'a'
> 	  m		b = svn branch 'b' (in my case, it was trunk)
>       /   \		m = a merge of branch 'a' and 'b', not yet commited to svn
>      a     b
> 
> So trying to dcommit m, git svn can't figure out on which branch, as 'a'
> and 'b' are both reachable. I had to use a graft file to lose one of the
> parents, which let git-svn commit to SVN.

You're right, both 'a' and 'b' are reachable from 'm'.  But if I got it 
right 'm' also contains information as to which one is the first parent 
and thereby which branch we're on. So wouldn't it be enough, if git-svn 
automatically chose the first parent (using log --first-parent)?

> 
> So for a short fix to get the work done, you could create a graft file
> where you fake m to only have one parent.
>
Thanks for that one. I didn't know about the grafts file before.

Matthias
