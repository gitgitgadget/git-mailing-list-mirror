Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABDFC20248
	for <e@80x24.org>; Mon, 15 Apr 2019 14:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfDOOGh (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 10:06:37 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40071 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfDOOGh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 10:06:37 -0400
Received: by mail-yw1-f67.google.com with SMTP id p64so6040416ywg.7
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nN50rG4Fm4MnPO2TvjDJ9akIoZGu7MNKkJ0X2Nn+UFk=;
        b=W1CFe3TA1kzRHbu1Jbpx5QB3NpNB0xkW1r7HiXBvuc5IKIZHX3YG496D2PyiSrvj1T
         IwqxDDaz0w9aNwPjIz21wTaoIR2HGQk1XmqjY4rEgOGz7D13m0TZwL6UdZuY74vGIB7h
         11V+jp9RwuBGlOxAV3b6zutmqseRjEFky3oU9eMxVS5hqA56sMx7WqTIvzcCA9/qD2jj
         RGHURX05WBDkImeZeKidB4458EwOGYNG1VfTkRaJjiO7ljXrMpT1eIDnT83XCyQKIcVY
         QyyjLFLDcUbulfVdKU53fZ9pG6TdZS45OsuT8GsOCr9kCTlRHR95tgqZKamIiFw0HHZQ
         jfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nN50rG4Fm4MnPO2TvjDJ9akIoZGu7MNKkJ0X2Nn+UFk=;
        b=IVgavI55Uj7Ek0XVKdUmb0a5mzzzBtrPNy1I0b5fg9JgxLC7HWqRmsY4dOb89mF9XK
         oglfxGLVgUZ/TokM202l9wim6CFF7cVxzjiiJ4BY/2mRW0M3vlYb3a7GMN4oDh4dM+yV
         lOAsQI1ZD1TZlf4EnfSmiNJrEMqguxQq9vpYsfFz2jKFKtAB74JEkK1jt8gWJULr5L8O
         /lZ89LOZDCFW2qq7v3ugLodf7+bfZDvlpmeG0FL0Gq+hlEehsztjg009UOTbbdTidx1Q
         mi1uu8e8C52JFdQ6QkdJnx+k1z+I2FqHdpzyJ7LpZWqRLB2lFp8cYq27dmQjgyN3J6ST
         fOwQ==
X-Gm-Message-State: APjAAAUVG0ysvsoPPWenbBraqm6cHGhDnqB8kDkkWBdNKGCgh42oR2qc
        sBxo3LMj5EeKW1b5npWXqJo=
X-Google-Smtp-Source: APXvYqzKT17wuOatYxsTVkSmwpUK+jpsrzOIPRIYBwxpQSnQIyySpXUgJOH0KmsZhHy291xgM/TNyA==
X-Received: by 2002:a0d:dfc2:: with SMTP id i185mr56938108ywe.11.1555337195404;
        Mon, 15 Apr 2019 07:06:35 -0700 (PDT)
Received: from [192.168.1.14] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id o139sm24888434ywo.13.2019.04.15.07.06.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:06:34 -0700 (PDT)
Subject: Re: [PATCH 07/14] parse-options: allow ll_callback with
 OPTION_CALLBACK
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190127003535.28341-1-pclouds@gmail.com>
 <20190127003535.28341-8-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <02d2a828-b191-9d9a-7422-d76cdca69ef1@gmail.com>
Date:   Mon, 15 Apr 2019 10:06:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <20190127003535.28341-8-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/26/2019 7:35 PM, Nguyễn Thái Ngọc Duy wrote:
> @@ -238,7 +249,10 @@ static enum parse_opt_result parse_short_opt(struct parse_opt_ctx_t *p,
>  			len++;
>  		arg = xmemdupz(p->opt, len);
>  		p->opt = p->opt[len] ? p->opt + len : NULL;
> -		rc = (*numopt->callback)(numopt, arg, 0) ? (-1) : 0;
> +		if (numopt->callback)
> +			rc = (*numopt->callback)(numopt, arg, 0) ? (-1) : 0;
> +		else
> +			rc = (*numopt->ll_callback)(p, numopt, arg, 0);
>  		free(arg);
>  		return rc;
>  	}

Hi Duy,

This "else" condition is unreachable. This block is only hit when we have a "-<n>"
option, using OPT_NUMBER_CALLBACK, which is implemented by filling "callback", never
"ll_callback".

I recommend reverting this diff segment, but please let me know if I'm missing something.

Thanks,
-Stolee
