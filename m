From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn, remote tracking branch question
Date: Tue, 27 Mar 2007 15:00:15 -0700
Message-ID: <20070327220015.GA16344@untitled>
References: <m2ps6usa9o.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 00:00:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWJiK-0000kc-39
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 00:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934005AbXC0WAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 18:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934209AbXC0WAU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 18:00:20 -0400
Received: from hand.yhbt.net ([66.150.188.102]:45502 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934005AbXC0WAT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 18:00:19 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 45E312DC01A;
	Tue, 27 Mar 2007 15:00:16 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 27 Mar 2007 15:00:15 -0700
Content-Disposition: inline
In-Reply-To: <m2ps6usa9o.fsf@ziti.fhcrc.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43311>

Seth Falcon <sethfalcon@gmail.com> wrote:
> Hi,
> 
> I've edited my <repos>/.git/config file so that git-svn is tracking
> the main devel line as well as a release branch of a project.  This
> seems to work well.
> 
> So I have:
> 
> [svn-remote "svn"]
> 	url = https://svn.url.com/root
> 	fetch = branches/release-2-5:refs/remotes/2.5
> 	fetch = trunk:refs/remotes/git-svn
> 
> I can checkout the 2.5 release branch like this:
> 
>    git checkout -b 2.5 remotes/2.5
> 
> But at this point, how do I ask git-svn to update it?  When working on
> the devel line, I can do 'git svn rebase' and I would like to do the
> same thing but relative to the branch.
> 
> Perhaps there is some config I can add so that I don't have to do:
> 
>    git svn fetch
>    git rebase remotes/2.5
> 
> That isn't so bad except for having to remember where you are...

'git svn rebase' should be capable auto-discovering the remote ref that
you last branched from.  I'm not sure if the '2.5' that's common in the
remote ref and your local branch would cause ambiguity, however...

I'll look into this more when/if I have time tonight.

-- 
Eric Wong
