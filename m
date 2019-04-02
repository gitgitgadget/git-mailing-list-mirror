Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1436F20248
	for <e@80x24.org>; Tue,  2 Apr 2019 05:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDBFu5 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 2 Apr 2019 01:50:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35191 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDBFu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 01:50:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so2026485wmd.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 22:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2fxnrmPU/+KbiLAW0cEGFUfaEo5jsPNcBvpQzCQNO2Y=;
        b=pX2QOK6hy5VAEWtR2FmGEhfrQ08MagRMKQfTfsrgLXg2d++6wmzxZfmOgSVMZt/go0
         MMpf2/0N3JO1NV0paCpa2yWOWZB0+boZwuC7fqlL+YFBdzTJdZ5neebQgXd9C/FewMH3
         e0WduqjNHDEmt7Nrk01wQEgz1KE2fRqz1mrwmAZQjTQ6mxGCvmMLEKId4qh6B22LX5u0
         x7PCL3CPsfNKwHovFjLJrbemvJNG1V5rg5QPGuacDn74XXRxhA6lKeN5lEHgSRIfiyvX
         Z9OxWa3xZ9UYEVpPK25Kr2gpw4YC16x5KhZHiJHZVsccMpF8/1ZX5hLeudiSOB5Aq/SV
         zXQg==
X-Gm-Message-State: APjAAAVpyydzNsmLOLZTclLbipHMjXlwlaJiagcUKebk11R8co8HpJej
        Qwo/uvqbS1HJ3UsCS80+4kXE6wrHiutFsXlTgaBIug==
X-Google-Smtp-Source: APXvYqwQFkzigc84y/dJejtw3wvB5bckYGUZHy5AUArm9kpPwwEqXLNGvFDlurUl+8FIOSFm/G+AaDhIW7A8QtP0wn8=
X-Received: by 2002:a7b:c769:: with SMTP id x9mr2181942wmk.103.1554184255207;
 Mon, 01 Apr 2019 22:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190325103844.26749-1-szeder.dev@gmail.com> <20190401115217.3423-1-szeder.dev@gmail.com>
 <20190401115217.3423-3-szeder.dev@gmail.com> <CAPig+cRMBmfG1YDeP9t9eLZdqMqthfxp6nviQYGr7qNEA2U54Q@mail.gmail.com>
In-Reply-To: <CAPig+cRMBmfG1YDeP9t9eLZdqMqthfxp6nviQYGr7qNEA2U54Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 2 Apr 2019 01:50:43 -0400
Message-ID: <CAPig+cTOOthnjweyRjJuLy6o2TffPwTPJmQ_5tJoP1jhdKyD6g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] progress: assemble percentage and counters in a
 strbuf before printing
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 2, 2019 at 1:45 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Apr 1, 2019 at 7:52 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > +       if (show_update) {
> >                 [...]
> >                 progress_update = 0;
> > -               return;
> >         }
>
> Removal of these two 'returns' is unrelated to the change made by this
> patch and should have been done by 1/4.
>
> >         return;
>
> Likewise, this final 'return' doesn't need to be here and should go away in 1/4.

I forgot to mention that these are micro-nits, not necessarily worth a re-roll.
