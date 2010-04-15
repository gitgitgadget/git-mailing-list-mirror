From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Lost a week?
Date: Thu, 15 Apr 2010 16:11:56 +0200
Message-ID: <4BC71EAC.8050602@drmicha.warpmail.net>
References: <t2s62a3a9cb1004150657g5baabb42o512e0e103d1e9596@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Grace <negativeview@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 16:15:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2PqV-0007ow-Px
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 16:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066Ab0DOOO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 10:14:58 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49082 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753817Ab0DOOO6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 10:14:58 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AC0CAEB852;
	Thu, 15 Apr 2010 10:14:57 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 15 Apr 2010 10:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=9gF8QJeZ7T950ArnGpkIz7qg0j4=; b=tU4AFKPkGsVVG8eWuk8uDil3Lz9MNX5SsseUNhc+xHyoRzggq/swO0CJXxSlxlDjnKDEC9sZFjV7/C8OTtQKdj/iAJjPtyW8LY4UFBD4WE7lgJJ5g24zcZ7qnmWXCn6NJr3kr2PjXmroUhhVOFLq963Panmzi8xv4xEaxsNK7yo=
X-Sasl-enc: MxiCD7TymzHa8BsDex2VXkw0pGUjzIm7m2aFdRIikej4 1271340897
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1F07C4587E;
	Thu, 15 Apr 2010 10:14:57 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <t2s62a3a9cb1004150657g5baabb42o512e0e103d1e9596@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144987>

Daniel Grace venit, vidit, dixit 15.04.2010 15:57:
> Appologies for not having more information. I usually use git as if
> it's just SVN with non-network checkins.
> 
> A few days ago, I pushed my git repository to github:
> 
> 127  git remote add github
> git@github.com:negativeview/Wherespresso.git [Note, this is a private
> repo]
> 128  git push github master
> 
> I then went about doing real-world business. I noticed at some point
> that when I did a `git status` it said that no branches were checked
> out. I don't remember doing anything between pushing to github and
> this state. If I did a git branch it shows something like * (no
> branch) then below that, master. I shrugged it off and did what I
> expected to fix that odd issue:
> 
> 515  git branch
> 516  git checkout master
> 
> Now, the next day, I noticed that I have no git history between the
> 6th and something I did soon after the git checkout master:
> 
> $ git log | grep Date | head -n 5
> Date:   Wed Apr 14 14:43:58 2010 -0500
> Date:   Tue Apr 6 00:42:20 2010 -0500
> Date:   Mon Apr 5 23:57:54 2010 -0500
> Date:   Mon Apr 5 07:01:26 2010 -0500
> Date:   Mon Apr 5 06:17:18 2010 -0500
> 
> github shows the same. I KNOW that there were commits (representing a
> good bit of work) in that time. I'm sure that it's *somewhere* but I'm
> at a complete loss as to where it is. gitk shows no side branches (nor
> does git branch). I don't use branches really, as much as I know that
> I should.
> 
> Daniel
> http://www.doomstick.com

Backup now.

Most probably, you've made those commits on a detached HEAD. May you
have checked out a remote branch, or a specific commit, before you went
about your business on or after 6th?

git reflog (or git log -g) will be able to show you the history of your
HEAD before you lost it ;)

Then you can tag those commits or 'checkout -b safehaven
nameofthetopcommit' to get a branch with those commits. Now they are
safe from being pruned during garbage collection.

Michael
