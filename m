Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A37120705
	for <e@80x24.org>; Tue,  6 Sep 2016 02:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753618AbcIFCUJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 22:20:09 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:35210 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbcIFCUI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 22:20:08 -0400
Received: by mail-it0-f52.google.com with SMTP id e124so171051474ith.0
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 19:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NitnduuYODXk5JYVXyKK754PRI+G6z5LCLvNRFD5TCc=;
        b=osLFASlrG/F550TaZGQBtL8dacQ01wyrvnt5jCm5Z3ui9sEeUooyKj1PusgjETKsWm
         PI79lBJBLjDdOw5fnroVsUvUdfc6KhMOR9QIeTXjwjjJ+rLFBvcZ5ls0U+BGLwfFzL6n
         7Ah3QqUqOiclce762NUW6WYEk9lNM5YGjRK3S/yujz4xTMAS4/4ZUoMTCG+5/xxqLQux
         aCEWAw+h5hcBCdEHPjBMAJ61epQ5SOVCmWTVmxUBq0g9kgobzzBcR6NF2V8l6PhJursD
         HoC9dPfA6mKi/DH0mscmK5k3UjGMVcE9U8tii/AqhUDi5G2ofmW5HDDcTl5NOqnGrA9g
         u44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NitnduuYODXk5JYVXyKK754PRI+G6z5LCLvNRFD5TCc=;
        b=i59TowTxIoOxc67/cGxPROMLHSZuIDvt3fPS7RmF1c2Z96PZWz4S0fGw5bmgkLTQWP
         UxVIKTyT0BQJqPwOvCiM/t+aL423uXAlBqPE5b1gp18M6g/ylTs4FSA4+9f9ZRr1qwZh
         Q9f1FWKOjGv/gE+AGRBwZ30gjxlXTso2k+OFnPAUjDHMDAOR0k4jD3U8x20UMivCFaLQ
         vPiRbWBvSRPf9swuk6U/FDDgKfEy+yCk3HUuIf3fs0NoqRAnDgvwS7mFCjpSfHgPfb6U
         ZZGhRUQWi1aWFUwH+Zt3COXhlo+mmq4/nSFY3svP0e97sm5Uw340IC5/XLCEw7lAdxPb
         E2Dw==
X-Gm-Message-State: AE9vXwMIu1+EH2Ii/ZbBHM3YaxG3D0ruMGDQ/n30aA7F+oF+BnL+V44AlSM9oZSAEzsbP1QYiCfObmOvfVm+5yHu
X-Received: by 10.107.139.136 with SMTP id n130mr2277622iod.173.1473128407679;
 Mon, 05 Sep 2016 19:20:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 5 Sep 2016 19:20:07 -0700 (PDT)
In-Reply-To: <CA+P7+xr=Lp36wDw2BRuhQ9Genv4q6iu9beGQe5hzOn5PJYDPfw@mail.gmail.com>
References: <20160904234237.10548-1-stefanbeller@gmail.com> <CA+P7+xr=Lp36wDw2BRuhQ9Genv4q6iu9beGQe5hzOn5PJYDPfw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Sep 2016 19:20:07 -0700
Message-ID: <CAGZ79ka7VV6Pqw-rcVFv0xU4J4D9dHWPg-oocPPWJdY5JVhT+A@mail.gmail.com>
Subject: Re: [PATCHv3] diff.c: emit moved lines with a different color
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 5, 2016 at 6:17 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sun, Sep 4, 2016 at 4:42 PM, Stefan Beller <stefanbeller@gmail.com> wrote:
>> When we color the diff, we'll mark moved lines with a different color.
>>
>
> Excellent idea. This is a very neat way to show extra information
> without cluttering the diff output.
>
>> This is achieved by doing a two passes over the diff. The first pass
>> will inspect each line of the diff and store the removed lines and the
>> added lines in its own hash map.
>> The second pass will check for each added line if that is found in the
>> set of removed lines. If so it will color the added line differently as
>> with the new `moved-new` color mode. For each removed line we check the
>> set of added lines and if found emit that with the new color `moved-old`.
>>
>
> Makes sense.
>
>> When detecting the moved lines, we cannot just rely on a line being equal,
>> but we need to take the context into account to detect when the moves were
>> reordered as we do not want to color moved but per-mutated lines.
>> To do that we use the hash of the preceding line.
>
> Also makes sense.
>
>>
>> This patch was motivated by e.g. reviewing 3b0c4200 ("apply: move
>> libified code from builtin/apply.c to apply.{c,h}", 2016-08-08)
>>
>
> Yes, this would be quite helpful.
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 0bcb679..f4f51c2 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -980,8 +980,9 @@ color.diff.<slot>::
>>         of `context` (context text - `plain` is a historical synonym),
>>         `meta` (metainformation), `frag`
>>         (hunk header), 'func' (function in hunk header), `old` (removed lines),
>> -       `new` (added lines), `commit` (commit headers), or `whitespace`
>> -       (highlighting whitespace errors).
>> +       `new` (added lines), `commit` (commit headers), `whitespace`
>> +       (highlighting whitespace errors), `moved-old` (removed lines that
>> +       reappear), `moved-new` (added lines that were removed elsewhere).
>>
>
> I liked Junio's "Moved from" and "moved to" but I think moved old and
> moved new are ok as well.

as we do not want to see dashes ('moved-old'), I think I'l go with
"movedfrom" and "movedto".

>
>> @@ -287,6 +304,25 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
>>         return git_default_config(var, value, cb);
>>  }
>>
>> +static int moved_entry_cmp(const struct moved_entry *a,
>> +                          const struct moved_entry *b,
>> +                          const void *unused)
>> +{
>> +       return strcmp(a->line, b->line) &&
>> +              a->hash_prev_line == b->hash_prev_line;
>
> So we're only comparing them if they match and have a matching
> previous line? That seems pretty reasonable to reduce the cost of
> computing exact copied sequences.
>
>> +       if (ecbdata->opt->color_moved) {
>> +               int h = memhash(line, len);
>> +               hash_prev_removed = h;
>> +               hash_prev_added = h;
>> +       }
>>  }
>
> If I understand, this is to ensure that we don't keep re-hashing each
> line right?

No, this is to ensure we have the context sensitivity of one prior line.

In the collection phase we look at each line of the patch and make a hash of it.
Then we store the hash temporarily (think of a state machine that goes line by
line and always keeps the hash of the last line)

What we store in the hashmaps is the hash(current line) ^
hash(previous applicable line).
With previous applicable line I mean any line starting with " " or "+"
when the current
line starts with "+" and " " or "-" when the current line starts with "-".

When going through the second pass and actually emitting colored lines
we only find matches in the hash map if the current line AND the previous line
match as we lookup by hash code, i.e. if we have a moved line, but the
previous line
changed we do not find it in the hashmap and we don't color it, such
that the reviewer
can spot a permutation.

So in the second phase we also need to have access to previous line, so maybe
we could also go with just taking the line with us instead of 2 hash codes.
But that implementation detail seems like a trade off to me, where I'd lean
on keeping the hashes around as lines may be very long in bad cases, whereas
the hashcode is short and it is a cheap hash.

(I am referring to http://i.imgur.com/MnaSZ1D.png where in the malicious
case all lines were moved to there as well, but permutated)
