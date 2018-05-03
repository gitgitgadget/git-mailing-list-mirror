Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E004C2023D
	for <e@80x24.org>; Thu,  3 May 2018 05:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeECFXC (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 01:23:02 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36914 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeECFXB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 01:23:01 -0400
Received: by mail-wm0-f42.google.com with SMTP id l1so28007314wmb.2
        for <git@vger.kernel.org>; Wed, 02 May 2018 22:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FKzc/9nDUNLITLwlDgdoGo8vP1+htKGQX8m1j26C8mA=;
        b=CGDokeDlgw6AmDUUxffaRbsyqjHXN9yz1SyUdTg7lOkQ1bFJFHdSf8FUIPZg/H0oN2
         KjbQQSIOy8ycsyd/RvKATCrGeH4bl2arfz7HeREwaXJhO9Zi9kjGP04zqmqYoSXalaKa
         u1uwbMSEOCvvRZ0Yu0CD8AQNcQMn1e7tTGmh6wcn4H1h8b/ip3EbvVi5NuSsDltlozW/
         XuekUomNdXZtvvqjx4QgmWcy0G6M5bDpXJl3p3nainpRiWuZBk5SOtRrPWlBkCJhC1wl
         hQm6GlZ9OLRXc2fgJEaDsZWGKOskeRabJ/+KTxiO50D6iWfvrF9tJhNFIuBIiDxn0UM9
         4/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FKzc/9nDUNLITLwlDgdoGo8vP1+htKGQX8m1j26C8mA=;
        b=Y6TRjy/e2/nxiKPylL1JvZFswmkCtNks+ZaZ9UtVftow59T8CkoRA9ZAdi7WGqH9Dv
         i5xP++2GCvVse58a0CCpps8b7sa+bxApNceiN2cGNj3AKoCFh5Pjs0kC2wlw8uNwdkGV
         Pgly0zMjYENPjjJKobg35odkK7vlmCTUfOcP5eAevl3I8lwP3+JjFW8996Eo0np2l0Hs
         YnLKeB4wHArzN39ZIZQ+Gs9qVHkowaYGuD5Lury0qN0xrbxOA4VXzszXviqKC5NHzVbz
         jPQQduR+Myn5w5t5kHGx6nIbKnusvoxg6TAWu88O6SZvHDcJRpmFatXGeX8XwcvDZTaA
         Q4Mg==
X-Gm-Message-State: ALQs6tDJyghCx5p1orT7yTT8ZZLtBLIhxoHWoFImZKGJ/vQE5tHPVCJV
        2QTPHiJj2P6im1r6tGUwrJs=
X-Google-Smtp-Source: AB8JxZpRBeSyt0f6XO5pILAyCShtl3592hWEXEGtbFHUOsB1YbANvhu5phlbXCrY+ht25OtNfaVdvg==
X-Received: by 2002:a50:b119:: with SMTP id k25-v6mr29975831edd.217.1525324980302;
        Wed, 02 May 2018 22:23:00 -0700 (PDT)
Received: from esm (ipbcc18eac.dynamic.kabel-deutschland.de. [188.193.142.172])
        by smtp.gmail.com with ESMTPSA id p36-v6sm7924997eda.43.2018.05.02.22.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 May 2018 22:22:59 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Thu, 3 May 2018 07:22:57 +0200
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v2] wt-status: use rename settings from
 init_diff_ui_defaults
Message-ID: <20180503052257.GA7576@esm>
References: <c466854f-6087-e7f1-264a-1d2df9fd9b5a@gmail.com>
 <50c60ddfeb9a44a99f556be2c2ca9a34@BPMBX2013-01.univ-lyon1.fr>
 <907020160.11403426.1525172946040.JavaMail.zimbra@inria.fr>
 <20180501114316.GB13919@esm>
 <1652522802.213664.1525177431907.JavaMail.zimbra@matthieu-moy.fr>
 <CABPp-BFbVP3iwAbaa2cEPw9Sr+ANJoHHYHOCQ4oAZoVdyX164A@mail.gmail.com>
 <xmqqlgd3x972.fsf@gitster-ct.c.googlers.com>
 <CABPp-BELX8u_CG8BswenAKCo8yvfxxOAOHjAbvh8jAm9gN7Qgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BELX8u_CG8BswenAKCo8yvfxxOAOHjAbvh8jAm9gN7Qgw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 01, 2018 at 05:08:27PM -0700, Elijah Newren wrote:
> Eckhard, can you add some comments to your commit message mentioning
> the email pointed to by Junio about break detection and rename
> detection being unsafe to use together, as well as the inconsistencies
> in break detection between different commands?

I will work on that.

Greetings,
Eckhard
