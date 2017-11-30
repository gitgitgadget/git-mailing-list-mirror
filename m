Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5F320A40
	for <e@80x24.org>; Thu, 30 Nov 2017 00:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbdK3AQR (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 19:16:17 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:35833 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752716AbdK3AQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 19:16:16 -0500
Received: by mail-io0-f172.google.com with SMTP id q15so5674952ioh.2
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 16:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KIAcX8MVCbSAJY0otMqwr0LOAnMqrn6c8AdrCxKmVww=;
        b=oyH1tnfxocXI2oKHPSxHp0Q4PhyF9fLBd6tSF64hNM6GEtzoYYTBn+PE1nRML8fqAg
         YqiuVQcsGYmOU1+p9Ldhn6oD/KK832xOkbxHkgt0ublxacDxyglbQSiCqYgCeC0hjqy8
         eZR0ZLsGTNczKpf9y1wV4Qn4xARtoLfqIY8pr1F9JtiTjWBuQUxeFPD7Y5kDoh5f8FYJ
         ECb9pBABVy29MNShNrhpO6WJbyWcFZpf43vmlaXB0+Wu2zjU2xnPRqRJu40htUoHDQPz
         aGkhG7vwJqoaKDXQOnxtZMJh9vnDDmw+O5XqPnTF/GGFTvPVARXeN864X1GM2mxEO9AS
         WFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KIAcX8MVCbSAJY0otMqwr0LOAnMqrn6c8AdrCxKmVww=;
        b=jn58eRWtxRxBOYA81Y8itHRuvG/A+eaIe57Z1h5R3RyPxLL7p8bxFVF4vUeer0z2IU
         AsyZmXb/IemxiDHsD4YnFFpGjUtJyZr1/V9VT/4l6N/dSQmyiKdA2zX4cmIh9bOZvKWP
         ZlKauh2tgVgvg0Bpym62ab9/YObOVGi9Jzz87TkkbyH75nigsgs2lCr14ChR/QkEPcK/
         ONjOeGeG27Bhk1GRPMLKQ0eDQ+HEeHVYLYt71fFErQyiK+zLSCwkA/LDb/ddQKImarCR
         YGwb0As2v+ipJ0Ux+Cbwarjv+0rcCFrIpPcABNCBdeog+LjlwKo5GraTyNexXb/562KV
         Z07w==
X-Gm-Message-State: AJaThX5OlUpLVRxIBZDpKAZufFRRVqgsHRZZGZbGuuWIaAzW2wyP7qlX
        njjf9i+YyjZiAoKCuNZ0xqo=
X-Google-Smtp-Source: AGs4zMZvAsib3ctzn4sRjDDoGI9/QuOj/zECLqpzzZMa1DbjmS/wiO7e6dGtuBPa7uSkSWqtmmMmFw==
X-Received: by 10.107.198.3 with SMTP id w3mr5902787iof.90.1512000975618;
        Wed, 29 Nov 2017 16:16:15 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i195sm1326206ioi.44.2017.11.29.16.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 16:16:14 -0800 (PST)
Date:   Wed, 29 Nov 2017 16:16:12 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] hashmap: adjust documentation to reflect reality
Message-ID: <20171130001612.GE15098@aiede.mtv.corp.google.com>
References: <466dd5331907754ca5c25cc83173ca895220ca81.1511999045.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <466dd5331907754ca5c25cc83173ca895220ca81.1511999045.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

> The hashmap API is just complicated enough that even at least one
> long-time Git contributor has to look up how to use it every time he
> finds a new use case. When that happens, it is really useful if the
> provided example code is correct...
>
> While at it, "fix a memory leak", avoid statements before variable
> declarations, fix a const -> no-const cast, several %l specifiers (which
> want to be %ld), avoid using an undefined constant, call scanf()
> correctly, use FLEX_ALLOC_STR() where appropriate, and adjust the style
> here and there.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  hashmap.h | 60 +++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 29 insertions(+), 31 deletions(-)

Yay, thanks for this.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Follow-on idea for the interested: would making a test that extracts
this sample code from hashmap.h and confirms it still works be a crazy
idea?
