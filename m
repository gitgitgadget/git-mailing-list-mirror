Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851E91F454
	for <e@80x24.org>; Tue,  6 Nov 2018 16:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbeKGBdM (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 20:33:12 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:55678 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbeKGBdM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 20:33:12 -0500
Received: by mail-it1-f174.google.com with SMTP id b7-v6so18545634itd.5
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 08:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dEcrNU+EnZn+MZSKIJpke2+NC3drpYc496nDVCsUpqY=;
        b=qajknP6KVFRiYtuxdJuJSMRSMuMPN4M/vZYcouaR2HIpwmzFbiONELnI3aRrghj+nt
         UYFtdqd7Z/8Ql6kOmX/dQeuclvx69pjPUllkX2xPgA5PP2tTObvxkDdxQcqrQw4dsoF9
         b2wgziopL1iONa9Hubu9EohqY+IDKZ/ExllkXJcOZtFkLKOVg4Z0D2kX6ZM7I/pBC/Kh
         km5FOXrKEwv/qjIk9itBnWyMyBxIlrDd0CKZdullhY1OeyEj8bx3bEv9JOEHpxi9dcpg
         3kOn5x5gbm36Vw2DtLr4ITxZCTsjixq/F/lY09KWQ0FAIVwS9TpEXXFbGB1+n0IpSkX4
         Omcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dEcrNU+EnZn+MZSKIJpke2+NC3drpYc496nDVCsUpqY=;
        b=YhLopF56ZX+gBma3Cd0ZoKlhRA6gG33aM0en8hDNYOMLxiY8dywqtWO2Lz0+KBXnDC
         nSFKorQAa8tWBUztlmO9kEaZ4+Kfzg87pD39dAXpiLc2coNv7RbM7K4wFDSruWgXT8ap
         R5g1Ws2poIAFlMmE2gVWUKjCLjfhpOs41uAmAtMixWqkPC6dNWKNCpfgms4n+95vJSTB
         ggWn9ihbg/uBmzm9YxECnuDQLroLQCc46aHAdc9AGdrtpYJC9EClwXggjLgTxI4aoJPJ
         pgql/Hf2nGoz+/q7ilgnMroY+6RAOeW5ZFCWg//1C9qACfIXorpRl1oJvDdZlXfHsABH
         1EPA==
X-Gm-Message-State: AGRZ1gL+thRYDTzH69ISWgNz1FHknqz7C6ut2e6CJAszkwMnITQm4b/P
        hyp72iz3NNvY/tCOUnBs6L1uUcuqyKtf/9o9ulw=
X-Google-Smtp-Source: AJdET5eujkLEfV/SFHuHyL1bltW81TUmiBt9bbFlI+Ahkv/N5t+LpAq0St4d3vS7KsPJ7Jr0lLmkH3gRbSzn2RE+Pp8=
X-Received: by 2002:a02:5748:: with SMTP id u69-v6mr24062167jaa.30.1541520437472;
 Tue, 06 Nov 2018 08:07:17 -0800 (PST)
MIME-Version: 1.0
References: <CAFd4kYBDWMvVgDmNTzwOK9Q7n_Fb0NrvNAFgHtKvkLkRFWqUKw@mail.gmail.com>
 <xmqqlg6covi6.fsf@gitster-ct.c.googlers.com> <CACsJy8DFUeEddSa2z4VTSqhaUBJ4+SUf8xvjh6iWY2Phhh96iQ@mail.gmail.com>
 <CAFd4kYDcX2BOYvMg1X9zO68EfYYE6Zke_-9CGY-Yi01jCc3EPA@mail.gmail.com>
In-Reply-To: <CAFd4kYDcX2BOYvMg1X9zO68EfYYE6Zke_-9CGY-Yi01jCc3EPA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Nov 2018 17:06:50 +0100
Message-ID: <CACsJy8AYtz2tjo5ZB_6Mj9MWaUnYGs4GUO2+6E6nDKiNzrJoAg@mail.gmail.com>
Subject: Re: Understanding pack format
To:     Farhan Khan <khanzf@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 6, 2018 at 3:23 AM Farhan Khan <khanzf@gmail.com> wrote:
> To follow-up from the other day, I have been reading the code that
> retrieves the pack entry for the past 3 days now without much success.
> But there are quite a few abstractions and I get lost half-way down
> the line.

Jeff already gave you some pointers. This is just a side note.

I think it's easier to run the code under a debugger and see what it
does than just reading it. You can create a repo with just one blob to
have better control over it (small packs also make it possible to
examine with a hex editor in parallel), e.g.

git init foo
cd foo
echo hello >file
git add file
git repack -ad
gdb --args git show :./file

then put a breakpoint in some interesting functions (perhaps one of
those Jeff pointed out)
-- 
Duy
