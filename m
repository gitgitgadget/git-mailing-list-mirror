Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 177B21F404
	for <e@80x24.org>; Thu,  5 Apr 2018 22:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbeDEWwb (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 18:52:31 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35332 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754087AbeDEWwa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 18:52:30 -0400
Received: by mail-qk0-f194.google.com with SMTP id c188so28149573qkg.2
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 15:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Ue2y14CB7+4YJpAbCQis0vVUARmDLOpaT3FInAt+Z2M=;
        b=ft7rkMjK4kPj0pJsLOwhl4phFsLcsxzzXeDawm9UAimbt62XOHTIXlwN4alegAVPWH
         x+N8FAplHAhmoeyCeeMxXDgBcaCtepLn3gDN/lAFYUWISTLTfOU2a7sZ1k79dbyw5g5B
         IEaMFuc5konNAyaIb3BktVKKKh9vmMx8+Ofg1GRYVFDxO82RJAJtNSPamM1W3+ULxbgB
         SYSrmzE30LGBdu3Kj9gaHyQAj7IVaK/UNXYgTb4+PcOgCzz5DFi90lUDgYoThVwT6toj
         4PubrwhdqNIuxamHPM4bA85dABdHM2nbGz7Tvj4UxQ2ynxXj6jWKMC4avyFsxdso+kr2
         Kb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Ue2y14CB7+4YJpAbCQis0vVUARmDLOpaT3FInAt+Z2M=;
        b=fYeMiKQDGfXHy+7A/WUbuBB7eA8XnHU5KKsHfHdL10uKyZHkq/ah3xGuUxkCzx4Qau
         2o+m09oU2bFn4jN+bxY6xyMrrjMfnp7hVJEG4q12QmACVxFGB2byLOPwIya5WNyl0cd9
         qNT1ntRvma2wuK1J4U9xciMu21RdUftF/GSvKXqJU2OFk3+F7Fs2r51PSFHPZDH48/3G
         Z641tQ4KYl7+jkKLpUWTTA8TQOOnpMmf8VtkdiV1zVE0AQxHSwxA+CHNhDr+iWVHbZgv
         MmcvQhYm2+s6mQKYBAXSc9fXSn5IUCrS5/LnF3MhUr5/AsoqNLmbwHklOM75m5pRm1Ir
         7q8A==
X-Gm-Message-State: ALQs6tCIrkQ2MG4ZRXQxohnX3QWCIo4pV0NV5AKr64MefW5PEiHtFrIc
        xKbl3KjKT3Jqbkv6AEa3Q/WZ8RDMDp+vCvk8KTxv/Q==
X-Google-Smtp-Source: AIpwx4/gMdYrqkXY3osfbWesmdLuVlPLEJMkcCHBAeDbOMZ4G0tzmzqONNRiC07D4+iWuQZld9KuHyKZeXh2ZWctyvU=
X-Received: by 10.55.3.140 with SMTP id 134mr33270813qkd.26.1522968749389;
 Thu, 05 Apr 2018 15:52:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Thu, 5 Apr 2018 15:52:29 -0700 (PDT)
In-Reply-To: <20180405223620.GD29117@sigill.intra.peff.net>
References: <20180329011634.68582-1-me@ttaylorr.com> <cover.1522896713.git.me@ttaylorr.com>
 <20180405025917.GD49902@syl.local> <20180405223620.GD29117@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 5 Apr 2018 18:52:29 -0400
X-Google-Sender-Auth: 6Q6B5brpQniCNapHD13JQoQlm-I
Message-ID: <CAPig+cQoTQ47n13q3t5MMS+UZQR6jbFDpVSP8Z=L4qckjrsxeQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] builtin/config: introduce `color` type specifier
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 6:36 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 04, 2018 at 07:59:17PM -0700, Taylor Blau wrote:
>> +     if (type == TYPE_COLOR) {
>> +             char v[COLOR_MAXLEN];
>> +             if (!git_config_color(v, key, value))
>> +                     /*
>> +                      * The contents of `v` now contain an ANSI escape
>> +                      * sequence, not suitable for including within a
>> +                      * configuration file. Treat the above as a
>> +                      * "sanity-check", and return the given value, which we
>> +                      * know is representable as valid color code.
>> +                      */
>> +                     return xstrdup(value);
>> +             die("cannot parse color '%s'", value);
>> +     }
>
> And this returns the original. Good.

It's entirely subjective, but I find this easier to read and
understand when written like this:

    char v[COLOR_MAXLEN];
    if (git_config_color(v, key, value))
        die("cannot parse color '%s'", value);

    /*
     * The contents of `v` now contain an ANSI escape
     * sequence, not suitable for including within a
     * configuration file. Treat the above as a
     * "sanity-check", and return the given value, which we
     * know is representable as valid color code.
    */
    return xstrdup(value);
