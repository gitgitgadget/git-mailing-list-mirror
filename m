From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: few questions from a git newbie
Date: Thu, 25 Feb 2010 21:35:38 +0100
Message-ID: <46d6db661002251235w2be39d11l5faa69a2bfddf653@mail.gmail.com>
References: <20100225202634.6a687a6c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Levente Kovacs <leventelist@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:35:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkkR2-0005Ex-R1
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 21:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933551Ab0BYUfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 15:35:43 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:49093 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933362Ab0BYUfm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 15:35:42 -0500
Received: by bwz1 with SMTP id 1so3218339bwz.21
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 12:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=xg7FyS5qVU5i2B2n1kavNA0X/4PNqWwCu9SoDaANPAA=;
        b=xPMGUhcUlgWZ4+HvtT+kzCAsP1oEqT8RlHStvCCpuwse+yU359G5k5eE+SA3ljm6wS
         sAb71ZDFx1Bul2sC9V4/H5lbujLvCYUxFW0rZJ+oF6RXWwdprpSZXbyuQpiFcCXzs5K4
         eRFjdNS8XbXKEYUTUGNk7Nr8Ro4C0mb2ddgOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XaT2hj+G5PtyYwiR9ANPcUuhxr8VSdxQnpbJruH5UWzwfeuXcaAdhxGIumOsRvU7uG
         bQAM67DWJjqutqw//8tYruEV6bPl4Puf1GYkK610fvaXFX0wqanBLLzolxXjtQIQnsjZ
         pMHlmicC4P9I6e0xiC0n5lNacUe5ccweViG/M=
Received: by 10.204.16.194 with SMTP id p2mr167183bka.32.1267130138999; Thu, 
	25 Feb 2010 12:35:38 -0800 (PST)
In-Reply-To: <20100225202634.6a687a6c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141069>

On Thu, Feb 25, 2010 at 8:26 PM, Levente Kovacs <leventelist@gmail.com> wrote:
> Hi,
>
>
> I am a git newbie, so forgive my ignorance.

We all started as padawans. :-)

> I've set up a working system with gitosis.

Gitosis has no commits since mid September 2009. I would suggest to
move to gitolite with a very easy setups, especially for newbies. I'll
actually answer more on the rest of your questions as if you would be
using gitolite and not gitosis.

>
> http://logonex.eu/git/
>
> Currently I can add a repository by doing the following
> stuff:
>
> edit gitosis.conf
>
> ssh git@server
> mkdir REPO.git
> cd REPO.git
> git --bare init
> exit

With gitolite, you clone the gitolite-admin on a remote machine, as
the user who has the admins ssh keys. Under the hood, you still
somehow do ssh, but with gitolite, all it takes is to edit
gitolite.conf, push your changes and the bare repo gets automatically
created on the server.

>
> git clone git@server:REPO.git
> cd REPO
> git remote add REPO git@server:REPO.git
> touch .gitignore
> git add .gitignore
> git commit -a
> git push origin master
>
> Is this flow is the "right way"? How can I add a repository without ssh'ing to
> the server?

If you cloned it, you should not need to add remotes. If you're a
newbie, I would suggest to use 'git gui' and 'gitk' until you're fully
familiar with the command line.

>
> Next question is about SVN.
>

I'll pass the rest of the email. Never got brainw@shed by SVN...

> How can I make gitosis to hide certain repositories?

You meant on your gitweb ? The first thing you need to do is actually
to secure your gitweb access. Back again to gitolite, a 'ssh gitolite
info' will actually tell you the repos you've access on only. So all
the rest of repos are hidden somehow. Keep in mind to remove gitweb if
you need hidden stuff.

Good luck.

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
