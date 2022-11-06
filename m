Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E813C433FE
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 08:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKFIZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 03:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiKFIZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 03:25:57 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8848A47C
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 01:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667723136; bh=4skKqb+z4on7JW9JYBxzUuq8cHMJow2o0po6cr286B4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iSf+V+3cYCWFOC55LC+4ZlCJPKVI71qIvCLW/hARexc8YVvXvCj3wZGb51Emr9Xkh
         3/N8ietjlfYJv6Pa0/GNjGxFHcxSBGgmJzSkciJILQqxsk9GIe/7LdUEaFWPw8y+L9
         TueGwdetlL6kZD3hmpbLYbQdZPFo4IBl8ZtatZaTFodhWgZqC9XZZX8E3kHE59vjZB
         ITWDbsMrqZSRwBtJcsKJ2CBNdFMUJ+aXHBktt44BiuNZKE/ZeJax7K0ZiBBqbMtFeH
         boZjvWG5stxpPSeIPS82xJjTwiia1yI3fTG6xkkGFiwqN4Kp3OIC8BSVNhYSwE7U2N
         SNlr8pGlEN9rA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.144.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQ8Wa-1oeLRo26Lo-00M3Rz; Sun, 06
 Nov 2022 09:25:36 +0100
Message-ID: <46ee3f92-943f-10d5-7ec5-c68f1ced87ce@web.de>
Date:   Sun, 6 Nov 2022 09:25:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 09/13] parse-options API: don't restrict OPT_SUBCOMMAND()
 to one *_fn type
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
 <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
 <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
 <221105.861qqhxz0o.gmgdl@evledraar.gmail.com>
 <25776063-a672-fc65-bed3-1bc8536ab8b3@web.de>
 <221105.86o7tlvxh0.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221105.86o7tlvxh0.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VpN+Cy4ReJG6VtnNqdUN/M6qxzxh9KFX+oatldmEoG/0Yed/+RK
 WpLtzRs8NPrbSazoq6p9hzMQaBy+6aOW2n5ErVJJDsQlYMEooRB9vPEUygHagRD8sKb+ChW
 STfuKAnnC8uWwC9s2Rtq3mQRWlHbdMbkjrNvsSQ6pCHG0gla6+VK4K7FZa3txbNiVrmubPL
 t26+H0g6Vp/u3FWMNciiA==
UI-OutboundReport: notjunk:1;M01:P0:xen4aj51O2c=;7WfyE+4kgauOXS+abl5MueeOBL8
 wy53cz7ZYpqqQJ/ZRMAdCy/U7RO2R0dxBumqkh5HVaOTVbFuSkQbnuLu3vjfpb+yEaRSUalyL
 TLg9AYADdrbNdBsayJU/h9q9gF/lbC62yevUTqr700OPuXRF3xQrpnFQvp7dHbHzNnTYzLmih
 XTJPksbqy4Txe/QMX5Kc69dFoG8JCTKML1VDGL+17yjdQt2WIdOmLLyBJC7ylyPbznRmMjLBb
 zoSfnlz8pxjegDGhsDD64JwVUJeTZjQHCxR2AWfG3cB/tJghEW/6xBChH0KhJpdJiMYxa26A0
 d9zdNZ4cpyRc1xkdj/41BWpyAuGg44tGZbSXFOZ9y4H40F1GQuunT7Za1Xg8R7k0ZtWmLmPDy
 jLcx1FIa/fZaLnOEuZfNr5oAn9xPq2+iJQhljtuHnjFx/TE0z1tIJ92KV+OxaeFJsestnWZvr
 v+Yt3wQHTCyGWVkWry2jCqxKQfZyN1KHNQpv/iwvr49MGMntMuhMWrTgZzTKLYBIrYU1uZoHU
 5I6yg+HMBkazk4R8udPlemI8k7+5tL5ObnPQn5Mb3Fj6bhKlEsakCREMo20i7BmBTS6WDTX+G
 cxKtkONjV8wFxzYbLF9QxQcIGayUvAiMgz8yH+zZ72AVwlGdkjtvJyyZhxwHdCTn0Fhn3lvax
 LlYhn4q0eQmhTor96uWid84JBpGbdrQVoPVu7EIMsyzUJjEql4/rV/m19keowMPPP1UsQRWiU
 RvdajwKmPC4eMIXkg9dFOxM2CFof273T9D+/41x6Dz0x776uEgUwtT/ctWzaENQhYCBUvXL36
 LYkvu15USLPt9pv/F5cBShF5QRLdxUb5337LhyRnmkrPoffJ1XB40oe1TjyVuSEDWeTRZZGLI
 b+dpkRjjUaIebh4T7ElKGj1tpGTX2W3p0sdkfkcNKB9rdWpMXvkWDJl9FwfItoLfY50WbfhO3
 l3NLCQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.11.22 um 23:33 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Nov 05 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 05.11.22 um 14:52 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>
>>> I think that's an "unportable" extension covered in "J.5 Common
>>> extensions", specifically "J.5.7 Function pointer casts":
>>>
>>> 	A pointer to an object or to void may be cast to a pointer to a
>>> 	function, allowing data to be invoked as a function
>>>
>>> Thus, since the standard already establishes that valid "void *" and
>>> "intptr_t" pointers can be cast'd back & forth, the J.5.7 bridges the
>>> gap between the two saying a function pointer can be converted to
>>> either.
>>>
>>> Now, I may be missing something here, but I was under the impression
>>> that "intptr_t" wasn't special in any way here, and that any casting o=
f
>>> a function pointer to either it or a "void *" was what was made portab=
le
>>> by "J.5.7".
>>
>> Do you mean "possible" or "workable" instead of "portable" here?  As yo=
u
>> write above, J.5.7 is an extension, not (fully) portable.
>
> I think my just-sent in the side-thread should clarify this.

AFAIU you think that J.5.7 plus POSIX make conversions between object
pointers and function pointers portable.

>>> Anyway, like ssize_t and a few other things this is extended upon and
>>> made standard by POSIX. I.e. we're basically talking about whether thi=
s
>>> passes:
>>>
>>> 	assert(sizeof(void (*)(void)) =3D=3D sizeof(void*))
>>>
>>> And per POSIX
>>> (https://pubs.opengroup.org/onlinepubs/9699919799/functions/dlsym.html=
):
>>>
>>> 	Note that conversion from a void * pointer to a function pointer
>>> 	as in:
>>>
>>> 		fptr =3D (int (*)(int))dlsym(handle, "my_function");
>>>
>>> 	is not defined by the ISO C standard. This standard requires
>>> 	this conversion to work correctly on conforming implementations.
>>
>> Conversion from object pointer to function pointer can still work if
>> function pointers are wider.

This means that a compliant implementation could lose bits when going
the other way, i.e. converting a function pointer to an object pointer.

>>> So I think aside from other concerns this should be safe to use, as
>>> real-world data backing that up we've had a intptr_t converted to a
>>> function pointer since v2.35.0: 5cb28270a1f (pack-objects: lazily set =
up
>>> "struct rev_info", don't leak, 2022-03-28).
>>
>> That may not have reached unusual architectures, yet.  Let's replace
>> that cast with something boring before someone gets hurt.  Something
>> like this?

[snip]

> I think "just leave it, and see if anyone complains".
>
> If you look over config.mak.uname you can see what we're likely to be
> ported to (and some of that's probably dead). The list of potential
> targets that:
>
>  1) We know of ports to, or people would plausibly port git to
>  2) Are updated so slow that they're on a release that's getting close
>     to a year old.
>
> Are small, and it's usually easy to look up their memory model etc. are
> you concerned about any specific one?

Using implementation-defined behavior and requiring extensions when
standard code would work just as well makes no sense to me.

> I think if you're worried enough about it to push for the diff above:
> Can we just hide it behind an "#ifdef", then if we find that nobody's
> using it, we can consider it safe to use.
>
> I don't think there's any great benefit to the extension in that
> specific case, but there might be in the future (e.g. this topic would
> be one small user), so since we already have an unintentional test
> ballon, why not see if we can keep it safely?

You can't certify safety with tests.  Undefined behavior may manifest
itself in weird ways and only under certain circumstances.  Future
architectures may add new failure modes.  It's not like a syntax
extension, to which nonsupporting compilers respond with an error,
i.e. a clear signal.

Ren=C3=A9
