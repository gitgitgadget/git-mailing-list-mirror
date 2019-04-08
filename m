Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29C520248
	for <e@80x24.org>; Mon,  8 Apr 2019 06:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfDHGp7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 02:45:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46394 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHGp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 02:45:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id d1so10550265edd.13
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 23:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNnl0xih6zh+P9Ozo1A35OzEAbQHDLaYZcCyjSCp1nE=;
        b=CnQ/gg3VJRCTd6ip0RTpNpWvPJ9qpmRISN0y/Nkfe2zEKonLyM5/gHMwH3B37+BnBM
         NouEyeNt76tZOBHwS0BefcXgtbeoXTJgW9Rn1Kxx/nRV5NDgb/Qa0KU/ch+xj14W9lOg
         swhP+SEBNfERV/bfXEc3fHO9JYJFy+Kkqrg7EzU9YwQAv7US8HaHU/siI0+v80e+zBdh
         G6h9FSons26Ew5RJogrD0mOhdhLfXjlvzV2xHzfI1QPQTDY29BfNalbDIJ2WylsswPFJ
         Z7ajDb90UL6v/rOVJYmQTX+X4LCvwYxxOjhjDJexfXCHjiBuaO3ZjDTiFcypIqYI39GX
         jEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNnl0xih6zh+P9Ozo1A35OzEAbQHDLaYZcCyjSCp1nE=;
        b=GskV6XNnIL73a5//yQfCQVbCIR2tNYKNAqrqUDIVxEr9Pnq0563MasYvqqhHB6V8xS
         Dnsz/yMWLW0bCztP26CxIyNxl1UTXe1riXcz5WwfJkDWlAnQGUXpqTik2MhnuSgLX8Zv
         rwC1dAuDlQuGrE98og5A6JnbntQvH6ULfQGjtCXTvuShug6e4MDto5RdE9WFzm7k6tcj
         ousU3V9p0kEjMo6ZIaRXL+J9g3PHYthU21cjBx3y2y3BOREM5IZuyhd3bfm7QNMYgd5y
         Budgx9fqY7XqUchtIeolhdNc1IaQaf7zmSBgqbXT0/fwk69Ls+YtCtoYAWw8jttiUKW3
         I/AQ==
X-Gm-Message-State: APjAAAWPEvcm5sfYxKgvXZe07kO+tSwMOM2bAsCaWO1pR1eqqAVdK8rL
        VT6jIauXUwiVlnX5kn8dH2B8/MpLkFoh1+tNCuc=
X-Google-Smtp-Source: APXvYqyxt+itstDzy+f5x0g8Ug+m7YcxPqdqnEIW0gHPQiSqSmfYgJQUIj1zDko73NFVfiHiOuXz/lYPFzB81VMR1RU=
X-Received: by 2002:a50:9b50:: with SMTP id a16mr17981146edj.160.1554705957660;
 Sun, 07 Apr 2019 23:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190326220906.111879-1-jonathantanmy@google.com>
 <cover.1553895166.git.jonathantanmy@google.com> <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
 <20190404024710.GO32732@szeder.dev> <nycvar.QRO.7.76.6.1904051528130.41@tvgsbejvaqbjf.bet>
 <CAP8UFD1qK61MtJ-XeMuwY4W2V0CdHeZQC9rQap1M+nEeaLmBJQ@mail.gmail.com>
 <xmqqy34lb4vb.fsf@gitster-ct.c.googlers.com> <xmqqmul19h9j.fsf@gitster-ct.c.googlers.com>
 <xmqqftqt9gpz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftqt9gpz.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 8 Apr 2019 08:45:46 +0200
Message-ID: <CAP8UFD15V1yskNzPjROCcOvarz34NdwOoSM2JRh3zNJhNeXA=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] diff: batch fetching of missing blobs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 8:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >>>  #include "fetch-object.h"
> >>> +#include "promisor-remote.h"
> >>
> >> Thanks.
> >
> > Together with "if we are forbidding the direct access to the
> > repository_format_partial_clone variable and the fetch_objects()
> > funciton, make it clear that is what is being done in the
> > multi-promisor topic", I think a patch that adds this header should
> > also remove inclusion of "fetch-object.h".
>
> In fact, your topic itself has the same issue.

Yeah sorry, this is the kind of things I easily forget.

> I'll queue the
> following at the tip of the topic tentatively before merging it to
> 'pu' with the fix we have been discussing around this thread.

Thanks!
