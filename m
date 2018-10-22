Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F3E21F453
	for <e@80x24.org>; Mon, 22 Oct 2018 06:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeJVORt (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 10:17:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37194 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeJVORs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 10:17:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id g9-v6so2164887wrq.4
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 23:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=M94GLFjg70kDwVNAIrytEBxbt0mjbQQlkDgxWdoLenA=;
        b=Q4Ew8KKvsUjoFk66dhj7zHBe9/th5AGG67ZtNXEpOlqq5/vtUbA8fPnQQRfLCvykUz
         QcZDhjm4ECn1R7vXeHxN5eQ0KAz22p0NTr5F5W+/bdm+JiSayrPk+JUNvlEx0sQF17N9
         korgui74xCQ+K2deK1uwcuApG0uUKLr3iJ0N6YgO4UgULn/chIVyZ2DxB0mC514HG0Ir
         +hDy8y5aE09kmJYscevgCY5xbjK1TiWjNEEis+MwzlrkCOIbmVzgwT8UKzH4p7mWygZo
         zsL9s6927PCPIiV5voP5hsEQ/ql8vcbL+UKAqnzaW+rSaPbT6xXEhz6diAQsQ/S932Y5
         kQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=M94GLFjg70kDwVNAIrytEBxbt0mjbQQlkDgxWdoLenA=;
        b=lQwZOkUMrXq4BIv0LZEPuT6A2DvxTo5TIHRlpSyy7ke50vYHYA7wAcQPqS6vtU9Se5
         rWj8Ls6Xfeeb+/IMqqYmgQ+5fR9LOUUY3rKpRZzqUcC6fM3zgvcpXxigPt737w2s8HNc
         84Mkl2Ha7kTK7BUNlHRuznO3+vP91Dd38z1FspTjhSTdE0sjtI+PYvc8xa3NzJBHGFSo
         CmI82KzdXmhn63ViYrGzXz+hshKpux6YD1hho37M4i0uLLYd8TKQH7VwvpHjms5fkZYn
         sp0B1/MJD4yxy0B0LwQUzfbU28kY3QQEZpPx/rmkPYYc6i8OL9k2ZtGebITxV9u+Whxd
         4HUQ==
X-Gm-Message-State: ABuFfogOuYO8v76ezFy1v9xKrD+l4ktrTrEBacERi2ftbLfGwJyc0mXS
        HewgZlAStGge7YJ9G81eiAU=
X-Google-Smtp-Source: ACcGV61pTp2IOqRlGh8eXc9K1uUfkCzTky14bTVRVPTFe4sQCxsAxxQmhaBiGY+wO0sWBwXJ3QPgwQ==
X-Received: by 2002:a05:6000:1284:: with SMTP id f4mr22630297wrx.140.1540188043638;
        Sun, 21 Oct 2018 23:00:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h15-v6sm2862536wrt.76.2018.10.21.23.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 23:00:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH 1/3] sha256: avoid redefinition for MIN
References: <20181022053605.81048-1-carenas@gmail.com>
        <20181022053605.81048-2-carenas@gmail.com>
Date:   Mon, 22 Oct 2018 15:00:42 +0900
In-Reply-To: <20181022053605.81048-2-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 21 Oct 2018 22:36:03 -0700")
Message-ID: <xmqqo9bmv7ud.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:

> it is already defined whenever "sys/param.h" is available
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  sha256/block/sha256.c | 2 ++
>  1 file changed, 2 insertions(+)

It is a no-brainer to say that this is obviously good.  I'd rather
see this become a part of sha256 topic (perhaps squash it in to
eliminate the need to have it as a separate patch), though.

Thanks.

>
> diff --git a/sha256/block/sha256.c b/sha256/block/sha256.c
> index 18350c161a..0d4939cc2c 100644
> --- a/sha256/block/sha256.c
> +++ b/sha256/block/sha256.c
> @@ -130,7 +130,9 @@ static void blk_SHA256_Transform(blk_SHA256_CTX *ctx, const unsigned char *buf)
>  	}
>  }
>  
> +#ifndef MIN
>  #define MIN(x, y) ((x) < (y) ? (x) : (y))
> +#endif
>  void blk_SHA256_Update(blk_SHA256_CTX *ctx, const void *data, size_t len)
>  {
>  	const unsigned char *in = data;
