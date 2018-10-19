Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E652B1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 17:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeJTBRo (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 21:17:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42580 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeJTBRo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 21:17:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id u20-v6so6851886qkk.9
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 10:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acUpP7pS1px0jbsQ13QnoneXnFrt0gBz35Pf/Xu4Yxo=;
        b=cO8m3forX8iWTknpChuzHJMst67QTWZK7EO3TAR+BhJgmrhxRWL8qzRkR8lHttSeGM
         s/RgAPBy3HPknObGjSKWyiT3VF0ne80Rn8kVwyM5NirQx4x9QAxP7TeEHXZ9lEOVS+CK
         GYoz1TIAYGbIoTjpAntMSKia/h3NVBlgwYE6oaffwhdmJCw3O00VAIpAeSpfvNPsUmu8
         /Mou9zkx8VwzcyAU8UgTZL2jz6RoneHCCgFGjZ7fdej35V1mLY9iN0NBSRM5Oogb1g/T
         CveHKiLD5GFpPxmA/xb/v379Oeb2QKsWAHnC2tJ61NnlldmqhNmLBIos2T3sVV4vIfCj
         nNtw==
X-Gm-Message-State: ABuFfogZoF/eAFfnxrWkBNP/mSYAscafU05ERrDuL2xZr0nbctkAMk6W
        W1eNZgD/Ewc1Dw1gspWFsN42Ok6V8RA2CmA0hC8=
X-Google-Smtp-Source: ACcGV61WfLPvr7HemVWmdvRiMbsSonIujGciReKNr/xVQ/3Xtx89TKPgWaKOvhbma/FlUStBF/yFGnrQHa5j3uYJJTQ=
X-Received: by 2002:a37:7641:: with SMTP id r62-v6mr33688127qkc.314.1539969045462;
 Fri, 19 Oct 2018 10:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181017164021.15204-1-peartben@gmail.com> <20181019161228.17196-1-peartben@gmail.com>
 <20181019161228.17196-3-peartben@gmail.com> <CAPig+cSL9=mmvdq9J9VXF67=010E1eZBjrYYaYQDN1z1OEf0CA@mail.gmail.com>
 <20181019164631.GB24740@sigill.intra.peff.net>
In-Reply-To: <20181019164631.GB24740@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Oct 2018 13:10:34 -0400
Message-ID: <CAPig+cR7=OpNsuZu+ppdyDvt5HAHMdDj4cBVg2U34B_j2zZ03g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] reset: add new reset.quiet config setting
To:     Jeff King <peff@peff.net>
Cc:     Ben Peart <peartben@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 12:46 PM Jeff King <peff@peff.net> wrote:
> On Fri, Oct 19, 2018 at 12:36:44PM -0400, Eric Sunshine wrote:
> > How does the user reverse this for a particular git-reset invocation?
> > There is no --no-quiet or --verbose option.
> >
> > Perhaps you want to use OPT__VERBOSITY() instead of OPT__QUIET() in
> > builtin/reset.c and document that --verbose overrides --quiet and
> > reset.quiet (or something like that).
>
> I think OPT__QUIET() provides --no-quiet, since it's really an
> OPT_COUNTUP() under the hood. Saying "--no-quiet" should reset it back
> to 0.

Okay. In any case, --no-quiet probably ought to be mentioned alongside
the "reset.quiet" option (and perhaps in git-reset.txt to as a way to
reverse "reset.quiet").
