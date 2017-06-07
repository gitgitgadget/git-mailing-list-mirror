Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBCF01FAEB
	for <e@80x24.org>; Wed,  7 Jun 2017 22:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbdFGWGB (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 18:06:01 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:32829 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdFGWGA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 18:06:00 -0400
Received: by mail-pg0-f41.google.com with SMTP id f185so9488764pgc.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 15:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nnQ3KFMKotIISW04t+DpLIq8OnoSMCn8R+p/NpZNGHk=;
        b=cgus3a3zTNUAaTw0iiAKvBiIVUPMSjXWz0kPmID6+v6JuwZSQICFDMD849IHRY9bhp
         /3ZYouydGvfeI6Vh5Ah/rdnXWKI7hQh+GpnmaRsoxfnQy4WU1UBSsq5bLkTBGy+3IKAv
         N2JRTUDM60Vcs+AirvuX4t4D0YDU1R8lhph4pF3JWj3xLktED7X6jTbjDGl6DR61NwkE
         QkAq00nokbDWwasv0MvUJaXVjPdvowMCxARfuquxa2tXoqOWkBNhtyIAr1lvwIFSGJjq
         ETL7aH/i8pMFx8XmvdNv0g38kvgDcXoPp9+58TPmM8eUAqrWJbAe/iUqbTiyqo8ybNF9
         c/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nnQ3KFMKotIISW04t+DpLIq8OnoSMCn8R+p/NpZNGHk=;
        b=fiVbe/NuvdZIne994t64lTqLQIzt6bzsGkT7eeWjbeARPALIf402+OL1M4/4E8qI2Q
         43O1dQtesnfiOkC2YjIh+bqVuk/hR8dSqcLPT7VkjuUVvSJoL+14v1HruSnvORsIpftu
         8RO9tFV5yjlHh0jEX6Bo6ObUks75OCl0Bvdmk+BAFZ/KY0W04R9/jATvOXJmbhohKEaL
         TBHbR+61OYyH5clD5y6hLrBci2MMPKZnCOEJjgcv658acPBJAs9glKWB4ODMFFvWsz7X
         NW23Is6Q3i/chTVIuMBMfZbZCDo5xQnu5ePsXO02zyufgyyv7cyZhE8SmpxWswdwbbZo
         96WQ==
X-Gm-Message-State: AODbwcDusSdzKpbGX9U7Aiwen02F4XHyrPLKObDoHTAlcd6/XyGnGgFX
        ChODsUjEaDk/NDQ7sukRH0m5QtiHBUFm
X-Received: by 10.98.63.10 with SMTP id m10mr23014107pfa.19.1496873159892;
 Wed, 07 Jun 2017 15:05:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Wed, 7 Jun 2017 15:05:59 -0700 (PDT)
In-Reply-To: <CACBZZX6FR-KD-TpRaGjLR0MfUt62w0KvYpikK7WcTS2EMQ2L8w@mail.gmail.com>
References: <xmqq1sqzkrui.fsf@gitster.mtv.corp.google.com> <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
 <CAMy9T_H4WAh6kA3K4VVv7oUwL3KHcK-mM-4bXxC0D1FinRa8mA@mail.gmail.com>
 <CA+P7+xr2xrVfUPppCa4gCj72enX-_qZsAK3bNtOusfh7wWH0rg@mail.gmail.com>
 <CAGZ79kZVB9Ld8m+Zjps0ysEvXaptp2_FzimqRhiOHEBfXdX91Q@mail.gmail.com> <CACBZZX6FR-KD-TpRaGjLR0MfUt62w0KvYpikK7WcTS2EMQ2L8w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Jun 2017 15:05:59 -0700
Message-ID: <CAGZ79kb_ROB=eeNJWT4tAtqcoMWKwwr0cewY5DiAHcvH7f1Bqw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #03; Mon, 5)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 7, 2017 at 2:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Jun 7, 2017 at 8:28 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, Jun 6, 2017 at 3:05 PM, Jacob Keller <jacob.keller@gmail.com> wr=
ote:
>>> On Tue, Jun 6, 2017 at 2:50 AM, Michael Haggerty <mhagger@alum.mit.edu>=
 wrote:
>>>> On Mon, Jun 5, 2017 at 8:23 PM, Stefan Beller <sbeller@google.com> wro=
te:
>>>>>
>>>>> > [...]
>>>>> >  "git diff" has been taught to optionally paint new lines that are
>>>>> >  the same as deleted lines elsewhere differently from genuinely new
>>>>> >  lines.
>>>>> >
>>>>> >  Are we happy with these changes?
>>>>
>>>>
>>>> I've been studiously ignoring this patch series due to lack of bandwid=
th.
>>>>
>>>>> [...]
>>>>> Things to come, but not in this series as they are more advanced:
>>>>>
>>>>>     Discuss if a block/line needs a minimum requirement.
>>>>>
>>>>> When doing reviews with this series, a couple of lines such
>>>>> as "\t\t}" were marked as a moved, which is not wrong as they
>>>>> really occurred in the text with opposing sign.
>>>>> But it was annoying as it drew my attention to just closing
>>>>> braces, which IMO is not the point of code review.
>>>>>
>>>>> To solve this issue I had the idea of a "minimum requirement", e.g.
>>>>> * at least 3 consecutive lines or
>>>>> * at least one line with at least 3 non-ws characters or
>>>>> * compute the entropy of a given moved block and if it is too low, do
>>>>>   not mark it up.
>>>>
>>>> Shooting from the hip here...
>>>>
>>>> It seems obvious that for a line to be marked as moved, a minimum
>>>> requirement is that
>>>>
>>>> 1. The line appears as both "+" and "-".
>>>>
>>>> That doesn't seem strong enough evidence though, and if that is the
>>>> only criterion, I would expect a lot of boilerplate lines like "\t\t}"
>>>> to be marked as moved. It seems like a lot of noise could be
>>>> eliminated by *also* requiring that
>>>>
>>>> 2a. The line doesn't appear elsewhere in the file(s) concerned.
>>
>> 'elsewhere' in the opposing sign (+,-) or all the diff (including ' ' co=
ntext)?
>>
>> This rule opens up the discussion on multi-copies, which I imagine
>> happens a lot in configuration files. So say you have a prod and staging
>> environment, then you might be tempted to make patches titled as:
>>   "1. preparation: duplicate common code into prod and staging"
>>   "2. Make an actual change to staging"
>>
>> For 1. you still want to see that there is faithful copy, but we'd have
>> 2 postimages having these lines.
>>
>> Also what about de-duplication?
>> I just stumbled upon edb0c72428 ([PATCH] diff: consolidate test
>> helper script pieces., 2005-05-31) for unrelated reasons,
>> but the move coloring of the same content multiple times
>> helped me there to focus on the relevant part.
>>
>>>>
>>>> Rule (2a) would probably get rid of most boilerplate lines without
>>>> having to try to measure entropy.
>>
>> But it would also get rid of good use cases when not being very careful.
>> I intentionally left out the (2a) as I am not yet sure how the move
>> detection for multiple occurrences in post and preimage should
>> work in the desired case. The suppression of little-entropy closing brac=
es
>> might be a side effect of just this. Or it can be treated separately.
>>
>>>>
>>>> Maybe you are already using both criteria? I didn't see it in a quick
>>>> perusal of the code.
>>>>
>>>> OTOH, it would be silly to refuse to mark lines like "\t\t}" as moved
>>>> *only* because they appear elsewhere in the file(s). If you did so,
>>>> you would have gaps of supposedly non-moved lines in the middle of
>>>> moved blocks. This suggests marking as moved lines matching (1) and
>>>> (2a) but also lines matching (1) and the following:
>>>>
>>>> 2b. The line is adjacent to to another line that is thought to have
>>>> moved from the same old location to the same new location.
>>
>> This is what we do, a "block detection" by comparing "line runs" against
>> the current lines. Based on these line runs we detect one block and
>> color up adjacent blocks.
>>
>>>>
>>>> Rule (2b) would be applied recursively, with the net effect being that
>>>> any line satisfying (1) and (2a) is allowed to carry along any
>>>> neighboring lines within the same "+"/"-" block even if they are not
>>>> unique.
>>
>> So you are saying each block has to have at least one unique line?
>> That doesn't go well with (de-)duplication IMHO.
>>
>> Thanks for your shot from the hip. I'll think about these rules more to =
see
>> if I can make sense of them for duplication still.
>
> I've just been skimming this topic so far, but a question, what variant o=
f:
>
>     git diff ... | grep ...
>
> Can I use to see whether the diff that's being emitted has hunks
> marked as moved? Presumably this needs -c ui.color=3Dalways & grepping
> for the color codes.
>
> The use-case being to say add that diff | grep -q to a for-loop to
> find all diffs in a repo that have hunks marked as moved.

Early on in one of the first iterations, I had different signs instead of
+,- to mark the moved parts. This would help you immensely in this
case.

I decided to not implement the different signs as this would require
much more extensive documentation as it would be a new diff
format essentially.

I think this can be hacked on top of the series quite easily.
(In the function to markup the color, you could just change the
sign as well, but then we also have to call that function in the
non-color case)

So yeah for now you need to grep for color codes.
