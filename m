Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B160201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 01:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbdKNBap (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 20:30:45 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:53939 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdKNBao (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 20:30:44 -0500
Received: by mail-vk0-f48.google.com with SMTP id k195so11253940vke.10
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 17:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SR3owemYjDWMIYr0m07/sXxUJrL1EFDrhuV9ipNgEdo=;
        b=Tb8/a+i/d7QzZDzTS8EmcjCPZc1b8HFRI+ut8d8N+L+Y/25YLRSUlU+hjYyh2jl92y
         ARXh96kNkEbeVcnVdvEj/eQHD/0YqnWsMTPKz9p0WyaUAuQT/Vo+pW8mTEy48Csr+Dmo
         4fRQ9Ut+OGpJtSjBz76j/B42gd8NodNYQLVZCi1vd01BWV7P23MvjLKetTSWrcpGZc/P
         o8rizwLTmLtzdy2vwr7qLamsHy+vwNwvlBeP2gf+pMxn8T+wSmMnM1W7c8KdSSrT+REC
         I8hERriLpobSadskJ7cnGVC1myr2+giZ3qdj6JKlcD66CiMT+NbJ5Rz5DDA2ZZoWDsNh
         AFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SR3owemYjDWMIYr0m07/sXxUJrL1EFDrhuV9ipNgEdo=;
        b=cdoSVUD8uf357Pw3xpXJU2KX1Nx2Bdq3sj3Tix7N5Z27YIJ5BhuYk2gwFkyO5Do6Sw
         oA9tpDgkpz7uGuBrT8uqYmW1dAeGEl77B9AVvRNpSZ7W8sRAio08FVAfw8W5C2m75q7K
         VuLrw/Ti0u9aS7+2IQ8vtI40hDC2d2+QPUrqz4IujyuH2PKx1Xbu9AsVJKC0Cafup4f+
         QlQ9BypBshcZvQTpykc4cbQ431ELKWfsBNW4IWx7m+1nWZlGHKEGCUkoNQlBCqVBJcr0
         fDGRf51HmyQviPUx37J06BsL+GzTtGRC3i/Z2QzwGeQywlT9Jndw9UmJL7oOdYWsVbej
         dIXA==
X-Gm-Message-State: AJaThX5eGcO4QKf5d9qKLorEOjD0SPkKusr1g9PRhHcvVjGV1McVqdFd
        teMSJ3e/Eoop8Othv9jXD9iWepRjuufhxvEf9TnG7A==
X-Google-Smtp-Source: AGs4zMbDxAonShUtou2ROU6U7U0k21LV46hBKjrioIIO0xOjAFaqz7Zwm36y8a8MKiCpIDaLXs4aNYVEKA4gLxti7Us=
X-Received: by 10.31.61.11 with SMTP id k11mr8294174vka.153.1510623043588;
 Mon, 13 Nov 2017 17:30:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Mon, 13 Nov 2017 17:30:43 -0800 (PST)
In-Reply-To: <CAGZ79kbsQqAFGFVN3dOnSAFuPishF3PGS7_go+53T5Oa-4qWiA@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-10-newren@gmail.com>
 <CAGZ79kbsQqAFGFVN3dOnSAFuPishF3PGS7_go+53T5Oa-4qWiA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Nov 2017 17:30:43 -0800
Message-ID: <CABPp-BFfWTRvaQrBn+gOKsu8s9fzT2eiTVeSw93p6SvzdQBPjw@mail.gmail.com>
Subject: Re: [PATCH 09/30] directory rename detection: testcases checking
 which side did the rename
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 4:25 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
>> +# Testcase 6b, Same rename done on both sides
>> +#   (Related to testcases 6c and 8e)
>> +#   Commit A: z/{b,c}
>> +#   Commit B: y/{b,c}
>> +#   Commit C: y/{b,c}, z/d
>
> Missing expected state

Oops!

>> +#   Note: If we did directory rename detection here, we'd move z/d into y/,
>> +#         but C did that rename and still decided to put the file into z/,
>> +#         so we probably shouldn't apply directory rename detection for it.
>
> correct. Also we don't want to see a rename/rename conflict (obviously).

Interestingly, (and this is unrelated to directory rename detection)
merge-recursive.c has a RENAME_ONE_FILE_TO_ONE value exactly for the
case where one file was renamed on both sides of history, but was
renamed to the exact same thing on both sides.  And in those cases, it
turns what would otherwise be a rename/rename(1to2) conflict into
essentially a RENAME_NORMAL case.  So, we wouldn't have to worry about
a rename/rename conflict anyway.

>> +# Testcase 6e, Add/add from one-side
>> +#   Commit A: z/{b,c}
>> +#   Commit B: z/{b,c} (no change)
>> +#   Commit C: y/{b,c,d_1}, z/d_2
>> +#   Expected: y/{b,c,d_1}, z/d_2
>> +#   NOTE: Again, this seems obvious but just checking that the implementation
>> +#         doesn't "accidentally detect a rename" and give us y/{b,c} +
>> +#         add/add conflict on y/d_1 vs y/d_2.
>
> What is less obvious in all these cases is the "(no change)" part to me.
> I would think that at least *something* changes in B in all cases above, maybe
> add file u/r (un-related) to have the tree ids changed?
> ("Less obvious" as in: we don't rely on the "no changes" part to make
> the decision,
> which sounds tempting so far)

Yes, I could have introduced unrelated changes into the test, and my
assumption is that the real world testcase would have such, it's just
that in paring down to a minimal testcase I end up with a "no change"
commit.

>>  test_done
>
> No conclusion box here, so my (misguided) suggestion:

Yeah, the conclusion was actually in the summary.  I could potentially
restate it here:

"Only apply implicit directory renames to directories if the _other_
side of history is the one doing the renaming"

I can add that.
