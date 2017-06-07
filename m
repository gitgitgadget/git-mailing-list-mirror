Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A406E1FAEB
	for <e@80x24.org>; Wed,  7 Jun 2017 21:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbdFGV6v (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 17:58:51 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33516 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdFGV6u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 17:58:50 -0400
Received: by mail-it0-f65.google.com with SMTP id l6so2340577iti.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 14:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fPkAQxWh2WH1gUas1SqMQLj89+WmwUzIA2pCKbOcvkQ=;
        b=bYhYD1Z5EGP5nyvvZAGeT+gwn7rdnaEFNfi/R45TW7cm7mKpm88xRbGqkixh1A6f91
         MT+j6/aJpYKiMSHUZ7C4DThJkCtr54FnH7Ir5ghwRr7t8mslIiPtsdd0GazoZzjdDBDv
         8/UTXVKe2Ppy8vh1nfsiWKeztAVNIV/sti9WKrbU2yWFiR/mGYbtP35ey5ES3TJq+Cmq
         oga9dh95Kkeu3v2C0c9s9K52UfdTs8xwopjs6Iu0AoDYP4Q3n6VHPz2uD22G0h4hnDO9
         t1p5SLYsqlxX4NhdZrctSg+l7+rcg0pnnLQtKklIgq3GaZnXs2ZeFG18uRuo/key6O4Y
         JtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fPkAQxWh2WH1gUas1SqMQLj89+WmwUzIA2pCKbOcvkQ=;
        b=kkv7mGWke5d+RhCZqY0fUOB6F6tyjE+tZmyPGZz0VwutASiAcHGY9h93kPjvoTZS94
         8JdxjpArAilEIVTItXeI1htXmihXtTix4uudIrTkIWbHY6ABhjQPxogEsSKC98dRqkkH
         cd2JrVEIXwUZ2w29PmeDOhvAJ1A7w68VR21UMXyGZYRwgFC6/KggCzdFyw7e6FtcXkJh
         lVcaJt3KoYMXET8Vce5VUNb0jnog4OOLIEGrXz/DLUFr0qjrWvI0mXbXD6TOz561Piv2
         iR6M/CrGL9EPP3F4KbQN7PJrZAXs7c/IWqGffLw79/jyMuAvhP1Wze1zLVlhbcfAYxEc
         Um9g==
X-Gm-Message-State: AODbwcApPa45vuE67+1GRiW5ReVTwDf/bGY8BrNJhh7Ji3x8qhkQeLUM
        YggmXxUVXkZRIJj50Rm3XwTccvQt0w==
X-Received: by 10.36.164.67 with SMTP id v3mr2292393iti.71.1496872729487; Wed,
 07 Jun 2017 14:58:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Wed, 7 Jun 2017 14:58:28 -0700 (PDT)
In-Reply-To: <CAGZ79kZVB9Ld8m+Zjps0ysEvXaptp2_FzimqRhiOHEBfXdX91Q@mail.gmail.com>
References: <xmqq1sqzkrui.fsf@gitster.mtv.corp.google.com> <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
 <CAMy9T_H4WAh6kA3K4VVv7oUwL3KHcK-mM-4bXxC0D1FinRa8mA@mail.gmail.com>
 <CA+P7+xr2xrVfUPppCa4gCj72enX-_qZsAK3bNtOusfh7wWH0rg@mail.gmail.com> <CAGZ79kZVB9Ld8m+Zjps0ysEvXaptp2_FzimqRhiOHEBfXdX91Q@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 7 Jun 2017 23:58:28 +0200
Message-ID: <CACBZZX6FR-KD-TpRaGjLR0MfUt62w0KvYpikK7WcTS2EMQ2L8w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #03; Mon, 5)
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 7, 2017 at 8:28 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jun 6, 2017 at 3:05 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Tue, Jun 6, 2017 at 2:50 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> On Mon, Jun 5, 2017 at 8:23 PM, Stefan Beller <sbeller@google.com> wrote:
>>>>
>>>> > [...]
>>>> >  "git diff" has been taught to optionally paint new lines that are
>>>> >  the same as deleted lines elsewhere differently from genuinely new
>>>> >  lines.
>>>> >
>>>> >  Are we happy with these changes?
>>>
>>>
>>> I've been studiously ignoring this patch series due to lack of bandwidth.
>>>
>>>> [...]
>>>> Things to come, but not in this series as they are more advanced:
>>>>
>>>>     Discuss if a block/line needs a minimum requirement.
>>>>
>>>> When doing reviews with this series, a couple of lines such
>>>> as "\t\t}" were marked as a moved, which is not wrong as they
>>>> really occurred in the text with opposing sign.
>>>> But it was annoying as it drew my attention to just closing
>>>> braces, which IMO is not the point of code review.
>>>>
>>>> To solve this issue I had the idea of a "minimum requirement", e.g.
>>>> * at least 3 consecutive lines or
>>>> * at least one line with at least 3 non-ws characters or
>>>> * compute the entropy of a given moved block and if it is too low, do
>>>>   not mark it up.
>>>
>>> Shooting from the hip here...
>>>
>>> It seems obvious that for a line to be marked as moved, a minimum
>>> requirement is that
>>>
>>> 1. The line appears as both "+" and "-".
>>>
>>> That doesn't seem strong enough evidence though, and if that is the
>>> only criterion, I would expect a lot of boilerplate lines like "\t\t}"
>>> to be marked as moved. It seems like a lot of noise could be
>>> eliminated by *also* requiring that
>>>
>>> 2a. The line doesn't appear elsewhere in the file(s) concerned.
>
> 'elsewhere' in the opposing sign (+,-) or all the diff (including ' ' context)?
>
> This rule opens up the discussion on multi-copies, which I imagine
> happens a lot in configuration files. So say you have a prod and staging
> environment, then you might be tempted to make patches titled as:
>   "1. preparation: duplicate common code into prod and staging"
>   "2. Make an actual change to staging"
>
> For 1. you still want to see that there is faithful copy, but we'd have
> 2 postimages having these lines.
>
> Also what about de-duplication?
> I just stumbled upon edb0c72428 ([PATCH] diff: consolidate test
> helper script pieces., 2005-05-31) for unrelated reasons,
> but the move coloring of the same content multiple times
> helped me there to focus on the relevant part.
>
>>>
>>> Rule (2a) would probably get rid of most boilerplate lines without
>>> having to try to measure entropy.
>
> But it would also get rid of good use cases when not being very careful.
> I intentionally left out the (2a) as I am not yet sure how the move
> detection for multiple occurrences in post and preimage should
> work in the desired case. The suppression of little-entropy closing braces
> might be a side effect of just this. Or it can be treated separately.
>
>>>
>>> Maybe you are already using both criteria? I didn't see it in a quick
>>> perusal of the code.
>>>
>>> OTOH, it would be silly to refuse to mark lines like "\t\t}" as moved
>>> *only* because they appear elsewhere in the file(s). If you did so,
>>> you would have gaps of supposedly non-moved lines in the middle of
>>> moved blocks. This suggests marking as moved lines matching (1) and
>>> (2a) but also lines matching (1) and the following:
>>>
>>> 2b. The line is adjacent to to another line that is thought to have
>>> moved from the same old location to the same new location.
>
> This is what we do, a "block detection" by comparing "line runs" against
> the current lines. Based on these line runs we detect one block and
> color up adjacent blocks.
>
>>>
>>> Rule (2b) would be applied recursively, with the net effect being that
>>> any line satisfying (1) and (2a) is allowed to carry along any
>>> neighboring lines within the same "+"/"-" block even if they are not
>>> unique.
>
> So you are saying each block has to have at least one unique line?
> That doesn't go well with (de-)duplication IMHO.
>
> Thanks for your shot from the hip. I'll think about these rules more to see
> if I can make sense of them for duplication still.

I've just been skimming this topic so far, but a question, what variant of:

    git diff ... | grep ...

Can I use to see whether the diff that's being emitted has hunks
marked as moved? Presumably this needs -c ui.color=always & grepping
for the color codes.

The use-case being to say add that diff | grep -q to a for-loop to
find all diffs in a repo that have hunks marked as moved.
