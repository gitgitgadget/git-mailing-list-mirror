Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726661F462
	for <e@80x24.org>; Wed, 19 Jun 2019 13:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfFSNSl (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 09:18:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40847 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfFSNSl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 09:18:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so19775522qtn.7
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 06:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZBYF+W8IFwVW4bCJVtxXQ/h9wrDLwxjMvREHWhRbzVs=;
        b=AZilZj3Wa47XJkXzqitxTEtslbktbYMVqUsXH7DDmD6kbbpCCJ90m25man48naahnm
         mDuhZoWQ71G+ZmF9UwOkRpqN91DnmH9AGZyWfrnhEVhtA2Cl1cAOjQoWJPb+c3bGbn7l
         9MptL2IHRG20qA2oYeQgUptpl/ZvbKQvwbjVT+0gbq9MqPxOQ9a4sGpmEpyl2MdApbRI
         jqzzlyHXrPTlZuY0aMiQzD9e454D66tZaUH0+g2sk9g2B66QoDsma4l/mzqGSkoqWimd
         n1YbtCzDpLMhWjFICjP9/Io4bGHvTSTW9QeO4cmJQf21FoqEBRdaQ5cxGF+KMaUZO9rk
         l7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZBYF+W8IFwVW4bCJVtxXQ/h9wrDLwxjMvREHWhRbzVs=;
        b=Sgcy0jd/8oS/1wviHRXLT5ISierWoGCIgN5tPwA2ZnzbD0bodiPclscRrK+2O/HCeC
         qQga6VsvIzJvE+2ZnSGqK+gtY5Y8Yxc4+H5UGY4zjrW/aqA9YhFaPa5sE1xSaj7LdRdU
         0lL/GFja+1BaDU4flsV64kxA+dVVxNjte7A57eU+4TXQUZ0EAUe21Bv9ND6gMDIFiwlS
         KCCtK4cP7Ne+VoysdXn9my0rqvlk1mBVFB/h4/eeUZF3J+SGn0xAuauv76SDc5ZaHb5R
         iaMrjpKmW8AD4X5Uy01h9FLauhChMCz6Heid2r17idEFVz/9sMWOTbz6odPf2x0ELHFs
         HPGQ==
X-Gm-Message-State: APjAAAVkvu1DdWMdgdp61edD6YzQp3MhSSGnygpx8ntEUbPoT0phBoZo
        qexB/+3+OeYstPawaRpxZtB18ESX
X-Google-Smtp-Source: APXvYqwdt/1sb+mUIfv40jqRDf2dImyxXsWBX0ne/7i1uAMnCO+SVxslkfmHl/H/PYQrOfzZWTDY/g==
X-Received: by 2002:a0c:b90a:: with SMTP id u10mr33398361qvf.201.1560950319946;
        Wed, 19 Jun 2019 06:18:39 -0700 (PDT)
Received: from [10.0.1.15] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id t2sm5723665qth.33.2019.06.19.06.18.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 06:18:39 -0700 (PDT)
Subject: Re: [PATCH 6/8] read-cache.c: dump "IEOT" extension as json
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20190619095858.30124-1-pclouds@gmail.com>
 <20190619095858.30124-7-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8a56ac88-f3b9-c80d-441e-8e74eb64921d@gmail.com>
Date:   Wed, 19 Jun 2019 09:18:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190619095858.30124-7-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/19/2019 5:58 AM, Nguyễn Thái Ngọc Duy wrote:> @@ -2266,7 +2271,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>  	 * to multi-thread the reading of the cache entries.
>  	 */
>  	if (extension_offset && nr_threads > 1)
> -		ieot = read_ieot_extension(mmap, mmap_size, extension_offset);
> +		ieot = read_ieot_extension(mmap, mmap_size, extension_offset, NULL);

I tried applying this series on top of v2.22.0 and ran into an issue
on this patch, and the message seemed to imply the problem was at this
block. I couldn't figure out what was wrong, but maybe the series is
based on a different commit?

That said, I applied the previous patches, compiled, and manually
tested those features. Seemed to be working as advertised.

Thanks,
-Stolee
