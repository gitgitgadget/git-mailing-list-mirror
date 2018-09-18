Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8948A1F453
	for <e@80x24.org>; Tue, 18 Sep 2018 19:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbeISBHk (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 21:07:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34773 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbeISBHk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 21:07:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so2927527eds.1
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 12:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szc4gzF/xw592jS7mFd/VOnOGvRJbK9PvVgXfpWIrBI=;
        b=PJpNJe0XY7gj0P99PfpS63MCIvGBl/HUgWbzLfzZV/QBYcTaRu4fJC5O77p5G0P0IT
         HvNxNR8szOllF9Y4SOKcpljfFy11XiwlJrh7+l3MlcGGfUFznTnS6y9KZ1emuhJkEilQ
         8fh2s4NcUwnoPr3GGSAn0s3EdowtbAIc9Wdg63NWJqS1pdl7f+w7oOfvbiXnynPjMlOX
         oBRAi5T1nZLKwH3LLQ26kbFTpjUgp/z282uivnTAl4SMfmARK4EraDz3sfa+feEKq555
         5dNpnzmjoRndzYPN5XXVw2/w2EZkklklriYIlCP048JQQXYXiNxaKn3LjSZDWSUJ3vmr
         AoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szc4gzF/xw592jS7mFd/VOnOGvRJbK9PvVgXfpWIrBI=;
        b=lz7mCQ/ToPcMRmYHE4rvxMjTAF1Hd9Jca2vgtAN3rjrkACVyKgsbJRX0GV322xybmS
         C3fPrjRpu7ByA0YmoELhsBuQOxsWfLjCSJ2nLn9UZel1XEUExXumM1ryWHMAg6TLL5uM
         qbvFFjfm8KHdZrUV2MfjyKtOCpAs8z798jS2fF6DE7etBKou3+F2wDTi/LfNH4dEn7gQ
         mI8v7QiDm2kH9w0ERv98HmO5FIlK/Qb44rTj5nllXA0Nwih/rDuvN9K/qbDLlTa1trJx
         ngbu0zdACG4HbJhacZne0u1bZEAgGK2Y0CZPFGYjgAGbSOtWI61bZYc5eM9YMXmO4vrq
         1Wfw==
X-Gm-Message-State: APzg51Dai5JttpyDs6sIHW4BVwoaqSrAqZ16hVC6tGmlf9+Wbrhl9zTR
        I+kRrHn6yJoGs4pMXwRm7qTvsRzKhoUNxYFHlUk=
X-Google-Smtp-Source: ANB0VdaN8mo1JHeQWCdS8ByGXLI5ypSuJGQ5q9c0nvUZfC9Eewo1TjqBU2YkcgAlUxExoAlwD3Te102Ip8z43ProeAo=
X-Received: by 2002:a50:a7a2:: with SMTP id i31-v6mr53525519edc.296.1537299215932;
 Tue, 18 Sep 2018 12:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180820154120.19297-1-pclouds@gmail.com> <20180916063146.9850-1-pclouds@gmail.com>
 <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 18 Sep 2018 12:33:24 -0700
Message-ID: <CA+P7+xoJ9URXxD=+uqfeqWmscec6=LnUTse_CcVi2z=91Rw=Tw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Make 'git commit' not accidentally lose staged content
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 10:09 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> It usually is safer (simply because you do not have to think about
> it) to start a behaviour change like this as a strict opt-in to gain
> confidence.

I tend to agree, however.. in this case it could be considered safer
to err on the side of not throwing away the index which could have
crafted changes in it.

> The approach to check if the contents in the index matches that in
> the HEAD per-path (i.e. "The contents we are adding to the index is
> whole working tree contents for that path.  But the index already
> has contents different from HEAD for the path---are we losing
> information by doing this?"), is a very good one.  But for the
> protection to be effective, I think "git commit" and "git add"
> should be covered the same way, ideally with the same code and
> possibly the same configuration knob and/or command line option to
> control the behaviour.

Checking both commit and add makes sense to me.

>
> If the information loss caused by the "add/commit X" or "add
> -u/commit -a" is so serious that this new feature deserves to become
> the default (which I do not yet think it is the case, by the way),
> then we could even forbid "commit X" or "commit -a" when the paths
> involved has difference between the index and the HEAD, without any
> configuration knob or command line override for "commit", and then
> tell the users to use "git add/rm" _with_ the override before coming
> back to "git commit".

I was going to suggest we have some sort of reflog equivalent for the
index, but Duy seems to discuss that in a follow-on mail.

>
> How should this new check intract with paths added with "add -N", by
> the way?
