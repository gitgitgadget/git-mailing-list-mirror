From: <4jxDQ6FQee2H@dyweni.com>
Subject: Re: Git - Pushing to a production website
Date: Fri, 9 Jan 2009 23:30:37 -0600
Message-ID: <20090109233037.31198694@family.dyweni.com>
References: <20090109222344.3539138a@family.dyweni.com>
	<200901092238.06968.bss@iguanasuicide.net>
	<20090109224618.5d8c461c@family.dyweni.com>
	<200901092304.51986.bss@iguanasuicide.net>
Reply-To: 4jxDQ6FQee2H@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sat Jan 10 06:32:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLWS8-0006VL-AL
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 06:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbZAJFam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 00:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbZAJFam
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 00:30:42 -0500
Received: from pl1.haspere.com ([208.111.35.220]:52736 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbZAJFal (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 00:30:41 -0500
Received: from family.dyweni.com (173-23-155-27.client.mchsi.com [173.23.155.27])
	by pl1.haspere.com (Postfix) with ESMTPSA id 3EB55C800E;
	Fri,  9 Jan 2009 23:30:39 -0600 (CST)
In-Reply-To: <200901092304.51986.bss@iguanasuicide.net>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.12.11; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105077>

> > - Do a git pull  
> 
> I'm not enitirely sure you want post-update doing the pull.

Really?

Let's say the website lives in /srv/www/htdocs
Let's also say the git repository lives in /srv/www/git

All developers pull/push from /srv/www/git  (git@server:/srv/www/git)

The website is a clone of /srv/www/git and only tracks 'master'.
Post-update (simplified) changes to /srv/www/htdocs and does 'git pull'.

I'm referencing this article:
  http://jblevins.org/log/tools/managing-websites-with-git

Would you recommend a different way to automatically push any changes
to 'master' down to the website?



> 
> > - Then create a new branch 'working' and checkout
> > - Apply the patches to 'working' and commit
> >
> >This leaves 'working' == 'master^'  
> 
> Actually, it leaves HEAD == working and master == working^.

I'm sorry - I mixed up my terminology.

I am referring to the branch's log.

'working' has 1 more log entry than 'master'.

Example:
 - git log master | grep ^commit | tail -n 2 | head -n 1
 - git log working | grep ^commit | tail -n 1 | head -n 1

Both of these commands should return the same commit hash.
