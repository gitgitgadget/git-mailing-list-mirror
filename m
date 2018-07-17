Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8541A1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 10:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbeGQK4u (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 06:56:50 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33440 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbeGQK4t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 06:56:49 -0400
Received: by mail-yb0-f194.google.com with SMTP id e84-v6so206361ybb.0
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 03:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdICAQjYh991BDQexqAfNCfqZeYVZiZuzS1F17YeW70=;
        b=lPRCqLmAE5vzWB6ZJ5F8BRu+v8wyvRuUPm54APCkm9oUhkhuuz/YR23epGCNN/v5BC
         owWM/S2cHody7GJJcF8DaZfz9IHGvImitdrzGbmC0FF6X8f3QCTTV4Iz78wO7mvmt1YD
         b7wLxU8UNlw5uPhdqqUNze66ECzGhJaKQr7TsDhuUXzCdNU0bat28ThMC4k70sublAuZ
         Z6eJ7UDquRjTg0JD+kDGmr6Mwhvb6cVrsTXkfs5IuD4Yu895g8vXclkLR9lQzQj08NHx
         u0NkoF05O/euLuDeik/R6e7kyeYpDy+PoP3pZZmtetYUfSeh5pqchSRWqd8iVGIcI8i4
         eU1g==
X-Gm-Message-State: AOUpUlH4NW6kHDmF6ht5H5vjTehV8W23Nj1fg6Nl/Sk087hozhhmympv
        9EQv23t+wQzMBsrh3WCRUJ9D2GSLKdIjNAf+j9U=
X-Google-Smtp-Source: AAOMgpcyvlS2OKiNaGuY9DBRFSr3LyH4o7jvFEBtx9pF9DsdV3itdjWmWBOVPP1JMu47BEntxsSA/LcaAJYNpbo6tK4=
X-Received: by 2002:a25:d38f:: with SMTP id e137-v6mr439749ybf.287.1531823094100;
 Tue, 17 Jul 2018 03:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180530080325.37520-1-sunshine@sunshineco.com>
 <20180530080325.37520-2-sunshine@sunshineco.com> <nycvar.QRO.7.76.6.1807171214590.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807171214590.71@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Jul 2018 06:24:42 -0400
Message-ID: <CAPig+cSXvo31etKLaAKjt0TSuCE+5S6gS69S3viVM2cMzy3iAw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] format-patch: allow additional generated content
 in make_cover_letter()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 6:15 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 30 May 2018, Eric Sunshine wrote:
> > make_cover_letter() returns early when it lacks sufficient state to emit
> > a diffstat, which makes it difficult to extend the function to reliably
> > emit additional generated content. Work around this shortcoming by
> > factoring diffstat-printing logic out to its own function and calling it
> > as needed without otherwise inhibiting normal control flow.
> >
> > Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>
> Makes sense.

Thanks, but it's probably not worth spending time reviewing this RFC
series. I already have a new series in the works (in fact, mostly
finished) in which the implementation is drastically changed from this
one. Aside from adding an --interdiff option to git-format-patch (in
addition to a --range-diff option) and allowing interdiff and
range-diff to be added as commentary to a single-patch, the new series
also takes advantage of the newly-libified range-diff engine rather
than running git-range-diff as a command. So, most or all of the code
has changed.

(Though, perhaps it wouldn't hurt to review the documentation changes
in this RFC series to see if I botched how I described the option.)
