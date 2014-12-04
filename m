From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Enhancement Request: "locale" git option
Date: Thu, 4 Dec 2014 18:21:40 +0100
Message-ID: <CACBZZX6iOtO-Wv_T1Sgtmjqdi8kEziBCHwp1X319x0o1QMOnGA@mail.gmail.com>
References: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
 <54801B50.4080500@web.de> <20141204095557.GE27455@peff.net>
 <CACBZZX4Rin6jj2viTUmdpEqLb9TWnMf+p_vRF8BbLrTWFDcp3A@mail.gmail.com> <548087F8.1030103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 18:22:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwa6T-0000iD-3z
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 18:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbaLDRWE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2014 12:22:04 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:62159 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182AbaLDRWA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 12:22:00 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp4so3150943obc.6
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 09:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YfHO9XgRiBgs8idxQJbaBn8MVoOS0F80yI3fAv24Og0=;
        b=GpIHJIooPVRgYzbGFDEgxnjJoyv+NtREHeeviOBSjxjFcUsMKfxvS8MNysTUkuuvgk
         4fXJd3LJrLBt08woQYE/NPa8Iier7BSYxUFODx2oeiiXFWpLmccqbZsBeujyKZ6JOdak
         2wxeE7+wtcuCgioDKeI3K+Y+3Jo2btXnygBncsfLNVQMtgt7ZvUaN1c7SqymKu1R2Myt
         7hzJPVJloPGIkbNPinoFQTF/3uqSkoK5D0TY2p67DIsYKOKHUUjkC3X9W+QRVmcY6YmF
         NbyRb8S4seegvApkH7fSuCP7UWOewGCDhBpsSc81Qmm1bL0sMQPHHxUBWnSW8mcVVwlU
         VZ/Q==
X-Received: by 10.182.79.104 with SMTP id i8mr7817384obx.58.1417713720263;
 Thu, 04 Dec 2014 09:22:00 -0800 (PST)
Received: by 10.76.141.44 with HTTP; Thu, 4 Dec 2014 09:21:40 -0800 (PST)
In-Reply-To: <548087F8.1030103@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260769>

On Thu, Dec 4, 2014 at 5:12 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason schrieb am 04.12.2014 um 16:49=
:
>> On Thu, Dec 4, 2014 at 10:55 AM, Jeff King <peff@peff.net> wrote:
>>> On Thu, Dec 04, 2014 at 09:29:04AM +0100, Torsten B=C3=B6gershausen=
 wrote:
>>>
>>>> How about
>>>> alias git=3D'LANGUAGE=3Dde_DE.UTF-8 git'
>>>> in your ~/.profile ?
>>>> (Of course you need to change de to the language you want )
>>>
>>> Besides being awkward in scripts (which will not respect the alias =
and
>>> use a different language!), that variable will also be inherited by
>>> programs git spawns. So the editor, for example, may end up in the =
wrong
>>> language.
>>>
>>> I think respecting core.locale would make sense (probably the chang=
e
>>> would go into git_setup_gettext(), but you may have to fight with t=
he
>>> setup code over looking at config so early in the process).
>>
>> I think we should just stick to the standard *nix way of doing this:
>> Tell people to set their locale in their environment.
>>
>> If someone's having this issue it's also happening for all the
>> binutils, and any other command-line and GUI program they use, unles=
s
>> they override using the standard way of doing so, by setting the
>> relevant LC_* environment variables.
>>
>> If you want Git in English then create an alias to override its loca=
le
>> to be C, if you want the editor it spawns to be in some other langua=
ge
>> alias that to something that explicitly sets LC_* for that editor.
>>
>> Maybe I'm being overzealous about this (especially with the "I
>> implemented this" blinders on), but let's not have Git set the
>> precedent for other *nix programs that they all should come up with
>> some custom way to override locales, that's something to be done at
>> the OS locale library level, which we use.
>>
>>> However, I think the original question is not one of localizing git=
, but
>>> rather of having it _not_ localized (avoiding the German translatio=
ns).
>>> There is a hack you can do that for that, which is to set
>>> GIT_TEXTDOMAINDIR to something nonsensical (like "/"), which will m=
ean
>>> git cannot find the .po files, and just uses the builtin messages.
>>
>> You can, but the fact that that works is an internal implementation
>> detail we shouldn't document or support.
>>
>
> The main issue at hand is really that we have localised git but not i=
ts
> man pages. Even if you understand English, the man pages don't help y=
ou
> at all if you can't connect the technical terms used there to their
> localised counterparts in git's messages. (NO_GETTEXT=3Dy is my solut=
ion.)
>
> That is one of the many reasons why I proposed to have a dictionary o=
f
> the main technical terms for each language before we even localise gi=
t
> in that language. In an ideal word, we would provide a simple solutio=
n
> for looking these terms up both ways. I don't think we're going to ha=
ve
> localised man pages any time soon, are we?

I think that's a great idea, and one that's only blocked on someone
(hint hint) sending patches for it.

It would be neat-o to have something to make translating the docs
easier, i.e. PO files for sections of the man pages. There's tools to
help with that which we could use.

But there's no reason for us not to have translated glossaries in the m=
eantime.
