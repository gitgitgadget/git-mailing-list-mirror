From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: Question about installing git from source
Date: Wed, 24 Dec 2014 13:52:09 +0600
Message-ID: <CANCZXo730yBxQEeCir2KZ4KxOn8RiOPyQf7Wd_AmTSR71H+NYQ@mail.gmail.com>
References: <CANCZXo42SdM8hMdTFYgvD8D+RmXua1oJvB+FfTjjfR=yWqhmkg@mail.gmail.com>
	<xmqqioh247th.fsf@gitster.dls.corp.google.com>
	<CANCZXo4daZffQ7binFpHBy9adKKeuwHuR5VRixXUowMdgAdhTQ@mail.gmail.com>
	<xmqq1tnq45yk.fsf@gitster.dls.corp.google.com>
	<CANCZXo4q-TwH8WyqP1GYcUY-obWG1HAt8gSEs7jy5TJiUDG0HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 24 08:52:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3gjv-0006JE-Ou
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 08:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbaLXHwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Dec 2014 02:52:11 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:62354 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbaLXHwK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Dec 2014 02:52:10 -0500
Received: by mail-oi0-f46.google.com with SMTP id h136so16763542oig.5
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 23:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xxEhiW3vXxkeYQ476ZLJPPzbmnfsiha8jByc/vgGGn8=;
        b=AJ2Pv3kDNEXK5Q4xFab6ctJLJuxYRQ5ggO7acApGcSNnPCQd8dw49OrQ2BMdsDEQS0
         8qgRR71o27xHLHrs/KoeH10DErkr98Sb1gCiDnqc3OxNeomb0W65ZcsUkp7Nij7iYkkp
         PLjH8Ua32kplVik/wz5NxAltKLfbZvi0qUtC2joNG+fQxxtRGWo0xME2joe1O4yjaih/
         ZhSv9BzzMsfaw6YUPA4kqJkWC07ojsbvr0Jc8Yj35ruv+jK9AXVgfWlOE2mvushjSdu0
         HDlbbj43nNZC8okgtvcd+RBJSO84CMkDkyLl0IQ6kQdzz/fPhDwQOOxPhzaUsxsjmgGd
         ITkQ==
X-Received: by 10.182.241.133 with SMTP id wi5mr18852819obc.10.1419407529302;
 Tue, 23 Dec 2014 23:52:09 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Tue, 23 Dec 2014 23:52:09 -0800 (PST)
In-Reply-To: <CANCZXo4q-TwH8WyqP1GYcUY-obWG1HAt8gSEs7jy5TJiUDG0HA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261794>

Yeah, was wrong install script.

thank you.

2014-12-23 23:53 GMT+06:00 Alexander Kuleshov <kuleshovmail@gmail.com>:
> I looked at Makefile, and seems that it occurs from here:
> https://github.com/git/git/blob/master/Makefile#L2205
>
> It tries to copy all files/folders from git root directory but
> 'install' command prints this error. I tried to execute 'sudo install
> -d -m 755' in other directory and if there is directory too it prints
> the same error. For example:
>
> ~/scripts $ ls
> addPPA    cleanMailTrash  git-autor    git-ranges       git-tp
>             install     scripts    ssh-live       term-help  tp-git
>     updateMail  xray-start
> buildGit  deployWork      git-install  git-remove-tags
> git-update-commit-message  install.sh  ssh-build  ssh-wiwob-lab  test
>      updateGitDev  updateNews
>
> test - is directory here
>
> ~/scripts $ sudo install -d -m 755 .
> Copying scripts to /usr/bin
> cp: omitting directory =E2=80=98test=E2=80=99
> Done
>
> 2014-12-23 23:43 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
>> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>>
>>> install -d -m 755 '/usr/bin'
>>> Copying scripts to /usr/bin
>>
>> As 'git grep "Copying scripts"' gives us nothing, the message is
>> obviously not what we are giving.  Perhaps you have a strange "insta=
ll"
>> in your path that does not understand "-d" is a way to tell it to
>> make sure a directory exists (by creating one as necessary)?
>>
>
>
>
> --
> _________________________
> 0xAX



--=20
_________________________
0xAX
