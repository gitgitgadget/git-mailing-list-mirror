Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95D451F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 08:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeKLSe7 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 12 Nov 2018 13:34:59 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33581 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeKLSe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 13:34:59 -0500
Received: by mail-qk1-f193.google.com with SMTP id o89so11942693qko.0
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 00:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ISo5NVVowzW+P97ME1l0c8mHERzJeEuIP7GzOqUY8RM=;
        b=lFq3dbA/kNbnWxjVU2+EV5TU5uVbN8GEpcYZGQGs/P/pKB0MnAQv4UF+uCPzmKSXBx
         3I8F1XBqatz74MOiby7n+tqGWvCAxPFKjCRbYKfdjOLzKdSbG8MJZswDvKMAg3TeXciE
         FCb8VZElhjt4S33bCrvl5Av2cNFI+w0kTpxq0Jo1xhMSMclQoIe5/5mQQUHyTdWf4xrb
         ZIW0YxLBiAJHSdYH4bnOqMR2r2hpatbZd2FjxoY5sTDZhrMptEJ8NdSxukJ3lS2iULrY
         dRZJsB0tQvTIlIOgvpLa9f1hEURSvOzy+OPiiwoFL6mYCjWz3vuqG6EtcPWBBuuTAR/P
         cLlw==
X-Gm-Message-State: AGRZ1gK86HJApp30RVztTEFEABRvwTt3zwIAo3aA+YiO2lfUHwH5RwWu
        0IcrV3E1qSZeiGUdGGYbYhr2g619hF0vR7hfCR0=
X-Google-Smtp-Source: AJdET5eoOASRehXqm/jbNNIlSmUyqLDOUNnioXTRdRl1dvWnbBB2a41sb4dweNpsqAFwE6hraFFpyFNUu2iIlUi/w0U=
X-Received: by 2002:a37:66c1:: with SMTP id a184mr52709qkc.314.1542012168241;
 Mon, 12 Nov 2018 00:42:48 -0800 (PST)
MIME-Version: 1.0
References: <20181112084031.11769-1-carenas@gmail.com> <20181112084031.11769-3-carenas@gmail.com>
In-Reply-To: <20181112084031.11769-3-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Nov 2018 03:42:37 -0500
Message-ID: <CAPig+cRksYnDxTO9mbH-ieW=M24CuU+J42JxTfC8z8fdWZrJ6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] read-cache: use time_t instead of unsigned long
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 3:41 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> b968372279 ("read-cache: unlink old sharedindex files", 2017-03-06)
> introduced get_shared_index_expire_date using unsigned long to track
> the modification times of a shared index.
>
> dddbad728c ("timestamp_t: a new data type for timestamps", 2017-04-26)
> shows why that might problematic so move to time_t instead.

s/might/& be/

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
