Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65CFD1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 14:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbeBZObj (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 09:31:39 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:39039 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753328AbeBZObi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 09:31:38 -0500
Received: by mail-qk0-f178.google.com with SMTP id z197so19227019qkb.6
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 06:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OXzh+NdEt9GYTYi820/KigSTCyi3af1v5stIhVFh098=;
        b=oiOpNPxPW6pFBx7xQrURb9WoaQD6VBYO4QDgMezB2Q2lTN6xfVghxSTrOIZTAwqfTc
         yIA3tPs/nHAsuGfi8GccgpmWyRbBDNywToyKM08UPuQrDIIdauw1OwpmdgHzuBsTrUsa
         ime4wNWqh+NMlwLVBOiaYCp4v5FX4b8TBly5PDZ2DJ1BhHmXKr3g7F5DFwUw70zeuOBg
         Rh+WWvuUHDvxOoWSLw/G1RJzNIbgVbIC/zzRqdVP8UTH8vGKapY+oKGzoQX2q9dRDPn7
         ES8xMk2Smwa77fuBhxqf5vrBFFHSjT8uwFj9qOICbzXjVOACgRf+K8INDDRXS3tZzJhE
         LV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OXzh+NdEt9GYTYi820/KigSTCyi3af1v5stIhVFh098=;
        b=hUkXIxmczwJp6MIY0coTasdlWazDgR5kS82FC6UPti+IcyoObIJBdlNWkiwlNlbqzK
         nj4D5MNCtJNjkku2EjxG0yFKfr3R7zxYDSkVREjLh8kx2qkMStG84NzZixGh2HnDzNM2
         WNAClqwNcx+XWNsrgoCLbC69zXrEj0SBErEnlairbBadYBJeOly1G5kAdU0bIv6Y0qJu
         gEJUrQPqRSRzFvm+vjdYL/oInGirG4rbmnsasKRUq4vUe5rDi8wdvL1br/CPLRxiKEUR
         n+mWwokEd7CvPRin1W2t1Y9RjYegKqD9oY36PGrqPcZgEOIFuCiFM8SP4rPMHB3kkmG0
         VQtQ==
X-Gm-Message-State: APf1xPAC1ucvTcEEeRXqFjhlYEr+J8ModMfKRfK5WGmorf+Gto0ogu+m
        9odaIaz87gDSKCE7e8hpI/5dgROW
X-Google-Smtp-Source: AG47ELuChSswUQt5V9je6sUmK6My90HwxebX2tuGqDfFpx2D3CLTUvryWF4tKsP0YgPyW/hU8rCRWg==
X-Received: by 10.55.159.212 with SMTP id i203mr17092544qke.31.1519655497264;
        Mon, 26 Feb 2018 06:31:37 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id c4sm4690597qtj.97.2018.02.26.06.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2018 06:31:36 -0800 (PST)
Subject: Re: [PATCH] commit-graph: fix some "plain integer as NULL pointer"
 warnings
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <e0bc5fe0-3b32-bebf-11cd-e335a8cf4e1c@ramsayjones.plus.com>
 <93d2329a-1963-dca8-2f9e-ba225ead9d0b@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <968481f1-dbda-502b-0c6f-41b0232fe870@gmail.com>
Date:   Mon, 26 Feb 2018 09:31:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <93d2329a-1963-dca8-2f9e-ba225ead9d0b@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/24/2018 12:42 AM, René Scharfe wrote:
> Am 24.02.2018 um 03:24 schrieb Ramsay Jones:
>> diff --git a/commit-graph.c b/commit-graph.c
>> index fc5ee7e99..c2f443436 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -45,7 +45,7 @@ char *get_graph_latest_filename(const char *obj_dir)
>>    {
>>    	struct strbuf fname = STRBUF_INIT;
>>    	strbuf_addf(&fname, "%s/info/graph-latest", obj_dir);
>> -	return strbuf_detach(&fname, 0);
>> +	return strbuf_detach(&fname, NULL);
>>    }
> You could also replace that function body with:
>
> 	return xstrfmt("%s/info/graph-latest", obj_dir);
>
> René

Thanks for the feedback! I will apply these locally as I am re-rolling 
today.

-Stolee
