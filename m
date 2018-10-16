Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C241F453
	for <e@80x24.org>; Tue, 16 Oct 2018 15:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeJPWv0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 18:51:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39579 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJPWv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 18:51:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id y81-v6so18304286oia.6
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sf1c/DlJ26ZXcJVFvRraP8vMt1Zp7CLyEeb6yio9AZQ=;
        b=B97YY1RpoduHArV8f+NdZP/Q1BBw/sVSoHzYiRbzBJk6uJ2Ub6LM7UxflACAluyBs8
         oCisci4qVvW3ppAne09dTOCH8BGN/SMK8Xaef/5IAL/e6FJpN4ND1OR2j1ISb+9pC+0j
         5YLwG9BpyJt0T+TjsVp0aLM8xTIXPL3gL+whteEWTDTOeElng03IO5UffN1fbUSHbq7A
         w4npi6MftBbkY2L2IdZuzEaaaYvETesvt08kcEHYiivxtIKFUDbfVRjrBqDhpa92LYPU
         cdoJly7vb+WQ4N4f0/E2LsQRoxaQenU8uTpFO1aqiGJWFuIefN/LerAmWnCqafQ3tqXf
         1GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sf1c/DlJ26ZXcJVFvRraP8vMt1Zp7CLyEeb6yio9AZQ=;
        b=VT7k2PaWwoIGoegstdUQagOj8xSqyVfJBO2RYma2WCFQaH3a77DN0NP045CekW/SWz
         4nJ3/RU04ARxJDY8zu2HX/Coxd+aiVYFzLsp6fAQa4FcXiLddEGXQG4X6RL9tKBBDMI3
         niyWcUmY/xUkYLyRxttzCNdcjteJBiAf7g0SmqQAEaORQgE27Rq/enIN1fn8tpOo5TMB
         8hhcXqz8h+oZWGav4pArh0ka+f7JSE9QpivT4qtsoRsvY5dngR+70nTHLPRo0q1DQQgR
         eJAWonP9Lm8YzHUbO1wBvij6MhUoXlWQMfkY6Pp0J84E/SEaIfdphZJZi07lCRXU6xOd
         lLQw==
X-Gm-Message-State: ABuFfojNZWh0og4nlt3p5nexVBd/gU9PVO69PMTgxddha+F8W11ujB1z
        K8zawwQ7mLjvishd6IMTLPccA8JJ62gy11zqXXpWtFnpwA==
X-Google-Smtp-Source: ACcGV60C07WxDrk1VkwzuUL+lPZkB8ReAgP1kAtYX5byRFrq6v1GXTXV7Kn/SsxYvstxA4scK4mFl/jhfSnxvqAn+4A=
X-Received: by 2002:aca:3341:: with SMTP id z62-v6mr11276941oiz.347.1539702034558;
 Tue, 16 Oct 2018 08:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1539373969.git.matvore@google.com>
 <xmqqd0sc6ilk.fsf@gitster-ct.c.googlers.com> <xmqqr2gr6fjy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2gr6fjy.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Tue, 16 Oct 2018 08:00:21 -0700
Message-ID: <CAMfpvhK4a15gd-PT3W+4YJmpe6c7HyhJE5N_UqOzu8gsYYej4A@mail.gmail.com>
Subject: Re: [PATCH v12 0/8] filter: support for excluding all trees and blobs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 14, 2018 at 8:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Matthew DeVore <matvore@google.com> writes:
> >
> >> Here is a re-roll-up since I haven't received any additional corrections for
> >> almost a week.
> >
> > Sorry, but doesn't this topic already sit in 'next'?  If so, please make
> > these small clean-ups as incremental patches.
>
> Here is what I'd queue for now, with forged s-o-by from you ;-).
>

Yes, this is fine, thank you! I've reapplied the patch in my own repo
on top of "next" in case I need to fix it and re-send, but please
queue what you have as-is.
