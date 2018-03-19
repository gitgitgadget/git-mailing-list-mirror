Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C36751FAE2
	for <e@80x24.org>; Mon, 19 Mar 2018 15:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934129AbeCSPvv (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 11:51:51 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42263 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933998AbeCSPvs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 11:51:48 -0400
Received: by mail-oi0-f67.google.com with SMTP id c18so14710710oiy.9
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aCYJiLB2nS0AuWVMbKP7jl689aHCbbCxYLiX5N/+Kkk=;
        b=CwcqB5kqX0lVyFt0FxUbzPeTSjC/jc7OYe25zR/A6YrLxeCQ/66P0pweV9h2KslGJX
         y+kUToriorLEL6pwygiRUvrL0jfvO0CtqMJqnNaWFB3UthHNHB8utdYByr/VuUgQzql3
         XNLmaYU4m7/XNIR4YVgn7vDiAkioK3jRbZQu68s9qfrUSKv+qNFsfsKowgfDCtXb4Um9
         AlroU7/D4Jait6en3P3nxycwuyNyXxIx5ttEVJ5omUmaG1HseU4O1xaUl5NSK++AMaFG
         4Y3hoW5zfWUTNeLyJg8JgmyD6onobH8ZgGuQxH228X7JQxW9UbGIl0vuCgA9P58uOeCG
         DblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aCYJiLB2nS0AuWVMbKP7jl689aHCbbCxYLiX5N/+Kkk=;
        b=kG0Bi9Plm71UHNhG3GVIviCyeU5Ksmo+Zzlo8yMjqnb1fAzsHm2Vj0mJ0x2Wax2tsg
         NWhU0bRlRfRz0hETn5ehORpzzxGDeVW535Uz+qo1TcoHvYSpdbURwPg/1Ng31k2pb/Jf
         S6ojoSL4+Sj3Ab6SQUA2y0ptiFtldyATBds2THGs8tOkXKU9mQdhURiRkqM03PJr1L/o
         UiesKeJjQESx3HogeiEb+ngszbUg3SW/60qXn4ukOHBRBLTBDMsWoHu+fhgS+KyZJ5da
         Lq4DFHX7c+XP5cxrWl5H6c80nix9v+FULG3+Jbqu2w3cRzz/Npd38qjrPiE82gyweJOZ
         oUYQ==
X-Gm-Message-State: AElRT7GkxbQm+90PGa60bQkB+l/7L4RuKLPHMjs1vjZHVtdP3es5kDw+
        voBMmIjYCODxc+IhSM3fiVJ4876i8MFB24Cznys=
X-Google-Smtp-Source: AG47ELtU6iGzFN+VW/yEz5/At3uFIvPmixexj0HEoCHyik3NAPqEtbNMlMGB3X0dcPC8n1iNJkkIw/700WzUTa+kYoU=
X-Received: by 10.202.64.85 with SMTP id n82mr7575733oia.30.1521474707602;
 Mon, 19 Mar 2018 08:51:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Mon, 19 Mar 2018 08:51:16 -0700 (PDT)
In-Reply-To: <edbc7234-ee60-6f3e-ae09-94721e4b5faa@jeffhostetler.com>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180317075421.22032-5-pclouds@gmail.com>
 <CAPig+cTSqxLTDoq3xGAmf1xCyCX0jvwyoSL5GApgaNg5PVPGGg@mail.gmail.com>
 <CACsJy8CeXZJashmh+sLykRR4Mm_EwnASMVyB-4ztEcfQXU7MXw@mail.gmail.com>
 <CAPig+cRGpD1_U5PgO=-1wrsiyWqY4GmE3tWNdgCnuAh7PUjvHg@mail.gmail.com> <edbc7234-ee60-6f3e-ae09-94721e4b5faa@jeffhostetler.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Mar 2018 16:51:16 +0100
Message-ID: <CACsJy8CbFWvAzvSVZKho1O1D4mi3jphs6cbZ9npSwDWXicMPfQ@mail.gmail.com>
Subject: Re: [PATCH 04/36] t/helper: merge test-lazy-init-name-hash into test-tool
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 10:40 AM, Jeff Hostetler <git@jeffhostetler.com> wr=
ote:
>
>
> On 3/18/2018 4:47 AM, Eric Sunshine wrote:
>>
>> On Sun, Mar 18, 2018 at 4:25 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>
>>> On Sun, Mar 18, 2018 at 3:11 AM, Eric Sunshine <sunshine@sunshineco.com=
>
>>> wrote:
>>>>
>>>> On Sat, Mar 17, 2018 at 3:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
>>>> <pclouds@gmail.com> wrote:
>>>>>
>>>>> -extern int test_lazy_init_name_hash(struct index_state *istate, int
>>>>> try_threaded);
>>>>> +extern int lazy_init_name_hash_for_testing(struct index_state *istat=
e,
>>>>> int try_threaded);
>>>>
>>>>
>>>> I get why you renamed this since the "main" function in the test
>>>> program wants to be called 'test_lazy_init_name_hash'...
>>>>
>>>>> diff --git a/t/helper/test-lazy-init-name-hash.c
>>>>> b/t/helper/test-lazy-init-name-hash.c
>>>>> @@ -9,6 +10,9 @@ static int perf;
>>>>> +static int (*init_name_hash)(struct index_state *istate, int
>>>>> try_threaded) =3D
>>>>> +       lazy_init_name_hash_for_testing;
>>>>> +
>>>>> @@ -33,9 +37,9 @@ static void dump_run(void)
>>>>>          if (single) {
>>>>> -               test_lazy_init_name_hash(&the_index, 0);
>>>>> +               init_name_hash(&the_index, 0);
>>>>
>>>>
>>>> ... but I'm having trouble understanding why this indirection through
>>>> 'init_name_hash' is used rather than just calling
>>>> lazy_init_name_hash_for_testing() directly. Am I missing something
>>>> obvious or is 'init_name_hash' just an unneeded artifact of an earlier
>>>> iteration before the rename in cache.{c,h}?
>>>
>>>
>>> Nope. It just feels too long to me and because we're already in the
>>> test I don't feel the need to repeat _for_testing everywhere. If it's
>>> confusing, I'll remove init_name_hash.
>>
>>
>> Without an explanatory in-code comment, I'd guess that someone coming
>> across this in the future will also stumble over it just like I did in
>> the review.
>
>
> I agree with Eric, this indirection seems unnecessary and confusing.
> Generally, when I see function pointers initialized like that, I
> think that there are plans for additional providers/drivers for that
> functionality, but I don't see that here.  And it seems odd.
>
>>
>> What if, instead, you rename test_lazy_init_name_hash() to
>> lazy_init_name_hash_test(), shifting 'test' from the front to the back
>> of the name? That way, the name remains the same length at the call
>> sites in the test helper, and you don't have to introduce the
>> confusing, otherwise unneeded 'init_name_hash'.
>>
>
> I see 2 problems.
> 1. The test function in name-hash.c that needs access to private data.
>     I'm not a fan of the "_for_testing" suffix, but I'm open.  I might
>     either leave it as is, or make it a "TEST_" or "test__" prefix (as
>     a guide for people used to languages with namespaces.
>
> 2. The new name for cmd_main().  There's no real need why it needs to
>    be "test_*", right?   Your cmds[] maps the command line string to a
>    function, but it could be anything.  That is, "cmd_main()" could be
>    renamed "cmd__lazy_init_name_hash()".  Then you can conceptually
>    reserve the "cmd__" prefix throughout t/helper for each test handler.

cmd__ prefix solves my problem nicely. I'll wait for a while before
resending another 30+ patches.
--=20
Duy
