Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 173CA1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 19:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbfJVTob (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 15:44:31 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:38911 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731703AbfJVToa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 15:44:30 -0400
Received: by mail-qk1-f175.google.com with SMTP id p4so17478318qkf.5
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 12:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KhAcCrm0jpV1eb7QnjQGcAK7dKAFC2LwiH3l5UdND3Q=;
        b=KWjNP0B9hRDuoxvJctZ6BnirbnJMfXDes7xgkCS4rZT7U0v42o5Ch/OD9GPu37HeiE
         65djN1DC+Tlk36tzW6c51aCXg+b0oWlcnt8x6uRW03ssIDNP/fptKtBxt3mPJpMXzBS3
         o3BK3DnI2zWqrPpOE5xttQKydXys2SWCL3I2pj1/V4cHZiLPf9fl8MDGdJSR4ytebwYK
         w5Ow6t9n2pY/CMluZeWS+VqfX0GOhqOnG0XLjjNJmxLS9YxaszcmPvQHJWtlsgoZOOlQ
         TftXrWW4SO/Mfudo/HLUGNA8aJruQ9nIUCjgYlPfyy0H7gEjPIwVcvzf9lEFQ7LnDWNP
         6GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KhAcCrm0jpV1eb7QnjQGcAK7dKAFC2LwiH3l5UdND3Q=;
        b=f4iPnZq8g0EuETng5S3U0A2ij+HLj5uOuzkO3jVCJix7GVGQOH3qhfmV6MMl38FIdz
         e07rkgf/fgngq6nCUbbnRGbk9aNvZk83tNAfTHurU3Ih+2E0kItxNIuJnxbWNrg33+aD
         hvqza76/ngR56zeqs2vvjcOBEkymwOAcEldOT4+oW8RRGPHXs6+BM685te680MHWliUt
         Cxq0MyLh6CwBCY+njZ/idijo2NRV72V44ChHma3P6oubKSP6e/kNwAe/xWUZtD5XlbaV
         GrqG8lUR7yiCzVnNU5WA5YdZM6OuLVrohiZXU/Kx8pBXkJ24Bs6EE+hCnZRXTbGu30EY
         2x8A==
X-Gm-Message-State: APjAAAU9RZh0ErhfMWugsrTnM8dzJ/MO3S+qqpMKC++nZ85rnUxUZbs7
        P9DV7Ds+53+5lE1f6cZ4g1fFzhvVTVw=
X-Google-Smtp-Source: APXvYqzx35KF+wD/d8+R/ElnBcndCIjhqqwm48qKTaZiFV94KiTza+K0N0e58zB/18ymWbUjBP716Q==
X-Received: by 2002:ae9:e50d:: with SMTP id w13mr161164qkf.297.1571773469676;
        Tue, 22 Oct 2019 12:44:29 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:39e3:4dff:5642:8160? ([2001:4898:a800:1010:eb18:4dff:5642:8160])
        by smtp.gmail.com with ESMTPSA id t17sm16821953qtt.57.2019.10.22.12.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 12:44:28 -0700 (PDT)
Subject: Re: is commitGraph useful on the server side?
To:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <20191022165112.GA4960@chatter.i7.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e0e294a7-bd3c-2174-a922-c5893b0945c2@gmail.com>
Date:   Tue, 22 Oct 2019 15:44:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191022165112.GA4960@chatter.i7.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/22/2019 12:51 PM, Konstantin Ryabitsev wrote:
> Hi, all:
> 
> I've read the docs on commitGraph and it's not 100% clear to me if turning it on and generating commit graphs would be useful on the server-side. I know it's going to be enabled by default and automatically generated whenever "git gc" runs, so I'm trying to figure out if it'll be useful for git-daemon operations.
> 
> Thanks in advance for your help.

I've CC'd Taylor Blau for more information here.

I'm biased, but I think the commit-graph is generally really good to have
in almost all cases. I actually do not know of a good reason to _not_ have
it.

If you are managing reachability bitmaps, then most of the server-side
stuff will use the bitmaps instead. However, creating those bitmaps will
be slightly faster with the commit-graph.

If you don't use bitmaps, then the commit-graph will help fetch negotiation
and many other commit-walk experiences.

If you have a lot of machinery around your server maintenance, then you
can schedule commit-graph updates more frequently than bitmap computations,
and you would get benefit by parsing commits faster in the zone "above" the
bitmaps.

Thanks,
-Stolee
