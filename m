From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 20:53:56 +0200
Message-ID: <200507282053.56786.Josef.Weidendorfer@gmx.de>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de> <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 28 21:02:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyDdi-0000oc-U1
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 21:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVG1S4O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 14:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVG1SyO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 14:54:14 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:55996 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S261531AbVG1SyI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 14:54:08 -0400
To: git@vger.kernel.org
User-Agent: KMail/1.8.1
In-Reply-To: <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 28 July 2005 17:56, Johannes Schindelin wrote:
> localhead=remotehead. BTW, this whole multihead mess applies only to Jeffs
> anyway :-)

GIT/Cogito usage is not about linux kernel only.
I actually try to work with a scenario for a project with a few developers, 
where each one should have its branch(es) in the central repository. I think 
this could be quite common among future GIT uses. I even would allow the few 
developers to merge into the central master.

> I just do not see a high demand for mappings of remote and local HEAD
> names, but rather a high potential of making mistakes (after all, it is
> not the machine which makes mistakes, it's the human operator).

I also think it is quite confusing to have different branch names for the same 
head in cloned repositories.

But I also think that Paskys scenario is real, where you want to pull branches 
in 2 remote repositories with the same name.

So why not put the name of the remote repository into the local branch name?
A remote branch "host1:path#branch1" could be named "host1:path#branch1".
The shorthand specified with "cg-add-branch" would be a local alias, i.e.
	(cd .git/refs/heads; ln -s host1:path#branch1 mylocalalias)

I even would find it handy to be able to say
	cg-pull host1:path#branch1
, and
	cg-push mylocalbranch host2:path#branch2
should create the alias "mylocalbranch"="host2:path#branch2"
and create a entry in .git/branches.

Josef
