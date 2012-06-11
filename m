From: konglu@minatec.inpg.fr
Subject: Re: Help understanding git checkout behavior
Date: Mon, 11 Jun 2012 20:21:32 +0200
Message-ID: <20120611202132.Horde.dPo1XHwdC4BP1jcsTvSBaFA@webmail.minatec.grenoble-inp.fr>
References: <CAMUXYmUFbixgA1bVMA46Zzjed1Dwmjv54kWWXyjsuyu904GpTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Renato Neves <nevrenato@gmail.com>
To: =?iso-8859-1?b?Q2zhdWRpbyA=?= =?iso-8859-1?b?TG91cmVu528=?= 
	<pt.smooke@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 20:21:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9FE-0007L3-NJ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab2FKSVh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 14:21:37 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:48832 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751456Ab2FKSVg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 14:21:36 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id D02B11A0241;
	Mon, 11 Jun 2012 20:21:32 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Mon, 11 Jun
 2012 20:21:32 +0200
In-Reply-To: <CAMUXYmUFbixgA1bVMA46Zzjed1Dwmjv54kWWXyjsuyu904GpTA@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199690>


Cl=E1udio Louren=E7o <pt.smooke@gmail.com> a =E9crit=A0:

> The project was going pretty fine, till we start modeling the=A0check=
out
> operation. We are with some problems finding useful information about
> the properties that have to be satisfied when the "git=A0checkout" is
> performed. We have concluded that if everything that is on index is
> commited then we have no problems making=A0checkout.
> The problem is when we have something on index that is not updated
> with the last commit. We cannot find a general property that says whe=
n
> checkout can be performed. We have even found some files that are
> lost, like in this case:
>
> smooke =A0teste $ git init
> Initialized empty Git repository in /home/smooke/Dropbox/teste/.git/
> smooke =A0teste $ touch f
> smooke =A0teste $ echo a > f
> smooke =A0teste $ git add f
> smooke =A0teste $ git commit -m 'first commit'
> [master (root-commit) dab04b9] first commit
> =A01 files changed, 1 insertions(+), 0 deletions(-)
> =A0create mode 100644 f
> smooke =A0teste $ git branch b
> smooke =A0teste $ touch something
> smooke =A0teste $ echo b > something
> smooke =A0teste $ git add something
> smooke =A0teste $ git commit -m 'something added'
> [master 9f2b8ad] something added
> =A01 files changed, 1 insertions(+), 0 deletions(-)
> =A0create mode 100644 something
> smooke =A0teste $ git rm something
> rm 'something'
> smooke =A0teste $ mkdir something
> smooke =A0teste $ cd something/
> smooke =A0something $ touch f1
> smooke =A0something $ echo c > f1
> smooke =A0something $ cd ..
> smooke =A0teste $ git add something/f1
> smooke =A0teste $ git checkout b
> Switched to branch 'b'
> smooke =A0teste $ ls
> f
> smooke =A0teste $ git checkout master
> Switched to branch 'master'
> smooke =A0teste $ ls
> f =A0something
> smooke =A0teste $ cat something
> b

What do you mean by "lost files" ? Are you talking about "something"
that doesn't appear on branch 'b' ?
