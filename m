Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D51C4363A
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 18:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4B2207BC
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 18:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgIUSMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 14:12:32 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:45880 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUSMc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 14:12:32 -0400
Received: by mail-ej1-f66.google.com with SMTP id i26so19031138ejb.12
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 11:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFFAYwbCMt3wwaHKSTLeb9apbiA38i6TlUBfb9cNsc0=;
        b=AnPtSdEUiisvmZU2V7RmG1h6cd4roXNMrC/uEiu4TjpIdFQYAmfSHqi6bZTV5zA8l8
         BisILIcBj6MvSH0stTXfF1CmNCszk3y1N26nRFMpF9iLwcRhAZoQRs85Y0r8qQ6CJjyE
         SjqMsoJWhvNwotXhRagM6QPxSR0EUbLsPsN79U1ovWqUqZHNE4JM88n/To0p0IzIATVK
         GGMqEAlrD3xPrmjGgaLQ4MFrO1CxpoTU/BPoxOWuQpSR+FpbkSWUQHSWSjWRmU49gQ4u
         gyLhCiraAZK+pGS0R5N0Uo8AlTPP4A0XZ5TFbwGp9RDiKPx8y8tbvHBm1/DZFWcQbZog
         Dr1A==
X-Gm-Message-State: AOAM530FcHNRbsoHl387Qd8QIa/TVkOEijFfiUoJV5Eyn/6/eDfLXMLN
        FHHnDT/Kb2b966bkn7rQMxKgib2o78y+YAIRnCg=
X-Google-Smtp-Source: ABdhPJzrXv5/GwVcd5mCD4T35jzOv2ozPAQniY9jC4xITiRpK+m3LX66iQzvNQtObM8gx88BsRtwjeM+qK0cSDY1Hds=
X-Received: by 2002:a17:906:454a:: with SMTP id s10mr758218ejq.138.1600711951041;
 Mon, 21 Sep 2020 11:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
 <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
 <CAPig+cQNiB8nw-JwwFweHzeFYcozGA06pPKr=0N9Metp8PBbSQ@mail.gmail.com> <6da3752f-5e45-1381-b54c-64a81d642b72@gmail.com>
In-Reply-To: <6da3752f-5e45-1381-b54c-64a81d642b72@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Sep 2020 14:12:20 -0400
Message-ID: <CAPig+cRdKbBZEan756gpLXBsmZCgwA+XyjUQYOWLDBTTbawGAA@mail.gmail.com>
Subject: Re: [PATCH 3/3] commit: add an option the reword HEAD
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 21, 2020 at 2:05 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 21/09/2020 16:43, Eric Sunshine wrote:
> > Nit: It feels a bit odd (though not outright wrong) to disallow
> > --reword in combination with --amend and --only after the
> > documentation states that --reword is equivalent to using those
> > options.
>
> Yeah I decided to be quite strict, I'm in two minds about the
> documentation, I think it might be better to remove that line.

I rather like that the documentation explains the equivalency between
--reword and `--amend --only --allow-empty` since it makes --reword
less magical and provides the readers with pointers for further study.

> I decided to use the C_LOCALE_OUTPUT prerequisite and test_cmp rather
> than grep so I could check the exact output. [...]

I overlooked C_LOCALE_OUTPUT.
