Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CDD41F453
	for <e@80x24.org>; Tue, 29 Jan 2019 23:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfA2X1g (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 18:27:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42249 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfA2X1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 18:27:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so9449314pga.9
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 15:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5YBwNbAB34W0d/nH8OcLX7Wtx96FCdNEcoG5H1AyUTM=;
        b=VQVKniobFhjOnXkv2ldp5p7JzeHII21WBc5Lxf6KdThrdKTMpCjvaxHJG2Sh3t/kkM
         46ZJAlLwbSrGG97YODDVQ6o8mbMTI9Cjd1VcQBj004Kx1gZRrTJXNZBuKGcyly3YJj9I
         DYSjw4lTUZ4AY1UVEegsaKSiM5l3NFK0KOylasXQ5+qgJDfPAJ+w09IlTID8BPeCUN9c
         yLOXp+FLLZ6vJaT68EIvWjIFaOTU+nxqWcBAtAuuuqtfcXxXpYoQOOSVlZ/qzWdTHuqn
         irl23Wzmq1qzaFDZQXacKsTYJ4iR8BCR3KmUzgBfxpWEBNDxGcmihA1Mns7r5PzuRiLN
         wcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5YBwNbAB34W0d/nH8OcLX7Wtx96FCdNEcoG5H1AyUTM=;
        b=L95r3xvEtY3yNcUVg6AV5hwb05r9J9e/NLD12Pyl8BvbVc37LzTlm5F8x7z+KmHNK+
         y2j4UVK4UkAPbhacMqHmORbHM9VTDrKYYLK+2VUfrngPgxNof54eACZ1XRyBRK6+f5CQ
         UNdoopV02RfZEVMbdN5Jgx1VQSGW1Y8ixDdNxHojA56iR8MJ+h/B2HCGuWnYz5buopen
         E4BW+JzoyagagqOYbHddkpv5eIQWeN7K9CTOXB/jSxBF1DpAqLMvV2JUTGO1eFS4oBmM
         RG1vOVq7VfRuZVn/jx5Q6nas0Z6GXcgFPzFO7/WpQwQeuZcg0TyYwwkKxNZ0/8uMDsGy
         m8bQ==
X-Gm-Message-State: AJcUukdug/vGKKtI1pMx4U3958eaHLKFh/i2LVXv2EmkXczvBfvLCuAM
        QEYxwCOiDqQuvJ0ff+OVr/r9nnuA
X-Google-Smtp-Source: ALg8bN6moabI26X8SaWkO5rM1YSa5D8Jcwn3NtB3bdvZK8pqU+MvLDTQBuFE62ORC3LtMc8iOrtUsA==
X-Received: by 2002:a63:2d46:: with SMTP id t67mr25963069pgt.140.1548804454720;
        Tue, 29 Jan 2019 15:27:34 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id u70sm69984837pfa.176.2019.01.29.15.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 15:27:33 -0800 (PST)
Date:   Tue, 29 Jan 2019 15:27:32 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: Re: [PATCH v3 4/4] tests: define GIT_TEST_SIDEBAND_ALL
Message-ID: <20190129232732.GB218214@google.com>
References: <cover.1547244620.git.jonathantanmy@google.com>
 <cover.1547666330.git.jonathantanmy@google.com>
 <47a98b67113869aa6a887ced52560c8306e55bc0.1547666330.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a98b67113869aa6a887ced52560c8306e55bc0.1547666330.git.jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -78,6 +78,7 @@ PassEnv GNUPGHOME
>  PassEnv ASAN_OPTIONS
>  PassEnv GIT_TRACE
>  PassEnv GIT_CONFIG_NOSYSTEM
> +PassEnv GIT_TEST_SIDEBAND_ALL

This is producing

 [env:warn] [pid 248632] AH01506: PassEnv variable GIT_TEST_SIDEBAND_ALL was undefined

when tests are run with "prove".

Should we set the envvar unconditionally in lib-httpd.sh?

Thanks,
Jonathan
