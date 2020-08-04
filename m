Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324FCC433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 04:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD0D206F6
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 04:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgHDEog convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 4 Aug 2020 00:44:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51500 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgHDEof (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 00:44:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id p14so1419192wmg.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 21:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tt+4k34IQ4yzPy5fqC4Qb+dQ8HochDtXgmwEwBnbpmg=;
        b=ETgOxwcK4qI2tj6fl5nQxbvllkXgzldOqBzqlMNXE9gCoqICGQA10vk71iPcUqj7Op
         qZ5paYguVl0OhVAkAzChzYUIcnl/isnMSCXPL8MpP3Bn9yNH0MxQwSHK8pDV1rbdTOAj
         wDyus6Cg6r3jfTPFPUXkvrT3fWrgHD/CAr3DCdSZ7yQWbVjlcTCi/DJfeTukO5FpyzYp
         ao9rKxQxl+MjsvwikU1BidgNEGnnoMjeaVuCW1cyG9DOJFka8IvOJ9bVlYGKJDdwJ0MY
         vknPiHQyDff19vN35Pe7RP1peyUgB3avYGwyvOs3gexP6GZkzfU/9r4++DifXpy1SIm5
         ecpw==
X-Gm-Message-State: AOAM5308enMoNr+K10oHouLMJdmfPV11Nvep8RvsbR7dbB5rduh6StBt
        Wsw2YzGA8XoADPx8Gnxm6hWjXlI6aFb1gBJOqxMPwq1W
X-Google-Smtp-Source: ABdhPJyzfnR0iyt/X4c9PWrmj0B5xq7lNjmz+c6+6ba4oVEfPie0DlkXNwq/WUgMCRCIiNH1qoHV5gxO6O+wtLU6zGY=
X-Received: by 2002:a1c:7405:: with SMTP id p5mr2100921wmc.130.1596516273966;
 Mon, 03 Aug 2020 21:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200803053612.50095-1-sunshine@sunshineco.com>
 <20200804005535.5126-1-sunshine@sunshineco.com> <CAN0heSpO4ocUTv2BSAOkRsuEX59V7phKn1=Y-PU2qq0POhp1Rg@mail.gmail.com>
In-Reply-To: <CAN0heSpO4ocUTv2BSAOkRsuEX59V7phKn1=Y-PU2qq0POhp1Rg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 4 Aug 2020 00:44:23 -0400
Message-ID: <CAPig+cS2jsmYkpf5+Kob2w09UKQgBvM5wjOV-bS-fVOK5KGhyA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] git-worktree documentation cleanups
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 4, 2020 at 12:29 AM Martin Ågren <martin.agren@gmail.com> wrote:
> On Tue, 4 Aug 2020 at 02:56, Eric Sunshine <sunshine@sunshineco.com> wrote:
> >   git-wortkree.txt: link to man pages when citing other Git commands
>
> s/wortkree/worktree/ in the subject of the final, new patch.

Thanks. Perhaps Junio can tweak that when queuing, otherwise I'll fix
it if I re-roll, otherwise it's minor enough that I won't worry about
it if it makes it into permanent history.

> I agree with all changes since v1, except ...
>
> > -By default, the repository "config" file is shared across all working
> > +By default, the repository `config` file is shared across all working
>
> I don't think this is a filename (in which case it would have been
> `.gitconfig?) but rather some sort of colloquial short form for
> 'configuration file', thus '"config" file'. So I could see the double
> quotes remain or being dropped, but I was surprised to see them
> converted like this.

I also thought at first that it was just shorthand for "configuration
file", but then I realized that it's talking about the `.git/config`
file, in which case it is an actual filename. So, I believe that
quoting it with backticks is correct here.
