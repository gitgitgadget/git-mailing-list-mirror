Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A2D1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 13:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeAZN2h (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 08:28:37 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35677 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeAZN2g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 08:28:36 -0500
Received: by mail-qt0-f173.google.com with SMTP id g14so1226500qti.2
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 05:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=StEHM/ewx7+sm+bIp4+NoxFegkUHmdowMG1YeStQvWY=;
        b=Wfow1Uz5WF08tzwtPSpXfn3bfkGBOCe3c29gwdZrZy2/ktZ1E0BQpdeW0i1QQrEcV/
         Kf7yLeYGnB68u5FA4desozx+CS90DtJ3LcUvoJ/uvH8d1bq7JGS5s8aJaLAe5/teG8KJ
         O4pizoD2NNJgx4DDPQqj/zv2EKUlsugySm06nlmZXJNYbe6evN0DL8c1sGR/O6YNGEMU
         rvszpdTw07WvoACtq9OgizDWTQIk+OA+zmjmAIiiMC95Y902/FAHpIZhS2FPXlnCQLqk
         t+ZCA2rD1fJei1eMIxP6SgcyBvR1e02nbxdJmKDMHrXGdpy0akFV6dOV14AJ9PW3i344
         yb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=StEHM/ewx7+sm+bIp4+NoxFegkUHmdowMG1YeStQvWY=;
        b=QSG1OpHAStqCsDk1rC8wFCKMZyYKYBbl3srtOgW61fu6ilcsfRwuapapglIbF2Sfxm
         2/4pUghbD+pz3jWBRsVQXFKOHISyme0W/B8p1/iIma+rjVkZvN1lvKTY+/OUb/Yx9mF3
         Y60ivweK6f1LWkKXKAAOnZe3j45SZ81tkVGCN+EPRrHnemrqfFYqmrcCFBQFVXouQgkl
         6Yy9gTeCRZ1b7KhoDQiB79u45jFW3ZmxYz9+9b5i3SHsfGOSsyGbvJPYA6KUlKDy7Ym1
         aNiW3UF+IMpI3+NQ1IrZTFEoIUGyZARVPrVOkVrbxHioJOBU7PHdQpERq2luvzJcrmQM
         d9qg==
X-Gm-Message-State: AKwxytcTLiR0ffeIykoL6RgJdjSUxHjVG12h8aeSFg8TvYlx2ynrg0Ra
        EbTgxeC3tw/Zgp1gst0Ru3g=
X-Google-Smtp-Source: AH8x227ZKHCLx19LkRBzaNaPkS2+e8pyCK4qyNAZViSifiAyaws9ewPfCzd5u6RxTY1ox/xrhEbKPQ==
X-Received: by 10.200.23.136 with SMTP id o8mr24911536qtj.255.1516973316022;
        Fri, 26 Jan 2018 05:28:36 -0800 (PST)
Received: from [10.160.98.110] ([167.220.148.110])
        by smtp.gmail.com with ESMTPSA id q54sm5652828qtj.41.2018.01.26.05.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2018 05:28:35 -0800 (PST)
Subject: Re: [PATCH 06/14] packed-graph: implement git-graph --write
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
 <20180125140231.65604-7-dstolee@microsoft.com>
 <CAGZ79kYQfHc398w5QMATotLYaCZW+sPiY05gGx9pGFm4GzBE+A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fbf1fcbf-752c-c558-6f47-e254656d8978@gmail.com>
Date:   Fri, 26 Jan 2018 08:28:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYQfHc398w5QMATotLYaCZW+sPiY05gGx9pGFm4GzBE+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 6:28 PM, Stefan Beller wrote:
> On Thu, Jan 25, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
>
>> +------------------------------------------------
>> +$ git midx --write
> midx?

Looks like I missed some replacements as I was building this. Now you 
see how I hope the feedback from this patch will inform the MIDX patch. ;)

>
>> +test_done
> The tests basically tests that there is no segfault?
> Makes sense.

Also checks that files are written based on the output hash. The next 
commits gives inspection ability.

Thanks,
-Stolee
