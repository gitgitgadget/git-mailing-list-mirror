From: badgerhardy <andrew.hardy@gl-group.com>
Subject: Re: git svn dcommit sends to wrong branch
Date: Thu, 26 Jan 2012 07:27:38 -0800 (PST)
Message-ID: <1327591658546-7227251.post@n2.nabble.com>
References: <20120110161843.GC8196@victor> <20120111140513.GA12633@victor> <877h0yz269.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 16:27:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqREq-0007c6-Bp
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 16:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274Ab2AZP1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 10:27:39 -0500
Received: from sam.nabble.com ([216.139.236.26]:35556 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520Ab2AZP1j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 10:27:39 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <andrew.hardy@gl-group.com>)
	id 1RqREg-0007PH-Ht
	for git@vger.kernel.org; Thu, 26 Jan 2012 07:27:38 -0800
In-Reply-To: <877h0yz269.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189151>


Thomas Rast wrote
> 
> Victor Engmark &lt;victor.engmark@&gt; writes:
> 
> The rule is that the commits go to the branch named in the git-svn-id
> line of the most recent first-parent ancestor of HEAD.
> 
> You can find the "base" commit in question with
> 
>   git log -1 --first-parent --grep=^git-svn-id:
> 
>> And more importantly, how do I "replay" my commits on trunk?
> 
> You need to rebase the commits on trunk, and (very important) strip the
> git-svn-id lines from their messages.  If you only had a handful of
> commits, your best bet is to use something like
> 
>   git checkout -b newbranch
>   git rebase -i --onto svn/trunk svn/branch_name  # or whatever git-svn
> named the remote branches
>   # edit all the 'pick' into 'reword'
>   # in every commit message editor that pops up, remove the git-svn-id
> line
> 
>   gitk  # make sure that you like the resulting history!
>   git svn dcommit
> 

I had the same problem and have followed these instructions (thanks!). I now
have a 'newbranch' that will correctly dcommit to the svn trunk. What
happens to the git 'master'? Is this recoverable or do I need to delete it
and rename the 'newbranch' as master?

Thanks,

--
View this message in context: http://git.661346.n2.nabble.com/git-svn-dcommit-sends-to-wrong-branch-tp7172744p7227251.html
Sent from the git mailing list archive at Nabble.com.
