Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22DAC1F51C
	for <e@80x24.org>; Mon, 21 May 2018 12:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbeEUMgJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 08:36:09 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:42991 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeEUMgI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 08:36:08 -0400
Received: by mail-qk0-f175.google.com with SMTP id b22-v6so11616766qkj.9
        for <git@vger.kernel.org>; Mon, 21 May 2018 05:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WwXFHESXtJ/t0J+KM7dhacRgNkiVlpA0hV5RP1wVoFQ=;
        b=B6xX6atcCfMPBe8PdkhgBDnTKJl0464bEA/9d6t/rei8CkYt+XVfpY5KA+Ow8WuPNX
         N1Ml+aOll4wZEFrQKn031twVZ/T+5/6FWl4G/CCKLDH7ssxfLXmOxg8JRP5UEsZeOMyj
         Sb0Gnd2YHsdSeKDiaywHe3PEMFvmXMEMM3YfApCUUaO3qS05HTad7xWMzKxjovw1RmKa
         io5caQCMPFhaBY8le/x32nqFJBIOJcHBDAswcfSQXApNLSn+f9AzPrMGRjoK8gTh2CkJ
         7oUElpnJjzyrBY1fSt1k13Xkd6b1ny/fNuRQhKOydOqvTtl7Xc3zWgWmQOLRqE0+9g6a
         D3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WwXFHESXtJ/t0J+KM7dhacRgNkiVlpA0hV5RP1wVoFQ=;
        b=taxkLJzZnE7S94OMtc+GSLN8KB/hCjAQnbXjpzaC6XuTTB+EbF8ooDIFFf79ZsRvW/
         7OhcvzD5hrABms80hQuZg3paZp7W48HeI9pEYIJ9mo2QlYmpjUnjjGW1rDydA6jYGO27
         8GvvIENX9U7hFT9ox8E0A8TvshYOVg3df7Q7aV6HpHEXZR+p5Qh6jMk8ivrXHUVyzrsZ
         lasY/QrDLUki4wmz061mDKX7hQ8tymHkm9sBxX/IOeWGyNpxAh3+ejeZvcVsIAis90YW
         CwQKe/4uNazmDgJTrsdkUX6N4Y/sGFmbMfexiWYFfs/N1ldZLaFH4SDF8ZbSnWb05BaV
         VrWw==
X-Gm-Message-State: ALKqPwd3q4axJ+Iyxm+Z+e/u+ChtkTgdzR5y8GVJNNUyKADAzRdxnUbh
        wfhwYE7K8FEiQu5bOjQ8tGY=
X-Google-Smtp-Source: AB8JxZq9THiHCCVYTomZb8Saz1VMFP4W+UGiuHIbLDUazqA6wwsJp9ydlKMPxPJydiXEsVbYndA51Q==
X-Received: by 2002:a37:7183:: with SMTP id m125-v6mr13724969qkc.107.1526906168136;
        Mon, 21 May 2018 05:36:08 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id g7-v6sm4385421qke.96.2018.05.21.05.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 May 2018 05:36:07 -0700 (PDT)
Subject: Re: [PATCH 3/5] query_fsmonitor: use xsnprintf for formatting
 integers
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Ben Peart <benpeart@microsoft.com>
References: <20180519015444.GA12080@sigill.intra.peff.net>
 <20180519015758.GC32492@sigill.intra.peff.net>
 <cd6dba3c-19bb-e6c7-0c1f-5cea0c8f9d81@web.de>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <c5d9da23-447d-2878-cf4f-e9e7f12ce35f@gmail.com>
Date:   Mon, 21 May 2018 08:36:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cd6dba3c-19bb-e6c7-0c1f-5cea0c8f9d81@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/19/2018 4:27 AM, René Scharfe wrote:
> Am 19.05.2018 um 03:57 schrieb Jeff King:
>> These formatted integers should always fit into their
>> 64-byte buffers. Let's use xsnprintf() to add an assertion
>> that this is the case, which makes auditing for other
>> unchecked snprintfs() easier.
> 
> How about this instead?
> 
> -- >8 --
>   
> -	snprintf(ver, sizeof(ver), "%d", version);
> -	snprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update);
> -	argv[1] = ver;
> -	argv[2] = date;
> -	argv[3] = NULL;
> -	cp.argv = argv;
> +	argv_array_push(&cp.args, core_fsmonitor);
> +	argv_array_pushf(&cp.args, "%d", version);
> +	argv_array_pushf(&cp.args, "%" PRIuMAX, (uintmax_t)last_update);

Looks good.  Simpler, cleaner, less error prone.

>   	cp.use_shell = 1;
>   	cp.dir = get_git_work_tree();
>   
> 
