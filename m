Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEADA208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 06:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbdHIGyy (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 02:54:54 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37763 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbdHIGyx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 02:54:53 -0400
Received: by mail-pg0-f67.google.com with SMTP id 83so5139590pgb.4
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 23:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=721YCQ8MKL/J77xUAotoLfPVduiw1XfWhtgeGZv8Sx0=;
        b=kNOC+au+zPKs5dAUs6NiOoR75i+PhwqQugfB06DRWr6FFGf985ZPSsIVEbUayu8+7h
         HthLqlKkxTAmV/nb6RT11EmHNutslGyQHbwtsmynsryd7WqfZr5YjeDidQSQAeyMo2Tj
         cfgHaTJ1jyqK5FAZRE7wAf1KS8MilBMaKvCAZOfkLFjXLfi/3vpTxxrNueD9Gj3LSpnL
         ukjLbbl9HNPyE9ZvLH11bfTCi49mJ91sikc9JXd5SgvhX9rkbGex9l+hBmKcdP2b4Gpi
         Lem6VsVPFM94R5502F+mmNJTOmBBFK/jdYLuu76nbHGuBhnBM9+WVR+aM13VIrVurBl6
         s+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=721YCQ8MKL/J77xUAotoLfPVduiw1XfWhtgeGZv8Sx0=;
        b=VKrPV2EshD6qo2v8N7BEy4UO7QLSIOcPZjwo6SFFcsW0TDA2K3Qs2zD/HWCKA4VtkT
         Od/mNvcnpINe1wAMp+o6dnijvSpy69YrdRvt/nj6d3nj5umpmBMDMNOz5us75Ddm7Rpf
         7Si4aMhbEXtEzMUfJgtJ29qckfxaNX8VKlDcoMR/c5JDxfsdU7hE8LhL38HQadiulFMs
         AtF8O2X2j3mejq6qdc1AMhVHmo/d0Zk0tJd4LnD1X4/uCRk0VzFurjzJU7Z+nt49chsy
         lXpNS2SvqZhxMGTj3oh5meskLMMjZcWtqjhVD/2QX5zGPlk5yW/aKpEdUqYsivrR9hCs
         h61w==
X-Gm-Message-State: AHYfb5hv0+dvhuZmSEwyH3A5WXobcMqGW+sZMmoCTLlO2h1dQG8Zwdif
        WwrPxs3mtuGXzQ==
X-Received: by 10.84.215.205 with SMTP id g13mr7779824plj.8.1502261692656;
        Tue, 08 Aug 2017 23:54:52 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:38c7:3176:1f11:8acc])
        by smtp.gmail.com with ESMTPSA id h14sm5757761pgn.34.2017.08.08.23.54.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 23:54:51 -0700 (PDT)
Date:   Tue, 8 Aug 2017 23:54:35 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/add: add detail to a 'cannot chmod' error message
Message-ID: <20170809065435.GA29220@aiede.mtv.corp.google.com>
References: <aa004526-3e0d-66d4-287f-30abd29758fc@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa004526-3e0d-66d4-287f-30abd29758fc@ramsayjones.plus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones wrote:

> In addition to adding the missing newline, add the x-ecutable bit
> 'mode change' character to the error message. This message now has
> the same form as similar messages output by 'update-index'.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> This is v2 of the earlier "add a newline" patch. Thanks!
>
>  builtin/add.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
