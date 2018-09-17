Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 319F81F404
	for <e@80x24.org>; Mon, 17 Sep 2018 20:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeIRBk7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 21:40:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33499 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbeIRBk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id b97-v6so2730390plb.0
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 13:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X7yXY6b+Aq9HjporlxpFCNa/RYBRztwursvD1rjd6BI=;
        b=a0/w8A+T9PmyVFJgdAZ8A4rFpq7BTMjP+ReArNRXdFmCEYg/zL101Z+VEzL8oxhU7N
         cAOcyorHpLqfRWsRg86wtTsyObcp5KfT8VBiopwqTnb3dTGPgEFrleLG8mz92tj59iUb
         8mVFwY/wQKT16hF/XgNZvqp1rCSII57RSrli9t4WhlS6XToXgGhEBjr7zh6F5+lYrVEa
         aemdIKCBsJP0VGm0BlVYqjw01soZeVmVJB7PBXGi1TkSvT1R8jfj8aaR82qBEbFh0DkW
         mKXsZ3NM188tI+USs6i0CMIYajMmjINR3yFZc/NzAvGAfxErXUWLrpE5QxtdLpKKmAnO
         NdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X7yXY6b+Aq9HjporlxpFCNa/RYBRztwursvD1rjd6BI=;
        b=esHH1SpoY9FdQ5O+sbh40Nmg/xTMjWx/OF/9VBmkOTM0zMpE1RGO9eG1l5utFnc0rq
         sNOLHaRMCa3Gkk0rPICip/d4N6qjmCerSoXR9SiIiCqIpdCMWVPkO/p/dtKJGjJIWcxx
         Jf8Yegn32fKZ4Eybd2mBtG5QGGABpK7gavyu5iQuIfo1F1h1AX7kgAZJw5OTLqsqyuuO
         nZQLJ9JwBSh3pj9YtiCRRHUmoHh693YAbJCPQ++PI87DJMyo0GGLwwYNnXXUFsdUi+2B
         j/W52olnTAY+AKa8zJx2nQNt/C5oqsGzAuZDHOwLQIeGbh4XInyhVt2Oq6H9hRQSSUPY
         q8Iw==
X-Gm-Message-State: APzg51ARiafsoyBy6EYYAqDRQ/nCjDqzg3Pv8JwRgOQQe8FLGQwgn98J
        OGxrXIC4jwz4HJB+RMQ2GxKgaIsx
X-Google-Smtp-Source: ANB0VdYMYr696Q9tHLTQbehq0W/ZPREmzo+Lb21FaClZDQBvvmOPmNiGwJ1mm8m1165vWMQmrmPO9g==
X-Received: by 2002:a17:902:2e01:: with SMTP id q1-v6mr26535246plb.40.1537215126420;
        Mon, 17 Sep 2018 13:12:06 -0700 (PDT)
Received: from [10.11.1.235] (173-11-86-161-SFBA.hfc.comcastbusiness.net. [173.11.86.161])
        by smtp.gmail.com with ESMTPSA id h82-v6sm24374358pfa.173.2018.09.17.13.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 13:12:04 -0700 (PDT)
Subject: Re: [PATCH] midx.c: mark a file-local symbol as static
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <63d480c7-0312-3b1d-59bc-7b9996facea0@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d4b88c9e-9d02-f361-922e-f85caf3994e1@gmail.com>
Date:   Mon, 17 Sep 2018 16:11:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <63d480c7-0312-3b1d-59bc-7b9996facea0@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/14/2018 7:26 PM, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Derrick,
>
> If you need to re-roll your 'ds/multi-pack-verify' branch, could you
> please squash this into the relevant patch (commit 64cbf3df21,
> "multi-pack-index: add 'verify' verb", 2018-09-13).
>
> [noticed by sparse].
>
> Thanks.
>
> ATB,
> Ramsay Jones

Thanks for catching this, Ramsay. Sorry for the mistake.

ds/multi-pack-verify is currently queued for 'next', so I wasn't 
planning on sending another version.

Junio, could you add this commit to the tip, or squash it into 64cbf3df2 
"multi-pack-index: add 'verify' verb"?

Thanks,
-Stolee

>
>   midx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/midx.c b/midx.c
> index 4d4c930522..713d6f9dde 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -926,7 +926,7 @@ void clear_midx_file(const char *object_dir)
>   	free(midx);
>   }
>   
> -int verify_midx_error;
> +static int verify_midx_error;
>   
>   static void midx_report(const char *fmt, ...)
>   {

