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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E0AD1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 05:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfIDFoz (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 01:44:55 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:45411 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfIDFoz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 01:44:55 -0400
Received: by mail-lj1-f173.google.com with SMTP id l1so18326479lji.12
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 22:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i89ZpZCqA5PqtUYqydgBCjxFE0Xmwx/moHuVIB66y2g=;
        b=EiST12akRKgHJydmNDRYNtYjbX7036ONivf8Zp/fJCV0xhnbeXHk39peOUf7RhphCc
         BMalQ4x6NwaBTmS/b1hKHEOesGLkIYMGPJYrrLZiJdXCVJKiMPWblpnxyAqQnXt05tiQ
         cPv4UF8KQBe7nK2rR99x1qlYEQG5bSmf/ow0jIMslLtkHXdiR2SFo4Zls2Yk1BUVvWvG
         dXgPbRTcNcrMy1pomKjZKvOBo/mwyb5TIlISZsum/u/ArvgwXJ/ndMLouvqt+2HnshjU
         5KTjD8LtoQgPP7TIL33gpc8p65fiNbuWAqoI4xMC1dTS4pZ8LKXmrkYNPB6uVi1k2o8l
         ZpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i89ZpZCqA5PqtUYqydgBCjxFE0Xmwx/moHuVIB66y2g=;
        b=YWA7gAHps9WCdviqrtUZlJbOB5mOyEeH/lPdTtYX7X8H/ouN/kco0XYpAZ6YgRwsRd
         0LaM8Ww/ENt0Rh72x4dTaDU4hW/M7cGETrpJVgChpqSxnEWeOM0cWbXbvZItzgMCqeLP
         ijjz8JXKbS9fsOoaut14JDXO0CN/4fHL0eRa5Gyj6nb4ZYD7Xw1ldSqdZjuAUSJ3bE8s
         hOEmcH8qYDAbxoYEs0tPb75Qba1TJm8/NcHYXrfZSuO8kOxtXoPaQzVpwt8PsmTnZQNq
         5SIxPmkHEzjRB7c6BI26Hhhuix93HMncz7gvDp+y1pb27o8JalZ80/xX9jMrHU0IY1tU
         pDPQ==
X-Gm-Message-State: APjAAAXPJVFxyoLlwuFTRvvCicLb6bS58d9wqLKdX6mJvRbEwj+u1OoG
        0AGfUTuMQSSHo+o/fc1kEJH9pwfkKY8EDAS+9tO1GqD+3GQ=
X-Google-Smtp-Source: APXvYqxy255L2yQify1zqgrWbodXKLPtCJsg8tOPwpQic2JHFrCBbXogFkGioi8YNLQS0xTjjoEnGn4Mge40WfutcHc=
X-Received: by 2002:a05:651c:1023:: with SMTP id w3mr20827497ljm.94.1567575892942;
 Tue, 03 Sep 2019 22:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
 <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com>
 <CAGr--=+CEX-STDgT_ZwaA=n9UHSrsgcWnxCMY=9tGDA=9XLkew@mail.gmail.com>
 <20190902181213.7jqvoyctdm26g34z@yadavpratyush.com> <CAGr--=JgqjC8FskqVFJTqAnQ5aq8J4z-Wje8s22VwBgVtkBF-Q@mail.gmail.com>
 <20190902184405.bfb5572iia2v2uwi@yadavpratyush.com> <20190902185819.fzf3lop6riiq6zja@yadavpratyush.com>
In-Reply-To: <20190902185819.fzf3lop6riiq6zja@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Wed, 4 Sep 2019 07:42:28 +0200
Message-ID: <CAGr--=+UA04F8JtpN3b8SahYtVkYgR45j_xeb3759DrtQOY6rg@mail.gmail.com>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar appears
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,


Just wanted to chime in on this one:

On Mon, Sep 2, 2019 at 8:58 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> On second thought, wouldn't it make more sense to expand the commit
> message buffer instead? The point of resizing that pane is to see more
> of the commit message. So it makes more sense to make the commit message
> buffer take up all the vertical space, rather than making the scrollbar
> move.

I also think it makes sense to expand the commit message buffer. And
how about automatic word wrapping? Should the user really have to care
about the 72 character limit, while typing the commit message? I'm not
sure what solution would be best.


Birger
