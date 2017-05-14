Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17DC220188
	for <e@80x24.org>; Sun, 14 May 2017 02:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754396AbdENCMT (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 22:12:19 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34839 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753628AbdENCMT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 22:12:19 -0400
Received: by mail-pf0-f181.google.com with SMTP id n23so41722941pfb.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 19:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e/Z27cXJ+DFWKR8rfNxPPEY5qpBaGa7UK9wdbWOMU5M=;
        b=PDKhKfsgPTDGGTKgGsyPGKlAHpj1E9gDJDAfM3wX5BfKEWGyX2MgFTnmLXVX5ZEHEC
         iua87jqXeVWSRvSIUl9Itlvuvh6lPiRFeTXxhYbQoqSP5/l//FR8aP1uL408njniLizf
         rjKPUF34DujFbC36u4CqojfVHPUmV99Bmp17a1YIZPQNFU9hUidgeHwRdEk8jRBktFtV
         jo1GuvZ2TtLWjpkkuxpD1ph1HU9Vz8qjOfTUvHdHBKT/Ljibt7/QB2PK+h1vSwibcjhA
         7qC5CU/tCi4tTAak+yDZqyCLmewqxcbeC6goXMwYktCp03Ya3TUi9vTLbpFDn5aLFper
         rmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e/Z27cXJ+DFWKR8rfNxPPEY5qpBaGa7UK9wdbWOMU5M=;
        b=IcIM3xoB0r5u5DJkJriuPXRnXo5uNY173J1gauPFA/wvnu8HmDFc9ylRf+oZ9P9rsP
         sqdoKd8nxUSM49dgoFbSwpSF0yrn5Bzrmr8fmeiZncdA6EmzbUltXgJjt7xHwbqlgNWs
         s38nqqG0vC2DBeKqOK044XxDpbwy7nIP+5S4zdmgpDYuB3kdiSbuofiYux/kfl/Mez45
         2sPVwGY4kgauGEOwZxUpqkztio3sj3th2jnlJRYpb3G9Lb9rIcMTxlSOP6VZcsCpZC3Z
         449cwRsz8JY5Q2sCoXEc9fdYUUXD4OOTZE1ARzRq37KzF9jxcaCtpDw5RFjcIYixBy93
         TV2Q==
X-Gm-Message-State: AODbwcAK50KiLLcNmCq6XVe9cRwI3HO4cBFYEmHlwLmp1Q0SuCbLx9Tv
        yfeOt+/UwA3uklPZnwdBow==
X-Received: by 10.98.108.68 with SMTP id h65mr11498457pfc.98.1494727938094;
        Sat, 13 May 2017 19:12:18 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:8f6:7dcd:1847:4543])
        by smtp.gmail.com with ESMTPSA id c12sm12342469pfl.79.2017.05.13.19.12.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 19:12:16 -0700 (PDT)
Date:   Sat, 13 May 2017 19:12:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] usage.c: drop set_error_handle()
Message-ID: <20170514021215.GA82343@google.com>
References: <20170513034818.h3aaihqmf4q43vef@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170513034818.h3aaihqmf4q43vef@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/12, Jeff King wrote:
> The set_error_handle() function was introduced by 3b331e926
> (vreportf: report to arbitrary filehandles, 2015-08-11) so
> that run-command could send post-fork, pre-exec errors to
> the parent's original stderr.
> 
> That use went away in 79319b194 (run-command: eliminate
> calls to error handling functions in child, 2017-04-19),
> which pushes all of the error reporting to the parent.
> This leaves no callers of set_error_handle(). As we're not
> likely to add any new ones, let's drop it.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Looks good to me!

Thanks

-- 
Brandon Williams
