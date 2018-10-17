Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362AF1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 12:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeJQURN (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 16:17:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40377 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeJQURN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 16:17:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id b4-v6so29636403qtc.7
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 05:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=10lZkdJdNMUUfpeBbPz4o+EPrMk46v3dySKIJubXKqs=;
        b=cSe81X0RByR7Re5FTSb5RU9XBZeVeUV1SSfV1Bt7uNlstAOfM47Ozu48e3iK/BIAB1
         buxTkma51Kn6I8DlIOooTCdRP352jday6F7x98eprz+LecsZCE5shi3GMG5KDUtolRwH
         iLxa8Xw0JphnPyyg20I6A4tmhg1Qgq7VxnBcuTQWp7DCqgQ4Q2FJa7w8T/EG7InAseBP
         mgtVwdL4YtinAdTc/ZGjeusIdn0SK+6JOjEH1lkQtz+fa3/wBNgD53qfkq2oJ8OuNK9u
         cxRG+N4B6Q3eIW4PXL19Dulc1Ld/n/jxYBSpWZQD3ZHtaTS8aIX7PtTjQcywVbBOoKCq
         boMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=10lZkdJdNMUUfpeBbPz4o+EPrMk46v3dySKIJubXKqs=;
        b=eMeeuBCdau450XRXkYI9b9Wq4/cO1+t/w1uNQEmzPz5PNIHSosOkG5b1mOI/v8K5Q8
         +OXO2oBjzrZ6AAlBuCwb7NnWbc+XaVh52CwG/5mI3xzd/KR0e4piIKLNmpzBmmIE4+O0
         QLdR465D4Ig05quHsFMW8Zr1iZbi/70HkrG4c8JohGp47uQj+auOfB+rf+epqWzzHSoM
         ABE/BOtKWlNfJ3u6wWR1GT+RUzBJd/dY/X2h/9Bm8KzLxDox1A5Kp7YI4kqxtCGIRRVN
         SfkczFS2PieOxzzGaJIoSMuaJwzMFa7miA6sfZai2Jz80MC0VuceJVXmfkijgRVCwC7y
         CzSw==
X-Gm-Message-State: ABuFfohpbcN1zbl7AjKnvzSs5vyEuFENeIhTUBkIFEdIKz5q7+Ibjl0O
        xVE/NfkozVJNvDyV31DjD70=
X-Google-Smtp-Source: ACcGV60y/BzzZGugFsmsQQg8qR7ClP4Xnkd1Vl6GOVkRLb+DJb7G3rL4G53G9ESxL6Q9U+gFf3Id8Q==
X-Received: by 2002:a0c:cb87:: with SMTP id p7mr24785590qvk.63.1539778904759;
        Wed, 17 Oct 2018 05:21:44 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8586:348a:8c9:d17b? ([2001:4898:8010:0:6ebc:348a:8c9:d17b])
        by smtp.gmail.com with ESMTPSA id t22-v6sm17058503qtt.1.2018.10.17.05.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 05:21:43 -0700 (PDT)
Subject: Re: [PATCH v2 13/13] commit-graph: specify OID version for SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-14-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d7412414-61a0-2da5-257f-f3d9764e15dd@gmail.com>
Date:   Wed, 17 Oct 2018 08:21:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181015021900.1030041-14-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/14/2018 10:19 PM, brian m. carlson wrote:
> Since the commit-graph code wants to serialize the hash algorithm into
> the data store, specify a version number for each supported algorithm.
> Note that we don't use the values of the constants themselves, as they
> are internal and could change in the future.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>   commit-graph.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 7a28fbb03f..e587c21bb6 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -45,7 +45,14 @@ char *get_commit_graph_filename(const char *obj_dir)
>   
>   static uint8_t oid_version(void)
>   {
> -	return 1;
> +	switch (hash_algo_by_ptr(the_hash_algo)) {
hash_algo_by_ptr is specified as an inline function in hash.h, so this 
leads to a linking error in jch and pu right now.

I think the fix is simply to add '#include "hash.h"' to the list of 
includes.

Thanks,
-Stolee
