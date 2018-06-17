Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4281F403
	for <e@80x24.org>; Sun, 17 Jun 2018 03:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754922AbeFQDlt (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 23:41:49 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:38599 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754589AbeFQDlt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 23:41:49 -0400
Received: by mail-yb0-f196.google.com with SMTP id q62-v6so4861988ybg.5
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 20:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aU66sxMtxrU2qjb2b7O1sKifPvjSQp3ZKeQ3qX5VVV8=;
        b=DB+gUGrW6yjlcTwxP2wOfoNyXtkWjd6DwU7s1V7HIxug/IULbXFSih6Rp7rzLTTXUi
         E9qL27/iEWCkRi/JckyWb23emKWE7XvZhv5MDKLrWK6RChM3fzNXKTxquNLZZ0efS3IO
         suivzmEEU2cfb1XhM8p2gedL+/U3rY9HhsUQkquS62TW5VonFmS/VNBH5VfVSC4o/1gu
         oLUNRVva/MqnKAJ6zPymsFOX8EEXl9Sz5H6lQRpiYlmYqn273st7qFMHbWy7pnlPJcGd
         PJtIY7oQ4XNEcpOMJBmU8KA/qZmr64BmobS1+WuYdA+LUM8JilhHjCXw1lix4ERtVYOk
         W0nw==
X-Gm-Message-State: APt69E3hNhyWSwkkm5lDv3Q0wSii23qOll2DIbJvS2Dmck+OBAXyH8aW
        k6z/AcxHW65iWQRhM7dqU7VFGZ6muPJIqc1kPGw=
X-Google-Smtp-Source: ADUXVKLH2DEACNVEiK0KRHh+e55b1xowr3iwlJRpRFDmNyFRtSFEmxmBVqc9P0JHvvYRC6k3NMisCddPlwuF9yRUBXU=
X-Received: by 2002:a25:a268:: with SMTP id b95-v6mr3879403ybi.295.1529206908422;
 Sat, 16 Jun 2018 20:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
 <CAP8UFD2SJF_gbP-mdXoAH0t_OmLjRbPuVK5vZZjgs2N9eJz5KQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2SJF_gbP-mdXoAH0t_OmLjRbPuVK5vZZjgs2N9eJz5KQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 16 Jun 2018 23:41:38 -0400
Message-ID: <CAPig+cRR8=vbafsjL_pnoq6ssxBkkoVo0OMd_i8P_a8ze7eLHg@mail.gmail.com>
Subject: Re: Is NO_ICONV misnamed or is it broken?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Mahmoud Al-Qudsi <mqudsi@neosmart.net>,
        Git List <git@vger.kernel.org>, ferdy@gentoo.org,
        Joachim Schmitz <jojo@schmitz-digital.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 16, 2018 at 10:57 PM Christian Couder
<christian.couder@gmail.com> wrote:
> On Fri, Jun 15, 2018 at 12:47 AM, Mahmoud Al-Qudsi <mqudsi@neosmart.net> wrote:
> > ~> make NO_ICONV=1
> > # ommitted
> >     LINK git-credential-store
> > /usr/bin/ld: cannot find -liconv
> I think 597c9cc540 (Flatten tools/ directory to make build procedure
> simpler., 2005-09-07) which introduces NEEDS_LIBICONV is even older
> than the commit that introduced NO_ICONV (see above), so you might
> want to play with NEEDS_LIBICONV too and see if it works better for
> you.
>
> I CC'ed the people involved in related commits. Maybe they can give
> you a better answer. It might also help if you could tell us on which
> OS/Platform and perhaps for which purpose you want to compile Git.

For completeness, for those reading this thread, a patch fixing this
issue has already been sent[1] to the list.

[1]: https://public-inbox.org/git/20180615022503.34111-1-sunshine@sunshineco.com/
