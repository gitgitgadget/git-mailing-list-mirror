Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7363C00144
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 00:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiG3AZp convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 29 Jul 2022 20:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiG3AZk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 20:25:40 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1F71D0E6
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 17:25:38 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-31f443e276fso65658877b3.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 17:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=2EDG+eWaxp6SgqvOfdXaFC+FBoA7Gzr4iBxLS6aFmMM=;
        b=G6UGu+Uw6Mg8dW9RzRxWowiPB4g2cRRoRbNRmcEuRqtvwXIoZPvoOO5I8tGLnxQLAm
         UZ6WmMaflL9Yl0wj08J4/3UtPYnVGGqKw0w5maoAyPlBJ4O5wE+giqRtJB6wP2/IYq4r
         +7ovBqbuNbR4XiqfY1ChSdLbWvM/+THPr7lu8mAB2K8uhU649ZZUe3e6tcFDgy3KQvL4
         VMUOIMLkxYagg7SRGXMPr0CgGEgSFYURfFb3ajzU3kdxY0aYleR30OZVwiMfFqt5E5WX
         r0J1g/eKoQoCnX694ZVxCd+z9hnR2llyUf0u45TIhfZJpu91dIXhjR+i6CuAeWdci+BG
         E/ww==
X-Gm-Message-State: ACgBeo2aI7OzKWhuBs9vFQgE5+ZjycS9DGGQMN5EY983sBYJwXXYqWTn
        /l4Y2ix7Hy7vp+A8tPk74xANN+7bTqZm0SAE+/s=
X-Google-Smtp-Source: AA6agR4Ep7wuaMIBjWuYz3PKxZmclT2prFutHpNFPSXtviEJkANqJMGkJG5ooCUk9DWw6rAtdeeqvwzampkpLYWh0nI=
X-Received: by 2002:a81:b717:0:b0:322:9a3a:4d53 with SMTP id
 v23-20020a81b717000000b003229a3a4d53mr5030321ywh.427.1659140737526; Fri, 29
 Jul 2022 17:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo7x9ch7n.fsf_-_@gitster.g> <20220728174953.66964-1-sunshine@sunshineco.com>
 <220728.867d3xj6s0.gmgdl@evledraar.gmail.com> <xmqqv8rh9co5.fsf@gitster.g> <CAPig+cTxM2vr11XRU-zrNAJRwveP0W9d0x8Euvr6HKmQicKgPQ@mail.gmail.com>
In-Reply-To: <CAPig+cTxM2vr11XRU-zrNAJRwveP0W9d0x8Euvr6HKmQicKgPQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 29 Jul 2022 20:25:26 -0400
Message-ID: <CAPig+cQ94oC-6wftkP_=RSEsOVPKeuBWuMshDkwV+Xu_FjrKeg@mail.gmail.com>
Subject: Re: [PATCH] format-patch: clarify --creation-factor=<factor>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eugen Konkov <kes-kes@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 28, 2022 at 5:09 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Jul 28, 2022 at 4:59 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >> -               [--range-diff=<previous> [--creation-factor=<percent>]]
> > >> +               [--range-diff=<previous> [--creation-factor=<factor>]]
> >
> > Eric, I am not sure if the other patch for the range-diff command as
> > a standalone patch is worth it.  Perhaps you can help me by
> > submitting a single combined patch to cover the above as well as
> > what we wrote in the two patches, with you marked as the primary
> > author and with Helped-by: that credits Ævar?
>
> Will do.

Given Dscho's response in [1] which states that "percent" is more
accurate than "factor", perhaps these two patches are unwanted after
all, and instead the documentation of "creation factor" in
Documentation/git-range-diff.txt ought to be expanded with a better
explanation, as hinted in [2].

[1]: https://lore.kernel.org/git/85snn12q-po05-osqs-n1o0-n6040392q01q@tzk.qr/
[2]: https://lore.kernel.org/git/xmqq5yjf4l60.fsf@gitster.g/
