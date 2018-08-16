Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E706D1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 15:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392101AbeHPSml (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 14:42:41 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35082 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392098AbeHPSmj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 14:42:39 -0400
Received: by mail-io0-f193.google.com with SMTP id w11-v6so4248253iob.2
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EdDnJ6o3coZos31WmwKtfvkDeOBYjB1jbm8uKcGribM=;
        b=btA78J9qwlRc1+yn8yINYyRqLan7rSTa5N7a01sd7o2QFHi/uaOb5Ulp9ZWkJZ7c+I
         ectgpqi5bwhUFIn28+UWjKLmmUiGcuvAmv2hTpioteRCy0zUJwYM0MSTNcMJ2sEA+kWu
         nBtZ6/23iKn49ZHCLO9MW84DWbpGgTC7VV8VF4oDrw6UzzbeVNKncocmWszuR2wG0aPF
         NAYvch6/ssiJjo76lM1L9vNUa2pnXvnt6AwfERw5s2CaN2nLVkA2TVa20JCD/fXDtTnG
         DHZBy1PvLmPyRklZ6fRm5tryABCXR5tLy8QAqJHIQxOmDsZay8jgR1uxGQrM+McgE0AH
         PMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EdDnJ6o3coZos31WmwKtfvkDeOBYjB1jbm8uKcGribM=;
        b=CTG5lz2c76Pb3wsEnpJRkKasrJvxAvh8BKv+k7dlVUsxsduPeBIzYUfvWz0Y3L3llt
         Pe3pUiCa73uNXLS6TZ1nCEzIEbsXprxKXcnGDWBrg/OBCmIjGDdqaO5yCUMB84WJ6hqe
         ykKZ9dFkJeAXFtjQsOCUZvLi9BPFftdkhqXmZcUKtR0qzMvg+dyP39c93aTpg06sAwR0
         P5tYV2cWsrLZ2F1HAWG+v55EW6SKq0mFtup+NDWaecR2u9YjvpcR1JgQqArNyK74MTf4
         cllsXgSVO4X4Bg0o/7w5l/544w7pu6HypHqW6IU3PCtsK5hRlchKtNMYJEiBmBMRFZfm
         I2oQ==
X-Gm-Message-State: AOUpUlFNYwrOoI6bPLphKxtDEE5WPR0WSEusXW9Dz1XAQPF/Bez99Krv
        oDsjaScrL3IDW1+WElSYHNxW/rO7xs1B9O1tzBs=
X-Google-Smtp-Source: AA+uWPy/Jh6lt4D1sE0CnVjyVi8fssB2YofbxU8Sw3CuPURHhMIAt8r/u0V8Ma0xCEZfxxxLCcaH75MTu45x0FyOhKw=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr24102131ioe.282.1534434203819;
 Thu, 16 Aug 2018 08:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180810153608.30051-1-pclouds@gmail.com> <20180812090714.19060-1-pclouds@gmail.com>
 <20180815190816.GA26521@tor.lan> <xmqqtvnvh12u.fsf@gitster-ct.c.googlers.com> <20180816140312.GA6102@tor.lan>
In-Reply-To: <20180816140312.GA6102@tor.lan>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 16 Aug 2018 17:42:57 +0200
Message-ID: <CACsJy8AwfFNJp56rdmGe8ZqZhjCeOZ16i8YX6AhSwJPHg=1EFQ@mail.gmail.com>
Subject: Re: [PATCH v4] clone: report duplicate entries on case-insensitive filesystems
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 4:03 PM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
> check_stat is 0 on Windows,

How? check_stat is 1 by default. And "git init" does not add this key
on new repos.

> Now back to the compiler switch:
> Windows always set inum to 0 and I can't think about a situation where
> a file in a working tree gets inum =3D 0, can we use the following:

I did consider using zero inum, but dropped it when thinking about
checking all file systems. Are you sure zero inode can't be valid?
--=20
Duy
