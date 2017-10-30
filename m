Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7591202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 20:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbdJ3U4C (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 16:56:02 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:50276 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbdJ3Uz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 16:55:59 -0400
Received: by mail-io0-f194.google.com with SMTP id 97so30304656iok.7
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 13:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BtJhuSnC1IOmq9RmOj/E+ugTT1xDdohTvdIsAWj31VQ=;
        b=awN5hwfnLS47wk3NQSmaL/lVQMu4zWjAjHDDLiv0XUKr8taLGUYMNTgrUxQyTcOVeY
         cEtD4Yx9PA/dO/N0GsxgezsyshtNgscc90FS3rumMUcHqyknsQT4i97GRLUtKksLQwIU
         3J+YcA4gWgp93+Sgr8hJ+kh2aLJYk7k5PYJ+VNXa8XSK4D9h9Ean4JNJ2I3v0c5XqABD
         2IVDqX5jzNtipOJQmtRjTFRNSzMjsvS1oNpISS3peTarNyBzdCT40nuM4LM/7d6w1yb4
         lnoopxiCdmBHDmt5/Tg1thEbuqgOFLrUrSG2K2aITwR6rDATZd/vcTjfJH/4y1DvD2sF
         L/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BtJhuSnC1IOmq9RmOj/E+ugTT1xDdohTvdIsAWj31VQ=;
        b=DlxaEOEYFez2taMLwy5T9lsx5VrgRSMCdfIvruMRxwHb4Xgainhwtsr70ZEddpjB2G
         fWxo/inZ2tc4OAtza/kxdo+fgmH7qkdwC/J2scJKSw+UHl4QBOJXGUMz4Z3Rpel3ZaII
         fTMczTteyt4MXC+7PXwngsbpzNNEDnMFuCajlXrAMw26G9+nl3hRKzScioRpj0MsQC61
         iJrC3PSpcWjyTk293Tux46ksVSaZcjUnrYYue/JlIoMAO62DZr3g18bVWXUmiP93Ceip
         KQMfGedGYjpRe8L0WIoa9lyR3FeetzDaJ+oqrlyiJDrrOvM+BAM5k1OIenTSDGNeNo/a
         bRpQ==
X-Gm-Message-State: AMCzsaXsjTRf4gGSbn4O4tkCW3alhG3F68sTPEq515QNDZd3kQWL/TNQ
        RXTnmaMAHsEZeGd+hlq/wDtRBIUe
X-Google-Smtp-Source: ABhQp+TmV9JH2xyYl7m3vJY/NbjCrORG0rpf4eub4u9xIGnw1EHSlcDbbnwe1V3JdxHOECEHEsH3EQ==
X-Received: by 10.107.131.147 with SMTP id n19mr12367441ioi.87.1509396959149;
        Mon, 30 Oct 2017 13:55:59 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id m141sm59774itm.12.2017.10.30.13.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Oct 2017 13:55:58 -0700 (PDT)
Date:   Mon, 30 Oct 2017 13:55:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] mingw: introduce a way to avoid std handle
 inheritance
Message-ID: <20171030205522.hur26cumwusk7wwa@aiede.mtv.corp.google.com>
References: <cover.1509382976.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1509382976.git.johannes.schindelin@gmx.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:

> Particularly when calling Git from applications, such as Visual Studio,
> it is important that stdin/stdout/stderr are closed properly. However,
> when spawning processes on Windows, those handles must be marked as
> inheritable if we want to use them, but that flag is a global flag and
> may very well be used by other spawned processes which then do not know
> to close those handles.
>
> As a workaround, introduce handling for the environment variables
> GIT_REDIRECT_STD* to read/write from/to named pipes instead
> (conceptually similar to Unix sockets, for you Linux folks). These do
> not need to be marked as inheritable, as the process can simply open the
> named pipe. No global flags. No problems.
>
> This feature was introduced as an experimental feature into Git for
> Windows v2.11.0(2) and has been tested ever since. I feel it is
> well-tested enough that it can be integrated into core Git.

Can this rationale go in the commit messages?

Actually I wouldn't mind if this were all a single patch, with such a
rationale in the commit message.

The patches' concept seems sane.  I haven't looked closely at the
implementation.

Thanks,
Jonathan
