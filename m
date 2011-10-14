From: P Rouleau <prouleau72@gmail.com>
Subject: Re: Git shouldn't allow to push a new branch called HEAD
Date: Fri, 14 Oct 2011 23:00:04 +0000 (UTC)
Message-ID: <loom.20111015T004856-72@post.gmane.org>
References: <1318591877.2938.20.camel@mastroc3.mobc3.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 01:00:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REqk0-00034Y-Sy
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 01:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430Ab1JNXAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 19:00:22 -0400
Received: from lo.gmane.org ([80.91.229.12]:39864 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757081Ab1JNXAV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 19:00:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1REqjh-0002w5-G9
	for git@vger.kernel.org; Sat, 15 Oct 2011 01:00:17 +0200
Received: from modemcable176.18-203-24.mc.videotron.ca ([24.203.18.176])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 01:00:17 +0200
Received: from prouleau72 by modemcable176.18-203-24.mc.videotron.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 01:00:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.203.18.176 (Opera/9.80 (Windows NT 6.0; U; en) Presto/2.9.168 Version/11.51)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183629>

Daniele Segato <daniele.segato <at> gmail.com> writes:

> 
> Hi all,
> 
> following from a discussion in IRC freenode #git between me, sitaram an
> shruggar
> 
> step to reproduce:
> 
> $ # time to create the remote HEAD branch
> $ cd buggenerator/
> $ git push origin HEAD:HEAD
> 
> But I think that git shouldn't allow the remote HEAD reference to be
> created in the first place

Maybe git should also refuse to create a local branch named HEAD. I made a
mistake recently where I used something likes this:

for B in $(git branch -a|grep "remotes/origin/"); do git co -t $B ; done

After that, git st was giving a warning about an ambiguous HEAD ref. Hopefully,
a simple "git branch -d HEAD" fixed it once I found the problem.

P.Rouleau
