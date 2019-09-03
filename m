Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A97E1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 01:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfICBBc (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 21:01:32 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:34987 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfICBBc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 21:01:32 -0400
Received: by mail-io1-f46.google.com with SMTP id b10so32234302ioj.2
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 18:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpRaRQUI+RxJaPb/GpyHwAJgmo2mNsKsAv6B80LcGrA=;
        b=Ocy9IDc78BkwK1nLZexbKa8kwSCkG/xRQDnm159cQeqVRGIcyD0m5AHHA3sNZwSVFm
         xZsxp1QdTiqp0tAUxLpAOyjGZGPFAHUHaP1mgmaYoHC3OdjPH4cz1CPXywONfAR7e9rJ
         VmLXhHOq+PLRqnL7QiK4wjlD1ln9Au8bK0JsIaIRl1g6rVA1uemDu5LXM18lbZ4wuzTv
         5e70Prr4bHU4ZnCGCIzfduTE313FeVU7PwHF+rDFVgctUzqcDd7CNaNiMQ39Z+616PEC
         2Kxeo1r8hQG7/vT6RWwEzKFgqUczLnhTh/WyBXZsikpk4HCWvRiCfD/2PaB/YFaYTDG6
         wfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpRaRQUI+RxJaPb/GpyHwAJgmo2mNsKsAv6B80LcGrA=;
        b=FoIRvwNpczKIPwbn/98IlIO4BECpkM0ix3aG+o4JHGUsCBzmNTA0r1b+7kNIFUNRGv
         9YasL32ZoaDfxUiaQPOZ6rD7t7P5/iIT1Fq8xv5nuMAH6dF05ez3jxqiWjw6h4cNgoi4
         +t1AS53j+LbgYYbMksSXSeRaPovHrpVgIxlW8O+wJOz5X2IHVJnpjPkWkux02/usCvtd
         tnJvgEoqtWsPcX6ht+6jUZzpkMgKvKxjcp2rLo+ajoOgLRCe+F5WR2xMijwTmOqkBlr9
         5zNYz3ljKOccg4avtxwwibQaZseCIsQfYlzLWQbpURZZ1jRDapz6i+6nc5wEzgYc6+wV
         oFSA==
X-Gm-Message-State: APjAAAU7q8QXiVIhD0r1vQdRip/tTM+uzyy9v5zU1n9LB4xTQJyqjy5v
        xuGNpCinT4ViiKe513IWg+wM+8LOG+DefZcnD6E=
X-Google-Smtp-Source: APXvYqyofHlciHUe/hd6/dv7s1x6PM/+5uYt5tmBrHvEviRBrv1C+se19H2IwggVBKZg+1+EmY2PaNZ65I7UYq5usAY=
X-Received: by 2002:a05:6602:2193:: with SMTP id b19mr12029453iob.113.1567472491012;
 Mon, 02 Sep 2019 18:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com> <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
In-Reply-To: <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
From:   David <bouncingcats@gmail.com>
Date:   Tue, 3 Sep 2019 11:01:19 +1000
Message-ID: <CAMPXz=pUWNVkM78UHm4NpFZ_nJQOa0ba07N3gMKFzWUiindZ1Q@mail.gmail.com>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 3 Sep 2019 at 04:11, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> On Mon, Sep 2, 2019 at 6:25 PM Birger Skogeng Pedersen <birger.sp@gmail.com> wrote:
> > On Sat, Aug 31, 2019 at 12:51 PM Birger Skogeng Pedersen <birger.sp@gmail.com> wrote:

> > > In my pursuit to fully utilize git-gui with only using a keyboard, I
> > > suggest that there is a hotkey to toggle between selecting "New
> > > Commit" and "Amend Last Commit".

Hi, thanks for maintaining and contributing to git and git-gui, it's a
great tool!

> After focusing the commit message widget, you can focus the radio
> buttons with Tab/Shift+Tab and press Space.

> I think this is short enough, so that wasting a Letter is not
> justified here.

Ugh, may I express how unhappy I am to read that opinion from
the maintainer. I strongly disagree, please reconsider :(

And I enthusiastically support this initial request for a single
hotkey to immediately toggle between "New Commit" and "Amend Last
Commit". And it should work regardless of wherever the cursor or
highlight is currently active.

I have used git-gui for many years and I find this is actually the
most annoying and inconsistent aspect of its user interface. Sometimes
if one is lucky then "spacebar" will achieve it at startup or after
refresh, sometimes not. When I test here just now the suggested
tab/shift-tab/spacebar method, it does toggle but it also changes the
items in the staged changes list as an unwanted side effect. My
version says 0.20.0.8.gd000, but I have a few local patches (written
years ago) so sorry I am not testing with a version that you have, but
even so I wanted to report what I observed.

If one is often amending commit messages as I do during large
interactive rebases, it is painful to have to do some kind of
context-sensitive multi-key dance just to change from "New Commit" to
"Amend Last Commit". Especially when every other operation has become
a single keystroke in my muscle memory.

In my world it most definitely would not be "wasting a letter" to
implement this! It would instead be "OMG at last that got fixed for
everyone, hooray!" :D
