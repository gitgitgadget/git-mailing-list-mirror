Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EA081F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 10:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfJaKn6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 06:43:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45408 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfJaKn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 06:43:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id q13so5652307wrs.12
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 03:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EEYUybuiiREm+hBgiTGUaZ2yiQVnKjLm1VHWRj+NEr0=;
        b=VUu9m3R0/+A4Wvg4Dl9FjKYACeaR1MYxEQrIBNReegMkHhR69xR4g4OPTB8JmyR9t2
         C0QcDXHBq1ZN95wUjc8Bj1WXToKhRJERiqrqnlcTMOI6nRdukXV4NPYi7Amlcg/SLckj
         G/yc2nmrkCNol0SuiBMdO4onOl/vhTRV/+GpdNh7VsdMKI/ty1vKzGeialJOSeim1gdL
         KEoGYAdJpy8xAaaI+xSt+puNFQom/4he5Qr0j5keox5yjNp/ArxKHxjkPvuTXNXznXHo
         gwkA2mF/mqghA3QLoN15MpwUr9qYnypHwfKsplNowLdJ20JrMiqDONSbaB7uQaev/Rxb
         y9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EEYUybuiiREm+hBgiTGUaZ2yiQVnKjLm1VHWRj+NEr0=;
        b=KFZhiJjZb3wuJ4V3jl5Ffwy1Ujc9MkZZoFmuFRdVxl5zJLMKXkfzQGcpgJTOlbY+2Q
         MKTCJ+dGftHsiUQuPreWYv7ZQZkOmg7u10k7PcekNa/TSrBOnhN02v5PX9vJNcIgia/T
         vznFiBZhQ+KG49K3tsopsEL/0CXo5gjrqJ7/IB6WQeWTWa2vdxcoyMOqVm7P9GjzwF/f
         Vnj+NpBkaMdRHv5VFMvcQiiKsgJ0Xm0tvqf5vjxmSKjeceSJr6NQjsNNwcTAsODrKv/L
         YqAMSvGTruOajrue9Z+4E+U34JSRHwmS2SQ7p0qb81TLNZkZPbBTdXLmvhiKOO4W7PsH
         T5Tw==
X-Gm-Message-State: APjAAAXnS+Y39gP8fwOfVgdy8L0odi5knRMSkuipfBx5Qf5AL4ktWgTa
        hIW6S2KZsbU0gxxq7ZuLuKDYNpMmfxc=
X-Google-Smtp-Source: APXvYqzvE4TZ0f2Ve3a4gsIWGro112J7cIBseYdgSSZhKcWdW/02ZL/dJs3ASaYGJBB5eY7Jsq7kdw==
X-Received: by 2002:adf:9381:: with SMTP id 1mr4886031wrp.10.1572518635850;
        Thu, 31 Oct 2019 03:43:55 -0700 (PDT)
Received: from localhost (host96-200-dynamic.171-212-r.retail.telecomitalia.it. [212.171.200.96])
        by smtp.gmail.com with ESMTPSA id c14sm3244728wru.24.2019.10.31.03.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 03:43:55 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:43:53 +0100
From:   Davide Berardi <berardi.dav@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Segmentation fault on non-commit objects.
Message-ID: <20191031104353.GA92289@carpenter.lan>
References: <20191029092735.GA84120@carpenter.lan>
 <20191029140621.GC2843@sigill.intra.peff.net>
 <xmqqbltz3qbc.fsf@gitster-ct.c.googlers.com>
 <20191031053733.GA10050@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191031053733.GA10050@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>Davide, do you have an interest in trying to make these code paths a bit
>more robust?
>
Absolutely, I am writing a patch taking in consideration your comments.
I only need to write a test routine then I will commit my new patch.

>-Peff

Thanks and sorry for the silence but I am learning from your comments.
:)
D.
