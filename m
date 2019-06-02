Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E311F462
	for <e@80x24.org>; Sun,  2 Jun 2019 16:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfFBQ7h (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 12:59:37 -0400
Received: from mout.web.de ([212.227.17.11]:50747 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbfFBQ7h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 12:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559494732;
        bh=ExiY3Ma81HOesGWQA4m/z7FCFbI4ZEpiFS+x2ViVttI=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=HTkmuUcc1vdLjpkw1MB7hk3HnryiSsQpejE+G9Wa/PNIyeZYzya1nJuyL0OU/wwFc
         P9/OdOmSP9tGh19JMTRMin9yKmsodhQ2fhRaQpMtLTBLV82nqBBRt/PITUl65GFkMi
         MWIxgy21oPTgnMFyZ8naOZV8RGjcgWrYe3trSyrs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.20.65]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MIvbh-1hZxrB0BK5-002Y9j; Sun, 02
 Jun 2019 18:58:52 +0200
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: git archive generates tar with malformed pax extended attribute
To:     Jeff King <peff@peff.net>
Cc:     Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
References: <20190524070644.GF25694@sigill.intra.peff.net>
 <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
 <20190524081337.GA9082@sigill.intra.peff.net>
 <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
 <20190528055805.GB7946@sigill.intra.peff.net>
 <5b312f6c-3375-66ba-efc7-931e4ddc4b11@web.de>
 <20190528190815.GA20499@sigill.intra.peff.net>
 <5f9ac691-4cb1-a15d-ca44-63fb64994d59@web.de>
 <20190529011744.GA22340@sigill.intra.peff.net>
 <24574d74-b6ca-6d36-759f-32cf26b36c3f@web.de>
 <20190530115554.GB31607@sigill.intra.peff.net>
Message-ID: <c961d89d-db0b-597f-c183-81aa791c0987@web.de>
Date:   Sun, 2 Jun 2019 18:58:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530115554.GB31607@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iWkpYNXHBCiYyfRt5TJUV+4+HVm6gQanilD28xT6KND4Nt8AuNr
 3cecE6m9aI1MBS3mbnX8iXseMQRhPkIjMh+fOlL4lD8ftVna7rWwWqqdWqpiOKfTlE1VNOm
 GR1ABaGIhENry0XcAfCA55akiZUV33cfzkqXaPrSzvr8j6i91gHJplnJOSIWeZzVlbFzpWB
 53R7Pj2kHFh6tOfH6b6dw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xhM1tsl2vEQ=:scfFedlE+Q3mY925IgxfPk
 aQHokzzbd2d3BYbzVossyWuq2vUsgJuZmdCp/VkoEqZ4PrS+JsjmgI1ERb2Czf9NtFhPsD083
 1yLseDX8F7SKwGMEtNSLjD1rHnNhpCs3ohdbMBaIwXWeH3BJcudXcIBgcYkcRzTU88NuGtA2u
 2jPut9qOHFaNhCIQARxL8VXhdF0OSAN/Pn0LfxTvKVq/VxIal+W4m+7+efVybJpFYD9RpPanV
 e/BikVUYrMK70xWDhUpVNDs4mUPi66ZbgrXmejbrD4yTcq+cKBEa7btwcFmMwp3PnOCDRNGj4
 AfzkccuwNXFB5Xhii2Bgz7syyzpyW3knDBf/FP2b5v9TbkgTmIJDu0tGmQ55FlmCeJJbV0VZ2
 g9lrfJnj14F6u0RVrcLKQo1GnOytXC7Jzj73whq1IgMCESquqXQeYB/a2jwwouQCbSopoTD8x
 9iZh5ZhTGz5odvREI8s++fUj7neLCpSzpQvG1rqQNEnDSrWn0tTbniEVa/LFMkuqQCBe3kiEh
 8l8ei+2a/3TJnEcLngn6nDwKpttplwV9HTJ/gNU7P8/P3hX7oBfGtvkP06TtBbpiraZ/w/Lin
 cS2o9jvWIiAm+8bZjmqjkO1dIbno33/nrB+jXPoUHel0MVNJbeotP4gZ3ySaY6PzJ1/T05V+b
 KBFXdVpePzQdSKZTZhaIH17SuvMJPK0QN7b0osug3IBr4ItChlKItQmbJUtoU5BRb7hjrlH3b
 2XLbYkyhQp8ErHZ1EAKO1qqvUsuvR997zSHN+qXq/7b7PyF2AYaK+/qLsl3EhDs0iQ/VViCvr
 WyI3Fp5H00iKAzYYt1YfdTqhAsPqbrjiSK05xDhgAeU4iCkdK17izXGsEOUDiuSifp3s74Bm1
 Tks0N01V1CzerTOay5+FrWUefqgHxuLSskcTAFJPkIzv+QeZ+wAw0B/ZURPwuAKLLNO3iRIIE
 aOZmyjpwQxjTT3tABo7lyAP0eIPrxHAY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.05.19 um 13:55 schrieb Jeff King:
> On Wed, May 29, 2019 at 07:54:44PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Am 29.05.19 um 03:17 schrieb Jeff King:
>>> But here the problem is in the tree, not the blob. So we're not findin=
g
>>> suspect blobs, but rather re-checking each tree. And no matter what we
>>> do (whether it's visiting the object again, or creating a set or mappi=
ng
>>> with the object names) is going to be linear there. And a repository
>>> with a symlink in the root tree is going to revisit or put in our
>>> mapping every single root tree.
>>
>> That's true, potentially it needs remember and/or reprocess all trees,
>> meaning this check may double the run time of fsck in the worst case.
>> Example from the wild: The kernel repo currently has 36 symlinks and
>> 6+ million objects are checked in total, and the symlink check processe=
s
>> 18943 trees_with_symlinks entries there.
>
> That sounds about right. It's basically every version of every tree that
> has a symlink. Did it make a noticeable difference in timing? Indexing
> the whole kernel history is already a horribly slow process. :)

Right, I didn't notice a difference -- no patience for watching that
thing to the end.  But here are some numbers for v2.21.0 vs. master with
the patch:

Benchmark #1: git fsck
  Time (mean =C2=B1 =CF=83):     307.775 s =C2=B1  9.054 s    [User: 307.1=
73 s, System: 0.448 s]
  Range (min =E2=80=A6 max):   294.052 s =E2=80=A6 322.931 s    10 runs

Benchmark #2: ~/src/git/git fsck
  Time (mean =C2=B1 =CF=83):     319.754 s =C2=B1  2.255 s    [User: 318.9=
27 s, System: 0.671 s]
  Range (min =E2=80=A6 max):   316.376 s =E2=80=A6 323.747 s    10 runs

Summary
  'git fsck' ran
    1.04 =C2=B1 0.03 times faster than '~/src/git/git fsck'

Seeing only a single CPU core being stressed for that long is a bit sad
to see.  Checking individual objects should be relatively easy to
parallelize, shouldn't it?

Ren=C3=A9
