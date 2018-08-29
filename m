Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8674C1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 12:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeH2Qee (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 12:34:34 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33699 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2Qee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 12:34:34 -0400
Received: by mail-qk0-f195.google.com with SMTP id z78-v6so3209572qka.0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZcOoo+MOKB7mW9xKKtKUoIz2hPULclaGHAYnVXL284Y=;
        b=ZgMkwavG1yoadNmDXp7Ilb1aCtkL+SxbIogugSTwyBeBhte4nLa3mHqSt/GSNv4dhu
         ms3cn9CQgfoBJoVUWaT7kk6ZwkdmTLEeTgeKPLavDXdlOzn+2Vc811ueAmoBqOTgQyl/
         DbLsm4MK1xzKPy0pzPAy7Jw/SexURnsjqdg9g3oPGSNTuto3eKPg3VIGvfiYs5t1C8jB
         Emf4bmw0Kfr5m+gXShVko69lCYHU99A3NrvbSunIwe3jHYVrXawdr+Hz0fgLPZ8wwh1Z
         z73QGq5rt+6JCp23pin99x5RH55EvviwaPkAZT1iW4VUGW/YKer5PIDECycAmW5+tex4
         rBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZcOoo+MOKB7mW9xKKtKUoIz2hPULclaGHAYnVXL284Y=;
        b=tNlbTYBnrPwXq/f7/C0N1s5wNmbO8Akfhv2Pyh98pOu4nJ0CuLj+3PDDp6qsGszmDL
         wIyeXPujkBx3SPipAB4GLgJIPTjt3mrRKxBCnOAEiEPUwFSeiLGem4ItXSc61OWTfyjf
         cm+PcWvn4l4sEkIo+RUmwVwW5zy8OaOLMZ2L8NMWhgizqq/jD9PYyz5VsU//BMPVYjDT
         ov/NpvbmpWZLtJ8Oh8tYvUvLs1RNchrTjYcYCNv4uWxCb+nixOO9gsVHsP/0DxvpB8by
         NNYM7w8elMM7ttMByhD/r0etHEZfJHXXFhU1JgAXn7C9SUe/WoViVsCBwhxqyqK+BNYG
         1U1g==
X-Gm-Message-State: APzg51BVM8WNav3NuzHOobMM7IKQueaI7I+0xWvk335JKfSHuxG+w79U
        MDiTsshLDIyAcqi81IHF7a4=
X-Google-Smtp-Source: ANB0VdaYfv667ptyEVk3vyt3nvitIAG8fZkZUUTCLuul9y66X/3miFodQom49LSRY5512vNeGdhBIw==
X-Received: by 2002:a37:4dcf:: with SMTP id a198-v6mr6065676qkb.139.1535546270311;
        Wed, 29 Aug 2018 05:37:50 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f86b:1660:ae35:a1de? ([2001:4898:8010:0:e1a1:1660:ae35:a1de])
        by smtp.gmail.com with ESMTPSA id g39-v6sm2627847qtb.90.2018.08.29.05.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 05:37:49 -0700 (PDT)
Subject: Re: [PATCH v3 01/11] t: add tool to translate hash-related values
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <20180829005642.980617-1-sandals@crustytoothpaste.net>
 <20180829005642.980617-2-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <777ea296-005d-0408-1197-178898399593@gmail.com>
Date:   Wed, 29 Aug 2018 08:37:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180829005642.980617-2-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2018 8:56 PM, brian m. carlson wrote:
> +	rawsz="$(test_oid rawsz)" &&
> +	hexsz="$(test_oid hexsz)" &&

These are neat helpers! The 'git commit-graph verify' tests in 
t5318-commit-graph.sh should automatically work if we use these for 
HASH_LEN instead of 20. I'll use a similar pattern when writing 'git 
multi-pack-index verify'.

Thanks,

-Stolee

