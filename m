Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 803D120374
	for <e@80x24.org>; Mon, 15 Apr 2019 10:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfDOKjn (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 06:39:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37982 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfDOKjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 06:39:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id d13so14231670edr.5
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 03:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PeuzKuq2df921+0dOZ7XduRNwbPfciuw7UUnVGK+BPY=;
        b=P2K5QydwhUgreqbD9fHHpIeotq2cYWZhlxiYzR2fqTiDk0mA0B5tVmDrJSI5B7ShW6
         Zr7KN6ynHBdabiKTLS4Vkhv/RSOhDY7FZiM5DNUU+8q8CUTia4MMX4kOXAv5iEuDKCv2
         mAU+RKXpY4L+CfQTCHl8/viazkUPLpTkkbqw7xvzwUdJAbzpg1Kl5di8XryyPzp6HEof
         jMDnaY83hwYR9praRjDGijGNPtnD9weQEVxAeR7uLwunCmn4J/IV2FjVLtiFmkSJvJe5
         q20k5wUs/Jb1tRowCDB46Ilm38BR1ipgC4B11hejI53YnNI9YQoiKiUD5xsXfNkzWFQz
         0x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PeuzKuq2df921+0dOZ7XduRNwbPfciuw7UUnVGK+BPY=;
        b=Q7O6AHDd6veieBXeXxCDU3lWuD2w1o8rgmYWlko1xBfJ7EJ75f7+x+c2dtiXdLD5P2
         gkXVoI4DoBcHtS8e6Jm1CS4W3U+gazDId+AO5Vj/lYv6+X8KZyZWkB3664fF+lmrzsgn
         PAyW1m6pSn8FjQ61vClZD5N/4o0Md73X2wxLN5h+r7MT2o6DW7FYl383WEDNOiRY8d11
         QeLoQsJ2bXhwIkYnZuLEn0O4rRgexHdLOTNoiP7+8Blm0uGq+3hb8iZFEosJipCF5jjf
         d+FdapO9xFs5fPXQw2ezBGF+IHMYitxs9AFGBTDL+vps1rTB0pryCs8msFw6iy2/p9Wn
         VSWQ==
X-Gm-Message-State: APjAAAVC5szKZAYjeSWZNfXTibjOvcfmgNUs7a2UXkuKoGVSWqgbUxZa
        9Gw/micAAJst/nHIjqArBs6ioS9UHzvDoBULa8g=
X-Google-Smtp-Source: APXvYqzX979NpA8dC2r/Vm4y8rK50Hhads+Elkffk7zcokuO1Fxt0iavshcF3bwZpYC3yoEFb6fhynKb0SoiWVMCRAE=
X-Received: by 2002:a17:906:4aca:: with SMTP id u10mr38882341ejt.227.1555324781237;
 Mon, 15 Apr 2019 03:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
 <xmqqmukrr52m.fsf@gitster-ct.c.googlers.com> <xmqqimvfr25d.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimvfr25d.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 15 Apr 2019 12:39:29 +0200
Message-ID: <CAP8UFD3nusWgF=MoaqF6-VdVZa0EJJg4E=Nxoc4Ra_SZ1nvDkw@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] Many promisor remotes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 15, 2019 at 12:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> >> This patch series is based on:
> >>
> >> 763fb763b8 (Merge branch 'jt/batch-fetch-blobs-in-diff' into jch, 2019-04-08)
> >>
> >> to avoid issues with jt/batch-fetch-blobs-in-diff.
> > ...
> > If you really need to depend on another topic or two, please base
> > your work on a merge between 'master' (or some well known ancestor
> > of it) and the tips of the topics instead.
>
> Well, I've done this myself by first queuing these on 763fb763b8 and
> then made a merge between jt/batch-fetch-blobs-in-diff and master
> and applied these pathes on top of the result.  You should be able
> to see the resulting topic replacing the old one in 'pu' in todays
> pushout.

Thanks, I will take a look.

> Now I can lose the semantic conflict resolution the rebuilding
> machinery was keeping, which makes things a bit simpler ;-)

Yeah, nice!
