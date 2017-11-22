Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3FED20954
	for <e@80x24.org>; Wed, 22 Nov 2017 17:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbdKVRv1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 12:51:27 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34381 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbdKVRv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 12:51:26 -0500
Received: by mail-pf0-f177.google.com with SMTP id k24so2636689pfb.1
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d99mlOd8LmEx5B/iYMKUUypdHf319IKTkbPJENxM1Y4=;
        b=PZJunk0FN4LknVI6/ty0wrjBqX1D/BtNelDcbYTs9ww6WNZutuNCP6uMNykAQ5VRL/
         HX/CPJwmTZKEM3QdxM9NUqejE0JV5UVPRyBsSwNov1L6MO8vomqzWvBI4ePQv7o3Bb08
         FXX7kHRXrd9GUh21wbGtmnCTen5sA7zK2sgz1yEmlm2LN0j76IBQ0Bo5r3iuIW5MZmJl
         s1OqVhgWzz/PUug3AOnnCGhTqIdebgTF8ne9hAWEIjRXhKF9kM48GT7lHx0IfToLA4QM
         u6l/C12stGY2q434ytjc8ejnY/VXCgVtQmSyVrKC7UW9QuS13UEM755drmhY821ogur+
         UN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d99mlOd8LmEx5B/iYMKUUypdHf319IKTkbPJENxM1Y4=;
        b=r1qCxVyHSStCXqwZa0yXpW+nl2ZewuJIMKwJu0oVbzvwbBbcHDhxLAbrlarb7Q8+8R
         Ba1XSqzf1/l3FsxUGF9oSdSFUXKUSXhyttJ1RrnfiC7c62mPAkte6a7hPzuMlFYmCtVB
         KczI2qXpSPlmJAJcUgskuQPo9mYrfpJHID+IzA5Mui6XwyvdSUp5BR5/k74cgJBvhYqm
         K4AY3YaiTQez22n1wkiiI3TuLWF7Rp7yfuKKaSSYrtd9wk0US2cNCKCdr0TczNOYHlE/
         OBJW3ZZIanb6U5P1u4/Vc6+KCRYNEh5F/orvUzs7Yc18jmbQ4U0xDhaO5vYO/2UR4b9h
         KDcg==
X-Gm-Message-State: AJaThX7Z8W5tvWPMNanP7vmAZnzK15lr3SgVO7AMhGTWrsfw16DoJVk4
        ieNsL1Q6S4AG4Zp3vzu7eh/vi5jU
X-Google-Smtp-Source: AGs4zMYEmSWiAESU1v0OAqy24nSffwLgScsVUgKSe0AXaCFHnS7kU3+VkL9mpRKSoWZzzwCRmoz/4A==
X-Received: by 10.98.33.203 with SMTP id o72mr19847055pfj.163.1511373085894;
        Wed, 22 Nov 2017 09:51:25 -0800 (PST)
Received: from ?IPv6:2405:204:73cd:cf11:6767:b6f6:4b9c:e3f? ([2405:204:73cd:cf11:6767:b6f6:4b9c:e3f])
        by smtp.gmail.com with ESMTPSA id h69sm15823590pfe.107.2017.11.22.09.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 09:51:24 -0800 (PST)
Subject: Re: [RFC PATCH] builtin/worktree: enhance worktree removal
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>
References: <20171121150954.3227-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQrC1MiPrwwPqtdX2tzj1ntFHxO28uqnMBcmVpPPrc_Rg@mail.gmail.com>
 <xmqqa7zfxdru.fsf@gitster.mtv.corp.google.com>
 <CAPig+cTux4dfBsX3DD=5TbM-p4-t66WX3+sufi39-W5Dw+ZvOw@mail.gmail.com>
 <CAPig+cStgFaeWoNVcwaJVtNnYeLQ2LfS9xXF7uM3Py17HUaFFw@mail.gmail.com>
 <xmqqvai3ufu9.fsf@gitster.mtv.corp.google.com>
 <CAPig+cQ1D+MFZkEX5yQ-DXu_CPf4oa507ChNjYqA=vG1CdZ4SQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <20883815-0d9b-a4d8-cc93-0eb8b918551f@gmail.com>
Date:   Wed, 22 Nov 2017 23:21:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQ1D+MFZkEX5yQ-DXu_CPf4oa507ChNjYqA=vG1CdZ4SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 
> Kaartic: Regarding the actual patch, rather than silencing
> validate_worktree() (which seems an unfortunate thing to do), isn't it
> possible simply to do a quick test to see if the worktree directory
> exists before calling validate_worktree()? If it doesn't exist, then
> just skip down to the part of the code which does the 'prune'
> operation.
> 

Nice suggestion. It seems to be a much better thing to do than silencing 
'validate_worktree' (it was an "ad-hoc" patch, you see). I'll send an 
update incorporating this suggestion (of course, with the suggested 
commit message), when I find time.

Thanks,
Kaartic
