Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13A402027C
	for <e@80x24.org>; Fri,  2 Jun 2017 19:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbdFBTcg (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 15:32:36 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:35506 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbdFBTce (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 15:32:34 -0400
Received: by mail-it0-f46.google.com with SMTP id m62so15941470itc.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9ThwDSv4df8PYhSZKW3p0nYE+wco2pKhHBL0OR16+yw=;
        b=BY5IqpgxGX98yIZ1B0mn0v5ADtC5ez3KAkaIm+pzLXpIorpzV15G7yoszlU4lqutiO
         rsZXwM3/YdY3/2ldqfihoVV2+N6kEtiiF3P0ayl+V6z3ZqyviiQsXXS1xYSZIuwmy+D1
         Ag/YCvALUKquM+o/GxErfzBm7UCUGlBsbAHRGpOcoeAQarr5+B4H5eQpQvN+bBuQ2a1T
         uGIu7XwlTPsFzKeOtWALsR0tfTFz6TXeYowRsquzlLd5o34SRWbZrncFQOM9SkWm6s+S
         rQk9hKfgQrOKQlXC8ATgYotVlQipEsTl+AYMW4Em7Zh1+eTgKcF2TfUbOdaVykVDL2hB
         yYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9ThwDSv4df8PYhSZKW3p0nYE+wco2pKhHBL0OR16+yw=;
        b=aYJ6Xi8h4hL1BGWfsV3yDbTePWSWArB8CShtl4jOTkesQpvBbS5DKPORd3slhuWmer
         iMt1i5aAb5Zr5QX/UJeHwYSoOdwGyy4g4R9FynyfJ8Y4HuZNkSslFPg22ST/Zq+vkunx
         lnLMVPPR9S98yHV7jmPRC+8PMvL4Fv9yCFssTkDCLJ3mLFqaHNHJVpHN0N2hR2snWMo0
         r73WtvRqT9xbAiP8BNO3KIkajkRxxVDuJS2sSht2sp5RiWh+kHMBJiZkM/voRvuiInE0
         idpIw2Gl9wbbKefEKudmMxMYH4kH9u6iX94PLzqGS9B8cG3OW8cu3i75lHCJ1wZGW+HR
         ao+A==
X-Gm-Message-State: AODbwcADwgXZ8ewoJp35KAoAzYcIvkfiW9Ac2Q6vvDtOfemxEa8AnItM
        7ZsS+ccl5CjTRhqY72gxDGOcz5g/Oeo6Na0=
X-Received: by 10.107.178.215 with SMTP id b206mr5906439iof.50.1496431953338;
 Fri, 02 Jun 2017 12:32:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 2 Jun 2017 12:32:12 -0700 (PDT)
In-Reply-To: <CAN0heSq3CSe=Hgygtzd+ZM4rW-qM1_chrNd7Pq0KnYnKEVXcpw@mail.gmail.com>
References: <mvm4lw0un5n.fsf@suse.de> <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
 <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com> <mvmmv9st3yv.fsf@suse.de>
 <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
 <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
 <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
 <CAN0heSp9DpW4_0QL57_oAHGu+os8k6yd=Z5+0MJnaL6iXTa-qQ@mail.gmail.com>
 <xmqq37bj454a.fsf@gitster.mtv.corp.google.com> <CACBZZX7EvUqH28uni+r=RUBXb9=WTp732B4=rq+ViD_kecxZaw@mail.gmail.com>
 <CAN0heSq3CSe=Hgygtzd+ZM4rW-qM1_chrNd7Pq0KnYnKEVXcpw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 2 Jun 2017 21:32:12 +0200
Message-ID: <CACBZZX5re5Ge1OzxYOE42nwBhhusya6=M9An08X-KzaqNH9Cog@mail.gmail.com>
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

On Fri, Jun 2, 2017 at 11:49 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> On 2 June 2017 at 10:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
>> On Fri, Jun 2, 2017 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote=
:
>>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>>
>>>> I looked into this some more. It turns out it is possible to trigger
>>>> undefined behavior on "next". Here's what I did:
>>>> ...
>>>>
>>>> This "fixes" the problem:
>>>> ...
>>>> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
>>>> index 3dff80a..d6f4c44 100644
>>>> --- a/sha1dc/sha1.c
>>>> +++ b/sha1dc/sha1.c
>>>> @@ -66,9 +66,9 @@
>>>> ...
>>>> With this diff, various tests which seem relevant for SHA-1 pass,
>>>> including t0013, and the UBSan-error is gone. The second diff is just
>>>> a monkey-patch. I have no reason to believe I will be able to come up
>>>> with a proper and complete patch for sha1dc. And I guess such a thing
>>>> would not really be Git's patch to carry, either. But at least Git
>>>> could consider whether to keep relying on undefined behavior or not.
>>>>
>>>> There's a fair chance I've mangled the whitespace. I'm using gmail's
>>>> web interface... Sorry about that.
>>>
>>> Thanks.  I see Marc Stevens is CC'ed in the thread, so I'd expect
>>> that the final "fix" would come from his sha1collisiondetection
>>> repository via =C3=86var.
>>>
>>> In the meantime, I am wondering if it makes sense to merge the
>>> earlier update with #ifdef ALLOW_UNALIGNED_ACCESS and #ifdef
>>> SHA1DC_FORCE_LITTLEENDIAN for the v2.13.x maintenance track, which
>>> would at least unblock those on platforms v2.13.0 did not work
>>> correctly at all.
>>>
>>> =C3=86var, thoughts?
>>
>> I think we're mixing up several things here, which need to be untangled:
>>
>> 1) The sha1dc works just fine on most platforms even with undefined
>> behavior, as evidenced by 2.13.0 working.
>
> Right, with "platform" meaning "combination of hardware-architecture
> and compiler". Nothing can be said about how the current code behaves
> on "x86". Such statements can only be made with regard to "x86 and
> this or that compiler". Even then, short of studying the compiler
> implementation/documentation in detail, one cannot be certain that
> seemingly unrelated changes in Git don't make the code do something
> else entirely.

I think you're veering into a theoretical discussion here that has
little to no bearing on the practicalities involved here.

Yes if something is undefined behavior in C the compiler &
architecture is free to do anything they want with it. In practice
lots of undefined behavior is de-facto standardized across various
platforms.

As far as I can tell unaligned access is one of those things. I don't
think there's ever been an x86 chip / compiler that would run this
code with any semantic differences when it comes to unaligned access,
and such a chip / compiler is unlikely to ever exist.

I'm not advocating that we rely on undefined behavior willy-nilly,
just that we should consider the real situation is (i.e. what actual
architectures / compilers are doing or are likely to do) as opposed to
the purely theoretical (if you gave a bunch of aliens who'd never
heard of our technology the ANSI C standard to implement from
scratch).

Here's a performance test of your patch above against p3400-rebase.sh.
I don't know how much these error bars from t/perf can be trusted.
This is over 30 runs with -O3:

- 3400.2: rebase on top of a lot of unrelated changes
  v2.12.0     : 1.25(1.10+0.06)
  v2.13.0     : 1.21(1.06+0.06) -3.2%
  origin/next : 1.22(1.04+0.07) -2.4%
  martin        : 1.23(1.06+0.07) -1.6%
- 3400.4: rebase a lot of unrelated changes without split-index
  v2.12.0     : 6.49(3.60+0.52)
  v2.13.0     : 8.21(4.18+0.55) +26.5%
  origin/next : 8.27(4.34+0.64) +27.4%
  martin        : 8.80(4.36+0.62) +35.6%
- 3400.6: rebase a lot of unrelated changes with split-index
  v2.12.0     : 6.77(3.56+0.51)
  v2.13.0     : 4.09(2.67+0.38) -39.6%
  origin/next : 4.13(2.70+0.36) -39.0%
  martin        : 4.30(2.80+0.32) -36.5%

And just your patch v.s. next:

- 3400.2: rebase on top of a lot of unrelated changes
  origin/next : 1.22(1.06+0.06)
  martin      : 1.22(1.06+0.05) +0.0%
- 3400.4: rebase a lot of unrelated changes without split-index
  origin/next : 7.54(4.13+0.60)
  martin      : 7.75(4.34+0.67) +2.8%
- 3400.6: rebase a lot of unrelated changes with split-index
  origin/next : 4.19(2.92+0.31)
  martin      : 4.14(2.84+0.39) -1.2%

It seems to be a bit slower, is that speedup worth the use of
unaligned access? I genuinely don't know. I'm just interested to find
what if anything we need to urgently fix in a release version of git.

One data point there is that the fallback blk-sha1 implementation
we've shipped since 2009 has the same errors about unaligned access as
before your patch with -fsanitize[..], and looking at the commit
message this was something Linus knew about at the time, see
d7c208a92e ("Add new optimized C 'block-sha1' routines", 2009-08-05).

That's strong empirical data suggesting that whatever we want to do
about unaligned access in the future it's not something which in
practice would cause wrong sha1 results for the implementation
shipping with v2.13.0.

As an aside, when I was trying to apply your patch I made a mistake,
and found that git's test suite could run 100% OK with a bad sha1
implementation, I didn't apply this part (word diff):

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 04b104fe58..d6f4c442b5 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -312 +312 @@ static void sha1_compression_W(uint32_t ihv[5], const
uint32_t W[80])
void sha1_compression_states(uint32_t ihv[5], const
[-uint32_t-]{+uint8_t+} m[64], uint32_t W[80], uint32_t states[80][5])
@@ -1642 +1642 @@ static void sha1_recompression_step(uint32_t step,
uint32_t ihvin[5], uint32_t i
static void sha1_process(SHA1_CTX* ctx, const [-uint32_t-]{+uint8_t+} block=
[64])
diff --git a/sha1dc/sha1.h b/sha1dc/sha1.h
index 1d1d2b8d7c..1d181a1403 100644
--- a/sha1dc/sha1.h
+++ b/sha1dc/sha1.h
@@ -21 +21 @@ extern "C" {
void sha1_compression_states(uint32_t[5], const
[-uint32_t-]{+uint8_t+}[64], uint32_t[80], uint32_t[80][5]);

The p3400-rebase.sh test will fail with your patch without that
change, but not any of the tests, gulp!

>> 2) There was a bug in practice with unaligned access on SPARC. It's
>> not clear to me whether anyone (Andreas, Liam?) still has any issues
>> in practice on any platform without specifying compile flags like what
>> Martin =C3=85gren suggested above.
>
> True.
>
>> 3) Now we have another issue reported by Martin =C3=85gren here, which i=
s
>> that while the code works in practice on most platforms it's using
>> undefined behavior.
> ...
>> I think that this is definitely something worth looking into /
>> coordinating with upstream, but I haven't seen anything to suggest
>> that we need to be rushing to get a patch in to fix this given 1) and
>> nobody saying yet that 2) doesn't solve their issue as long as they're
>> not supplying some -fsanitize=3D* flags.
>>
>> Now, stepping a bit back from this whole thing: I didn't read the
>> entire discussion back in February when sha1dc was integrated, but I
>> really don't see given all this churn / bug reporting we're getting
>> now why another acceptable solution wouldn't be to just revert
>> e6b07da278 ("Makefile: make DC_SHA1 the default", 2017-03-17) &
>> release 2.13.1 with that.
>>
>> Clearly there are outstanding issues with it, and needing to do a
>> memcpy() as my `next` patch does will harm performance on some
>> platforms, and something like Martin's patch on top will slow it down
>> even more.
>
> The only thing in my second "patch" which could possibly affect
> performance as I see it would be the call to memcpy(.. ,.. ,4),
> including pointer-calculation. Focusing on x86, I would not say that
> it "will" slow it down until I'd measured performance. I wouldn't even
> rule out that the compiled assembler could be identical. I would just
> say the patch "would most likely slow it down even more on some
> architectures, with some compilers and/or with some
> compiler-settings".
>
> If undefined behavior is avoided with memcpy(.., .., 4) then there
> should be no formal need for your "big" memcpy where things are copied
> into a known-to-be-aligned buffer. The behavior will be defined on all
> architectures, anyway. Then your memcpy would simply be part of an
> optimization to prefer one big memcpy and many loads instead of many
> small memcpy-calls. On some architectures, that might be a very good
> optimization. But on others, if the small memcpy is compiled to a
> simple load, then I believe such an optimization would most likely be
> a slow-down (modulo crazy-clever compiler optimizations).
>
>> It seems to me that we should give it more time to cook, and better
>> understand the various trade-offs involved. The shattered attack is
>> very unlikely to impact anything in practice, and users who are
>> paranoid about it can opt-in to this extra protection.
>
> Regarding reverting and cooking, I don't feel like I'm in a position
> to express an opinion. Thanks for thinking about this undefined
> behavior, though, and I hope I'm contributing in some way, although
> I'm aware I'm just standing at the side-line, waving my hands, and not
> contributing any actual code.
