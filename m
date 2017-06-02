Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9252027C
	for <e@80x24.org>; Fri,  2 Jun 2017 20:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbdFBUPO (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 16:15:14 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:34614 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbdFBUPN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 16:15:13 -0400
Received: by mail-it0-f44.google.com with SMTP id m47so6175596iti.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NjXxcbK0DsAxz/mfeBe2Hbt/og+dgQF+oeIueK7F9Dw=;
        b=MpGigiiKwBuvIM3jIWlvTEC5d9xaq43kFh2aGjar5MhuBBQbqCA/gUDF+IoWVYsG6Z
         U4Hpb1G96HjwBKYLVTWH8EAGxYYDsNP6Rm83SPZyvhsL4fjKa4dAvgQXAzQ0OLg1ThLP
         XHdnuO3kcOMtl6HAFoQvPcnf7gvRr4LLndn2Lvt/QlWYRxCbw18KjivDPPTHdfe10xlk
         1Y0v9Z3eSteW5gqgk+ueioSTSdCYi1Pt0hWbo6l5yApOpttg3BUPZ1Go94GKcj63PVXe
         rYOZvILf6ibVvpUQWfTKkEuctue5t6V/5N0LZmg+ohSlEdYDyxml7NoEUNwc2k4R1hGG
         4Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NjXxcbK0DsAxz/mfeBe2Hbt/og+dgQF+oeIueK7F9Dw=;
        b=BLduarfQM+YuPSlpx0RWP51c83deO3iXrH1QtNrgVLqLGjN6XUdYh6FRAu6vAOwFPY
         i7d/gZMF50qHAzC/olpeCMUCliXBTrNocSMX+8CYItiN7ASM1YjQXUE6hY0bHB0QGp5u
         8YnlnUCRpuU2mfm02vaBynxrmzXDam6gR5z/40dgI4TVthi/LiSG7kCtw3WB+yhlW5WZ
         4cJGa5MaQSa4VXAz5ZVV3Htt3BKvdhpJUY5NdiHz1P9JxtDUEcBPMDZzovFznBqFo66q
         KzaknvB+boR6ExYaEap9quhxOX2pz3zqPfLi2dV8uDSLYjFwRbznNRs7B4dCvETTcfJe
         6o/g==
X-Gm-Message-State: AODbwcCRc/p4hyjAZJNVw5YQzB8xOQVo/wbUNIN48/JIWswPzctUtLx2
        lccLoRkny9m7vJxsMAEy+pAbfAFkEQ==
X-Received: by 10.107.178.215 with SMTP id b206mr6079832iof.50.1496434512287;
 Fri, 02 Jun 2017 13:15:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.148.208 with HTTP; Fri, 2 Jun 2017 13:14:51 -0700 (PDT)
In-Reply-To: <CAN0heSoV3nPO1v=CWze4DfpnmBn7+wVLm3_4f4ouv+PSGMAd+w@mail.gmail.com>
References: <mvm4lw0un5n.fsf@suse.de> <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
 <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com> <mvmmv9st3yv.fsf@suse.de>
 <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
 <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
 <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
 <CAN0heSp9DpW4_0QL57_oAHGu+os8k6yd=Z5+0MJnaL6iXTa-qQ@mail.gmail.com>
 <xmqq37bj454a.fsf@gitster.mtv.corp.google.com> <CACBZZX7EvUqH28uni+r=RUBXb9=WTp732B4=rq+ViD_kecxZaw@mail.gmail.com>
 <CAN0heSq3CSe=Hgygtzd+ZM4rW-qM1_chrNd7Pq0KnYnKEVXcpw@mail.gmail.com>
 <CACBZZX5re5Ge1OzxYOE42nwBhhusya6=M9An08X-KzaqNH9Cog@mail.gmail.com> <CAN0heSoV3nPO1v=CWze4DfpnmBn7+wVLm3_4f4ouv+PSGMAd+w@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 2 Jun 2017 22:14:51 +0200
Message-ID: <CACBZZX7BReh=ssqp2HezWZsy8359SVXbBtWiJJNtHYXRVu_hXQ@mail.gmail.com>
Subject: Re: Unaligned accesses in sha1dc
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
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

On Fri, Jun 2, 2017 at 10:11 PM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> On 2 June 2017 at 21:32, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
>> On Fri, Jun 2, 2017 at 11:49 AM, Martin =C3=85gren <martin.agren@gmail.c=
om> wrote:
>>> On 2 June 2017 at 10:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
>>>> On Fri, Jun 2, 2017 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>>>>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>>>>
>>>>>> I looked into this some more. It turns out it is possible to trigger
>>>>>> undefined behavior on "next". Here's what I did:
>>>>>> ...
>>>>>>
>>>>>> This "fixes" the problem:
>>>>>> ...
>>>>>> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
>>>>>> index 3dff80a..d6f4c44 100644
>>>>>> --- a/sha1dc/sha1.c
>>>>>> +++ b/sha1dc/sha1.c
>>>>>> @@ -66,9 +66,9 @@
>>>>>> ...
>>>>>> With this diff, various tests which seem relevant for SHA-1 pass,
>>>>>> including t0013, and the UBSan-error is gone. The second diff is jus=
t
>>>>>> a monkey-patch. I have no reason to believe I will be able to come u=
p
>>>>>> with a proper and complete patch for sha1dc. And I guess such a thin=
g
>>>>>> would not really be Git's patch to carry, either. But at least Git
>>>>>> could consider whether to keep relying on undefined behavior or not.
>>>>>>
>>>>>> There's a fair chance I've mangled the whitespace. I'm using gmail's
>>>>>> web interface... Sorry about that.
>>>>>
>>>>> Thanks.  I see Marc Stevens is CC'ed in the thread, so I'd expect
>>>>> that the final "fix" would come from his sha1collisiondetection
>>>>> repository via =C3=86var.
>>>>>
>>>>> In the meantime, I am wondering if it makes sense to merge the
>>>>> earlier update with #ifdef ALLOW_UNALIGNED_ACCESS and #ifdef
>>>>> SHA1DC_FORCE_LITTLEENDIAN for the v2.13.x maintenance track, which
>>>>> would at least unblock those on platforms v2.13.0 did not work
>>>>> correctly at all.
>>>>>
>>>>> =C3=86var, thoughts?
>>>>
>>>> I think we're mixing up several things here, which need to be untangle=
d:
>>>>
>>>> 1) The sha1dc works just fine on most platforms even with undefined
>>>> behavior, as evidenced by 2.13.0 working.
>>>
>>> Right, with "platform" meaning "combination of hardware-architecture
>>> and compiler". Nothing can be said about how the current code behaves
>>> on "x86". Such statements can only be made with regard to "x86 and
>>> this or that compiler". Even then, short of studying the compiler
>>> implementation/documentation in detail, one cannot be certain that
>>> seemingly unrelated changes in Git don't make the code do something
>>> else entirely.
>>
>> I think you're veering into a theoretical discussion here that has
>> little to no bearing on the practicalities involved here.
>>
>> Yes if something is undefined behavior in C the compiler &
>> architecture is free to do anything they want with it. In practice
>> lots of undefined behavior is de-facto standardized across various
>> platforms.
>>
>> As far as I can tell unaligned access is one of those things. I don't
>> think there's ever been an x86 chip / compiler that would run this
>> code with any semantic differences when it comes to unaligned access,
>> and such a chip / compiler is unlikely to ever exist.
>>
>> I'm not advocating that we rely on undefined behavior willy-nilly,
>> just that we should consider the real situation is (i.e. what actual
>> architectures / compilers are doing or are likely to do) as opposed to
>> the purely theoretical (if you gave a bunch of aliens who'd never
>> heard of our technology the ANSI C standard to implement from
>> scratch).
>
> Yeah, that's an argument. I just thought I'd provide whatever input I
> could, albeit in text form. The only thing that matters in the end is
> that you (the Git project) feel that you make the correct decision,
> possibly going beyond "theoretical" reasoning into engineering-land.

I forgot to note, I think it would be very useful if you could submit
that patch of yours in cleaned up form to the upstream sha1dc project:
https://github.com/cr-marcstevens/sha1collisiondetection

They might be interested in taking it, even if it's guarded by some
macro "don't do unaligned access even on archs that seem OK with it".

My comments are just focusing on this in the context of whether we
should be hotfixing our copy due to an issue in the wild, like e.g.
the SPARC issue.
