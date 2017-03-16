Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CE2920323
	for <e@80x24.org>; Thu, 16 Mar 2017 22:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbdCPWvk (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:51:40 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34317 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdCPWvk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:51:40 -0400
Received: by mail-pg0-f66.google.com with SMTP id b5so7535291pgg.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f45BNqnhcntA1pW6YE69I1HnJr52fxGNGv+S38KcK+k=;
        b=WBogTlK9rS+yxe52TJSGeloGjAVl61WVoZhQ4aP7xY2qd8Tob4PYkonBOQy0K7yCaf
         UQRfsw9aPxy5p1pNnO1hT2dvZ8B8pb7Ej4uWAM56NI6JyNgLC68W9Aawz/6rNgzD09Ud
         dCtm/JNdY9Pkq98heE7rnFKv+yqihWJu+UtGaHUTUDLL19uxlwuCebm3S7ySJzHR9dD3
         L5CeYWzochjPw2FcOW5+auSKBK4rcWQRRW3gxyy9uuxKVnyzMToUQNCZTbFDcsKHbQ6C
         /7sfnybThzlGyjSpUDMemRou22N76+GgmOr8Ajrpef93Tk6e4+LJJcF08fo6VFWV0rem
         yAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f45BNqnhcntA1pW6YE69I1HnJr52fxGNGv+S38KcK+k=;
        b=L3F3F3wJCcr0QFzkAB7QP+pi9D8rIMFSxyg/TZNavfjr+NHshLBiAq4W9xBWWcDln8
         ot+upt6eUBa/YtSw+OdtpQh2BGECnAVswYwWJ34Uz9aK/ypNY4PSTccEf8VaRuvWAoZY
         O3W2gtOtnS3SNQHfp/wmNFwcIm723T5Yos4enTdcHvv4eCVX0+2pUpF00bHBKbwcny2p
         aTyuP2oXy7oDhmGoC4tBhW4v/jIOLU883N05kir3mbEq+1Iz+QluHRTpQukO6FXLhilq
         Czd7KL++oGNjNz07exQVv+/etlVeAuw1mV4l/ANQlJSLEdAsCLuKZbVtZC5g6FigvQha
         bLnw==
X-Gm-Message-State: AFeK/H0nBZIokZr9lWKEGZNchaau6I+vnAnanWXtRUgHpUjSnB2kqCJkfv7YZusNzMzddQ==
X-Received: by 10.98.80.1 with SMTP id e1mr12688152pfb.250.1489704670941;
        Thu, 16 Mar 2017 15:51:10 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:61c9:f866:d5e4:4761])
        by smtp.gmail.com with ESMTPSA id w20sm12577243pgc.18.2017.03.16.15.51.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 15:51:10 -0700 (PDT)
Date:   Thu, 16 Mar 2017 15:51:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] wt-status.c: improve readability for wt_shortstatus_print
Message-ID: <20170316225108.GB9135@aiede.mtv.corp.google.com>
References: <20170316213619.30678-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170316213619.30678-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Subject: wt-status.c: improve readability for wt_shortstatus_print

Maybe:

	wt-status: simplify by using for_each_string_list_item

	Improve readability by using the for_each_string_list_item helper
	instead of manually iterating with an integer counter.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  wt-status.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)

I like the diffstat. :)

With or without a clarified commit message,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
