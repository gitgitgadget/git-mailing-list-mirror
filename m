From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 08:52:15 +0000 (UTC)
Message-ID: <loom.20080823T084556-260@post.gmane.org>
References: <20080822174655.GP23334@one.firstfloor.org> <32541b130808221056l75a3fd6bsa6c7933a1c3da60f@mail.gmail.com> <20080822183129.GR23334@one.firstfloor.org> <m37ia8sv49.fsf@localhost.localdomain> <20080823071552.GU23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 10:56:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWouq-0001EG-Kn
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbYHWIzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 04:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbYHWIzI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:55:08 -0400
Received: from main.gmane.org ([80.91.229.2]:40975 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbYHWIzG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:55:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KWoti-0002iP-BG
	for git@vger.kernel.org; Sat, 23 Aug 2008 08:55:02 +0000
Received: from host63-75-dynamic.4-87-r.retail.telecomitalia.it ([87.4.75.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 08:55:02 +0000
Received: from paolo.ciarrocchi by host63-75-dynamic.4-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 08:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.4.75.63 (Mozilla/5.0 (X11; U; Linux i686; en; rv:1.8.1.16) Gecko/20080715 Epiphany/2.20 Firefox/2.0.0.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93444>

Andi Kleen <andi <at> firstfloor.org> writes:

> 
> >   $ git remote update
> >   $ git reset --hard origin/master  # when on master
> > 
> > BTW. it is stated countless time in documentation that published
> > history should be not rebased, barring some extenuating circumstances
> 
> Yes and people countless times ignore that recommendation and do 
> it anyways (for good reasons).  And then other users 
> have to deal with these rebased trees somehow.
> 
> Anyways it is all solvable but right now ill supported
> in standard commands and the documentation does not really
> cover it. I was just asking (mostly for others to avoid
> going through the same pain as me) for that to be improved
> so that git becomes easier to use.
> 
> Sadly you guys don't even seem to want to recognize there
> is a problem  

Why are you saying so?

You now understand that your script:
git fetch origin
git fetch --tags origin
git remote update
git checkout master
git reset --hard origin/master

it's far from being perfect, right?

git remote update is going to update all the remotes so you don't need the two
git fetch command.

Furthermore, I just tried what was suggested in this thread:
paolo@paolo-desktop:~/linux.trees.git$ git pull --rebase
remote: Counting objects: 7867, done.
remote: Compressing objects: 100% (1868/1868), done.
remote: Total 5125 (delta 4373), reused 3839 (delta 3246)
Receiving objects: 100% (5125/5125), 870.73 KiB | 187 KiB/s, done.
Resolving deltas: 100% (4373/4373), completed with 942 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip
 + dff643a...f8fcb0d auto-core-next -> tip/auto-core-next  (forced update)
   b635ace..6a55617  auto-core-next-base -> tip/auto-core-next-base
   b635ace..6a55617  auto-cpus4096-next -> tip/auto-cpus4096-next
   b635ace..6a55617  auto-cpus4096-next-base -> tip/auto-cpus4096-next-base
 + 1f1fccc...696f6d1 auto-fastboot-next -> tip/auto-fastboot-next  (forced update)
   b635ace..6a55617  auto-fastboot-next-base -> tip/auto-fastboot-next-base
 + cdca408...06d0224 auto-ftrace-next -> tip/auto-ftrace-next  (forced update)
   b635ace..6a55617  auto-ftrace-next-base -> tip/auto-ftrace-next-base
   b635ace..6a55617  auto-generic-ipi-next -> tip/auto-generic-ipi-next
[...]

A nice single command that seems to achive your needs.


Ciao,
             Paolo
