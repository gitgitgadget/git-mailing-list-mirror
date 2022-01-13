Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4929DC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiAMN4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:56:03 -0500
Received: from mout.web.de ([212.227.15.14]:37479 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbiAMN4D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642082154;
        bh=LX8ZclQEbCFEKiCIQvM/PWfOfF4xK9VM9sf9GB0E0Es=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=rW5/hJVPIS/diuc+jSS5I31UIowGGw+OAZarzK0/VPq+Vp28fxw8hNG8e7/BixDQl
         xoVJHwxt8/4WHuSd+dMgrVHF7drRveo7NJRXnlERSqfTxntHS6+9SaiHM2KASEmrn8
         wCADc3wUHLWjDmls38ek3U9XE4GBMkhVXfHwlK/I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZjd-1mcVeB2SPV-00caz4; Thu, 13
 Jan 2022 14:55:54 +0100
Message-ID: <8bc73981-589e-20e5-247b-2f74e166ae1a@web.de>
Date:   Thu, 13 Jan 2022 14:55:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: git bisect bad @
Content-Language: en-US
To:     Christian Couder <christian.couder@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        "Miriam R." <mirucam@gmail.com>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <xmqq4k6b34h8.fsf@gitster.g>
 <bafa9564-fa48-413d-bbef-3f068c03dd31@www.fastmail.com>
 <3dade45b-494f-663b-264b-06a51ea1cf56@web.de> <xmqq35lsyhbf.fsf@gitster.g>
 <13e323e9-eb0c-71c3-215f-b77c91fcc4c8@web.de>
 <5be4cdad-6769-68e8-0984-5fe89668d007@web.de>
 <421215c1-f6ae-4ec2-b666-2a481056ef79@www.fastmail.com>
 <CAP8UFD3tyBhrOQzg9j4qDAT0Tb8TCTK0=J6ORsiLVuMWn+W9wg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAP8UFD3tyBhrOQzg9j4qDAT0Tb8TCTK0=J6ORsiLVuMWn+W9wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WJ8u8s1djr7AWIdJLhBTKH2hS4Vee/T197oxMXd+e1T5A0q4c4q
 d+7WqP5KPa5FyhcdQDc4HFBbve1siuhlK7aXsm6DF3JS3oYBpnRWw5qtbSYP41Nn+JAqD3J
 ZfHn+MLnEzDRJFL44r0zK/iiJPJrh/eIUJGtMm/RmyfslPQ8wzm5jJ1+pFLlhYp2IT6eWsS
 oYLHKetW6ZaDdJQRao8AA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GHX2d3RJpoI=:lqttNJhQiNX3r3UVj6+W4M
 hObIMWP8L0E6XksmrxYtAdnZluEQ5+OIiY++NG94hFqL2FInC8ewdN4do0d62RgHdG57al70s
 wINIVd/USuNN5EKpH/Wc0+1YfXo2S5U3+HZoeNDWuhhHduAyX5jgrB/gbegUFtXJB4mxJmZqh
 8gsWqaFCkdTrt7C7SZw03rSIUw25eceb4wPf9wQTVs2xG05J0DvkvxADSTzESjOzw4aK2wUzV
 OQZbe3vjNGTQm+k5zsyb51jUjpqeTG7MnGG3WPFcTIGfo5CD60n0FZp+sAcxtdOoxKkbgdVKU
 RPt2giGjyGVLXERigmjJT72rh/KNoRtx4IzIJvMZeFQ7yhGm19S7iDt6ta6k0MFGXSLHguh1Q
 xiE07mqK+eq5quAyoVfJW3Yus8GO8d+FRNuDjjTNNVxs+8X/9Y7GyXGsxjIL5ZDbd532vJNbG
 il2CDdz3IGT8Sy4PcGswLKZx8wCxg+EXfT7n5GOj3Y6fhxatOrXfY4A8Tvg1waBorv5TZGNVo
 ToDsLIPDM+bozpm2Bn29iM7/GqKNdXoKVYnCYY424lSHoAOWPPWvHrLF2aFh7t1dKp4qEgTXl
 TOTO0UghfpS2OqZ5SEJmYr0KIAX7kdFusfdjZTEp1Z5s79SeEvHvj7y3W2adFIhiOgnvX73Eh
 e4ogBXVmdrdMbnOcrz9X+UB2NCinvcKGKx3IEvrJNkJLdZggE/CszHQdgU/a3uISew3pElJSo
 xO1jgvV2j645kPU/juSbYZPqIeCSPD3+O1CHk20pb0QGEOyyLK+pjokqpEqHuXSOkId59nn7+
 C2Cdi8uc7/1ilFKUnEtlHOrS3Q+/6GPYGYAywkuTGelkO/n7zb9fdEPCx9BxEUEasSVS/hHZQ
 IuE+KbzI4z8AQ9Q3jEAyGjuJ5+Ejk1T+DBeSdNUkJoOg7NgB03V7GVgiRMMKcPk93wfgX4ptJ
 p005KVr8Tej/JP5aDPc7NJ8Z8+wcD38djcOp0vHKsFJ4of/ktoAZW10d7r8kg4V7Foq11lRe8
 3dM1FvcaaCdQgjIvOw3MZl/CBw1hUkJid4w0l/3kGLeONSHC0Zuieiw0N8FImCksCeJbzdWJE
 Po6rlrPfv4GD0A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.01.22 um 13:28 schrieb Christian Couder:
> On Thu, Jan 13, 2022 at 10:32 AM Ramkumar Ramachandra
> <r@artagnon.com> wrote:
>>
>> Ren=C3=A9 Scharfe wrote:
>
>>> Reserving 126 and 127 shouldn't cause too much trouble,
>
> I don't think it's a good idea at this point to reserve the 126 and
> 127 error codes as there might be existing scripts relying on them
> to mean "bad".

Certainly possible -- people get the weirdest ideas.

> Perhaps we could introduce a new command line option, for example
> --bad-is-only-1, to specify that the only error code considered bad
> will be 1. Or perhaps a more general --bad-is=3D<list of ranges>, to
> be able to specify all the values and ranges that should be
> considered bad.

This would only help someone who mistyped the script name or forgot to
make it executable if they also used that option.  I can't imagine
someone planning their mistakes ahead like that.  And always using this
option would be annoying.

>>> but there's also a way to avoid it: bisect run could checkout a
>>> known-good revision first and abort if the script returns
>>> non-zero for any reason, including its non-existence.
>>
>> I can't say I'm overly enthusiastic about this trade-off. I think
>> most people would check their bisect scripts against the good
>> revision by hand before starting bisect: why introduce one
>> redundant step for users like me who tend to bump their heads,
>> because they're a bit rusty with machines?

It would slow the normal operation a bit, but reduce the time to error
and its impact significantly.

> I also don't like introducing a redundant step, unless a special
> command line option is introduced for it.

My comment regarding --is-bad applies here as well.

OK, here's another idea: We verify using a known-good commit only if
the return code of the first run of the bisect script is 126 or 127.
If we get the same value again then we report the script as broken and
leave the bisect state unchanged.  Otherwise we know it's an old school
script, register the first revision as bad and continue without further
verification steps.

>> Again, I don't know if this is a good idea, but if exit codes from
>> the shell aren't standardized, surely fork() and exec() would have
>> a better spec? So, perhaps remove the little git-bisect.sh and
>> rewrite it in C? I'd be up for this task, if we decide that this is
>> a better way to go.
>
> There has been a lot of effort, especially by Miriam (added in Cc),
> to port git-bisect.sh to C over the years.

The implementation language of git bisect is not immediately relevant
here, but that the shell is used to call the user-supplied bisect run
script is.  If we'd run it directly (without RUN_USING_SHELL) we could
distinguish error code 126/127 from execution errors.  I assume the
option is used to stay compatible with the old shell version of bisect.

Ren=C3=A9

