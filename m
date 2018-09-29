Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6E371F453
	for <e@80x24.org>; Sat, 29 Sep 2018 00:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbeI2HRv (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 03:17:51 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:40534 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbeI2HRv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 03:17:51 -0400
Received: by mail-wm1-f44.google.com with SMTP id o2-v6so3712972wmh.5
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 17:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jEtMoMbEV4eNFGfpQI/GrLtyqcEo3Jj1y/Iq/2og5Co=;
        b=AM8VWAtQ9TxYWN9yrrAiqXYlofBPgbDQIlDdkzA+0qFzn3PpbzqomMqFb0vLWW+4Xn
         aTzM43bEVFA0o1MBE8uPvTuttrVsMqglYR4UagpwyzCJEKA8MI6ISxL18YuWz1aZpn47
         5FAf9WkonvNmYWUkpuIBWAdbhrmxA13JwErP+nF9i42/gQJaCg7jkZkFD4uHZW7L+2BL
         IUCEyB/mDl1+GwLsAiNmAvH63GCyNjXAk6MSfCuMMD/r7tPbpZwsnFXPpaAAFacB3WOi
         GzuSg5HSjwbNUsSC/nTlul63g06EC7rhXkkuKpmiYbzRudmZHD0jrCRAkUc677iyK7dt
         srog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jEtMoMbEV4eNFGfpQI/GrLtyqcEo3Jj1y/Iq/2og5Co=;
        b=Rv+vj0hdyLRbvnYm3FRYxagszia1MiL3cfvdaEe5kxHH/00IpYJQ0Jc8QUYLHhTzDw
         GoG/PrCAy/qcRHk+7r8tJ+MXFvBxahho9uF3acyhBFdcjMA5dcKGjoPJf+n5nXD5+xbu
         I2XQ/nbuzSp2+/2jjb4DhSpKO0s97Ql6sP0pjf1NCx5OawohBJm7d8APuvEy5oeS+VcD
         nRkSsqKOGXgQZ0CBajM5kHI6mK0JlB27c5jwmRtms2rKsmj/oOI4t//I+5Vd2PGxxalV
         rWvEdgUxsDL4UxqJNUAyemP7jJ+xXPesraAhn+55fgHCgJKN6L/Wr4c+jgCuqRUHSFR9
         fVFw==
X-Gm-Message-State: ABuFfoiIAEu7EAWiFBdNW6EqsrrW+Dw8QfwCs9pcTPTEpfAppAid+egm
        SuohfHJkUPh6dWYqVVs6gKTYAQn/
X-Google-Smtp-Source: ACcGV601tNJ39RhmoihAXIDuidjHpzVDSrS4BqH4aCd+Yc3OLLp7XDyW/POitYjQL8wHXcBDD4zFNA==
X-Received: by 2002:a1c:958d:: with SMTP id x135-v6mr3419787wmd.46.1538182292273;
        Fri, 28 Sep 2018 17:51:32 -0700 (PDT)
Received: from localhost (x4db1ef73.dyn.telefonica.de. [77.177.239.115])
        by smtp.gmail.com with ESMTPSA id i4-v6sm13621416wrs.87.2018.09.28.17.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 17:51:31 -0700 (PDT)
Date:   Sat, 29 Sep 2018 02:51:28 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v6 3/7] eoie: add End of Index Entry (EOIE) extension
Message-ID: <20180929005128.GD23446@localhost>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180926195442.1380-1-benpeart@microsoft.com>
 <20180926195442.1380-4-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180926195442.1380-4-benpeart@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 03:54:38PM -0400, Ben Peart wrote:
> diff --git a/read-cache.c b/read-cache.c
> index 6ba99e2c96..80255d3088 100644
> --- a/read-cache.c
> +++ b/read-cache.c

> +static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
> +{

<....>

> +	the_hash_algo->final_fn(hash, &c);
> +	if (hashcmp(hash, (const unsigned char *)index))
> +		return 0;

Please use !hasheq() instead of hashcmp().

