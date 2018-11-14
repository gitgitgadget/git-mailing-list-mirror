Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FCBC1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 05:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeKNPeT (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 10:34:19 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41233 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeKNPeS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 10:34:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id e22-v6so7299177pfn.8
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 21:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=aTOAK9UZR3C4jc6JTjdByTOCsDB3RVqpkpPV5vE5B24=;
        b=ZH3QWQRO66A0gBMiJ1yOB/O24OWBZRncc7gKh+TjiaQGLN/EV5gspL15XuLnRVgKCw
         CRr3IyJEibkQnahG1m4wFbD9qgnhuLJePSrLAFYK46GXLqevIDDOx0554Z96DHqmbl+O
         uGG/cweLP3qS69bEFJhHeq4URVLnWkWnXdv7U+YR6lhoKFReTbuHiwWpoeslBGiQnfUR
         m+RBAEq7kr7ddFGR67qjrSqJixrGoVl1C83ZowTLD09xWIZJkWNGibVt+4j1gGmvkODx
         H5uNyucsioDKGQeUj/Z0hii5xE4ltwSisx8vqPQjg/t92LoFOUIDSuk6BdGlTeVS68WW
         Hp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aTOAK9UZR3C4jc6JTjdByTOCsDB3RVqpkpPV5vE5B24=;
        b=ndMQrJVEofC5cop7LjwCrejK2UMHNkL9eduepmreNy9G0c8VOjSCi0u77yPKp3kqRR
         /B5G/jbS2UbZe54Fc8cxiLcGtlNCz/20gIi2PWL7F29r2rJynqjqt7VhZz5NM1NVNDMV
         WDytBbSJNEwQAEZdvD7HmFI52hNuu6UNd4MwTDKpuu/40oE7GApFhSh15byd/JZkhTrx
         HfQcu7Q/ZJO2w/I7n4oFrp2PXmMmSMi6DngzkCLtNV+B0POjXRbe3YPwAbIyTXLT7eNt
         ubiCZXNJjGP/6QIoMS8b5x9lVox2NPbHVo10rOoHFOMFx/zjWCwTWRIl2DcJ2wBMtMbk
         n1Bg==
X-Gm-Message-State: AGRZ1gJpXPG2+G43dwqjersoicVsHmnpyzb0Op5qoA4trqR7yE4VOTAj
        C/bQfTRycAdnWc9njmkjQtieLFJoMhI=
X-Google-Smtp-Source: AJdET5fjdmTOEy9A3PaltJsT7aMuJgb+jI07kDcG6faA0btthlsFqvhgNkzkwuNSuxgNRSU5QwrKyQ==
X-Received: by 2002:a63:dd55:: with SMTP id g21mr495978pgj.86.1542173557717;
        Tue, 13 Nov 2018 21:32:37 -0800 (PST)
Received: from localhost ([113.185.22.242])
        by smtp.gmail.com with ESMTPSA id 186sm16827834pga.36.2018.11.13.21.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 21:32:36 -0800 (PST)
From:   Danh Doan <congdanhqx@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, mduft@gentoo.org, stefano.lattarini@gmail.com,
        kusmabite@gmail.com
Subject: Re: [PATCH] git-compat-util: prefer poll.h to sys/poll.h
In-Reply-To: <20181114014307.GM890086@genre.crustytoothpaste.net>
References: <20181114011043.27419-1-congdanhqx@gmail.com> <20181114014307.GM890086@genre.crustytoothpaste.net>
Date:   Wed, 14 Nov 2018 12:32:29 +0700
Message-ID: <87h8gkrzpu.fsf@congdanhqx.xyz>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> - t1308.23 is failing because musl `fopen` is success when open directory
>> in readonly mode. POSIX allows this behavior:
>> http://pubs.opengroup.org/onlinepubs/7908799/xsh/fopen.html
>> [EISDIR]
>> The named file is a directory and mode requires write access.
>
> Does setting FREAD_READS_DIRECTORIES fix this?

Yes, setting FREAD_READS_DIRECTORIES fixes this.
And, `configure` can set that itself.

I blindly followed the Void's build template which explicitly unset it
in the configure script without investigating it.
My bad!

I'll send them a patch to fix this downstream.

> -- 
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

-- 
Danh
