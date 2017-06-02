Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8E92027C
	for <e@80x24.org>; Fri,  2 Jun 2017 20:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbdFBUZK (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 16:25:10 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35889 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdFBUZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 16:25:09 -0400
Received: by mail-lf0-f49.google.com with SMTP id o83so416089lff.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HugKEOOJpkMpa4ZHyMAc9Ni+G14+litBJ8tWHDkR5ko=;
        b=ulDSarZfp8IY4/6+JHN8TMjDDyt+fhpdO5NkxkYB8L2yKhSvjSRyJYrkJSEx/ABHR8
         +EHySBqRBajjIshc1Nkj9jBsVGfBjjz2krZPPN5f0ZB6JrToAqNzpYGsuosfatdx54VQ
         9XsBT5pBGWL21QsLinU2OoM8ihq/m8I2O7eqzCPcASOZcquU7xZEVP9dNAONBmB4yiEa
         CHyQ+MrrAaPzZRy1tic308kbJULFe+uJLpKaySKUZUx4Vu0g26q0P12lPdRmt0uykvmW
         Bq6JrzZ0VSK633MWrQza8dGG0xJ8+mW35a2I71UbDGW7qXWHmYmF+cNSNGqhbljklmD2
         B3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HugKEOOJpkMpa4ZHyMAc9Ni+G14+litBJ8tWHDkR5ko=;
        b=ldKxCM1fYRmHPtFc3NsxJ/sIuQ4xcSnmMvAoSHfQMTWvLoHrXgf8S3gGsTNP4Pkzj2
         z9ov4CFX0SklFJN1tLqXlSYEFWxzvGp6+6xUrSTd2NlpXCsNSDFXOUMfe9wOC77Pr4+D
         EScrxMMpAjASjGDBB7+kPG0+u9M4dMpJd80YxEfmRml9005gIihdXJxFPNhKcHkYnEi6
         Z9NKlPE99K3KXu0gpearo5WmMtCDnf12GcMPkLlTqKyPEtkIM7PwKzcjqHvdcd/l4E3n
         t7EQd/k5XX5eII1JC786d3RJNmOlge2lbFKvhkKhx7EykZm03YDTCjRV1RZqK+4gARJP
         Y2nw==
X-Gm-Message-State: AODbwcBdBlI56ILAmqZrr4n1Itai+6tN9hCf3Waiapi0orv8Hd3vazd3
        1SvJ5DKM+joZ2PJWct0Ib+Bpq2TuEQ==
X-Received: by 10.25.27.196 with SMTP id b187mr2795197lfb.62.1496435107968;
 Fri, 02 Jun 2017 13:25:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.217.20 with HTTP; Fri, 2 Jun 2017 13:25:07 -0700 (PDT)
In-Reply-To: <CACBZZX7BReh=ssqp2HezWZsy8359SVXbBtWiJJNtHYXRVu_hXQ@mail.gmail.com>
References: <mvm4lw0un5n.fsf@suse.de> <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
 <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com> <mvmmv9st3yv.fsf@suse.de>
 <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
 <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
 <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
 <CAN0heSp9DpW4_0QL57_oAHGu+os8k6yd=Z5+0MJnaL6iXTa-qQ@mail.gmail.com>
 <xmqq37bj454a.fsf@gitster.mtv.corp.google.com> <CACBZZX7EvUqH28uni+r=RUBXb9=WTp732B4=rq+ViD_kecxZaw@mail.gmail.com>
 <CAN0heSq3CSe=Hgygtzd+ZM4rW-qM1_chrNd7Pq0KnYnKEVXcpw@mail.gmail.com>
 <CACBZZX5re5Ge1OzxYOE42nwBhhusya6=M9An08X-KzaqNH9Cog@mail.gmail.com>
 <CAN0heSoV3nPO1v=CWze4DfpnmBn7+wVLm3_4f4ouv+PSGMAd+w@mail.gmail.com> <CACBZZX7BReh=ssqp2HezWZsy8359SVXbBtWiJJNtHYXRVu_hXQ@mail.gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Fri, 2 Jun 2017 22:25:07 +0200
Message-ID: <CANgJU+XjVpc2vJ3bdY1MReRq0hZL3PPOQhNwAGvqrh7ZThLV-Q@mail.gmail.com>
Subject: Re: Unaligned accesses in sha1dc
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
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

On 2 June 2017 at 22:14, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:
> On Fri, Jun 2, 2017 at 10:11 PM, Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
>> On 2 June 2017 at 21:32, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com> wrote:
>>> On Fri, Jun 2, 2017 at 11:49 AM, Martin =C3=85gren <martin.agren@gmail.=
com> wrote:
>>>> On 2 June 2017 at 10:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>>>>> On Fri, Jun 2, 2017 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>>>>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>>>>>
>>>>>>> I looked into this some more. It turns out it is possible to trigge=
r
>>>>>>> undefined behavior on "next". Here's what I did:
>>>>>>> ...
>>>>>>>
>>>>>>> This "fixes" the problem:
>>>>>>> ...
>>>>>>> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
>>>>>>> index 3dff80a..d6f4c44 100644
>>>>>>> --- a/sha1dc/sha1.c
>>>>>>> +++ b/sha1dc/sha1.c
>>>>>>> @@ -66,9 +66,9 @@
>>>>>>> ...
>>>>>>> With this diff, various tests which seem relevant for SHA-1 pass,
>>>>>>> including t0013, and the UBSan-error is gone. The second diff is ju=
st
>>>>>>> a monkey-patch. I have no reason to believe I will be able to come =
up
>>>>>>> with a proper and complete patch for sha1dc. And I guess such a thi=
ng
>>>>>>> would not really be Git's patch to carry, either. But at least Git
>>>>>>> could consider whether to keep relying on undefined behavior or not=
.
>>>>>>>
>>>>>>> There's a fair chance I've mangled the whitespace. I'm using gmail'=
s
>>>>>>> web interface... Sorry about that.
>>>>>>
>>>>>> Thanks.  I see Marc Stevens is CC'ed in the thread, so I'd expect
>>>>>> that the final "fix" would come from his sha1collisiondetection
>>>>>> repository via =C3=86var.
>>>>>>
>>>>>> In the meantime, I am wondering if it makes sense to merge the
>>>>>> earlier update with #ifdef ALLOW_UNALIGNED_ACCESS and #ifdef
>>>>>> SHA1DC_FORCE_LITTLEENDIAN for the v2.13.x maintenance track, which
>>>>>> would at least unblock those on platforms v2.13.0 did not work
>>>>>> correctly at all.
>>>>>>
>>>>>> =C3=86var, thoughts?
>>>>>
>>>>> I think we're mixing up several things here, which need to be untangl=
ed:
>>>>>
>>>>> 1) The sha1dc works just fine on most platforms even with undefined
>>>>> behavior, as evidenced by 2.13.0 working.
>>>>
>>>> Right, with "platform" meaning "combination of hardware-architecture
>>>> and compiler". Nothing can be said about how the current code behaves
>>>> on "x86". Such statements can only be made with regard to "x86 and
>>>> this or that compiler". Even then, short of studying the compiler
>>>> implementation/documentation in detail, one cannot be certain that
>>>> seemingly unrelated changes in Git don't make the code do something
>>>> else entirely.
>>>
>>> I think you're veering into a theoretical discussion here that has
>>> little to no bearing on the practicalities involved here.
>>>
>>> Yes if something is undefined behavior in C the compiler &
>>> architecture is free to do anything they want with it. In practice
>>> lots of undefined behavior is de-facto standardized across various
>>> platforms.
>>>
>>> As far as I can tell unaligned access is one of those things. I don't
>>> think there's ever been an x86 chip / compiler that would run this
>>> code with any semantic differences when it comes to unaligned access,
>>> and such a chip / compiler is unlikely to ever exist.
>>>
>>> I'm not advocating that we rely on undefined behavior willy-nilly,
>>> just that we should consider the real situation is (i.e. what actual
>>> architectures / compilers are doing or are likely to do) as opposed to
>>> the purely theoretical (if you gave a bunch of aliens who'd never
>>> heard of our technology the ANSI C standard to implement from
>>> scratch).
>>
>> Yeah, that's an argument. I just thought I'd provide whatever input I
>> could, albeit in text form. The only thing that matters in the end is
>> that you (the Git project) feel that you make the correct decision,
>> possibly going beyond "theoretical" reasoning into engineering-land.
>
> I forgot to note, I think it would be very useful if you could submit
> that patch of yours in cleaned up form to the upstream sha1dc project:
> https://github.com/cr-marcstevens/sha1collisiondetection
>
> They might be interested in taking it, even if it's guarded by some
> macro "don't do unaligned access even on archs that seem OK with it".
>
> My comments are just focusing on this in the context of whether we
> should be hotfixing our copy due to an issue in the wild, like e.g.
> the SPARC issue.

A good way to get the sha1dc project properly tests on all platforms
would be to wrap it in a cpan distribution and let cpants (cpan
testers) test it for you on all the platforms under the sun.

In the Sereal project we found and fixed many portability issues with
the csnappy code simply because there are people testing modules in
the cpan world on every platform you can think of, and a few you might
be surprised to find out people still use.

Yves

Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
