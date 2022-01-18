Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF2FC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 12:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiARMpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:45:35 -0500
Received: from mout.web.de ([212.227.15.14]:49993 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236418AbiARMpe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 07:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642509925;
        bh=oaaFViX5D2MJSM/9utL4RJTv9wH5EN+InPC7pihaoNM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kP6UB0K961PC2vCIG7EwVqpm6YQT1yzKpenrWwngALtUPZLodDSuSSARYwLOhwE8K
         WRALfTMqx/ToznvtOQVw97QuIZ2nlIh7Qa1lZfkDPHjj6Fy8wRtf9bDMjxkCTUgIGQ
         Shc0Cj9BvL+Z91abu2np66SakGUorKxNxKmIjIzI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCE0-1mcg2P1YXA-00bss9; Tue, 18
 Jan 2022 13:45:25 +0100
Message-ID: <b5c85f32-eaea-a5f9-c648-5bdbe1c5cd62@web.de>
Date:   Tue, 18 Jan 2022 13:45:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: git bisect bad @
Content-Language: en-US
To:     Ramkumar Ramachandra <r@artagnon.com>,
        Christian Couder <christian.couder@gmail.com>
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
 <8bc73981-589e-20e5-247b-2f74e166ae1a@web.de>
 <925ef53d-c8b2-4ef4-acee-490900e8a3b7@www.fastmail.com>
 <88899d16-5e3e-2bb2-07e9-59f7607c91a8@web.de>
 <e90803fb-00a1-4575-9a8b-8f7fed7f5e6a@www.fastmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <e90803fb-00a1-4575-9a8b-8f7fed7f5e6a@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:arL0h5vapNF5OGmklA8XXgMK776174OtzV6m/a0dBoKllsQ8CGB
 fU1OUE4sZ5YjSIZ11JgsYs1G069OfXlFCPNJf4lVbRyalNgClOHZZzhHnR1R10BfXUh1g21
 OUhg9cK3BjdxoyQG3mZ5uYxzhKuyy40mpTFgpqoA9J6yKbrBtiTcgIIRBxUQ7ihw6hK+hT+
 A2UYM2yJMAAAo0K5WRt2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AiBNGPIS3dg=:tDCMkVL4gHF8sFGm+PZ62t
 nxoOdJ7mhUJV5Uw/jNh6TiqHa4r/qooWD/lNYaPssI62/5L7st/iuhshtyZlYxKKPtX3FupfH
 cuagiYfh7ySHkdUp8z6vvNpk2P0jGg9w0LN1vwu8HR01pkp7DV8l76oTb0zgy3q7ie5QNSMZN
 Qx50iAgwDRKriP0qqRa/cgt5WStBtHywOIbh16RfBv6KSOuIeHrc2mFnoz+OYsz0IuvCvRHrr
 IeIu8mT7wlaXK/rHejhPVyWkSmcOLkT/e12wyHxT88dnXRYR6GCJ08T9GfnGhCmYjLEo3BTni
 9KtQFL0zrKCEFRe38ijUvogqTOyhZo3M5lezBbJVzGG7iikq6MtsOpcWCDw3EPsNMREuNiSE9
 jnWeKNNWk3oZXIXLUWNkiDlagkPQ5SL/3waZc+cfOoi3qKMNOQnYRhaye5rSEyV9eAlIn0j4q
 /VWudmNVXGBuzPAsp1JkMvHam1dFpA9edqNXLufcCdzQHqKj6S3eeSv+x65KvXwqvrYG9Ook1
 BGgd74RfrYFe/i64KpNsvdOqD2s0Rrr9/EKCknORxmtibFjGD6wEITzPNZmS5GQ98S6s/z9Ne
 BBcvagF3d2Zk2VOTsnMXrNYCOIjMqvjzXL++d8G6E4/57qfAJnydUXBVhyV1xaVucHjMo2dmd
 UJuBI86ttqDezauqf/r/zu6JospZJBtPDffxcW8ESra+pDE5M2dfyAJFJ/+RWhZaUOkudGGkY
 JDB9WT06r8mS4ZMzLHNGxTPcozm3PIopxepz8pZNbmVaJ5tf1/cfyIGuXcvS1lkAXTBmXPrtC
 QlGrK4JwSKrPlkkRbZq/KKJxqxPEhxuZepf+0nG5Xdwt6d/RW4npTwPr2D/T+CxZ7BtFW9Byi
 Gs9nEBjCDPPoVLaB0TheNarcxeZFtf0OgZAX8YsniToQ/sbtBD8pkw34tvVVpq8vEHZcidPtq
 F4fxtnBdjDnjcIY0XhlvA6d9FdMRQnOm4Ntru1zbLLwalONzWz5ps0rzcKu/JTZO/Sam0jkIe
 jRXt86lT2aRRjsOEiS/cCWlssGO4xff8FNxJXMLlxN3K2Gua5suyr65Jf7HsrPCfNdCj9v4QE
 NflybFjLxPwaOE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.01.22 um 09:04 schrieb Ramkumar Ramachandra:
> Ren=C3=A9 Scharfe wrote:
>> Using the shell allows the bisect run command to be any shell command,
>> not just some script.  E.g. you could bisect a build failure with just
>> "git bisect run make".  Quite useful.
>
> Ah, that's quite useful, yes. The problem of improving user
> experience with bisect is getting more and more hairy. May I suggest
> something tractable, albeit not too elegant, and certainly not
> perfect, in view of improving user experience in common use cases?

I like the pragmatism.

> 1. If argv[0] of the supplied command is found in $PATH, check it for
> executable permissions. Otherwise, error out. It's highly unlikely
> that the user meant a shell builtin, which would supersede the
> executable in $PATH.

Installing something in $PATH and forgetting to make it executable
sounds like a very rare case.  And if we find such a thing, would it
warrant erroring out?  What if there is an executable version somewhere
else in the $PATH or a shell builtin or an alias?

> 2. If argv[0] is found in the current directory, prompt for "Did you
> mean ... [Y/n]?"

That is more likely, I imagine, but is the existence of such a file
strong enough a signal to interrupt the program?  I think we are
better off making sure there actually is a problem first.

> 3. If checking on merge-base fails, improve the error message with
> "Perhaps your bisect script is broken?" and reset bisect
> automatically.

That would have no effect if the bad commit is a straight descendant of
the good one.  And a merge base being bad can have other causes than a
missing script.

Ren=C3=A9
