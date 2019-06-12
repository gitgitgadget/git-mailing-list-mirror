Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66CC01F462
	for <e@80x24.org>; Wed, 12 Jun 2019 17:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbfFLRJX (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 13:09:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43952 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfFLRJX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 13:09:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so26805342edb.10
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SDAv4pcIh+YZauA6VWVuO4sGcVAYNzs/aCCgL/rWmuI=;
        b=cP/IWyFdn6FA4aqyRdpysbiAyoDlFeWH1mGUG66nAxM1ryZBTPcGltYHRmd98fy8HZ
         +WV+WfTPGosWeg78NJuwZJWjZdrtUiBVAnohqfjYqv33PirPn16RvwYeuEWJzcWH08Sr
         oLAjby0EBr4ieKAz8jt6rO/90qpsO7S4TM/wFxlj4lCPmY6FD+3xB+WvwUfAggrocWr1
         x8EqGJ+aZMGpEjaY6hrpus5cdZT9+I2C5aLdCbYx/uzBFg+UwEGC954088vqt6KNH+Ev
         9BbwIW2dZIaU/+nwGywL119Icm8Xysm0cVqG9nRMcwj1Xw8nmb/HmQeT6NIgMSstxeq9
         tkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SDAv4pcIh+YZauA6VWVuO4sGcVAYNzs/aCCgL/rWmuI=;
        b=EedWF/FD/gckzNSwafLcCug/14QIse0BIJQdXC0TZNv5vmovzlKB5A0+f1rVrSG6F0
         xSEhhzF7gjYPxVpBuD+sJYAXu2tbrJ5jhA6Ojrgn7g7Nj14rOQl29bG4quVO3qMLtmOw
         uI7aChZytZ285+2fFt8+GurX1LomXxIaBepVZmXgAXk59461roRiTo163kiUaaoqPvxY
         TIAMoIsTzWu86WpJarH5jpvVXR0vPP90JjAeD7McuFvf4zJ5+np/akJ8m9tGZbrt7tVr
         TqxQUpDKlwwB6FRlCvGxd12uzLAdhXxC18KwX9fbNr1t47FxBClaqPoXBASvcyyE+U7P
         23Bg==
X-Gm-Message-State: APjAAAUG0tvksEzh2GHHqq16QWDLkQ6D5D0EEAPqTul9zx5skwBC7I7k
        GM58b4rkKVHUGigmjTz2ZS6o7bBukkysu1w6bSw=
X-Google-Smtp-Source: APXvYqzqGWB8ynU/J4XnqMtSABEs89O9dPk+tQy9bXhc7ZgQD0yL/sa7CYdQm2KhhxpSc0gDi/VECcEEoPdacPRzVWw=
X-Received: by 2002:aa7:c5d2:: with SMTP id h18mr87706772eds.110.1560359361423;
 Wed, 12 Jun 2019 10:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190611082325.28878-1-chriscool@tuxfamily.org>
 <20190611082325.28878-3-chriscool@tuxfamily.org> <20190611101250.GE4012@szeder.dev>
In-Reply-To: <20190611101250.GE4012@szeder.dev>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 12 Jun 2019 19:09:06 +0200
Message-ID: <CAP8UFD1Cn15P4KeuPbK1ZOcZuWHNRq690PtdcvQSWnSc_T+Beg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] t: add t0016-oidmap.sh
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 11, 2019 at 12:12 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>
> On Tue, Jun 11, 2019 at 10:23:24AM +0200, Christian Couder wrote:
> > diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
> > new file mode 100755
> > index 0000000000..cbd2cb71d6
> > --- /dev/null
> > +++ b/t/t0016-oidmap.sh
> > @@ -0,0 +1,100 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'test oidmap'
> > +. ./test-lib.sh
> > +
> > +# This purposefully is very similar to t0011-hashmap.sh
> > +
> > +test_oidmap() {
> > +     echo "$1" | test-tool oidmap $3 > actual &&
>
> Style nit: space between redirection op and filename ;)

Aargh! I will resend soon with a fix.

It will actually have everything that Junio put in 7f2a91c1a6
(SQUASH??? sh style, 2019-06-11) which is in pu.

Thanks,
Christian.
