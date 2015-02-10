From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: EOL handling (EGit/svn/Windows)
Date: Tue, 10 Feb 2015 16:32:30 +0100
Message-ID: <54DA248E.4080100@web.de>
References: <CAA01Csrp0ZOouM5zhVuHQW9sWCnbMMLRkmcbRtgsU3k8wNtSqw@mail.gmail.com>	<54D99BED.8010005@web.de> <CAA01CspP-C5ZVSR6Vyxe0X6UxpxGPwEM=P_7QwcfPFpUBGEzPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiA=?= =?UTF-8?B?QsO2Z2Vyc2hhdXNlbg==?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 16:32:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLCns-0006aE-9s
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 16:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbbBJPck convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2015 10:32:40 -0500
Received: from mout.web.de ([212.227.17.11]:60656 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbbBJPcj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 10:32:39 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MF3jD-1YN7ol1I43-00GHDi; Tue, 10 Feb 2015 16:32:36
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CAA01CspP-C5ZVSR6Vyxe0X6UxpxGPwEM=P_7QwcfPFpUBGEzPQ@mail.gmail.com>
X-Provags-ID: V03:K0:F+ZtRWYppXC5uKl3HCUp92xjdU/v9nbQ8zHmhZBfnQUHtwPHcSC
 9IxamB5DHR6nGen5y/DYEwL8GZa78uHHuYB2R/6XUgmJph4D1k/wztN3swb8Z0anEfGvt68
 XLJZjlM3L44CVosoCDqVcFjktv9KksvJacOFxYcugNxOySb5dt9ASMEm5AwLa45D65RtUDh
 8Bg+W9HlieuIXXsJZ7lCg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263635>

On 2015-02-10 11.52, Piotr Krukowiecki wrote:
> On Tue, Feb 10, 2015 at 6:49 AM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> Which Git versions are you using ?
>=20
> The one I'm testing currently:
>=20
> git version 1.7.9 (cygwin)
> git version 1.9.0.msysgit.0 (msys)
> EGit from Eclipse Luna
>=20
> Cygwin git is a bit old, as I see now. Will try to update later.
>=20
>=20
>> How many people are there involved, how many on Windows, how many on=
 Linux ?
>=20
> Less than 10 actively, most on Windows.
>=20
>=20
>> Do you want to commit to svn, or is this a one-time conversion ?
>=20
> One-time.
>=20
>=20
>> If it is a one-time conversion, and you continue to work in Git only=
,
>> then the cleanest, most portable and future proof way is to use the
>> .gitattributes file,
>=20
> I'm not sure if EGit supports .gitattributes:
> https://bugs.eclipse.org/bugs/show_bug.cgi?id=3D342372
>=20
>=20
>> add that to the repo, do the normalization  and push.
>> A line like this:
>> * text=3Dauto
>> is the easiest way.
>=20
> I'm trying it.
>=20
>=20
>> Have a look at
>> https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
>> take a tee or coffee, do some experiments first with a dummy repo,
>> but all the client OS/Gits involved.
>=20
> That's one step we did not do carefully enough :(
>=20
>=20
>> Please let us know the result (or feel free to ask more questions)
>=20
> For testing, I've converted all files to LF and commited it, also
> added the .gitattribute file.
>=20
> So far:
> 1. msysgit can't checkout a one file (saying filename too long, the
> relative path has 215 bytes) - probably not related to EOL issue.
Please have a look here:
https://github.com/msysgit/msysgit/releases/Git-1.9.5-preview20141217
I think we have support for long path names (Haven't tested it myself)
> Cygwin git works ok. So I did not check how msysgit works yet.
> 2. maybe due to old cygwin git, I have a problem of not displaying
> changes, if the changed line has LF eol (and the file was checked out
> on Windows with CRLF eols). Will try later with newer git.
Normally you will not see any changes, and "git diff" will not show
anything either.
> 2a. EGit handles such files gracefuly, but OTOH if the file is simple
> dos2unix'ed, it shows diffs showing all lines changed, and when you
> commit the files, it will create empty commit.
Why this dos2unix ?
Is there a special reason ?
By the way, when people only use Egit, I assume they use Eclipse,
and you don't use Notepad.exe or so at all.
Then you don't need CRLF in the worktree at all, as Eclipse handle
LF well.

and in this case you should be able to set
git config core.autocrlf input
on all repos, just in case someone sneaks in a CRLF somewhere.
(And after the normalizing of course)

https://www.kernel.org/pub/software/scm/git/docs/git-config.html

(and don't ask me if Egit supports that)

>=20
>=20
> $ git status
> # On branch master
> #
> nothing to commit (working directory clean)
>=20
> $ file master/settings.gradle
> master/settings.gradle: ASCII text, with CRLF line terminators
That is under msysgit ?
(Side note: Msysgit is called Git for Windows these days)
>=20
> $ dos2unix.exe master/settings.gradle
Is this under Msysgit ?
> dos2unix: converting file master/settings.gradle to Unix format ...
>=20
> $ git status
> # On branch master
> #
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working di=
rectory)
> #
> #       modified:   master/settings.gradle
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>=20
> $ git diff
> fatal: LF would be replaced by CRLF in master/settings.gradle
That's interesting.

What does=20
git config -l | grep core
give ?
