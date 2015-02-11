From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: EOL handling (EGit/svn/Windows)
Date: Wed, 11 Feb 2015 12:46:08 +0100
Message-ID: <CAA01CsoDV3FQfrCJ8Zs6gwSwwn3YOBhioG5QGxXFnnsVK8Z+Tw@mail.gmail.com>
References: <CAA01Csrp0ZOouM5zhVuHQW9sWCnbMMLRkmcbRtgsU3k8wNtSqw@mail.gmail.com>
	<54D99BED.8010005@web.de>
	<CAA01CspP-C5ZVSR6Vyxe0X6UxpxGPwEM=P_7QwcfPFpUBGEzPQ@mail.gmail.com>
	<54DA248E.4080100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 11 12:46:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLVkG-0004xU-2z
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 12:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbbBKLqL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2015 06:46:11 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:57427 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbbBKLqK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2015 06:46:10 -0500
Received: by mail-wi0-f182.google.com with SMTP id n3so4175594wiv.3
        for <git@vger.kernel.org>; Wed, 11 Feb 2015 03:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Ms7ZTILWgba7L87ldOAaHX+O3V0vTFymSQ+yNU6tXcM=;
        b=UO9muzWQHp6ZWRwv5AG5HDLKDldNC02v9+Ucq4awepEadXbqzKoFj8BX3xbOJxYbyv
         l7/L/5RPii9v3hARAReLyKJ8R11WQExVsBUo8XyIqMIHMBdZHOt+nJpHME7Ewpn+e2Ok
         DySMSw3wvb7EhZQC7RKyTh9wb24z8TaQb5D4j4597dJL3xODLcp1SyScJ/m3wbsXd1qd
         lIcAxd/VSiBoIsYJUj5DKAiNE2fvUGIPr3BF6dPs07A9RpseZxcqoGveFUA4dK/JSIFx
         bQ5hInbzveOaifuTMabyt555QT9225bSOVNyfQ1qW6ccX1p22isdRoJUgcOp2J6drb0h
         lORw==
X-Received: by 10.194.76.73 with SMTP id i9mr61815457wjw.93.1423655168684;
 Wed, 11 Feb 2015 03:46:08 -0800 (PST)
Received: by 10.180.207.4 with HTTP; Wed, 11 Feb 2015 03:46:08 -0800 (PST)
In-Reply-To: <54DA248E.4080100@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263673>

On Tue, Feb 10, 2015 at 4:32 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 2015-02-10 11.52, Piotr Krukowiecki wrote:
>>
>> So far:
>> 1. msysgit can't checkout a one file (saying filename too long, the
>> relative path has 215 bytes) - probably not related to EOL issue.
>> Cygwin git works ok. So I did not check how msysgit works yet.
>
> Please have a look here:
> https://github.com/msysgit/msysgit/releases/Git-1.9.5-preview20141217
> I think we have support for long path names (Haven't tested it myself=
)

Thanks, I'll have a look later if I have some free time. Since
Cygwin's git is more recent I'd prefer to use it instead of "msys",
unless there are some other advantages of msys version.


>> 2. maybe due to old cygwin git, I have a problem of not displaying
>> changes, if the changed line has LF eol (and the file was checked ou=
t
>> on Windows with CRLF eols). Will try later with newer git.
> Normally you will not see any changes, and "git diff" will not show
> anything either.

I meant that there are some actual changes in the file (not only
whitespaces), but the line with the changes also has LF eol instead of
CRLF, and the actual changes are now shown. That's what the examples
below show.


>> 2a. EGit handles such files gracefuly, but OTOH if the file is simpl=
e
>> dos2unix'ed, it shows diffs showing all lines changed, and when you
>> commit the files, it will create empty commit.
> Why this dos2unix ?
> Is there a special reason ?

Just an use case - if for some reason someone/something coverts the
file to LF eol. Plus I think it would be better if empty commit was
not done (since there are no actual changes besides LF<->CRLF).


> By the way, when people only use Egit, I assume they use Eclipse,
> and you don't use Notepad.exe or so at all.
> Then you don't need CRLF in the worktree at all, as Eclipse handle
> LF well.

That's true, but I thought it'd be better to use native EOLs. The reaso=
ns:
- new files will have initially CRLF (and will be converted to LF on
first commit, but I think they will be left with CRLF in workspace
even after commit), so workspace might have CRLF files anyway
- some files are c# code/projects and are developer in VS, so they
should probably have CRLF eols; not checked how VS will work yet.
- some external tools might not work with non-native EOLs (not that I
know of any specific tool we use - just a precaution)
- when in Rome, do as Romans do, generally ;)


> and in this case you should be able to set
> git config core.autocrlf input
> on all repos, just in case someone sneaks in a CRLF somewhere.
> (And after the normalizing of course)

I'm aware of that option, we might change to it - but I still don't
see what's the advantage, except lack of CRLF<->LF conversion (that's
a valid reason, but won't core.safecrlf help here?)


>> $ file master/settings.gradle
>> master/settings.gradle: ASCII text, with CRLF line terminators
> That is under msysgit ?
> (Side note: Msysgit is called Git for Windows these days)

Nope - both repository and client was cygwin git.


>> $ dos2unix.exe master/settings.gradle
> Is this under Msysgit ?

Cygwin.


>> dos2unix: converting file master/settings.gradle to Unix format ...
>>
>> $ git status
>> # On branch master
>> #
>> # Changes not staged for commit:
>> #   (use "git add <file>..." to update what will be committed)
>> #   (use "git checkout -- <file>..." to discard changes in working d=
irectory)
>> #
>> #       modified:   master/settings.gradle
>> #
>> no changes added to commit (use "git add" and/or "git commit -a")
>>
>> $ git diff
>> fatal: LF would be replaced by CRLF in master/settings.gradle
> That's interesting.
>
> What does
> git config -l | grep core
> give ?

core.autocrlf=3Dtrue
core.safecrlf=3Dtrue
core.eol=3Dnative
core.repositoryformatversion=3D0
core.filemode=3Dtrue
core.bare=3Dfalse
core.logallrefupdates=3Dtrue
core.ignorecase=3Dtrue

Plus, "*.gradle text" in .gitattributes.

As I wrote, it might be old Cygwin git - 1.7.9. Will try to update.


--=20
Piotr Krukowiecki
