Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8178FC28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 11:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D1B21655
	for <git@archiver.kernel.org>; Sat,  9 May 2020 11:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="mMQiyjqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgEILv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 07:51:59 -0400
Received: from mout.web.de ([217.72.192.78]:42601 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgEILv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 07:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589025107;
        bh=TfXEBMPUgt50XYeBcnKNrGTJFp4Kv2Iipz2JSasgeo0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mMQiyjqPLXlcF8kytuNB6/0Vm0oQxoo4OktO9mCSqRhniJmkgaXHcFVldHB52VgFA
         zWB6/YZX0DzKLM1i4zcOJE+4n7f4Ye5MK4VVubK79bhjJLcZMB8e96slNNJjP1mjVd
         RhnXpzb83JD2yC7k2xWlJvUyibuPGg5qbUJi8Nf0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MC1fA-1jOcap3Dnc-008orI; Sat, 09
 May 2020 13:51:47 +0200
Subject: Re: invalid tree and commit object
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
 <nycvar.QRO.7.76.6.2005090915020.56@tvgsbejvaqbjf.bet>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <142b7944-e151-2160-2fbe-e277f16033c9@web.de>
Date:   Sat, 9 May 2020 13:51:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2005090915020.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DMdT7eDmY+B2ib2wrvQPywmiNp4v/rYmw8Z+j+vMrwcoP1priRC
 5EnFDuXlerm/BdOrQpmIsBI//BGz4U8dqi6Rpzugk2V3CBKZ+t+l32JWX++13KbSyGTKcEQ
 tqsgwfW8EQc666LMMu00bqugKnilMMxTNmJlNet0Cb6zYI+c7F10ItNu6cMt+pK9i7/UqRi
 y0e7z/CrJDvFq/OuPjlMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EDH65E4TDdI=:bBBpufskXrhNxddcqOSe2y
 que1RwAeYfglJDiE5NFo/B2EYSHFhw15HBfixcTpxsMx3h3DmKcXiQBBMd3qxgyCCoYrSFL5S
 O9B4HAa7DG+EqaY8Nn7fb1Q68u8VE+ySMTB0Jw6mfp7aEgaICKa/CTs5F+a5B60MDpjsIbMPW
 pdRBgPAZN2BDbG/8tqe8QxWI6aqh+JAaxqDBne3xUIugfeVNxVZqCYtKkyoO/dVeYEBB0mA80
 XiSLMbx+dODi7ObfzDVuLYOCzMjNJ2PldFC41wjIefWNJaMaua0NEmd9xT0lpz4FA0tDUTQww
 k4fyI0IbkWgRfqAzsAeJ7jhin0KaEzl+hisZmq24q5KwCvmd9aVl5eKNeDl+rUE27BIp0cXfa
 wSlTpfIbK+YnR+9W1biD9VcjR8J0JI3PI0fEV4O6MY4eh0Pl1XQ9+LMLB71hR4afjAVW86xQ4
 TQ4CPq/J8C/AGCfIwvmNloTkog3iFLMMc/EX/zeG1veM+6BeRQ5vazYvhjqwzw4a92C5Dn4OB
 R34b1eu3qq/0RlmQFFnwP4qxCbIlXQrW6apOxn2VOiUtwF5j7+HcM02So0Ut0bJVeqLDJ31ld
 I5hyuhYQ8mE9XYX/OVztkLCyC/Qd5EB1yCZcOGEW/2E0ONc59/GB+CxiMh1shwstdVkr0KQam
 WvM9xCdqtvZUMPolj/OxWAI6kRRn3GsBYv8ZbtcRo8GeQbLAQ5axGS4QLyQ1bmBNSp63L9mS4
 5GexKCfBR62jNTi6bpCokCzuYawgd3nS/q96POlRwJfCLk1m+odukP0K00+XFDiz5P7ZoSbgl
 sLh6BbyKmVmmLqW2k2Q1SLrpzc15ule7f/3iAD2+uMJYT5Sf8l8hi9T8ON/l+OS7nDgN2W6YD
 UWH06hF8uBriXty8+MSOtSs9+OHYAf4Xp7NKdtmEZhXBvTkBSFKamhnBD/0T8c7MtXT+O/NzI
 36MlLxsNBmOZW469MWnbX+9od4mLGeGV5SJdbV50KW8vFdj/byHxFXmoAFmZ/jqDy8PAiRTSL
 LOpeUM1lo5YmD72ZiTEH6iOI9kmzmfRIcHsIiHLEezi3J9ob3qHcc7Jbt+7OV0IGT+57HOK2V
 1jPChMtH1nKegV50X6dL1VU2w0Pxdxvfc5LrOJyJ1AApXmluX0J+3lndPFLD+kNCKSvYQB7Xg
 qP4SXHNwi6zS5Mw9OA1GShUKm+oLtnugHNbhIdbsaMKB+hiMLRrkRitIB+OewG/D9vBErQsFf
 qBN2FLraOEWhQXiYv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.05.20 um 09:16 schrieb Johannes Schindelin:
> Hi,
>
> On Sat, 9 May 2020, Ren=C3=A9 Scharfe wrote:
>
>> Am 09.05.20 um 08:19 schrieb Brandon Williams:
>>> Here's the setup:
>>>     tree c63d067eaeed0cbc68b7e4fdf40d267c6b152fe8
>>>     tree 6241ab2a5314798183b5c4ee8a7b0ccd12c651e6
>>>     blob 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
>>>
>>>     $ git ls-tree c63d067eaeed0cbc68b7e4fdf40d267c6b152fe8
>>>     100644 blob 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689    hello
>>>     100644 blob 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689    hello.c
>>>     040000 tree 6241ab2a5314798183b5c4ee8a7b0ccd12c651e6    hello
>>
>>> Am I correct in assuming that this object is indeed invalid and should=
 be
>>> rejected by fsck?
>>
>> I'd say yes twice -- what good is a tree that you can't check out becau=
se
>> it contains a d/f conflict?
>>
>> So I got curious if such trees might be in popular repos, wrote the pat=
ch
>> below and checked around a bit, but couldn't find any.
>>
>> Is there a smarter way to check for duplicates?  One that doesn't need
>> allocations?  Perhaps by having a version of tree_entry_extract() that
>> seeks backwards somehow?
>
> Maybe we should verify that the entries are sorted? That would not need
> any allocation, and it could even use the return value of the same
> comparison we already perform to check for duplicates.

Yes, but the key question is: Sorted by what?  Tree entries are sorted
by name, only that a slash is appended implicitly to the name of entries
of type tree.  The current code already checks for duplicates by
comparing neighboring entries' names.  That's not sufficient to find
duplicates that differ in type, as Brandon's example above shows (which
is sorted correctly).

Ren=C3=A9
