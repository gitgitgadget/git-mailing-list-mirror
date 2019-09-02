Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726A21F461
	for <e@80x24.org>; Mon,  2 Sep 2019 20:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfIBUPh (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 16:15:37 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:34741 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfIBUPh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 16:15:37 -0400
Received: by mail-vs1-f46.google.com with SMTP id r17so7002847vso.1
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 13:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVwaZ5snl61/tlY//FaA1tg1kKmQNShJV6v8+xIc84M=;
        b=DRIxWHJTWXiDe+yxcNVX23Pf1x55HXrqxRCjyjm39BqMnpQ/oWABO/ZlbZOAifzAxx
         DiXZ69xN/Pg0waRwx75f+uff1v1pZzyJkvmZ/8E76OxCTHgdgU9KD7+ywL2tSJelw1Lx
         RkufUZMcNbP2p1k6Hu3hsPz+ifLVS/X2iJ7ykUK+JFlhPeBiC/Veq9rebq3vDm5Auqeu
         5v0fkb6h+TuA4bxQ3J03a1EQoXAUUyt/kBA+STpNVOBKKGTE2FC3ZlOIXUV+aOEPRwEy
         6qTHCqzmw0fWBvWkAlZLsnuHriZvMxHmpMubakNB55TO9EsZ2PX3YIS31n7Wd3XxmyQT
         D3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVwaZ5snl61/tlY//FaA1tg1kKmQNShJV6v8+xIc84M=;
        b=GxUkf/L7/+bq9yQHxUttyHGVszU/0TIIBMxyAMmjtB6DUneAok+AG1t8vwa13xWp2U
         MjA6XA84XbM8SfCBWR4qZlCA3iXAUIhI2KdqabIWPX+Tok7rdurpBgiLp7o9aJOprbaI
         SZ+EZ79YUsCqz+AWeMmQNzIIF1+AlciCTg4LHuvBSlNqOMwdHlaoMyYOQeWn1KXz+CZs
         c6xxY54RsrzSB1LvIOQt6z4K69IvYOIt8ELc8YD0pMxZzoyYfqPBvA8wR9zpt2ZsiNNw
         tySUVhtAKMFuKUZTYVIeVbUVNL369hBdTqUOSPB401GMybZPvbKv9rh1kw6B4ZVLWj0g
         Z/PQ==
X-Gm-Message-State: APjAAAVrhRf1PyOzw7NqhPMRmA2vOp2dnxxzXQPwE3xKGeKBA0NlNHh+
        YCrh7IuWX76E7o38/JJVY0B3rGb+/SDsBbe6aZ3yyy7+
X-Google-Smtp-Source: APXvYqzcRCROZhgy1kNOKExBe9L9wWlr9A54WlcYyXupULZKUbHwzD0aykwNOoTnoDq2EU2d8HkZPtQBE1KIKg8UA3A=
X-Received: by 2002:a67:e45:: with SMTP id 66mr16816027vso.197.1567455336494;
 Mon, 02 Sep 2019 13:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
 <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
 <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com> <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
In-Reply-To: <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon, 2 Sep 2019 22:15:25 +0200
Message-ID: <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 2, 2019 at 10:12 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>
> On Mon, Sep 2, 2019 at 9:49 PM Birger Skogeng Pedersen
> <birger.sp@gmail.com> wrote:
> >
> > Hi Bert,
> >
> >
> > On Mon, Sep 2, 2019 at 8:08 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> > > I think with your "focus" patch, this is not needed anymore:
> > >
> > > After focusing the commit message widget, you can focus the radio
> > > buttons with Tab/Shift+Tab and press Space.
> > >
> > > I think this is short enough, so that wasting a Letter is not justified here.
> >
> > Pressing the Tab key while the commit message widget is focused
> > inserts a tab in the commit message.

does Control-Tab works for traversal?

> > (Again, I'm on Windows so you might get different behaviour on Linux)
> >
> > If the Tab key acted like you suggested, I agree it would not be
> > necessary with this a hotkey like this.
>
> can we try to figure this out, before going forward with anything else?
>
> Thanks.
>
> Bert
>
> >
> >
> > Best regards,
> > Birger
