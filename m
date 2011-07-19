From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Re: How to push the very last modification only ?
Date: Tue, 19 Jul 2011 11:37:58 +0530
Message-ID: <20110719113758.3099f220@shiva.selfip.org>
References: <20110718131730.4898ddaf@shiva.selfip.org>
	<4E23F5CB.3090009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 08:07:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qj3TK-00088l-Bj
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 08:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab1GSGHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 02:07:53 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:46760
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751645Ab1GSGHw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2011 02:07:52 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 8656E3804001;
	Tue, 19 Jul 2011 08:07:50 +0200 (CEST)
In-Reply-To: <4E23F5CB.3090009@gmail.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177437>

On Mon, 18 Jul 2011 20:58:51 +1200
Chris Packham <judge.packham@gmail.com> wrote:

> Hi,
> 
> On 18/07/11 19:47, J. Bakshi wrote:
> > Hello list,
> > 
> > I have found that during push, all local commit goes into the git 
> > server.
> 
> Yes that's the normal behaviour. When you think about what push is doing
> it's trying to make the remote branch the same as your local branch.
> 
> > Where I like to only push the very last modification with
> > a meaningful comment which will be available at the git server. How
> > can I then push only the last modified one ?
> 
> This is easily doable. What you need to do is prepare a branch that you
> do want to push. Something like this, assuming that your current branch
> is 'master' and you want to push to origin/master:
> 
>   # first create temporary a branch to use while you're delivering
>   git checkout -b delivery origin/master
> 
>   # now cherry pick the commits you do want to push. I usually use
>   # gitk and cherry-pick from the right-click menu, but for simplicity
>   # I'll use git cherry-pick here.
>   git cherry-pick master
>   # you can provide a commit id instead of 'master'.
> 
>   # at this point you could also use git commit --amend to add any
>   # final tweaks to the commit
> 
>   # check that your delivery branch is good using git log/gitk. Build,
>   # test, etc
> 
>   # now push it to your local delivery branch to the remote master
>   # branch
>   git push origin delivery:master
> 
>   # now do some cleanup
>   git checkout master
>   git branch -d delivery
>   git rebase origin/master
> 
> 

It works !! Many many thanks :-)
