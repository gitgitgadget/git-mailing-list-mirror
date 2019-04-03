Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A61E220248
	for <e@80x24.org>; Wed,  3 Apr 2019 15:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDCPZs (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 11:25:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40853 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCPZs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 11:25:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so8330678pfc.7
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JJyvpPPorGKhay8UafZEDh9fgQ29AlJqUfzFxkbLirM=;
        b=pQ0tUpzyFhxyqsxQdTQczgjevq3WMGkQx2zE07o8o8RlFlNV5DtdJClHliaXz52uMZ
         S11T1u4NJe6aOSkhPMWJLKp9yM9DuSLiboWmsyZY/vx1bVC+K4iLdSyHjZ/SPTU/9qUr
         nvYOnmi66x1/zKxdHKtMzxJudbRtQ/JcBkn1dFTrEWlSFs0/MezUgSUzzb7VCPChvHjQ
         eY8SattAKE6LKUkKBhF4WWqF4IUrx5KCHuoEcxUp2K71lUAgiiOSlmCIixa2+stpIGZK
         cM6eg8FLBxbEjY21UH/hRrfp25lfYMcL6e35hduxF55lJSdwSaS21YXX7t83PWuDOmPu
         FS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JJyvpPPorGKhay8UafZEDh9fgQ29AlJqUfzFxkbLirM=;
        b=Dgzm0mv4it9uNxyvMQ7nljou1gOFyZSeooQbvGJ2MFoYckquu9pclrJU90pyiTJzDd
         QH43OdgFWOLChpShMm5v++ssrZIYMdqmh5E6BFp2A/GmbIPRE++Fw3xoFe0LQ8cTN5cB
         0o1KOZKqy2jBV7G0sGKT4RkQy4jp3p5bu3kwumto9aFpegCrIEOpmAfF9jxw4kUrC9R6
         bp4S3HtX/IwphU8FIud0h3I9UprNVfhh6q2VNFzEaka+ptRRDPVyV2F30xshyebtCn15
         /idASj62Ud+GJDSQ75oii44zajUvd68q8KuYJK6N0r6Zi4C2R2r1IKfIVVJq9BeEgWj2
         LrVw==
X-Gm-Message-State: APjAAAWeN4JyB4TC+HY3kTjU5j9IsVETlZLbCar+ldOL54/nPOsKQ26N
        39TiW3XQyNzONH033B46+HvYwu58HX8=
X-Google-Smtp-Source: APXvYqy2Rw7GBuVtZxWYxocTgI/gfdBbvX3eX+XF/MYeXr8T7cDyYWhiXQr/wDk+WM5qOvSEiZQI0A==
X-Received: by 2002:a62:6842:: with SMTP id d63mr14795650pfc.9.1554305146903;
        Wed, 03 Apr 2019 08:25:46 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id g6sm20133856pgq.54.2019.04.03.08.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 08:25:45 -0700 (PDT)
Subject: Re: [RFC PATCH 0/1] Fuzzy blame
To:     Michael Platings <michael@platin.gs>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20190324235020.49706-1-michael@platin.gs>
 <xmqq5zs7oexn.fsf@gitster-ct.c.googlers.com>
 <CAJDYR9RWUmXzh9Pn3qGBXAxNf70-SMKUCB3wwXVYKRTKOy8F_g@mail.gmail.com>
 <b077afed-d143-506e-977e-6edf2492f75f@google.com>
 <CAJDYR9R77_+gfOgLXX_Az8iODNRyDTHAT8BAubZeptEWJViYqA@mail.gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <7540d14b-f225-39ec-b37e-54cb157d4a72@google.com>
Date:   Wed, 3 Apr 2019 11:25:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAJDYR9R77_+gfOgLXX_Az8iODNRyDTHAT8BAubZeptEWJViYqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 3/25/19 7:21 PM, Michael Platings wrote:
>> The first thing that comes to mind for me is to plug your fuzzy logic
>> into my patch set.
> Please do! It should be easy to pluck fuzzy_find_matching_lines() and
> its dependencies out. Just to set your expectations, I have not yet
> optimised it and it is highly wasteful right now both in terms of time
> and memory.

I edited my patch set to allow changing the heuristic.  I also made a 
commit that uses your fingerprinting code to match target lines to 
parent lines.  I'll send it all out in another email and CC you.  The 
last commit is still a work in progress.

Regarding stuff like the name of the ignore file, in my first version, I 
went with whatever git hyper-blame does.  That was shot down, rightly 
so, I think.  With a git-config setting, you can name the file whatever 
you want, or add multiple files.  With my current patchset, you can 
disable the file too with --ignore-revs-file="".

As far as using notes or per-commit info, that might be nice, though 
it's not a huge burden to have a separate commit - you can wait til 
after things get merged (so we have the final object name (hash)) and 
it's not hugely burdensome.  But I get that's just my opinion.  =)

Barret



