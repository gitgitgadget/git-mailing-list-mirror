From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: EOL handling (EGit/svn/Windows)
Date: Tue, 10 Feb 2015 11:52:39 +0100
Message-ID: <CAA01CspP-C5ZVSR6Vyxe0X6UxpxGPwEM=P_7QwcfPFpUBGEzPQ@mail.gmail.com>
References: <CAA01Csrp0ZOouM5zhVuHQW9sWCnbMMLRkmcbRtgsU3k8wNtSqw@mail.gmail.com>
	<54D99BED.8010005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 11:52:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YL8Qw-0006kn-ER
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 11:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115AbbBJKwm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2015 05:52:42 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:57953 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbbBJKwl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2015 05:52:41 -0500
Received: by mail-wg0-f53.google.com with SMTP id x13so12602244wgg.12
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 02:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UUHB1CFVtx+Fl36o0FqRN5uGlcjfJz0cik79GfNlx04=;
        b=X9LtoQ1t82IKQV9SkEXdGrwHiXnum5x1wu7prtlurUr0Ld30cMWWXgtmbXWyZDXcbh
         GZVpJiN5N1ssMcQVX/Cyub/ebjzyI8nVSxB/Or373pgjiPX3h16ZEDCOnTFyjaIcyoeW
         LJMj2HP+3+839nKNUoystvdkxW4WquJhpGjMkuNy/fdknVctf/TdaH0J3rxVGndF0jeN
         TpTeimqOTMi1BdwIPGHHXJ9b4M7+S8XTBWNU3+v/+/jwh1tSgRmokDU/WTXtEb47+NBL
         U9haKWBnBydvfXQUa/jZM6b2pRbNxH8VJKnqbmSq6tHTAZBNr4usOyEv6oTTc0nhtZ7r
         tmPw==
X-Received: by 10.180.88.193 with SMTP id bi1mr44474598wib.70.1423565559904;
 Tue, 10 Feb 2015 02:52:39 -0800 (PST)
Received: by 10.180.207.4 with HTTP; Tue, 10 Feb 2015 02:52:39 -0800 (PST)
In-Reply-To: <54D99BED.8010005@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263627>

On Tue, Feb 10, 2015 at 6:49 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> Which Git versions are you using ?

The one I'm testing currently:

git version 1.7.9 (cygwin)
git version 1.9.0.msysgit.0 (msys)
EGit from Eclipse Luna

Cygwin git is a bit old, as I see now. Will try to update later.


> How many people are there involved, how many on Windows, how many on =
Linux ?

Less than 10 actively, most on Windows.


> Do you want to commit to svn, or is this a one-time conversion ?

One-time.


> If it is a one-time conversion, and you continue to work in Git only,
> then the cleanest, most portable and future proof way is to use the
> .gitattributes file,

I'm not sure if EGit supports .gitattributes:
https://bugs.eclipse.org/bugs/show_bug.cgi?id=3D342372


> add that to the repo, do the normalization  and push.
> A line like this:
> * text=3Dauto
> is the easiest way.

I'm trying it.


> Have a look at
> https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
> take a tee or coffee, do some experiments first with a dummy repo,
> but all the client OS/Gits involved.

That's one step we did not do carefully enough :(


> Please let us know the result (or feel free to ask more questions)

=46or testing, I've converted all files to LF and commited it, also
added the .gitattribute file.

So far:
1. msysgit can't checkout a one file (saying filename too long, the
relative path has 215 bytes) - probably not related to EOL issue.
Cygwin git works ok. So I did not check how msysgit works yet.
2. maybe due to old cygwin git, I have a problem of not displaying
changes, if the changed line has LF eol (and the file was checked out
on Windows with CRLF eols). Will try later with newer git.
2a. EGit handles such files gracefuly, but OTOH if the file is simple
dos2unix'ed, it shows diffs showing all lines changed, and when you
commit the files, it will create empty commit.


$ git status
# On branch master
#
nothing to commit (working directory clean)

$ file master/settings.gradle
master/settings.gradle: ASCII text, with CRLF line terminators

$ dos2unix.exe master/settings.gradle
dos2unix: converting file master/settings.gradle to Unix format ...

$ git status
# On branch master
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       modified:   master/settings.gradle
#
no changes added to commit (use "git add" and/or "git commit -a")

$ git diff
fatal: LF would be replaced by CRLF in master/settings.gradle

$ echo "hi" >> master/settings.gradle

$ file master/settings.gradle
master/settings.gradle: ASCII text

############### diff does not show changes! ###################
$ git diff
fatal: LF would be replaced by CRLF in master/settings.gradle

$ git diff -- master/settings.gradle
fatal: LF would be replaced by CRLF in master/settings.gradle

$ cat master/settings.gradle
[the changes are there]

$ unix2dos.exe master/settings.gradle
unix2dos: converting file master/settings.gradle to DOS format ...

$ git diff
diff --git a/master/settings.gradle b/master/settings.gradle
index a8d6609..7aa9e6b 100755
[changes are shown]

$ vim -b master/settings.gradle
[remove CR from the changed line]

$ git status
# On branch master
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       modified:   master/settings.gradle
#
no changes added to commit (use "git add" and/or "git commit -a")

$ git diff
fatal: LF would be replaced by CRLF in master/settings.gradle



--=20
Piotr Krukowiecki
