From: Matthieu Stigler <matthieu.stigler@gmail.com>
Subject: How to push properly a la subversion
Date: Thu, 30 Jul 2009 12:11:08 +0200
Message-ID: <111060c20907300311g2f8423b0w656928c8ef3e3979@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>, apenwarr@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 12:11:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWSbX-0000yF-3t
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 12:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbZG3KLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jul 2009 06:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbZG3KLK
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 06:11:10 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:45959 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbZG3KLJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2009 06:11:09 -0400
Received: by fxm28 with SMTP id 28so526872fxm.17
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=yopMJUGCaYkvRK18cByo/wBA5BgSE3zAOeAF0RjInWM=;
        b=WzM4FKZEiWQ3s6Y1h2PuxOeidNohMlcGoa4dE2cyaAPFdzOPy6DLhEU6eriKFMjb7X
         jVbiTfmUi5KX4E2ubSOp33AyNV7deo6KmWRSkHWVGyvmcdeqFCZs4BaLItPkWVLiZxNz
         1yrpewL8QbXNE5WdpiDkjMyYvOgM9qT+nUzl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=h4Om4em3hM2pLAGCfa94S9luDisk6rDIutg8QVx/RO/Nk3XuiXLkRaXlRkkqPV/m4L
         vPKpLpiK90ltgIPq1/puzg02+P+lvORp+XGlGRLMOHRpdF360uURkChrcl/Yv9kVoHRc
         p34i9PDGhMua9dZXVfVIeDMfNpv6Ej5qG72ks=
Received: by 10.103.6.5 with SMTP id j5mr564650mui.46.1248948668138; Thu, 30 
	Jul 2009 03:11:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124457>

Hi

Thanks Dmitiri and Avery for your help and advices! I could understand
a little bit better, but I'm still confused. Actually what I did not
mention is that we are working on windows (actually 2000 and soon
vista :-(). The institute have a big programming project and I try to
introduce version control hopefully with git. The project is now
stored in a shared disk and there are no security/permissions issues
(every body is allowed to erase it basically:-(). Furthermore, there
are reluctant to install any new softwares and to use command line
software, I used for now portable GIT on windows, which seems to have
also ssh.

So I understood that I need to set-up a shared repo, thanks for your
advices! Now do I really need all those permissions issues? What is
the simplest way to deal with that?

I looked at http://toolmantim.com/articles/setting_up_a_new_remote_git_=
repository
but I'm stuck with first command:
ssh myserver.com

Does that need I should have previously set-up a ssh server? Is this a
necessary step?


In my case, the shared disk is say: T:\project\gitrepo
How should I do?

The second line in the tuto mentions:

mkdir /var/git/myapp.git && cd /var/git/myapp.git
Here /var is linux specific...
Is it any directory that is concerned or is it required to be in /var?
How do I set-it up in windows?


=46inally, should I rather use something like Putty on windows?

Thank you so much for your precious help, I'm just discovering git...

Matthieu
2009/7/29 Dmitry Potapov <dpotapov@gmail.com>
On Wed, Jul 29, 2009 at 08:32:46PM +0200, Matthieu Stigler wrote:
>
> I tried just by cloning A to B, changing/commiting B and the pushing =
to
> A but: then on A the last log is integrated but I have this message w=
ith
> gitk "local changes checked in to index but not commited", and those
> local =A0changes are actually the version of A before the commit from=
 B
> :-( What I expected with svn mentality is that A is changed and
> updated...

This is because git-push does not change your working tree. So, your
normally should never push to the branch that is currerently checked
out. (New versions of Git will warn you about that). As to having a
common/shared repo, it should be a "bare" repository.

>
> Should I enter a specifical push option? Or rather work on section
> "Setting up a shared repository"? in
> http://www.kernel.org/pub/software/scm/git/docs/gitcvs-migration.html=
 ?
> I tried to do it entering:
>
> $ mkdir /pub/my-repo.git
> $ cd /pub/my-repo.git
> $ git --bare init --shared
> $ git --bare fetch /home/alice/myproject master:master
>
> but then I get also this message "local changes checked in to index b=
ut
> not commited" and especially there are many git files appearing that =
we
> would not want to see....

Strange... The above commands work perfectly for me.... And if you have
a bare repo then it should not have 'index'. So, the error does not mak=
e
much sense to me... Is it produced by gitk? Hmm, maybe some old version
of gitk did not work correctly with a bare repo... I dunno...

> And furthermore it seems there are complicated
> permissions/ssh issues that I don't need (I'm doing for now only
> locally).

I don't understand your troubles with permissions. Basically, there are
two options to setup a shared repo:
1. where every developer has each own account
2. a single account (but still each has each own ssh key)

The 'shared' option during init is necessary only for the first case to
make repository group writable. All users who can push to it should be
members of the group.

If you want to have a single system account for all users, you have two
options:
- gitosis
- ssh based authentification with forced command and then update hook
=A0if extra check is needed (see Documentation/howto/update-
>
> hook-example.txt)
>
>
> Dmitry
