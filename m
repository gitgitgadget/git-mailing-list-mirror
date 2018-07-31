Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F06041F597
	for <e@80x24.org>; Tue, 31 Jul 2018 10:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbeGaM0P (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 08:26:15 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:40654 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbeGaM0P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 08:26:15 -0400
Received: by mail-yb0-f195.google.com with SMTP id y11-v6so5944578ybm.7
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 03:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0W3UxtssNUrNXNqAuN/cmoDyW+oZT59jdVYj9+W7iWU=;
        b=p2UK6FnOSKJtOLghR0gryc6E2of0IPJsRoS7bo99kOAmwcT409OmI0K6+9fqv+ea/r
         2VcMQQmx2Me9OiDIYfdPVbI33nHlVpfxT5vQ+/MjNpGq6kBunEkX5su/4KqJNOm7ZW2l
         ClB0EUFhhUBX5mS35QNdIATDEz03o9neV3wRBbAPbJrBrn8dVX6s06eAHM89DVhmFPzv
         xyvSik29tWmsXHJl0HkjDJOcRwTeGdvB8j87gNXDoUGhehHRWEvnBmXhw7O7jr2hCMZb
         KpA2S5AFJS7PgJ43aOb9upkrmyQWLJ7QqSeaQTxjk3MAEhA4aiH/acdIYdW1nCW1oWUV
         fM5w==
X-Gm-Message-State: AOUpUlHeQUodOKYEpxe5dF2OPRIrnIoa00DNuHdWwsw9fyUgn6zaQL5e
        ds0eBZMKGP7e1pZ8Qybe95+2xr9NHEF6XwtL4d4=
X-Google-Smtp-Source: AAOMgpdHZjFhG3dDiJclNnrvtkamVEi6AyvwFXANbSTeqxXlW/JinUikhEzip7mSEg6xc2i4jpB3GNJ7mTnfNb8znas=
X-Received: by 2002:a25:8b04:: with SMTP id i4-v6mr11088355ybl.12.1533033991929;
 Tue, 31 Jul 2018 03:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com> <f9a7e77d-3c67-082e-ed8d-701f4d0d1759@talktalk.net>
In-Reply-To: <f9a7e77d-3c67-082e-ed8d-701f4d0d1759@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Jul 2018 06:46:20 -0400
Message-ID: <CAPig+cRkdAoV7gsEeKMcvhckifRxU32+ec2zxY7MgNGmJp5Sug@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fix "rebase -i --root" corrupting root commit
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@idaemons.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 6:06 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 31/07/18 08:33, Eric Sunshine wrote:
> > Patch 2/4 of this series conflicts with Akinori MUSHA's
> > 'am/sequencer-author-script-fix' which takes a stab at fixing one of the
> > four (or so) bugs fixed by this series (namely, adding a missing closing
> > quote to GIT_AUTHOR_DATE in "rebase-merge/author-script"). That patch
> > probably ought to be dropped (without prejudice) in favor of this series
> > for the following reasons:
> > [...]
> > The test added by Akinori MUSHA's patch may still have value, and it may
> > make sense to re-submit it, however, doing so need not hold up this
> > (higher priority) series.
>
> Yes I think it does, also the patch that Johannes and I have on top of
> it to fix the quoting of "'" in write_author_script() relies on fixing
> the missing trailing quote and handling of "'" at the same time,
> hopefully we can get that rebased on top of these asap.

I'm not sure if "Yes I think it does" means that Akinori's test has
value or if it means that this series should be held back waiting for
other changes built atop it.

Anyhow, thanks for reading over the series. I appreciate it even if
our "sense of priority" doesn't always align (as evidenced by your
review comments and my responses).
