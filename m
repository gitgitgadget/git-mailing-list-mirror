Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3ED1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 15:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfICPgA (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 11:36:00 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:36413 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfICPgA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 11:36:00 -0400
Received: by mail-io1-f41.google.com with SMTP id b136so12783327iof.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbvKP1xj0LSoRh6JJhSgR8uQlM2ffX8c28PqUMCV43Y=;
        b=fonM7Sv02jNEpLgi/NwK2YcoZjirjmVBNvBXDwtqNaPLMYy4ssVEoxONESv46fplf+
         uxPSV1hgwk+gtawufH6xUMBEjgrYpvPdH+jH8k2g2j3HRcUfZFciMALkdxvUl16kQnpi
         fQafCa2to3dYgKH2U9b3ElG/yCuXYw0zjwh1xGN1TECvBUkbfvz7X4V+hBJyNyK4YxJE
         DbSt5RUfNegO2y6ZuZmiOL8RqzKs6mSZbtr6Tkac0fm0sebbm1eHpxSRcTiF0kQRNL4v
         L1msJj3YulLtHNF2otIMRRW7lbArheP44lpHQv17IRt9rgNo0zmMl8EchPFS0rgq2yXZ
         q23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbvKP1xj0LSoRh6JJhSgR8uQlM2ffX8c28PqUMCV43Y=;
        b=FPo67RO6bKis6Y9D1C4JTO9g3x8WpmuM8H4q0Nwp+XD+s8y686mnSLOC+9tGhfAX+e
         4mDnwxz4i8vXO9vx7mnqB4sIsGVQy1cI9xZpt2+wnSc3mzhGwO+IjCw0pb0st3h4+alO
         gZkUJivLSNgWThVOruG+TMmjnP7QBYu9XTQllMK5D+TpqmvoGsJwXa+KNtrAD7p4UVsN
         9ktBYD4Q9KlYToEMcAPTMpAMyWLvzcw7Lg0TsnvgzUB+kkpUVBLXzSa/rtL5otarf9z0
         6nz7dgPD2RcEC8iDxdRTmHPopnYE6wpMpbVhxvFNhLgsmbMCZZsoF7ZcBrEa9kjf1AXD
         eqLA==
X-Gm-Message-State: APjAAAWUNFpvVhD30+wS3XukoF6aGvrlcBYA1XO/4gj8czY6AlTZObD7
        fjq0rcL12ygBgWKIPTeSKG1i/1oxFZjiKwguQO4=
X-Google-Smtp-Source: APXvYqxwyGb5aZNmGdylZfd3Lr41xpA8VZhDwDUNzVrez3MZ2I0EkWCFi8hMfSna7uo6fu3oE57L2I84J7Ai/rN/8Ro=
X-Received: by 2002:a5e:960a:: with SMTP id a10mr115293ioq.298.1567524959461;
 Tue, 03 Sep 2019 08:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
 <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
 <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
 <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
 <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com> <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com>
In-Reply-To: <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com>
From:   David <bouncingcats@gmail.com>
Date:   Wed, 4 Sep 2019 01:35:47 +1000
Message-ID: <CAMPXz=r7hLn+aOp6B9arGMT2jxOTTpOvc0e5gm3=ttDqWNfmDA@mail.gmail.com>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 3 Sep 2019 at 22:45, Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Can you try doing a Shift+Tab? For me on Linux, if I hit Shift+Tab, it
> immediately takes me to the "Amend last commit" option. Then I can press
> space to select it and Tab again to get back to the commit message.

Hi Pratyush Yadav,

Yes, we know it can be done this way. The point being made is not
"this cannot be changed with the keyboard". We know that you can
fool around with the tab key and the shift key and the spacebar and
eventually you can succeed in changing this option.

And if you want to toggle it back again, you have to do a slightly
different keyboard dance, depending on where your cursor or
highlight is currently positioned.

Rather what we (at least I) am hoping to communicate is that after you
have done this many thousands of times, and you can do everything
else in git-gui very fast without touching the mouse, you might also join
us in wishing for action to be achievable with one hotkey-combination
event that does not affect any other state, it just toggles new/amend
commit, and is not a sequence of several multi-key actions which must
be adapted according to the current status of other input mode actions.
