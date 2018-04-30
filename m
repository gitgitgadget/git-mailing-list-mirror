Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 429B2215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 17:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755043AbeD3RFS (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 13:05:18 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:46456 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755025AbeD3RFR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 13:05:17 -0400
Received: by mail-qk0-f172.google.com with SMTP id s70so7125059qks.13
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=X44cEgF1SDf0crMyvLRKGf+5U9BfDeyiC5L5EuOYbPA=;
        b=nuLWemfXKv8A3L4NWqVWvOY1PD/wAqIA4Wy2rKlvjhEs4qk6bIj2Vd4BywweE2lXxQ
         A2Zf6vD/to4UDWVMLuqPvgXsPYuZlRCFzLChefF8xhMs9lPiTNne3FyM5Cdes0/NUYZ2
         VLImQ11Ty+qUyDUdmxycPIGGY8Z4OeSrgotE2UBqvdONBcoIHTlTgiHHRHa/oFGwjYRX
         Ph0wql3CXH6bOzmePo5vowVYSr8T+yisZcxp5ZWz/Cv207/Opy2YHNyYrt3ODcz13qrJ
         HtGB5hCrJSnCZ9BDAEYQrMXUUGlfmugwdZuW9h6xKgO5BXAuEMfC29M6jm7jcj21DZR4
         j0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=X44cEgF1SDf0crMyvLRKGf+5U9BfDeyiC5L5EuOYbPA=;
        b=LFMeg+qhHENvURVZMre30mIWvgdCPoPXgiDvMcF7krdJQXz+YruQ8x9NAzIc9pLXWl
         ugXdrDwqcKOCT4Tf+mKt+tGpkwM3kNT3LySy7O4a+Q4UPIW0qslY2xmULFZbFYR2alFO
         fRBzk4zSAXvG5M/kb/v0CFANEup4OqS6HcaWWg+djLqnh4WE4SGmKzbtlNCCitBBlutB
         5JwU+JNJ9titvnrrOI95niBb0lpGUlNxSVZlAuoll9Qt5x9Xqea1rsJcFXeLOxcZmeZv
         GvHHBN/vBvACArmQv+Cofmh9B2S3bK4xYnMgxgPvO67vu/czIBKO0J4fpT8LAnN3vZSu
         5/Uw==
X-Gm-Message-State: ALQs6tC0ike43EaBBYdtz0k+uH1uyWKIP0F66M+tSVd+dttxPc5hVnDT
        oBPRet/QIwC6L2w8yV+j2aiAht9kozMWtqQSUOc=
X-Google-Smtp-Source: AB8JxZo3m5AfL9VRhUe9BOv2lCYT+ux7D85R2pt0d/GFxT1EpujtfC9mRQCMgdQyDzbBDe6gGbb53fuU3Frw+IeAjAA=
X-Received: by 10.55.99.199 with SMTP id x190mr10461225qkb.91.1525107916547;
 Mon, 30 Apr 2018 10:05:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Mon, 30 Apr 2018 10:05:16 -0700 (PDT)
In-Reply-To: <20180430142555.23260-1-benpeart@microsoft.com>
References: <20180430142555.23260-1-benpeart@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Apr 2018 13:05:16 -0400
X-Google-Sender-Auth: 1GBZWMdnko58B7NEQ5VjUSM5gFw
Message-ID: <CAPig+cQPk9hj2JqOqFiZmb=Xcdi9P4dy7WUeJaj4AaUUMs10HQ@mail.gmail.com>
Subject: Re: [PATCH v1] test-drop-caches: simplify delay loading of NtSetSystemInformation
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 10:26 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> Take advantage of the recent addition of support for lazy loading functions
> on Windows to simplfy the loading of NtSetSystemInformation.

s/simplfy/simplify/

> Signed-off-by: Ben Peart <benpeart@microsoft.com>
