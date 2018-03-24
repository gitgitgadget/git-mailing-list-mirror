Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC631F404
	for <e@80x24.org>; Sat, 24 Mar 2018 04:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeCXEbt (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 00:31:49 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45735 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeCXEbs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 00:31:48 -0400
Received: by mail-oi0-f68.google.com with SMTP id 71-v6so12008455oie.12
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 21:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hackers-mu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZHaQ8h5SY6YXo+atDqzH2SCGxwBj7qtQnlek6YYLKAU=;
        b=MVMpWzNkZysEthJdHvUx+nBMWdRcOqPGhpB9SF0HPHzNk2+V1ORQzVXvH+LhFcyU/b
         y4Qdl1I50KcbvTwu09gk8ZPn87a9Znhisgq8SGKA9R41ZrjbbSfkmPDXM4UwsYBqwHO8
         xuHlzIhBWtAPg1KcqGiKHsUE+MLLJskyFj4Bdtg7lg4HErOOETdGStwaL7yoJQJy2Pc7
         QbQ8mlack4Hx4F04apG94Mxcx42+O+Naso73ddT6Se7HMZiudv8r9OvCBzGhGJAcsLkg
         Y9LZz8NHbOrh6wF9IjOYgxbTdb6TIA9fntQCauZj6LO0GBdrjkJuNrkpKZW2o7W43sSj
         S3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZHaQ8h5SY6YXo+atDqzH2SCGxwBj7qtQnlek6YYLKAU=;
        b=kRaWIXVPiapSB/yDZ0A761fO007C1fyyfZ/KqFXlLgWKl5RtvsXM6zZ7ts5zUq9JyN
         4fQ6rPq4mpW8vemgsir5dt+mtJVVHxUsvWqR/+twU8WtbdZf4BJhpxqHaS68dRYnEDdA
         ul1FS50qOWIIWwHbpd027jnmR4wxXCOBKbe6dnAHS49wnhXcwWV0fLzsmv5N0iQQmQZd
         DHEhrIPGxpxGNAyLuVlvcc9mNxPTY0tXLnSKfDDQkbYKYmqF11nRCrFzaS6wWute+CNj
         Kdlk3iG60xKlLQPLJj32mjyvuUtpA0c2XeTU77Firc1RaJAp9yvFwDv1KQo2o9fxeRAG
         yMMw==
X-Gm-Message-State: AElRT7EWwVczzEY3jS0OmD/o81MYNwsei/HbyNLHEawC69tBkI+nzH/j
        RfJlt10BDiuUavK+aEeXlA4IIbnc3zXjcm+fzNYupw==
X-Google-Smtp-Source: AG47ELsTWjAnIm6SLTvU88g065VaXyk9I/K/LlxEv24anbrLAZapv8HbU5nq/4P1wYu8UA4Z/mV5AAuBKPKLo+ERRaA=
X-Received: by 10.202.80.200 with SMTP id e191mr7382539oib.269.1521865908170;
 Fri, 23 Mar 2018 21:31:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.197.137 with HTTP; Fri, 23 Mar 2018 21:31:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1803232246020.16250@tvnag.unkk.fr>
References: <20180323193435.GA21971@voidlinux> <alpine.DEB.2.20.1803232246020.16250@tvnag.unkk.fr>
From:   Loganaden Velvindron <logan@hackers.mu>
Date:   Sat, 24 Mar 2018 08:31:47 +0400
Message-ID: <CAFDEUTd_t554b=7xWcO=bY21YTRfbz8SwLVjEmdbCRb=56v6FA@mail.gmail.com>
Subject: Re: [PATCH v2] Allow use of TLS 1.3
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 1:47 AM, Daniel Stenberg <daniel@haxx.se> wrote:
> On Fri, 23 Mar 2018, Loganaden Velvindron wrote:
>
>> +#ifdef CURL_SSLVERSION_TLSv1_3
>> +       { "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
>> +#endif
>
>
> Unfortunately, CURL_SSLVERSION_TLSv1_3 is an enum so this construct won't
> work.
>
> Also, let me just point out that 7.52.0 is 0x073400 in hex and not the one
> used for the first version of this patch.
>
Yeah, v1 patch is broken. I'm sending a v3 patch which is properly
tested with OpenSSL preview alpha.



> --
>
>  / daniel.haxx.se
