Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEBA61F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 11:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfJHLvr (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 07:51:47 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38899 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfJHLvr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 07:51:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id u186so16384599qkc.5
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 04:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sSLapddjd7X3ODt3JI1vgxPnaK7xFKOhNjx5m4V8wFQ=;
        b=s/yw2FeyfAcvwV6IQNh3Ntl4sw5lsIzaAFFJ0oiFsZ0qLz5dmoPe1FQjAl3g9iiXln
         /RNC+QORxU/LIc3emrTpHZOgd7e62w6Gp/Ci45T7qMpVwQdvQLaRSXaAFyPVWzASLcyb
         BiKV+5aZa9pDc2stkiEZ5swKS4U8pDG0yE1MHAAc7lLLIBHT/+yyGL8vlF6uUGbeCuNc
         23skS8eYUvEL6DKZ7VeILRu8e+7b9KS1Su2+3dhlYy5i6tvhf7w8OkrhiPTDEkCwjhb6
         1103FRqiafitvyddGQx1kfcVNaTUrqyGQloBlYNBgjAgzLE/I0SpJT2QTCo1UDP4imyf
         xkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sSLapddjd7X3ODt3JI1vgxPnaK7xFKOhNjx5m4V8wFQ=;
        b=AnPvnZv92gYC2KoUiwWKpgkOqxGu/wv9cxEjyhm2BViXg72JoAIn/oiExQ8HtOHc/Y
         9EG5oDnFF6VccEtekZYDsyBSkZLlUQNjceJp0ct4gEZJ+TH7cB2LSdu9lWnCwQE6ErKG
         yMDpTccY4oJe8rxi2AV0IB5eDoKD/EoreK4Rs4xwd44T2DzvBeQofxBJQajqBesKy89r
         qEwAfMTdU3GvSxEyV8QIGlKn4SSAKKtp+2vTXowV9QHBV9kNOdPkpwk+VoCs/5kfZl77
         YDbua4JHNwKqMnmoXvA9L366naRAGKno4nNtN1nMVwOw8EMCK21QH2wpwL2k+5i2Qa5x
         vQDw==
X-Gm-Message-State: APjAAAV5m7YG3HqD6bJsdIvF3gohRH86pCXdp/8l9g0A2HhfCYcNJYtL
        Kww6KXz7SXzwOGxRGXqCRwQ=
X-Google-Smtp-Source: APXvYqw2t2vW5+2nGuiMW5ullDxvnfuTJLjFebDyf2rN4uqEagrAjZW2bN0TAZkVSrUJV+x9w0B4SA==
X-Received: by 2002:a37:57c6:: with SMTP id l189mr29760970qkb.246.1570535506530;
        Tue, 08 Oct 2019 04:51:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c988:3ed2:5e14:1c0f? ([2001:4898:a800:1010:7abe:3ed2:5e14:1c0f])
        by smtp.gmail.com with ESMTPSA id g8sm12119632qta.67.2019.10.08.04.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 04:51:45 -0700 (PDT)
Subject: Re: [PATCH 03/15] rev-parse: add an --object-format option
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
 <20191005211209.18237-4-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3cb91b69-7d33-12ab-de37-175592f95df7@gmail.com>
Date:   Tue, 8 Oct 2019 07:51:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191005211209.18237-4-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2019 5:11 PM, brian m. carlson wrote:
> Add an option to print the object format used for input, output, or
> storage. This allows shell scripts to discover the hash algorithm in
> use.

Why put this in 'rev-parse'? Is a test helper not an option for this?

-Stolee
