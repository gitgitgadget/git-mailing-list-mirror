From: Kevin Coleman <kevin.coleman@sparkstart.io>
Subject: Re: folder naming bug?
Date: Mon, 2 Feb 2015 23:52:21 -0500
Message-ID: <06E0624C-2484-476D-A32F-B586062EC230@sparkstart.io>
References: <27503C0E-7D33-4893-AD25-6A821D31FAB1@sparkstart.io> <CAGyf7-FXhhW74DvcO8nbWud9A868AYqKj_zY61wmf9XGvH4eQA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 05:52:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIVTO-0000eR-Sl
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 05:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933888AbbBCEwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Feb 2015 23:52:22 -0500
Received: from imap10-3.ox.privateemail.com ([192.64.116.216]:53503 "EHLO
	imap10-3.ox.privateemail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933886AbbBCEwV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 23:52:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.privateemail.com (Postfix) with ESMTP id 589932400D3;
	Mon,  2 Feb 2015 23:52:21 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at imap10.ox.privateemail.com
Received: from mail.privateemail.com ([127.0.0.1])
	by localhost (imap10.ox.privateemail.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZKb1Kin_uMJs; Mon,  2 Feb 2015 23:52:21 -0500 (EST)
Received: from [192.168.49.81] (unknown [72.16.218.22])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 23D8B2400C7;
	Mon,  2 Feb 2015 23:52:21 -0500 (EST)
In-Reply-To: <CAGyf7-FXhhW74DvcO8nbWud9A868AYqKj_zY61wmf9XGvH4eQA@mail.gmail.com>
X-Mailer: Apple Mail (2.1993)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263305>

Sorry for sending x2.  I got a bounce notification the first time.

=3D=3D=3D=3D
Yes, I am on a Mac.  I just tried that, but I don=E2=80=99t think that =
completely fixed it.  As you can see it tracks =E2=80=9Cfoo/bar.md=E2=80=
=9D and then it tracks =E2=80=9CFoo/bar.md=E2=80=9D.  It still tracks b=
oth =E2=80=9Cfoo=E2=80=9D and =E2=80=9CFoo=E2=80=9D even tho only =E2=80=
=9CFoo=E2=80=9D exists in my dir after the rename.

I create a public repo on github with this repo https://github.com/Kevi=
nColemanInc/test

I am running git version 2.2.2.

11:41:57 ~/test $ git init
Initialized empty Git repository in /Users/kcoleman/test/.git/
11:42:03 ~/test (master #) $ git config core.ignorecase false
11:42:06 ~/test (master #) $ mkdir foo
11:42:13 ~/test (master #) $ cd foo
11:42:26 ~/test/foo (master #) $ touch bar.md
11:42:30 ~/test/foo (master #) $ cd ..
11:42:32 ~/test (master #) $ git add .
11:42:35 ~/test (master #) $ git commit -m "first"
[master (root-commit) 6125a1d] first
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo/bar.md
11:42:39 ~/test (master) $ mv foo Foo
11:42:44 ~/test (master) $ ls
=46oo
11:42:46 ~/test (master) $ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	Foo/

nothing added to commit but untracked files present (use "git add" to t=
rack)
11:42:48 ~/test (master) $ git add .
11:43:18 ~/test (master +) $ git commit -m "second"
[master f78d025] second
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 Foo/bar.md

-Kevin Coleman

> On Feb 2, 2015, at 11:37 PM, Bryan Turner <bturner@atlassian.com> wro=
te:
>=20
> Are you, by any chance, on MacOS? HFS+ by default is
> case-insensitive-but-case-preserving, and Git on MacOS by default run=
s
> with core.ignorecase =3D true as a result.
>=20
> If you set that to false does it change the behavior?
>=20
> Hope this helps,
> Bryan Turner
>=20
> On Tue, Feb 3, 2015 at 12:56 PM, Kevin Coleman
> <kevin.coleman@sparkstart.io> wrote:
>> git isn=E2=80=99t tracking folder renames when the case of the lette=
rs change, but it will track it if the folder changes names.  Is this i=
ntentional?
>>=20
>> Here is an example:
>>=20
>> 08:51:26 ~/test $ git init
>> Initialized empty Git repository in /Users/kcoleman/test/.git/
>> 08:51:29 ~/test (master #) $ mkdir main
>> 08:51:44 ~/test (master #) $ cd main
>> 08:51:46 ~/test/main (master #) $ touch readme.md
>> 08:51:50 ~/test/main (master #) $ ls
>> readme.md
>> 08:51:53 ~/test/main (master #) $ cd ..
>> 08:51:54 ~/test (master #) $ git add .
>> 08:51:59 ~/test (master #) $ git commit -m "one"
>> [master (root-commit) b0fddf6] one
>> 1 file changed, 0 insertions(+), 0 deletions(-)
>> create mode 100644 main/readme.md
>> 08:52:04 ~/test (master) $ cd main
>> 08:52:14 ~/test/main (master) $ cd ..
>> 08:52:27 ~/test (master) $ mv main Main
>> 08:53:51 ~/test (master) $ git status
>> On branch master
>> nothing to commit, working directory clean
>> 08:53:53 ~/test (master) $ ls
>> Main
>> 08:54:02 ~/test (master) $ mv Main MainA
>> 08:55:44 ~/test (master *) $ git status
>> On branch master
>> Changes not staged for commit:
>>  (use "git add/rm <file>..." to update what will be committed)
>>  (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
>>=20
>>        deleted:    main/readme.md
>>=20
>> Untracked files:
>>  (use "git add <file>..." to include in what will be committed)
>>=20
>>        MainA/
>>=20
>> no changes added to commit (use "git add" and/or "git commit -a")
>> 08:55:45 ~/test (master *) $--
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
