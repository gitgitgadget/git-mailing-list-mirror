Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D7041F45F
	for <e@80x24.org>; Mon,  6 May 2019 22:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfEFWZf convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 6 May 2019 18:25:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50347 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFWZf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 18:25:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id p21so17731952wmc.0
        for <git@vger.kernel.org>; Mon, 06 May 2019 15:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VijAtcm0KV7AR5WoD2e8VSNyVts/cN907+aqGTMT04s=;
        b=emdN9EROU19dpWuVQ09N0MYdtpqmpKih15M+70WXOE50udqKfZRUo+b8XHuhtzgchK
         vxtU3iAryrNP7SO+T+pKVsv+fSY033sSFAh97jlcbngRCajH9UEYv5ezL+t+6wo/nf9E
         wp1f9F8/XRtGMVA7c4IIqoUt9A5eo1tH2+HYMgTgRImbzABNxKacd94IbMIhAomMPxCo
         ngZhjEvGDN8I31Gok5q9U04PujMbTIwgpmgvzm8ZUa6+GtsPwH48RPropGS9qxVvjgpN
         p4bUZWRSCG02wU07ksmTyu7EZBnY8VgKe38KdRl5G2OU6/Xaa4RpSthCa1eoKRrnmFPI
         TqzQ==
X-Gm-Message-State: APjAAAVNbdiYY2VirIR2uF5CIl5joMDd9o9TDeDHDW0qxmFxVgIsdss1
        V3pqC4RS6/R+qHvZTIHiRBoE1BvEtFUKy2vGywOOlzNT
X-Google-Smtp-Source: APXvYqyH1H4GH46sQUzdL64dmYSKUZF85dr4y45Om+a4yKZ50+ZdkCd7srGIIrMyn1ilNZme09/Qu1C6FyjatYgNfYI=
X-Received: by 2002:a1c:cb85:: with SMTP id b127mr19252364wmg.76.1557181533058;
 Mon, 06 May 2019 15:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <1556895855.30374.0@yandex.ru> <20190506203003.GA85211@google.com>
In-Reply-To: <20190506203003.GA85211@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 6 May 2019 18:25:22 -0400
Message-ID: <CAPig+cTC8aGkM3ksG9cEapz33-FcjsvoO9ejeJzjmkyXHjvoJQ@mail.gmail.com>
Subject: Re: [RFE] Allow for "interactive"-like actions in non-interactive rebase
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Konstantin Kharlamov <hi-angel@yandex.ru>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 6, 2019 at 4:30 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> On Fri, May 03, 2019 at 06:04:15PM +0300, Konstantin Kharlamov wrote:
> > Interactive rebase (i.e. for example "git rebase -i HEAD~10") is used most
> > often to apply an action to a single commit, e.g. "rename", "edit", "fixup",
> > etc…
> >
> > Instead, it would be nice to have native support in git to start "rebase"
> > for a given commit, and pass the "interactive action" to use on that commit.
> >
> > $ git rebase -i HEAD~10 --action edit
> > $ git rebase -i HEAD~10 --action rename
> > $ git rebase -i HEAD~10 --action fixup
>
> I would totally use this. The equivalent workflow right now is a pretty
> large number of steps for, say, fixing a typo.

Isn't this pretty much what Phil Hord's RFC patch series[1] was about?
However, Junio outlined[2] a generalization of that approach providing
more flexibility and control.

[1]: https://public-inbox.org/git/20190422000712.13584-1-phil.hord@gmail.com/
[2]: https://public-inbox.org/git/xmqqk1fm9712.fsf@gitster-ct.c.googlers.com/
