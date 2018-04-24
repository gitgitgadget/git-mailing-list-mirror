Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9871F424
	for <e@80x24.org>; Tue, 24 Apr 2018 23:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbeDXXXb (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 19:23:31 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:44213 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDXXX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 19:23:29 -0400
Received: by mail-yb0-f181.google.com with SMTP id v63-v6so2364111ybi.11
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 16:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=bkwoGW1UQfXMbzFJJmhokRGKjt4R04sZg5t0zrTV6Ys=;
        b=Kq/98AWqArZdR56FNYoyzdhR0QP8DyYkwXbSCdWEwB0V9N72ZHeu6NKOXTFQb64Q09
         cfht/RPxKLQPaqWxTnfG3gCwTC/RcXHZY/bEfhHiaVwUbKlpbbomTqlqC7b7jzrHEMU0
         KvRbwez74ZaX4aoeHBKx/7TKybRP/uFYqThsmLgLVGfaOiZ3m8++ulAdpn0Em9iZR9Ng
         BwuoNapHwkZTPwtrJplh8xEdNADrL1IkUyC20E+pDg5ZdlvoZ1Ni7hk8UAnf7etBLpRS
         qvjNDrdIr+GesapClkNC0H9hfPIQ3n0Rud9uxHl6A28QHg2BlneSQfPTdZoMqHRfjqSQ
         MD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=bkwoGW1UQfXMbzFJJmhokRGKjt4R04sZg5t0zrTV6Ys=;
        b=JcJUryYhpWrlfS7evkUBJzeBTy9JgJkvAooaZXfwy8fOTt7ZmL7oJA8haCv6kBPnV3
         EV7OxNgDZYGHF51GA8GYf7nccmSQK/lv2QSHvWCDzfk6fTd2P1Xq7y+9k8xEpAYi2ETa
         JiMZuFTh2UBn++QNLKC9sKuI7Ec1pJMbJKYFABOkaozjFtD3wf7TnvcYd6Ljj96nOIDu
         jU+L0VdFIUGWwm3IYaT5t36NIh2jC9vGaOIcMgnAa6wOrR5HG4kez4miX/4Ao1o7hZv0
         ZS4MNjSpytO1XyrbiY+jx1xFo4q2SGgWqKfvh4WBp6/+MGI8BEaaT6RqCNaGwHwu6jFJ
         casA==
X-Gm-Message-State: ALQs6tBgvrkE2c5UtrtjhuyoZLDKCByIRgA5KguDEnVV1qJo3qwWyFPf
        9/nj6s5ODNm4U3lp+gSMZgdNx2rTpFAsjwVuWSdwnxSW
X-Google-Smtp-Source: AB8JxZo/qSg7XyWx/Pvo9v15hEwZDt9q5dxaBDL9NaQn5lT5RAO6MezZJDrsce9niFc7CQrLz7s/10mZQAo7P5oHVpg=
X-Received: by 2002:a25:500e:: with SMTP id e14-v6mr14689027ybb.334.1524612208823;
 Tue, 24 Apr 2018 16:23:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 24 Apr 2018 16:23:28
 -0700 (PDT)
In-Reply-To: <CAGZ79kbGkHFSS9K8KKTwNikx3Tw+m+RMLY3RAf8SW_iK9a2OJQ@mail.gmail.com>
References: <20180424210330.87861-1-sbeller@google.com> <20180424210330.87861-8-sbeller@google.com>
 <20180424153513.dc2404cd111c44ac78bd8ed8@google.com> <CAGZ79kbGkHFSS9K8KKTwNikx3Tw+m+RMLY3RAf8SW_iK9a2OJQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Apr 2018 16:23:28 -0700
Message-ID: <CAGZ79kbQUWq_pfvwLWotqCxc1-Y=ctJ4SqgqR+EvJ5wkJkp5kQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] diff.c: add --color-moved-ignore-space-delta option
To:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replied to Jonathan only instead of all. My reply is below:

On Tue, Apr 24, 2018 at 3:55 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Apr 24, 2018 at 3:35 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
>> On Tue, 24 Apr 2018 14:03:30 -0700
>> Stefan Beller <sbeller@google.com> wrote:
>>
>>> +--color-moved-[no-]ignore-space-prefix-delta::
>>> +     Ignores whitespace when comparing lines when performing the move
>>> +     detection for --color-moved. This ignores uniform differences
>>> +     of white space at the beginning lines in moved blocks.
>>
>> Setting this option means that moved lines may be indented or dedented,
>> and if they have been indented or dedented by the same amount, they are
>> still considered to be the same block. Maybe call this
>> --color-moved-allow-indentation-change.
>
> ok, sounds good as well. I tried coming up with a name that refers to
> the block check as that is the important part.
>
>>> +struct ws_delta {
>>> +     char *string; /* The prefix delta, which is the same in the block */
>>
>> Probably better described as "the difference between the '-' line and
>> the '+' line". This may be the empty string if there is no difference.
>
> Makes sense.
>
>>
>>> +     int direction; /* adding or removing the line? */
>>
>> What is the value when "added" and what when "removed"? Also, it is not
>> truly "added" or "removed", so a better way might be: 1 if the '-' line
>> is longer than the '+' line, and 0 otherwise. (And make sure that the
>> documentation is correct with respect to equal lines.)
>>
>>> +     int missmatch; /* in the remainder */
>>
>> s/missmatch/mismatch/
>> Also, what is this used for?
>
> The mismatch should be used for (thanks for catching!)
> checking if the remainder of a line is the same, although a boolean
> may be not the correct choice. We know that the two strings
> passed into compute_ws_delta come from a complete white space
> agnostic comparison, so consider:
>
> + SP SP more TAB more
> + SP SP text TAB text
>
> - SP more TAB more
> - SP text TAB text
>
> which would mark this as a moved block. This is the feature
> working as intended, but what about
>
> + SP SP more TAB more
> + SP SP text TAB text
>
> - SP more SP more
> - SP text TAB text
>
> Note how the length of the strings is the same, hence the current
> code of
>
>     compute_ws_delta(...) {
>         int d = longer->len - shorter->len;
>         out->string = xmemdupz(longer->line, d);
>     }
>
> would work fine and not notice the "change in the remainder".
> That ought to be caught by the mismatch variable, that
> is assigned, but not used.
>
> The compare_ws_delta(a, b) needs to be extended to
>
>   !a->mismatch && !b->mismatch && existing_condition
>
> Ideally the example from above would be different depending
> on whether the other white space flags are given or not.
>
>>> +     if (diffopt->color_moved_ws_handling & COLOR_MOVED_DELTA_WHITESPACES)
>>> +             /*
>>> +              * As there is not specific white space config given,
>>> +              * we'd need to check for a new block, so ignore all
>>> +              * white space. The setup of the white space
>>> +              * configuration for the next block is done else where
>>> +              */
>>> +             flags |= XDF_IGNORE_WHITESPACE;
>>> +
>>>       return !xdiff_compare_lines(a->es->line, a->es->len,
>>>                                   b->es->line, b->es->len,
>>>                                   flags);
>>
>> I wrote in [1]:
>>
>>   I think we should just prohibit combining this with any of the
>>   whitespace ignoring flags except for the space-at-eol one. They seem
>>   to contradict anyway.
>
> As outlined above, I think there are corner cases in which they do not
> contradict. So I think the COLOR_MOVED_DELTA_WHITESPACES
> will go into its own variable, and then we can solve the corner cases
> correctly.
>
>> To elaborate, adding a specific flag that may interfere with other
>> user-provided flags sounds like we're unnecessarily adding combinations
>> that we must keep track of, and that it's both logical (from a user's
>> point of view) and clearer (as for the code) to just forbid such
>> combinations.
>
> Yes, I think you mentioned this before. Thanks for reminding!
>
>>> +     struct ws_delta *wsd = NULL; /* white space deltas between pmb */
>>> +     int wsd_alloc = 0;
>>> +
>>> +     int n, flipped_block = 1, block_length = 0;
>>
>> It seems like pmb and wsd are parallel arrays - could each wsd be
>> embedded into the corresponding entry of pmb instead?
>
> I'll explore that. It sounds like a good idea for code hygiene.
> Although if you do not intend to use this feature, then keeping it separate
> would allow for a smaller footprint in memory.
>
>>
>>> --- a/diff.h
>>> +++ b/diff.h
>>> @@ -214,6 +214,8 @@ struct diff_options {
>>>       } color_moved;
>>>       #define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
>>>       #define COLOR_MOVED_MIN_ALNUM_COUNT 20
>>> +     /* XDF_WHITESPACE_FLAGS regarding block detection are set at 2, 3, 4 */
>>> +     #define COLOR_MOVED_DELTA_WHITESPACES   (1 << 22)
>>>       int color_moved_ws_handling;
>>>  };
>>
>> Setting of DELTA_WHITESPACES should be a separate field, not as part of
>> ws_handling. It's fine for the ws_handling to be a bitset, since that's
>> how it's passed to xdiff_compare_lines(), but we don't need to do the
>> same for DELTA_WHITESPACES.
>
> You are correct. Thanks for your patience in this series!
>
>> +     git diff --color --color-moved-ignore-space-prefix-delta |
>> +             grep -v "index" |
>> +             test_decode_color >actual &&
>
>>> +     q_to_tab <<-\EOF >expected &&
>>> +             <BOLD>diff --git a/text.txt b/text.txt<RESET>
>>> +             <BOLD>--- a/text.txt<RESET>
>>> +             <BOLD>+++ b/text.txt<RESET>
>>> +             <CYAN>@@ -1,7 +1,7 @@<RESET>
>>> +             <RED>-QIndented<RESET>
>>> +             <RED>-QText across<RESET>
>>> +             <RED>-Qthree lines<RESET>
>>> +             <RED>-QBut! <- this stands out<RESET>
>>> +             <RED>-Qthis one<RESET>
>>> +             <RED>-QQline did<RESET>
>>> +             <RED>-Qnot adjust<RESET>
>>> +             <GREEN>+<RESET>QQ<GREEN>Indented<RESET>
>>> +             <GREEN>+<RESET>QQ<GREEN>Text across<RESET>
>>> +             <GREEN>+<RESET>QQ<GREEN>three lines<RESET>
>>> +             <GREEN>+<RESET>QQQ<GREEN>But! <- this stands out<RESET>
>>> +             <GREEN>+<RESET><GREEN>this one<RESET>
>>> +             <GREEN>+<RESET>Q<GREEN>line did<RESET>
>>> +             <GREEN>+<RESET><GREEN>not adjust<RESET>
>>> +     EOF
>>> +
>>> +     test_cmp expected actual
>>> +'
>>
>> I would have expected every line except the "this stands out" line to be
>> colored differently than the usual RED and GREEN. Is this test output
>> expected?
>
> It is wrong indeed. I blindly copied the actual file once interactive testing
> confirmed it worked.
>
> The command is missing a --color-moved, as the --color-moved-whitespace-settings
> do not imply --color-moved, yet(?)
>
> Thanks,
> Stefan
