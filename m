Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B44CB207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 23:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbcI3XMh (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 19:12:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33804 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbcI3XMg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 19:12:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id b201so195723wmb.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 16:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=LYLnY1DUv+aDq4eCKnjzqXwp67WnMpIoMSillJLDHfM=;
        b=drjLcnmcu7kPlAdOacUIOKKepyd/znISX/Kx7OKatg/R6Yjmw1nfX0CZ7WjjkqmTGb
         nvK9T+FUKh5gCvrapPymGRNfVJ3k7uOYcZEWBRi27REasVXjt9FrwCGOI6AeO5vRUpDs
         bMg15xy1SIoLC4+C8Vi2zjS9wxGxCbMifWKZ0bjupkTNf3QyiBMvFxJunpytWvhf664W
         EZqHOn5it0XZgo+rHzdJGp3LV2pD5WSsPI+7LZ5qEy+Uuzhuh8y0Q8qkMG7pJBltUNlI
         wcKXKoIRYjm/kK90Ogke2O2mbZD5ZLRrrgNbT/aB0PzsPAJjRUmaxLf/EkSHwIUM52Cq
         jAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=LYLnY1DUv+aDq4eCKnjzqXwp67WnMpIoMSillJLDHfM=;
        b=T5ki5N6GbAJSucRW+9f2E/1vf3Z7SK5Hcj6Ss9dNn88U5vS8hl2BUIUJhmx94fX3gX
         gYfCL2bkhWWs3KhxLK7ZRxqFc/ZjpSs7Np4hCYx8QfiWx00//3iPoeUNCEe0tttN/zit
         3wgLkCX0HhgkcABasgktnV7K1imAX9NnA6R5Ts0e74V4PJq8tZOoHDJAEv/NpBGnSGDF
         GL1W9qc1wWOWCGwHEjJglGpCLTVk+9QDsqM5oNcwEa4f3/1oKDgASxk+xRPMG/wToy1b
         9F3X9QRihMnw76f30NTozxziWCU8ae8VHPOx/KnTbdlsIWDj3A/lEInR/CA94RwKA9UK
         knrA==
X-Gm-Message-State: AA6/9Rnj5o7iD6YdkdjZtMghJojkzYiWjRfMOKH1k2gqaQ28TsF5861jvQ7Xfijvrvn2gw==
X-Received: by 10.28.69.68 with SMTP id s65mr6256251wma.127.1475277154680;
        Fri, 30 Sep 2016 16:12:34 -0700 (PDT)
Received: from [192.168.1.26] (afo182.neoplus.adsl.tpnet.pl. [83.25.144.182])
        by smtp.googlemail.com with ESMTPSA id lz5sm21743636wjb.24.2016.09.30.16.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2016 16:12:33 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] ref-filter: add function to print single
 ref_array_item
To:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
References: <20160930221806.3398-1-santiago@nyu.edu>
 <20160930221806.3398-3-santiago@nyu.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        sunshine@sunshineco.com, walters@verbum.org,
        Lukas Puehringer <luk.puehringer@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <0e3cc036-787b-d93b-dc87-47a0826ec919@gmail.com>
Date:   Sat, 1 Oct 2016 01:12:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160930221806.3398-3-santiago@nyu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 01.10.2016 o 00:18, santiago@nyu.edu pisze:
> From: Lukas Puehringer <luk.puehringer@gmail.com>
> 
> ref-filter functions are useful for printing git object information
> using a format specifier. However, some other modules may not want to use
> this functionality on a ref-array but only print a single item.
> 
> Expose a format_ref function to create, pretty print and free individual
> ref-items.

It's now pretty_print_ref, not format_ref (old version in commit message).

[...]
> +void pretty_print_ref(const char *name, const unsigned char *sha1,
> +		const char *format, unsigned kind)

