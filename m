Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B74A1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 11:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfA2LPa (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 06:15:30 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:54425 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfA2LPa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 06:15:30 -0500
Received: by mail-wm1-f46.google.com with SMTP id a62so17373464wmh.4
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 03:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zdmj8cjLgmJjmmYvZFJPrxsu5jMjyXNmyR3Z82OzSKw=;
        b=lCsYvNKI2MXtwbFK0uyBGj7/cXFJq/4ZWeb0nYbesV5VCmxa5WgHbK8WgjKECiRuLN
         zdgw1sRfboR3PEB6Ckkyf38UjRqfDPVIyqFBsJz4K7GNNeAkNXwA1vJf1NXTzIR4Q/48
         J1LcICtNmmB2MIMwlgtAGJa9vUszM/9a0TbIuQXrJ5UaakVsfCYBHkn0kKExQZitubmV
         Y/OWAbJ6yNAg5X5WOkCuwGPCVyisZdDuZq1wADWiz71dVSbUcBr5T/0X1B2ObEGlIaV2
         icacwK53jS76PjEoxBf6NH7+hcplvqS2vOdP2vKbAPgb68onUgJYFWZPwazVnCHPKxC2
         LfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zdmj8cjLgmJjmmYvZFJPrxsu5jMjyXNmyR3Z82OzSKw=;
        b=H4tz262ZgYBpdP45MQCNn2tX9dVTBVO2flzkiztNUWMzQUDXAZc3Ew4i5IAyzpLBwx
         FTv7q8FSdzNdMT6ixlujb15muriq8Oe9fxSyY6B2NNMSqtNg8Lvq8e7QSD0bx9o6vfpi
         GzARoosmTmaaDD9FFxVDAgJTMZH41b22Ew0GDVSm6w3EP+dl8u0o59NFgBgXM+jX7NHL
         Ym/AgDExs/kGp5u6CiiKhZOahPJQkVfs8Qf4GzhPZkt6pyfYXzzFHymBwBKxFhueRMgt
         TtlRJt74nWAuw/dyN9ChSiburykXkTH5shOyX2tXRV3NDletPCj5ZigvvZeA7zGeGWAq
         M7Ew==
X-Gm-Message-State: AJcUukc8+5wf+4wKeAD3r9hIAt3ZNLooGY+N8gZwK2YSzWsmLpAnvizD
        ihfy2WJiDPVF5DheH1PcINQ=
X-Google-Smtp-Source: ALg8bN7ZBOSNyqBp0rMGOhcWCl56XLL+sAr4Ydl3KcF3m463+wFG++aOVIksfF7OR3YwpV9qSJQLzw==
X-Received: by 2002:a1c:3905:: with SMTP id g5mr20148577wma.30.1548760528512;
        Tue, 29 Jan 2019 03:15:28 -0800 (PST)
Received: from szeder.dev (x4db3778b.dyn.telefonica.de. [77.179.119.139])
        by smtp.gmail.com with ESMTPSA id n9sm93266269wrx.80.2019.01.29.03.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:15:27 -0800 (PST)
Date:   Tue, 29 Jan 2019 12:15:19 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Stefan Xenos <sxenos@gmail.com>
Cc:     Stefan Xenos <sxenos@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/8] sha1-array: Implement oid_array_readonly_contains
Message-ID: <20190129111519.GA14183@szeder.dev>
References: <20190127194128.161250-1-sxenos@google.com>
 <20190127194128.161250-2-sxenos@google.com>
 <20190128130513.GA12887@szeder.dev>
 <CABh8og41XhiYzg=X3to7M+zWszJq6a+n8bwHrwkU-GoxYa8-VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABh8og41XhiYzg=X3to7M+zWszJq6a+n8bwHrwkU-GoxYa8-VQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 28, 2019 at 08:42:23AM -0800, Stefan Xenos wrote:
> Is there a linter script I can run to check for such formatting issues?

Not that I know of, I just happened to notice it while looking into
Coccinelle's suggestion about using oideq().

