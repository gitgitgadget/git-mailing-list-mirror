Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E17E1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 19:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeDCTWf (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 15:22:35 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:38260 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDCTWe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 15:22:34 -0400
Received: by mail-yb0-f181.google.com with SMTP id k1-v6so1171727yba.5
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PY4qd60WWDYBy1Cgw7O0Br6CE+UIeEReaDrjudiFkvc=;
        b=mV0qGayBkLk/ZsssR2ZCskNtnBxmZEEkUGn77vcqOG6h9ktTbYitOmoujS14Kbib7e
         EcgPn4bnUL5r3PucSoG4M5sup0DmaqVEQ17XVKW9XmeN0RIdojT6c3AiQdS7sSmFEyVR
         uM+2oGw28Fn8Dm56eIQekh8IaRt+DMYmXhJYI/h67p9qpFcp8l++w+0VC72VUl+/ZX97
         QTgcQ/wNacuo3gDly6ZvLuhYkg+V+GFSoWXYxDRlwQ4VB+ovDtJCsaEAOUcB4urCVnmZ
         aaOlnJovj0HoVfqsSf5SLK37ZR5NZJEb07rrs3q6W3ijKwNSaOE9aO+fEEtBrltDfBDk
         r6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PY4qd60WWDYBy1Cgw7O0Br6CE+UIeEReaDrjudiFkvc=;
        b=Ty5rsFZA7HZHudZkUJH/9tuPtHnLXHnxBa9WomFaFQ2PLDRF1elSYnC6KIw1l2w/YG
         ii1GkNWT0VXhJc8MGIccW4JA7U6hDuljfFQtTQDrzDbhEZG8GmBR3kU8N307Q5i0UEF2
         C2wxLmDlG27LXOF7nL/6sSc8v75DjEYRNa8xKzGLxFsXeALU7Xf4B2C7gVMsH91ulX+D
         flcAL0jsyh+7XzfInlk3KRypqtxkJqgmdZX0WjEG4GEd99Fr+6Gm8+R9XBJH14IoCWiT
         f8nEi2w4BWEFqkTQp0UsO7vAWcrcNevDS0dbR9YDp/wpQtRrIZLb2bjn+62lcQwGuhdu
         sgaw==
X-Gm-Message-State: ALQs6tBmCrdUAYl5aovs8SciYffvWiHXtd+GrwDFdZozAOzB9vNJtnl9
        f4jZzygzAHBkQD5k+Xk+orGKigxDBU+Qdk/UVOGARg==
X-Google-Smtp-Source: AIpwx49cS9y1mMMwk/8rxMCosGvLMUwzTCbu3dE6+/0LtQ4Drx2bjn8YrFTdtqwCiYHf2deHFNa2fjdBay7QrZ5YFCw=
X-Received: by 10.129.108.67 with SMTP id h64mr420273ywc.500.1522783353284;
 Tue, 03 Apr 2018 12:22:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 3 Apr 2018 12:22:32 -0700 (PDT)
In-Reply-To: <20180402174118.d204ec0d4b9d2fa7ebd77739@google.com>
References: <20180402224854.86922-1-sbeller@google.com> <20180402224854.86922-8-sbeller@google.com>
 <20180402174118.d204ec0d4b9d2fa7ebd77739@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Apr 2018 12:22:32 -0700
Message-ID: <CAGZ79kYPx=OB92yWFw8W=zJDoJT5BjBd3Q+gt_WS_KuUw299vQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] diff.c: add --color-moved-ignore-space-delta option
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Simon Ruderich <simon@ruderich.org>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 2, 2018 at 5:41 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Mon,  2 Apr 2018 15:48:54 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> +struct ws_delta {
>> +     int deltachars;
>> +     char firstchar;
>> +};
>
> I'll just make some overall design comments.
>
> Shouldn't this be a string of characters (or a char* and len) and
> whether it was added or removed? If you're only checking the first
> character, this would not work if the other characters were different.

I considered diving into this, but it seemed to be too complicated for
>95 % of the use cases, which can be approximated in change of the
first character.

Because if we take a string of characters, we'd also need to take care of
tricky conversions (e.g. Are 8 white spaces equal to a tab, and if so do
we break blocks if one line converts 8 ws to a tab?)

So I would definitely pursue the string instead of change of first
character, but what are all the heuristics to put in?

Just to be clear: The string would contain only the change in
white space up front, or would we also somehow store white space
in other parts?

- # This is a sample comment
- # across multiple lines
- # maybe even a license header
+ #     This is a sample comment
+ #     across multiple lines
+ #     maybe even a license header

How about this?


>
>> @@ -717,10 +752,20 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
>>       const struct diff_options *diffopt = hashmap_cmp_fn_data;
>>       const struct moved_entry *a = entry;
>>       const struct moved_entry *b = entry_or_key;
>> +     unsigned flags = diffopt->color_moved & XDF_WHITESPACE_FLAGS;
>> +
>> +     if (diffopt->color_moved & COLOR_MOVED_DELTA_WHITESPACES)
>> +             /*
>> +              * As there is not specific white space config given,
>> +              * we'd need to check for a new block, so ignore all
>> +              * white space. The setup of the white space
>> +              * configuration for the next block is done else where
>> +              */
>> +             flags |= XDF_IGNORE_WHITESPACE;
>>
>>       return !xdiff_compare_lines(a->es->line, a->es->len,
>>                                   b->es->line, b->es->len,
>> -                                 diffopt->color_moved & XDF_WHITESPACE_FLAGS);
>> +                                 flags);
>>  }
>
> I think we should just prohibit combining this with any of the
> whitespace ignoring flags except for the space-at-eol one. They seem to
> contradict anyway.

ok, we can narrow this one down to ignore all white space.

>
>> +test_expect_success 'compare whitespace delta across moved blocks' '
>> +
>> +     git reset --hard &&
>> +     q_to_tab <<-\EOF >text.txt &&
>> +     QIndented
>> +     QText
>> +     Qacross
>> +     Qfive
>> +     Qlines
>> +     QBut!
>> +     Qthis
>> +     QQone
>> +     Qline
>> +     QQdid
>> +     Qnot
>> +     QQadjust
>> +     EOF
>
> Do we need 5 lines? I thought 2 would suffice. (It's the ALNUM_COUNT
> that matters, as far as I know.) This makes it hard to see that the
> "But!" line is the one that counts.

I did not want to go with the bare minimum as then adjusting the minimum
would be a pain as these unrelated (to the minimum) test cases would
break.

>
>> +test_expect_success 'compare whitespace delta across moved blocks with multiple indentation levels' '

>> +     EOF
>
> If the objective it just to show that the functions f and g are treated
> as one unit despite their lines being of multiple indentation levels,
> the test file could be much shorter.

yeah, I noticed that we already test that in the test above where we
have that test after the "But!", where lines ziggy-zag. Will drop this test.
