Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DAE81F859
	for <e@80x24.org>; Wed, 31 Aug 2016 18:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933949AbcHaSjb (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 14:39:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36552 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933939AbcHaSja (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 14:39:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id i138so8841306wmf.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 11:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PoZX8rKrhRxqv44XPK8LMd1hZzsj1IaOm+y1ufNosh0=;
        b=aAZQUpRC1iLBYgASZEzizVrM0U2V6HX7BdjeQvxBcqjt1PCZMx8CipzpRwNTHBXfrH
         2EFKOAbSDRb7AZ6BHEnpgG7Rzs6NwSQDfWYnnkLU9Y7qXAKr9V/iW4mR/+rWQQY4RZh4
         qU/6F8rQGjMU/iAUNUx9mE1JEEaOcEYxGi6EqqMUYCZKMIzvbT9S/OYpfx/wHISIrWjW
         XbQwjIA5zncswJfwIVu2QW6QeMSO07PF8sewYuf30rCfq5MWDVys9eisWBt+SKQIfyJa
         8AVgGtPLEJE7YsLH0L2MprZXohd0/kDFnnO+drdDCGqIhi9iSLwqwf/YwZNZ1IaTDeIG
         6H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoZX8rKrhRxqv44XPK8LMd1hZzsj1IaOm+y1ufNosh0=;
        b=HDqSCgbcJd3gtwZDvCHMzpDA/EnGWNOKBiagR8ivVtTfLG+ox7DxXK/B8+tb+1j3AM
         FdLwc9vqI6milhuxQey4JuDtlhd6PP0ZoABCjk0PDAZBrgFLvMpjt1i0e6uPTGXEUst2
         PD0YQXLRz+Wn6Ma298FQu7a9uMvNzoqKq9W+5+DSxiXPzpz0ZPi4ipYZC8T2n/0CZ/e7
         yiwout5qEZ13VfyH0CSscSr9Mh9L93+F826q31VR7RFnJS8DO6kDkyQtVfhHAoAmqrHT
         mGB0RgMgyh8TdALgYsHYXRAY2sxY5zIKH1JfQVHQxqwNkt+fsWgMYEcdoD31stPMFGmW
         borA==
X-Gm-Message-State: AE9vXwOHdigMYZD6RM2opXIuNruUStdJmirllsaGVTZ4rf7+2bspXt4e/y5vRKNyT1fX0w==
X-Received: by 10.28.208.206 with SMTP id h197mr22103381wmg.17.1472668769071;
        Wed, 31 Aug 2016 11:39:29 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id f4sm24973987wmf.8.2016.08.31.11.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 11:39:28 -0700 (PDT)
Message-ID: <1472668767.4265.73.camel@kaarsemaker.net>
Subject: Re: [PATCH 05/34] sequencer (rebase -i): learn about the 'verbose'
 mode
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Wed, 31 Aug 2016 20:39:27 +0200
In-Reply-To: <68118621a481d786dd57d5c7fd4c3ea0a8e61b07.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
         <68118621a481d786dd57d5c7fd4c3ea0a8e61b07.1472633606.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On wo, 2016-08-31 at 10:54 +0200, Johannes Schindelin wrote:

> +               if (file_exists(rebase_path_verbose()))
> +                       opts->verbose = 1;

I don't see anything in this series that creates this file, will that
be part of a later series?

D.
