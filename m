Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88F511F600
	for <e@80x24.org>; Sun, 23 Jul 2017 23:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbdGWXEF (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 19:04:05 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:37572 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdGWXEE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 19:04:04 -0400
Received: by mail-ua0-f170.google.com with SMTP id f9so66876328uaf.4
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 16:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SLaV3jQJeWenSV9wEvXvwovUiry+HnQR9v2VePbi9Qw=;
        b=b2gCxq4HaQbLn8YaXzGYglEOPToo7T/lIqyoBEuQYkdbPrZlJgVmiMAgCqMgs22lOj
         Z+rniQsKj0pIzAZ+F+Q7YPs9/6iuey6zWmwXus+dVZGTh5gPpYdx8pdoL7tFA7RrHrM/
         7gaSQ9ABk6ul7iTzf4maiS0Ae9MYl2h5W1M7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SLaV3jQJeWenSV9wEvXvwovUiry+HnQR9v2VePbi9Qw=;
        b=U9kCCIVkerWBXah3e2ty6WIyxpbYKx7zPMOSF496XP0N5gUh/7pEDj/cBknz0qKH0o
         AAWa3tQ9MiwV1scsAkmZMS85q7wlfkkKTP1ebwt0uHZOfTVzHTfT3MbGBy7g+WzJkt0V
         zhlXS5ELYoNzbS+GewYiwIh4r1kXZ+27Udw/c1tthjglaA7yV2MLQZ5Gskj3oipDOnI/
         nHfZYJUoOXvYdfLu6JPwfj/SKLh6YYAmb5xqSU6f6zDZDh6HNQPBwESNi4Gws0h/zxv5
         LJ1axcVZDrDbNW1jUf2duNXZnbHUeiKE3gW5aVPJNvo+XnogD0gr5YPHp0HN3oktrik6
         xT0w==
X-Gm-Message-State: AIVw110UphASBeUZ2UWZP281WuH69x/Dh4Rd9X4mPfoexzN7G84xr5qF
        tZi1sH/jiD4ymEFvOfPVAv5yYdnsYboKJnrF7g==
X-Received: by 10.31.138.213 with SMTP id m204mr2824507vkd.149.1500851043693;
 Sun, 23 Jul 2017 16:04:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.137.4 with HTTP; Sun, 23 Jul 2017 16:03:43 -0700 (PDT)
In-Reply-To: <CAJo=hJvm5P6fq4KzZsO0h879xU4pV05MOscCWBPy_gCCYSxobQ@mail.gmail.com>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <CAMy9T_GsgDewHhe1heH7t2qPZuE3XQOKzoxc50-fLmOqm=6ZzQ@mail.gmail.com>
 <CAJo=hJv36tYuxHuso7NrPkfE9hApGfn=iP8g_8+MeM8L91h09g@mail.gmail.com>
 <CAMy9T_Fuf3YoHzsLgx-fcX5OQBNXw8xOvrPEpffkYjWGBpNsMQ@mail.gmail.com> <CAJo=hJvm5P6fq4KzZsO0h879xU4pV05MOscCWBPy_gCCYSxobQ@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Sun, 23 Jul 2017 16:03:43 -0700
Message-ID: <CAJo=hJty4nWBVBmxOJn5HEi9-9uY8kYEt6H6Sk9_c6nNWqJLUQ@mail.gmail.com>
Subject: Re: reftable: new ref storage format
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 23, 2017 at 3:56 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Mon, Jul 17, 2017 at 6:43 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On Sun, Jul 16, 2017 at 12:43 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>> On Sun, Jul 16, 2017 at 10:33 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
>> * What would you think about being extravagant and making the
>> value_type a full byte? It would make the format a tiny bit easier to
>> work with, and would leave room for future enhancements (e.g.,
>> pseudorefs, peeled symrefs, support for the successors of SHA-1s)
>> without having to change the file format dramatically.
>
> I reran my 866k file with full byte value_type. It pushes up the
> average bytes per ref from 33 to 34, but the overall file size is
> still 28M (with 64 block size). I think its reasonable to expand this
> to the full byte as you suggest.

FYI, I went back on this in the v3 draft I posted on Jul 22 in
https://public-inbox.org/git/CAJo=hJvxWg2J-yRiCK3szux=eYM2ThjT0KWo-SFFOOc1RkxXzg@mail.gmail.com/

I expanded value_type from 2 bits to 3 bits, but kept it as a bit
field in a varint. I just couldn't justify the additional byte per ref
in these large files. The prefix compression works well enough that
many refs are still able to use only a single byte for the
suffix_length << 3 | value_type varint, keeping the average at 33
bytes per ref.

The reftable format uses values 0-3, leaving 4-7 available. I reserved
4 for an arbitrary payload like MERGE_HEAD type files.
