From: Hong-Ming Su <halleyinvent@gmail.com>
Subject: Re: How to make "git push/pull" work in non-clone repo?
Date: Fri, 4 Nov 2011 00:10:27 +0800
Message-ID: <CANiMyiF=C_uBXf3kV8ix=CY9Mi=cxHU-J3dn5UyJ87gu3Sm0dg@mail.gmail.com>
References: <CANiMyiFfiLnK8-q7vTZ9VAtkW8ip2NQfpR4iaU2oSnnonVDuUA@mail.gmail.com>
	<F802D297-95A0-4B1E-894D-9681E0EEF3AD@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 17:10:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLzsA-0006hU-FQ
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 17:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933849Ab1KCQK3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 12:10:29 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51382 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933820Ab1KCQK3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2011 12:10:29 -0400
Received: by eye27 with SMTP id 27so1276483eye.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8P3KC39VaZ03hpJ5OobVjEKhGTikK6LjfBP9Zt+R/io=;
        b=X+RMkUltkroJNIdVO/gj20QqhIvQjYEEk3iAZlRQQfED4Fx1duu+pmI9Cyy3Cf44Zf
         68evoj3R1FGDyXV8UHUTIJ7Ew6g2l93+1tLitiKrWGXuMy5P5QzmK/chr9fCbVUdkMWH
         K/Da7HxhYRc6O2K/CQ7W5ltTUUo+zVuXmtXn8=
Received: by 10.14.15.195 with SMTP id f43mr963206eef.233.1320336627904; Thu,
 03 Nov 2011 09:10:27 -0700 (PDT)
Received: by 10.14.127.4 with HTTP; Thu, 3 Nov 2011 09:10:27 -0700 (PDT)
In-Reply-To: <F802D297-95A0-4B1E-894D-9681E0EEF3AD@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184726>

Thank for your hints. I get "git push" work. The "git pull" need argume=
nt.

/d/workspace/git
$ ls
depot  work1  work2

/d/workspace/git
$ git clone --bare work1 depot
Cloning into bare repository depot...
done.

/d/workspace/git/work1 (master)
$ git push
fatal: No destination configured to push to.

/d/workspace/git/work1 (master)
$ git pull
fatal: No remote repository specified.  Please, specify either a URL or=
 a
remote name from which new revisions should be fetched.

/d/workspace/git/work1 (master)
$ git remote add origin ../depot

/d/workspace/git/work1 (master)
$ git push
Everything up-to-date

/d/workspace/git/work1 (master)
$ git pull
=46rom ../depot
 * [new branch]      master     -> origin/master
You asked me to pull without telling me which branch you
want to merge with, and 'branch.master.merge' in
your configuration file does not tell me, either. Please
specify which branch you want to use on the command line and
try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details.

If you often merge with the same branch, you may want to
use something like the following in your configuration file:

    [branch "master"]
    remote =3D <nickname>
    merge =3D <remote-ref>

    [remote "<nickname>"]
    url =3D <url>
    fetch =3D <refspec>

/d/workspace/git/work1 (master)
$ git pull origin master:master
Already up-to-date.
2011/11/4 Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>:
>
>
> 03.11.2011, =D7 17:59, Hong-Ming Su:
>
>> I create a repo X with git init. After several commit in X, I clone =
a
>> bare repo Y from X.
>> I try to continue work in X, and push to/pull from Y. The command gi=
t
>> push and git pull fails. I see the error message but I do not know
>> which git command can fix that problem.
>> Then I clone Z from Y. git push/pull works in Z.
>> How to make "git push/pull" the same in X as in Z?
>>
>
>
> By cloning Y from X you made X to be a parent of Y while you need vic=
e versa.
> To fix this add Y as a remote to X and set up tracking for you master=
 branch.
>
> By the way, in such cases you'd better write commands you've executed=
, and the error report you've got.
> " I see the error message but I do not know which git command can fix=
 that problem" - this is zero of useful information.
>
> ----------------------------------
> Kirill Likhodedov
> JetBrains, Inc
> http://www.jetbrains.com
> "Develop with pleasure!"
>
>
