Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F5920D13
	for <e@80x24.org>; Fri,  2 Jun 2017 09:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbdFBJt5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 05:49:57 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35006 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdFBJt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 05:49:56 -0400
Received: by mail-it0-f42.google.com with SMTP id m62so961434itc.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+N8BvX409l2pJHZFFChu2E+T4+4gfmiJ4XgICYn+MfU=;
        b=fXutTTdUElPXU1/nM4/Uf0JLu3p1LYjsRanFcRNZkIjyr92ShHkZDCyzui1UvvpSEl
         McVJSaqB6dt66b/hR1ZrrzypRnuWrYZLQetKDJXrAJ+T2NVELztNot9ET+ohiGA2F8Tv
         uUHv+5Gk5zlFNjwApUVfMTRcs9lCPIjpZfEqbEZchtGlwUPbWuTDkrTg5l3nXuevtk2d
         flgfrT/uwiEj6ZxOV6jqY3OrourL1BVq2G6oKEN2Fzfd4eImiPR2OtA6WEi8R/kA1kWp
         DoOhJr7CMnmAZzSg+7OYFNbDzgWue4rSZYX2m+wv+rk/C3otcrfp5w6Q13FLbcvop3oS
         AJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+N8BvX409l2pJHZFFChu2E+T4+4gfmiJ4XgICYn+MfU=;
        b=N9LIC1Odu4DePIFDGyCffHNUUhe+7/XDLE0EIbRwnHvKpQsG7uqwMxows5gbJhkIN2
         tJzL0GNgpfZ4kEBc8xohmDBsvturtSm6uJPZMddqUFycuBxFX4uTRkaWlEhbYCiMTUac
         JyLdEwAzoFUUWLDSwNTLZWepOZheZXev6foLDXFmhvOcTbmngyQyi1eMB2giwgAq3NP2
         hQPYIk9Zul0BEpJzQLbKPBMVjcqUXhQQmoF93bw18Z4UjEWBD46bHOvBRnDe9ZTA/lBv
         ClqClydlTGSxrbUKEdocR3ZoFmuEuMWe+8m3PYUwUyVRsrP8YhJQX4ybPBnnhuMXVvAE
         QhoA==
X-Gm-Message-State: AODbwcCv+b/COlX8lQIUU0SzhsmO2+bnPeCQGcTekJ4IW4fa40hztMMc
        fWjkTIIanOVbpGAYLgaJ1BKsS0iNig==
X-Received: by 10.98.11.196 with SMTP id 65mr5980273pfl.110.1496396994862;
 Fri, 02 Jun 2017 02:49:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.137.233 with HTTP; Fri, 2 Jun 2017 02:49:54 -0700 (PDT)
In-Reply-To: <CACBZZX7EvUqH28uni+r=RUBXb9=WTp732B4=rq+ViD_kecxZaw@mail.gmail.com>
References: <mvm4lw0un5n.fsf@suse.de> <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
 <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com> <mvmmv9st3yv.fsf@suse.de>
 <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
 <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
 <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
 <CAN0heSp9DpW4_0QL57_oAHGu+os8k6yd=Z5+0MJnaL6iXTa-qQ@mail.gmail.com>
 <xmqq37bj454a.fsf@gitster.mtv.corp.google.com> <CACBZZX7EvUqH28uni+r=RUBXb9=WTp732B4=rq+ViD_kecxZaw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 2 Jun 2017 11:49:54 +0200
Message-ID: <CAN0heSq3CSe=Hgygtzd+ZM4rW-qM1_chrNd7Pq0KnYnKEVXcpw@mail.gmail.com>
Subject: Re: Unaligned accesses in sha1dc
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@suse.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 June 2017 at 10:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:
> On Fri, Jun 2, 2017 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>
>>> I looked into this some more. It turns out it is possible to trigger
>>> undefined behavior on "next". Here's what I did:
>>> ...
>>>
>>> This "fixes" the problem:
>>> ...
>>> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
>>> index 3dff80a..d6f4c44 100644
>>> --- a/sha1dc/sha1.c
>>> +++ b/sha1dc/sha1.c
>>> @@ -66,9 +66,9 @@
>>> ...
>>> With this diff, various tests which seem relevant for SHA-1 pass,
>>> including t0013, and the UBSan-error is gone. The second diff is just
>>> a monkey-patch. I have no reason to believe I will be able to come up
>>> with a proper and complete patch for sha1dc. And I guess such a thing
>>> would not really be Git's patch to carry, either. But at least Git
>>> could consider whether to keep relying on undefined behavior or not.
>>>
>>> There's a fair chance I've mangled the whitespace. I'm using gmail's
>>> web interface... Sorry about that.
>>
>> Thanks.  I see Marc Stevens is CC'ed in the thread, so I'd expect
>> that the final "fix" would come from his sha1collisiondetection
>> repository via =C3=86var.
>>
>> In the meantime, I am wondering if it makes sense to merge the
>> earlier update with #ifdef ALLOW_UNALIGNED_ACCESS and #ifdef
>> SHA1DC_FORCE_LITTLEENDIAN for the v2.13.x maintenance track, which
>> would at least unblock those on platforms v2.13.0 did not work
>> correctly at all.
>>
>> =C3=86var, thoughts?
>
> I think we're mixing up several things here, which need to be untangled:
>
> 1) The sha1dc works just fine on most platforms even with undefined
> behavior, as evidenced by 2.13.0 working.

Right, with "platform" meaning "combination of hardware-architecture
and compiler". Nothing can be said about how the current code behaves
on "x86". Such statements can only be made with regard to "x86 and
this or that compiler". Even then, short of studying the compiler
implementation/documentation in detail, one cannot be certain that
seemingly unrelated changes in Git don't make the code do something
else entirely.

> 2) There was a bug in practice with unaligned access on SPARC. It's
> not clear to me whether anyone (Andreas, Liam?) still has any issues
> in practice on any platform without specifying compile flags like what
> Martin =C3=85gren suggested above.

True.

> 3) Now we have another issue reported by Martin =C3=85gren here, which is
> that while the code works in practice on most platforms it's using
> undefined behavior.
...
> I think that this is definitely something worth looking into /
> coordinating with upstream, but I haven't seen anything to suggest
> that we need to be rushing to get a patch in to fix this given 1) and
> nobody saying yet that 2) doesn't solve their issue as long as they're
> not supplying some -fsanitize=3D* flags.
>
> Now, stepping a bit back from this whole thing: I didn't read the
> entire discussion back in February when sha1dc was integrated, but I
> really don't see given all this churn / bug reporting we're getting
> now why another acceptable solution wouldn't be to just revert
> e6b07da278 ("Makefile: make DC_SHA1 the default", 2017-03-17) &
> release 2.13.1 with that.
>
> Clearly there are outstanding issues with it, and needing to do a
> memcpy() as my `next` patch does will harm performance on some
> platforms, and something like Martin's patch on top will slow it down
> even more.

The only thing in my second "patch" which could possibly affect
performance as I see it would be the call to memcpy(.. ,.. ,4),
including pointer-calculation. Focusing on x86, I would not say that
it "will" slow it down until I'd measured performance. I wouldn't even
rule out that the compiled assembler could be identical. I would just
say the patch "would most likely slow it down even more on some
architectures, with some compilers and/or with some
compiler-settings".

If undefined behavior is avoided with memcpy(.., .., 4) then there
should be no formal need for your "big" memcpy where things are copied
into a known-to-be-aligned buffer. The behavior will be defined on all
architectures, anyway. Then your memcpy would simply be part of an
optimization to prefer one big memcpy and many loads instead of many
small memcpy-calls. On some architectures, that might be a very good
optimization. But on others, if the small memcpy is compiled to a
simple load, then I believe such an optimization would most likely be
a slow-down (modulo crazy-clever compiler optimizations).

> It seems to me that we should give it more time to cook, and better
> understand the various trade-offs involved. The shattered attack is
> very unlikely to impact anything in practice, and users who are
> paranoid about it can opt-in to this extra protection.

Regarding reverting and cooking, I don't feel like I'm in a position
to express an opinion. Thanks for thinking about this undefined
behavior, though, and I hope I'm contributing in some way, although
I'm aware I'm just standing at the side-line, waving my hands, and not
contributing any actual code.
