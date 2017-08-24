Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98FEA208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 09:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbdHXJA3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 05:00:29 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34537 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbdHXJA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 05:00:28 -0400
Received: by mail-oi0-f45.google.com with SMTP id 187so61584oig.1
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 02:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WQ+BrL2V00XY8klGO6zmHINyVawz3kAL2qQVorWkeCw=;
        b=Ejnqr2Lh/n9/Qkwq9qP5oh8G+6EhyG/uuvpVmG7YcezfYTypr8ToSj4PloveJUlRN9
         f6EITODoAx5w7rPd5XYDwRQ4rQP0WUNMAQ6lb9BNXoyzkfPGDMhUVkOi4w1I5zSrnleV
         px2cMEm3a4Q7HxkcC6CNjqT1/4WEOO2cjNr4zNyvlUzblaF47mT3cSsIqu9h6tqheoLd
         0vGVnRix0Hkoce3f6JEwLz9L1M+VVvPdx6lBeRV1Arw6mJMU4BI5TDURT9UUgTlopL0f
         WdsmzWE7Ezp0hD7ll7d+FvezNQwc5MmrkW7Elgz8zNkov4Yw2093xm4cCueA75PaYH0k
         JZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WQ+BrL2V00XY8klGO6zmHINyVawz3kAL2qQVorWkeCw=;
        b=IjrlkoVXSSTUadI2RKClJEZbKZw2/uY2I3RWNDC5hu0SyGPi8kmO0C7hCLXuYtUJOM
         6E0w//pUUGEd8CqNlWdDlSv48lX4AnMoBSmb2oJsP3cCySLhn6xU7MJr6PkBDYBSGLhb
         58EKvkMmIAXcWFFCLLRVtLfxCs2XPw6443tUJW0CnR3LhtzmiSbvKSApWK5MoYuLn29R
         61r9IMMm7ejdSpGtX3FKL/agQcPknzE5zJ+FzY4zirstinI96xOewmdeELnU5WDIRZ8H
         xD0x8ZmYP07rdDmIffjNKfHsnHO+Wbrp4YJfD+AWTq7YySwR7b83GIAOEar9Y/EhFTrr
         Vk0A==
X-Gm-Message-State: AHYfb5iV5oAVbsn2AKB72RPQEztfxAqU4izeyb5UiUa8yOS/ajp7ZGhY
        AdfjHRd4e52EICxaR0WLJBls7bpoSw==
X-Received: by 10.202.208.202 with SMTP id j71mr7226063oiy.276.1503565228167;
 Thu, 24 Aug 2017 02:00:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.176.69 with HTTP; Thu, 24 Aug 2017 01:59:57 -0700 (PDT)
In-Reply-To: <20170823201334.bz42s6t5ti4jdaqm@pitfall>
References: <20170823201334.bz42s6t5ti4jdaqm@pitfall>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 24 Aug 2017 15:59:57 +0700
Message-ID: <CACsJy8C=D_MHRJHdbqjZHBvr-Xs_VXxzRU_KenpWrvX1Nb_iyw@mail.gmail.com>
Subject: Re: Undocumented change in `git branch -M` behavior
To:     Nish Aravamudan <nish.aravamudan@canonical.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 3:13 AM, Nish Aravamudan
<nish.aravamudan@canonical.com> wrote:
> Hello,
>
> Hopefully, I've got this right -- I noticed a change in behavior in git
> with Ubuntu 17.10, which recently got 2.14.1. Specifically, that when in
> an orphaned branch, -M ends up moving HEAD to the new branch name,
> clobbering the working tree.

Thanks for the report. I think I see what's going on. I need some more
time to come up with a patch but yes this is definitely a bug (and
caused by my commit)
-- 
Duy
