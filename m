From: "Steve French" <smfrench@gmail.com>
Subject: Re: CIFS fixes
Date: Sun, 11 May 2008 12:48:10 -0500
Message-ID: <524f69650805111048v6033c2eajb7cc22b9c4fa6bc0@mail.gmail.com>
References: <524f69650805082054g43823f85i623cb2c11cd01039@mail.gmail.com>
	 <alpine.LFD.1.10.0805090810390.3142@woody.linux-foundation.org>
	 <524f69650805110942k7ccb065bm2c1e60f1a509af5a@mail.gmail.com>
	 <alpine.LFD.1.10.0805110948530.3330@woody.linux-foundation.org>
	 <524f69650805110953t6561ff84t1867681bea093d35@mail.gmail.com>
	 <alpine.LFD.1.10.0805110957530.3330@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 11 19:49:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvFfT-0002x7-Ta
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 19:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959AbYEKRsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 13:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754712AbYEKRsO
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 13:48:14 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:51505 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670AbYEKRsN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 13:48:13 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1712863fkq.5
        for <git@vger.kernel.org>; Sun, 11 May 2008 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=czWc5a8OGJToMoqzLzx2Cdj7eNjP4RGVFldrOIIarAU=;
        b=IeBcdPk5Evu4iYqWKsTF+4D3tsbJr5DjLMsKhO8p2rLefcXVaWCJgS88ZUwfgg3mGawjl3TKAl45k3Fd3V5/YA1qosGOP1NtsYkz9uwzmub+gR/SYKC6pPlvW8PILSEebhXEitCG444Bh7DknqrxQ+SrAfUJNPqS+g3pOGpN5uA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ekTg/2pjixaM+gLe6GqXgcbm8bj43RZo/7yVxXQ6SHOroJGxiYr4B4v5kAqsKq7Q/x/R0bih/KGDaELUOJiV4iBcg4ZKW2oC4q5Vp9ml/K0wyhkXPSPwSa7jc1W5Fkivnh9WmEnqrvZxXEn5GJAd/57R9pX2mtcBYqYtRUR913s=
Received: by 10.78.150.7 with SMTP id x7mr1714719hud.41.1210528090325;
        Sun, 11 May 2008 10:48:10 -0700 (PDT)
Received: by 10.78.141.1 with HTTP; Sun, 11 May 2008 10:48:10 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0805110957530.3330@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81804>

The rebase did fix up the obsolete commits ... but I still get the
"warn: No branch of ..." message.  I think that will go away when
there is another newer commit  in your tree.  It doesn't seem to be a
problem - the list of commits is right.  See below:


[sfrench@hera cifs-2.6]$ git fetch
remote: Counting objects: 1627, done.
remote: Compressing objects: 100% (178/178), done.
remote: Total 1097 (delta 927), reused 1087 (delta 919)
Receiving objects: 100% (1097/1097), 167.04 KiB, done.
Resolving deltas: 100% (927/927), completed with 285 local objects.
From /pub/scm/linux/kernel/git/torvalds/linux-2.6
   28a4acb..5bb7ff7  master     -> origin/master
[sfrench@hera cifs-2.6]$ git rebase origin
First, rewinding head to replay your work on top of it...
HEAD is now at 5bb7ff7 Merge master.kernel.org:/home/rmk/linux-2.6-arm
Applying [CIFS] cifs_find_tcp_session cleanup
Applying [CIFS]  add local struct inode pointer to cifs_setattr
Applying [CIFS] when not using unix extensions, check for and set
ATTR_READONLY on create and mkdir
Applying [CIFS] don't allow demultiplex thread to exit until
kthread_stop is called
[sfrench@hera cifs-2.6]$ git-request-pull origin
git://git.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git
warn: No branch of
git://git.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git is
at:
warn:   e691b9d: [CIFS] don't allow demultiplex thread to exit until
kthread_stop is called
warn: Are you sure you pushed HEAD there?


The following changes since commit 5bb7ff795fffc9418e3039cac77b42adcaae1a57:
  Linus Torvalds (1):
        Merge master.kernel.org:/home/rmk/linux-2.6-arm

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git
..BRANCH.NOT.VERIFIED..

Cyrill Gorcunov (1):
      [CIFS] cifs_find_tcp_session cleanup

Jeff Layton (2):
      [CIFS]  add local struct inode pointer to cifs_setattr
      [CIFS] when not using unix extensions, check for and set
ATTR_READONLY on create and mkdir

Steve French (1):
      [CIFS] don't allow demultiplex thread to exit until kthread_stop is called

 fs/cifs/cifspdu.h |    1 +
 fs/cifs/cifssmb.c |   16 ++++-------
 fs/cifs/connect.c |   79 +++++++++++++++++++++++++++--------------------------
 fs/cifs/dir.c     |   16 +++++++++--
 fs/cifs/inode.c   |   35 ++++++++++++++---------
 5 files changed, 81 insertions(+), 66 deletions(-)


On Sun, May 11, 2008 at 12:04 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
>  On Sun, 11 May 2008, Steve French wrote:
>  >
>
> > That is not what I meant.   I meant that since May 6th I only did one
>  > - and those messages still showed up.  So I just ran a git-rebase
>  > origin which removed them
>
>  You're doing something wrong then, and your rebased result is suspect.
>
>  Have you done a "git fetch" to fetch what is in my current tree? Because
>  if you haven't, then you're generating the "this is the new state" without
>  actually taking into account that the old state was already pulled!
>
>  And that *old* state contains those four merges that I got from your
>  previous pull request!
>
>  So now you likely rebased the commits that I already merged (again,
>  because you *think* they are just local to your branch, because you
>  haven't updated your origin reference point), and they are now duplicates
>  of something I already have (but with different commit ID's, since your
>  rebase has moved them around in the history).
>
>  So now, if I were to pull again, I'd just get the same commits all over
>  again, just as duplicates (plus any new ones, of course). Git would
>  probably merge it all fine - unless your new ones were to the same area as
>  the old ons, in which case it might be unhappy about the fact that both
>  branches changed things in the same area - but the history would be crud.
>
>  In other words: you *must*not* rebase stuff that you have already
>  publicized. That just creates problems.
>
>  The good news is that you can most likely fix it all up by just doing
>
>         git fetch
>         git rebase origin
>
>  because now the *new* rebase will try to rebase it all over again, but now
>  it will see that I already merged the old ones, so the rebase will just
>  skip those commits, and you should have only the *real* new ones pending
>  again.
>
>                 Linus
>



-- 
Thanks,

Steve
