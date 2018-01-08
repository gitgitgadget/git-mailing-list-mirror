Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7301FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 17:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeAHRY2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 12:24:28 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:46937 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeAHRY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 12:24:26 -0500
Received: by mail-oi0-f41.google.com with SMTP id d124so3711441oib.13
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 09:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ACwMAvMzq+H2oUBQRgxz6nFm5tLCMxAQeoZfKcz7THA=;
        b=MvPB1gvp7ktrhSo4u7tqYum6k5Cb0se9s/RaIroosGk94QDDePgI5u4Hl2fPaRrKay
         G06amgT/BlzG8KpJ4ZrZ5ebIRWNxlP/8K3CyvFK+ypabBqB02OG6SigWtxo0zew/TO9N
         UlVjAG84JVlkMrjgclPI3hb8Nn5Vl6xgCIAotlJx3uJkUUYkMpdT6de+CS9Uml40hdE0
         cYwnNZR94nJeUaJgffqqsdMrC9VW96uRvIYqf0gA2LbW1VC4mn0iWOFkxSRyQwYi79/D
         D7hpxaoyqkC/fMzdh04Yebhi/RhSzzXBDGRswTfK2dp9reBPKbdF9ffXl4ZhnOTw7LOX
         8oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ACwMAvMzq+H2oUBQRgxz6nFm5tLCMxAQeoZfKcz7THA=;
        b=EjHFpLItBrVVtFJE5bswv3vhXJDVGe0W0jMMy4NugLqOM0zPjtUBZ++ob71Rlx+tNW
         +V1qG41ThKx791boy83BO8Dk+D9ziXrx2o+/tZlojslH2aumOcw0jJxWYrF2xefMQQpU
         kCPGBepBsOCrXUY85CUMYRr8QZ2NFrSyNOVAvzjPkXUG3ZlKr2kiMp0OZEEF4Uij6bUz
         Asr5NNXya/QnfNjXFgfLmOvyQ5ikyoRUb0VQzlG6P6QS0dUZrMMlooQjM/oousNsDUbw
         1jQl4YF1M8RhZNS9qCnjcIoI5QVn8/J3ll2aje0JLu7L5gTU8Pwydzr9lBHHo5idmyG3
         UtDg==
X-Gm-Message-State: AKGB3mKaIzqJ6+U/YSJTtPyc1Bs5krg5l4CXt51xryPBsVxV6rnYN1ya
        9PkeBmPYZkeU2HMimSnQT9UdMFTpB8C5fJHWU0xzFQ==
X-Google-Smtp-Source: ACJfBosGWfzsV9+xD5Ic4zAFZy8v9BbsMpS7cY03rQ0J1apTLr2+cAn9BIPtMNJqXLjFbgt+1F4Q8YrsztuljoqYi/s=
X-Received: by 10.202.239.134 with SMTP id n128mr6824069oih.279.1515432266004;
 Mon, 08 Jan 2018 09:24:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.73.21 with HTTP; Mon, 8 Jan 2018 09:24:05 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801081730170.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAJs94Eas59UxZ+490AUSOuB37i+JBEvbCnGBMVpKi1G469OTbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801081452290.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAJs94Ea52CcNvBxXVeZLvgsaS4YPiXaeDvRm2zUopoLVowgm+Q@mail.gmail.com>
 <CAJs94Ea_Kf5RFMuPreBOGYEjhECdQP2F7m=-wDkf9xRnQFPfhA@mail.gmail.com> <nycvar.QRO.7.76.6.1801081730170.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Mon, 8 Jan 2018 20:24:05 +0300
Message-ID: <CAJs94EYrBgNW-bzoEgy9=fStJW2esoULxfOHX45V63HavqOCpw@mail.gmail.com>
Subject: Re: rebase preserve-merges: incorrect merge commits
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-08 19:32 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:
>
>> 2018-01-08 17:42 GMT+03:00 Matwey V. Kornilov <matwey.kornilov@gmail.com>:
>> > 2018-01-08 16:56 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> >> Hi Matwey,
>> >>
>> >> On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:
>> >>
>> >>> I think that rebase preserve-merges algorithm needs further
>> >>> improvements. Probably, you already know it.
>> >>
>> >> Yes. preserve-merges is a fundamentally flawed design.
>> >>
>> >> Please have a look here:
>> >>
>> >>         https://github.com/git/git/pull/447
>> >>
>> >> Since we are in a feature freeze in preparation for v2.16.0, I will
>> >> submit these patch series shortly after v2.16.0 is released.
>> >>
>> >>> As far as I understand the root cause of this that when new merge
>> >>> commit is created by rebase it is done simply by git merge
>> >>> $new_parents without taking into account any actual state of the
>> >>> initial merge commit.
>> >>
>> >> Indeed. preserve-merges does not allow commits to be reordered. (Actually,
>> >> it *does* allow it, but then fails to handle it correctly.) We even have
>> >> test cases that mark this as "known breakage".
>> >>
>> >> But really, I do not think it is worth trying to fix the broken design.
>> >> Better to go with the new recreate-merges. (I am biased, of course,
>> >> because I invented recreate-merges. But then, I also invented
>> >> preserve-merges, so ...)
>> >
>> > Well. I just checked --recreate-merges=no-rebase-cousins from the PR
>> > and found that it produces the same wrong result in my test example.
>> > The topology is reproduced correctly, but merge-commit content is
>> > broken.
>> > I did git rebase --recreate-merges=no-rebase-cousins --onto abc-0.1 v0.1 abc-0.2
>>
>> Indeed, exactly as you still say in the documentation: "Merge conflict
>> resolutions or manual amendments to merge commits are not preserved."
>> My initial point is that they have to be preserved. Probably in
>> recreate-merges, if preserve-merges is discontinued.
>
> Ah, but that is consistent with how non-merge-preserving rebase works: the
> `pick` commands *also* do not record merge conflict resolution...
>

I am sorry, didn't get it. When I do non-merge-preserving rebase
--interactive there is no way to `pick' merge-commit at all.

> Ciao,
> Johannes



-- 
With best regards,
Matwey V. Kornilov
