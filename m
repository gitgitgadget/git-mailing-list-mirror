Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E4762027C
	for <e@80x24.org>; Fri,  2 Jun 2017 20:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdFBUL2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 16:11:28 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35951 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdFBUL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 16:11:27 -0400
Received: by mail-pg0-f53.google.com with SMTP id x64so11621591pgd.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A3HqCUGwe5Pxs84Ri6w6+vD1CgMBa+JUqz33o/6rhEw=;
        b=cCWt6UCBCo+S/UaUI9zL2xDFrkwa8X8gun6VZOqmDJbZ7b/2/yrrnGhtqeuI6m5YhD
         /odIiu01Nh1t/Dhov9bJC4dUqPD9ZMF61G5MuTN+Mj773DZyHbly3BdCm+JzCzHk7sWC
         QYKJQGgogEwftcdgpN5QuPTeiOXUJNoVyfg3le0bE8BQvsoUU+OFVRFwawZyenzFL+gP
         rEHkI1ohQ66FPdO8FezaVaL9tQyWpB2JVzApZh1jBHn+/6G4NTvjefaYV5SxGKewLkaV
         ludvuL8y6fGLaLp25ic/8+gxBjBGkI5Aiy7XurN1tV1pbxolxI4nEHoO6kRVkJ7cohzl
         ynvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A3HqCUGwe5Pxs84Ri6w6+vD1CgMBa+JUqz33o/6rhEw=;
        b=Os7VMY/SCPikDstNTJr+PwDDj+q0U9+X7p2VV0OgPSvZRaQat1SWy7RnRkdg9ll41y
         hdVeHB8qMqAsGXYGImlPUZHLkosjr1CXozjqXMHeORy8YUlDmBT8huwy/I90XAgaAzCj
         Pu6xQwXTssX/4saMi2Sh02VYZmcneYmIBBBczDUOy80nEDBWHH7eAeCeVrk3OUcP+nOB
         iZFypH11fPalB7Og4CIOwP4moB3j8PINK1OGC/pLkY83l08owcoo1bDiIJOazQK1KJjg
         QCmFfxEfWyTJbuoUZckRk+2x4DDntAj3FLfG5kYsGfqCxqm1j05jpCmoNIpuSKcBT7Wg
         aZSw==
X-Gm-Message-State: AODbwcBtQrLjGD44EvNb2KoP+Vig0uiv1xGgfVUi97zvIWvJSP3BNDK5
        fptQ5bIULPwFJ/IL3yeo4gsUv76n0g==
X-Received: by 10.84.224.205 with SMTP id k13mr1536002pln.279.1496434286682;
 Fri, 02 Jun 2017 13:11:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.137.233 with HTTP; Fri, 2 Jun 2017 13:11:25 -0700 (PDT)
In-Reply-To: <CACBZZX5re5Ge1OzxYOE42nwBhhusya6=M9An08X-KzaqNH9Cog@mail.gmail.com>
References: <mvm4lw0un5n.fsf@suse.de> <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
 <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com> <mvmmv9st3yv.fsf@suse.de>
 <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
 <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
 <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
 <CAN0heSp9DpW4_0QL57_oAHGu+os8k6yd=Z5+0MJnaL6iXTa-qQ@mail.gmail.com>
 <xmqq37bj454a.fsf@gitster.mtv.corp.google.com> <CACBZZX7EvUqH28uni+r=RUBXb9=WTp732B4=rq+ViD_kecxZaw@mail.gmail.com>
 <CAN0heSq3CSe=Hgygtzd+ZM4rW-qM1_chrNd7Pq0KnYnKEVXcpw@mail.gmail.com> <CACBZZX5re5Ge1OzxYOE42nwBhhusya6=M9An08X-KzaqNH9Cog@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 2 Jun 2017 22:11:25 +0200
Message-ID: <CAN0heSoV3nPO1v=CWze4DfpnmBn7+wVLm3_4f4ouv+PSGMAd+w@mail.gmail.com>
Subject: Re: Unaligned accesses in sha1dc
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@suse.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 June 2017 at 21:32, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:
> On Fri, Jun 2, 2017 at 11:49 AM, Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
>> On 2 June 2017 at 10:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com> wrote:
>>> On Fri, Jun 2, 2017 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>>>
>>>>> I looked into this some more. It turns out it is possible to trigger
>>>>> undefined behavior on "next". Here's what I did:
>>>>> ...
>>>>>
>>>>> This "fixes" the problem:
>>>>> ...
>>>>> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
>>>>> index 3dff80a..d6f4c44 100644
>>>>> --- a/sha1dc/sha1.c
>>>>> +++ b/sha1dc/sha1.c
>>>>> @@ -66,9 +66,9 @@
>>>>> ...
>>>>> With this diff, various tests which seem relevant for SHA-1 pass,
>>>>> including t0013, and the UBSan-error is gone. The second diff is just
>>>>> a monkey-patch. I have no reason to believe I will be able to come up
>>>>> with a proper and complete patch for sha1dc. And I guess such a thing
>>>>> would not really be Git's patch to carry, either. But at least Git
>>>>> could consider whether to keep relying on undefined behavior or not.
>>>>>
>>>>> There's a fair chance I've mangled the whitespace. I'm using gmail's
>>>>> web interface... Sorry about that.
>>>>
>>>> Thanks.  I see Marc Stevens is CC'ed in the thread, so I'd expect
>>>> that the final "fix" would come from his sha1collisiondetection
>>>> repository via =C3=86var.
>>>>
>>>> In the meantime, I am wondering if it makes sense to merge the
>>>> earlier update with #ifdef ALLOW_UNALIGNED_ACCESS and #ifdef
>>>> SHA1DC_FORCE_LITTLEENDIAN for the v2.13.x maintenance track, which
>>>> would at least unblock those on platforms v2.13.0 did not work
>>>> correctly at all.
>>>>
>>>> =C3=86var, thoughts?
>>>
>>> I think we're mixing up several things here, which need to be untangled=
:
>>>
>>> 1) The sha1dc works just fine on most platforms even with undefined
>>> behavior, as evidenced by 2.13.0 working.
>>
>> Right, with "platform" meaning "combination of hardware-architecture
>> and compiler". Nothing can be said about how the current code behaves
>> on "x86". Such statements can only be made with regard to "x86 and
>> this or that compiler". Even then, short of studying the compiler
>> implementation/documentation in detail, one cannot be certain that
>> seemingly unrelated changes in Git don't make the code do something
>> else entirely.
>
> I think you're veering into a theoretical discussion here that has
> little to no bearing on the practicalities involved here.
>
> Yes if something is undefined behavior in C the compiler &
> architecture is free to do anything they want with it. In practice
> lots of undefined behavior is de-facto standardized across various
> platforms.
>
> As far as I can tell unaligned access is one of those things. I don't
> think there's ever been an x86 chip / compiler that would run this
> code with any semantic differences when it comes to unaligned access,
> and such a chip / compiler is unlikely to ever exist.
>
> I'm not advocating that we rely on undefined behavior willy-nilly,
> just that we should consider the real situation is (i.e. what actual
> architectures / compilers are doing or are likely to do) as opposed to
> the purely theoretical (if you gave a bunch of aliens who'd never
> heard of our technology the ANSI C standard to implement from
> scratch).

Yeah, that's an argument. I just thought I'd provide whatever input I
could, albeit in text form. The only thing that matters in the end is
that you (the Git project) feel that you make the correct decision,
possibly going beyond "theoretical" reasoning into engineering-land.

Take care,
Martin
