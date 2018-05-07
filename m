Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41D5C200B9
	for <e@80x24.org>; Mon,  7 May 2018 21:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbeEGVTp (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 17:19:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37681 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752803AbeEGVTo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 17:19:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id e9so18898085pfi.4
        for <git@vger.kernel.org>; Mon, 07 May 2018 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nHHW5hUWuaoRw7E1LW1usZYZ+TQrcm60/OTg/1/tm+4=;
        b=ELWUL55z6GxoMg56GPzlpxdkCdRYiTMGBTmsAmw3WRSybW2n7rIrBsYTc2CmTn1gph
         CnVbsQ0ArdXPOhDB9pPy1xrrc+41MROCM/kqedJsvBGPhwzpcRgjGNcg2azZSvkx9qr8
         ll6kNlV7UlXEzpuwGXZW42umztfYq0vDxuaTv041qdcS5DcptS2QPaWrJK40+fnuxqPq
         XDD7Eqa53LIBkvulAlFDqw/fqpB0oF3ilafV2rsZriqlR9ZeLpva0OHtfybVwmhQZCWA
         tomMidGYa9abuFudtcFGMne8DfuTbm5hHpkk/wqJd3YXstSv9rfWWrHNGyHGFrUKK1zW
         JBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nHHW5hUWuaoRw7E1LW1usZYZ+TQrcm60/OTg/1/tm+4=;
        b=cTCwH5JJ1XCbnrJVAIm2YATwsJzHSx/bfhHFDCB/jRtsLowRIJRAdTz4foW77S9fKx
         6gp7yY+PBBmLu60Fq1ZVlnCnKDPHOXqqOLtGRV310ytAPfPPZRZPimkHZe70c60rrC1e
         mO6Iwo47+b656MC0yT6OPlYf9LoeDaCUq0pWIs/kunyqs+kzbzFt2F1BxIi7RUqpcr3P
         ZoZIw9Brh3XTa5w6A0WtfNi5DYhexo8ETD/C7iyzvyWswCKnhjFba2baen3lhQfe+BIB
         wZH0ggguJHATHsz50s5IxriNioLOxwpf4QWtdcDBrBitHJFdIMmM/VIbRJPVjxmVqcEf
         wnLQ==
X-Gm-Message-State: ALQs6tDBegKfERumHjDH6DGjr2RUChknwatsxS4mBrV3SIgqmfcL28Yc
        lGaNHLywVMaxHdMOoE8QOfjPa2vrt84GansnaRQ5wXLj
X-Google-Smtp-Source: AB8JxZrxFIBR9DftEKBJ3JH0nYi/16KiRLl31kk4yfAjaogNZjRZaAzuhR3tAaaSDhvS4oLjkzMAxMGeWV1D6uohXOA=
X-Received: by 2002:a63:7b53:: with SMTP id k19-v6mr30851616pgn.146.1525727983549;
 Mon, 07 May 2018 14:19:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Mon, 7 May 2018 14:19:42 -0700 (PDT)
In-Reply-To: <CACsJy8DDyrUinwXx1b66DCHB+2DLt1KBmFt_83R1+HWjbzGH2A@mail.gmail.com>
References: <20180506141031.30204-5-martin.agren@gmail.com>
 <CACsJy8DyRhQ0DKy8UyK+r7Kmw=0hHD=W6aXXKutk4e-wtGTdNg@mail.gmail.com>
 <CACsJy8Btuc2J4aCTymkvLYyMV5zJrdMUdtV5NDnPqXOjsTVw4w@mail.gmail.com>
 <CAN0heSpA5H7Gwwx0TEY9=iFJrgKb0SPXqKOwHK=4NxPYoGjZ7A@mail.gmail.com> <CACsJy8DDyrUinwXx1b66DCHB+2DLt1KBmFt_83R1+HWjbzGH2A@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 7 May 2018 23:19:42 +0200
Message-ID: <CAN0heSr20XFj=W28_kZAp9BWWHExQGMYa4Om=ieYWw+ucrLhRA@mail.gmail.com>
Subject: Re: [PATCH 4/5] lock_file: make function-local locks non-static
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 May 2018 at 17:24, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, May 6, 2018 at 9:32 PM, Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
>> On 6 May 2018 at 19:42, Duy Nguyen <pclouds@gmail.com> wrote:
>> Thank you Duy for your comments. How about I write the commit message
>> like so:
>
> +Jeff. Since he made it possible to remove lock file from the global
> linked list, he probably knows well what to check when switching from
> a static lock file to a stack-local one.
>
>>
>>   After 076aa2cbd (tempfile: auto-allocate tempfiles on heap, 2017-09-05=
),
>>   we can have lockfiles on the stack. These `struct lock_file`s are loca=
l
>>   to their respective functions and we can drop their staticness.
>>
>>   Each of these users either commits or rolls back the lock in every
>>   codepath, with these possible exceptions:
>>
>>     * We bail using a call to `die()` or `exit()`. The lock will be
>>       cleaned up automatically.
>>
>>     * We return early from a function `cmd_foo()` in builtin/, i.e., we
>>       are just about to exit. The lock will be cleaned up automatically.
>
> There are also signals which can be caught and run on its own stack (I
> think) so whatever variable on the current stack should be safe, I
> guess.

Right, that could also happen.

>>   If I have missed some codepath where we do not exit, yet leave a locke=
d
>>   lock around, that was so also before this patch. If we would later
>>   re-enter the same function, then before this patch, we would be retaki=
ng
>>   a lock for the very same `struct lock_file`, which feels awkward, but =
to
>>   the best of my reading has well-defined behavior. Whereas after this
>>   patch, we would attempt to take the lock with a completely fresh `stru=
ct
>>   lock_file`. In both cases, the result would simply be that the lock ca=
n
>>   not be taken, which is a situation we already handle.
>
> There is a difference here, if the lock is not released properly,
> previously the lockfile is still untouched. If it's on stack, it may
> be overwritten which can corrupt the linked list to get to the next
> lock file.  (and this is about calling the function in question just
> _once_ not the second time).

One thing I can try to make clearer is that no-one is holding on to the
address of a `struct lock_file`. Not anyone, anywhere. So whether that
location gets filled with random junk after the function has returned is
irrelevant when it comes to the eventual cleaning up. The only thing
that anyone is keeping track of is the *temp*file. The `struct
lock_file` is just a fancy wrapper for keeping a pointer to a tempfile.
The tempfile infrastructure keeps track of the tempfiles directly,
without tracking any lockfiles.

Maybe it is a bit optimistic to tackle all of these at one fell swoop.
Fiddling with lockfiles makes people nervous, for good reasons. I could
go for the ones where it is easy to see that we always clean things up,
then handle the less trivial ones in a second run-over, or not at all.

Martin
