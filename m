From: Chris Patti <cpatti@gmail.com>
Subject: Re: Odd issue - The Diffs That WILL NOT DIE.
Date: Wed, 7 Dec 2011 17:30:19 -0500
Message-ID: <CAJ8P3RA48W7ZiABvjkn_KkU-JPnCnaF_X_WK0wPtToph3DGDvg@mail.gmail.com>
References: <CAJ8P3RBm=RhNf6LKLqprqX6Rqx0OgRnJR+=+-Qhg4PvpeqaUDg@mail.gmail.com>
	<20111206215102.GA3654@centaur.lab.cmartin.tk>
	<CAJ8P3RCPt9Kwi1F7_TEkZQhkm1mwR_TFKhYszS5LL50kXU8oNQ@mail.gmail.com>
	<20111207220345.GA21596@sigill.intra.peff.net>
	<CAJ8P3RB=Gj-QCe6meqXSZ7N8+PnfNxSD8omUxT6dDh00bUf0QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 07 23:30:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYQ0Q-0004Id-3q
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 23:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757913Ab1LGWaV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 17:30:21 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:51330 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757048Ab1LGWaV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 17:30:21 -0500
Received: by wgbds13 with SMTP id ds13so89288wgb.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 14:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VWpuu9on1aIoT0mAS3HweN2qRqjzAzzg2YluML1+Ch8=;
        b=fNY9j6/PNkriGBgLKFRUwnoAJp8F3c0zG1QHA7U9YtzmdpjFebugRpdxjOK/XhfCDA
         wMv6lCrcN1FxGoan7vnkt/G3Hp84A9byOxV14OUE79e09u6+R7qYQrF4MMs1zJTffr6B
         7XZGXr8HKcG4LVknIw6m0dt5suD5n8Ns2oqhk=
Received: by 10.180.19.42 with SMTP id b10mr548964wie.39.1323297019376; Wed,
 07 Dec 2011 14:30:19 -0800 (PST)
Received: by 10.223.88.132 with HTTP; Wed, 7 Dec 2011 14:30:19 -0800 (PST)
In-Reply-To: <CAJ8P3RB=Gj-QCe6meqXSZ7N8+PnfNxSD8omUxT6dDh00bUf0QQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186514>

Actually I'm wrong on that count, but in an interesting way.

Both CloudSponge.php and Cloudsponge.php exist and are *not* deleted
in the remote repository, but on OSX only Cloudsponge.php shows up on
the filesystem, yet CloudSponge.php is being reported as modified.

Turns out two of our other developers are also seeing this behavior.

-Chris


On Wed, Dec 7, 2011 at 5:24 PM, Chris Patti <cpatti@gmail.com> wrote:
> On Wed, Dec 7, 2011 at 5:03 PM, Jeff King <peff@peff.net> wrote:
>> On Wed, Dec 07, 2011 at 11:54:26AM -0500, Chris Patti wrote:
>>
>>> OK. =C2=A0Let me give you a very specific series of commands, sorry=
 about
>>> the poor question / report (Not convinced it's a bug, probably pilo=
t
>>> error?)
>>>
>>> If my understanding of the way Git works is correct, there should b=
e
>>> NO pending diffs in a freshly cloned repository, yes?
>>
>> Yes. It's probably a bug, perhaps related to the case-insensitive
>> filesystem (we've seen similar weird "phantom changes right after cl=
one"
>> bugs before).
>>
>>> 11:35][admin@Hiram-Abiff-2:~/src]$ rm -rf framework/
>>> [11:37][admin@Hiram-Abiff-2:~/src]$
>>> [11:44][admin@Hiram-Abiff-2:~/src]$ git clone
>>> ssh://git.bluestatedigital.com/home/git/framework.git
>>> Cloning into 'framework'...
>>> remote: Counting objects: 378540, done.
>>> remote: Compressing objects: 100% (100469/100469), done.
>>> remote: Total 378540 (delta 261046), reused 374685 (delta 258447)
>>> Receiving objects: 100% (378540/378540), 148.33 MiB | 2.08 MiB/s, d=
one.
>>> Resolving deltas: 100% (261046/261046), done.
>>> [11:51][admin@Hiram-Abiff-2:~/src]$ cd framework/
>>> [11:51][admin@Hiram-Abiff-2:~/src/framework(master)]$ git diff
>>> diff --git a/app/modules/Core/controllers/CloudSponge.php b/app/mod=
ules/Core/con
>>> index 615a7b3..911d456 100644
>>> --- a/app/modules/Core/controllers/CloudSponge.php
>>> +++ b/app/modules/Core/controllers/CloudSponge.php
>>
>> Are there other files in the repository that differ from this path o=
nly
>> in capitalization? Can you show us the output of "git ls-files"?
>>
>> Is it possible to make this repo public, or at least available priva=
tely
>> to git developers?
>>
>> You mentioned v1.7.8. Do you see the bug with other git versions? If
>> not, can you try bisecting?
>>
>> -Peff
>
> Yup, you nailed it. =C2=A0The files in question are CloudSponge.php
> (deleted) and Cloudsponge.php (still being actively maintained).
>
> I am seeing the same behavior with 1.7.7.4 which I backrevved to
> yesterday while troubleshooting this issue. =C2=A0Can you suggest an =
older
> version for me to try next?
>
> I'm not sure how I would git bisect in this case, I'd need to have al=
l
> the different git revs installed in order to do that right? (I'm
> relatively new to git bisect, just figured it out the other day).
>
> Thanks,
> -Chris
>
> --
> Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
> chrisfeohpatti | P: (260) 54PATTI
> "Technology challenges art, art inspires technology." - John Lasseter=
, Pixar



--=20
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, =
Pixar
