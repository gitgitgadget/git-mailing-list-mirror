From: "Dmitry S. Kravtsov" <idkravitz@gmail.com>
Subject: Re: Git pull --rebase with strategy ours doesn't work (possibly bug)
Date: Mon, 13 Jun 2011 14:41:56 +1100
Message-ID: <BANLkTinoaznfBQo3ruPP9C8JfMV5E2v_Fw@mail.gmail.com>
References: <BANLkTi=jLQf6Wp-qqYoy7kND2M1=WRyxXg@mail.gmail.com>
	<BANLkTikYH9qG6YGEb4k=WMh97JHSJyN8cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 05:43:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVy3f-0002Vi-3u
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 05:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380Ab1FMDl6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2011 23:41:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39976 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab1FMDl5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2011 23:41:57 -0400
Received: by iyb14 with SMTP id 14so3538565iyb.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 20:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=nq9f80OsaGXJHicpOaqndAtemvXNYQgSbmDVIrA+6fk=;
        b=tovA4eaP/Iv7AneEggbiL1tJuyBjNEtCyzhcbEk/2xknHzaWDG/CTfKEoj+4sxe6ul
         2nfqaJlVX6Ul/L6EtXppJ3s3K5TnzvSL/LGNRTJXDVzbnayX+WM9mcvoRhcC9nYXNa2U
         mi60D1lLVob3N5VlJKo2bY23p0QzvnArv3zk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=g/SEPHQun2f+CQuS9kB/1sK+LQ7Y5sfiJCyzGMCrWDstQ0F2CQ1Z/gUgfGA5QWCTlz
         QBKcJwnwiVaYlFtqOJbHiEIpNeuluTKZb2YI44owEl77o7auW5aKUbBC5jN+zsMlSYXD
         eLFd2gp1G18ymqTGUYoAh2RCnv311DNKOt2fI=
Received: by 10.231.82.197 with SMTP id c5mr5162091ibl.131.1307936516295; Sun,
 12 Jun 2011 20:41:56 -0700 (PDT)
Received: by 10.231.20.69 with HTTP; Sun, 12 Jun 2011 20:41:56 -0700 (PDT)
In-Reply-To: <BANLkTikYH9qG6YGEb4k=WMh97JHSJyN8cA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175678>

Also I read that during rebase terms ours and theirs are swapped, but
it i change strategy to theirs it's still error, but even more
cryptic:

remote: Counting objects: 5, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
=46rom /home/kravitz/git-test/A
 * branch            master     -> FETCH_HEAD
=46irst, rewinding head to replay your work on top of it...
/usr/libexec/git-core/git-rebase: line 117: git-merge-theirs: command n=
ot found
Unknown exit code (127) from command: git-merge-theirs
1a3b9bcbc737728ae997368d6d850a6a265681b7^ -- HEAD
1a3b9bcbc737728ae997368d6d850a6a265681b7

2011/6/13 Dmitry S. Kravtsov <idkravitz@gmail.com>:
> Excuse me for russian locale, the part with error in english locale:
>
> remote: Counting objects: 5, done.
> remote: Total 3 (delta 0), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> From /home/kravitz/git-test/A
> =C2=A0* branch =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0master =C2=A0=
 =C2=A0 -> FETCH_HEAD
> First, rewinding head to replay your work on top of it...
> Already applied: 0001 3rd
> /usr/libexec/git-core/git-rebase: line 157:
> /home/kravitz/git-test/C/.git/rebase-merge/rewritten: No such file or
> directory
> All done.
> kravitz@Vor
>
>
> 2011/6/13 Dmitry S. Kravtsov <idkravitz@gmail.com>:
>> Hi,
>>
>> So here the steps to reproduce:
>>
>> $ git init A
>> Initialized empty Git repository in /home/catsadmin/git-test/A/.git/
>> $ (cd A && echo 123 > file && git add file && git commit -m "1st")
>> [master (root-commit) 1055edf] 1st
>> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 file
>> $ git clone A B
>> Cloning into B...
>> done.
>> $ git clone A C
>> Cloning into C...
>> done.
>> $ (cd B && echo 333 >file && git commit -am "2nd")
>> [master 4e9cd67] 2nd
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>> $ (cd A && git pull ~/git-test/B master)
>> remote: Counting objects: 5, done.
>> remote: Total 3 (delta 0), reused 0 (delta 0)
>> Unpacking objects: 100% (3/3), done.
>> From /home/catsadmin/git-test/B
>> =C2=A0* branch =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0master =C2=A0=
 =C2=A0 -> FETCH_HEAD
>> Updating 1055edf..4e9cd67
>> Fast-forward
>> =C2=A0file | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>> $ (cd C && echo 111 > file && git commit -am "3rd")
>> [master 1c4a368] 3rd
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>> $ cd C
>> $ git push origin master
>> To /home/catsadmin/git-test/A
>> =C2=A0! [rejected] =C2=A0 =C2=A0 =C2=A0 =C2=A0master -> master (non-=
fast-forward)
>> error: failed to push some refs to '/home/catsadmin/git-test/A'
>> To prevent you from losing history, non-fast-forward updates were re=
jected
>> Merge the remote changes (e.g. 'git pull') before pushing again. =C2=
=A0See the
>> 'Note about fast-forwards' section of 'git push --help' for details.
>>
>> So my idea is to create a straight line history, that will look like
>> "1st"---"2nd"---"3rd",
>> and from git-rebase man page I read, that strategy ours allows us to
>> discard conflicing changes in favor
>> of ours.
>>
>> $ git pull --rebase -s ours origin master
>> remote: Counting objects: 5, done.
>> remote: Total 3 (delta 0), reused 0 (delta 0)
>> Unpacking objects: 100% (3/3), done.
>> From /home/catsadmin/git-test/A
>> =C2=A0* branch =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0master =C2=A0=
 =C2=A0 -> FETCH_HEAD
>> First, rewinding head to replay your work on top of it...
>> Already applied: 0001 3rd
>> /usr/bin/git-rebase: line 157:
>> /home/catsadmin/git-test/C/.git/rebase-merge/rewritten: =D0=9D=D0=B5=
=D1=82 =D1=82=D0=B0=D0=BA=D0=BE=D0=B3=D0=BE
>> =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B8=D0=BB=D0=B8 =D0=BA=D0=B0=D1=82=
=D0=B0=D0=BB=D0=BE=D0=B3=D0=B0
>> All done.
>>
>> This message not only looks weird, it also discard my "3rd" commit
>> from master tree:
>> $ git branch
>> * master
>> $ git log
>> commit 4e9cd6730b1215b22b65fbcc6cbf87e331e5eb92
>> Author: Your Name <you@example.com>
>> Date: =C2=A0 Mon Jun 13 13:53:27 2011 +1100
>>
>> =C2=A0 =C2=A02nd
>>
>> commit 1055edf3618787ea53231ed6f4b00dfe571c8940
>> Author: Your Name <you@example.com>
>> Date: =C2=A0 Mon Jun 13 13:52:53 2011 +1100
>>
>> =C2=A0 =C2=A01st
>>
>> Am I wrong at something?
>>
>> --
>> Dmitry S. Kravtsov
>>
>
>
>
> --
> Dmitry S. Kravtsov
>



--=20
Dmitry S. Kravtsov
