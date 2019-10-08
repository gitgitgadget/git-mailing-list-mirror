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
	by dcvr.yhbt.net (Postfix) with ESMTP id 849F81F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 12:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfJHMVu (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 08:21:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47051 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730316AbfJHMVu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 08:21:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so16439226qkd.13
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=efyaUu3J50TdEU/WIet02ET8pMyn5R79XQrRZ2nDCfY=;
        b=LHPL70vFfPyxBWs3BipBd2zEVV5+YxqRi3Vl2cV8DH0JyTVLEHch/rYKo+Omy/H69U
         I8qXYkt9yrjoxQ2efRSS9tOlj+3YUkDszq3z/jzucj2Hoyu423hcD/IofWw9zitOXMvc
         LdYYLDq1Vp+8u0xOxOyZPcDWPETi6BNla3yhTZf3koNjqBIQVO4LfZ4bleneBo2/fN/q
         TuRVA0LSueUNGiLmNmF/AyuiLh9Cut008JQ6BsCv0V9qE/CBVIwW0S8rHphom8R9absM
         BuNKmFa86jDAt5dUFqoWjvJ1FJGW7pKpHYyUur28OSUChGIjiSIsnp0WaK9Da8Ld90xi
         zQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=efyaUu3J50TdEU/WIet02ET8pMyn5R79XQrRZ2nDCfY=;
        b=s00XEeub7diD6p04p5dPMeJCx4ZhFaLww5NJ67C2VXOIAGFqKS5ef3x6MFi/7d+OS+
         7qSUhVLFuO1WVNuD4fHWrSBzu7oQY3bKmpdVis2q/f6ksAZtk2ZuvL2hXEETqT49SNcR
         2RUCuSq2AZ19QOA9POPHlAVoJE4cIwjxC3bMLCV5nO7/luAUj5ubcH0rUqWx9Vm4czMH
         1LZOBCJWDLLudj6eU6pRjbPFd4GM1O2hDp1Fz+mPjXweQoCxmUe4Y8GAqK5ktnuMt5pX
         HQLlt8+ocW7xtYT7luznUUAxkqL+mft9HvFrr0GjD7qSf9UN4rVPKVVhLkYFx6MPKmZk
         XC2Q==
X-Gm-Message-State: APjAAAW9OrVGZnIsgfDtC6ij/MnPqoTqx+8lDmX9fN2S2UbzeqUu34LZ
        /QIABu+GfabbZFN07FhGqJ0=
X-Google-Smtp-Source: APXvYqxw7DRiEo4EXifAnC4+1J7ZqjZt0kyyQP25jBEhQ2QbKThQgZ606lPeOTMYuQ5s6Wjg9dYNpw==
X-Received: by 2002:a37:a411:: with SMTP id n17mr6253907qke.216.1570537309478;
        Tue, 08 Oct 2019 05:21:49 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c988:3ed2:5e14:1c0f? ([2001:4898:a800:1012:7abc:3ed2:5e14:1c0f])
        by smtp.gmail.com with ESMTPSA id 54sm13059988qts.75.2019.10.08.05.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 05:21:49 -0700 (PDT)
Subject: Re: [PATCH 07/15] t4011: abstract away SHA-1-specific constants
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
 <20191005211209.18237-8-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4733b8a0-bfd9-a49a-01d2-1c9f2a48cdf8@gmail.com>
Date:   Tue, 8 Oct 2019 08:21:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191005211209.18237-8-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2019 5:12 PM, brian m. carlson wrote:
> Adjust the test so that it computes variables for object IDs instead of
> using hard-coded hashes.

[snip]

> @@ -137,14 +141,17 @@ test_expect_success SYMLINKS 'setup symlinks with attributes' '
>  '
>  
>  test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
> -	cat >expect <<-\EOF &&
> +	file=$(git rev-parse --short $(git hash-object file.bin)) &&
> +	link=$(git rev-parse --short \
> +		$(printf file.bin | git hash-object --stdin)) &&

Why this change from $(git hash-object file.bin) to
$(printf file.bin | git hash-object --stdin)?

For that matter, why are you using the "printf|git hash-object"
pattern throughout your change? Seems like an unnecessary hurdle
to me.

-Stolee
