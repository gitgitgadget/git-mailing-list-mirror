Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A168A2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 20:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbdFBUjC (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 16:39:02 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35067 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdFBUjB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 16:39:01 -0400
Received: by mail-it0-f42.google.com with SMTP id m62so17487784itc.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LCACSocYICZhFkVsWY0PJ7GOTp46lmqVDrEjzAPLnfI=;
        b=Vi+va4ytHUNGloCMvvFHBwQlDdUMOdt3yZoOcgzkeWyBh1xLF1t/NiH5vZQC0YQznO
         x7MzAEADzQCac2w2nnr3Sh47xLGYvs3DLaqogEavIRD8ltiisdwCY1tpKjIibn1rRuQt
         piuB5poVRFSuRQnSu6+E1P18HifkvM24AE5k5zkq2cqOO20mtoSA+dujSzjCwnqKuni8
         Vq2YJoN3+w8LwCD0ekxEH2pWhr/9jWHB3wIPhK0XfeqcSVcjeWiGRHLusaQZUHqDd7Jn
         Uc2GvJIub+JdOzuEypnxLwCQqW4GExY8OF0nQv5ItmAsktYbB0F4oxIjDTol9S1GLMqT
         Q3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LCACSocYICZhFkVsWY0PJ7GOTp46lmqVDrEjzAPLnfI=;
        b=ujcO32Bgp33qdekNTy768AZM/+96BJHUZxrTy3GCjkxlbtiP6WsZ0t3jI2Z/oRCwqf
         PncEaLmTW/pioauVgmhowbOza7/pbcobJbrNsVw4zrsbh/Kkf4ZhWeNX0GGQMxw15V9p
         LrvktovX0IKH9dgiKgF3ol/T2ZD9eFXJwz7vKsFolv0xwHNVYYsGEQdiS18ZoY0rTfDw
         l8rfu2AdCaD+r/7B2TabJZzns1HkjXZipQz2eCEzwcFDBSzXd/3hzhD4u4PpXhbPATSm
         g3K0dpxzxXZJNwlDq7o4K53AQGIVDvc5yBaUDZ4aPF3ZL8rYMmbfz0wZko7kcKmO2ILm
         s5HQ==
X-Gm-Message-State: AODbwcDqNAqyvPyuqMV7P/5Cfo0h3xmSAF16P4aTZaYEKssAiAOar3Uf
        b2nBtPrpbypxSZ6BFVmexC5Oo67qYQ==
X-Received: by 10.107.201.131 with SMTP id z125mr9181859iof.160.1496435940180;
 Fri, 02 Jun 2017 13:39:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Fri, 2 Jun 2017 13:38:39 -0700 (PDT)
In-Reply-To: <CANgJU+UzoaN3Urj=L4unMMtNwFm6G8LGxx19g49AR5R+76F2OA@mail.gmail.com>
References: <mvm4lw0un5n.fsf@suse.de> <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
 <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com> <mvmmv9st3yv.fsf@suse.de>
 <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
 <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
 <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
 <CAN0heSp9DpW4_0QL57_oAHGu+os8k6yd=Z5+0MJnaL6iXTa-qQ@mail.gmail.com>
 <xmqq37bj454a.fsf@gitster.mtv.corp.google.com> <CACBZZX7EvUqH28uni+r=RUBXb9=WTp732B4=rq+ViD_kecxZaw@mail.gmail.com>
 <CAN0heSq3CSe=Hgygtzd+ZM4rW-qM1_chrNd7Pq0KnYnKEVXcpw@mail.gmail.com>
 <CACBZZX5re5Ge1OzxYOE42nwBhhusya6=M9An08X-KzaqNH9Cog@mail.gmail.com> <CANgJU+UzoaN3Urj=L4unMMtNwFm6G8LGxx19g49AR5R+76F2OA@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 2 Jun 2017 22:38:39 +0200
Message-ID: <CACBZZX5ZLGpZFnPcGiohMTAk9ShBZe0Mrx2s42xNhmK_zPApDg@mail.gmail.com>
Subject: Re: Unaligned accesses in sha1dc
To:     demerphq <demerphq@gmail.com>
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

On Fri, Jun 2, 2017 at 10:17 PM, demerphq <demerphq@gmail.com> wrote:
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
>>
>> Here's a performance test of your patch above against p3400-rebase.sh.
>> I don't know how much these error bars from t/perf can be trusted.
>> This is over 30 runs with -O3:
>>
>> - 3400.2: rebase on top of a lot of unrelated changes
>>   v2.12.0     : 1.25(1.10+0.06)
>>   v2.13.0     : 1.21(1.06+0.06) -3.2%
>>   origin/next : 1.22(1.04+0.07) -2.4%
>>   martin        : 1.23(1.06+0.07) -1.6%
>> - 3400.4: rebase a lot of unrelated changes without split-index
>>   v2.12.0     : 6.49(3.60+0.52)
>>   v2.13.0     : 8.21(4.18+0.55) +26.5%
>>   origin/next : 8.27(4.34+0.64) +27.4%
>>   martin        : 8.80(4.36+0.62) +35.6%
>> - 3400.6: rebase a lot of unrelated changes with split-index
>>   v2.12.0     : 6.77(3.56+0.51)
>>   v2.13.0     : 4.09(2.67+0.38) -39.6%
>>   origin/next : 4.13(2.70+0.36) -39.0%
>>   martin        : 4.30(2.80+0.32) -36.5%
>>
>> And just your patch v.s. next:
>>
>> - 3400.2: rebase on top of a lot of unrelated changes
>>   origin/next : 1.22(1.06+0.06)
>>   martin      : 1.22(1.06+0.05) +0.0%
>> - 3400.4: rebase a lot of unrelated changes without split-index
>>   origin/next : 7.54(4.13+0.60)
>>   martin      : 7.75(4.34+0.67) +2.8%
>> - 3400.6: rebase a lot of unrelated changes with split-index
>>   origin/next : 4.19(2.92+0.31)
>>   martin      : 4.14(2.84+0.39) -1.2%
>>
>> It seems to be a bit slower, is that speedup worth the use of
>> unaligned access? I genuinely don't know. I'm just interested to find
>> what if anything we need to urgently fix in a release version of git.
>>
>> One data point there is that the fallback blk-sha1 implementation
>> we've shipped since 2009 has the same errors about unaligned access as
>> before your patch with -fsanitize[..], and looking at the commit
>> message this was something Linus knew about at the time, see
>> d7c208a92e ("Add new optimized C 'block-sha1' routines", 2009-08-05).
>>
>> That's strong empirical data suggesting that whatever we want to do
>> about unaligned access in the future it's not something which in
>> practice would cause wrong sha1 results for the implementation
>> shipping with v2.13.0.
>>
>> As an aside, when I was trying to apply your patch I made a mistake,
>> and found that git's test suite could run 100% OK with a bad sha1
>> implementation, I didn't apply this part (word diff):
>>
>> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
>> index 04b104fe58..d6f4c442b5 100644
>> --- a/sha1dc/sha1.c
>> +++ b/sha1dc/sha1.c
>> @@ -312 +312 @@ static void sha1_compression_W(uint32_t ihv[5], const
>> uint32_t W[80])
>> void sha1_compression_states(uint32_t ihv[5], const
>> [-uint32_t-]{+uint8_t+} m[64], uint32_t W[80], uint32_t states[80][5])
>> @@ -1642 +1642 @@ static void sha1_recompression_step(uint32_t step,
>> uint32_t ihvin[5], uint32_t i
>> static void sha1_process(SHA1_CTX* ctx, const [-uint32_t-]{+uint8_t+} bl=
ock[64])
>> diff --git a/sha1dc/sha1.h b/sha1dc/sha1.h
>> index 1d1d2b8d7c..1d181a1403 100644
>> --- a/sha1dc/sha1.h
>> +++ b/sha1dc/sha1.h
>> @@ -21 +21 @@ extern "C" {
>> void sha1_compression_states(uint32_t[5], const
>> [-uint32_t-]{+uint8_t+}[64], uint32_t[80], uint32_t[80][5]);
>
>
> That change doesnt look right anyway.
>
> The original code asserts that it will receive a pointer to 64
> uint32_t's as the second argument.
>
> The changed code asserts that it will receive a pointer to 64
> uint8_t's as the second argument.
>
> If you change the type you will need to change the *number* corresponding=
ly.
>
> I would expect to see the uint32_t[64] to turn into uint8_t[256]

Indeed, the full change is one where "uint32_t m[16]" is changed to
"uint8_t m[64]". See Martin's patch upthread.

The word-diff I posted is in the context of my misapplying that patch
(since GMail destroyed it I manually typed in the change). That
produced "uint32_t m[16]" -> "uint32_t m[64]" instead of Martin's
version.

That's obviously incorrect and results in a broken SHA-1
implementation, but git's test suite isn't exhaustive enough that
nothing in t/ caught it, only the t/perf rebase performance test.

> I have noticed that gcc does not necessarily enforce these types of
> declarations and I believe that the change might not have any affect
> at all depending on how the pointers are being used. (C passes
> pointers on the stack, so afaik these things are more hints than
> anything else.)
>
> Looking at the code it looks like it conflates endianness with
> alignedness when they arent the same thing, except that the majority
> of little-endian boxes are x86 which do not require aligned access,
> and many big-endian boxes do require aligned access. IOW, even they
> are often related they are distinct properties.
>
> Most hash function implementations have code like the following
> (extracted and reduced from hv_macro.h in perl.git [which only
> supports little-endian hash functions]):
>
> #ifndef U32_ALIGNMENT_REQUIRED
>   #if (BYTEORDER =3D=3D 0x1234 || BYTEORDER =3D=3D 0x12345678)
>     #define U8TO32_LE(ptr)   (*((const U32*)(ptr)))
> #elif (BYTEORDER =3D=3D 0x4321 || BYTEORDER =3D=3D 0x87654321)
>     #if defined(__GNUC__) && (__GNUC__>4 || (__GNUC__=3D=3D4 && __GNUC_MI=
NOR__>=3D3))
>       #define U8TO32_LE(ptr)   (__builtin_bswap32(*((U32*)(ptr))))
>     #endif
>   #endif
> #endif
>
> #ifndef U8TO16_LE
>     /* Without a known fast bswap32 we're just as well off doing this */
>   #define U8TO32_LE(ptr)
> ((U32)(ptr)[0]|(U32)(ptr)[1]<<8|(U32)(ptr)[2]<<16|(U32)(ptr)[3]<<24)
> #endif
>
> Of course, in the case of SHA1 it is defined as being big-endian
> (making it a relatively poor choice for use on x86), so you would need
> to reverse a bit of this logic.
>
> Note the form shown in that last block will work regardless of
> endianness or alignedness requirements and should be optimised
> properly by most compilers into the most efficient operation.
>
> In other words, if you guys just switch to that kind of pattern this
> problem will go away everywhere, and the only issue you will have to
> consider is if it makes some oddball platforms too slow.

I think this is something Marc Stevens & co would be very interested
to hear about at
https://github.com/cr-marcstevens/sha1collisiondetection

He's CC'd here but I suspect he's not keeping up with this deluge of
E-Mails from the git project very closely, we're just using his
software as-is.
