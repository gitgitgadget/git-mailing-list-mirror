Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD65201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 18:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754689AbdBUSUA (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 13:20:00 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:35263 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbdBUSTy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 13:19:54 -0500
Received: by mail-it0-f50.google.com with SMTP id 203so120483402ith.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 10:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xiaQd1J1Iew9r8FywXmyT6JbyYTDwIfeasl63ttJnkQ=;
        b=j0lc3RdSJLy+5YOYISjtpTypaR6QZ7o7SI2O4TtcLe7Dd4zBaN6mVErYbQPMnBBF3O
         pB3WlBT6KFGnhI2TO0/pNPf0/iI0u90cEqJL2MJjlxBvflhlDgZf6IcQZlXNIp3U/upL
         C7laipAJ840E5zW+n2+veVB/dBfGDGHK18hNHKCHE5pZ/hFPStO3Ua3RXnyORcxtzuab
         DPScS8h4QaXsjnOSWVXVxxLX7NkugW83lXsvXliqNhDMx1DGRGR25XB1f/k2MxX2WQBa
         2sYfnTlkYQSndvezsEGyFSa36FkktJYsVvP0F+6WxpVY38oOLZaUE1hsG0pZ5XLL39yt
         061w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xiaQd1J1Iew9r8FywXmyT6JbyYTDwIfeasl63ttJnkQ=;
        b=pCoBxCNH/9y/bNwP1Nc1f/MO/TgDkJ1UgjX0H6H2S+Jk+KS5i9R4M2d98+0aZD3c6V
         VXrz9kBvy8Vi/ESvo8yc2Qwf6/xXZliA0GDr29ZzYQuST/7EK9+vUSX0AhijnmM1R5Xq
         Rnc0kCPfmBNfiL6hn/0jVjHEobtJfLC1py32aatcajiSYqngDyyg78PDmk26e83XYZSO
         TaLBhvwHlnjKw1JQagWzv8yEXKEpitvNUD1/nxdZDk8Ww8ya/nIofs4SGiw9RPi5zmne
         lmDu06O08nIusyqhmuAY6EaE8nq5zcCmxanHN0UzOF9df0H9ifVvRKlq4ojBgc0/ZzX2
         l/QA==
X-Gm-Message-State: AMke39n57ZW+uPd/n/MBRao5X0lLypaiuQf75xKObPadoGnUrGdQ/7eJ/RyUkhFoJlLganLABWnq5h1EdA04ezL0
X-Received: by 10.36.40.198 with SMTP id h189mr28646130ith.114.1487701178778;
 Tue, 21 Feb 2017 10:19:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 21 Feb 2017 10:19:38 -0800 (PST)
In-Reply-To: <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net>
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
 <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net> <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
 <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net> <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
 <20170221070653.65ho2anbp55uzjeu@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Feb 2017 10:19:38 -0800
Message-ID: <CAGZ79kZgMbEZy7hoA+VxsKdKBavt59SmC1c6FpDdgrW2GKMHvQ@mail.gmail.com>
Subject: Re: url.<base>.insteadOf vs. submodules
To:     Jeff King <peff@peff.net>
Cc:     Toolforger <toolforger@durchholz.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2017 at 11:06 PM, Jeff King <peff@peff.net> wrote:
>
> We'll see if the submodule folks have any ideas on how to implement
> that.
>

So from reading your discussion, the user expectation is to have
`git submodule {init, update --init, sync}`
to pay attention to url.<base>.insteadOf when setting up the
submodule.<name>.URL, such that the modified URL is used for the
initial clone of the submodule (and hence any subsequent usage within
the submodule).

That sounds like a good idea to me.

Two caveates:

* After running `git submodule init`, you change url.<base>.insteadOf
  in the superproject. How do we need to word the documentation to
  have users expecting this change doesn't affect submodules?
  (See above Any vs. "Any except (initialized) submodules")

* So with the point above the insteadOf config only applies to the
  init/sync process, (i.e. once in time, ideally).
  Is that confusing or actually simplifying the submodule workflow?

Thanks,
Stefan
