Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEFAC48BDF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F3961040
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhFIRXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:23:44 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33502 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhFIRXn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 13:23:43 -0400
Received: by mail-wr1-f42.google.com with SMTP id a20so26412090wrc.0
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ug3ix6UCCzEggqEqLZHdpqIUpzj2JnKump3AO8v8eJM=;
        b=K1EqWC7vKZEJy1Vtgd/Dg+f1yGzBdZnezFec9RnLn57gLJYFdaMAxpZNnD/FHJzJYm
         WGDtjqMb7bu2hhicZvhi7nn0jZI67+FnOHBAZ09zdvFyfr63XPCWfQglgTOjW7qR6Dlh
         cK65/IX7NzrPnzdyv8chbi1ACPmLYSMXs5nKtake5wIobtn/nwggVg0l7N+llrIatrzK
         BLVT7qR2aY6Nx8C1Uc+JMkxDKxmLdJkJSSKU784Y6oXpidUJHoP1o3s+YgJxthw2hIEC
         kPIo9UCPtnnuhEPTZMdEMdZhMWEiiOTN8FN5qDuV7dhgRORza8Y87/MhAeGCFOZl/Ysc
         S/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ug3ix6UCCzEggqEqLZHdpqIUpzj2JnKump3AO8v8eJM=;
        b=ExD2UjBwfyQXJOwca/Y5EsONheVZqOROqBENudvDFwHCodGjKfdOlqv57sQ/qU3TrB
         mvsWAyi5d7TUTaFv6xX+OIeB39vvrtGz471mEcaPrIMvFUUri89soa0LEmTLZVRr7bDz
         54Z8Tvaug5iN4ahyDaxbGcJKwkHFU/vZwVWkUUceQh73NNk91lkZB8VYHegGsEYqDICR
         4WPBs67c0YfwCCGyCv+aRApyiQRYl+cZo06Lb0Mdcem3yVMpr3XgdKYYTtR+R3KdQYcP
         1RIfG7d/wZ9ttiIxEPYBxHDt+LvneGtmX4707X/0lubVT8yfbii2wkVLnHqvjzVT0706
         SvpQ==
X-Gm-Message-State: AOAM530+fUtgn4ipxqalF77YSkCX8dSFazhfkmNICAGHjpmZDiydMKPM
        4Ax4s2ei1BWQVwf4sdrkXY87ZTtKTnXaij0i96fn5w==
X-Google-Smtp-Source: ABdhPJxWr1Mob1Li4qh9wlvCTUF4WZujYQE6lE0kwJl3xhuWKFYaZGvEbI0HOvt9q3dh1Kl1Cp8+LzOuB2KUFbLAzGM=
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr962662wro.2.1623259248058;
 Wed, 09 Jun 2021 10:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210420233830.2181153-1-bga@google.com> <patch-1.1-2302c9d522-20210607T143157Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-2302c9d522-20210607T143157Z-avarab@gmail.com>
From:   Bruno Albuquerque <bga@google.com>
Date:   Wed, 9 Jun 2021 10:20:36 -0700
Message-ID: <CAPeR6H4bqTjSxieWVbWQGG+vg3=6DA62JQRrpLaG_xKuhf4ADQ@mail.gmail.com>
Subject: Re: [PATCH] protocol-caps.h: add newline at end of file
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 7, 2021 at 7:33 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Add a trailing newline to the protocol-caps.h file added in the recent
> a2ba162cda (object-info: support for retrieving object info,
> 2021-04-20). Various editors add this implicitly, and some compilers
> warn about the lack of a \n here.

Thanks for cleaning this up.
