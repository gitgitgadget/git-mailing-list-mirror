Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2FFF1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 15:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeHUTL6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 15:11:58 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37582 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbeHUTL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 15:11:58 -0400
Received: by mail-io0-f194.google.com with SMTP id v14-v6so6714852iob.4
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xahukij9lVw9Y7mPQ8o3dOp2SF2i6r5YQGtFwaq28U=;
        b=RBwWaUShPdSYDBLmBBOZqVdhgMrui3Pjcm4MuNMDTeKCLAOYDHaYh3EOax6syCjPeR
         ikrSlpcoJESn8y9vuJuB73O6LSVAYuXES8jLZdG0bNAyB4UT9dUAi16AB5GPLXSb6XVg
         yw2GawQnj35YsDcvKYQkYFeCJM2sV9rCUUxyEU1xQfsQ2yCZaJgFv7meZUTfX1LevtyF
         AfA7Nz05Os5eDn7xVQ0VOUWiCVLKOKM9vXORiLD0lK28zOsYHsJoMPnkU60wIGKvpSIX
         HXPWu8e5WwY9bE/cYjH/uCB+Eu8D0s1ElqMF0OV6Wvh93KNVoPEHWh7ewcw39dJGdSvU
         +cJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xahukij9lVw9Y7mPQ8o3dOp2SF2i6r5YQGtFwaq28U=;
        b=BCmOUA6QE7Pn+HyeaYkbgskfKuTi3kzQQqtaoCvVGzT4QPQiHxGRTL9CtHRyTy6Qsc
         lO3RveAQNBEUyPQ6fyzHRoq87r2LwTInLq8Iz0YhlQeHa8pTiBKcxAuIHyNWmCYNaCg9
         iL6eStHrU1KIOzd/LC9/gsHc7Ot+V6mK9MnJCa9YDUKosfHTqXREWtmsiP/PzLe4obGR
         jI4hQNQFYXTOtcwWGcl5+UELdniZheDB70iCT4s13aGQqqIPGjJ2sZv/Riy2cnpnCrlX
         KYKvSh6/hUx1q5+K0jNOqBXzTtusPINQnT5OX73UXtmvf6lVyFJlyzybkedG1vczK5wH
         gi5A==
X-Gm-Message-State: APzg51AszPIK3VnffeSqt/ptMm3OdudqSxN3UmN8J4VeWkK3tadZRS3b
        XIE2EK2T75LHkbdNwOgPUfuRuRqMTGcVdSgzxuc=
X-Google-Smtp-Source: ANB0VdbwYCESDAYzoQm2b26fpZjGwwDOZ4/JQcxJ4PSdfEIZ4MmvWLIH4Wa1NuhsbGBb3ZZgMyWsFnXlMhzOhfTTd44=
X-Received: by 2002:a6b:8fd0:: with SMTP id r199-v6mr6210258iod.118.1534866677153;
 Tue, 21 Aug 2018 08:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1534374650.git.matvore@google.com> <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com>
 <CACsJy8AE+MwBzzUFRGLKVp6vaAg2W_KO-qbUU2LQpd=rMQw2sA@mail.gmail.com>
 <cover.1533854545.git.matvore@google.com> <msg.1534770125.matvore@google.com> <CAGZ79kZfNeWnZEnX4Z0hMShxZZEsB2jYJ67JgE7F_d-3ymHi+A@mail.gmail.com>
In-Reply-To: <CAGZ79kZfNeWnZEnX4Z0hMShxZZEsB2jYJ67JgE7F_d-3ymHi+A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 Aug 2018 17:50:51 +0200
Message-ID: <CACsJy8CNyep5cEV2bWkAMiZNrd9uGi1i8He3jGhPFq4NtKAPzg@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] list-objects-filter: implement filter tree:0
To:     Stefan Beller <sbeller@google.com>
Cc:     Matthew DeVore <matvore@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 8:38 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Mon, Aug 20, 2018 at 6:18 AM Matthew DeVore <matvore@google.com> wrote:
> >
> > There were many instances in this file where it seemed like BUG would be
> > better, so I created a new commit before this one to switch them over. The
> > interdiff is below.
> >
> > BTW, why are there so many instances of "die" without "_"? I expect all
> > errors that may be caused by a user to be localized.
>
> Well, there is the porcelain layer to be consumed by a human user
> and the plumbing that is good for scripts. And in scripts you might want
> to grep for certain errors and react to that, so a non-localized error
> message makes the script possible to run in any localisation.

I probably have a different view about this, but strings (as English
sentences) are for human only and should be translated. For machines
there should be well defined format (that  just might look like
English), not totally free text. In some case, this format can be as
simple as the "error/warning/fatal" prefix, which is left
untranslated, but the rest should be. There is no guarantee that these
die() messages will not change in the future, even left untranslated.
-- 
Duy
