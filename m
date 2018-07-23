Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE6091F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbeGWTqp (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:46:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41131 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388017AbeGWTqo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:46:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id v22-v6so1193816lfe.8
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kqtVZaGFkq1QFUd9MF1QykreTTRbtGCNFZNR9w5MSR8=;
        b=JOQSkG2IqAozuSO8eJFnd/4FNfTNwdiISkW2/6IpHqgoyOLAVjD7FmkIZo+TUS+jP2
         2ZlIwIKcMXP0hpYlS4oFpHSaW5M1w5IeF/JZ5UMKq2QvoqY6gQEd9hlyN9b1lNcymRLe
         gXp1k0S7xqUBJTZ7gsYG618QslPbgogwZLKDUBjt1JDvvePPQFo8tMDATvFkUVLIeynS
         pYp6T4fMHJYO/XRThHrT+XVlWOxEQlQFVppFU6EJuX72Ff2ZX//pS4n4+CttTUT6d/lB
         fDEv0ZYjhVY7Ic10vvDdQ4u6WGcj7bmApb/AXtnNrj3dj5gwulTruThTCHOtpebVxxax
         wuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kqtVZaGFkq1QFUd9MF1QykreTTRbtGCNFZNR9w5MSR8=;
        b=f80VeheNPCLLinSTAqbvjNEr/whhB0sZnWHBFw1qZALflBb9U0x+BF30s6RChnrAOE
         neN14XfLoRbQd8MCE82/WCHs5vcVeOCLoSqyRO7oynRa+//VnBh6ySZjTFtVuFknTc/P
         d3sLjgpKCBIMhKQDnGesmylD1lFP6reOFc0mZd2VOYMj/7VMDtqCxnoPxVYEs39wK8mA
         LRs8LBzUF6krt/QS+PTXpel+kItEyfgr4iMN8nCfelBK3cPyoDwEilHzGCtIvz/eigk3
         TtW35FDK+UBHvTpdBnr0kSWYdSF9D0MfBc+ZtYzFVV9gzS5Q2P2IPj80GBVVw8lGKcRs
         LGuw==
X-Gm-Message-State: AOUpUlFB80q7O1vY9a/J18jGHo+tkOR1EX3s52LA5XBwUk1EOWM8xbb8
        uI/AgpxnvSVja5uROS/1iijQZu1U2qTDeRdlw6+nhzI5
X-Google-Smtp-Source: AAOMgpcetcZCFsncB929rvJtdRgXMcmx32LZhhZcy+1vxMg9WNeHuvHciRIfWj3uQYfS1ekTyrsYlfHgFi2wP9btyG0=
X-Received: by 2002:a19:501e:: with SMTP id e30-v6mr7920733lfb.71.1532371451289;
 Mon, 23 Jul 2018 11:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180723135100.24288-1-szeder.dev@gmail.com> <20180723135100.24288-4-szeder.dev@gmail.com>
 <CAPig+cSOZd+t17j7FSCYAydS34ZtfcRFZyE6E9fz=u7xB-01Mg@mail.gmail.com>
In-Reply-To: <CAPig+cSOZd+t17j7FSCYAydS34ZtfcRFZyE6E9fz=u7xB-01Mg@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 23 Jul 2018 20:43:59 +0200
Message-ID: <CAM0VKjkJoqRFmXdnuujSaiZ=hvz6MeAmgoUQNAkZ+82ZrKtotw@mail.gmail.com>
Subject: Re: [PATCH 3/5] coccinelle: exclude sha1dc source files from static analysis
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 8:28 PM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> On Mon, Jul 23, 2018 at 9:51 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
> > sha1dc is an external library, that we carry in-tree for convenience
> > or grab as a submodule, so there is no use in applying our semantic
> > patches to its source files.
> >
> > Therefore, exclude sha1dc's source files from Coccinelle's static
> > analysis.
> >
> > Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> > ---
> > diff --git a/Makefile b/Makefile
> > @@ -2666,10 +2666,16 @@ check: command-list.h
> > +ifdef DC_SHA1_SUBMODULE
> > +COCCI_SOURCES =3D $(filter-out sha1collisiondetection/%,$(C_SOURCES))
> > +else
> > +COCCI_SOURCES =3D $(filter-out sha1dc/%,$(C_SOURCES))
> > +endif
>
> Can't you just filter out both of these unconditionally without
> worrying about DC_SHA1_SUBMODULE?

I'm not sure what you mean by that.  Like this perhaps?

  COCCI_SOURCES =3D $(filter-out sha1collisiondetection/%,$(filter-out
sha1dc/%,$(C_SOURCES)))

While it's only a single line, I don't think it's any easier on the
eyes.
