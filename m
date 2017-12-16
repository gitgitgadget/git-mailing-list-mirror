Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E25331F42B
	for <e@80x24.org>; Sat, 16 Dec 2017 01:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755977AbdLPBbf (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 20:31:35 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:33308 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755802AbdLPBbe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 20:31:34 -0500
Received: by mail-io0-f170.google.com with SMTP id t196so4468725iof.0
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 17:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KKx5cM2JT8/WQGKkwSjW+udIkQEqicz4Q4WQvIUt51g=;
        b=TsClIngJE+LGudBki1ZJJOhUt+ZEmQlXFeZlNOFuZPDIXcgRJMgs5OpT0bugRCDVVA
         CgxtY5/aJb+WN7yxyyOSzfLA80aaFiKPpd6vi0HiYVhae2e/5ljnBfSz4HbBH5GclTx4
         UV2uAkMh5Idhj9jYLgWyKYEnRH2zzQCfkl/MSfLykPeGy9eVICU40BjsaWBqVys+BOWr
         /FYBb/4+ujplLxzO9nPU57na91vEsAF20VpFBG7yTV699F2fvzuA7FnVNZDuK8sSdtdJ
         tdcMdUavhadDTu690U/LMPQE/HQSzroQEihTysocD0nYWlqnOdC1NzT23DojK5Kf/y0T
         mS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KKx5cM2JT8/WQGKkwSjW+udIkQEqicz4Q4WQvIUt51g=;
        b=C7EJf9UPNGXDVsafMcSSphFkxlwDkACjIL6X072DbN/nw7K2XIhbJBUzrrj9lYisrF
         wLzbQaexq2iZnAHlJEIrRPYVUyX+Gudjkq+CzOG4PXDIPcgxPrBPZAiWLtqYQ5DF7gXB
         inqKXVLIsIYfk9rXcdhN1/GPNzp/VWoy6rZagEity4lS3vFwD56UfzwNDUdJT67sIDXz
         GmsPkRbGxlHWn/yiMdgJ5Np6MNWPPecO4VoxclWYH/W6mJyTGRBjFjqYKiU4wokDeAoW
         oKcETj+VGRDxtr/bzd0KaDcH4A0mCJM3xv/TZ3f09NtlOITjdnh6wmkefwvgLR4nWyVE
         hQcQ==
X-Gm-Message-State: AKGB3mL6Oq/yTLiKJpiohcHv8Ba2BOO6K2eGIlLUFL9Fpb6h9+Adh2f2
        BOWunGcQQmKXWk1Edlh4V8ePgHfl
X-Google-Smtp-Source: ACJfBouO0TD05kXT9J1JAP45b0Cn6/IxgX8Q78vh6rG0riVzTyOEi5lpRVQxMTQp0vfPzWGVKfos9Q==
X-Received: by 10.107.152.137 with SMTP id a131mr14094029ioe.168.1513387893758;
        Fri, 15 Dec 2017 17:31:33 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g79sm4420076itb.29.2017.12.15.17.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Dec 2017 17:31:32 -0800 (PST)
Date:   Fri, 15 Dec 2017 17:31:30 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Simon Doodkin <helpmepro1@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: feature-request: git "cp" like there is git mv.
Message-ID: <20171216013130.GB188893@aiede.mtv.corp.google.com>
References: <CANaQPdK4xWek3PhiFZrURBBTgPBwsC3d3watd-cWVNBVZRqZRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaQPdK4xWek3PhiFZrURBBTgPBwsC3d3watd-cWVNBVZRqZRA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Simon,

Simon Doodkin wrote:

> please develop a new feature, git "cp" like there is git mv tomovefile1 tofile2
> (to save space).
>
> there is a solution in https://stackoverflow.com/a/44036771/466363
> however, it is not single easy command.

This sounds like a reasonable thing to add.  See builtin/mv.c for how
"git mv" works if you're looking for inspiration.

cmd_mv in that file looks rather long, so I'd also be happy if someone
interested refactors to break it into multiple self-contained pieces
for easier reading (git mostly follows
https://www.kernel.org/doc/html/latest/process/coding-style.html#functions).

Thanks,
Jonathan
