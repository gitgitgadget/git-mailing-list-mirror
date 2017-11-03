Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F18F20281
	for <e@80x24.org>; Fri,  3 Nov 2017 02:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964942AbdKCC3j (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 22:29:39 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:48587 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964891AbdKCC3i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 22:29:38 -0400
Received: by mail-qt0-f178.google.com with SMTP id f8so1720942qta.5
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 19:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=biwcJc1gVJc7s/ye6n39SjQoM5yGd1qcbXtnB8BlI/Y=;
        b=JXz2ZaKH1Wc2fwIlrR0Ill8jmb277FiquPGoTZz7YMjGhGeBOqKthRt3exGmh96bdL
         0oGyeP0wjrVit4PIPIXJzqXydt3zNnAWrSPs1leV038S1sp3iffAJP1A7g5sXKFOiNjL
         TPwL6bm897d3A3fOeMCNhaWs1Tjlig6eQQnyvG8p8ValEj+Cg/kgZopgCHEwHzdNorFT
         y7CFPmtTwu9AxpIw77U5ay4t8jOKSyqyaBTm7jXeCfwwQ1qPVlH+8H6x98Mc8M0THsZP
         MJ5brU8Shcmjk1eH7heP20HxnOnd1/Er8bUk4Hw+jJxLAo1jo1fJa/eENNz+7qOImAdr
         4mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=biwcJc1gVJc7s/ye6n39SjQoM5yGd1qcbXtnB8BlI/Y=;
        b=jUtYJGcu8SRO6FKEe3kC+L5nm8O6cQqjAJ0JbmS0yYnkLGmmvYe7E9vwMdeDb7GZq3
         7w/JLHwjs6+t0W16WVR0813g9yja/Sr6W1aQ2kDGRef7GrGCOfuVNR825PxWjt9DgK7w
         wgKrd8V6QERctY2Ol/zgiulFF1eyQOE6P7RV/nn/sQH8Xh7FHqS8tRJWKB8dQXRTWE4O
         Wa0oMgBdeKU1jNYKN/OoM5C16c4sl7u54I16J7Hnr2qBxaPvADPEYYzrBbKjbcVVzMuu
         eDGfv5/kpKPzOy5XHmYIbAHUq3FHZfUkrFzGigFI4UWHGH87mKRwsYxJXnN0Wy8fhJWS
         4s0A==
X-Gm-Message-State: AMCzsaWyVTFm8fcAxw0uoaUl+wawWxLU+xoZS/VtRDJCd3MooA6k2OsA
        5RrZbDjTgyBT2ku4d7mJlvNtJ79a0oL1Z3xnRAZ9RUNI
X-Google-Smtp-Source: ABhQp+SR6lg39MZnuGL0rZtcNQ8XPNrbc3YjvUTv/baLqfqzOkf5+3pbu2ueuRqq9ziMp1gHX7nM1OMmk6JG5AQSB9k=
X-Received: by 10.200.40.146 with SMTP id i18mr7984429qti.79.1509676177938;
 Thu, 02 Nov 2017 19:29:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 2 Nov 2017 19:29:37 -0700 (PDT)
In-Reply-To: <xmqq8tfoqgle.fsf@gitster.mtv.corp.google.com>
References: <20171031211852.13001-1-sbeller@google.com> <20171102194148.2124-1-sbeller@google.com>
 <CA+P7+xr0owJt4qvWeNkWhEionJ4468h0pTdB+h-FrEaBqi375w@mail.gmail.com> <xmqq8tfoqgle.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Nov 2017 19:29:37 -0700
Message-ID: <CAGZ79kYhV7pjbCAiJir_CJQNVrBOTA3ZoCRn6Svz80Xi5O3LWA@mail.gmail.com>
Subject: Re: [PATCHv3 0/7] git describe blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 2, 2017 at 6:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> I agree, "something" is better than "nothing", and we can work to
>> improve "something" in the future, especially after we get more real
>> use and see what people think. Only question would be how much do we
>> need to document the current behavior might be open for improvement?
>
> If
>
>  - it always digs to the root of the history no matter what; and/or

this is fixed.

>  - it almost always yields correct but suboptimal result


this is not, for the lack of knowing what the optimal result is.

>
> then that fact must be documented in BUGS section, possibly a brief
> descrition of why that limitation is there, with a hint to invite
> people to look into fixing it.
>
> We should mark it prominently as experimental and advertise it as
> such.  "It's too slow in real project to be usable"

I found it quite fast after fixing the history walking, but still.

> and "Its output
> bases the answer on an irrelevant commit" are not something we want
> our users to experience, except for those with inclination to (or
> ability and time to) help improve the feature.

I think the current documentation states exactly this.

Thanks.
