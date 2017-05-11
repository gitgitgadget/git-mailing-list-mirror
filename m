Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B30F9201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756096AbdEKUKT (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:10:19 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34755 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754763AbdEKUKS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:10:18 -0400
Received: by mail-pg0-f49.google.com with SMTP id u28so19653357pgn.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8ghYL3kLSLFSYDDnESsJEiHrQxpkzYcOrUFHHkcNP0w=;
        b=ttrjipQAsIqjdca1ZRQZTgJVy8Aym/ZmoFyzvFtrLVLz8N7MM4n1+c85YwizX0sftY
         axAqVnRuiicr8nl99p9XkrFgMRX6U4quv2YZw2+eHNaPo/U3QSmGpDtiB95UC74Ycdld
         GpHFz/bXU0ipQQuNlNPmu+LzVM9QEX2y4V6f3vWQvF2kkqBT3GWVS5ns1kPr8y/vn1By
         yVyeXj7UDiBLHYXWMp+/h7LnaPOOgSzwgthzALHuUUFhYv8vRiW6Ds3XsdhlrMRbNrsa
         CSqRvvq4V4gowIH64fXlHHELWXRH5OylWgllG0e0OHd9FSGx9f49INtYvw0HjH71UZzN
         kRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8ghYL3kLSLFSYDDnESsJEiHrQxpkzYcOrUFHHkcNP0w=;
        b=JBTUSbdiuGXym1RGbh9Oc3Ef+vZcEnRk18/aY4sDmPQ4L8m6taLgAX9wZZVsNdOmhR
         TtZ3gQfwMolpxOOCdfYeeABgRqv2A88Ybi7G06mhTv3jnyfbRwtVjjPgw7Ao1r6Jpv9Q
         WqbgfTWPj3n4lYrXHaq0GaNmk+iYSH47yLd3w8jKASwjqKGJLpkaGOy7e9iBbQQglsVB
         qdanbQWSPJJDUAMSwm925JJkp6TfVIfnAq5eaBmegzkUV/xQbJpYL7zR9IhKgZDnNv8j
         uOrn0QBmT7dF79UiQ5lybpjE3i8cdDUZgWVySKkSCjrLciS2N5eg2Ud59m7XYp17AsvS
         yn1Q==
X-Gm-Message-State: AODbwcC7Wy9pZOrIDWX2uhq+09ItEybKjX9473dmD++Fis1BPIN+j5fC
        2ym07aPMx2/+7Q5u
X-Received: by 10.99.157.138 with SMTP id i132mr292708pgd.87.1494533418037;
        Thu, 11 May 2017 13:10:18 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:938:3d1d:44aa:d816])
        by smtp.gmail.com with ESMTPSA id p6sm1624408pgn.9.2017.05.11.13.10.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 13:10:16 -0700 (PDT)
Date:   Thu, 11 May 2017 13:10:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 22/29] grep: change the internal PCRE macro names to be
 PCRE1
Message-ID: <20170511201015.GG83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com>
 <20170511091829.5634-23-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170511091829.5634-23-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Ævar Arnfjörð Bjarmason wrote:
> Change the internal USE_LIBPCRE define, & build options flag to use a
> naming convention ending in PCRE1, without changing the long-standing
> USE_LIBPCRE Makefile flag which enables this code.
> 
> This is for preparation for libpcre2 support where having things like
> USE_LIBPCRE and USE_LIBPCRE2 in any more places than we absolutely
> need to for backwards compatibility with old Makefile arguments would
> be confusing.
> 
> In some ways it would be better to change everything that now uses
> USE_LIBPCRE to use USE_LIBPCRE1, and to make specifying
> USE_LIBPCRE (or --with-pcre) an error. This would impose a one-time
> burden on packagers of git to s/USE_LIBPCRE/USE_LIBPCRE1/ in their
> build scripts.
> 
> However I'd like to leave the door open to making
> USE_LIBPCRE=YesPlease eventually mean USE_LIBPCRE2=YesPlease,
> i.e. once PCRE v2 is ubiquitous enough that it makes sense to make it
> the default.

I know this isn't what you initially wanted but its probably the safest
option.  Thanks.

-- 
Brandon Williams
