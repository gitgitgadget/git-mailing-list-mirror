Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D795CC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 09:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351913AbiALJEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 04:04:49 -0500
Received: from mout.web.de ([212.227.15.3]:36907 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351895AbiALJEt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 04:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641978282;
        bh=zRUVEV9K/nDsgm8+qyTaVGaneZNKwm3dgSZJPMtenQo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IUjM39YhMn8dneESjyNN4fLxdwvuz0eH5nIBcMdsCSWJd9J0bddVlKeWYZKtfGtNP
         P7rhaQ45RZR1aFagO3nK+6VJm7uLYG9Yu9otxOwfiUSghWIht0Nz6YgJ0j+kDmsH+a
         fbxgk5vVWEF+IzLfXoJu+HinmPuq83E2lg739gds=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFayw-1n88aC0Bji-00HZh1; Wed, 12
 Jan 2022 10:04:42 +0100
Message-ID: <3dade45b-494f-663b-264b-06a51ea1cf56@web.de>
Date:   Wed, 12 Jan 2022 10:04:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: git bisect bad @
Content-Language: en-US
To:     Ramkumar Ramachandra <r@artagnon.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <xmqq4k6b34h8.fsf@gitster.g>
 <bafa9564-fa48-413d-bbef-3f068c03dd31@www.fastmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <bafa9564-fa48-413d-bbef-3f068c03dd31@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4MLhuNB3ASdP4STaRPoVHjXYI3ObSA+BSTED1+pQMCtfEBMO7n2
 3zd7XNobbZBsLloOzXMaOfrvyOMjiA7jHdTH47qYvsTi/5LqY+EP1h/Q+6kXkF4HeRN700l
 U4oX+1X1qkaMO7yskW1q+92IX6rrJKagd0PR5wTQf0fTVS9j3BiX10sLAOGeeCnEj+5fzWt
 5oBgwAl2LEssFlexW2Mig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1SfUoFA38IA=:+ZjLbheX0+E+w7+vShzzFb
 6iovgF5bYYXHiVUuTZGfZPB8bDnH2s1t5dBdHh+hNYyoTySN/HSDQ1HjexxW4iv4OhUSIw3+d
 tbJW9M5UENSB/JZtIzx4HeGBn/+Bx6JGmusropAKWjmSQgvHYrh37tWqinsJ5hIV5yjqIpGb4
 mBSVU748LRknr4MEsqZsbsggWaxg0Q9Zt/jOePoVYd8s0KNLRggDooJwNIY0jCK6qcaO7SNDb
 LsveEHvtFuC+aFDXHr6qFHwbERAUDRKarpOlUpBdAL7ngpOuNCIfLoJRcXWiEngShZCeaPBAA
 f1yTvxQJL+rq44SWxBlTbvIjjZRf6eyDTy+6p0u+TKl0CZVgdvQJApp6CMIzJna8x3QmbBibJ
 jc0ufdZ2pt/+eegOIRYlpwKcHw4FetCnPAinHQDWQKJVQaJ6Hk+XNg0KlsqtV5qfc1zJ9zRFW
 itja9ZqpLcG4jf5MbF4yhLFpDTW4QJkC4JmVhTUEiwQvhDhMAmtWVJxprGPWdqF1bQIWANYW3
 ezGUQuiEcm1PxSKB8YnUPem9VasRY4a2GQlUgyjc0UnuR+EDSGiFnO8/kwppctJl/26jL8n6Y
 7SeENMn9KR8VaTIKDbhKMCUR920ztFrmD5RuMmTlp4wCIvHTiYdcRWXbzqGFsuFNksrL9AS7t
 d16ZOMmCT8S2/yT1Y3WsjILj/HRq3Op9z56qvxRdHCQtYvQaOfDRlGvHz1ViVAdUwHADHSMgO
 LX1r/PmxFCYvjG4R0un7QGQFLOVZ4bplJn2YqZdhYe2oWrT7brtOfXObSD4y9UWKP4aAlPwXX
 kYQEXHLY51771Wh2Xm+1C/PB9Wpw3XPJakc0JXDnZzVvfPJ0Ch0r4UvtTQV+5RQlmZZO5R4E8
 xno47tQxWaeVOWhlUSJdXaw7LkZ+/4RJ/BquWA+mZ7czZaqLGog8KcFAC3KOjem3Jm1iOsubm
 pwXZG/Z3rYQOCVflzrEJZAJb2gZWrsj0YlJeFM9spo0/Cf3+bQWckitaA8+BAPQw92uqPee1N
 EiFJq8R1fUiUeeWx7fPP+Nw6JqGrO1LW976kLRmGBPMjTN5go0pQRO05rmUvqt9hCMl6Mc9lW
 FS0QPNt2+Q1WDvWRtfSchHplzDBKWo273zzYRDC/eTYjjCK64m2PJbOeLxO343HkgB94sQueX
 Hhqe30pykp6xwFtMROmx5i+LG8UHwzUDiYPmO/Oo3ewyGhB0pfIAsqeBNbzIlsFZvZ6KcVLDG
 T+zxW4Enogi7PltZU5voXPbrSPfkOFxz9XP8YLsTGLJZ70i6NrYqwD+LomJpJrtuLEARUPpZQ
 K8ZYBL/fnqFJ3c5O1j5iIeD6olLbJSU8Cyhhx3hA/wuSsX6/eBzuEO3fCU9vWb+JJIqcXIVS
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.01.22 um 22:04 schrieb Ramkumar Ramachandra:
> Hi Junio,
>
> Junio C Hamano wrote:
>> "Ramkumar Ramachandra" <r@artagnon.com> writes:
>>
>>>   # on coq.git, for those curious
>>>   $ git bisect start
>>>   $ git bisect bad @
>>>   $ git bisect good V8.14.1
>>>   $ git bisect run bisect.sh # oops!
>>>   Lancement de  'bisect.sh'
>>>   'bisect.sh': bisect.sh: command not found
>>>   La base de fusion ea3595845f5013359b2ba4402f948e454350a74c est mauva=
ise.
>>> ...
>>
>> "command not found"?
>
> Yeah, I suppose bisect invokes exec(), which then probably expects
> the executable to either be in $PATH, or expects me to specify the
> path of the executable, failing that; in other words, './bisect.sh'.
> In any case, this minor typo shouldn't penalize the user by having to
> abort the bisect, and restart it, specifying good and bad commits all
> over again.

Yes, bisect run invokes the given command using the shell, which tries
to find it in $PATH.

It would be nice if we could determine if the command was not found by
the shell and halt the bisection.  This is actually indicated by the
shell using error code 127.  However, the script itself could also exit
with that code (e.g. if one of its commands was not found).  Currently
this is interpreted as a bad revision and bisection continues, as
documented in the man page of git bisect.

If we'd make error code 127 (and 126) special by stopping the bisection
(like we do for 128 and higher) then scripts that relied on that code
indicating a bad revision would require a manual "git bisect bad" at
each affected step.  Annoying, but not dangerous.  Such a script would
have to be modified to convert codes 126 and 127 to e.g. 1.

Seems like a reasonable trade-off to me.  Thoughts?

> Then again, there are other ways to bump your head: what
> if I forgot to chmod +x the bisect.sh?

That's indicated by error code 126.

> What if there is no bisect.sh?

You have to provide one, of course, but ...

> Should I have to restart the bisect process from the beginning?

... interpreting the non-existence of the script as all revisions being
bad seems odd indeed.  Halting the bisection at that point makes more
sense to me.

> This presents another possible opportunity for enhancement: in an
> overwhelmingly large majority of the use cases (or so I assume), './'
> is really redundant.
Adding the current directory to $PATH would be inconsistent and might
even be dangerous.

Prepending "./" to a given command that contains no directory separator
is speculative -- what if that command is actually found in $PATH?

Halting the bisection would take the sting out of such a typo, because
it's reported immediately and you can fix it and continue.
Additionally we could check for the command in the current directory
and suggest something like "'bisect.sh' not found; did you mean
'./bisect.sh'?".

Ren=C3=A9
