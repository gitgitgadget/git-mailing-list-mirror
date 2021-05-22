Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA485C2B9FB
	for <git@archiver.kernel.org>; Sat, 22 May 2021 21:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4A461163
	for <git@archiver.kernel.org>; Sat, 22 May 2021 21:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhEVVcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 17:32:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59545 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231379AbhEVVcx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 17:32:53 -0400
Received: from [IPv6:2601:646:8602:8be1:7cda:30c5:4c66:daab] ([IPv6:2601:646:8602:8be1:7cda:30c5:4c66:daab])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14MLTmlq441520
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 22 May 2021 14:29:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14MLTmlq441520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621718989;
        bh=ZMID+ZD9wDW7iKPOW1HGVwyI3grYXwTsFKcy49Sv3ts=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=IGAOAz0KMXzl/Ba0Vinh3DJ+jJLG58gRwRi7kiN9sLzIxH3Gp94SmYHQl00SB0nrL
         bYWR1Lh/Hhi+zNFYO9b4uJx7Xc0MQFNQZf+g1mpqbauHN0Spa+4XC63+lSeT3QFTbB
         RBYFMxxe6MkVxULJf6DJIde237KgWyhkO3P3IZJXSdjXarmpYVqYjq7ybRQG7yZ0nA
         qzq2DpgS5MR+773tjFuodOldVPo/CdInKaTUcoEBzMptUR9V/hNp2ioL6QS4GaCMYo
         6Qcmk5w7Q/3HJY98/8I+ZPkguD0H8dO0XXeWtmhrfwxLD3RTr2zzXCgw8JSjFOpClX
         CCV2xEsSb4znw==
Date:   Sat, 22 May 2021 14:29:39 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <60a976221c390_857e920812@natae.notmuch>
References: <YKWggLGDhTOY+lcy@google.com> <60a5afeeb13b4_1d8f2208a5@natae.notmuch> <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com> <dc14c50d-c626-19f8-e615-52ca3c9051dc@zytor.com> <xmqqfsyfqhkq.fsf@gitster.g> <60a976221c390_857e920812@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: RFC: error codes on exit
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
CC:     Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <3C6468D1-3E14-4600-BC8E-86CCCB84E74C@zytor.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No, please use the standardized numbers when they apply=2E

On May 22, 2021 2:22:42 PM PDT, Felipe Contreras <felipe=2Econtreras@gmail=
=2Ecom> wrote:
>Junio C Hamano wrote:
>> "H=2E Peter Anvin" <hpa@zytor=2Ecom> writes:
>>=20
>> > On 5/21/21 9:53 AM, Alex Henrie wrote:
>> >> On Wed, May 19, 2021 at 6:40 PM Felipe Contreras
>> >> <felipe=2Econtreras@gmail=2Ecom> wrote:
>> >>>
>> >>> It's good to not include many initial codes, but I would start
>with at
>> >>> least three:
>> >>>
>> >>>    OK =3D 0,
>> >>>    UNKNOWN =3D 1,
>> >>>    NORMAL =3D 2,
>> >> If you go that route, could you please pick a word other than
>> >> "normal"
>> >> to describe errors that are not entirely unexpected? I'm worried
>that
>> >> someone will see "normal" and use it instead of "OK" to indicate
>> >> success=2E
>> >>=20
>> >
>> > <sysexits=2Eh>
>>=20
>> Is the value assignment standardized across systems?
>
>I think his intention was to suggest to use that list as inspiration=2E=
=2E=2E
>As in have USAGE, NOINPUT, UNAVAILABE, etc=2E
>
>I would prefer to start with something easy=2E=2E=2E UNKNOWN =3D 1, USUAL=
 =3D 2=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
