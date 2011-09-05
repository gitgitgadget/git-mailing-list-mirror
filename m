From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: "Your local changes ... would be overwritten" bug
Date: Tue, 6 Sep 2011 09:37:17 +1000
Message-ID: <CAH5451kKVEjDjwJE8Htid8PQiuEv91r2VjXx-22o26Kx6xy11Q@mail.gmail.com>
References: <8362l73qi6.fsf@kalahari.s2.org>
	<vpqty8rx774.fsf@bauges.imag.fr>
	<87wrdmrgbs.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Vijay Lakshminarayanan <laksvij@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 01:37:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0ijK-0006Ie-J6
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 01:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176Ab1IEXhU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Sep 2011 19:37:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45719 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab1IEXhS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2011 19:37:18 -0400
Received: by fxh19 with SMTP id 19so4121047fxh.19
        for <git@vger.kernel.org>; Mon, 05 Sep 2011 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jz1OGZV31q/uHyAhlgrxfEwd4Asy351aSqvHx0ryrE4=;
        b=IfTIoG5zfTn7+HDxR0nOMbzaDXJRfeLBPZGYzy/ewEJDVwT7W/rV+uZ0pTXZZCH0CW
         kOVN16b0So6Y2qpYzZfOA6xGI0/vRP72iof/LN/wv4a87Jq5ZLjj3B+B42mGaBm4e1TP
         h1tfjSGP4MOjY+q9VUDQw4vMNxM4dVsR2YnYQ=
Received: by 10.223.51.216 with SMTP id e24mr1167354fag.105.1315265837511;
 Mon, 05 Sep 2011 16:37:17 -0700 (PDT)
Received: by 10.152.8.226 with HTTP; Mon, 5 Sep 2011 16:37:17 -0700 (PDT)
In-Reply-To: <87wrdmrgbs.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180766>

I can not reproduce on msysgit version 1.7.6.msysgit.0, for what it is =
worth.

Regards,

Andrew Ardill



On 6 September 2011 04:31, Vijay Lakshminarayanan <laksvij@gmail.com> w=
rote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Hannu Koivisto <azure@iki.fi> writes:
>>
>>> The following script can be used to reproduce the problem:
>>
>> [...]
>>
>> I cannot reproduce on Linux.
>
> I can't either.
>
>>> I'm running Cygwin git 1.7.5.1 in Windows XP.
>
> I'm running cygwin git 1.7.5.1 in Windows Vista.
>
> $ mkdir temp
> d temp
> git init
> echo foo > testfile
> git add testfile
> git commit -m "test1"
> echo foo > testfile2
> chmod +x testfile2
> git add testfile2
> git commit -m "test2"
> mkdir foo
> cd foo
> git co master~1
>
> vijay@balrog ~/foo
> $ cd temp
>
> vijay@balrog ~/foo/temp
> $ git init
> Initialized empty Git repository in /home/vijay/foo/temp/.git/
>
> vijay@balrog ~/foo/temp
> $ echo foo > testfile
>
> vijay@balrog ~/foo/temp
> $ git add testfile
>
> vijay@balrog ~/foo/temp
> $ git commit -m "test1"
> [master (root-commit) 7564449] test1
> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 testfile
>
> vijay@balrog ~/foo/temp
> $ echo foo > testfile2
>
> vijay@balrog ~/foo/temp
> $ chmod +x testfile2
>
> vijay@balrog ~/foo/temp
> $ git add testfile2
>
> vijay@balrog ~/foo/temp
> $ git commit -m "test2"
> [master 9675b55] test2
>
> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
> =C2=A0create mode 100755 testfile2
>
> vijay@balrog ~/foo/temp
> $ mkdir foo
>
> vijay@balrog ~/foo/temp
> $ cd foo
>
> vijay@balrog ~/foo/temp/foo
> $ git co master~1
> git: 'co' is not a git command. See 'git --help'.
>
> Did you mean one of these?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0clone
> =C2=A0 =C2=A0 =C2=A0 =C2=A0log
>
> vijay@balrog ~/foo/temp/foo
> $ git checkout master~1
> Note: checking out 'master~1'.
>
> You are in 'detached HEAD' state. You can look around, make experimen=
tal
> changes and commit them, and you can discard any commits you make in =
this
> state without impacting any branches by performing another checkout.
>
> If you want to create a new branch to retain commits you create, you =
may
> do so (now or later) by using -b with the checkout command again. Exa=
mple:
>
> =C2=A0git checkout -b new_branch_name
>
> HEAD is now at 7564449... test1
>
>> Probably a dumb question (from a non-windows-user), but why not use =
the
>> native Git for windows?
>
> Do you mean msysgit? =C2=A0As a GNU/Linux user, I probably don't need=
 to
> explain the luxuries a bash prompt gives you. =C2=A0In this scenario,=
 cygwin
> is the closest approximation on Windows system.
>
> msysgit comes with its own bash shell etc (which is good) but rather
> than go that integration route, it's much simpler to have git working
> within cygwin when you're already used to it.
>
> Cheers
> ~vijay
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
