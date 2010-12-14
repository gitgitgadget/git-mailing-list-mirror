From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: Revert-style merge/Working tree-only checkout?
Date: Tue, 14 Dec 2010 08:36:20 -0600
Message-ID: <ie7veg$ks5$1@dough.gmane.org>
References: <AANLkTi=ioX25aqXg-yWDA0oXBTATkFe+J25g-dB7-psS@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 15:37:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSW0M-0001qm-Is
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 15:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501Ab0LNOhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 09:37:21 -0500
Received: from lo.gmane.org ([80.91.229.12]:44200 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754849Ab0LNOhU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 09:37:20 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PSW0F-0001nj-6E
	for git@vger.kernel.org; Tue, 14 Dec 2010 15:37:19 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 15:37:19 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 15:37:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163649>


"Yuriy Romanenko" <groman@gmail.com> wrote in message 
news:AANLkTi=ioX25aqXg-yWDA0oXBTATkFe+J25g-dB7-psS@mail.gmail.com...
> Hello,
>
> I am somewhat new to Git and I keep running into having to accomplish
> a certain task and reading through the documentation I can't seem to
> find any way of doing this easily.
>
> The problem is when branches diverge and I want to sync a branch to
> another branch with full overwrite, but maintain history and maintain
> separate branches.
>
> For example, say there is a branch "master" and I create a branch "b1"
> from master at some point. After this, there are 5 commits
> (C1,C2,C3,C4,C5) to master and
> 17 commits to b1 (let's call them cb1, cb2, cb3, ..., cb17). Say I
> want to create an 18-th commit to "b1" that makes it identical to the
> C5 (current) state of master. Essentially a single commit wipe of
> changes cb1 -> cb17 as well as application of C1->C5. So far I have
> found one way of accomplishing this, but it is difficult, error prone,
> slow and I just plain don't like it. I feel like there should be an
> easier way.
>
> What I currently do:
>
> $ rm -rf *
> $ git checkout -f master
> $ tar -cvzf /tmp/master.tar.gz *
> $ git checkout b1
> $ rm -rf *
> $ tar -xvzf /tmp/master.tar.gz
> $ git add
> $ git commit -a
> $ git merge master
>
>
> I've considered doing something like the following
>
> $ git checkout b1
> $ git revert b1~17..b1
> $ git merge master
>
> but it also seems wrong, and requires me to count the submits by hand,
> which seems silly --> I'm not actually reverting anything. I don't
> know if this would even work.
>
>
> Any suggestions on how to accomplish this easier? Some sort of a
> force-checkout that affects working tree only but not the index?
>
Have you looked at the vendor branch methodology in the git-rm manpage?   It 
may give you some ideas you're interested in.

v/r,
Neal 
