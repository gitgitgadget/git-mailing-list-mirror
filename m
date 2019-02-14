Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AE011F453
	for <e@80x24.org>; Thu, 14 Feb 2019 12:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394713AbfBNMdw (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 07:33:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54579 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394708AbfBNMdv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 07:33:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so6110038wmh.4
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 04:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=C3lVEU1WNbbzkHzcVqjtuznTwRYE5HEUokIJx3Jqf9s=;
        b=QYca+cROJzndhgwG+2F3Q3jKd+F81IkwK8GmYCmdIEBJyZ36lTtqJPBiMjOc7lww63
         FxmPl++yqxstezB1L+fcj1GiVIgdb2GAduu8uejDpzj2GV8yKI+S5HyRikXqW1McpAE3
         U0HRmHuIzIUfRc7lxoJbtMxqu1bI7DjF4JusqY+PM0tk6zbL/xAssgAeU/YGb+HSXSv2
         CQpBZZEbhlTHJ1ivD+t3w5qfLVAVnPIYuhAuzJNSXHtRfECN2mYytnSOf4AF3IL71F+K
         bEdN+kTf+hSF9z40DV4aU+ZrzMsAOzzlYSSSajvScM2y6knFUpIYziNFDVN5qBPrXtAL
         raPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=C3lVEU1WNbbzkHzcVqjtuznTwRYE5HEUokIJx3Jqf9s=;
        b=Rt4LS7atD5J3qKeO5yQVZzorLBgTRr8yUfP322cZPgUEhtIKwehlDYEe+nppai0uvd
         NKYenI63rciBU+o1xAyGuvF4/gx9TmzqGcxV6dWAwxXDuRDAzLJ9j8LyAElr5lAkCbq5
         NgCttSZgR5zz8gAk6TvLuXQef9gfFITacK2OdB+1FXQvMS2lqNOeD0xn0X674/8ABlw4
         Yi+jmXBTLW5f5jebG9V6+R851tE9xHuLSxf0Dxp5ylqWLgvLrV1t7yVtBHRzdxSeDIjY
         zuKjtobdJzB38MI0qYTvJ87grTsZxpjMTG0oALq6y2oKsRoc63hu3pDYg0SqUc5n3PD6
         JJzA==
X-Gm-Message-State: AHQUAubMXKKGmQG+9N4pIW8h84tVb+/ew4FZVZO4nWg89tJd4gMurqGG
        ZH+uGbU8IqnkcHwFKNCIt1KrnReJ+AU=
X-Google-Smtp-Source: AHgI3IY6CMpbmRWmczi8soQ0Mu80RmaAV6VV66FaLxNQUYPH8+nMw0CEiTwkVMnQru4OPdSnsORAPg==
X-Received: by 2002:a1c:6589:: with SMTP id z131mr2492615wmb.120.1550147629787;
        Thu, 14 Feb 2019 04:33:49 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id t18sm2090532wmt.35.2019.02.14.04.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 04:33:49 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/15] Trace2 tracing facility
References: <pull.108.v5.git.gitgitgadget@gmail.com> <pull.108.v6.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <pull.108.v6.git.gitgitgadget@gmail.com>
Date:   Thu, 14 Feb 2019 13:33:47 +0100
Message-ID: <87a7iyk0r8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 06 2019, Jeff Hostetler via GitGitGadget wrote:

> V6 addresses: [] The remaining hdr-check warning in trace2/tr2_tls.h
>
> There are no other outstanding comments that I'm aware of.

Not a comment on this, just a follow-up question. I started looking into
whether this could be driven by config instead of getenv(). A lot easier
to set up in some cases than injecting env variables, especialy if the
log target supported a strftime() string, is any of that something
you've looked into already (so I don't do dupe work...).

There's the chicken & egg problem with wanting to do traces way before
we get to reading config, so I expect that such a facility would need to
work by always trace record at the beginning until we get far enough to
write the config, and then either stop and throw away the buffer, or
write out the existing trace to the configured target, and continue.
