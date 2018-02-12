Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C826B1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 22:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932918AbeBLWlj (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 17:41:39 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:46031 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932698AbeBLWli (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 17:41:38 -0500
Received: by mail-pg0-f51.google.com with SMTP id e11so2543613pgq.12
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 14:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9yCTA4S03cTS66xvcbLO6ja8NEs6jz71bLFx5WXM4B0=;
        b=tCwNTcCx5Oiggirwh3rjatfzTq0xmtPYjG0eLSKAZMPXINYyxhb8JBXYrvOJKvRg2k
         T69mQ4WXbyored1qz9nw5Q+z2y5DcP0qignjjAXVHdPXbM5EWzJfTFa6puO2v2u0/xku
         dvdYJWRCR5/A5+y1t4ajYHgE8WpTror9S8TS8QgsJy6dCAUdxcqDj5dNED6NW3U0jev3
         MjSKdFIYb5QZY/TNYO/j6Kw7jEy0VUhqdXlbjLkm7ao+buTxdO+9S1fVlI1YCYWpRAb7
         qND/jv5EfR47F/Pol3luOAHQRz7tFwukIVvTJk+SIk7VPAQhcn2emG4jFl7c1ZFoLZHS
         PznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9yCTA4S03cTS66xvcbLO6ja8NEs6jz71bLFx5WXM4B0=;
        b=Bg0+OwI5UiUVsxkR8mOnHo1YMQxocJh8EjhYNBxWm2UXtSDMQ2rXcUH+J9dVxdRo9A
         FZuEU9IqMhkOZdafS2iT0+B5PrJCQ/s+Xk/IF3wfN/pFrOPO0hFoVtDyfSSBEI7s0mPr
         hwgkxYYt6EqcDzZs6FNBaXAnRUPf7VHbTQh5VW2crw1rAw1vSfR91XywgGIt6YxqWkXT
         vdofC89Nbw5qnldokxi6QHoKB00ghRzt6ybKAJR/xxkd/bC0oN6x39Zf4wlhkznvTgvL
         4NgoTMvFRTkDzlJahhQQBGvKxXcEkLTCIShHolbEwEW1Qr5akHB2tNbFGCP1HrX1n7cj
         jOiQ==
X-Gm-Message-State: APf1xPDBQHqOENdq8q/4P1rAMXcMr7XisVovlDMUjtDv8GZ6Q9hvp0xm
        IqrAXuwdFpFsK0D1A0KVpogP8JtfltZ9pWyJQfTYSxp7
X-Google-Smtp-Source: AH8x224DlbL3s9mosnVwEU8dtlSzihAUiQ5/EX5hctX88HsEVtw93YriTzXV6nuBlVjnR74G6R+clejaIO9iBtlt7/4=
X-Received: by 10.98.150.14 with SMTP id c14mr12999040pfe.210.1518475297754;
 Mon, 12 Feb 2018 14:41:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.163.48 with HTTP; Mon, 12 Feb 2018 14:41:37 -0800 (PST)
In-Reply-To: <xmqq4lmlsvhr.fsf@gitster-ct.c.googlers.com>
References: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com>
 <xmqq4lmlsvhr.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 12 Feb 2018 23:41:37 +0100
Message-ID: <CAN0heSr5bRx7Lrzu4mfeHx3SuZ75bgpXUA75kM1HJ-h=+8dgPQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] t7006: add tests for how git config paginates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12 February 2018 at 23:17, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> +test_expect_success TTY 'git config respects pager.config when setting'=
 '
>> +     rm -f paginated.out &&
>> +     test_terminal git -c pager.config config foo.bar bar &&
>> +     test -e paginated.out
>> +'
>
> I am debating myself if this test should instead spell out what we
> eventually want from the above test and make it expect_failure, just
> like the next one.

That's a valid point. I was coming at it from the point of view of "the
current behavior is well-defined and non-broken -- we'll soon change it,
but that's more a redefinition, not a bugfix (as with --edit)". But I
could go either way.

There is some prior art in ma/branch-list-paginate, where I handled `git
branch --set-upstream-to` similar to here, cf. d74b541e0b (branch:
respect `pager.branch` in list-mode only, 2017-11-19).

> In addition to setting (which will start ignoring pager in later
> steps), unsetting, replacing of a variable and renaming/removing a
> section in a configuration should not page, I would suspect.  Should
> we test them all?

I actually had several more tests in an early draft, including --unset.
Similarly, testing all the --get-* would be possible but feels like
overkill.  From the implementation, it's "obvious enough" (famous last
words) that there are two classes of arguments, and by testing a few
from each class we should be home free.

This now comes to `git config` after `git tag` and `git branch`, where
the "complexity" of the problem has been steadily increasing. (Off the
top of my head, tag has two modes, branch has three, config has lots.)
That the tests don't get more complex might be bad, or good. But all of
these use the same basic API (DELAY_PAGER_CONFIG) in the same rather
simple way. I actually almost had the feeling that these tests here were
too much, considering that DELAY_PAGER_CONFIG gets tested quite a few
times by now.

Thanks for your comments. I'll ponder this, and see what I come up with.
Maybe a changed approach, or maybe an extended commit message. Any
further input welcome, as always.

Martin
