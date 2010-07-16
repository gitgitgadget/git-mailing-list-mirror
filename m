From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] grep: Don't pass a TODO test if REG_STARTEND is supported
Date: Fri, 16 Jul 2010 14:33:55 +0000
Message-ID: <AANLkTimZ3f550HQwx3OEpO6n1b037He6hJ6rAXP8vfIk@mail.gmail.com>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>
	<7viq4ppxt9.fsf@alter.siamese.dyndns.org>
	<AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>
	<7vtyo0vdpz.fsf@alter.siamese.dyndns.org>
	<AANLkTim-4I5Sdu653yJOmnVYDqI8bb71839Vqfd3FKCi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 16:34:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZlzS-0006hU-2W
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 16:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965712Ab0GPOd7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 10:33:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54919 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965699Ab0GPOd6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jul 2010 10:33:58 -0400
Received: by iwn7 with SMTP id 7so2198759iwn.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bc4onzbM8imsakt28msP3QAbCI/CNrEKMRe9d63Z6MA=;
        b=gx1IH0Fvg35El6BaHWwuOJ8g0BvKUIcal4wnXuX94ak8ZD+fEJoTuqB3j81ABsVR2L
         vB+xTdjUGWpN7OkQEW7kFt543gmNf2mHuBYDg/W7sGIRZ9A+otaPxtQv6XLKP8t2RQ2m
         3snHof8Ea/o7KY4o8j35Q1AXh+gXD4t6gkyxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tYsfetVJvekT6wNl0vhjn4fD9hKSsDmkwN1ElneFy1M8Xg+VdbYSkO7eIVPgIo5RuJ
         M4Vaz+gn4grazZLlJx2hCH0+Pxt/1njegq4f0uOhmzLDmEK6VZ4q996tlCmOXUreaZOo
         28MawNqg9qrEuU+EVid19esy3q+ckpEM9FNEQ=
Received: by 10.231.145.1 with SMTP id b1mr1070518ibv.69.1279290835383; Fri, 
	16 Jul 2010 07:33:55 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 16 Jul 2010 07:33:55 -0700 (PDT)
In-Reply-To: <AANLkTim-4I5Sdu653yJOmnVYDqI8bb71839Vqfd3FKCi@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151154>

On Thu, Jul 15, 2010 at 18:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Thu, Jul 15, 2010 at 17:47, Junio C Hamano <gitster@pobox.com> wro=
te:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> On Thu, Jul 8, 2010 at 19:40, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> wr=
ites:
>>>>
>>>>> +if git grep ile a
>>>>> +then
>>>>> + =C2=A0 =C2=A0 test_expect_success 'git grep ile a' 'git grep il=
e a'
>>>>> +else
>>>>> + =C2=A0 =C2=A0 test_expect_failure 'git grep ile a' 'git grep il=
e a'
>>>>> +fi
>>>>
>>>> So if command "X" is known to succeed, we run it inside expect_suc=
cess
>>>> and if not we run it inside expect_failure?
>>>>
>>>> What kind of idiocy is that, I have to wonder...
>>>
>>> Well, the point is to normalize the test suite so that we never hav=
e
>>> passing TODO tests if everything's OK.
>>
>> I do not consider a test that passes under some condition but doesn'=
t
>> under some other condition "everything is OK". =C2=A0Marking the tes=
t as
>> "expect failure" as Ren=C3=A9 originally did makes a lot of sense to=
 me.
>>
>> The quoted patch is even worse as it will _actively_ prevent you fro=
m
>> catching a new error you just introduced while futzing "git grep" on=
 a
>> platform that used to work. =C2=A0Your "if" statement will say "ah, =
grep is
>> broken", and you will use expect-failure, not because your platform =
does
>> not support REG_STARTEND, but because you broke "git grep".
>>
>> The point of having tests is to help you catch your bugs while you
>> develop. =C2=A0A test that turns itself off when the feature it is t=
esting is
>> broken helps nobody.
>>
>> So forget about "passing TODO tests", whatever a "TODO test" is. =C2=
=A0The
>> change in question is actively _wrong_.
>
> I was under the impression that REG_STARTEND was considered purely
> icing on the cake, i.e. that the tests should be passing whether or
> not it was present.
>
> I guess my reasoning at the time was that if that wasn't the case,
> reporting an unexpected pass by default, as opposed to a failing TODO
> on platforms without REG_STARTEND. Since only TAP will report this, I
> thought that was just an omission.
>
> Anyway, since REG_STARTEND *isn't* obviously considered icing you're
> of course right, but the test is still broken as-is. Now it reports a=
n
> abnormal condition if REG_STARTEND is present (passing TODO test), it
> should instead have a failing TODO test where REG_STARTEND isn't
> present. I'll come up with a patch to fix that.

Well to clarify: The TAP is arguably right, although semantically
these sort of tests should probably be a SKIP on unsupported
platforms, not a passing TODO.

prove(1) also features passing TODO tests a bit too prominently for my
tastes. I've filed a bug for that:
https://rt.cpan.org/Public/Bug/Display.html?id=3D59428

> We should also just upgrade the GNU regex library in compat/regex to
> the version that supports REG_STARTEND. Unfortunately that seems
> easier said than done, since the library is now part of glibc, and ha=
s
> aquired a lot of glibc specific macros and other constructs that woul=
d
> need to be #defined away or otherwise worked around.

This is what we should be focusing on, the patch by Jonathan Nieder is
a good start.
