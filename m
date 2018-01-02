Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D83671F428
	for <e@80x24.org>; Tue,  2 Jan 2018 20:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750968AbeABUEg (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 15:04:36 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:39905 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeABUEg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 15:04:36 -0500
Received: by mail-qt0-f172.google.com with SMTP id k19so64129607qtj.6
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 12:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=72werVsbVRqfn5Bd2hSPeOMC+i33avEhVYH8R9J813g=;
        b=K0hCFRm/CiOqURNuV7bdTbGlkQ3+vZfr+Fv9rj6dadmbxGtPWcsI2hvbhoSM1SGc5t
         MoAzZRBK1EqZARq66MBl05VEISEdMcy/heKw+40t8zvCsiTM0Qb8iW1i4uCOzt+OikoE
         TczR3a6N4ofmJUTpV1MMgvU9oEjyVq2cI1x+ZPiJRKOD1odXmcmPWybgXH5XCWcyjfU/
         uy10wezslhBHnSp2QDFquLiqW+B+hW7kfnEcXSQ0KJtJPAsuIUK87EvQkfkrz5g851aL
         +HI6rnCslePUEGqYfy26uco7BqO+PYGsp1JK7N8cxEUTtvH6n++2gkdGj2XKBohOnrTD
         5+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=72werVsbVRqfn5Bd2hSPeOMC+i33avEhVYH8R9J813g=;
        b=gzGYz3v0apL7F32XXo83mglDqofs7qzkQptne+ZbWv/K6J10nmGpVav0Ex2oZLIvs3
         buCY6LjDiJShGP4ftWT0/6Z29MGRkwMf2u7wai/VFx6qh1DHxbSG+8I3qoNaGJ7f+pFd
         tG3R2w9KPrKqlc0NhX+236e1w8C2naBcFFev6m1rYoTAMzambi0eaRryFzQOuKH/mslq
         p6ke3MpSqLT54QMatbXkVtT4U9nkVOGQq4diqqTrHZF+xJuF82fwUa8Eh9/Q2+a0izLH
         y7OWO+C9e4PN0uE163BbyLyju91quMEtKAUcUIl/07jukCkOOOZ7KHciozQw5eArpSf9
         0S/Q==
X-Gm-Message-State: AKGB3mKuyUVR4beu8g57hanrx802QxC6iTLucIfIf8VycOZGk7R/uFPO
        IQlIPAgjb9iOUyYG4zcsK1Uk1CIemQr3+M45btwdsA==
X-Google-Smtp-Source: ACJfBosrXg1tFKIUto3FqdUxUVxjkVeWGYgVDIcTEu51ryRcO+paT++mPUV4bVA/rdt4J2cajeZngHxemYRP8ARguAo=
X-Received: by 10.200.35.215 with SMTP id r23mr58499665qtr.174.1514923475051;
 Tue, 02 Jan 2018 12:04:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 2 Jan 2018 12:04:34 -0800 (PST)
In-Reply-To: <xmqqh8sallqs.fsf@gitster.mtv.corp.google.com>
References: <xmqq608rn9ca.fsf@gitster.mtv.corp.google.com> <CABPp-BHxcFU+e4OgccWb+LgLbMo5sJsNjYFQb=WnxViTFdOu=g@mail.gmail.com>
 <xmqqh8sallqs.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 2 Jan 2018 12:04:34 -0800
Message-ID: <CAGZ79kapuEKLO4RUUPVS6_-aeBERDhjpBAtmK=gycT8GaK2bFg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2017, #05; Wed, 27)
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 28, 2017 at 11:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> surprised by the branch name, though.  Was 'ew/' a typo,
>
> Blush X-<.  Yes it is a typo.

Note on that series:
I have reviewed the first three patches (which could form an independent series)
that it would warrant a Reviewed-By: Stefan Beller <sbeller@google.com>

While I reviewed the earlier versions of the later patches, I would
prefer if there is another reviewer for these as it seems like a bigger
contribution at a core functionality.

I cc'd some people who were active in some form of rename detection
work earlier; could you review this series, please?

Thanks,
Stefan
