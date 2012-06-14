From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Git rebase basics
Date: Wed, 13 Jun 2012 21:39:03 -0700
Message-ID: <CAE1pOi3uXHcXm=fpH-e6pHyBTAACS7=KkdR9jQEuEjzoXy1w=A@mail.gmail.com>
References: <1339621152946-7561468.post@n2.nabble.com> <1339642794317-7561489.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: lancelyons <llyons2@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 14 06:39:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf1qC-00077S-J6
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 06:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208Ab2FNEjZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 00:39:25 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36065 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab2FNEjY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2012 00:39:24 -0400
Received: by yenl2 with SMTP id l2so607540yen.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 21:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=F8KM5i0hTlnWxW1p8Z0wDx1D7g1uDRPBQnzl33xnhTI=;
        b=Ibec5oQGd87NpmQLQoark2CAyqn91s4XAnXtF/lZnlQKtXto4NkmdL3R2afO8kEbu8
         ZFvnYfdwaIKzqaBRBTax3s/PH7muWLX1kkFSxJStJjYX9NM4EtqE2CEiQZG3S4Pg5QkV
         my7rkifW2SF+hx4OIKt80VPdcUVW+zv9RisnO0VmrD0t4iTdhnt8Qq2dX9Exzc+Ckxwz
         3trzNUHkEZQrKgLVKK6XhrBvxjV2TZT77P9IJVC6yiWS8lug2uGJXwNp2hfEdiLYTJM6
         qUuPkj2kTEIjNkLcK84pdteDcLhmx9lKCrk3CAg01eqPSiDNV5y5mGHZY+uDNqnqmVKK
         2M7g==
Received: by 10.101.134.6 with SMTP id l6mr165738ann.21.1339648763693; Wed, 13
 Jun 2012 21:39:23 -0700 (PDT)
Received: by 10.236.29.230 with HTTP; Wed, 13 Jun 2012 21:39:03 -0700 (PDT)
In-Reply-To: <1339642794317-7561489.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199967>

On 13 June 2012 19:59, lancelyons <llyons2@cox.net> wrote:
> Sorry about that.. I thought I was being pretty descriptive but maybe=
 I
> missed something.

Perhaps "descriptive" but certainly not "precise".

> After we setup Git (msysgit) and set it up using Apache with active
> directory authentication, I added a repository using git init --bare =
then I
> copied my files I wanted to add to the repository and did a git add .=
 and
> git commit -a
>
> So that all worked. =C2=A0 We have done several clones using git clon=
e with this
> remote repo. =C2=A0We have also done =C2=A0git push and git pull to v=
erify everything
> is working ok. =C2=A0 Everything was working fine.
>
> So back to my original train of though.
>
> I am trying to learn more about rebase so i have cloned the central r=
epo two
> times =C2=A0(I call the central repo the origin) doing the following =
(to help you
> understand)
>
> git clone https://servername:port/repopath c:\clonedrepo1
>
> git clone https://servername:port/repopath c:\clonedrepo2
>
> and then made changes to this cloned copy (clonedrepo1) and pushed tw=
o
> commits back to origin.
> (git commit -a =C2=A0two times)
>
> so now I have the following in the remote repo (origin)
>
> origin --> =C2=A0C1 --> C2
>
> (Note to help you understand =C2=A0C1 =3D commit 1 and c2 =3D commit =
2, etc)
>
> In the other cloned copy (clonedrepo2), which I consider a branch, I =
have
> made two more commits =C2=A0C3 and C4
>
> clonedrepo2 --> C3 --> =C2=A0C4
>
> I am able to easily pull from origin to get my clonedrepo2 to look li=
ke
> clonerepo2 --> C3 --> C4 --> C1 --> C2 using git pull origin =C2=A0or=
 git pull
> https://servername:port/repopath
>
> however I was wanting to rebase the clonedrepo2 branch so that it sho=
ws
> clonerepo2 -> C1 --> C2 --> C3 --> C4
>
> In other words I am wanting to rebase clonedrepo2 to the master of th=
e
> origin.

What you want is "git pull --rebase origin master". See "git help
pull". Also check "git help fetch" if you really want to keep doing
this.

But it sounds like you should simply be using a real branch. You can
do "git pull" on your master branch and then run "git rebase master"
on your own branch. Did you really read up on Git? It has truly
excellent documentation. See for example http://git-scm.com/book (but
this is just one of many).

> I thought the command to do this was =C2=A0 git rebase origin master =
but that
> doesnt work and I get
>
> C:\clonedrepo2>git rebase origin master
> Switched to branch 'master'
> Your branch is ahead of 'origin/master' by 2 commits.
> Current branch master is up to date.
>
> I know my my branch is ahead by c3 and c4 but it does not have C1 and=
 C2
>
> Thoughts.
>
> --
> View this message in context: http://git.661346.n2.nabble.com/Git-reb=
ase-basics-tp7561468p7561489.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
